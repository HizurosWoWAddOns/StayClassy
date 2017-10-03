
StayClassyDB,StayClassyToonDB = {},{};
local addon, ns, _ = ...;
local L,version,author = ns.L,GetAddOnMetadata(addon,"Version"),GetAddOnMetadata(addon,"Author");
local faction,Faction = UnitFactionGroup("player");
local Realm = GetRealmName():gsub(" ",""):gsub("%-",""):gsub("'","");
local data,achievements = {},faction=="Alliance" and {meta=5152,5151,5153,5154,5155,5156,5157,6624} or {meta=5158,5160,5161,5162,5164,5163,5165,6625};
local achievementRaces = faction=="Alliance" and {"HUMAN","NIGHTELF","GNOME","DWARF","DRAENEI","WORGEN","PANDAREN"} or {"ORC","TAUREN","TROLL","UNDEAD","BLOODELF","GOBLIN","PANDAREN"};
local _, aName, aPoints, aCompleted, aMonth, aDay, aYear, aDescription, aFlags, aIcon, aRewardText, aIsGuild, aWasEarnedByMe, aEarnedBy = 1,2,3,4,5,6,7,8,9,10,11,12,13,14; -- GetAchievementInfo
local cString, cType, cCompleted, cQuantity, cReqQuantity, cCharName, cFlags, cAssetID, cQuantityString = 1,2,3,4,5,6,7,8,9; -- GetAchievementCriteriaInfo
local classEN = setmetatable({},{__index=function(t,k) local v; for K,V in pairs(LOCALIZED_CLASS_NAMES_MALE)do if k==V then v=K; break; end end rawset(t,k,v); return v; end});
local excluded,me,guildMembersLast = {},UnitName("player").."-"..Realm,0;
local check = "|TInterface\\Buttons\\UI-CheckBox-Check:14:14:0:0:32:32:5:27:5:27|t";
local spacer = "|TInterface\\Common\\SPACER:14:14:0:0:8:8:0:8:0:8|t";
local icons = "|T%s:14:14:0:0:32:32:2:30:2:30|t";
local LR = LibStub("LibRaces-1.0");
local LDB,LDBObject,LDBIcon
local members = {};

function ns.print(...)
	local colors,t,T,c = {"0088ff","00ff00","ff0000","44ffff","ffff00","ff8800","ff00ff","ffffff"},{},{...},1;
	tinsert(T,1,ns.L[addon]..":");
	for i=1, #T do
		T[i] = tostring(T[i]);
		if T[i]:match("||c") then
			tinsert(t,T[i])
		else
			tinsert(t,"|cff"..colors[c]..T[i].."|r");
			c = c<#colors and c+1 or 1;
		end
	end
	print(unpack(t));
end

local debugMode = (version=="@".."project-version".."@");
function ns.debug(...)
	if debugMode then
		ns.print("debug",...);
	end
end


--==[ LibColors ]==--
local LC = LibStub("LibColors-1.0");
local C = LC.color;
LC.colorset({
	["sc_header"]	= "ffcc00",
	["sc_gray0"]	= "404040",
	["sc_gray1"]	= "909090",
	["sc_gray2"]	= "D0D0E0",
});

local classIndexByName = {};
for i,v in ipairs(LFG_LIST_GROUP_DATA_CLASS_ORDER)do
	classIndexByName[v]=i;
	classIndexByName[LOCALIZED_CLASS_NAMES_MALE[v]]=i;
end

local raceValues = {};
for i,v in ipairs(achievementRaces)do
	raceValues[v] = L[v];
end

local function sortClasses(a,b)
	return a[cString]<b[cString];
end

local LaS = "%03d%02d";
local function sortLevelAndStanding(a,b)
	return LaS:format(a[2],a[4])>LaS:format(b[2],b[4]);
end


--==[ guild member list ]==--
local guildMembers,guildMembersNote,raceCustomPattern,added,guildMembersLocked = {},{},{},{},false;

