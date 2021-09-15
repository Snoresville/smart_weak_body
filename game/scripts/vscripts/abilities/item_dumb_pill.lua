LinkLuaModifier("item_dumb_pill_modifier", "abilities/item_dumb_pill", LUA_MODIFIER_MOTION_NONE)
item_dumb_pill = class({})

function item_dumb_pill:OnSpellStart()
    -- unit identifier
    local caster = self:GetCaster()

    if caster:IsHero() and caster:IsRealHero() and not caster:IsIllusion() then
        caster:AddNewModifier(caster, self, "item_dumb_pill_modifier", {}):IncrementStackCount()
        EmitSoundOn("Bottle.Drink", caster)

        -- Consume one charge
        self:SpendCharge()
    end
end

item_dumb_pill_modifier = class({})
function item_dumb_pill_modifier:GetTexture() return "monkey" end -- get the icon from a different ability

function item_dumb_pill_modifier:IsPermanent() return true end
function item_dumb_pill_modifier:RemoveOnDeath() return false end
function item_dumb_pill_modifier:IsHidden() return false end 	-- we can hide the modifier
function item_dumb_pill_modifier:IsDebuff() return false end 	-- make it red or green

function item_dumb_pill_modifier:GetAttributes()
	return 0
		+ MODIFIER_ATTRIBUTE_PERMANENT           -- Modifier passively remains until strictly removed. 
		-- + MODIFIER_ATTRIBUTE_MULTIPLE            -- Allows modifier to stack with itself. 
		-- + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE -- Allows modifier to be assigned to invulnerable entities. 
end

function item_dumb_pill_modifier:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
	}
	return funcs
end

function item_dumb_pill_modifier:GetModifierBonusStats_Intellect()
	return -self:GetStackCount()
end