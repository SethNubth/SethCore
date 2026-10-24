-- SethLeatCore V2.0 PURE LUA - Made: SethNubth - Rexbe
-- Leatrix Gfx 2.15 ORIGINAL (2009) + SethCore PURE + Fix fpscap line 151
-- 4 Locales - EN / RU / ES / PT - SIN DLL - SIN ACE - WotLK 3.3.5a

if _G.SETHLEATCORE_LOADED then return end
_G.SETHLEATCORE_LOADED = true
_G.SETHCORE_LOADED = true

local locale = GetLocale()
local L = {}
if locale == "ruRU" then
L["reduce"]="Уменьшить цвета мира" L["shadow"]="Убрать тени и грязь" L["shaders"]="Отключить шейдеры"
L["ground"]="Отключить траву" L["full"]="Полноэкранный режим свечения" L["glow"]="Отключить свечение"
L["maxfps"]="Лимит FPS" L["fpscap"]="Лимит FPS" L["maxfpsbk"]="Лимит FPS в фоне" L["userdef"]="На весь экран"
L["restart"]="Перезапустите WoW." L["seth"]="SethCore PURE GC" L["seth_on"]="Включить умный GC" L["gfx"]="Графика"
elseif locale == "esES" or locale == "esMX" then
L["reduce"]="Reducir colores del mundo" L["shadow"]="Quitar sombras y suciedad" L["shaders"]="Desactivar shaders"
L["ground"]="Desactivar pasto" L["full"]="Modo pantalla completa brillo" L["glow"]="Desactivar brillo"
L["maxfps"]="Limitar FPS" L["fpscap"]="Límite de FPS" L["maxfpsbk"]="Limitar FPS en segundo plano" L["userdef"]="Pantalla completa"
L["restart"]="Reinicia WoW para aplicar." L["seth"]="SethCore PURE GC" L["seth_on"]="Activar GC Inteligente" L["gfx"]="Gráficos"
elseif locale == "ptBR" then
L["reduce"]="Reduzir cores do mundo" L["shadow"]="Remover sombras e sujeira" L["shaders"]="Desativar shaders"
L["ground"]="Desativar grama" L["full"]="Modo tela cheia brilho" L["glow"]="Desativar brilho"
L["maxfps"]="Limitar FPS" L["fpscap"]="Limite de FPS" L["maxfpsbk"]="Limitar FPS em segundo plano" L["userdef"]="Tela cheia"
L["restart"]="Reinicie o WoW para aplicar." L["seth"]="SethCore PURE GC" L["seth_on"]="Ativar GC Inteligente" L["gfx"]="Gráficos"
else
L["reduce"]="Reduce world colors" L["shadow"]="Remove shadows and dirt" L["shaders"]="Disable shaders"
L["ground"]="Disable ground clutter" L["full"]="Fullscreen glow mode" L["glow"]="Disable glow"
L["maxfps"]="Limit FPS" L["fpscap"]="FPS Cap" L["maxfpsbk"]="Limit FPS in background" L["userdef"]="Fullscreen"
L["restart"]="Restart WoW to apply." L["seth"]="SethCore PURE GC" L["seth_on"]="Enable Smart GC" L["gfx"]="Graphics"
end

if type(LeaGfxDB) ~= "table" then LeaGfxDB = {} end
if type(SethCoreDB) ~= "table" then SethCoreDB = {} end

local LeaGfxLC = {}
LeaGfxLC["gxcolorbits"] = LeaGfxDB["gxcolorbits"] or "24"
LeaGfxLC["shadowprints"] = LeaGfxDB["shadowprints"] or "1"
LeaGfxLC["shaders"] = LeaGfxDB["shaders"] or "1"
LeaGfxLC["groundEffects"] = LeaGfxDB["groundEffects"] or "1"
LeaGfxLC["ffxGlow"] = LeaGfxDB["ffxGlow"] or "1"
LeaGfxLC["ffxGlowFull"] = LeaGfxDB["ffxGlowFull"] or "0"
LeaGfxLC["maxfps"] = LeaGfxDB["maxfps"] or "0"
LeaGfxLC["fpscap"] = tonumber(LeaGfxDB["fpscap"]) or 120
LeaGfxLC["maxfpsbk"] = LeaGfxDB["maxfpsbk"] or "0"
LeaGfxLC["userdef"] = LeaGfxDB["userdef"] or "0"
LeaGfxLC["seth_enabled"] = (SethCoreDB.enabled == nil and "1" or (SethCoreDB.enabled and "1" or "0"))

