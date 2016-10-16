
StayClassyDB,StayClassyToonDB = {},{};
local addon, ns, _ = ...;
local L,version,author = ns.L,GetAddOnMetadata(addon,"Version"),GetAddOnMetadata(addon,"Author");
local faction,Faction = UnitFactionGroup("player");
local Realm = GetRealmName():gsub(" ","");
local data,achievements = {},faction=="Alliance" and {meta=5152,5151,5153,5154,5155,5156,5157,6624} or {meta=5158,5160,5161,5162,5164,5163,5165,6625};
local achievementRaces = faction=="Alliance" and {"HUMAN","NIGHTELF","GNOME","DWARF","DRAENEI","WORGEN","PANDAREN"} or {"ORC","TAUREN","TROLL","SCOURGE","BLOODELF","GOBLIN","PANDAREN"};
local _, aName, aPoints, aCompleted, aMonth, aDay, aYear, aDescription, aFlags, aIcon, aRewardText, aIsGuild, aWasEarnedByMe, aEarnedBy = 1,2,3,4,5,6,7,8,9,10,11,12,13,14; -- GetAchievementInfo
local cString, cType, cCompleted, cQuantity, cReqQuantity, cCharName, cFlags, cAssetID, cQuantityString = 1,2,3,4,5,6,7,8,9; -- GetAchievementCriteriaInfo
local classEN = setmetatable({},{__index=function(t,k) local v; for K,V in pairs(LOCALIZED_CLASS_NAMES_MALE)do if k==V then v=K; break; end end rawset(t,k,v); return v; end});
local excluded,debug = {},false;
local check = "|TInterface\\Buttons\\UI-CheckBox-Check:14:14:0:0:32:32:5:27:5:27|t";
local spacer = "|TInterface\\Common\\SPACER:14:14:0:0:8:8:0:8:0:8|t";
local icons = "|T%s:14:14:0:0:32:32:2:30:2:30|t";

local function print(...)
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
	_G.print(unpack(t));
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

local function sortClasses(a,b)
	return a[cString]<b[cString];
end

local LaS = "%03d%02d";
local function sortLevelAndStanding(a,b)
	return LaS:format(a[2],a[4])>LaS:format(b[2],b[4]);
end

if version=="@project-version@" then
	function debug(event)
		print(event,"(no guid)");
	end
end

--==[ guild member list ]==--
local guildMembers,guildMembersByName,guildMembersNote,raceCustomPattern,guildMembersLocked = {},{},{},{},false;

local function notes2race(name,note,notesource)
	for i=1, #achievementRaces do
		if (raceCustomPattern[achievementRaces[i]] and note:find(raceCustomPattern[achievementRaces[i]])) or note:find(achievementRaces[i]) then
			guildMembersNote[name] = {i,notesource}; -- for notifyWrongNotes
			--if StayClassyToonDB[name]==nil and StayClassyToonDB[name]~=achievementRaces[i] then
				StayClassyToonDB[name] = achievementRaces[i];
			--end
			break;
		end
	end
end

local function updateGuildMembers()
	if not IsInGuild() or #guildMembers>0 then return end
	for i=1, #achievementRaces do
		local key = "raceDetection"..achievementRaces[i];
		if achievementRaces[i]=="PANDAREN" then
			key = key .. (faction=="Alliance" and 1 or 2);
		end
		if tostring(StayClassyDB[key]):trim()~="" then
			raceCustomPattern[achievementRaces[i]]=StayClassyDB[key];
		end
	end
	local num = GetNumGuildMembers();
	for i=1, num do
		local name,_,_,level,_,_,note,offnote,_,_,class,_,_,_,_,repStanding = GetGuildRosterInfo(i);
		if not name:find("%-") then
			name = name.."-"..Realm;
		end
		tinsert(guildMembers,{name,level,class,repStanding,note,offnote});
		guildMembersByName[name] = #guildMembers;
		if StayClassyDB.raceDetectionNotes and note:trim()~="" then
			notes2race(name,note,1);
		end
		if StayClassyDB.raceDetectionOfficer and offnote:trim()~="" then
			notes2race(name,offnote,2);
		end
	end