local function notes2race(name,note,notesource)
	local race,raceEng = LR:FindRaceNameInText(note);
	if race then
		guildMembersNote[name].found = raceEng:upper(); -- for notifyWrongNotes
		guildMembersNote[name].foundSource = notesource;
		StayClassyToonDB[name] = raceEng:upper();
	else
		local F = "_FEMALE";
		for i=1, #achievementRaces do
			local race = achievementRaces[i];
			if ((raceCustomPattern[race] and note:find(raceCustomPattern[race])) or note:find(race))
			or ((raceCustomPattern[race..F] and note:find(raceCustomPattern[race..F])) or note:find(race..F)) then
				guildMembersNote[name].found = race;  -- for notifyWrongNotes
				guildMembersNote[name].foundSource = notesource;
				StayClassyToonDB[name] = race;
				break;
			end
		end
	end
end

local function optionsRaceFunc(info,value)
	local name = info[#info];
	if value~=nil then
		StayClassyToonDB[name] = value;
	end
	return StayClassyToonDB[name];
end

local function optionsHideKnown(info)
	if StayClassyDB.hideMembersWithKnownRace and StayClassyToonDB[info[#info]]~=nil then
		return true;
	end
	return false;
end

local function updateGuildMembers()
	if not IsInGuild() then return end
	local now = time();
	if guildMembersLast>now then
		return;
	end
	-- check guild members
	local optionMembersByClass = {};
	local tmp,changed,num = {},false,GetNumGuildMembers();
	for i=1, num do
		local name,_,_,level,_,_,note,offnote,_,_,class,_,_,_,_,repStanding = GetGuildRosterInfo(i);
		if not name:find("%-") then
			name = name.."-"..Realm;
		end
		if optionMembersByClass[class]==nil then
			optionMembersByClass[class] = {num=0,numUnknown=0,entries={}};
		end
		optionMembersByClass[class].num = optionMembersByClass[class].num+1;
		if StayClassyToonDB[name]==nil then
			optionMembersByClass[class].numUnknown = optionMembersByClass[class].numUnknown+1;
		end
		optionMembersByClass[class].entries[name] = {type="select", name=name, values=raceValues, get=optionsRaceFunc, set=optionsRaceFunc, hidden=optionsHideKnown };
		note,offnote = note:trim(),offnote:trim();
		if guildMembersNote[name]==nil then
			guildMembersNote[name]={};
		end
		if StayClassyDB.raceDetectionNotes and note~="" and guildMembersNote[name].note~=note then
			guildMembersNote[name].note=note;
			notes2race(name,note,1);
		end
		if StayClassyDB.raceDetectionOfficer and offnote~="" and guildMembersNote[name].offnote~=offnote then
			guildMembersNote[name].offnote = offnote;
			notes2race(name,offnote,2);
		end
		tinsert(tmp,{name,level,class,repStanding,note,offnote});
	end
	guildMembers = tmp;
	guildMembersLast=now+5; -- +5sec
	for k,v in pairs(optionMembersByClass)do
		members[k].name = C(k,LOCALIZED_CLASS_NAMES_MALE[k]).." ("..v.numUnknown.."/"..v.num..")";
		members[k].args = v.entries;
	end
end

local function GetGuildMembersByClass(class)
	if not IsInGuild() then return {}; end
	guildMembersLocked = true;
	if #guildMembers==0 then
		updateGuildMembers();
	end
	local withRace,withoutRace = {},{};
	for i=1, #guildMembers do
		if guildMembers[i][3]==class then
			if StayClassyToonDB[guildMembers[i][1]] then
				tinsert(withRace,guildMembers[i]);
			else
				tinsert(withoutRace,guildMembers[i]);
			end
		end
	end
	guildMembersLocked = false;
	return withRace,withoutRace;
end


--==[ Tooltip ]==--
local LibQTip,panelfix,tt,tt2,tooltipOnLeaveTicker = LibStub("LibQTip-1.0"),CreateFrame("Frame",nil,UIParent);

local function panel_fix(parent)
	if parent then
		panelfix:SetFrameStrata("BACKGROUND");
		panelfix:SetPoint("TOPLEFT",parent,"TOPLEFT",0,1);
		panelfix:SetPoint("BOTTOMRIGHT",parent,"BOTTOMRIGHT",0,-1);
	else
		panelfix:ClearAllPoints();
	end
end

local function openAchievement(id)
	if type(id)=="table" then id = id.id; end
	AchievementObjectiveTracker_OpenAchievement(nil,id);
end

local function tt2AddLine(name,realm,class,level,reqLevel,reputation,reqReputation)
	tt2:AddLine(
		"   "..C(class,name)..C("sc_header",realm~=Realm and "*" or ""),
		level.." "..(level>=reqLevel and check or spacer),
		_G["FACTION_STANDING_LABEL"..reputation].." "..(reputation>=reqReputation and check or spacer)
	);
end

local function tooltip2OnEnter(self)
	tt2 = LibQTip:Acquire(addon.."2",3,"LEFT","RIGHT","RIGHT","RIGHT");
	local f = tt:GetCenter();
	local u = UIParent:GetCenter();
	if f>u then
		tt2:SetPoint("RIGHT",tt,"LEFT",0,0);
	else
		tt2:SetPoint("LEFT",tt,"RIGHT",0,0);
	end
	tt2:Clear();

	tt2:AddLine(C("sc_header",NAME),C("sc_header",LEVEL)..C("sc_gray1"," ("..self.info.reqLevel..")"),C("sc_header",REPUTATION)..C("sc_gray1"," (".._G["FACTION_STANDING_LABEL"..self.info.reqReputation]..")"));
	tt2:AddSeparator();

	if StayClassyDB.showToonUnknownRace then
		tt2:SetCell(tt2:AddLine(),1,C("sc_gray1",self.info.label),nil,"LEFT",0);
	end

	local c,a,b = 0,GetGuildMembersByClass(self.info.class);
	table.sort(a,sortLevelAndStanding);
	for i,v in pairs(a)do
		if StayClassyToonDB[v[1]]==self.info.race then
			local name,realm = strsplit("-",v[1]);
			tt2AddLine(name,realm,self.info.class,v[2],self.info.reqLevel,v[4],self.info.reqReputation);
			c=c+1;
		end
	end

	if c==0 then
		tt2:SetCell(tt2:AddLine(),1,C("sc_gray1",L["NoCandidates"]),nil,"CENTER",0);
	end

	if StayClassyDB.showToonUnknownRace and #b>0 then
		tt2:SetCell(tt2:AddLine(),1,C("sc_gray1",L["UnknownRaces"]),nil,"LEFT",0);
		table.sort(b,sortLevelAndStanding);
		for i,v in pairs(b)do
			local name,realm = strsplit("-",v[1]);
			tt2AddLine(name,realm,self.info.class,v[2],self.info.reqLevel,v[4],self.info.reqReputation);
			c=c+1;
		end
	end

	-- Tiptac Support for LibQTip Tooltips
	if tt2 and _G.TipTac and _G.TipTac.AddModifiedTip then
		-- Pass true as second parameter because hooking OnHide causes C stack overflows
		_G.TipTac:AddModifiedTip(tt2, true);
	end
	tt2:Show();
end

local function tooltip2OnLeave(self)
	LibQTip:Release(tt2);
	tt2 = nil;
end

local tooltipOnLeave;
function tooltipOnLeave()
	if not (type(tt)=="table" and type(tt.parent)=="table" and type(panelfix)=="table") then return end
	if not MouseIsOver(tt.parent) and not MouseIsOver(panelfix) then
		if tt and not MouseIsOver(tt) then
			LibQTip:Release(tt);
			panel_fix(false);
			tooltipOnLeaveTicker:Cancel();
			tt=nil;
		end
	end
end

local function tooltipOnEnter(self)
	local columns = 3;
	tt = LibQTip:Acquire(addon,columns,"LEFT","CENTER","CENTER","RIGHT","RIGHT","RIGHT");

	tt:Hide();
	tt:Clear();
	if not data[achievements.meta] then
		tt:SetCell(tt:AddLine(),1,C("sc_header",addon),"LEFT",0);
		tt:AddSeparator(4,0,0,0,0);
		tt:SetCell(tt:AddLine(),1,C("sc_gray2",L["CollectData"]),nil,"CENTER",0);
	else
		local stayClassyLocale = "";
		if not (LOCALE_enUS or LOCALE_enGB) then
			-- adds localized name of achievement behind the addon name for non english user
			stayClassyLocale = " - "..C(data[achievements.meta][aCompleted] and "green" or "mage",data[achievements.meta][aName]);
		end
		local l = tt:SetCell(tt:AddLine(),1,C("sc_header",addon)..stayClassyLocale,tt:GetHeaderFont(),"LEFT",0);

		if not IsInGuild() then
			tt:AddSeparator(4,0,0,0,0);
			tt:SetCell(tt:AddLine(),1,C("sc_gray2",ERR_GUILD_PLAYER_NOT_IN_GUILD),nil,"CENTER",0);
		else
			tt.lines[l].id = achievements.meta;
			tt:SetLineScript(l,"OnMouseUp",openAchievement);
			for i=1, #achievements do
				tt:AddSeparator(4,0,0,0,0);
				local requirements,flag,l = "","",tt:AddLine();
				if data[achievements[i]][aCompleted] then
					flag = " "..check;
				end
				if StayClassyDB.showRequirements and not data[achievements[i]][aCompleted] then
					requirements = " "
								 ..C("sc_gray1","("..LEVEL..": ")
								 ..C("sc_gray2",data[achievements[i]].criteria[1][cReqQuantity])
								 ..C("sc_gray1",", "..REPUTATION..": ")
								 ..C("sc_gray2",FACTION_STANDING_LABEL6)
								 ..C("sc_gray1",")");
				end
				tt:SetCell(l,1,icons:format(data[achievements[i]][aIcon]).." "..C("sc_header",data[achievements[i]][aName])..flag..requirements,nil,"LEFT",0);
				tt.lines[l].id = achievements[i];
				tt:SetLineScript(l,"OnMouseUp",openAchievement);
				if not data[achievements[i]][aCompleted] or StayClassyDB.expandCompleted then
					tt:AddSeparator();
					local c,l=columns+1;
					table.sort(data[achievements[i]].criteria,sortClasses);
					for I,v in pairs(data[achievements[i]].criteria) do
						if not v[cCompleted] or StayClassyDB.showCompletedCriteria or (StayClassyDB.expandCompleted and data[achievements[i]][aCompleted]) then
							if c>columns then c,l=1,tt:AddLine(); end
							local class = classEN[v[cString]]
							local flag = v[cCompleted] and check or spacer;
							local candidates = "";
							if StayClassyDB.showCandidates then
								local c,a = 0,GetGuildMembersByClass(class);
								for _,v in pairs(a)do
									if StayClassyToonDB[v[1]]==achievementRaces[i] then
										c=c+1;
									end
								end
								candidates = " "..C(c>0 and "sc_gray2" or "sc_gray0",c);
							end
							tt:SetCell(l,c,flag.." "..C(class,v[cString])..candidates,nil,"LEFT");
							tt.lines[l].cells[c].info = {race=achievementRaces[i],class=class,reqLevel=data[achievements[i]].criteria[1][cReqQuantity],reqReputation=6,label=data[achievements[i]][aName]};
							tt:SetCellScript(l,c,"OnEnter",tooltip2OnEnter);
							tt:SetCellScript(l,c,"OnLeave",tooltip2OnLeave);
							c=c+1;
						end
					end
				end
			end
		end
	end
	panel_fix(self);
	tt:SmartAnchorTo(self);
	tt.parent = self;
	tt:SetScript("OnLeave",tooltipOnLeave);
	tooltipOnLeaveTicker = C_Timer.NewTicker(0.8,tooltipOnLeave);
	-- Tiptac Support for LibQTip Tooltips
	if tt and _G.TipTac and _G.TipTac.AddModifiedTip then
		-- Pass true as second parameter because hooking OnHide causes C stack overflows
		_G.TipTac:AddModifiedTip(tt, true);
	end
	tt:Show();
end


--==[ LibDataBroker & Minimap icon ]==--
local function RegisterDataBroker()
	LDB = LibStub("LibDataBroker-1.1");
	LDBIcon = LibStub("LibDBIcon-1.0");
	LDBObject = LibStub("LibDataBroker-1.1"):NewDataObject(addon,{
		type    = "data source",
		icon	= "Interface\\Icons\\Achievement_general_stayclassy",
		label	= addon,
		text	= addon,
		OnEnter = tooltipOnEnter,
		OnLeave = tooltipOnLeave,
		OnClick = function(_, button)
			if (button=="LeftButton") then
				openAchievement(achievements.meta);
			else
				local Lib = LibStub("AceConfigDialog-3.0");
				if Lib.OpenFrames[addon]~=nil then
					Lib:Close(addon);
				else
					Lib:Open(addon);
					Lib.OpenFrames[addon]:SetStatusText(("%s: %s, %s: %s"):format(GAME_VERSION_LABEL,version,L["Author"],author));
				end
			end
		end
	});
	LDBIcon:Register(addon, LDBObject, StayClassyDB.minimap);
end


--==[ Option panel ]==--
local function raceOptionFunc(info,value)
	local key = info[#info];
	if value~=nil then
		StayClassyDB[key] = value;
		updateGuildMembers();
	end
	return StayClassyDB[key];
end

local function raceOption(order,rType,faction)
	local key = "raceDetection"..rType..(faction~=nil and faction or "");
	return {
		type="group", order=order, inline=true, name="",
		args={
			[key.."_Label"] = {type="description",name=C("dkyellow",L[rType]),width="normal", fontSize="medium", order=0},
			[key] = {type="input", order=1, name=MALE},
			[key.."_FEMALE"] = {type="input", order=2, name=FEMALE}
		}
	};
end

local function optionsFunc(info,value)
	local key = info[#info];
	if key == "minimap" then
		if value~=nil then
			StayClassyDB.minimap.hide = not value;
			LDBIcon:Refresh(addon);
		end
		return not StayClassyDB.minimap.hide;
	else
		if value~=nil then
			StayClassyDB[key] = value;
		end
		return StayClassyDB[key];
	end
end

local options = {
	type = "group",
	name = addon,
	childGroups = "tab",
	get = optionsFunc,
	set = optionsFunc,
	args = {
		loadedMsg = {
			type = "toggle", width = "double", order = 1,
			name = L["OptLoadedMsg"], desc = nil -- L["OptLoadedMsgDesc"]
		},
		minimap = {
			type = "toggle", width = "double", order = 2,
			name = L["OptMinimap"], desc = nil -- L["OptMinimapDesc"]
		},
		section1 = {
			type = "group", order = 2,
			name = L["OptTabTT"],
			args = {
				overview = {
					type = "group", order = 1, inline = true,
					name = L["OptHeadAOV"],
					args = {
						expandCompleted = {
							type = "toggle", width = "full", order = 1,
							name = L["OptExpand"], desc = nil -- L["OptExpandDesc"],
						},
						showCompletedCriteria = {
							type = "toggle", width = "full", order = 2,
							name = L["OptShowCompleted"], desc = nil -- L["OptShowCompletedDesc"],
						},
						showRequirements = {
							type = "toggle", width = "full", order = 3,
							name = L["OptRequire"], desc = nil -- L["OptRequireDesc"],
						},
						showCandidates = {
							type = "toggle", width = "full", order = 4,
							name = L["OptShowCount"], desc = nil -- L["OptShowCountDesc"],
						}
					}
				},
				checklist = {
					type = "group", order = 2, inline = true,
					name = L["OptHeadCCL"],
					args = {
						showToonUnknownRace = {
							type = "toggle", width = "full", order = 1,
							name = L["OptShowUnknown"], desc = nil --  L["OptShowUnknownDesc"],
						}
					}
				}
			}
		},
		section3 = {
			type = "group", order = 4,
			name = L["OptTabRT"],
			childGroups = "tab",
			args = {
				desc = {
					type = "description", order = 0, fontSize = "medium",
					name = L["OptRTDesc"]
				},
				raceDetectionNotes = {
					type = "toggle", order = 1,
					name = L["OptScanNote"], desc = nil -- L["OptScanNoteDesc"]
				},
				raceDetectionOfficer = {
					type = "toggle", order = 2,
					name = L["OptScanOffNote"], desc = nil -- L["OptScanOffNoteDesc"]
				},
				notifyWrongNotes = {
					type = "toggle", order = 3,
					name = L["OptNotifyWrong"], desc = L["OptNotidyWrongDesc"]
				},
				races_alliance = {
					type = "group", order = 4,
					name = FACTION_ALLIANCE,
					childGroups = "tab",
					get=raceOptionFunc,
					set=raceOptionFunc,
					args = {
						HUMAN    = raceOption(1,"HUMAN"),
						NIGHTELF = raceOption(2,"NIGHTELF"),
						GNOME    = raceOption(3,"GNOME"),
						DWARF    = raceOption(4,"DWARF"),
						DRAENEI  = raceOption(5,"DRAENEI"),
						WORGEN   = raceOption(6,"WORGEN"),
						PANDAREN = raceOption(7,"PANDAREN",1),
					},
					hidden = faction~="Alliance"
				},
				races_horde = {
					type = "group", order = 4,
					name = FACTION_HORDE,
					childGroups = "tab",
					get=raceOptionFunc,
					set=raceOptionFunc,
					args = {
						ORC      = raceOption(1,"ORC"),
						TAUREN   = raceOption(2,"TAUREN"),
						TROLL    = raceOption(3,"TROLL"),
						UNDEAD   = raceOption(4,"UNDEAD"),
						BLOODELF = raceOption(5,"BLOODELF"),
						GOBLIN   = raceOption(6,"GOBLIN"),
						PANDAREN = raceOption(7,"PANDAREN",2),
					},
					hidden = faction~="Horde"
				},
				notifications = {
					type = "group", order = 5,
					name = L["OptTabNotifications"],
					args = {
						no_data = {
							type = "description", order = 1,
							name = L["OptNoNotifications"]
						}
					}
				}
			}
		},
		section4 = {
			type = "group", order = 5,
			name = L["OptTabMRT"],
			childGroups = "tree",
			args = {
				hideMembersWithKnownRace = {
					type = "toggle", order = 0, width = "full",
					name = L["OptHideKnown"]
				}
			}
		}
	}
};

-- generate classes lists
for i,v in ipairs(CLASS_SORT_ORDER)do
	local label = C(v,LOCALIZED_CLASS_NAMES_MALE[v]);
	options.args.section4.args[v] = { type="group", order=i+1, name=label, args={} };
	members[v] = options.args.section4.args[v];
end

local notifiedNames = {};
local function addNotification(name)
	if notifiedNames[name]~=nil then return end
	notifiedNames[name] = true;
	local msg = L["OptNotifyMsg"]:format(
		L[StayClassyToonDB[name]],
		guildMembersNote[name].foundSource==1 and LABEL_NOTE or OFFICER_NOTE_COLON,
		L[guildMembersNote[name].found]
	);
	options.args.section3.args.notifications.args.no_data.hidden=true;
	options.args.section3.args.notifications.args['notification'..name] = {
		type = "group", order = 2,
		guiInline = true,
		name = name,
		args = {
			message = {
				type = "description",
				name = msg
			}
		}
	}
	if StayClassyDB.notifyWrongNotes then
		ns.print(name,"\n",msg);
	end
end

local function RegisterOptionPanel()
	LibStub("AceConfig-3.0"):RegisterOptionsTable(addon, options);
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions(addon);
end


--==[ Data update and events ]==--
local ticker,doUpdate = nil,true;

local function readAchievements()
	data[achievements.meta] = {GetAchievementInfo(achievements.meta)};
	for i=1, #achievements do
		data[achievements[i]] = {GetAchievementInfo(achievements[i])};
		data[achievements[i]].criteria = {};
		for criteriaIndex=1, GetAchievementNumCriteria(achievements[i]) or 0 do
			tinsert(data[achievements[i]].criteria,{GetAchievementCriteriaInfo(achievements[i], criteriaIndex)});
		end
	end
	if data[achievements.meta][aCompleted] and LDB then
		LDB.text = C("green",addon);
	end
	doUpdate=false;
end

local function updateAchievements(self,event)
	if self and event then
		doUpdate = true;
	elseif doUpdate and IsInGuild() then
		-- focus achievements > force update criteria...
		if not (AchievementFrame and AchievementFrame:IsShown()) then
			for i=1, #achievements do
				SetFocusedAchievement(achievements[i]);
			end
		end
		C_Timer.After(2,readAchievements);
	end
end

local function GetRaceByChatMsgGUID(self,event,...)
	if not IsInGuild() then return end
	if achievements.meta and data[achievements.meta] and data[achievements.meta][aCompleted] then return end
	local _,_,_,_,_,_,_,_,_,_,_,guid = ...;
	if tostring(guid):find("^Player%-%d+%-") then
		local className,classId,raceName,race,gender,toon = GetPlayerInfoByGUID(guid);
		if not toon:find("%-") then toon = toon.."-"..Realm; end
		if IsGuildMember(toon) then
			race = race:upper();
			if race=="SCOURGE" then race = "UNDEAD" end
			StayClassyToonDB[toon] = race;
			if guildMembersNote[toon] and guildMembersNote[toon].found~=StayClassyToonDB[toon] then
				addNotification(toon);
			end
		end
	elseif debug and not excluded[event] then
		if toon~="-"..Realm then
			excluded[event] = true;
		end
		debug(event,"(no guid)");
	end
end

local frame,events = CreateFrame("frame"),{
	ADDON_LOADED = function(self,event,addonName)
		if addon==addonName then
			if StayClassyDB==nil then
				StayClassyDB = {};
			end
			if StayClassyToonDB==nil then
				StayClassyToonDB = {};
			end
			for i,v in pairs({
				minimap = {hide=false},
				loadedMsg = true,
				--toonrace = {},
				expandCompleted = false,
				showCompletedCriteria = false,
				showRequirements = true,
				showCandidates = true,
				showToonUnknownRace = false,
				raceDetectionNotes = false,
				raceDetectionOfficer = false,
				notifyWrongNotes = false,
				hideMembersWithKnownRace = true
			})do
				if StayClassyDB[i]==nil then
					StayClassyDB[i] = v;
				end
			end
			-- little internal migration
			if not StayClassyDB.migrateUNDEAD then
				for k,v in pairs(StayClassyToonDB)do
					if v=="SCOURGE" then
						StayClassyToonDB[k] = "UNDEAD";
					end
				end
				if StayClassyDB.raceDetectionSCOURGE~=nil then
					StayClassyDB.raceDetectionUNDEAD=StayClassyDB.raceDetectionSCOURGE;
					StayClassyDB.raceDetectionSCOURGE=nil;
				end
				if StayClassyDB.raceDetectionSCOURGE_FEMALE~=nil then
					StayClassyDB.raceDetectionUNDEAD_FEMALE=StayClassyDB.raceDetectionSCOURGE_FEMALE;
					StayClassyDB.raceDetectionSCOURGE_FEMALE=nil;
				end
				StayClassyDB.migrateUNDEAD=true;
			end
			--
			RegisterDataBroker();
			RegisterOptionPanel();
			--
			for i=1, #achievementRaces do
				local key = "raceDetection"..achievementRaces[i];
				local keyF = key.."_FEMALE";
				if achievementRaces[i]=="PANDAREN" then
					key = key .. (faction=="Alliance" and 1 or 2);
					keyF = keyF .. (faction=="Alliance" and 1 or 2);
				end
				if tostring(StayClassyDB[key]):trim()~="" then
					raceCustomPattern[achievementRaces[i]]=StayClassyDB[key];
				end
				if tostring(StayClassyDB[keyF]):trim()~="" then
					raceCustomPattern[achievementRaces[i].."_FEMALE"]=StayClassyDB[keyF];
				end
			end
			--
			if StayClassyDB.loadedMsg then
				ns.print(L.AddOnLoaded);
			end
			self:UnregisterEvent(event);
		end
	end,
	-- track achievement
	PLAYER_ENTERING_WORLD = function(self,event,...)
		if IsInGuild() then
			local _,race = UnitRace("player");
			StayClassyToonDB[me] = race:upper();
		end
		ticker = C_Timer.NewTicker(5,updateAchievements);
		self:UnregisterEvent(event);
	end,
	-- detect faction changes
	NEUTRAL_FACTION_SELECT_RESULT = function(self,event,...)
		faction,Faction = UnitFactionGroup("player");
	end,
	ACHIEVEMENT_EARNED = updateAchievements,
	CRITERIA_UPDATE = updateAchievements,
	PLAYER_GUILD_UPDATE = updateAchievements,
	-- guild roster
	GUILD_ROSTER_UPDATE = function(self,event,...)
		updateGuildMembers();
	end,
	-- detect guild member races
	CHAT_MSG_ACHIEVEMENT = GetRaceByChatMsgGUID,
	CHAT_MSG_AFK = GetRaceByChatMsgGUID,
	CHAT_MSG_CHANNEL_JOIN = GetRaceByChatMsgGUID,
	CHAT_MSG_CHANNEL_LEAVE = GetRaceByChatMsgGUID,
	CHAT_MSG_DND = GetRaceByChatMsgGUID,
	CHAT_MSG_EMOTE = GetRaceByChatMsgGUID,
	CHAT_MSG_GUILD = GetRaceByChatMsgGUID,
	CHAT_MSG_GUILD_ACHIEVEMENT = GetRaceByChatMsgGUID,
	CHAT_MSG_GUILD_ITEM_LOOTED = GetRaceByChatMsgGUID,
	CHAT_MSG_INSTANCE_CHAT = GetRaceByChatMsgGUID,
	CHAT_MSG_INSTANCE_CHAT_LEADER = GetRaceByChatMsgGUID,
	CHAT_MSG_OFFICER = GetRaceByChatMsgGUID,
	CHAT_MSG_PARTY = GetRaceByChatMsgGUID,
	CHAT_MSG_PARTY_LEADER = GetRaceByChatMsgGUID,
	CHAT_MSG_RAID = GetRaceByChatMsgGUID,
	CHAT_MSG_RAID_LEADER = GetRaceByChatMsgGUID,
	CHAT_MSG_RAID_WARNING = GetRaceByChatMsgGUID,
	CHAT_MSG_SAY = GetRaceByChatMsgGUID,
	CHAT_MSG_TEXT_EMOTE = GetRaceByChatMsgGUID,
	CHAT_MSG_WHISPER = GetRaceByChatMsgGUID,
	CHAT_MSG_YELL = GetRaceByChatMsgGUID
};

frame:SetScript("OnEvent",function(self,event,...) if events[event] then events[event](self,event,...); end end);
for i,v in pairs(events)do frame:RegisterEvent(i); end

