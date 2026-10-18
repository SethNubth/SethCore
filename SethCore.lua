-- SethCore V1.1 Safe Universal - by SethNubth - Angel Edition
-- 100% Lua - No DLL - No Ban - DXVK Ready - For All PCs
-- Boot automatico en: Dalaran, Raids ICC/SR/TOC/VoA/Ulduar, BGs

local ADDON="SethCore"
local LOCALE=GetLocale()
local L={}

if LOCALE=="ptBR" or LOCALE=="ptPT" then
  L.LOADED="V1.1 Safe carregado! /sethcore - DXVK Ready - 100% Lua"
  L.LOW_ON="Boost ON em: %s - FPS aumentado - Gama Baixa/Media/Alta"
  L.HIGH_ON="Graficos restaurados"
  L.GC="GC: %d MB"
else
  if LOCALE=="esES" or LOCALE=="esMX" then
    L.LOADED="V1.1 Safe cargado! /sethcore - DXVK Ready - 100% Lua"
    L.LOW_ON="Boost ON en: %s - FPS aumentado - Gama Baja/Media/Alta"
    L.HIGH_ON="Graficos restaurados"
    L.GC="GC: %d MB"
  else
    L.LOADED="V1.1 Safe loaded! /sethcore - DXVK Ready - 100% Lua"
    L.LOW_ON="Boost ON in: %s - FPS boosted - Low/Mid/High End"
    L.HIGH_ON="Graphics restored"
    L.GC="GC: %d MB"
  end
end

local heavyZones={
  ["Dalaran"]=true, ["Ciudad de Dalaran"]=true,
  ["Icecrown Citadel"]=true, ["Ciudadela de la Corona de Hielo"]=true, ["Cidadela da Coroa de Gelo"]=true,
  ["The Ruby Sanctum"]=true, ["El Sagrario Rubi"]=true, ["Santuario Rubi"]=true, ["SR"]=true,
  ["Trial of the Crusader"]=true, ["Prueba del Cruzado"]=true, ["TOC"]=true,
  ["Vault of Archavon"]=true, ["Camara de Archavon"]=true, ["VoA"]=true,
  ["Ulduar"]=true, ["Wintergrasp"]=true, ["Conquista del Invierno"]=true,
}

local f=CreateFrame("Frame")
local saved={}
local function Print(m) DEFAULT_CHAT_FRAME:AddMessage("|cffffd700[SethCore]|r "..m) end

local function EnableLow(zone)
  if saved.applied then return end
  saved.shadow=GetCVar("shadowLevel")
  saved.density=GetCVar("groundEffectDensity")
  SetCVar("shadowLevel","0")
  SetCVar("groundEffectDensity","16")
  saved.applied=true
  Print(string.format(L.LOW_ON, zone))
end

local function DisableLow()
  if not saved.applied then return end
  if saved.shadow then SetCVar("shadowLevel",saved.shadow) end
  if saved.density then SetCVar("groundEffectDensity",saved.density) end
  saved.applied=false
  Print(L.HIGH_ON)
end

f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("ZONE_CHANGED_NEW_AREA")
f:SetScript("OnEvent", function(_,e,a)
  if e=="ADDON_LOADED" and a==ADDON then
    SethCoreDB=SethCoreDB or {}
    Print(L.LOADED)
  elseif e=="PLAYER_ENTERING_WORLD" or e=="ZONE_CHANGED_NEW_AREA" then
    local z=GetRealZoneText()
    if heavyZones[z] then EnableLow(z) else DisableLow() end
    collectgarbage("collect")
  end
end)

SLASH_SETHCORE1="/sethcore"
SLASH_SETHCORE2="/sc"
SlashCmdList["SETHCORE"]=function(msg)
  msg=string.lower(msg or "")
  if msg=="low" then EnableLow("Manual")
  elseif msg=="high" then DisableLow()
  elseif msg=="gc" then collectgarbage("collect") Print(string.format(L.GC, math.floor(gcinfo()/1024)))
  else Print("Comandos: /sethcore low / high / gc - DXVK Ready - ICC/SR/TOC/VoA/Ulduar/Dalaran/BGs")
  end
end
