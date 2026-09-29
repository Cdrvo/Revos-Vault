SMODS.Consumable({
	key = "ink_intuition",
	set = "Tarot",
	config = { extra = { odds = 2 } },
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		local num, den = SMODS.get_probability_vars(card,1,cae.odds,"ink_seed")
		return { vars = { num,  den } }
	end,
	pos = { x = 0, y = 0 },
	atlas = "revo_tarots",
	cost = 4,
	can_use = function(self, card)
		return RVF.has_room(G.jokers) 
	end,
	use = function(self, card)
		if SMODS.pseudorandom_probability(card,"ink_seed",1,card.ability.extra.odds) then
			SMODS.add_card({ set = "Joker", area = G.jokers, rarity = "crv_printer" })
		else
			RVF.nope({card = card})
		end
	end,
	crv_credits = {
		art = "mr.cr33ps"
	}
})

SMODS.ObjectType({
	key = "crv_mega_printer",
	cards = {
		["j_crv_energy_generator"] = true,
		["j_crv_printer_core"] = true,
		["j_crv_fluid_tank"] = true,
	},
})

SMODS.Consumable({
	key = "dreams_desires",
	weight = 0.5,
	set = "Tarot",
	config = { extra = {} },
	loc_vars = function(self, info_queue, card)
		return { vars = {} }
	end,
	pos = { x = 1, y = 0 },
	atlas = "revo_tarots",
	cost = 3,
	can_use = function(self, card)
		return RVF.has_room(G.jokers)
	end,
	use = function(self, card)
		SMODS.add_card({ set = "crv_mega_printer", area = G.jokers })
		delay(1.5)
	end,
	crv_credits = {
		art = "mr.cr33ps"
	}
})