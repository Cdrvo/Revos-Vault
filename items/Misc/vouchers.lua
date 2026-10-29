SMODS.Voucher({
	key = "cartridge_extension",
	atlas = "revo_vouchers",
	pos = {
		x = 0,
		y = 0,
	},
	config = {
		extra = {
			limit = 1,
		},
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		return {
			vars = { cae.limit },
		}
	end,
	crv_credits = {
		art = { "mr.cr33ps" },
	},
	cost = 10,
	redeem = function(self, card)
		local cae = card.ability.extra
		G.GAME.crv_cartridge_limit = G.GAME.crv_cartridge_limit + card.ability.extra.limit
	end,
})

SMODS.Voucher({
	key = "quantum_cartridges",
	atlas = "revo_vouchers",
	pos = {
		x = 1,
		y = 0,
	},
	cost = 10,
	config = {
		extra = {
			limit = 1,
		},
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		return {
			vars = { cae.limit },
		}
	end,
	crv_credits = {
		art = { "mr.cr33ps" },
	},
	requires = { "v_crv_cartridge_extension" },
	redeem = function(self, card)
		local cae = card.ability.extra
		G.GAME.crv_cartridge_limit = G.GAME.crv_cartridge_limit + card.ability.extra.limit
	end,
})

-- Scrap set

SMODS.Voucher({
	key = "shredder",
	atlas = "revo_vouchers",
	pos = {
		x = 0,
		y = 1,
	},
	cost = 10,
	config = {
		extra = {
			odds = 3,
		},
	},
	loc_vars = function(self, info_queue, card)
		local num, den = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "burner_seed")
		return { vars = { num, den } }
	end,
	calculate = function(self, card, context)
		if
			context.selling_card
			and context.card.ability.set == "Joker"
			and SMODS.pseudorandom_probability(card, "shredder_seed", 1, card.ability.extra.odds)
		then
			SMODS.add_card({
				set = "crv_Scrap",
				area = G.consumeables,
				edition = "e_negative",
			})
		end
	end,
	redeem = function(self, card)
		local cae = card.ability.extra
	end,
})

SMODS.Voucher({
	key = "burner",
	atlas = "revo_vouchers",
	pos = {
		x = 1,
		y = 1,
	},
	requires = { "v_crv_shredder" },
	cost = 10,
	config = {
		extra = {
			odds = 3,
		},
	},
	loc_vars = function(self, info_queue, card)
		local num, den = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "burner_seed")
		return { vars = { num, den } }
	end,
	calculate = function(self, card, context)
		if
			context.selling_card
			and context.card.ability.consumeable
			and SMODS.pseudorandom_probability(card, "burner_seed", 1, card.ability.extra.odds)
		then
			SMODS.add_card({
				set = "crv_Scrap",
				area = G.consumeables,
				edition = "e_negative",
			})
		end
	end,
	redeem = function(self, card)
		local cae = card.ability.extra
	end,
})