local defaults = {enabled=true, frameStepKB=50, combatStepKB=15, idleStepKB=150, loadingStepKB=300, fullCollectThresholdMB=300, idleTimeout=15}
for k,v in pairs(defaults) do if SethCoreDB[k]==nil then SethCoreDB[k]=v end end

local orig_GetTime = GetTime
local cachedTime = orig_GetTime()
local pool, poolCount, POOL_MAX = {}, 0, 200
function _G.SethCore_AcquireTable() if poolCount>0 then local t=pool[poolCount] pool[poolCount]=nil poolCount=poolCount-1 return t end return {} end
function _G.SethCore_ReleaseTable(t) if type(t)~="table" then return end if poolCount>=POOL_MAX then return end if getmetatable(t) then return end wipe(t) poolCount=poolCount+1 pool[poolCount]=t end
function _G.GetTimeCached() return cachedTime end

local gcFrame = CreateFrame("Frame")
local eventFrame = CreateFrame("Frame")
local inCombat, isIdle, isLoading, lastActivity = false, false, false, orig_GetTime()
local function GetMemoryMB() return collectgarbage("count")/1024 end
local function GetCurrentStepKB()
  if isLoading then return SethCoreDB.loadingStepKB end
  if inCombat then return SethCoreDB.combatStepKB end
  if isIdle then return SethCoreDB.idleStepKB end
  return SethCoreDB.frameStepKB
end

local menu = CreateFrame("Frame", "SethLeatCoreMenu", UIParent, "BackdropTemplate")
menu:SetSize(340, 560)
menu:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
menu:SetBackdrop({
  bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
  edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
  tile = true, tileSize = 32, edgeSize = 32,
  insets = { left = 11, right = 12, top = 12, bottom = 11 }
})
menu:SetMovable(true)
menu:EnableMouse(true)
menu:RegisterForDrag("LeftButton")
menu:SetScript("OnDragStart", function(self)
  if IsAltKeyDown() then self:StartMoving() end
end)
menu:SetScript("OnDragStop", function(self)
  self:StopMovingOrSizing()
end)
menu:Hide()

local title = menu:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
title:SetPoint("TOPLEFT", 20, -18)
title:SetText("SethLeatCore")

local function AddSectionTitle(text, y)
  local t = menu:CreateFontString(nil, "ARTWORK", "GameFontNormal")
  t:SetPoint("TOPLEFT", 20, y)
  t:SetText(text)
  return y - 26
end

local function CheckBox(field, label, y)
  local cb = CreateFrame("CheckButton", "SLGCheck_" .. field, menu, "OptionsCheckButtonTemplate")
  cb:SetPoint("TOPLEFT", 20, y)
  _G[cb:GetName() .. "Text"]:SetText(label)
  cb:SetScript("OnShow", function() cb:SetChecked(LeaGfxLC[field] == "1") end)
  cb:SetScript("OnClick", function() LeaGfxLC[field] = cb:GetChecked() and "1" or "0" end)
end

local function Slider(field, label, y)
  local s = CreateFrame("Slider", "SLGSlider_" .. field, menu, "OptionsSliderTemplate")
  s:SetPoint("TOPLEFT", 30, y)
  s:SetMinMaxValues(10, 200)
  s:SetValueStep(1)
  _G[s:GetName() .. "Text"]:SetText(label)
  _G[s:GetName() .. "Low"]:SetText("10")
  _G[s:GetName() .. "High"]:SetText("200")
  s:SetScript("OnShow", function() s:SetValue(tonumber(LeaGfxLC[field]) or 120) end)
  s:SetScript("OnValueChanged", function(_, v)
    local value = math.floor(v)
    LeaGfxLC[field] = value
    _G[s:GetName() .. "Text"]:SetText(label .. " (" .. value .. ")")
  end)
end

local y = -50

y = AddSectionTitle(L["gfx"], y)
CheckBox("gxcolorbits", L["reduce"], y - 20)
y = y - 40
CheckBox("shadowprints", L["shadow"], y - 20)
y = y - 40
CheckBox("shaders", L["shaders"], y - 20)
y = y - 40
CheckBox("groundEffects", L["ground"], y - 20)
y = y - 55

y = AddSectionTitle("Glow", y)
CheckBox("ffxGlowFull", L["full"], y - 20)
y = y - 40
CheckBox("ffxGlow", L["glow"], y - 20)
y = y - 55

y = AddSectionTitle("FPS", y)
CheckBox("maxfps", L["maxfps"], y - 20)
y = y - 40
Slider("fpscap", L["fpscap"], y - 18)
y = y - 60
CheckBox("maxfpsbk", L["maxfpsbk"], y - 20)
y = y - 40
CheckBox("userdef", L["userdef"], y - 20)
y = y - 55

