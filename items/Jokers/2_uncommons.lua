SMODS.Joker({
	key = "those_who_joke",
	atlas = "revo_jokers",
	rarity = 2,
	cost = 4,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,

	pos = {
		x = 7,
		y = 2,
	},
	config = {
		extra = {
			odds = 4,
		},
	},
	attributes = {
		"generation",
		"chance",
	},
	crv_credits = {
		art = { "Crazy Dave" },
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_mr_bones
		local cae = card.ability.extra
		local num, den = SMODS.get_probability_vars(card, 1, cae.odds, "j_thoose")
		return {
			vars = { num, den },
		}
	end,

	calculate = function(self, card, context)
		local crv = card.ability.extra
		if
			context.setting_blind
			and SMODS.pseudorandom_probability(card, "j_thoose", 1, crv.odds)
			and not context.blueprint
		then
			SMODS.add_card({
				key = "j_mr_bones",
				area = G.jokers,
				edition = "e_negative",
			})
			SMODS.destroy_cards(card)
		end
	end,
})

SMODS.Joker({
	key = "rain_rabbit",
	atlas = "revo_jokers",
	rarity = 2,
	cost = 4,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 9,
		y = 3,
	},
	config = {
		extra = {
			mult = 0,
			mult_gain = 10,
			hands = {},
			odds = 4,
		},
	},
	loc_vars = function(self, info_queue, card)
		local num, den = SMDOS.get_probability_vars(card, 1, card.ability.extra.odds, "crv_rain_seed")
		return { vars = { card.ability.extra.mult_gain, card.ability.extra.mult, num, den } }
	end,
	calculate = function(self, card, context)
		if
			context.initial_scoring_step
			and not context.blueprint
			and not card.ability.extra.hands[context.scoring_name]
		then
			card.ability.extra.hands[context.scoring_name] = true
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "mult",
				scalar_value = "mult_gain",
				message_colour = G.C.MULT,
			})
		end
		if context.joker_main then
			return {
				mult = card.ability.extra.mult,
			}
		end
		if
			context.end_of_round
			and context.main_eval
			and not context.blueprint
			and not RVF.card_position(card, card.area).inbetween
		then
			if SMODS.pseudorandom_probability(card, "crv_rain_seed", 1, card.ability.extra.odds) then
				SMODS.destroy_cards(card)
				return {
					message = localize("k_crv_destroyed"),
				}
			else
				return {
					message = localize("k_safe_ex"),
				}
			end
		end
		if context.ante_end and not context.blueprint then
			SMODS.reset_card(card, {
				ref_table = card.ability.extra,
				ref_value = "mult",
				reset_value = 0,
				message_colour = G.C.RED,
			})
		end
	end,
})

