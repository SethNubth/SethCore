-- SethCore - Optimized WotLK For Naerzone V1.0 Safe
-- Original Engine by Sethnubth - Angel Edition - Universal
-- 100% Lua - No DLL - No Ban - Compatible DXVK
-- For All PCs - Low/Mid/High End - ES/EN/PT-BR - enUS

local ADDON = "SethCore"
local SC = CreateFrame("Frame")
local lastGC = 0
local inCombat = false
local lowMode = false
local savedShadow = nil

-- ===== LOCALIZATION EN-US / ES / PT-BR =====
local LOCALE = GetLocale()
local L = {}

if LOCALE == "ptBR" or LOCALE == "ptPT" then
  L.LOADED = "V1.0 Safe - Angel Edition carregado! /sethcore"
  L.GC_DONE = "GC executado! Memoria: %d MB"
  L.LOW_ON = "Modo Dalaran ON - FPS boost ativado"
  L.HIGH_ON = "Graficos restaurados"
  L.INFO = "Mem: %d MB | LowMode: %s"
  L.HELP1 = "--- SethCore V1.0 Safe ---"
  L.HELP2 = "/sethcore gc - limpar Lua"
  L.HELP3 = "/sethcore low / high - forcar modo"
  L.HELP4 = "/sethcore info - ver estado"
  L.HELP5 = "Auto-GC a cada 45s + otimizacao em Dalaran/ICC"
elseif LOCALE == "esES" or LOCALE == "esMX" then
  L.LOADED = "V1.0 Safe - Angel Edition cargado! /sethcore"
  L.GC_DONE = "GC ejecutado! Memoria: %d MB"
  L.LOW_ON = "Modo Dalaran ON - FPS boost activado"
  L.HIGH_ON = "Graficos restaurados"
  L.INFO = "Mem: %d MB | LowMode: %s"
  L.HELP1 = "--- SethCore V1.0 Safe ---"
  L.HELP2 = "/sethcore gc - limpiar Lua"
  L.HELP3 = "/sethcore low / high - forzar modo"
  L.HELP4 = "/sethcore info - ver estado"
  L.HELP5 = "Auto-GC cada 45s + optimizacion en Dalaran/ICC"
else -- enUS / enGB default
  L.LOADED = "V1.0 Safe - Angel Edition loaded! /sethcore"
  L.GC_DONE = "GC done! Memory: %d MB"
  L.LOW_ON = "Dalaran Mode ON - FPS boost enabled"
  L.HIGH_ON = "Graphics restored"
  L.INFO = "Mem: %d MB | LowMode: %s"
  L.HELP1 = "--- SethCore V1.0 Safe ---"
  L.HELP2 = "/sethcore gc - clean Lua"
  L.HELP3 = "/sethcore low / high - force mode"
  L.HELP4 = "/sethcore info - show status"
  L.HELP5 = "Auto-GC every 45s + optimization in Dalaran/ICC"
end

local HEAVY_ZONES = {
  ["Dalaran"] = true,
  ["Dalaran City"] = true,
  ["Cidade de Dalaran"] = true,
  ["Icecrown Citadel"] = true,
  ["Cidadela da Coroa de Gelo"] = true,
  ["Ciudadela de la Corona de Hielo"] = true,
  ["The Ruby Sanctum"] = true,
  ["Sagrario Rubi"] = true,
  ["Santuario Rubi"] = true,
  ["Vault of Archavon"] = true,
  ["Wintergrasp"] = true,
  ["Conquista del Invierno"] = true,
  ["Crystalsong Forest"] = true,
  ["Bosque Canto de Cristal"] = true
}

local function Print(msg)
  DEFAULT_CHAT_FRAME:AddMessage("|cffffd700[SethCore]|r |cff00BFFF"..msg.."|r")
end

local function EnableLow()
  if lowMode then return end
  savedShadow = GetCVar("shadowLevel")
  SetCVar("shadowLevel", "0")
  SetCVar("groundEffectDensity", "16")
  SetCVar("groundEffectDist", "1")
  SetCVar("M2UseShaders", "0")
  lowMode = true
end

local function DisableLow()
  if not lowMode then return end
  if savedShadow then SetCVar("shadowLevel", savedShadow) end
  SetCVar("groundEffectDensity", "64")
  SetCVar("groundEffectDist", "140")
  SetCVar("M2UseShaders", "1")
  lowMode = false
end

local function SafeGC()
  if inCombat then return end
  if GetTime() - lastGC < 45 then return end
  collectgarbage("collect")
  lastGC = GetTime()
end

SC:RegisterEvent("ADDON_LOADED")
SC:RegisterEvent("PLAYER_ENTERING_WORLD")
SC:RegisterEvent("PLAYER_REGEN_DISABLED")
SC:RegisterEvent("PLAYER_REGEN_ENABLED")
SC:RegisterEvent("ZONE_CHANGED_NEW_AREA")

SC:SetScript("OnEvent", function(self, event, arg1)
  if event == "ADDON_LOADED" and arg1 == ADDON then
    if not SethCoreDB then SethCoreDB = { enabled = true } end
    Print(L.LOADED)
    lastGC = GetTime()
  elseif event == "PLAYER_ENTERING_WORLD" then
    collectgarbage("collect")
    local zone = GetRealZoneText()
    if HEAVY_ZONES[zone] then EnableLow() else DisableLow() end
  elseif event == "PLAYER_REGEN_DISABLED" then
    inCombat = true
  elseif event == "PLAYER_REGEN_ENABLED" then
    inCombat = false
    SafeGC()
  elseif event == "ZONE_CHANGED_NEW_AREA" then
    local zone = GetRealZoneText()
    if HEAVY_ZONES[zone] then EnableLow() else DisableLow() end
  end
end)

local ticker = 0
SC:SetScript("OnUpdate", function(self, elapsed)
  ticker = ticker + elapsed
  if ticker >= 1.5 then
    ticker = 0
    SafeGC()
  end
end)

SLASH_SETHCORE1 = "/sethcore"
SLASH_SETHCORE2 = "/sc"
SlashCmdList["SETHCORE"] = function(msg)
  msg = strtrim(string.lower(msg or ""))
  if msg == "gc" then
    collectgarbage("collect")
    Print(string.format(L.GC_DONE, math.floor(gcinfo()/1024)))
  elseif msg == "low" then
    EnableLow()
    Print(L.LOW_ON)
  elseif msg == "high" then
    DisableLow()
    Print(L.HIGH_ON)
  elseif msg == "info" then
    Print(string.format(L.INFO, math.floor(gcinfo()/1024), lowMode and "ON" or "OFF"))
  else
    Print(L.HELP1)
    Print(L.HELP2)
    Print(L.HELP3)
    Print(L.HELP4)
    Print(L.HELP5)
  end
end
