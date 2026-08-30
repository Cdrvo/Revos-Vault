SMODS.Joker({
	key = "blueprinter",
	atlas = "revo_jokers",
	rarity = "crv_printer",
	cost = 13,
	
	discovered = false,
	blueprint_compat = false,
	attributes = {
		"printer",
		"generation",
		"joker",
	},
	pos = {
		x = 8,
		y = 4,
	},
	config = {
		extra = {
			test_this_shit = false
		},
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_blueprint
	end,

	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint then
			RVF.printer_create(card, { key = "j_blueprint" })
		end
	end,
})

SMODS.Joker({
	key = "broken_blueprinter",
	atlas = "revo_jokers",
	rarity = "crv_printer",
	cost = 10,
	
	discovered = false,
	blueprint_compat = false,
	pos = {
		x = 5,
		y = 5,
	},
	config = {
		extra = {
			odds = 4
		},
	},
	loc_vars = function(self, info_queue, card)
		local num, den = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "broken_seed")
		info_queue[#info_queue + 1] = G.P_CENTERS.j_blueprint
		return{vars={num, den}}
	end,

	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint then
			if SMODS.pseudorandom_probability(card, "broken_seed", 1, card.ability.extra.odds) then
				SMODS.destroy_cards(card)
			end
			RVF.printer_create(card, { key = "j_blueprint" })
		end
	end,

	in_pool = function(self, wawa, wawa2)
		return true
	end,
})

SMODS.Joker({
	key = "gros_printer",
	atlas = "revo_jokers",
	rarity = "crv_printer",
	cost = 13,
	
	discovered = false,
	blueprint_compat = true,
	attributes = {
		"printer",
		"generation",
		"joker",
	},
	pos = {
		x = 9,
		y = 4,
	},
	config = {
		extra = {
			odds = 4011,
		},
	},
	loc_vars = function(self, info_queue, card)
		local num, den = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "gros_seed")
		info_queue[#info_queue + 1] = G.P_CENTERS.j_crv_holy_banana
		return { vars = { num, den } }
	end,

	calculate = function(self, card, context)
		if context.setting_blind then
			if not SMODS.pseudorandom_probability(card, "gros_seed", 1, card.ability.extra.odds) then
				local banana = pseudorandom_element(SMODS.get_attribute_pool("banana"), pseudoseed("gros_seed"))
				RVF.printer_create(card, { key = banana })
			else
				RVF.printer_create(card, { key = "j_crv_holy_banana" })
			end
		end
	end,
})

SMODS.Joker({
	key = "rusty_printer",
	atlas = "revo_jokers",
	rarity = "crv_printer",
	cost = 13,
	
	discovered = false,
	blueprint_compat = false,
	attributes = {
		"printer",
		"generation",
		"joker",
	},
	pos = {
		x = 0,
		y = 5,
	},
	config = {
		extra = {},
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_brainstorm
	end,

	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint then
			RVF.printer_create(card, { key = "j_brainstorm" })
		end
	end,
})

SMODS.Joker({
	key = "default_printer",
	atlas = "revo_jokers",
	rarity = "crv_printer",
	--[[fg_data = {
			is_alternate = false,
			alternate_key ='j_crv_aberration_printer'
		},	]]
	cost = 13,
	
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 1,
		y = 5,
	},
	attributes = {
		"printer",
		"generation",
	},
	config = {
		extra = {},
	},
	calculate = function(self, card, context)
		if context.setting_blind then
			local sets, _set, fuck = { "Joker", "Consumeables", "Playing Card" }, nil, nil
			_set = pseudorandom_element(sets, pseudoseed("default_printer_seed"))
			if _set == "Playing Card" then
				fuck = G.deck
			elseif _set == "Consumeables" then
				fuck = G.consumeables
			else
				fuck = G.jokers
			end
			RVF.printer_create(card, { set = _set, area = fuck })
		end
	end,
})

SMODS.Joker({
	key = "joker_printer",
	atlas = "revo_jokers",
	rarity = "crv_printer",
	cost = 13,
	
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 2,
		y = 5,
	},
	config = {
		extra = {},
	},
	attributes = {
		"printer",
		"generation",
		"joker"
	},
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_joker
	end,
	calculate = function(self, card, context)
		if context.setting_blind then
			RVF.printer_create(card, { key = "j_joker", area = G.jokers })
		end
	end,
})

SMODS.Joker({
	key = "obelisk_printer",
	atlas = "revo_jokers",
	rarity = "crv_printer",
	cost = 13,
	
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 3,
		y = 5,
	},
	attributes = {
		"printer",
		"generation",
		"joker"
	},
	config = {
		extra = {},
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_obelisk
	end,
	calculate = function(self, card, context)
		if context.setting_blind then
			RVF.printer_create(card, { key = "j_obelisk", area = G.jokers })
		end
	end,
})

