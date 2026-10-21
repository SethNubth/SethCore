-- SethCore V1.0 SAFE MODE - by SethNubth - NO BLOQUEA NADA
local f=CreateFrame("Frame", "SethCoreSafeFrame")
local loaded=false

local function Print(m)
  if DEFAULT_CHAT_FRAME then
    DEFAULT_CHAT_FRAME:AddMessage("|cffffd700[SethCore]|r "..m)
  end
end

f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, arg1)
  if event=="ADDON_LOADED" and arg1=="SethCore" and not loaded then
    loaded=true
    Print("V1.0 SAFE cargado - NO bloquea - /sethcore low / high / status")
    self:UnregisterEvent("ADDON_LOADED")
  end
end)

-- Funciones con pcall para que nunca crasheen
local function SafeSetCVar(cvar, value)
  local ok, err = pcall(function() SetCVar(cvar, value) end)
  if not ok then
    Print("CVar "..cvar.." error: "..tostring(err))
  end
  return ok
end

local saved={}
local function Enable()
  saved.s1=GetCVar("shadowLevel")
  saved.s2=GetCVar("groundEffectDensity")
  Print("Guardado: shadow="..tostring(saved.s1))
  SafeSetCVar("shadowLevel", "0")
  SafeSetCVar("groundEffectDensity", "24")
  Print("Boost ON - Manual")
end

local function Disable()
  if saved.s1 then SafeSetCVar("shadowLevel", saved.s1) end
  if saved.s2 then SafeSetCVar("groundEffectDensity", saved.s2) end
  Print("Boost OFF - Restaurado")
end

SLASH_SETHCORE1="/sethcore"
SLASH_SETHCORE2="/sc"
SlashCmdList["SETHCORE"]=function(msg)
  msg=msg and string.lower(msg) or ""
  if msg=="low" or msg=="on" then Enable()
  elseif msg=="high" or msg=="off" then Disable()
  elseif msg=="status" then Print("SAFE MODE - No bloquea, solo manual")
  else Print("Uso: /sethcore low = ON | /sethcore high = OFF | /sethcore status") end
end