end

local function GetGuildMembersByClass(class)
	if not IsInGuild() then return {}; end
	guildMembersLocked = true;
	updateGuildMembers();
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

local function ToonIsInMyGuild(name)
	if not IsInGuild() then return false; end
	guildMembersLocked = true;
	updateGuildMembers();
	local bool = not not guildMembersByName[name];
	guildMembersLocked = false;
	return bool;
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
		tt2:SetCell(tt2:AddLine(),1,C("sc_gray1",L["No candidates found..."]),nil,"CENTER",0);
	end

	if StayClassyDB.showToonUnknownRace and #b>0 then
		tt2:SetCell(tt2:AddLine(),1,C("sc_gray1",L["Unknown races"]),nil,"LEFT",0);
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
		tt:SetCell(tt:AddLine(),1,C("sc_gray2",L["Oops... Collecting data."]),nil,"CENTER",0);
	else
		local stayClassyLocale = "";
		if not (LOCALE_enUS or LOCALE_enGB) then
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
local LDB = LibStub("LibDataBroker-1.1"):NewDataObject(addon,{
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
local LDBIcon = LDB and LibStub("LibDBIcon-1.0", true) or false;


--==[ Option panel ]==--
local function raceOption(order,rType,faction)
	local key = "raceDetection"..rType..(faction~=nil and faction or "");
	return {
		type = "input", order = order,
		name = rType,
		get = function() return StayClassyDB[key]; end,
		set = function(_,v)
			StayClassyDB[key] = v;
			wipe(guildMembers);
			wipe(guildMembersByName);
			wipe(guildMembersNote);
			wipe(raceCustomPattern);
		end
	};
end

local options = {
	type = "group",
	name = addon,
	args = {
		minimap = {
			type = "toggle", width = "full", order = 1,
			name = L["Show minimap icon"],
			get = function() return not StayClassyDB.minimap.hide; end,
			set = function(_,v)
				StayClassyDB.minimap.hide = not v;
				if LDBIcon then
					if v then
						LDBIcon:Show(addon);
					else
						LDBIcon:Hide(addon);
					end
				end
			end
		},
		section1 = {
			type = "group", order = 2,
			name = L["Tooltip options"],
			args = {
				overview = {
					type = "group", order = 1, guiInline = true,
					name = L["Achievement overview"],
					args = {
						showCompleted = {
							type = "toggle", width = "full", order = 1,
							name = L["Expand completed achievements"],
							get = function() return StayClassyDB.expandCompleted; end,
							set = function(_,v) StayClassyDB.expandCompleted = v; end
						},
						showCompletedCriteria = {
							type = "toggle", width = "full", order = 2,
							name = L["Show completed criteria"],
							get = function() return StayClassyDB.showCompletedCriteria; end,
							set = function(_,v) StayClassyDB.showCompletedCriteria = v; end
						},
						showRequirements = {
							type = "toggle", width = "full", order = 3,
							name = L["Show achievement requirements"],
							get = function() return StayClassyDB.showRequirements; end,
							set = function(_,v) StayClassyDB.showRequirements = v; end
						},
						showCandidates = {
							type = "toggle", width = "full", order = 4,
							name = L["Show candidates counter"],
							get = function() return StayClassyDB.showCandidates; end,
							set = function(_,v) StayClassyDB.showCandidates = v; end
						}
					}
				},
				checklist = {
					type = "group", order = 2, guiInline = true,
					name = L["Candidates check list"],
					args = {
						showToonUnknownRace = {
							type = "toggle", width = "full", order = 1,
							name = L["Show candidates with unknown races"],
							get = function() return StayClassyDB.showToonUnknownRace; end,
							set = function(_,v) StayClassyDB.showToonUnknownRace = v; end
						}
					}
				}
			}
		},
		section3 = {
			type = "group", order = 4,
			name = L["Race detection"],
			childGroups = "tab",
			args = {
				desc = {
					type = "description", order = 0,
					name = L["This addon detecting the races of guild members through chat messages. Optionally, the races can also be recognized by reading the guild notes. For this, it is necessary to define the recognition characteristic manually."]
				},
				notes = {
					type = "toggle", width = "full", order = 1,
					name = L["Scan note"],
					get = function() return StayClassyDB.raceDetectionNotes; end,
					set = function(_,v) StayClassyDB.raceDetectionNotes = v; end
				},
				officer = {
					type = "toggle", width = "full", order = 2,
					name = L["Scan officer note"],
					get = function() return StayClassyDB.raceDetectionOfficer; end,
					set = function(_,v) StayClassyDB.raceDetectionOfficer = v; end
				},
				notifyWrongNotes = {
					type = "toggle", width = "full", order = 3,
					name = L["Notify wrong notes and/or officer notes"],
					desc = L["Print notification about wrong notes and/or officer notes in chat frame"],
					get = function() return StayClassyDB.notifyWrongNotes; end,
					set = function(_,v) StayClassyDB.notifyWrongNotes = v; end
				},
				races_alliance = {
					type = "group", order = 4,
					name = FACTION_ALLIANCE,
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
					args = {
						ORC      = raceOption(1,"ORC"),
						TAUREN   = raceOption(2,"TAUREN"),
						TROLL    = raceOption(3,"TROLL"),
						SCOURGE  = raceOption(4,"SCOURGE"),
						BLOODELF = raceOption(5,"BLOODELF"),
						GOBLIN   = raceOption(6,"GOBLIN"),
						PANDAREN = raceOption(7,"PANDAREN",2),
					},
					hidden = faction~="Horde"
				},
				notifications = {
					type = "group", order = 5,
					name = L["Notifications"],
					args = {
						--info = { type = "description", order = 0, name = "" },
						no_data = {
							type = "description", order = 1,
							name = L["Currently there are no notifications collected..."]
						}
					}
				}
			}
		}
	}
};

local notifiedNames = {};
local function addNotification(name)
	if notifiedNames[name]~=nil then return end
	notifiedNames[name] = true;
	local msg = L["Different races found: Over chat message = %s, in guild member %s = %s."]:format(
		StayClassyToonDB[name],
		guildMembersNote[name][2]==1 and LABEL_NOTE or OFFICER_NOTE_COLON,
		achievementRaces[guildMembersNote[name][1]]
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
		print(name,"\n",msg);
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
	local _,toon,_,_,_,_,_,_,_,_,_,guid = ...;
	if not toon:find("%-") then toon = toon.."-"..Realm; end
	if tostring(guid):find("^Player%-%d+%-") then
		if ToonIsInMyGuild(toon) then
			local _, _, _, race = GetPlayerInfoByGUID(guid);
			StayClassyToonDB[toon] = race:upper();
			if guildMembersNote[toon] and achievementRaces[guildMembersNote[toon][1]]~=StayClassyToonDB[toon] then
				addNotification(toon);
			end
		end
	elseif debug and not excluded[event] then
		excluded[event] = true;
		debug(event);
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
				--toonrace = {},
				expandCompleted = false,
				showCompletedCriteria = false,
				showRequirements = true,
				showCandidates = true,
				showToonUnknownRace = false,
				raceDetectionNotes = false,
				raceDetectionOfficer = false,
				notifyWrongNotes = false
			})do
				if StayClassyDB[i]==nil then
					StayClassyDB[i] = v;
				end
			end
			if LDBIcon then
				LDBIcon:Register(addon, LDB, StayClassyDB.minimap);
			end
			RegisterOptionPanel();
			self:UnregisterEvent(event);
		end
	end,
	-- track achievement
	PLAYER_ENTERING_WORLD = function(self,event,...)
		if IsInGuild() then
			local _,race = UnitRace("player");
			StayClassyToonDB[UnitName("player").."-"..Realm] = race:upper();
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
		local num = GetNumGuildMembers();
		if guildMembersLocked or #guildMembers==num then return end
		wipe(guildMembers);
		wipe(guildMembersByName);
		wipe(guildMembersNote);
		wipe(raceCustomPattern);
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
	CHAT_MSG_LOOT = GetRaceByChatMsgGUID,
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