SMODS.Joker({
	key = "boss",
	atlas = "revo_jokers",
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	rarity = 2,
	pos = {
		x = 4,
		y = 4,
	},
	config = {
		extra = {
			xmult = 2,
		},
	},
	crv_credits = {
		art = { "Astro" },
	},
	attributes = {
		"xmult",
		"joker",
		"scaling",
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		local henchmans = 1
		if G.jokers and G.jokers.cards then
			for k, v in pairs(G.jokers.cards) do
				if v.config.center.key == "j_crv_henchman" then
					henchmans = henchmans + 1
				end
			end
		end
		return {
			vars = { cae.xmult, cae.xmult * henchmans },
		}
	end,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.joker_main then
			local henchmans = 1
			for k, v in pairs(G.jokers.cards) do
				if v.config.center.key == "j_crv_henchman" then
					henchmans = henchmans + 1
				end
			end
			return {
				xmult = cae.xmult * henchmans,
			}
		end
	end,
})

SMODS.Keybind({
	key_pressed = "f1",
	event = "pressed",
	action = function(self)
		SMODS.calculate_context({ crv_call_for_help = true })
	end,
})
SMODS.Joker({
	key = "spamton",
	atlas = "revo_jokers",
	rarity = 2,
	cost = 4,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	pos = {
		x = 2,
		y = 3,
	},
	config = {
		extra = {
			ready = true,
			hands = 2,
			discards = 1,
		},
	},
	crv_credits = {
		art = { "Nyxel" },
	},
	loc_vars = function(self, info_queue, card)
		local text = localize("s_crv_not_ready")
		if card.ability.extra.ready then
			text = localize("s_crv_ready")
		end
		return {
			vars = {
				card.ability.extra.hands,
				card.ability.extra.discards,
				text,
				colours = { (card.ability.extra.ready and G.C.GREEN) or G.C.RED },
			},
		}
	end,
	attributes = {
		"hands",
		"discards",
	},
	calculate = function(self, card, context)
		if
			context.crv_call_for_help
			and not context.blueprint
			and card.ability.extra.ready
			and G.GAME.blind
			and G.GAME.blind.in_blind
		then
			ease_hands_played(card.ability.extra.hands)
			ease_discard(card.ability.extra.discards)
			card.ability.extra.ready = false
		end
		if context.ante_end and not context.blueprint then
			card.ability.extra.ready = true
			return {
				message = localize("s_crv_ready"),
			}
		end
	end,
})

SMODS.Joker({
	key = "paperwork",
	config = {
		extra = {
			chips = 20.4,
			mult = 9.8,
		},
	},
	rarity = 2,
	atlas = "revo_jokers",
	blueprint_compat = true,
	discovered = false,
	pos = {
		x = 0,
		y = 8,
	},
	cost = 6,
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.chips, card.ability.extra.mult },
		}
	end,
	attributes = {
		"chips",
		"mult",
		"two",
		"three",
		"four",
		"five",
		"six",
		"seven",
		"eight",
		"nine",
	},
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card:get_id() >= 2 and context.other_card:get_id() <= 9 then
				return {
					chips = card.ability.extra.chips,
					mult = card.ability.extra.mult,
					card = card.other_card,
				}
			end
		end
	end,
})

