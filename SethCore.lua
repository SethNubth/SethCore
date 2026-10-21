-- SethCore PURE LUA v1.0 - Basado en LuaBoost 1.9.8 - SIN DLL - by SethNubth
if _G.SETHCORE_LOADED then return end
_G.SETHCORE_LOADED = true

local ADDON_NAME = "SethCore"
local defaults = {
  enabled = true,
  frameStepKB = 50,
  combatStepKB = 15,
  idleStepKB = 150,
  loadingStepKB = 300,
  fullCollectThresholdMB = 300,
  idleTimeout = 15,
  preset = "mid",
  debugMode = false,
}

local db
local function InitDB()
  if type(SethCoreDB) ~= "table" then SethCoreDB = {} end
  for k,v in pairs(defaults) do
    if SethCoreDB[k] == nil then SethCoreDB[k] = v end
  end
  db = SethCoreDB
end

-- A1. GetTime Cached - SAFE
local orig_GetTime = GetTime
local cachedTime = 0
local frameNumber = 0

function _G.GetTimeCached() return cachedTime end

-- A4. Table Pool - Reduce GC
local pool = {}
local poolCount = 0
local POOL_MAX = 200

function _G.SethCore_AcquireTable()
  if poolCount > 0 then
    local t = pool[poolCount]
    pool[poolCount] = nil
    poolCount = poolCount - 1
    return t
  end
  return {}
end

function _G.SethCore_ReleaseTable(t)
  if type(t) ~= "table" then return end
  if poolCount >= POOL_MAX then return end
  if getmetatable(t) then return end
  wipe(t)
  poolCount = poolCount + 1
  pool[poolCount] = t
end

-- Master Frame - UN SOLO FRAME, sin GetFramesRegisteredForEvent
local eventFrame = CreateFrame("Frame")
local inCombat = false
local isIdle = false
local isLoading = false
local lastActivity = GetTime()

local function Msg(text)
  print("|cffffd700[SethCore PURE]|r "..text)
end

-- B. Smart GC Manager - 100% PURE LUA, sin DLL
local function GetMemoryMB()
  return collectgarbage("count") / 1024
end

local function GetCurrentStepKB()
  if not db then return 50 end
  if isLoading then return db.loadingStepKB end
  if inCombat then return db.combatStepKB end
  if isIdle then return db.idleStepKB end
  return db.frameStepKB
end

eventFrame:SetScript("OnUpdate", function(self, elapsed)
  cachedTime = orig_GetTime()
  frameNumber = frameNumber + 1
  
  if not db or not db.enabled then return end
  
  -- Idle detection
  local now = cachedTime
  if (now - lastActivity) > db.idleTimeout then
    isIdle = true
  end
  
  -- GC Stepping - PURE LUA, sin DLL
  local step = GetCurrentStepKB()
  collectgarbage("step", step)
  
  -- Emergency GC
  if GetMemoryMB() > db.fullCollectThresholdMB then
    collectgarbage("collect")
  end
end)

eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")

eventFrame:SetScript("OnEvent", function(self, event, addon)
  if event == "ADDON_LOADED" and addon == "SethCore" then
    InitDB()
    Msg("V1.0 PURE LUA cargado - Sin DLL - Sin bloqueos - /sethcore")
    self:UnregisterEvent("ADDON_LOADED")
  elseif event == "PLAYER_REGEN_DISABLED" then
    inCombat = true
    isIdle = false
    lastActivity = cachedTime
  elseif event == "PLAYER_REGEN_ENABLED" then
    inCombat = false
    lastActivity = cachedTime
  elseif event == "PLAYER_ENTERING_WORLD" then
    isLoading = false
    isIdle = false
    lastActivity = cachedTime
    C_Timer_After = C_Timer_After or function(delay, func)
      local f = CreateFrame("Frame")
      local t = 0
      f:SetScript("OnUpdate", function(self, e)
        t = t + e
        if t >= delay then
          self:SetScript("OnUpdate", nil)
          func()
        end
      end)
    end
    C_Timer_After(2, function() isLoading = false end)
  end
end)

-- Comandos
SLASH_SETHCORE1 = "/sethcore"
SLASH_SETHCORE2 = "/sc"
SlashCmdList["SETHCORE"] = function(msg)
  msg = string.lower(msg or "")
  if msg == "low" or msg == "on" then
    if db then db.enabled = true end
    Msg("GC ON - 30k+ FPS - PURE LUA")
  elseif msg == "high" or msg == "off" then
    if db then db.enabled = false end
    collectgarbage("collect")
    Msg("GC OFF - Restaurado")
  elseif msg == "status" then
    Msg(string.format("Mem: %.1f MB | Step: %d KB | Idle: %s | Combat: %s",
      GetMemoryMB(), GetCurrentStepKB(), tostring(isIdle), tostring(inCombat)))
  elseif msg == "collect" then
    collectgarbage("collect")
    Msg("Full GC hecho - Mem: "..string.format("%.1f MB", GetMemoryMB()))
  else
    Msg("PURE LUA sin DLL - Comandos: low/high/status/collect")
  end
end
