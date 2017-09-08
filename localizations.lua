
local addon, ns = ...;
local L = setmetatable({},{__index=function(t,k) local v=tostring(k); rawset(t,k,v); return v; end});
ns.L = L;

-- Hi. This addon needs your help for localization. :)
-- https://wow.curseforge.com/projects/stayclassy/localization

-- english localization

--@do-not-package@
L["OptMinimap"] = "Show minimap icon"
L["OptTabTT"] = "Tooltip options"
L["OptHeadAOV"] = "Achievement overview"
L["OptExpand"] = "Expand completed achievements"
L["OptShowCompleted"] = "Show completed criteria"
L["OptRequire"] = "Show achievement requirements"
L["OptShowCount"] = "Show candidates counter"
L["OptHeadCCL"] = "Candidates check list"
L["OptShowUnknown"] = "Show candidates with unknown races"

L["OptTabRT"] = "Race detection"
L["OptRTDesc"] = "This addon can detecting the races of guild members through chat messages. Optionally, the races can also be recognized by reading the guild notes. For this, it is necessary to define the recognition characteristic manually."
L["OptScanNote"] = "Scan note"
L["OptScanOffNote"] = "Scan officer note"
L["OptNotifyWrong"] = "Notify wrong notes"
L["OptNotidyWrongDesc"] = "Print notification about wrong notes and/or officer notes in chat frame"
L["OptTabNotifications"] = "Notifications"
L["OptNoNotifications"] = "Currently there are no notifications collected..."

L["OptTabMRT"] = "Manually race editing"
L["OptHideKnown"] = "Hide members with known race"
L["OptNotifyMsg"] = "Different races found: Over chat message = %s, in guild member %s = %s.";

L["UnknownRaces"] = "Unknown races";
L["NoCandidates"] = "No candidates found..."
L["CollectData"] = "Oops... Collecting data."
L["Author"] = "Author"

--[[ old localization lines
L["Candidates"] = "Candidates check list"
L["Currently there are no notifications collected..."] = "Currently there are no notifications collected..."
L["Different races found: Over chat message = %s, in guild member %s = %s."] = "Different races found: Over chat message = %s, in guild member %s = %s."
L["Expand completed achievements"] = "Expand completed achievements"
L["No candidates found..."] = "No candidates found..."
L["Notifications"] = "Notifications"
L["Notify wrong notes and/or officer notes"] = "Notify wrong notes and/or officer notes"
L["Oops... Collecting data."] = "Oops... Collecting data."
L["Print notification about wrong notes and/or officer notes in chat frame"] = "Print notification about wrong notes and/or officer notes in chat frame"
L["Race detection"] = "Race detection"
L["Scan note"] = "Scan note"
L["Scan officer note"] = "Scan officer note"
L["Show achievement requirements"] = "Show achievement requirements"
L["Show candidates counter"] = "Show candidates counter"
L["Show candidates with unknown races"] = "Show candidates with unknown races"
L["Show completed criteria"] = "Show completed criteria"
L["Show minimap icon"] = "Show minimap icon"
L["This addon detecting the races of guild members through chat messages. Optionally, the races can also be recognized by reading the guild notes. For this, it is necessary to define the recognition characteristic manually."] = "This addon detecting the races of guild members through chat messages. Optionally, the races can also be recognized by reading the guild notes. For this, it is necessary to define the recognition characteristic manually."
L["Tooltip options"] = "Tooltip options"
L["Unknown races"] = "Unknown races"
--]]
--@end-do-not-package@
--@localization(locale="enUS", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
-- /end english localization

if LOCALE_deDE then
--@do-not-package@
L["Author"] = "Autor"
L["CollectData"] = "Oops.. Sammle noch Daten."
L["NoCandidates"] = "Keine Kandidaten gefunden..."
L["OptExpand"] = "Erweiter abgeschlossene Erfolge"
L["OptHeadAOV"] = "Erfolgsübersicht"
L["OptHeadCCL"] = "Kandidatencheckliste"
L["OptHideKnown"] = "Verstecke Mitglieder mit bekannter Rasse"
L["OptMinimap"] = "Zeige Minikartensymbol"
L["OptNoNotifications"] = "Zur Zeit keine Benachrichtigungen gesammelt..."
L["OptNotidyWrongDesc"] = "Zeige Benachrichtigungen über falsche Notizen und/oder Offiziersnotizen im Chatfenster"
L["OptNotifyMsg"] = "Unterschiedliche Rassen gefunden: Über Chatnachricht = %s, in Gildenmitglied %s = %s"
L["OptNotifyWrong"] = "Melde falsche Notizen"
L["OptRequire"] = "Zeige Erfolgsanforderungen"
L["OptRTDesc"] = "Dieses Addon erkennt die Rassen von Gildenmitgliedern durch Chat-Nachrichten. Optional kann die Rassen auch durch lesen der Gildennotizen erkannt werden. Dazu ist es erforderlich, das Erkennungsmerkmal manuell zu definieren."
L["OptScanNote"] = "Scanne Notiz"
L["OptScanOffNote"] = "Scanne Offiziersnotiz"
L["OptShowCompleted"] = "Zeige abgeschlossene Kriterien"
L["OptShowCount"] = "Zeige Kandidatenzähler"
L["OptShowUnknown"] = "Zeige Kandidaten mit unbekannte Rassen"
L["OptTabMRT"] = "Rasse manuell bearbeiten"
L["OptTabNotifications"] = "Benachrichtigungen"
L["OptTabRT"] = "Rassenerkennung"
L["OptTabTT"] = "Tooltip Optionen"
L["UnknownRaces"] = "Unbekannte Rassen"
--@end-do-not-package@
--@localization(locale="deDE", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
elseif LOCALE_esES then
--@localization(locale="esES", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
elseif LOCALE_esMX then
--@localization(locale="esMX", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
elseif LOCALE_frFR then
--@localization(locale="frFR", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
elseif LOCALE_itIT then
--@localization(locale="itIT", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
elseif LOCALE_koKR then
--@localization(locale="koKR", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
elseif LOCALE_ptBR then
--@localization(locale="ptBR", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
elseif LOCALE_ruRU then
--@localization(locale="ruRU", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
elseif LOCALE_zhCN then
--@localization(locale="zhCN", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
elseif LOCALE_zhTW then
--@localization(locale="zhTW", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
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


