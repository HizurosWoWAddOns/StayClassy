
StayClassyDB = {};
local addon, ns = ...;
local faction,Faction = UnitFactionGroup("player");
local data,achievements = {},faction=="Alliance" and {meta=5152,5151,5153,5154,5155,5156,5157,6624} or {meta=5158,5160,5161,5162,5163,5164,5165,6625};
local _, aName, aPoints, aCompleted, aMonth, aDay, aYear, aDescription, aFlags, aIcon, aRewardText, aIsGuild, aWasEarnedByMe, aEarnedBy = 1,2,3,4,5,6,7,8,9,10,11,12,13,14; -- GetAchievementInfo
local cString, cType, cCompleted, cQuantity, cReqQuantity, cCharName, cFlags, cAssetID, cQuantityString = 1,2,3,4,5,6,7,8,9; -- GetAchievementCriteriaInfo
local classEN = setmetatable({},{__index=function(t,k) local v; for K,V in pairs(LOCALIZED_CLASS_NAMES_MALE)do if k==V then v=K; break; end end rawset(t,k,v); return v; end});
local L = setmetatable({},{__index=function(t,k) local v=tostring(k); rawset(t,k,v); return v; end});
local check = "|TInterface\\Buttons\\UI-CheckBox-Check:14:14:0:0:32:32:5:27:5:27|t";
--local cross = "|TInterface\\Common\\VOICECHAT-MUTED:14:14:0:0:32:32:0:32:0:32|t";
local spacer = "|TInterface\\Common\\SPACER:14:14:0:0:8:8:0:8:0:8|t";
local icons = "|T%s:14:14:0:0:32:32:2:30:2:30|t";

--==[ LibColors ]==--
local LC = LibStub("LibColors-1.0");
local C = LC.color;
LC.colorset({
	["sc_header"]	= "ffcc00",
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

--==[ Tooltip ]==--
local LibQTip,panelfix,tt = LibStub("LibQTip-1.0"),CreateFrame("Frame",nil,UIParent);

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

local function tooltip2OnEnter(self)
	--print(self.aid,self.cid);
end

local function tooltip2OnLeave(self)
	--
end

local tooltipOnLeave;
function tooltipOnLeave(self)
	if not MouseIsOver(self) and not MouseIsOver(panelfix) then
		if MouseIsOver(tt) then
		else
			LibQTip:Release(tt);
			panel_fix(false);
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
		local l = tt:SetCell(tt:AddLine(),1,C("sc_header",addon).." - "..C(data[achievements.meta][aCompleted] and "green" or "mage",data[achievements.meta][aName]),tt:GetHeaderFont(),"LEFT",0);

		if not IsInGuild() then
			tt:AddSeparator(4,0,0,0,0);
			tt:SetCell(tt:AddLine(),1,C("sc_gray2",L["You are not in a guild."]),nil,"CENTER",0);
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
					for cid,v in pairs(data[achievements[i]].criteria) do
						if not v[cCompleted] or StayClassyDB.showCompletedCriteria or (StayClassyDB.expandCompleted and data[achievements[i]][aCompleted]) then
							if c>columns then c,l=1,tt:AddLine(); end
							local color = C(classEN[v[cString]]);
							local flag = v[cCompleted] and check or spacer;
							tt:SetCell(l,c,flag.." "..C(color,v[cString]),nil,"LEFT");
							--if not v[cCompleted] then
							--	tt.lines[l].cells[c].aid = achievements[i];
							--	tt.lines[l].cells[c].cid = cid;
							--	tt:SetCellScript(l,c,"OnEnter",tooltip2OnEnter);
							--	tt:SetCellScript(l,c,"OnLeave",tooltip2OnLeave);
							--end
							c=c+1;
						end
					end
				end
			end
		end
	end
	panel_fix(self);
	tt:SmartAnchorTo(self);
	tt:SetScript("OnLeave",tooltipOnLeave);
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
				Lib.OpenFrames[addon]:SetStatusText(GAME_VERSION_LABEL..": "..GetAddOnMetadata(addon,"Version"));
			end
		end
	end
});
local LDBIcon = LDB and LibStub("LibDBIcon-1.0", true) or false;

--==[ Option panel ]==--
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
		showCompleted = {
			type = "toggle", width = "full", order = 2,
			name = L["Expand completed achievements"],
			get = function() return StayClassyDB.expandCompleted; end,
			set = function(_,v) StayClassyDB.expandCompleted = v; end
		},
		showCompletedCriteria = {
			type = "toggle", width = "full", order = 3,
			name = L["Show completed criteria"],
			get = function() return StayClassyDB.showCompletedCriteria; end,
			set = function(_,v) StayClassyDB.showCompletedCriteria = v; end
		},
		showRequirements = {
			type = "toggle", width = "full", order = 4,
			name = L["Show achievement requirements"],
			get = function() return StayClassyDB.showRequirements; end,
			set = function(_,v) StayClassyDB.showRequirements = v; end
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

local frame,events = CreateFrame("frame"),{
	ADDON_LOADED = function(self,event,addonName)
		if addon==addonName then
			if StayClassyDB==nil then
				StayClassyDB = {};
			end
			for i,v in pairs({
				minimap = {hide=false},
				expandCompleted = false,
				showCompletedCriteria = false,
				showRequirements = true
			})do
				if StayClassyDB[i]==nil then
					StayClassyDB[i] = v;
				end
			end
			if LDBIcon then
				LDBIcon:Register(addon, LDB, StayClassyDB.minimap);
			end
			RegisterOptionPanel();
		end
	end,
	PLAYER_ENTERING_WORLD = function(self,event,...)
		ticker = C_Timer.NewTicker(5,updateAchievements);
		self:UnregisterEvent(event);
	end,
	ACHIEVEMENT_EARNED = updateAchievements,
	CRITERIA_UPDATE = updateAchievements,
	PLAYER_GUILD_UPDATE = updateAchievements,
};

frame:SetScript("OnEvent",function(self,event,...) if events[event] then events[event](self,event,...); end end);
for i,v in pairs(events)do frame:RegisterEvent(i); end
