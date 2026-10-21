-- SethCore V1.2 FUSION FULL - by SethNubth - Angel Edition - GOD V6.2
-- Integrado en SethBUDDYLK - 100% Lua - No DLL - No Ban - DXVK Ready
SethCoreDB=SethCoreDB or {}
if SethCoreDB.disabled then return end

local LOCALE=GetLocale()
local L={}
if LOCALE=="ptBR" or LOCALE=="ptPT" then
  L.LOW_ON="Boost ON em: %s - FPS aumentado"
  L.HIGH_ON="Graficos restaurados"
  L.GC="GC: %d MB"
  L.DISABLED="Anti-Lag DESACTIVADO - /sethcore enable"
  L.ENABLED="Anti-Lag ACTIVADO"
elseif LOCALE=="esES" or LOCALE=="esMX" then
  L.LOW_ON="Boost ON en: %s - FPS aumentado"
  L.HIGH_ON="Graficos restaurados"
  L.GC="GC: %d MB"
  L.DISABLED="Anti-Lag DESACTIVADO - /sethcore enable"
  L.ENABLED="Anti-Lag ACTIVADO"
else
  L.LOW_ON="Boost ON in: %s - FPS boosted"
  L.HIGH_ON="Graphics restored"
  L.GC="GC: %d MB"
  L.DISABLED="Anti-Lag DISABLED - /sethcore enable"
  L.ENABLED="Anti-Lag ENABLED"
end

local heavyZones={
  ["Dalaran"]=true, ["Ciudad de Dalaran"]=true,
  ["Icecrown Citadel"]=true, ["Ciudadela de la Corona de Hielo"]=true, ["Cidadela da Coroa de Gelo"]=true,
  ["The Ruby Sanctum"]=true, ["El Sagrario Rubi"]=true, ["Santuario Rubi"]=true,
  ["Trial of the Crusader"]=true, ["Prueba del Cruzado"]=true,
  ["Vault of Archavon"]=true, ["Camara de Archavon"]=true,
  ["Ulduar"]=true, ["Wintergrasp"]=true, ["Conquista del Invierno"]=true,
}
local saved={}
local function SC_Print(m) DEFAULT_CHAT_FRAME:AddMessage("|cffffd700[SethCore]|r "..m) end
local function SC_EnableLow(zone)
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
  SC_Print(string.format(L.LOW_ON, zone))
end
local function SC_DisableLow()
  if not saved.applied then return end
  if saved.shadow then SetCVar("shadowLevel",saved.shadow) end
  if saved.density then SetCVar("groundEffectDensity",saved.density) end
  if saved.farclip then SetCVar("farclip",saved.farclip) end
  if saved.particle then SetCVar("particleDensity",saved.particle) end
  saved.applied=false
  SC_Print(L.HIGH_ON)
end

SethCoreAPI={
  EnableLow=SC_EnableLow,
  DisableLow=SC_DisableLow,
  IsActive=function() return saved.applied end,
  heavyZones=heavyZones,
  Version="V1.2 FUSION FULL",
}

local scFrame=CreateFrame("Frame")
scFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
scFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
scFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
scFrame:SetScript("OnEvent", function(_,e)
  if SethCoreDB.disabled then return end
  if e=="PLAYER_ENTERING_WORLD" or e=="ZONE_CHANGED_NEW_AREA" then
    local z=GetRealZoneText() or ""
    if heavyZones[z] then SC_EnableLow(z) else SC_DisableLow() end
    collectgarbage("collect")
  elseif e=="PLAYER_REGEN_DISABLED" then
    if heavyZones[GetRealZoneText() or ""] then SC_EnableLow(GetRealZoneText().." [Combat]") end
  end
end)

SLASH_SETHCORE1="/sethcore"
SLASH_SETHCORE2="/sc"
SlashCmdList["SETHCORE"]=function(msg)
  msg=string.lower(msg or "")
  if msg=="low" then SethCoreDB.disabled=nil SC_EnableLow("Manual")
  elseif msg=="high" then SC_DisableLow()
  elseif msg=="disable" then SethCoreDB.disabled=true SC_DisableLow() SC_Print(L.DISABLED)
  elseif msg=="enable" then SethCoreDB.disabled=nil SC_Print(L.ENABLED)
  elseif msg=="gc" then collectgarbage("collect") SC_Print(string.format(L.GC, math.floor(gcinfo()/1024)))
  elseif msg=="status" then
    if SethCoreDB.disabled then SC_Print("Status: DISABLED")
    elseif saved.applied then SC_Print("Status: Boost ON")
    else SC_Print("Status: Boost OFF") end
  else SC_Print("Comandos: /sethcore low / high / enable / disable / gc / status - V1.2 FULL")
  end
end

DEFAULT_CHAT_FRAME:AddMessage("|cffffd700[SethBUDDYLK]|r SethCore V1.2 FUSION FULL cargado - /sc low/high/disable")
