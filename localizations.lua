
local addon, ns = ...;
local L = setmetatable({},{__index=function(t,k) local v=tostring(k); rawset(t,k,v); return v; end});
ns.L = L;

-- Hi. This addon needs your help for localization. :)
-- https://wow.curseforge.com/projects/stayclassy/localization

-- english localization

--@do-not-package@

L["AddOnLoaded"] = "AddOn loaded..."
L["Author"] = "Author"
L["CollectData"] = "Oops... Collecting data."
L["Days"] = "Days";
L["Hours"] = "Hours";
L["Months"] = "Months";
L["NoCandidates"] = "No candidates found..."
L["OptExpand"] = "Expand completed achievements"
L["OptExpandDesc"] = "Display completed achievements in tooltip"
L["OptHeadAOV"] = "Achievement overview"
L["OptHeadCCL"] = "Candidates check list"
L["OptInact"] = "Inactive members"
L["OptInactDesc"] = "With the following options you can set an offline time limit or select a rank for inactive members. All members of this rank or offline limit will be ignored in cadidates counter from main tooltip and list separate in sub tooltip."
L["OptInactHide"] = "Hide inactive"
L["OptInactRank"] = "Inactive by rank"
L["OptInactRankDesc"] = "Select a rank to exclude inactive member."
L["OptInactTimeNum"] = "Offline time limit"
L["OptInactTimeType"] = "Inactive by offline time limit"
L["OptLoadedMsgDesc"] = "Display 'AddOn loaded...' message in chat window on startup";
L["OptMinimap"] = "Minimap button"
L["OptMinimapDesc"] = "Display own button for this addon on minimap"
L["OptRequire"] = "Show achievement requirements"
L["OptRequireDesc"] = "Display required level and guild reputation for individual archievements."
L["OptShowCompleted"] = "Completed criteria"
L["OptShowCompletedDesc"] = "Display completed criteria for individual achievements."
L["OptShowCount"] = "Candidates counter"
L["OptShowCountDesc"] = "Display the number of guild members with known race behind the criteria that can complete it."
L["OptShowUnknown"] = "Candidates without detected races"
L["OptShowUnknownDesc"] = "Display guild members without detected race in candidates tooltip";
L["OptTabTT"] = "Tooltip options"
L["UnknownRaces"] = "Unknown races";
L["Years"] = "Years";
--@end-do-not-package@
--@localization(locale="enUS", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
-- /end english localization

if LOCALE_deDE then
--@do-not-package@
L["AddOnLoaded"] = "AddOn geladen..."
L["Author"] = "Autor"
L["CollectData"] = "Oops.. Sammle noch Daten."
L["Days"] = "Tage"
L["Hours"] = "Stunden"
L["Months"] = "Monate"
L["NoCandidates"] = "Keine Kandidaten gefunden..."
L["OptExpand"] = "Erweiter abgeschlossene Erfolge"
L["OptExpandDesc"] = "Zeige abgeschloßene Erfolge im Tooltip"
L["OptHeadAOV"] = "Erfolgsübersicht"
L["OptHeadCCL"] = "Kandidatencheckliste"
L["OptInact"] = "Inaktive Mitglieder"
L["OptInactDesc"] = "Mit den folgenden Optionen kannst du ein Zeitlimit für Offlinezeit setzen oder einen Rang für inaktive Mitglieder auswählen. Alle Mitglieder dieses Ranges oder Offline Limits werden ignoriert im Kandidatenzähler vom Haupttooltip und separat im Untertooltip aufgelistet."
L["OptInactHide"] = "Verstecke Inaktive"
L["OptInactRank"] = "Inaktiv durch Rang"
L["OptInactRankDesc"] = "Wähle einen Rang um inaktive Mitglieder auszuschließen"
L["OptInactTimeNum"] = "Offline Zeitlimit"
L["OptInactTimeType"] = "Inaktiv durch Offline Zeitlimit"
L["OptLoadedMsgDesc"] = "Zeige die 'AddOn geladen...' Nachricht im Chatfenster an Anfang"
L["OptMinimap"] = "Minikartensymbol"
L["OptMinimapDesc"] = "Zeige einen eigenen Knopf für dieses AddOn an der Minikarte an"
L["OptRequire"] = "Zeige Erfolgsanforderungen"
L["OptRequireDesc"] = "Zeige erforderliche Stufe und Gildenruf für einzelne Erfolge"
L["OptShowCompleted"] = "Abgeschlossene Kriterien"
L["OptShowCompletedDesc"] = "Zeige vervollständigte Kriterien für einzelne Erfolge."
L["OptShowCount"] = "Kandidatenzähler"
L["OptShowCountDesc"] = "Zeige die Anzahl Gildenmitglieder mit bekannter Rasse hinter dem Kriterium, die es vervollständigen können."
L["OptShowUnknown"] = "Kandidaten ohne erkannte Rasse"
L["OptShowUnknownDesc"] = "Zeige Gildenmitglieder ohne erkannte Rasse im Kandidaten-Tooltip"
L["OptTabTT"] = "Tooltip Optionen"
L["UnknownRaces"] = "Unbekannte Rassen"
L["Years"] = "Jahre"

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
L.HUMAN = "Human"
L.ORC = "Orc"
L.DWARF = "Dwarf"
L.NIGHTELF = "Night Elf"
L.UNDEAD = "Undead"
L.TAUREN = "Tauren"
L.GNOME = "Gnome"
L.TROLL = "Troll"
L.GOBLIN = "Goblin"
L.BLOODELF = "Blood Elf"
L.DRAENEI = "Draenei"
L.WORGEN = "Worgen"
L.PANDAREN = "Pandaren"

if LOCALE_deDE then
	L.HUMAN = "Mensch"
	L.ORC = "Orc"
	L.DWARF = "Zwerg"
	L.NIGHTELF = "Nachtelf"
	L.UNDEAD = "Untoter"
	L.TAUREN = "Tauren"
	L.GNOME = "Gnom"
	L.TROLL = "Troll"
	L.GOBLIN = "Goblin"
	L.BLOODELF = "Blutelf"
	L.DRAENEI = "Draenei"
	L.WORGEN = "Worgen"
	L.PANDAREN = "Pandaren"
end

if LOCALE_esES then
	L.HUMAN = "Humano"
	L.ORC = "Orco"
	L.DWARF = "Enano"
	L.NIGHTELF = "Elfo de la noche"
	L.UNDEAD = "No-muerto"
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
	L.UNDEAD = "No-muerto"
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
	L.UNDEAD = "Mort-vivant"
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
	L.UNDEAD = "Non Morto"
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
	L.UNDEAD = "언데드"
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
	L.UNDEAD = "Morto-vivo"
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
	L.UNDEAD = "Нежить"
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
	L.UNDEAD = "亡灵"
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
	L.UNDEAD = "不死族"
	L.TAUREN = "牛頭人"
	L.GNOME = "地精"
	L.TROLL = "食人妖"
	L.GOBLIN = "哥布林"
	L.BLOODELF = "血精靈"
	L.DRAENEI = "德萊尼"
	L.WORGEN = "狼人"
	L.PANDAREN = "熊貓人"
end


