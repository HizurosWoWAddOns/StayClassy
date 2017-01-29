
local addon, ns = ...;
local L = setmetatable({},{__index=function(t,k) local v=tostring(k); rawset(t,k,v); return v; end});
ns.L = L;

--[[
L["Achievement overview"] = "";
L["Author"] = "";
L["Candidates check list"] = "";
L["Currently there are no notifications collected..."] = "";
L["Different races found: Over chat message = %s, in guild member %s = %s."] = "";
L["Expand completed achievements"] = "";
L["No candidates found..."] = "";
L["Notifications"] = "";
L["Notify wrong notes and/or officer notes"] = "";
L["Oops... Collecting data."] = "";
L["Print notification about wrong notes and/or officer notes in chat frame"] = "";
L["Race detection"] = "";
L["Scan note"] = "";
L["Scan officer note"] = "";
L["Show achievement requirements"] = "";
L["Show candidates counter"] = "";
L["Show candidates with unknown races"] = "";
L["Show completed criteria"] = "";
L["Show minimap icon"] = "";
L["This addon detecting the races of guild members through chat messages. Optionally, the races can also be recognized by reading the guild notes. For this, it is necessary to define the recognition characteristic manually."] = "";
L["Tooltip options"] = "";
L["Unknown races"] = "";
--]]

if LOCALE_deDE then
	L["Achievement overview"] = "Erfolgsübersicht";
	L["Author"] = "Autor";
	L["Candidates check list"] = "Kandidatencheckliste";
	L["Currently there are no notifications collected..."] = "Zur Zeit keine Benachrichtigungen gesammelt...";
	L["Different races found: Over chat message = %s, in guild member %s = %s."] = "Unterschiedliche Rassen gefunden: Über Chatnachricht = %s, in Gildenmitglied %s = %s";
	L["Expand completed achievements"] = "Erweiter abgeschlossene Erfolge";
	L["No candidates found..."] = "Keine Kandidaten gefunden...";
	L["Notifications"] = "Benachrichtigungen";
	L["Notify wrong notes and/or officer notes"] = "Melde falsche Notizen und/oder Offiziersnotizen";
	L["Oops... Collecting data."] = "Oops.. Sammle noch Daten.";
	L["Print notification about wrong notes and/or officer notes in chat frame"] = "Zeige Benachrichtigungen über falsche Notizen und/oder Offiziersnotizen im Chatfenster";
	L["Race detection"] = "Rassenerkennung";
	L["Scan note"] = "Scanne Notiz";
	L["Scan officer note"] = "Scanne Offiziersnotiz";
	L["Show achievement requirements"] = "Zeige Erfolgsanforderungen";
	L["Show candidates counter"] = "Zeige Kandidatenzähler";
	L["Show candidates with unknown races"] = "Zeige Kandidaten mit unbekannte Rassen";
	L["Show completed criteria"] = "Zeige abgeschlossene Kriterien";
	L["Show minimap icon"] = "Zeige Minikartensymbol";
	L["This addon detecting the races of guild members through chat messages. Optionally, the races can also be recognized by reading the guild notes. For this, it is necessary to define the recognition characteristic manually."] = "Dieses Addon erkennt die Rassen von Gildenmitgliedern durch Chat-Nachrichten. Optional kann die Rassen auch durch lesen der Gildennotizen erkannt werden. Dazu ist es erforderlich, das Erkennungsmerkmal manuell zu definieren.";
	L["Tooltip options"] = "Tooltip Optionen";
	L["Unknown races"] = "Unbekannte Rassen";
end

-- races
if LOCALE_deDE then
	L.HUMAN = "Mensch"
	L.ORC = "Orc"
	L.DWARF = "Zwerg"
	L.NIGHTELF = "Nachtelf"
	L.SCOURGE = "Untoter"
	L.TAUREN = "Tauren"
	L.GNOME = "Gnom"
	L.TROLL = "Troll"
	L.GOBLIN = "Goblin"
	L.BLOODELF = "Blutelf"
	L.DRAENEI = "Draenei"
	L.WORGEN = "Worgen"
	L.PANDAREN = "Pandaren"
end

if LOCALE_enUS then
	L.HUMAN = "Human"
	L.ORC = "Orc"
	L.DWARF = "Dwarf"
	L.NIGHTELF = "Night Elf"
	L.SCOURGE = "Undead"
	L.TAUREN = "Tauren"
	L.GNOME = "Gnome"
	L.TROLL = "Troll"
	L.GOBLIN = "Goblin"
	L.BLOODELF = "Blood Elf"
	L.DRAENEI = "Draenei"
	L.WORGEN = "Worgen"
	L.PANDAREN = "Pandaren"
end

