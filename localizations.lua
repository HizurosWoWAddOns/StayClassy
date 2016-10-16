
local addon, ns = ...;
local L = setmetatable({},{__index=function(t,k) local v=tostring(k); rawset(t,k,v); return v; end});
ns.L = L;

--[[
L["Achievement overview"] = "";
L["Author"] = "";
L["Candidates check list"] = "";
L["Expand completed achievements"] = "";
L["No candidates found..."] = "";
L["Notify wrong notes and/or officer notes"] = "";
L["Oops... Collecting data."] = "";
L["Race detection"] = "";
L["Scan note"] = "";
L["Scan officer note"] = "";
L["Show achievement requirements"] = "";
L["Show candidates counter"] = "";
L["Show candidates with unknown races"] = "";
L["Show completed criteria"] = "";
L["Show minimap icon"] = "";
L["This addon detecting the races of guild members through chat messages. Optionally, the races can also be recognized by reading the guild notes. For this, it is necessary to define the recognition characteristic manually."] = "";
L["Unknown races"] = "";
--]]

if LOCALE_deDE then
	L["Achievement overview"] = "Erfolgsübersicht";
	L["Author"] = "Autor";
	L["Candidates check list"] = "Kandidatencheckliste";
	L["Expand completed achievements"] = "Erweiter abgeschlossene Erfolge";
	L["No candidates found..."] = "Keine Kandidaten gefunden...";
	--L["Notify wrong notes and/or officer notes"] = "";
	L["Oops... Collecting data."] = "Oops.. Sammle noch Daten.";
	L["Race detection"] = "Rassenerkennung";
	L["Scan note"] = "Scanne Notiz";
	L["Scan officer note"] = "Scanne Offiziersnotiz";
	L["Show achievement requirements"] = "Zeige Erfolgsanforderungen";
	L["Show candidates counter"] = "Zeige Kandidatenzähler";
	L["Show candidates with unknown races"] = "Zeige Kandidaten mit unbekannte Rassen";
	L["Show completed criteria"] = "Zeige abgeschlossene Kriterien";
	L["Show minimap icon"] = "Zeige Minikartensymbol";
	L["This addon detecting the races of guild members through chat messages. Optionally, the races can also be recognized by reading the guild notes. For this, it is necessary to define the recognition characteristic manually."] = "Dieses Addon erkennt die Rassen von Gildenmitgliedern durch Chat-Nachrichten. Optional kann die Rassen auch durch lesen der Gildennotizen erkannt werden. Dazu ist es erforderlich, das Erkennungsmerkmal manuell zu definieren.";
	L["Unknown races"] = "Unbekannte Rassen";
end
