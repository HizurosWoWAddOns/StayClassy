
StayClassyDB,StayClassyToonDB = {},{};
local addon, ns, _ = ...;
local L,author = ns.L,"@project-author@";
local faction,Faction = UnitFactionGroup("player");
local data,achievements = {},faction=="Alliance" and {meta=5152,5151,5153,5154,5155,5156,5157,6624} or {meta=5158,5160,5161,5162,5164,5163,5165,6625};
local achievementRaces = faction=="Alliance" and {"HUMAN","NIGHTELF","GNOME","DWARF","DRAENEI","WORGEN","PANDAREN"} or {"ORC","TAUREN","TROLL","UNDEAD","BLOODELF","GOBLIN","PANDAREN"};
local _, aName, aPoints, aCompleted, aMonth, aDay, aYear, aDescription, aFlags, aIcon, aRewardText, aIsGuild, aWasEarnedByMe, aEarnedBy = 1,2,3,4,5,6,7,8,9,10,11,12,13,14; -- GetAchievementInfo
local cString, cType, cCompleted, cQuantity, cReqQuantity, cCharName, cFlags, cAssetID, cQuantityString = 1,2,3,4,5,6,7,8,9; -- GetAchievementCriteriaInfo
local classEN = setmetatable({},{__index=function(t,k) local v; for K,V in pairs(LOCALIZED_CLASS_NAMES_MALE)do if k==V then v=K; break; end end rawset(t,k,v); return v; end});
local check,spacer,icons = "|TInterface\\Buttons\\UI-CheckBox-Check:14:14:0:0:32:32:5:27:5:27|t","|TInterface\\Common\\SPACER:14:14:0:0:8:8:0:8:0:8|t","|T%s:14:14:0:0:32:32:2:30:2:30|t";
local guildMembersLast,Realm,LDB,LDBObject,LDBIcon = 0,false;

--==[ Coloured print function ]==--
do
	local addon_short = "SC";
	local colors = {"82c5ff","00ff00","ff6060","44ffff","ffff00","ff8800","ff44ff","ffffff"};
	local function colorize(...)
		local t,c,a1 = {tostringall(...)},1,...;
		if type(a1)=="boolean" then tremove(t,1); end
		if a1~=false then
			tinsert(t,1,"|cff82c5ff"..((a1==true and addon_short) or (a1=="||" and "||") or addon).."|r"..(a1~="||" and HEADER_COLON or ""));
			c=2;
		end
		for i=c, #t do
			if not t[i]:find("\124c") then
				t[i],c = "|cff"..colors[c]..t[i].."|r", c<#colors and c+1 or 1;
			end
		end
		return unpack(t);
	end
	function ns.print(...)
		print(colorize(...));
	end
	function ns.debug(...)
		ConsolePrint(date("|cff999999%X|r"),colorize(...));
	end
end

--==[ Short realm name ]==--
do
	local realm = GetRealmName();
	local pattern = "^"..(realm:gsub("(.)","[%1]*")).."$";
	for i,v in ipairs(GetAutoCompleteRealms()) do
		if v:match(pattern) then
			Realm = v;
			break;
		end
	end
	if not Realm then
		Realm = realm:gsub(" ",""):gsub("%-","");
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

local function sortClasses(a,b)
	return a[cString]<b[cString];
end

local LaS = "%03d%02d";
local function sortLevelAndStanding(a,b)
	return LaS:format(a[2],a[4])>LaS:format(b[2],b[4]);
end

local function MouseIsOver(region, topOffset, bottomOffset, leftOffset, rightOffset)
	if region and region.IsMouseOver then -- blizzards version doesn't check existance of IsMouseOver function
		return region:IsMouseOver(topOffset, bottomOffset, leftOffset, rightOffset);
	end
end



--==[ guild member list ]==--
local guildMembers,guids,guildMembersLocked,queryTicker = {},{},{},false;
local function addRace(name,race)
	race = race:upper();
	if race=="SCOURGE" then
		race = "UNDEAD";
	end
	StayClassyToonDB[name] = race;
end
local function queryRaceByGUID()
	if #guids>0 then
		local c = 0;
		for i=#guids, 1, -1 do
			local guid,name,race,_ = unpack(guids[i]);
			_,_,_,race = GetPlayerInfoByGUID(guid);
			if race then
				addRace(name,race);
				tremove(guids,i);
			end
			c = c+1;
			if c>20 then
				return; -- 20 requets per second
			end
		end
	else
		queryTicker:Cancel();
		queryTicker=nil;
	end
end