SMODS.Joker({
	key = "plantain",
	atlas = "revo_jokers",
	no_pool_flag = "crv_plaintain_nopool",
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	perishable_compat = false,
	eternal_compat = false,
	pos = {
		x = 1,
		y = 8,
	},
	config = {
		extra = {
			timer = 0,
			timer_max = 3,
			xmult = 2,
			odds = 12,
		},
	},
	pools = {
		Food = true,
	},
	attributes = {
		"xmult",
		"chance",
		"banana",
		"food",
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		local num, den = SMODS.get_probability_vars(card, 1, cae.odds, "crv_plaintain_seed")
		return {
			vars = {
				card.ability.extra.timer,
				card.ability.extra.xmult,
				num,
				den,
				cae.timer_max,
			},
		}
	end,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.end_of_round and context.main_eval and not context.blueprint then
			if cae.timer >= cae.timer_max then
				if SMODS.pseudorandom_probability(card, "crv_plaintain_seed", 1, cae.odds) then
					SMODS.destroy_cards(card, { pinch_anim = true })
					G.GAME.pool_flags.crv_plaintain_nopool = true
					return {
						message = localize("k_extinct_ex"),
					}
				else
					return {
						message = localize("k_safe_ex"),
					}
				end
			else
				cae.timer = cae.timer + 1
				RVF.msg(card, "+1")
			end
		end
		if context.joker_main and cae.timer >= cae.timer_max then
			return {
				xmult = cae.xmult,
			}
		end
	end,
})

SMODS.Joker({
	key = "red_banana",
	atlas = "revo_jokers",
	no_pool_flag = "red_banana_nopool",
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	perishable_compat = false,
	eternal_compat = false,
	pos = {
		x = 2,
		y = 8,
	},
	config = {
		extra = {
			mult = 30,
			odds = 8,
		},
	},
	pools = {
		Food = true,
	},
	attributes = {
		"mult",
		"chance",
		"banana",
		"food",
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		local num, den = SMODS.get_probability_vars(card, 1, cae.odds, "red_banana_seed")
		return {
			vars = { card.ability.extra.mult, num, den },
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				mult = card.ability.extra.mult,
			}
		end
		if context.end_of_round and context.main_eval and not context.blueprint then
			if
				SMODS.pseudorandom_probability(card, "red_banana_seed", 1, card.ability.extra.odds)
				and not context.blueprint
			then
				SMODS.destroy_cards(card, { pinch_anim = true })
				G.GAME.pool_flags.red_banana_nopool = true
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
	key = "latundan",
	atlas = "revo_jokers",
	no_pool_flag = "latundan_nopool",
	rarity = 2,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	perishable_compat = false,
	eternal_compat = false,
	pos = {
		x = 3,
		y = 8,
	},
	config = {
		extra = {
			chips = 0,
			odds = 8,
			chip_gain = 15,
		},
	},
	display_size = { w = 47, h = 59 },

	pools = {
		Food = true,
	},
	attributes = {
		"xchips",
		"chance",
		"banana",
		"food",
		"scaling",
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		local num, den = SMODS.get_probability_vars(card, 1, cae.odds, "latundan_seed")
		return {
			vars = {
				card.ability.extra.chips,
				num,
				den,
				card.ability.extra.chip_gain,
			},
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				chips = card.ability.extra.chips,
			}
		end
		if context.end_of_round and context.main_eval and not context.blueprint then
			if not next(SMODS.find_card("j_gros_michel")) then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "chips",
					scalar_value = "chip_gain",
					message_colour = G.C.CHIPS,
				})
			end
			if SMODS.pseudorandom_probability(card, "latundan_seed", 1, card.ability.extra.odds) then
				SMODS.destroy_cards(card, { pinch_anim = true })
				G.GAME.no_pool_flag.latundan_nopool = true
				return {
					message = localize("k_extinct_ex"),
				}
			else
				return {
					message = localize("k_safe_ex"),
				}
			end
		end
	end,
})

SMODS.Joker({
	key = "ticking_banana",
	atlas = "revo_jokers",
	no_pool_flag = "tex",
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	perishable_compat = false,
	pos = {
		x = 4,
		y = 8,
	},
	config = {
		extra = {
			xmult = 15,
			timer = 0,
			max_timer = 3,
		},
	},
	pools = {
		Food = true,
	},
	attributes = {
		"xmult",
		"banana",
		"food",
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.xmult, card.ability.extra.timer, card.ability.extra.max_timer },
		}
	end,
	calculate = function(self, card, context)
		if
			context.end_of_round
			and context.main_eval
			and not context.blueprint
			and card.ability.extra.timer < card.ability.extra.max_timer
		then
			card.ability.extra.timer = card.ability.extra.timer + 1
			RVF.msg(card, "+1")
			if not card.ability.extra.juicing and card.ability.extra.timer >= card.ability.extra.max_timer then
				card.ability.extra.juicing = true
				local eval = function()
					return card.ability.extra.juicing
				end
				juice_card_until(card, eval, true)
			end
		end
		if context.joker_main then
			if card.ability.extra.timer == card.ability.extra.max_timer then
				card.ability.crv_destruction = true
				return {
					x_mult = card.ability.extra.xmult,
				}
			end
		end
		if context.after and not context.blueprint and card.ability.crv_destruction then
			SMODS.destroy_cards(card)
			return {
				message = localize("k_crv_boom_ex"),
			}
		end
	end,
	crv_credits = {
		art = "mr.cr33ps",
	},
})

SMODS.Joker({
	key = "uncanny_banana",
	config = {
		extra = {
			xmult = 15,
		},
	},
	pools = {
		Food = true,
	},
	rarity = 2,
	atlas = "revo_jokers",
	blueprint_compat = false,
	discovered = false,
	pos = {
		x = 5,
		y = 8,
	},
	attributes = {
		"banana",
		"food",
		"xmult",
	},
	cost = 4,
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.xmult },
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				x_mult = card.ability.extra.xmult,
			}
		end

		if context.end_of_round and context.main_eval and not context.blueprint then
			local a = math.random(1, 10)
			if a == 10 then
				RVF.cool_enhance(card, "j_crv_banana_of_doom")
				if not card.ability.eternal then
					card:add_sticker("eternal", true)
				else
					card.ability.crv_eternal_by_default = true
				end
			end
		end
	end,
	crv_credits = {
		art = "mr.cr33ps",
	},
})

