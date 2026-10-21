-- SethCore PURE LUA v1.1 - FIX + Compatible Leatrix Gfx - SIN DLL - by SethNubth
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

-- A1. GetTime Cached - SAFE - No pisa el global GetTime
local orig_GetTime = GetTime
local cachedTime = orig_GetTime()
local frameNumber = 0
function _G.GetTimeCached() return cachedTime end

-- A4. Table Pool - Reduce GC - SAFE con Leatrix
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

-- FIX: Dos frames separados para no pisar OnUpdate/OnEvent en 3.3.5a
local gcFrame = CreateFrame("Frame")
local eventFrame = CreateFrame("Frame")
local inCombat = false
local isIdle = false
local isLoading = false
local lastActivity = orig_GetTime()

local function Msg(text)
  print("|cffffd700[SethCore PURE]|r "..text)
end

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

-- FRAME 1: Solo GC - Nunca se pisa
gcFrame:SetScript("OnUpdate", function(self, elapsed)
  cachedTime = orig_GetTime()
  frameNumber = frameNumber + 1
  
  if not db or not db.enabled then return end
  
  if (cachedTime - lastActivity) > db.idleTimeout then
    isIdle = true
  end
  
  collectgarbage("step", GetCurrentStepKB())
  
  if GetMemoryMB() > db.fullCollectThresholdMB then
    collectgarbage("collect")
    if db.debugMode then Msg("Emergency GC - Mem: "..string.format("%.1f MB", GetMemoryMB())) end
  end
end)

-- FRAME 2: Solo Eventos
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
eventFrame:RegisterEvent("PLAYER_LEAVING_WORLD")
eventFrame:RegisterEvent("PLAYER_STARTED_MOVING")

eventFrame:SetScript("OnEvent", function(self, event, addon)
  if event == "ADDON_LOADED" and addon == "SethCore" then
    InitDB()
    Msg("V1.1 PURE LUA cargado - Sin DLL - Compatible con Leatrix Gfx - /sethcore")
    self:UnregisterEvent("ADDON_LOADED")
  elseif event == "PLAYER_REGEN_DISABLED" then
    inCombat = true
    isIdle = false
    lastActivity = cachedTime
  elseif event == "PLAYER_REGEN_ENABLED" then
    inCombat = false
    lastActivity = cachedTime
  elseif event == "PLAYER_ENTERING_WORLD" then
    isLoading = true
    isIdle = false
    lastActivity = cachedTime
    -- Fix C_Timer para 3.3.5a sin pisar global si ya existe
    if not C_Timer_After then
      C_Timer_After = function(delay, func)
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
    end
    C_Timer_After(3, function() isLoading = false end)
  elseif event == "PLAYER_LEAVING_WORLD" or event == "PLAYER_STARTED_MOVING" then
    isIdle = false
    lastActivity = cachedTime
  end
end)

-- Comandos mejorados
SLASH_SETHCORE1 = "/sethcore"
SLASH_SETHCORE2 = "/sc"
SlashCmdList["SETHCORE"] = function(msg)
  msg = string.lower(msg or "")
  if not db then InitDB() end
  if msg == "low" or msg == "on" then
    db.enabled = true
    Msg("GC ON - PURE LUA")
  elseif msg == "high" or msg == "off" then
    db.enabled = false
    collectgarbage("collect")
    Msg("GC OFF - Restaurado")
  elseif msg == "status" then
    Msg(string.format("Mem: %.1f MB | Step: %d KB | Idle: %s | Combat: %s | FPS: Leatrix compatible",
      GetMemoryMB(), GetCurrentStepKB(), tostring(isIdle), tostring(inCombat)))
  elseif msg == "collect" then
    collectgarbage("collect")
    Msg("Full GC - Mem: "..string.format("%.1f MB", GetMemoryMB()))
  else
    Msg("PURE LUA sin DLL - Comandos: low/on/high/off/status/collect | Compatible con /gfx")
  end
end
