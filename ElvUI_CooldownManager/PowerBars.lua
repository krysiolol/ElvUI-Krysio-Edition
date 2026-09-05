local E, L, V, P, G = unpack(ElvUI)
local CM = E:GetModule("CooldownManager")

local CreateFrame = CreateFrame
local UnitPower = UnitPower
local UnitPowerMax = UnitPowerMax
local UnitPowerType = UnitPowerType
local GetComboPoints = GetComboPoints
local unpack, pairs, ipairs = unpack, pairs, ipairs

-- ============================================================================
-- Resource & Power Bar Module for CooldownManager
-- ============================================================================
local PowerBars = {}
CM.PowerBars = PowerBars

function PowerBars:CreatePowerFrame(barKey, config)
	if CM.bars[barKey] then return CM.bars[barKey] end

	local frameName = "ElvUI_CMPower_" .. barKey
	local holder = CreateFrame("Frame", frameName .. "_Holder", E.UIParent)
	holder:SetSize(config.barWidth or 240, config.barHeight or 18)
	holder:Point("CENTER", E.UIParent, "CENTER", 0, -180)

	local bar = CreateFrame("Frame", frameName, E.UIParent)
	bar:SetSize(config.barWidth or 240, config.barHeight or 18)
	bar:Point("CENTER", holder, "CENTER", 0, 0)

	bar.key = barKey
	bar.holder = holder
	bar.moverName = frameName .. "_Mover"

	bar.statusBar = CreateFrame("StatusBar", nil, bar)
	bar.statusBar:SetAllPoints(bar)
	local normTex = E.LSM:Fetch("statusbar", config.statusBarTexture or "ElvUI Norm")
	bar.statusBar:SetStatusBarTexture(normTex)

	bar.bg = bar.statusBar:CreateTexture(nil, "BACKGROUND")
	bar.bg:SetAllPoints()
	bar.bg:SetTexture(normTex)
	bar.bg:SetVertexColor(0.1, 0.1, 0.1, 0.8)

	bar.text = bar.statusBar:CreateFontString(nil, "OVERLAY")
	bar.text:FontTemplate(E.LSM:Fetch("font", E.db.cooldownManager.font or "Expressway"), 11, "OUTLINE")
	bar.text:SetPoint("CENTER")

	E:CreateMover(holder, bar.moverName, config.name or "Power Bar", nil, nil, nil, "ALL,SOLO", nil, "elvuiPlugins,cooldownManager")

	CM.bars[barKey] = bar
	return bar
end

function PowerBars:Update(barKey)
	local bar = CM.bars[barKey]
	local config = CM:GetBarConfig(barKey)
	if not bar or not config then return end

	if not E.db.cooldownManager.enable or not config.enable then
		bar:Hide()
		CM:DisableMover(barKey)
		return
	else
		if not config.attachTo or config.attachTo == "NONE" then
			CM:EnableMover(barKey)
		end
	end

	local pType, pToken = UnitPowerType("player")
	local curPower = UnitPower("player", pType)
	local maxPower = UnitPowerMax("player", pType)
	if maxPower <= 0 then maxPower = 1 end

	bar.statusBar:SetMinMaxValues(0, maxPower)
	bar.statusBar:SetValue(curPower)

	-- Resource Colors
	local r, g, b = 0.2, 0.6, 1.0
	if pToken == "MANA" then r, g, b = 0.0, 0.4, 0.9
	elseif pToken == "RAGE" then r, g, b = 0.9, 0.1, 0.1
	elseif pToken == "ENERGY" then r, g, b = 1.0, 0.9, 0.1
	elseif pToken == "RUNIC_POWER" then r, g, b = 0.0, 0.8, 1.0
	end

	bar.statusBar:SetStatusBarColor(r, g, b)
	bar.text:SetText(string.format("%d / %d", curPower, maxPower))
	bar:Show()
end
