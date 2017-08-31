
local addon, ns = ...;
local L = setmetatable({},{__index=function(t,k) local v=tostring(k); rawset(t,k,v); return v; end});
ns.L = L;

-- Hi. This addon needs your help for localization. :)
-- https://wow.curseforge.com/projects/stayclassy/localization

if LOCALE_deDE then
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


