
local addon, ns = ...;
local L = setmetatable({},{__index=function(t,k) local v=tostring(k); rawset(t,k,v); return v; end});
ns.L = L;

-- Do you want to help localize this addon?
-- https://www.curseforge.com/wow/addons/@cf-project-name@/localization

--@localization(locale="enUS", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@

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
elseif LOCALE_ptBR or LOCALE_ptPT then
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
	L.DRAENEI = "Draene??"
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
	L.HUMAN = "??????"
	L.ORC = "??????"
	L.DWARF = "?????????"
	L.NIGHTELF = "????????? ??????"
	L.UNDEAD = "?????????"
	L.TAUREN = "?????????"
	L.GNOME = "??????"
	L.TROLL = "??????"
	L.GOBLIN = "?????????"
	L.BLOODELF = "????????? ??????"
	L.DRAENEI = "????????????"
	L.WORGEN = "????????????"
	L.PANDAREN = "?????????"
end

if LOCALE_ptBR or LOCALE_ptPT then
	L.HUMAN = "Humano"
	L.ORC = "Orc"
	L.DWARF = "An??o"
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
	L.HUMAN = "??????????????"
	L.ORC = "??????"
	L.DWARF = "??????????"
	L.NIGHTELF = "???????????? ????????"
	L.UNDEAD = "????????????"
	L.TAUREN = "????????????"
	L.GNOME = "????????"
	L.TROLL = "????????????"
	L.GOBLIN = "????????????"
	L.BLOODELF = "???????? ??????????"
	L.DRAENEI = "????????????"
	L.WORGEN = "????????????"
	L.PANDAREN = "????????????????"
end

if LOCALE_zhCN then
	L.HUMAN = "??????"
	L.ORC = "??????"
	L.DWARF = "??????"
	L.NIGHTELF = "????????????"
	L.UNDEAD = "??????"
	L.TAUREN = "?????????"
	L.GNOME = "??????"
	L.TROLL = "??????"
	L.GOBLIN = "??????"
	L.BLOODELF = "?????????"
	L.DRAENEI = "?????????"
	L.WORGEN = "??????"
	L.PANDAREN = "?????????"
end

if LOCALE_zhTW then
	L.HUMAN = "??????"
	L.ORC = "??????"
	L.DWARF = "??????"
	L.NIGHTELF = "?????????"
	L.UNDEAD = "?????????"
	L.TAUREN = "?????????"
	L.GNOME = "??????"
	L.TROLL = "?????????"
	L.GOBLIN = "?????????"
	L.BLOODELF = "?????????"
	L.DRAENEI = "?????????"
	L.WORGEN = "??????"
	L.PANDAREN = "?????????"
end


