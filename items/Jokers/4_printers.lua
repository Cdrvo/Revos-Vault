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
			test_this_shit = false,
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
	attributes = {
		"printer",
		"generation",
		"joker",
		"chance"
	},
	config = {
		extra = {
			odds = 4,
		},
	},
	loc_vars = function(self, info_queue, card)
		local num, den = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "broken_seed")
		info_queue[#info_queue + 1] = G.P_CENTERS.j_blueprint
		return { vars = { num, den } }
	end,

	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint then
			if SMODS.pseudorandom_probability(card, "broken_seed", 1, card.ability.extra.odds) then
				SMODS.destroy_cards(card)
			end
			RVF.printer_create(card, { key = "j_blueprint" })
		end
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
		"chance"
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
		"joker",
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
		"joker",
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
		"economy",
	},
	config = {
		extra = {
			money = 15,
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {},
		}
	end,
	add_to_deck = function(self, card, from_debuff)
		card.ability.extra_value = card.ability.extra_value or 0
		card.ability.extra_value = card.sell_cost * 4
		card:set_cost()
	end,
	calculate = function(self, card, context)
		if context.setting_blind then
			local _pool = SMODS.get_attribute_pool("economy")
			local clean_pool = {}
			for k, v in pairs(_pool) do
				if G.P_CENTERS[v] and G.P_CENTERS[v].set and G.P_CENTERS[v].set == "Joker" then
					clean_pool[#clean_pool + 1] = v
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
		"economy",
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
		c_crv_golden = true,
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
		extra = {},
	},
	attributes = {
		"printer",
		"generation",
		"joker",
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
	},
	cost = 13,
	eternal_compat = true,
	calculate = function(self, card, context)
		if context.setting_blind then
			RVF.printer_create(card, { set = "crv_Contracts", area = G.consumeables })
		end
	end,
})

SMODS.Joker({
	key = "camera",
	atlas = "revo_jokers",
	rarity = "crv_printer",
	cost = 10,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 3,
		y = 6,
	},
	config = {
		extra = {
			odds = 3,
		},
	},
	attributes = {
		"printer",
		"generation",
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_photograph
		info_queue[#info_queue + 1] = G.P_CENTERS.j_joker
		local cae = card.ability.extra
		local num, den = SMODS.get_probability_vars(card, 1, cae.odds, "camera_seed")
		return {
			vars = { num, den },
		}
	end,
	calculate = function(self, card, context)
		if next(SMODS.find_card("j_joker")) and context.setting_blind then
			RVF.printer_create(card, { key = "j_photograph", area = G.jokers })
		end
	end,
})

SMODS.Joker({
	key = "3d_printer",
	loc_vars = function(self, info_queue, card)
		return {
			vars = {},
		}
	end,
	crv_cartridge_blacklist = {
		c_crv_mixed = true,
		c_crv_ghostly = true,
		c_crv_golden = true,

	},
	atlas = "revo_jokers",
	rarity = "crv_printer",
	cost = 13,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	pos = {
		x = 4,
		y = 6,
	},
	config = {
		extra = {},
	},
	attributes = {
		"printer",
		"generation",
	},
	calculate = function(self, card, context)
		if context.starting_shop and not context.blueprint then
			if not G.GAME.crv_stop_booster then
				G.GAME.crv_stop_booster = true
				RVF.printer_create(card, { set = "Booster" })
			else
				RVF.add_tag("tag_crv_3dprinter_tag")
			end
		end
	end,
})

SMODS.Joker({ 
	key = "time_printer",
	atlas = "revo_jokers",
	rarity = "crv_printer",
	cost = 15,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	pos = {
		x = 5,
		y = 6,
	},
	crv_cartridge_blacklist = {
		c_crv_mixed = true,
		c_crv_ghostly = true,
		c_crv_golden = true,
		
	},
	config = {
		extra = {
			odds = 6,
			ante = 1,
		},
	},
	crv_credits = {
		art = { "Tatsu" },
		idea = { "Tatsu" },
	},
	attributes = {
		"printer",
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		local num, den = SMODS.get_probability_vars(card, 1, cae.odds, "time_printer_seed", nil, true)
		info_queue[#info_queue + 1] = { set = "Other", key = "crv_immutable" }
		return {
			vars = { num, den, cae.ante },
		}
	end,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.end_of_round and context.main_eval and SMODS.pseudorandom_probability(card, "time_printer_seed", 1, cae.odds, nil, true) and not context.blueprint then
			ease_ante(-cae.ante)
			RVF.msg(card, ("-" .. cae.ante .. " " .. localize("k_crv_ante")))
		end
	end,
})
-- leg

SMODS.Joker({
	key = "mega_printer", 
	atlas = "revo_mega_printer",
	rarity = 4,
	cost = 25,
	discovered = false,
	blueprint_compat = false,
	display_size = {w=128, h=95},
	pos = {
		x = 0,
		y = 0,
	},
	soul_pos = {
		x = 0,
		y = 1,
	},
	config = {
		extra = {
		},
	},
	attributes = {
		"printer",
		"joker",
		"generation",
	},
	loc_vars = function(self, info_queue, card)
	end,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.setting_blind and not context.blueprint then
			RVF.printer_create(card, {set = "Joker", area = G.jokers, rarity = "crv_printer"})
		end
	end,
	crv_credits = {
		art = "mr.cr33ps"
	}
})


SMODS.Joker({
	key = "legendary_printer", -- should i add printer badge idk
	atlas = "revo_jokers",
	rarity = 4,
	cost = 20,

	discovered = false,
	blueprint_compat = false,
	crv_cartridge_blacklist = {
		c_crv_mixed = true,
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
		"chance",
	},
	loc_vars = function(self, info_queue, card)
		local num, den = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "crv_legendary_seed")
		return {
			vars = { num, den },
		}
	end,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.setting_blind and not context.blueprint then
			if SMODS.pseudorandom_probability(card, "crv_legendary_seed", 1, cae.odds) then
				RVF.printer_create(
					card,
					{
						set = "Joker",
						area = G.jokers,
						edition = "e_negative",
						stickers = { "perishable" },
						legendary = true,
					}
				)
			end
		end
	end,
})
