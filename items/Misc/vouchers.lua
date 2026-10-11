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
	requires = { "v_crv_cartridge_extension" },
	redeem = function(self, card)
		local cae = card.ability.extra
		G.GAME.crv_cartridge_limit = G.GAME.crv_cartridge_limit + card.ability.extra.limit
	end,
})