y = AddSectionTitle(L["seth"], y)
CheckBox("seth_enabled", L["seth_on"], y - 20)

local memText = menu:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
memText:SetPoint("BOTTOMLEFT", 18, 50)

local applyButton = CreateFrame("Button", nil, menu, "UIPanelButtonTemplate")
applyButton:SetSize(120, 24)
applyButton:SetPoint("BOTTOMRIGHT", menu, "BOTTOMRIGHT", -18, 18)
applyButton:SetText("Apply")
applyButton:SetScript("OnClick", function()
  for k,v in pairs(LeaGfxLC) do
    if k ~= "seth_enabled" then
      if k == "fpscap" then LeaGfxDB[k] = tonumber(v) or 120 else LeaGfxDB[k] = v end
    end
  end
  SethCoreDB.enabled = LeaGfxLC["seth_enabled"] == "1"
  SetCVar("gxColorBits", LeaGfxLC["gxcolorbits"] == "1" and "16" or "24")
  SetCVar("shadowLevel", LeaGfxLC["shadowprints"] == "1" and "0" or "1")
  print("|cffffd700[SethLeatCore]|r " .. L["restart"] .. " /slg rl")
end)

local closeButton = CreateFrame("Button", nil, menu, "UIPanelCloseButton")
closeButton:SetPoint("TOPRIGHT", -6, -6)
closeButton:SetScript("OnClick", function() menu:Hide() end)

local function ShowMenu()
  if menu:IsShown() then
    menu:Hide()
  else
    menu:Show()
  end
end

gcFrame:SetScript("OnUpdate", function()
  cachedTime = orig_GetTime()
  if SethCoreDB.enabled and (cachedTime - lastActivity) > SethCoreDB.idleTimeout then isIdle=true end
  if SethCoreDB.enabled then
    collectgarbage("step", GetCurrentStepKB())
    if GetMemoryMB() > SethCoreDB.fullCollectThresholdMB then collectgarbage("collect") end
  end
  if memText then memText:SetText(string.format("GC: %.1f MB | Step: %d KB", GetMemoryMB(), GetCurrentStepKB())) end
end)

eventFrame:RegisterEvent("PLAYER_REGEN_DISABLED") eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD") eventFrame:RegisterEvent("PLAYER_STARTED_MOVING")
eventFrame:SetScript("OnEvent", function(_,event)
  if event=="PLAYER_REGEN_DISABLED" then inCombat=true isIdle=false lastActivity=cachedTime
  elseif event=="PLAYER_REGEN_ENABLED" then inCombat=false lastActivity=cachedTime
  elseif event=="PLAYER_ENTERING_WORLD" then isLoading=true lastActivity=cachedTime
    local f=CreateFrame("Frame") local t=0 f:SetScript("OnUpdate",function(s,e) t=t+e if t>=3 then s:SetScript("OnUpdate",nil) isLoading=false end end)
  elseif event=="PLAYER_STARTED_MOVING" then isIdle=false lastActivity=cachedTime end
end)

SLASH_SLG1="/slg" SLASH_SLG2="/sethleatcore" SLASH_SLG3="/gfx"
SlashCmdList["SLG"]=function(msg)
  msg=string.lower(msg or "")
  if msg=="" then ShowMenu()
  elseif msg=="reload" or msg=="rl" then ReloadUI()
  elseif msg=="status" or msg=="s" then print(string.format("|cffffd700[SethLeatCore]|r Mem: %.1f MB | Step: %d KB",GetMemoryMB(),GetCurrentStepKB()))
  elseif msg=="collect" or msg=="c" then collectgarbage("collect") print("|cffffd700[SethLeatCore]|r GC Done - "..string.format("%.1f MB",GetMemoryMB()))
  elseif msg=="on" then SethCoreDB.enabled=true LeaGfxLC["seth_enabled"]="1" print("|cffffd700[SethLeatCore]|r GC ON")
  elseif msg=="off" then SethCoreDB.enabled=false LeaGfxLC["seth_enabled"]="0" collectgarbage("collect") print("|cffffd700[SethLeatCore]|r GC OFF")
  else print("|cffffd700[SethLeatCore]|r /slg | /slg rl | /slg s | /slg c | /slg on/off") end
end
SLASH_SC1="/sc" SLASH_SC2="/sethcore" SlashCmdList["SC"]=function(m) SlashCmdList["SLG"](m) end

print("|cffffd700[SethLeatCore]|r Made: SethNubth - Rexbe V2.0 PURE LUA - /slg - Loaded")
