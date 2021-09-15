examplemodifier = examplemodifier or class({})

-- check out https://developer.valvesoftware.com/wiki/Dota_2_Workshop_Tools/Scripting/API

-- The modifier Tooltip is inside resource/addon_english.txt (Have fun playing)


function examplemodifier:GetTexture() return "bigbrain" end -- get the icon from a different ability

function examplemodifier:IsPermanent() return true end
function examplemodifier:RemoveOnDeath() return false end
function examplemodifier:IsHidden() return false end 	-- we can hide the modifier
function examplemodifier:IsDebuff() return true end 	-- make it red or green

function examplemodifier:OnCreated()
	if IsClient() then return end
	self:StartIntervalThink(0.1)
end

function examplemodifier:GetAttributes()
	return 0
		+ MODIFIER_ATTRIBUTE_PERMANENT           -- Modifier passively remains until strictly removed. 
		-- + MODIFIER_ATTRIBUTE_MULTIPLE            -- Allows modifier to stack with itself. 
		-- + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE -- Allows modifier to be assigned to invulnerable entities. 
end

function examplemodifier:OnIntervalThink()
	self:GetParent():CalculateStatBonus(true)
end

function examplemodifier:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
	}
	return funcs
end

function examplemodifier:GetModifierBonusStats_Strength()
	return -self:GetParent():GetIntellect()
end

function examplemodifier:GetModifierBonusStats_Agility()
	return -self:GetParent():GetIntellect()
end