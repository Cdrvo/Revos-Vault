function RevosVault.FUNCS.remove_border(card)
	if card.ability.border then
        RevosVault.MISC.Borders[card.ability.border.key]:apply(card, false)
        card.ability.border = nil
    end
end

function RevosVault.FUNCS.set_border(card, key)
    if card:crv_has_border() then
	    RevosVault.FUNCS.remove_border(card)
    end
	RevosVault.MISC.Borders[key]:apply(card, true)
end

function Card:crv_has_border(border)
	if self.ability.border and (self.ability.border.key == border or not border) then
        return true
    end
    return false
end

function Card:crv_calculate_border(context, key)
	local border = RevosVault.MISC.Borders[key]
	if self.ability[key] and type(border.calculate) == "function" then
		local o = border:calculate(self, context)
		if o then
			if not o.card then
				o.card = self
			end
			return o
		end
	end
end



RevosVault.MISC.Borders = {}
RevosVault.MISC.Border = SMODS.GameObject:extend({
	required_params = { "key", "atlas" },
	set = "crv_Border",
	atlas = "revo_borders",
	pos = { x = 0, y = 0 },
	obj_table = RevosVault.MISC.Borders,
	obj_buffer = {},
	unlocked = true,
	discovered = true,
	config = {},
	badge_colour = G.C.DARK_EDITION,
	class_prefix = "border",
	no_rank = false,
	no_suit = false,
	register = function(self)
		if self.registered then
			sendWarnMessage(("Detected duplicate register call on object %s"):format(self.key), self.set)
			return
		end
		RevosVault.MISC.Border.super.register(self)
		self.order = #self.obj_buffer
	end,
	inject = function(self)
		self.sticker_sprite = Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS[self.atlas], self.pos)
		G.shared_stickers[self.key] = self.sticker_sprite

		if self.misc_inject then self:misc_inject(self) end
	end,
	apply = function(self, card, val)
		if val then
			card.ability.border = {
                key = self.key
            }
			if self.applied then
				self:applied(card)
			end
		else
			card.ability.border= nil    
			if self.removed then
				self:removed(card)
			end
		end
		card.ability[self.key] = val
		if val and self.config and next(self.config) then
			card.ability["border"].effect = copy_table(self.config)
		end
	end,
	loc_vars = function(self)
		return {}
	end,
	pre_inject_class = function(self)
		G.P_CENTER_POOLS[self.set] = {}
	end,
    crv_credits = {
        art = {"GeorgeTheRat"},
        idea = {"theOfficialFem"}
    }
})