SMODS.Joker({
	key = "banana_of_doom",
	config = {
		extra = {
			xmult = 15,
		},
	},
	pools = {
		Food = true,
	},
	rarity = 2,
	atlas = "revo_jokers",
	blueprint_compat = false,
	discovered = false,
	no_collection = true,
	pos = {
		x = 6,
		y = 8,
	},
	attributes = {
		"destroy_card",
		"banana",
		"food",
	},
	cost = 4,
	loc_vars = function(self, info_queue, card)
		return {}
	end,
	add_to_deck = function(self, card, from_debuff)
		card.ability.extra.satisfaction = math.random(1, 3)
	end,
	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint then
			card.ability.extra.satisfaction = card.ability.extra.satisfaction - 1
			local jokers = {}
			for k, v in pairs(G.jokers.cards) do
				if v ~= card and not v.getting_sliced then
					jokers[#jokers + 1] = v
				end
			end
			local card_to_destroy = pseudorandom_element(jokers, pseudoseed("banana_of_seeds"))
			if card_to_destroy then
				SMODS.destroy_cards(card_to_destroy)
			end

			if card.ability.extra.satisfaction <= 0 then
				RVF.cool_enhance(card, "j_crv_uncanny_banana")
				if not card.ability.crv_eternal_by_default then
					card:remove_sticker("eternal")
				end
			end
		end
	end,
	in_pool = function(self)
		return false
	end,
})

SMODS.Joker({
	key = "banana_template",
	atlas = "revo_jokers",
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	perishable_compat = false,
	pos = {
		x = 7,
		y = 8,
	},
	config = {
		extra = {
			timer = 0,
			timer_max = 3,
		},
	},
	pools = {
		Food = true,
	},
	attributes = {
		"banana",
		"food",
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.timer, card.ability.extra.timer_max },
		}
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval and not context.blueprint then
			if card.ability.extra.timer < card.ability.extra.timer_max then
				card.ability.extra.timer = card.ability.extra.timer + 1
				RVF.msg(card, "+1")
				if card.ability.extra.timer == card.ability.extra.timer_max then
					local banana_list = SMODS.get_attribute_pool("banana")
					if #banana_list > 0 then
						local selected_banana = pseudorandom_element(banana_list, pseudoseed("random_banana_seed"))
						RVF.cool_enhance(card, selected_banana)
					end
				end
			end
		end
	end,
	crv_credits = {
		art = "mr.cr33ps",
	},
})

