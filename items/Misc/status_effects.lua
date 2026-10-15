-- Register it or somethign

RevosVault.MISC.StatusEffects = {}
RevosVault.MISC.StatusEffect = SMODS.GameObject:extend({
	required_params = { "key"},
	set = "crv_StatusEffect",
	atlas = "revo_status_effects",
	pos = { x = 0, y = 0 },
	obj_table = RevosVault.MISC.StatusEffects,
	obj_buffer = {},
	unlocked = true,
	discovered = true,
	config = {},
	badge_colour = HEX("5d8e98"),
	class_prefix = "csf", -- // crv_status_effect
	register = function(self)
		if self.registered then
			sendWarnMessage(("Detected duplicate register call on object %s"):format(self.key), self.set)
			return
		end
		RevosVault.MISC.StatusEffect.super.register(self)
		self.order = #self.obj_buffer
	end,
	inject = function(self)
		self.sticker_sprite = Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS[self.atlas], self.pos)
		G.shared_stickers[self.key] = self.sticker_sprite

		if self.misc_inject then
			self:misc_inject(self)
		end
	end,
	apply = function(self, card, val)
		if val then
			local ref_table = card.ability
			ref_table.crv_status_effects = ref_table.crv_status_effects or {}
			ref_table.crv_status_effects[self.key] = true
            if self.config and next(self.config) then 
                ref_table.crv_status_effects[self.key].ability = copy_table(self.config)
            end
			if self.applied and type(self.applied) == "function" then
				self:applied(card)
			end
		else
            local ref_table = card.ability
			if ref_table.crv_status_effects[self.key] then
				ref_table.crv_status_effects[self.key] = nil
			end
			if self.removed and type(self.removed) == "function" then
				self:removed(card)
			end
		end
	end,
})

-- DrawStep bs

SMODS.DrawStep({ 
	key = "crv_StatusEffects",
	order = 15,
	func = function(self, layer)
		for k, v in pairs(RevosVault.MISC.StatusEffects) do
			if self.ability.crv_status_effects and self.ability.crv_status_effects[v.key] then
				if v and v.draw and type(v.draw) == "function" then
					v:draw(self, layer)
				else
					G.shared_stickers[v.key].role.draw_major = self
					G.shared_stickers[v.key]:draw_shader("dissolve", nil, nil, nil, self.children.center)
				end
			end
		end
	end,
	conditions = { vortex = false, facing = "front" },
})

-- Calculation

function Card:crv_calculate_statuseffect(context, key)
    if self.ability.crv_status_effects then
        local StatusEffect = RevosVault.MISC.StatusEffects[key]
        if self.ability.crv_status_effects[key] and type(StatusEffect.calculate) == 'function' then
            local o = StatusEffect:calculate(self, context)
            if o then
                if not o.card then o.card = self end
                return o
            end
        end
    end
end

-- Funcs

function Card:crv_has_statuseffect(effect)
	if not effect then return end
	local completed_effect = "csf_" .. effect
	if self.ability and self.ability.crv_status_effects and self.ability.crv_status_effects[completed_effect] then
		return true
	end
	return false
end

function Card:apply_status_effect(effect)
	if not effect then return end
	local completed_effect = "csf_" .. effect
	RevosVault.MISC.StatusEffects[completed_effect]:apply(self, true)
end

function Card:remove_status_effect(effect)
	if not effect then return end
	local completed_effect = "csf_" .. effect
	RevosVault.MISC.StatusEffects[completed_effect]:apply(self, false)
end


-- Status Effects

local StatusEffect = RevosVault.MISC.StatusEffect

StatusEffect{
    key = "temporary",
	badge_colour = HEX("a6605d"),
    atlas = "revo_status_effects",
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval then
            SMODS.destroy_cards(card)
        end
    end
}

StatusEffect{
    key = "empowered",
    pos = {x=1,y=0},
	badge_colour = HEX("e9f2a5"),
    atlas = "revo_status_effects",
    calculate = function(self, card, context)
        if context.retrigger_joker_check and context.other_card == card and not context.retrigger_joker then
            return{
                repetitions = 1
            }
        end
    end
}

StatusEffect{
    key = "drained",
    pos = {x=3,y=0},
    atlas = "revo_status_effects",
	badge_colour = HEX("5e5e5e"),
    calculate = function(self, card, context)
		if context.before and not card.ability.crv_no_trigger and SMODS.pseudorandom_probability(card, "crv_drained", 1, 4, nil, true) then
			card.ability.crv_no_trigger = true
			card.ability.crv_drained = true
		end
		if context.after then
			if card.ability.crv_drained then
				card.ability.crv_drained = nil
				card.ability.crv_no_trigger = nil
			end
		end
	end
}

StatusEffect{
	key = "marked",
	pos = {x=2,y=0},
	badge_colour = HEX("fd5f55"),
	atlas = "revo_status_effects",
	calculate = function(self, card, context)
        if context.joker_type_destroyed and context.card ~= card and context.card.ability.set == "Joker" and not context.blueprint and not context.card:crv_has_statuseffect("crv_marked") and not context.card.ability.crv_marked_mark then
			context.card.ability.crv_marked_mark = true
			local copy_card = SMODS.copy_card(context.card)
			copy_card.ability.crv_marked_mark = nil
			SMODS.destroy_cards(card)
		end
    end
}