BuffCounter = {}

function BuffCounter:OnLoad()
	BuffCounter:SendMessage("TEST!")
	SLASH_BuffCounter1 = "/bc"
	SlashCmdList["BuffCounter"] = function(msg) 
		if msg == "toggle" then
			if BuffCounterToggle then
				BuffCounterToggle = false
			else
				BuffCounterToggle = true
			end
			BuffCounter:SendMessage("Toggled mode!")
		end
	end
end

function BuffCounter:BuffAmount()
	local a = 0
	for i=1, 32 do
		local b,_ = UnitBuff("player", i, "HELPFUL")
		if not b then a=i; break end
	end
	return a or 0
end

function BuffCounter:RemainingBuffs()
	return 32-self:BuffAmount()
end

function BuffCounter:SendMessage(msg)
	DEFAULT_CHAT_FRAME:AddMessage("|cFFFF8080BuffCounter|r: "..msg)
end

function BuffCounter:Update()
	if BuffCounterToggle then
		BuffCounter_FrameAmount:SetText(self:BuffAmount())
	else
		BuffCounter_FrameAmount:SetText(self:RemainingBuffs())
	end
end