SMODS.Joker({
	key = "jimbanana",
	atlas = "revo_jokers",
	no_pool_flag = "jimbanana_nopool",
	rarity = 2,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	perishable_compat = false,
	eternal_compat = false,
	pos = {
		x = 8,
		y = 8,
	},
	config = {
		extra = {
			mult = 8,
			odds = 6,
		},
	},
	pools = {
		Food = true,
	},
	attributes = {
		"banana",
		"food",
		"mult",
		"chance",
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		local num, den = SMODS.get_probability_vars(card, 1, cae.odds, "jim_seed")
		return {
			vars = { card.ability.extra.mult, den, num },
		}
	end,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.joker_main then
			return {
				mult = cae.mult,
			}
		end
		if context.end_of_round and context.main_eval and not context.blueprint then
			if SMODS.pseudorandom_probability(card, "jim_seed", 1, cae.odds) then
				SMODS.destroy_cards(card, { pinch_anim = true })
				G.GAME.pool_flags.jimbanana_nopool = true
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
	key = "grosdish",
	atlas = "revo_jokers",
	no_pool_flag = "crv_grosdish_nopool",
	rarity = 2,
	cost = 3,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	perishable_compat = false,
	eternal_compat = false,
	pos = {
		x = 3,
		y = 9,
	},
	config = {
		extra = {
			chips = 30,
			odds = 6,
		},
	},
	attributes = {
		"banana",
		"food",
		"chips",
		"chance",
	},
	pools = {
		Food = true,
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		local num, den = SMODS.get_probability_vars(card, 1, cae.odds, "grosdish_seed")
		return {
			vars = { card.ability.extra.chips, num, den },
		}
	end,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.joker_main then
			return {
				chips = cae.chips,
			}
		end
		if context.end_of_round and context.main_eval and not context.blueprint then
			if SMODS.pseudorandom_probability(card, "jim_seed", 1, cae.odds) then
				SMODS.destroy_cards(card, { pinch_anim = true })
				G.GAME.pool_flags.crv_grosdish_nopool = true
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
	key = "cavicheal",
	atlas = "revo_jokers",
	no_pool_flag = "crv_cavicheal_nopool",
	yes_pool_flag = "crv_grosdish_nopool",
	rarity = 2,
	cost = 4,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	perishable_compat = false,
	eternal_compat = false,
	pos = {
		x = 4,
		y = 9,
	},
	config = {
		extra = {
			xchips = 3,
			odds = 1000,
		},
	},
	pools = {
		Food = true,
	},
	attributes = {
		"banana",
		"food",
		"xchips",
		"chance",
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		local num, den = SMODS.get_probability_vars(card, 1, cae.odds, "cavicheal_seed")
		return {
			vars = { card.ability.extra.xchips, num, den },
		}
	end,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.joker_main then
			return {
				xchips = cae.xchips,
			}
		end
		if context.end_of_round and context.main_eval and not context.blueprint then
			if SMODS.pseudorandom_probability(card, "cavicheal_seed", 1, cae.odds) then
				SMODS.destroy_cards(card, { pinch_anim = true })
				G.GAME.pool_flags.crv_cavicheal_nopool = true
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
	key = "reinforced_glass_joker",
	config = {
		extra = {
			xmult = 0.4,
		},
	},

	rarity = 2,
	atlas = "revo_jokers",
	blueprint_compat = true,
	discovered = false,
	pos = {
		x = 5,
		y = 9,
	},
	attributes = {
		"xmult",
		"full_deck",
		"enhancements",
	},
	cost = 6,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_crv_reinforced_glass
		return {
			vars = {
				card.ability.extra.xmult * RVF.owned_enhancements("m_crv_reinforced_glass") + 1,
				card.ability.extra.xmult,
				RVF.owned_enhancements("m_crv_reinforced_glass"),
			},
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			if RVF.owned_enhancements("m_crv_reinforced_glass") > 0 then
				return {
					x_mult = RVF.owned_enhancements("m_crv_reinforced_glass") * card.ability.extra.xmult + 1,
				}
			end
		end
	end,
	in_pool = function(self)
		if RVF.owned_enhancements("m_crv_reinforced_glass") > 0 then
			return true
		end
		return false
	end,
})

SMODS.Joker({
	key = "diamond_joker",
	config = {
		extra = {
			xmult = 0.3,
		},
	},
	attributes = {
		"xmult",
		"full_deck",
		"enhancements",
	},
	rarity = 2,
	atlas = "revo_jokers",
	blueprint_compat = true,
	discovered = false,
	pos = {
		x = 6,
		y = 9,
	},
	cost = 6,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_crv_diamond
		return {
			vars = {
				card.ability.extra.xmult * RVF.owned_enhancements("m_crv_diamond") + 1,
				card.ability.extra.xmult,
				RVF.owned_enhancements("m_crv_diamond"),
			},
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			if RVF.owned_enhancements("m_crv_diamond") > 0 then
				return {
					x_mult = RVF.owned_enhancements("m_crv_diamond") * card.ability.extra.xmult + 1,
				}
			end
		end
	end,
	in_pool = function(self)
		if RVF.owned_enhancements("m_crv_diamond") > 0 then
			return true
		end
		return false
	end,
})

SMODS.Joker({
	key = "flytrap",
	atlas = "revo_jokers",
	rarity = 2,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 2,
		y = 9,
	},
	config = {
		extra = {
			chip_gain = 10,
			chips = 0,
		},
	},
	attributes = {
		"chips",
		"clubs",
		"scaling",
		"suit"
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.chip_gain, card.ability.extra.chips },
		}
	end,

	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			local clubs = 0
			for k, v in pairs(context.scoring_hand) do
				if v:is_suit("Clubs") then
					clubs = clubs + 1
				end
			end
			card.ability.extra.chip_gain_total = card.ability.extra.chip_gain*clubs
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "chips",
				scalar_value = "chip_gain_total",
				message_colour = G.C.CHIPS,
			})
			card.ability.extra.chip_gain_total = 0
		end

		if context.joker_main then
			return {
				chips = card.ability.extra.chips,
			}
		end
	end,
})