SMODS.DrawStep({ 
	key = "Borders",
	order = 15,
	func = function(self, layer)
		if self.border and G.shared_stickers[self.border] then
			G.shared_stickers[self.border].role.draw_major = self
			G.shared_stickers[self.border]:draw_shader("dissolve", nil, nil, nil, self.children.center)
		end

		for k, v in pairs(RevosVault.MISC.Borders) do
			if self.ability[v.key] then
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


-- Borders yipee

RevosVault.MISC.Border{
	key = "bonus",
	atlas = "revo_borders",
	pos = { x = 0, y = 0 },
	config = {
		effect = 10
	},
	loc_vars = function(self,info_queue,card)
		local cae = card.ability.border.effect
		return{vars = {cae.effect}}
	end,
	calculate = function(self,card,context)
        local cae = card.ability.border.effect
		if context.main_scoring and context.cardarea == G.play then
		    SMODS.calculate_effect({ chips = cae.effect }, card)
		end
	end
}

RevosVault.MISC.Border{
	key = "mult",
	atlas = "revo_borders",
	pos = { x = 0, y = 1 },
	config = {
		effect = 2
	},
	loc_vars = function(self,info_queue,card)
		local cae = card.ability.border.effect
		return{vars = {cae.effect}}
	end,
	calculate = function(self,card,context)
		if context.main_scoring and context.cardarea == G.play then
            local cae = card.ability.border.effect
			SMODS.calculate_effect({ mult = cae.effect }, card)
		end
	end
}

RevosVault.MISC.Border{
	key = "smudged",
	atlas = "revo_borders",
	pos = { x = 2, y = 1 },
	config = {
		effect = "N/A"
	},
	loc_vars = function(self,info_queue,card)
		local translate
		local cae = card.ability.border.effect
        local _key  = self.key
		cae.effect = "N/A" 
		if card and card.base and card.base.suit then 
			if card.base.suit == "Spades" then
				translate = "Clubs"
			elseif card.base.suit == "Clubs" then
				translate = "Spades"
			elseif card.base.suit == "Diamonds" then
				translate = "Hearts"
			elseif card.base.suit == "Hearts" then
				translate = "Diamonds"
			end

			cae.effect = (localize(translate, "suits_plural"))
		end

        if card.area.config.collection then
            _key = _key .. "_alt"
        end
		return{key = _key, vars = {cae.effect}}
	end,
	calculate = function(self,card,context)
	end,
    crv_credits = {
        idea = {"theOfficialFem"}
    }
}

RevosVault.MISC.Border{
	key = "glass",
	atlas = "revo_borders",
	pos = { x = 5, y = 0 },
	config = {
		effect = 1.2
	},
	loc_vars = function(self,info_queue,card)
		local cae = card.ability.border.effect
		return{vars = {cae.effect}}
	end,
	calculate = function(self,card,context)
		if context.main_scoring and context.cardarea == G.play then
            local cae = card.ability.border.effect
			SMODS.calculate_effect({ xmult = cae.effect }, card)
		end
	end
}

RevosVault.MISC.Border{
	key = "steel",
	atlas = "revo_borders",
	pos = { x = 4, y = 0 },
	config = {
		effect = 1.2
	},
	loc_vars = function(self,info_queue,card)
		local cae = card.ability.border.effect
		return{vars = {cae.effect}}
	end,
	calculate = function(self,card,context)
         local cae = card.ability.border.effect
		if context.main_scoring and context.cardarea == G.hand then
			SMODS.calculate_effect({ xmult = cae.effect }, card)
		end
	end
}

RevosVault.MISC.Border{
	key = "stone",
	atlas = "revo_borders",
	pos = { x = 2, y = 0 },
	config = {effect=10},
	blank = true,
	loc_vars = function(self,info_queue,card)
		local cae = card.ability.border.effect
		return{vars = {cae.effect}}
	end,
	calculate = function(self,card,context)
         local cae = card.ability.border.effect
		if context.main_scoring and context.cardarea == G.play then
			SMODS.calculate_effect({ chips = cae.effect }, card)
		end
	end,
}

RevosVault.MISC.Border{
	key = "gold",
	atlas = "revo_borders",
	pos = { x = 3, y = 0 },
	config = {
		effect = 1
	},
	loc_vars = function(self,info_queue,card)
		local cae = card.ability.border.effect
		return{vars = {cae.effect}}
	end,
	calculate = function(self,card,context)
         local cae = card.ability.border.effect
		if context.end_of_round and context.cardarea == G.hand and context.playing_card_end_of_round then
			SMODS.calculate_effect({ dollars = cae.effect }, card)
		end
	end
}

RevosVault.MISC.Border{ 
	key = "lucky",
	atlas = "revo_borders",
	pos = { x = 1, y = 0 },
	config = {
		odds = 5,
		odds2 = 15,
		mult = 5,
		dollars = 5
	},
	loc_vars = function(self,info_queue,card)
		local cae = card.ability.border.effect
		local num, den = SMDOS.get_probability_vars(card, 1, cae.odds, "lucky_border_seed")
		return{vars = {num,cae.odds,cae.odds2,cae.mult,cae.dollars}}
	end,
	calculate = function(self,card,context)
        local cae = card.ability.border.effect
        local effects = {
            repetitions = 0
        }
		if SMODS.pseudorandom_probability(card, "luck_border_seed", 1, cae.odds) and context.main_scoring and context.cardarea == G.play then
            effects["mult"] = cae.mult
		end
		if SMODS.pseudorandom_probability(card, "luck_border_seed", 1, cae.odds2) and context.main_scoring and context.cardarea == G.play then
            effects["dollars"] = cae.dollars
		end
        SMODS.calculate_effect(effects, card)
	end
}


