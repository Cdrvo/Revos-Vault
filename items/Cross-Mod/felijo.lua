SMODS.Atlas({
    key = "felisjokeria",
    path = "Cross-Mod/felisjokeria.png",
    px = 71,
    py = 95
})

SMODS.Joker({
	key = "peltprinter",
	atlas = "felisjokeria",
	rarity = "crv_p",
	cost = 10,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 0,
		y = 0,
	},
	config = {
		extra = {
			xmult = 1.5,
			odds = 4
		},
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_felijo_plt_wlf
		info_queue[#info_queue + 1] = G.P_CENTERS.m_felijo_plt_bny
        info_queue[#info_queue + 1] = G.P_CENTERS.m_felijo_plt_gold
		local cae = card.ability.extra
		local num, den = SMODS.get_probability_vars(card, 1, cae.odds, "general_printer_seed_cause_im_lazy")
		return {
			vars = { num, den },
		}
	end,
	add_to_deck = function(self, card, from_debuff)
		G.GAME.felijo_pelts_enabled = true
	end,
	calculate = function(self, card, context)
		if context.first_hand_drawn then
            local selected_pelt = pseudorandom_element({"m_felijo_plt_wlf", "m_felijo_plt_bny"})
			RevosVault.printer_apply(selected_pelt, "m_felijo_plt_gold", nil, nil, nil, "m_felijo_plt_olddata", nil)
		end
	end,
})
