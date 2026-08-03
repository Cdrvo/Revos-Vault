SMODS.Joker({
	key = "the_ace",
	config = {
		extra = {
			xmult = 2,
		},
	},
	rarity = 4,
	atlas = "revo_jokers",
	blueprint_compat = true,
	discovered = false,
	pos = {
		x = 1,
		y = 0,
	},
	soul_pos = {
		x = 0,
		y = 0,
	},
	attributes = {
		"xmult",
		"ace",
		"modify_card",
		"rank",
	},
	cost = 20,
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		return {
			vars = { cae.xmult },
		}
	end,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.individual and context.cardarea == G.play then
			if context.other_card:get_id() == 14 then
				return {
					xmult = cae.xmult,
				}
			end
		end
	end,
})

SMODS.Joker({
	key = "blueberry",
	rarity = 4,
	atlas = "revo_jokers",
	blueprint_compat = false,
	discovered = false,
	pos = {
		x = 3,
		y = 0,
	},
	soul_pos = {
		x = 2,
		y = 0,
	},
	attributes = {
		"enhancements",
		"modify_card",
	},
	cost = 20,
	loc_vars = function(self, info_queue, card) end,
	calculate = function(self, card, context)
		if context.final_scoring_step and not context.blueprint then
			for k, v in pairs(context.scoring_hand) do
				if v.config.center.key == "c_base" then
					RVF.cool_enhance(v, SMODS.poll_enhancement({ guaranteed = true }))
				end
			end
		end
	end,
})

SMODS.Joker({
	key = "pandik",
	rarity = 4,
	atlas = "revo_jokers",
	blueprint_compat = false,
	discovered = false,
	pos = {
		x = 5,
		y = 0,
	},
	soul_pos = {
		x = 4,
		y = 0,
	},
	attributes = {
		"generation",
	},
	cost = 20,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "crv_fixed_chances" }
		local numerator, denominator = SMODS.get_probability_vars(card, 1, 2, "crv_pandik_roll", nil, true)
		return {
			vars = { denominator, numerator },
		}
	end,
	calculate = function(self, card, context)
		if context.reroll_shop and not context.blueprint then
			if #G.consumeables.cards < G.consumeables.config.card_limit then
				SMODS.add_card({
					area = G.consumeables,
					set = "Consumeables",
				})
			end
		end
	end,
})

SMODS.Joker({
	key = "the_ant",
	config = {
		extra = {
			xmult = 2,
			xmultg = 0.05,
		},
	},
	rarity = 4,
	attributes = {
		"xmult",
		"scaling",
		"rank", -- technically?
	},
	atlas = "revo_jokers",
	blueprint_compat = true,
	discovered = false,
	pos = {
		x = 7,
		y = 0,
	},
	soul_pos = {
		x = 6,
		y = 0,
	},
	cost = 20,
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		return {
			vars = { cae.xmult, cae.xmultg },
		}
	end,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.individual and context.cardarea == G.play then
			if not context.other_card:is_face() and context.other_card:get_id() ~= 14 and not context.blueprint then
				cae.xmult = cae.xmult + cae.xmultg
				return {
					xmult = cae.xmult,
				}
			end
		end
	end,
})

SMODS.Joker({
	key = "shop_sign",
	atlas = "revo_jokers",
	rarity = 4,
	pos = { x = 3, y = 3 },
	soul_pos = { x = 0, y = 0 },
	attributes = {
		"passive"
	},
	soul_atlas = "shop_sign",
	calculate = function(self, card, context)
		if context.crv_pre_reroll and not context.blueprint then
				local a, b = {}, {}
				for k, v in pairs(G.shop_vouchers.cards) do
					if v.ability.set == "Voucher" then
						a[#a + 1] = v
					end
				end
				for k, v in pairs(G.shop_booster.cards) do
					if v.ability.set == "Booster" then
						b[#b + 1] = v
					end
				end
				SMODS.destroy_cards(a, {
					bypass_eternal = true,
					destroy_func = function(card, args)
						card:remove()
						card = nil
					end,
					immediate = true
				})
				SMODS.destroy_cards(b, {
					bypass_eternal = true,
					destroy_func = function(card, args)
						card:remove()
						card = nil
					end,
					immediate = true
				})
				for i = 1, G.shop_vouchers.config.card_limit do
					local v = pseudorandom_element(SMODS.get_clean_pool("Voucher"), pseudoseed("the_shop_sign_seed"))
					--SMODS.add_voucher_to_shop(v) // imagine
					local card = Card(G.shop_vouchers.T.x + G.shop_vouchers.T.w/2,
						G.shop_vouchers.T.y, G.CARD_W, G.CARD_H, G.P_CARDS.empty, G.P_CENTERS[v],{bypass_discovery_center = true, bypass_discovery_ui = true})
						card.shop_voucher = true
						create_shop_card_ui(card, 'Voucher', G.shop_vouchers)
						card:start_materialize()
						G.shop_vouchers:emplace(card)
				end

				for i = 1, G.shop_booster.config.card_limit do
					local v = pseudorandom_element(SMODS.get_clean_pool("Booster"), pseudoseed("the_shop_sign_seed"))
					SMODS.add_booster_to_shop(v)
				end
		end
	end,
})
