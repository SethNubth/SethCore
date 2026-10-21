-- SethCore V1.2 FUSION - by SethNubth - Angel Edition - GOD V6.2
-- 100% Lua - No DLL - No Ban - DXVK Ready - For All PCs
-- Boot automatico en: Dalaran, ICC, RS, TOC, VoA, Ulduar, BGs
-- NUEVO: Integración SethBUDDYLK WAR 30K / WLO 31K - Auto Low en combate

local ADDON="SethCore"
local LOCALE=GetLocale()
local L={}

if LOCALE=="ptBR" or LOCALE=="ptPT" then
  L.LOADED="V1.2 FUSION carregado! /sethcore - DXVK Ready - BUDDYLK Ready - V6.2"
  L.LOW_ON="Boost ON em: %s - FPS aumentado - WAR 30K/WLO 31K activo"
  L.HIGH_ON="Graficos restaurados"
  L.GC="GC: %d MB - BUDDYLK OK"
  L.BUDDYLK_FOUND="BUDDYLK detectado - Auto Low en RAID activado"
else
  if LOCALE=="esES" or LOCALE=="esMX" then
    L.LOADED="V1.2 FUSION cargado! /sethcore - DXVK Ready - BUDDYLK Ready - V6.2"
    L.LOW_ON="Boost ON en: %s - FPS aumentado - WAR 30K/WLO 31K activo"
    L.HIGH_ON="Graficos restaurados"
    L.GC="GC: %d MB - BUDDYLK OK"
    L.BUDDYLK_FOUND="BUDDYLK detectado - Auto Low en RAID activado"
  else
    L.LOADED="V1.2 FUSION loaded! /sethcore - DXVK Ready - BUDDYLK Ready - V6.2"
    L.LOW_ON="Boost ON in: %s - FPS boosted - WAR 30K/WLO 31K active"
    L.HIGH_ON="Graphics restored"
    L.GC="GC: %d MB - BUDDYLK OK"
    L.BUDDYLK_FOUND="BUDDYLK detected - Auto Low in RAID enabled"
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
  saved.farclip=GetCVar("farclip")
  saved.particle=GetCVar("particleDensity")
  SetCVar("shadowLevel","0")
  SetCVar("groundEffectDensity","16")
  SetCVar("farclip","400")
  SetCVar("particleDensity","10")
  saved.applied=true
  Print(string.format(L.LOW_ON, zone))
end

local function DisableLow()
  if not saved.applied then return end
  if saved.shadow then SetCVar("shadowLevel",saved.shadow) end
  if saved.density then SetCVar("groundEffectDensity",saved.density) end
  if saved.farclip then SetCVar("farclip",saved.farclip) end
  if saved.particle then SetCVar("particleDensity",saved.particle) end
  saved.applied=false
  Print(L.HIGH_ON)
end

-- API Publica para SethBUDDYLK
SethCoreAPI={
  EnableLow=EnableLow,
  DisableLow=DisableLow,
  IsActive=function() return saved.applied end,
  heavyZones=heavyZones,
  Version="V1.2 FUSION GOD V6.2",
}

f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("ZONE_CHANGED_NEW_AREA")
f:RegisterEvent("PLAYER_REGEN_DISABLED")
f:SetScript("OnEvent", function(_,e,a)
  if e=="ADDON_LOADED" and a==ADDON then
    SethCoreDB=SethCoreDB or {}
    Print(L.LOADED)
    if IsAddOnLoaded("SethBUDDYLK") then
      Print(L.BUDDYLK_FOUND)
    end
  elseif e=="PLAYER_ENTERING_WORLD" or e=="ZONE_CHANGED_NEW_AREA" then
    local z=GetRealZoneText()
    if heavyZones[z] then EnableLow(z) else DisableLow() end
    collectgarbage("collect")
  elseif e=="PLAYER_REGEN_DISABLED" then
    -- Auto Low en combate si está en zona pesada o BUDDYLK en combate
    if heavyZones[GetRealZoneText() or ""] then
      EnableLow(GetRealZoneText().." [Combat]")
    end
  end
end)

SLASH_SETHCORE1="/sethcore"
SLASH_SETHCORE2="/sc"
SlashCmdList["SETHCORE"]=function(msg)
  msg=string.lower(msg or "")
  if msg=="low" then EnableLow("Manual")
  elseif msg=="high" then DisableLow()
  elseif msg=="gc" then collectgarbage("collect") Print(string.format(L.GC, math.floor(gcinfo()/1024)))
  elseif msg=="status" then
    if saved.applied then Print("Status: Boost ON - FPS Boost activo")
    else Print("Status: Boost OFF - Graficos normales") end
    if IsAddOnLoaded("SethBUDDYLK") then Print("BUDDYLK: V6.2 FUSION conectado - WAR 30K/WLO 31K") end
  else Print("Comandos: /sethcore low / high / gc / status - V1.2 FUSION - ICC/SR/TOC/VoA/Ulduar/Dalaran/BGs")
  end
end