local function updateGuildMembers()
	if not IsInGuild() then return end
	local now = time();
	if guildMembersLast>now then
		return;
	end
	-- check guild members
	local tmp,changed,num = {},false,GetNumGuildMembers();
	if #guildMembers==num then return end
	for i=1, num do
		local name,rank,_,level,_,_,_,_,_,_,class,_,_,_,_,repStanding,guid = GetGuildRosterInfo(i); -- @blizzard: thanks for guid :)
		local y,m,d,h = GetGuildRosterLastOnline(i);
		y,m,d,h = y or 0, m or 0, d or 0, h or 0;
		local off,race = ((((y*12)+m)*30.5+d)*24+h);
		if not name:find("%-") then
			name = name.."-"..Realm;
		end
		if StayClassyToonDB[name] then
			race = StayClassyToonDB[name];
		elseif class=="DEMONHUNTER" then
			race = faction=="Alliance" and "NIGHTELF" or "BLOODELF";
			StayClassyToonDB[name] = race;
		elseif guid then
			_,_,_,race = GetPlayerInfoByGUID(guid);
			if race then
				addRace(name,race)
			else
				tinsert(guids,{guid,name});
			end
		end
		tinsert(tmp,{name,level,class,repStanding});
	end
	guildMembers = tmp;
	guildMembersLast=now+5; -- +5sec
	if #guids>0 and (not queryTicker) then
		queryTicker = C_Timer.NewTicker(0.5,queryRaceByGUID);
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
	OpenAchievementFrameToAchievement(type(id)=="table" and id.id or id);
end

local function tt2AddLine(name,realm,class,level,reqLevel,reputation,reqReputation)
	tt2:AddLine(
		"   "..C(class,name)..C("sc_header",realm~=Realm and "*" or ""),
		level.." "..(level>=reqLevel and check or spacer),
		_G["FACTION_STANDING_LABEL"..reputation].." "..(reputation>=reqReputation and check or spacer)
	);
end

local function tooltip2OnEnter(self, data)
	tt2 = LibQTip:Acquire(addon.."2",3,"LEFT","RIGHT","RIGHT","RIGHT");
	local f = tt:GetCenter();
	local u = UIParent:GetCenter();
	if f>u then
		tt2:SetPoint("RIGHT",tt,"LEFT",0,0);
	else
		tt2:SetPoint("LEFT",tt,"RIGHT",0,0);
	end
	tt2:Clear();

	tt2:AddLine(C("sc_header",NAME),C("sc_header",LEVEL)..C("sc_gray1"," ("..data.reqLevel..")"),C("sc_header",REPUTATION)..C("sc_gray1"," (".._G["FACTION_STANDING_LABEL"..data.reqReputation]..")"));
	tt2:AddSeparator();

	if StayClassyDB.showToonUnknownRace then
		tt2:SetCell(tt2:AddLine(),1,C("sc_gray1",data.label),nil,"LEFT",0);
	end

	local c,a,b = 0,GetGuildMembersByClass(data.class);
	table.sort(a,sortLevelAndStanding);
	for i,v in pairs(a)do
		if StayClassyToonDB[v[1]]==data.race then
			local name,realm = strsplit("-",v[1]);
			tt2AddLine(name,realm,data.class,v[2],data.reqLevel,v[4],data.reqReputation);
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
			tt2AddLine(name,realm,data.class,v[2],data.reqLevel,v[4],data.reqReputation);
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
								 ..C("sc_gray1","("..LEVEL..CHAT_HEADER_SUFFIX)
								 ..C("sc_gray2",data[achievements[i]].criteria[1][cReqQuantity])
								 ..C("sc_gray1",", "..REPUTATION..CHAT_HEADER_SUFFIX)
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
							tt:SetCellScript(l,c,"OnEnter",tooltip2OnEnter,{race=achievementRaces[i],class=class,reqLevel=data[achievements[i]].criteria[1][cReqQuantity],reqReputation=6,label=data[achievements[i]][aName]});
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
					Lib.OpenFrames[addon]:SetStatusText(("%s: %s, %s: %s"):format(GAME_VERSION_LABEL,"@project-version@",L["Author"],"@project-author@"));
				end
			end
		end
	});
	LDBIcon:Register(addon, LDBObject, StayClassyDB.minimap);
end


--==[ Option panel ]==--
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

local function getRanks()
	if not IsInGuild() then return {} end
	local lst,num = {["_none"]=ADDON_DISABLED},GuildControlGetNumRanks();
	for i=1, num do
		lst["rank"..i] = GuildControlGetRankName(i);
	end
	return lst;
end

