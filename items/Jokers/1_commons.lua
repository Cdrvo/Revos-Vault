SMODS.Joker({
	key = "ghostslices",
	atlas = "revo_jokers",
	rarity = 1,
	cost = 1,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 2,
		y = 1,
	},
	config = {
		extra = {
			chips = 50,
		},
	},
	attributes = {
		"chips",
		"food",
		"banana",
	},
	pools = {
		Food = true,
		Banana = true,
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.chips },
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				chips = card.ability.extra.chips,
			}
		end
	end,
	in_pool = function(self)
		return false
	end,
})

SMODS.Joker({
	key = "golden_banana",
	atlas = "revo_jokers",
	no_pool_flag = "crv_golden_nopool",
	rarity = 1,
	cost = 4,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	perishable_compat = false,
	eternal_compat = false,
	pos = {
		x = 1,
		y = 4,
	},
	config = {
		extra = {
			dollars = 2,
			odds = 3,
			odds2 = 6,
		},
	},
	attributes = {
		"banana",
		"food",
		"economy",
		"chance",
	},
	pools = {
		Food = true,
		BananaPool = true,
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		local num, den = SMODS.get_probability_vars(card, 1, cae.odds, "crv_golden_seed")
		local num2, den2 = SMODS.get_probability_vars(card, 1, cae.odds2, "crv_golden_seed")
		return {
			vars = { card.ability.extra.dollars, num, den, den2 },
		}
	end,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if
			context.individual
			and context.cardarea == G.play
			and SMODS.pseudorandom_probability(card, "crv_golden_seed", 1, cae.odds)
		then
			return {
				dollars = cae.dollars,
			}
		end
		if context.end_of_round and context.main_eval and not context.blueprint then
			if
				SMODS.pseudorandom_probability(card, "crv_golden_seed", 1, card.ability.extra.odds2)
				and not context.blueprint
			then
				SMODS.destroy_cards(card, { pinch_anim = true })
				G.GAME.pool_flags.crv_golden_nopool = true
				return {
					message = localize("k_extinct_ex"),
					delay(0.6),
				}
			else
				return {
					message = localize("k_safe_ex"),
					delay(0.6),
				}
			end
		end
	end,
})

SMODS.Joker({
	key = "daily_news",
	atlas = "revo_jokers",
	rarity = 1,
	cost = 3,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	pos = {
		x = 2,
		y = 4,
	},
	config = {
		extra = {
			odds = 4,
		},
	},
	attributes = {},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		local num, den = SMODS.get_probability_vars(card, 1, cae.odds, "news_seed")
		return {
			vars = { num, den },
		}
	end,

	calculate = function(self, card, context)
		local cae = card.ability.extra
		if
			context.end_of_round
			and context.main_eval
			and SMODS.pseudorandom_probability(card, "news_seed", 1, cae.odds)
			and not context.blueprint
		then
			RVF.add_tag("tag_coupon")
		end
	end,
})

SMODS.Joker({
	key = "henchman",
	atlas = "revo_jokers",
	cost = 3,
	rarity = 1,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 3,
		y = 4,
	},
	config = {
		extra = {
			mult = 6,
		},
	},
	attributes = {
		"mult",
	},
	crv_credits = {
		art = { "Astro" },
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		return {
			vars = { cae.mult },
		}
	end,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.joker_main then
			return {
				mult = cae.mult,
			}
		end
	end,
})

SMODS.Joker({
	key = "rekoj",
	atlas = "revo_jokers",
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	rarity = 1,
	pos = {
		x = 5,
		y = 4,
	},
	config = {
		extra = {
			chips = 40,
		},
	},
	attributes = {
		"chips",
	},
	crv_credits = {
		art = { "mr.cr33ps" },
	},
	loc_vars = function(self, info_queue, card)
		local crv = card.ability.extra
		return {
			vars = { crv.chips },
		}
	end,
	calculate = function(self, card, context)
		local crv = card.ability.extra
		if context.joker_main then
			return {
				chips = crv.chips,
			}
		end
	end,
})

SMODS.Joker({
	key = "collection",
	atlas = "revo_jokers",
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	rarity = 1,
	pos = {
		x = 6,
		y = 4,
	},
	config = {
		extra = {
			mult = 0,
			mult_gain = 1,
		},
	},
	attributes = {
		"mult",
		"scaling",
	},
	crv_credits = {
		art = { "mr.cr33ps" },
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		return {
			vars = { cae.mult, cae.mult_gain },
		}
	end,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.buying_card and not context.blueprint then
			SMODS.scale_card(card, {
				ref_table = cae,
				ref_value = "mult",
				scalar_value = "mult_gain",
				message_colour = G.C.MULT,
			})
		end
		if context.joker_main then
			return {
				mult = cae.mult,
			}
		end
	end,
})

SMODS.Joker({
	key = "bee",
	atlas = "revo_jokers",
	rarity = 1,
	cost = 4,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	pos = {
		x = 7,
		y = 4,
	},
	config = {
		extra = {
			dollars = 3,
		},
	},
	crv_credits = {
		art = { "Nyxel" },
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_crv_honey
		return {
			vars = { card.ability.extra.dollars },
		}
	end,
	calculate = function(self, card, context)
		if context.final_scoring_step and not context.blueprint then
			for k, v in pairs(context.scoring_hand) do
				if SMODS.has_enhancement(v, "m_crv_honey") then
					local sides = {}
					local pos, area = RVF.card_position(v, v.area).pos, v.area.cards
					if
						area[pos + 1]
						and not SMODS.has_enhancement(area[pos + 1], "m_crv_honey")
						and not v.honey_marked
					then
						sides[#sides + 1] = 1
					end
					if
						area[pos - 1]
						and not SMODS.has_enhancement(area[pos - 1], "m_crv_honey")
						and not v.honey_marked
					then
						sides[#sides + 1] = -1
					end
					if #sides > 0 then
						local p = (pseudorandom_element(sides, pseudoseed("crv_bee_seed")))
						RVF.cool_enhance(area[pos + p], "m_crv_honey")
						area[pos + p].honey_marked = true
					end
				end
			end
		end
		if context.after and not context.blueprint then
			for k, v in pairs(G.playing_cards) do
				if v.honey_marked then
					v.honey_marked = nil
				end
			end
		end
	end,
	in_pool = function(self)
		return RVF.find_enhancement("m_crv_honey")
	end,
})

SMODS.Joker({
	key = "do_a_barrel_roll",
	atlas = "revo_jokers",
	rarity = 1,
	cost = 2,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	pos = {
		x = 3,
		y = 7,
	},
	config = {
		extra_slots_used = -1,
	},
	attributes = {
		"passive",
	},
	crv_credits = {
		art = { "WombatCountry" },
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {},
		}
	end,
	calculate = function(self, card, context)
		if context.individual and (context.cardarea == G.play or context.cardarea == "unscored") then
			if context.other_card then
				context.other_card:flip()
				context.other_card:flip()
			end
		end
	end,
})

SMODS.Joker({
	key = "yellow_card",
	atlas = "revo_jokers",
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 4,
		y = 7,
	},
	config = {
		extra = {
			chips = 0,
			chip_gain = 15,
		},
	},
	attributes = {
		"chips",
		"scaling",
		"booster"
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		return {
			vars = { cae.chips, cae.chip_gain },
		}
	end,

	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.skipping_booster and not context.blueprint then
			card.ability.extra.skipped = true
		end
		if context.ending_booster and not context.blueprint then
			if not card.ability.extra.skipped then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "chips",
					scalar_value = "chip_gain",
					message_colour = G.C.CHIPS,
				})
			end
			card.ability.extra.skipped = false
		end
		if context.joker_main then
			return {
				chips = cae.chips,
			}
		end
	end,
})

SMODS.Joker({
	key = "emergency_button",
	atlas = "revo_jokers",

	rarity = 1,
	cost = 3,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	attributes = {
		"hands"
	},
	pos = {
		x = 5,
		y = 7,
	},
	config = {
		extra = {
			hands = 2,
		},
	},
	loc_vars = function(self, info_queue, card)
		local crv = card.ability.extra
		return {
			vars = { crv.hands },
		}
	end,
	calculate = function(self, card, context)
		local crv = card.ability.extra
		if context.selling_self and not context.blueprint and G.GAME.blind and G.GAME.blind.in_blind then
			ease_hands_played(card.ability.extra.hands)
		end
	end,
})


SMODS.Joker({
	key = "rainbow_octopus",
	atlas = "revo_jokers",
	pos = { x = 6, y = 7 },
	rarity = 1,
	cost = 6,
	config = {
		extra = {
			dollars = 2,
			odds = 2
		},
	},
	attributes = {
		"chance",
		"economy",
		"suit"
	},
	crv_credits = {
		art = {"Chainsawmert"}
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		local num, den = SMODS.get_probability_vars(card, 1, cae.odds, "rainbow_octopus_seed" )
		return {
			vars = { cae.dollars, (G.GAME.current_round.crv_rainbow_octopus_suit or "Spades"), num, den, colours = {G.C.SUITS[((G.GAME.current_round) and G.GAME.current_round.crv_rainbow_octopus_suit) or "Spades"]} },
		} 
	end,
	calculate = function(self, card, context)
		local cae = card.ability.extra 
		if context.individual and context.cardarea == G.play and SMODS.pseudorandom_probability(card, "rainbow_octopus_seed", 1, cae.odds) then
			if context.other_card:is_suit(G.GAME.current_round.crv_rainbow_octopus_suit) then
				return {
					dollars = cae.dollars,
				}
			end
		end
	end,
})


SMODS.Joker({
	key = "evil_joker",
	atlas = "revo_jokers",
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 7,
		y = 7,
	},
	config = {
		extra = {
			mult = 0,
			mult_gain = 3
		},
	},
	attributes = {
		"mult",
		"scaling",
		"joker"
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		return {
			vars = { cae.mult, cae.mult_gain},
		}
	end,

	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.joker_main and cae.mult>0 then
			return{
				mult = cae.mult
			}
		end
		if context.joker_type_destroyed and context.card ~= card and context.card.ability.set == "Joker" and not context.blueprint then
			SMODS.scale_card(card,{
				ref_table = cae,
				ref_value = "mult",
				scalar_value = "mult_gain",
				message_colour = G.C.MULT
			})
		end
	end,
})

SMODS.Joker({
	key = "rainbow",
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	atlas = "revo_jokers",
	pos = {
		x = 8,
		y = 7,
	},
	attributes = {
		"passive",
		"suit"
	},
	crv_credits = {
		art = {"Chainsawmert"}
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
	end,

	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.first_hand_drawn and not context.blueprint then
			local suits, list = {}, {}
			for k,v in pairs(G.hand.cards) do
				if not list[v.base.suit] then
					list[v.base.suit] = true
					suits[#suits+1] = v.base.suit
				end
			end
			local suit = pseudorandom_element(suits, pseudoseed("rianbow_suit_seed"))
			for k, v in pairs(G.hand.cards) do
				RVF.cool_enhance(v, function() assert(SMODS.change_base(v, suit, nil)) end, nil)
			end
		end
	end,
})

SMODS.Joker({
	key = "useless_joker",
	rarity = 1,
	cost = 1,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	atlas = "revo_jokers",
	pos = {
		x = 9,
		y = 7,
	},
	config = {
		extra = {
		},
	},
	set_ability = function(self, card, initial, delay_sprites)
		card:set_edition(poll_edition(nil, nil, nil, true), true, true)
	end,
	crv_credits = {
		art = {"lfmoth"},
		idea = {"theOfficialFem"}
	}
})