SMODS.Joker({
	key = "golden_printer",
	atlas = "revo_jokers",
	rarity = "crv_printer",

	cost = 15,
	
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 4,
		y = 5,
	},
	attributes = {
		"printer",
		"generation",
		"joker",
		"economy"
	},
	config = {
		extra = {
			money = 15
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {},
		}
	end,
	add_to_deck = function(self, card, from_debuff)
		card.ability.extra_value = card.ability.extra_value or 0
		card.ability.extra_value = card.sell_cost*4
		card:set_cost()
	end,
	calculate = function(self, card, context)
		if context.setting_blind then
			local _pool = SMODS.get_attribute_pool("economy")
			local clean_pool = {}
			for k, v in pairs(_pool) do
				if G.P_CENTERS[v] and G.P_CENTERS[v].set and G.P_CENTERS[v].set == "Joker" then
					clean_pool[#clean_pool+1] = v
				end
			end
			local _card = pseudorandom_element(clean_pool, pseudoseed("reworked_gold_seed"))
			RVF.printer_create(card, { key = _card, area = G.jokers })
		end
	end,
})

SMODS.Joker({
	key = "spectral_printer",
	atlas = "revo_jokers",
	rarity = "crv_printer",
	cost = 13,
	
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 6,
		y = 5,
	},
	attributes = {
		"printer",
		"generation",
		"economy"
	},
	config = {
		extra = {},
	},
	calculate = function(self, card, context)
		if context.setting_blind then
			RVF.printer_create(card, { set = "Spectral", area = G.consumeables })
		end
	end,
})

SMODS.Joker({
	key = "voucher_printer",
	atlas = "revo_jokers",
	rarity = "crv_printer",
	cost = 15,
	
	discovered = false,
	blueprint_compat = false,
	crv_cartridge_blacklist = {
		c_crv_mixed = true,
		c_crv_ghostly = true,
		c_crv_golden = true
	},
	pos = {
		x = 9,
		y = 5,
	},
	attributes = {
		"printer",
		"generation",
	},
	config = {
		extra = {},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {},
		}
	end,
	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint then
			RVF.printer_create(card, { set = "Voucher" })
		end
	end,
})

SMODS.Joker({
	key = "food_printer",
	atlas = "revo_jokers",
	rarity = "crv_printer",
	cost = 13,
	
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 0,
		y = 6,
	},
	config = {
		extra = {
		},
	},
	attributes = {
		"printer",
		"generation",
		"joker"
	},
	pools = {
		Food = true,
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {},
		}
	end,
	calculate = function(self, card, context)
		if context.setting_blind then
			RVF.printer_create(card, { set = "Food", area = G.jokers })
		end
	end,
})

SMODS.Joker({
	key = "fax_machine",
	config = {
		extra = {
			odds = 2,
		},
	},
	discovered = false,
	rarity = "crv_printer",
	atlas = "revo_jokers",
	blueprint_compat = true,
	pos = {
		x = 1,
		y = 6,
	},
	attributes = {
		"printer",
		"generation",
		"chance"
	},
	cost = 13,
	eternal_compat = true,
	loc_vars = function(self, info_queue, card)
		local num, den = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "fax_machine_seed")
		return {
			vars = { num, den },
		}
	end,
	calculate = function(self, card, context)
		if context.setting_blind and SMODS.pseudorandom_probability(card, "fax_machine_seed", 1, card.ability.extra.odds) then
			RVF.printer_create(card, { set = "crv_Contracts", area = G.consumeables })
		end
	end,
})



-- leg
SMODS.Joker({
	key = "legendary_printer", -- should i add printer badge idk
	atlas = "revo_jokers",
	rarity = 4,
	cost = 20,
	
	discovered = false,
	blueprint_compat = false,
	crv_cartridge_blacklist = {
		c_crv_mixed = true
	},
	pos = {
		x = 7,
		y = 5,
	},
	soul_pos = {
		x = 8,
		y = 5,
	},
	config = {
		extra = {
			odds = 2,
		},
	},
	attributes = {
		"printer",
		"joker",
		"generation",
		"chance"
	},
	loc_vars = function(self, info_queue, card)
		local num,den = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "crv_legendary_seed")
		return {
			vars = { num, den },
		}
	end,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.setting_blind and not context.blueprint then
			if SMODS.pseudorandom_probability(card, "crv_legendary_seed", 1, cae.odds) then
				RVF.printer_create(card, { set = "Joker", area = G.consumeables, edition = "e_negative", stickers = {"perishable"}, legendary = true })
			end
		end
	end,
})