local options = {
	type = "group",
	name = addon,
	childGroups = "tab",
	get = optionsFunc,
	set = optionsFunc,
	args = {
		loadedMsg = {
			type = "toggle", order = 1,
			name = L["AddOnLoaded"], desc = L["OptLoadedMsgDesc"]
		},
		minimap = {
			type = "toggle", order = 2,
			name = L["OptMinimap"], desc = L["OptMinimapDesc"]
		},
		header = {
			type = "header", order = 3,
			name = L["OptTabTT"]
		},
		overview = {
			type = "group", order = 4, inline = true,
			name = L["OptHeadAOV"],
			args = {
				expandCompleted = {
					type = "toggle", width = "double", order = 1,
					name = L["OptExpand"], desc = L["OptExpandDesc"]
				},
				showCompletedCriteria = {
					type = "toggle", width = "double", order = 2,
					name = L["OptShowCompleted"], desc = L["OptShowCompletedDesc"]
				},
				showRequirements = {
					type = "toggle", width = "double", order = 3,
					name = L["OptRequire"], desc = L["OptRequireDesc"]
				},
				showCandidates = {
					type = "toggle", width = "double", order = 4,
					name = L["OptShowCount"], desc = L["OptShowCountDesc"]
				},
			}
		},
		checklist = {
			type = "group", order = 5, inline = true,
			name = L["OptHeadCCL"],
			args = {
				showToonUnknownRace = {
					type = "toggle", width = "full", order = 1,
					name = L["OptShowUnknown"], desc = L["OptShowUnknownDesc"],
				},
			}
		},
		inactive = {
			type = "group", order = 6, inline = true,
			name = L["OptInact"],
			args = {
				inactiveLabel = {
					type = "description", order = 2, fontSize = "medium",
					name = L["OptInactDesc"]
				},
				inactiveTimeType = {
					type = "select", order = 3,
					name = L["OptInactTimeType"],
					values = {
						years = L["Years"],
						months = L["Months"],
						days = L["Days"],
						hours = L["Hours"],
						_none = ADDON_DISABLED
					}
				},
				inactiveTimeNum = {
					type = "range", order = 4, width = "double",
					name = L["OptInactTimeNum"],
					min = 1, max = 500, step = 1,
					disabled = function() return StayClassyDB.inactiveTimeType=="_none" end
				},
				inactiveRank = {
					type = "select", order = 5,
					name = L["OptInactRank"], desc = L["OptInactRankDesc"],
					values = getRanks
				},
				inactiveHide = {
					type = "toggle", order = 6,
					name = L["OptInactHide"],
				}
			}
		}
	}
};

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
end

local function updateAchievements()
	if doUpdate and IsInGuild() then
		doUpdate=false;
		-- focus achievements > force update criteria...
		if not (AchievementFrame and AchievementFrame:IsShown()) then
			for i=1, #achievements do
				SetFocusedAchievement(achievements[i]);
			end
		end
		C_Timer.After(1,readAchievements);
		doUpdate=false;
	end
end

local frame = CreateFrame("frame");
frame:SetScript("OnEvent",function(self,event,...)
	if event=="ADDON_LOADED" and addon==... then
		if StayClassyDB==nil then
			StayClassyDB = {};
		end
		if StayClassyToonDB==nil then
			StayClassyToonDB = {};
		end
		for i,v in pairs({
			-- defaults
			minimap = {hide=false},
			loadedMsg = true,
			expandCompleted = false,
			showCompletedCriteria = false,
			showRequirements = true,
			showCandidates = true,
			showToonUnknownRace = false,

			raceDetectionNotes = "nil", -- deprecated
			raceDetectionOfficer = "nil", -- deprecated
			notifyDetected = "nil", -- deprecated
			hideMembersWithKnownRace = "nil", -- deprecated

			inactiveRank = "_none",
			inactiveHide = false,
			inactiveTimeType = "days",
			inactiveTimeNum = 60
		})do
			if v=="nil" and StayClassyDB[i] then
				StayClassyDB[i] = nil;
			elseif StayClassyDB[i]==nil then
				StayClassyDB[i] = v;
			end
		end
		--
		RegisterDataBroker();
		RegisterOptionPanel();
		--
		if StayClassyDB.loadedMsg then
			ns.print(L.AddOnLoaded);
		end
		self:UnregisterEvent(event);
		self:RegisterEvent("PLAYER_ENTERING_WORLD");
		self:RegisterEvent("NEUTRAL_FACTION_SELECT_RESULT");
		self:RegisterEvent("ACHIEVEMENT_EARNED");
		self:RegisterEvent("CRITERIA_UPDATE");
		self:RegisterEvent("PLAYER_GUILD_UPDATE");
		self:RegisterEvent("GUILD_ROSTER_UPDATE");
	elseif event=="PLAYER_ENTERING_WORLD" then
		if not ticker then
			ticker = C_Timer.NewTicker(5,updateAchievements);
		end
		self:UnregisterEvent(event);
	elseif event=="NEUTRAL_FACTION_SELECT_RESULT" then
		faction,Faction = UnitFactionGroup("player");
	elseif event=="ACHIEVEMENT_EARNED" or event=="CRITERIA_UPDATE" or event=="PLAYER_GUILD_UPDATE" then
		doUpdate = true;
	elseif event=="GUILD_ROSTER_UPDATE" then
		updateGuildMembers();
	end
end);
frame:RegisterEvent("ADDON_LOADED");

