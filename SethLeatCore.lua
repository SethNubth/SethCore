
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

local panel = CreateFrame("Frame", "SethLeatCorePanel")
panel.name = "SethLeatCore"
local function OptionsText(text,x,y) local t=panel:CreateFontString(nil,"ARTWORK","GameFontNormal") t:SetPoint("TOPLEFT",x,y) t:SetText(text) end
local function CheckBox(field,label,x,y)
  local cb = CreateFrame("CheckButton","SLGCheck_"..field,panel,"OptionsCheckButtonTemplate")
  cb:SetPoint("TOPLEFT",x,y) _G[cb:GetName().."Text"]:SetText(label)
  cb:SetScript("OnShow", function() cb:SetChecked(LeaGfxLC[field]=="1") end)
  cb:SetScript("OnClick", function() LeaGfxLC[field]=cb:GetChecked() and "1" or "0" end)
end
local function Slider(field,label,x,y)
  local s = CreateFrame("Slider","SLGSlider_"..field,panel,"OptionsSliderTemplate")
  s:SetPoint("TOPLEFT",x,y) s:SetMinMaxValues(10,200) s:SetValueStep(1)
  _G[s:GetName().."Text"]:SetText(label) _G[s:GetName().."Low"]:SetText("10") _G[s:GetName().."High"]:SetText("200")
  s:SetScript("OnShow", function() s:SetValue(tonumber(LeaGfxLC[field]) or 120) end)
  s:SetScript("OnValueChanged", function(_,v) LeaGfxLC[field]=math.floor(v) _G[s:GetName().."Text"]:SetText(label.." ("..math.floor(v)..")") end)
end

OptionsText(L["gfx"],16,-16)
CheckBox("gxcolorbits",L["reduce"],16,-97)
CheckBox("shadowprints",L["shadow"],16,-127)
CheckBox("shaders",L["shaders"],16,-157)
CheckBox("groundEffects",L["ground"],16,-187)
OptionsText("Glow",16,-222)
CheckBox("ffxGlowFull",L["full"],16,-247)
CheckBox("ffxGlow",L["glow"],16,-277)
OptionsText("FPS",16,-312)
CheckBox("maxfps",L["maxfps"],16,-337)
Slider("fpscap",L["fpscap"],46,-372)
CheckBox("maxfpsbk",L["maxfpsbk"],16,-407)
CheckBox("userdef",L["userdef"],16,-437)
OptionsText(L["seth"],16,-472)
CheckBox("seth_enabled",L["seth_on"],16,-497)
local memText = panel:CreateFontString(nil,"ARTWORK","GameFontNormalSmall")
memText:SetPoint("TOPLEFT",16,-522)

gcFrame:SetScript("OnUpdate", function()
  cachedTime = orig_GetTime()
  if SethCoreDB.enabled and (cachedTime - lastActivity) > SethCoreDB.idleTimeout then isIdle=true end
  if SethCoreDB.enabled then
    collectgarbage("step", GetCurrentStepKB())
    if GetMemoryMB() > SethCoreDB.fullCollectThresholdMB then collectgarbage("collect") end
  end
  if memText then memText:SetText(string.format("GC: %.1f MB | Step: %d KB", GetMemoryMB(), GetCurrentStepKB())) end
end)

function panel.okay()
  for k,v in pairs(LeaGfxLC) do
    if k~="seth_enabled" then
      if k=="fpscap" then LeaGfxDB[k]=tonumber(v) or 120 else LeaGfxDB[k]=v end
    end
  end
  SethCoreDB.enabled = LeaGfxLC["seth_enabled"]=="1"
  SetCVar("gxColorBits", LeaGfxLC["gxcolorbits"]=="1" and "16" or "24")
  SetCVar("shadowLevel", LeaGfxLC["shadowprints"]=="1" and "0" or "1")
  print("|cffffd700[SethLeatCore]|r "..L["restart"].." /slg rl")
end
InterfaceOptions_AddCategory(panel)

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
  if msg=="" then InterfaceOptionsFrame_OpenToCategory(panel)
  elseif msg=="reload" or msg=="rl" then ReloadUI()
  elseif msg=="status" or msg=="s" then print(string.format("|cffffd700[SethLeatCore]|r Mem: %.1f MB | Step: %d KB",GetMemoryMB(),GetCurrentStepKB()))
  elseif msg=="collect" or msg=="c" then collectgarbage("collect") print("|cffffd700[SethLeatCore]|r GC Done - "..string.format("%.1f MB",GetMemoryMB()))
  elseif msg=="on" then SethCoreDB.enabled=true LeaGfxLC["seth_enabled"]="1" print("|cffffd700[SethLeatCore]|r GC ON")
  elseif msg=="off" then SethCoreDB.enabled=false LeaGfxLC["seth_enabled"]="0" collectgarbage("collect") print("|cffffd700[SethLeatCore]|r GC OFF")
  else print("|cffffd700[SethLeatCore]|r /slg | /slg rl | /slg s | /slg c | /slg on/off") end
end
SLASH_SC1="/sc" SLASH_SC2="/sethcore" SlashCmdList["SC"]=function(m) SlashCmdList["SLG"](m) end

print("|cffffd700[SethLeatCore]|r Made: SethNubth - Rexbe V2.0 PURE LUA - /slg - Loaded")