if LOCALE_esES then
	L.HUMAN = "Humano"
	L.ORC = "Orco"
	L.DWARF = "Enano"
	L.NIGHTELF = "Elfo de la noche"
	L.SCOURGE = "No-muerto"
	L.TAUREN = "Tauren"
	L.GNOME = "Gnomo"
	L.TROLL = "Trol"
	L.GOBLIN = "Goblin"
	L.BLOODELF = "Elfo de sangre"
	L.DRAENEI = "Draenei"
	L.WORGEN = "Huargen"
	L.PANDAREN = "Pandaren"
end

if LOCALE_esMX then
	L.HUMAN = "Humano"
	L.ORC = "Orco"
	L.DWARF = "Enano"
	L.NIGHTELF = "Elfo de la noche"
	L.SCOURGE = "No-muerto"
	L.TAUREN = "Tauren"
	L.GNOME = "Gnomo"
	L.TROLL = "Trol"
	L.GOBLIN = "Goblin"
	L.BLOODELF = "Elfo de sangre"
	L.DRAENEI = "Draenei"
	L.WORGEN = "Huargen"
	L.PANDAREN = "Pandaren"
end

if LOCALE_frFR then
	L.HUMAN = "Humain"
	L.ORC = "Orc"
	L.DWARF = "Nain"
	L.NIGHTELF = "Elfe de la nuit"
	L.SCOURGE = "Mort-vivant"
	L.TAUREN = "Tauren"
	L.GNOME = "Gnome"
	L.TROLL = "Troll"
	L.GOBLIN = "Gobelin"
	L.BLOODELF = "Elfe de sang"
	L.DRAENEI = "Draeneï"
	L.WORGEN = "Worgen"
	L.PANDAREN = "Pandaren"
end

if LOCALE_itIT then
	L.HUMAN = "Umano"
	L.ORC = "Orco"
	L.DWARF = "Nano"
	L.NIGHTELF = "Elfo della Notte"
	L.SCOURGE = "Non Morto"
	L.TAUREN = "Tauren"
	L.GNOME = "Gnomo"
	L.TROLL = "Troll"
	L.GOBLIN = "Goblin"
	L.BLOODELF = "Elfo del Sangue"
	L.DRAENEI = "Draenei"
	L.WORGEN = "Worgen"
	L.PANDAREN = "Pandaren"
end

if LOCALE_koKR then
	L.HUMAN = "인간"
	L.ORC = "오크"
	L.DWARF = "드워프"
	L.NIGHTELF = "나이트 엘프"
	L.SCOURGE = "언데드"
	L.TAUREN = "타우렌"
	L.GNOME = "노움"
	L.TROLL = "트롤"
	L.GOBLIN = "고블린"
	L.BLOODELF = "블러드 엘프"
	L.DRAENEI = "드레나이"
	L.WORGEN = "늑대인간"
	L.PANDAREN = "판다렌"
end

if LOCALE_ptBR then
	L.HUMAN = "Humano"
	L.ORC = "Orc"
	L.DWARF = "Anão"
	L.NIGHTELF = "Elfo Noturno"
	L.SCOURGE = "Morto-vivo"
	L.TAUREN = "Tauren"
	L.GNOME = "Gnomo"
	L.TROLL = "Troll"
	L.GOBLIN = "Goblin"
	L.BLOODELF = "Elfo Sangrento"
	L.DRAENEI = "Draenei"
	L.WORGEN = "Worgen"
	L.PANDAREN = "Pandaren"
end

if LOCALE_ruRU then
	L.HUMAN = "Человек"
	L.ORC = "Орк"
	L.DWARF = "Дворф"
	L.NIGHTELF = "Ночной эльф"
	L.SCOURGE = "Нежить"
	L.TAUREN = "Таурен"
	L.GNOME = "Гном"
	L.TROLL = "Тролль"
	L.GOBLIN = "Гоблин"
	L.BLOODELF = "Эльф крови"
	L.DRAENEI = "Дреней"
	L.WORGEN = "Ворген"
	L.PANDAREN = "Пандарен"
end

if LOCALE_zhCN then
	L.HUMAN = "人类"
	L.ORC = "兽人"
	L.DWARF = "矮人"
	L.NIGHTELF = "暗夜精灵"
	L.SCOURGE = "亡灵"
	L.TAUREN = "牛头人"
	L.GNOME = "侏儒"
	L.TROLL = "巨魔"
	L.GOBLIN = "地精"
	L.BLOODELF = "血精灵"
	L.DRAENEI = "德莱尼"
	L.WORGEN = "狼人"
	L.PANDAREN = "熊猫人"
end

if LOCALE_zhTW then
	L.HUMAN = "人類"
	L.ORC = "獸人"
	L.DWARF = "矮人"
	L.NIGHTELF = "夜精靈"
	L.SCOURGE = "不死族"
	L.TAUREN = "牛頭人"
	L.GNOME = "地精"
	L.TROLL = "食人妖"
	L.GOBLIN = "哥布林"
	L.BLOODELF = "血精靈"
	L.DRAENEI = "德萊尼"
	L.WORGEN = "狼人"
	L.PANDAREN = "熊貓人"
end


