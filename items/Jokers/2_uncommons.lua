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
		"suit",
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
			card.ability.extra.chip_gain_total = card.ability.extra.chip_gain * clubs
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

SMODS.Joker({
	key = "red_utopia",
	atlas = "revo_jokers",
	rarity = 2,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 6,
		y = 10,
	},
	config = {
		extra = {
			xmult = 3,
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.xmult },
		}
	end,
	attributes = {
		"one",
		"two",
		"three",
		"four",
		"xmult",
	},
	crv_credits = {
		art = { "mr.cr33ps" },
	},
	calculate = function(self, card, context)
		if context.joker_main then
			local numbers, all_cards = 0, 0
			for k, v in ipairs(G.hand.cards) do
				all_cards = all_cards + 1
				if v:get_id() >= 2 and v:get_id() <= 4 then
					numbers = numbers + 1
				end
			end
			if numbers == all_cards then
				return {
					x_mult = card.ability.extra.xmult,
				}
			end
		end
	end,
})

SMODS.Joker({
	key = "whiteboard",
	atlas = "revo_jokers",
	rarity = 2,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 7,
		y = 9,
	},
	config = {
		extra = {
			xmult = 3,
		},
	},
	crv_credits = {
		art = { "mr.cr33ps" },
	},
	attributes = {
		"xmult",
		"suit",
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		return {
			vars = {
				cae.xmult,
				(G.GAME.current_round.crv_whiteboard_suit or "Spades"),
				colours = {
					G.C.SUITS[(G.GAME.current_round and G.GAME.current_round.crv_whiteboard_suit) or "Spades"],
				},
			},
		}
	end,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.joker_main then
			local suits, all_cards = 0, 0
			for k, v in ipairs(G.hand.cards) do
				all_cards = all_cards + 1
				if v:is_suit(G.GAME.current_round.crv_whiteboard_suit, true) then
					suits = suits + 1
				end
			end
			if suits == all_cards then
				return {
					x_mult = card.ability.extra.xmult,
				}
			end
		end
	end,
})

SMODS.Joker({
	key = "checkpoint",
	atlas = "revo_jokers",
	rarity = 2,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	pos = {
		x = 8,
		y = 9,
	},
	attributes = {
		"hands",
		"discards",
	},
	config = {
		extra = {},
	},
	crv_credits = {
		art = { "Chainsawmert" },
	},
	loc_vars = function(self, info_queue, card) end,
	calculate = function(self, card, context)
		if context.selling_self and not context.blueprint and G.GAME.blind and G.GAME.blind.in_blind then
			G.GAME.chips = G.GAME.chips / 2
			G.GAME.current_round.hands_left = G.GAME.current_round.hands_left + G.GAME.current_round.hands_played
			G.GAME.current_round.discards_left = G.GAME.current_round.discards_left + G.GAME.current_round.discards_used
		end
	end,
})

SMODS.Joker({
	key = "goldfish",
	atlas = "revo_jokers",
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	pos = {
		x = 9,
		y = 9,
	},
	config = {
		extra = {
			reps = 2,
		},
	},
	attributes = {
		"retrigger",
		"enhancements",
	},
	crv_credits = {
		art = { "Chainsawmert" },
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.reps },
		}
	end,
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play then
			if SMODS.has_enhancement(context.other_card, "m_gold") then
				return {
					repetitions = card.ability.extra.reps,
				}
			end
		end
	end,
})

SMODS.Joker({
	key = "jimbo_show",
	atlas = "revo_jokers",
	rarity = 2,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 0,
		y = 10,
	},
	config = {
		extra = {
			xmult = 1,
			xmultg = 0.05,
		},
	},
	attributes = {
		"scaling",
		"xmult",
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.xmult, card.ability.extra.xmultg },
		}
	end,

	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.joker_main then
			SMODS.scale_card(card, {
				ref_table = cae,
				ref_value = "xmult",
				scalar_value = "xmultg",
				message_colour = G.C.MULT,
			})
			return {
				xmult = card.ability.extra.xmult,
			}
		end
	end,
})

SMODS.Joker({
	key = "jnx",
	atlas = "revo_jokers",
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	rarity = 2,
	pos = {
		x = 1,
		y = 10,
	},
	config = {
		extra = {
			chips = 1,
			chipsg = 0.05,
		},
	},
	attributes = {
		"scaling",
		"xchips",
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.chips, card.ability.extra.chipsg },
		}
	end,

	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.joker_main then
			SMODS.scale_card(card, {
				ref_table = cae,
				ref_value = "chips",
				scalar_value = "chipsg",
				message_colour = G.C.CHIPS,
			})
			return {
				x_chips = card.ability.extra.chips,
			}
		end
	end,
})

SMODS.Joker({
	key = "the_hand",
	atlas = "wip",
	rarity = 2,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	pos = {
		x = 0,
		y = 0,
	},
	config = {
		extra = {},
	},
	attributes = {
		"destroy_card",
	},
	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint and G.jokers.cards[RVF.card_position(card).pos + 1] then
			local pos = RVF.card_position(card).pos
			local _card = G.jokers.cards[pos + 1]
			_card.ability.crv_the_hand_mark = true
			SMODS.destroy_cards(_card, { bypass_eternal = true, immediate = true })
			RVF.do_event(function()
				SMODS.calculate_context({ crv_handcheck = true, crv_card = card })
				return true
			end)
		end
		if context.crv_handcheck and context.crv_card == card and G.jokers.cards[RVF.card_position(card).pos + 1] then -- havent checked if works
			local pos = RVF.card_position(card).pos
			local _card = G.jokers.cards[pos + 1]
			if _card.ability.crv_the_hand_mark then
				print("force removed")
				_card.ability.crv_the_hand_mark:remove()
				_card.ability.crv_the_hand_mark = nil
			end
		end
	end,
})

SMODS.Joker({
	key = "stock_market",
	atlas = "revo_jokers",
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	rarity = 2,
	pos = {
		x = 2,
		y = 10,
	},
	config = {
		extra = {
			moneymult = 2,
			money = 1,
			odds = 4,
		},
	},
	attributes = {
		"scaling",
		"economy",
		"chance",
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		local num, den = SMODS.get_probability_vars(card, 1, cae.odds, "crv_stock_market_seed")
		return {
			vars = { cae.moneymult, cae.money, num, den },
		}
	end,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.end_of_round and context.main_eval and not context.blueprint then
			if SMODS.pseudorandom_probability(card, "crv_stock_market_seed", 1, cae.odds) then
				SMODS.reset_card(card, {
					ref_table = cae,
					ref_value = "money",
					reset_value = 1,
					message_colour = G.C.RED,
				})
			else
				SMODS.scale_card(card, {
					ref_table = cae,
					ref_value = "money",
					scalar_value = "moneymult",
					operation = "X",
					message_colour = G.C.GOLD,
				})
			end
		end
	end,
	calc_dollar_bonus = function(self, card)
		local cae = card.ability.extra
		return cae.money
	end,
})

SMODS.Joker({
	key = "love_letter",
	atlas = "revo_jokers",
	rarity = 2,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 3,
		y = 10,
	},
	config = {
		extra = {
			multg = 1,
			mult = 0,
		},
	},
	attributes = {
		"scaling",
		"mult",
		"suit",
		"hearts",
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.multg, card.ability.extra.mult },
		}
	end,

	calculate = function(self, card, context)
		if
			context.individual
			and context.cardarea == G.play
			and context.other_card:is_suit("Hearts")
			and not context.blueprint
		then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "mult",
				scalar_value = "multg",
				message_colour = G.C.RED,
			})
		end

		if context.joker_main then
			return {
				mult = card.ability.extra.mult,
			}
		end
	end,
})

SMODS.Joker({
	key = "biker",
	atlas = "revo_jokers",
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 4,
		y = 10,
	},
	config = {
		extra = {
			mult = 1,
		},
	},
	attributes = {
		"perma_bonus",
		"modify_card",
		"mult",
	},
	crv_credits = {
		art = { "rat" },
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		return {
			vars = { cae.mult },
		}
	end,

	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.individual and context.cardarea == G.play then
			context.other_card.ability.perma_mult = context.other_card.ability.perma_mult or 0
			context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + cae.mult
			return {
				message = localize("k_upgrade_ex"),
				colour = G.C.MULT,
				message_card = context.other_card,
			}
		end
	end,
})

SMODS.Joker({
	key = "banker",
	atlas = "revo_jokers",
	rarity = 2,
	cost = 0,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	pos = {
		x = 5,
		y = 10,
	},
	config = {
		extra = {
			owe = 5,
			owe_limit = 100,
			current_dept = 0,
		},
	},
	attributes = {
		"economy",
	},
	crv_credits = {
		art = { "kusanehexaku" },
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		return {
			vars = { cae.owe_limit, cae.owe, cae.current_dept },
		}
	end,
	add_to_deck = function(self, card, from_debuff)
		local cae = card.ability.extra
		card.ability.extra_value = -100 - card.sell_cost
		card:set_cost()
		ease_dollars(cae.owe_limit)
	end,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.end_of_round and context.main_eval and not context.blueprint then
			card.ability.extra_value = card.ability.extra_value + cae.owe
			cae.current_dept = cae.current_dept + cae.owe
			card:set_cost()
			ease_dollars(-cae.owe)
			RVF.msg(card, nil, "dollars", -cae.owe)
			if cae.current_dept >= cae.owe_limit then
				SMODS.destroy_cards(card)
			end
		end
	end,
})

SMODS.Joker({
	key = "tab_keeper",
	config = {
		extra = {
			stored = 0,
		},
	},
	rarity = 2,
	atlas = "revo_jokers",
	blueprint_compat = false,
	discovered = false,
	pos = {
		x = 7,
		y = 10,
	},
	attributes = {
		"economy",
		"reroll",
		"passive",
	},
	cost = 6,
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		return {
			vars = { cae.stored },
		}
	end,
	crv_credits = {
		art = { "mr.cr33ps" },
	},
	add_to_deck = function(self, card, from_debuff)
		G.GAME.current_round.crv_perma_free_rerolls = true
		calculate_reroll_cost(true)
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.GAME.current_round.crv_perma_free_rerolls = false
		local cae = card.ability.extra
		ease_dollars(-cae.stored)
	end,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.reroll_shop and not context.blueprint and not context.repetition then
			cae.stored = cae.stored + 5
		end
	end,
})

SMODS.Joker({
	key = "the_moon",
	atlas = "revo_jokers",
	rarity = 2,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	pos = {
		x = 8,
		y = 10,
	},
	config = {
		extra = {},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {},
		}
	end,
	attributes = {
		"modify_card",
		"suit",
		"hearts",
		"clubs",
		"spades",
		"diamonds",
	},
	crv_credits = {
		art = { "mr.cr33ps" },
	},
	calculate = function(self, card, context)
		if context.final_scoring_step and not context.blueprint then
			for k, v in ipairs(context.scoring_hand) do
				if v:is_suit("Hearts", true) then
					RVF.cool_enhance(v, function()
						assert(SMODS.change_base(v, "Spades", nil))
					end)
				end
				if v:is_suit("Diamonds", true) then
					RVF.cool_enhance(v, function()
						assert(SMODS.change_base(v, "Clubs", nil))
					end)
				end
			end
		end
	end,
})

SMODS.Joker({
	key = "the_night_rose",
	atlas = "wip",
	rarity = 2,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	pos = {
		x = 0,
		y = 0,
	},
	config = {
		extra = {},
	},
	attributes = {
		"modify_card",
		"suit",
		"hearts",
		"clubs",
		"spades",
		"diamonds",
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {},
		}
	end,
	crv_credits = {
		art = { "mr.cr33ps" },
	},
	calculate = function(self, card, context)
		if context.final_scoring_step and not context.blueprint then
			for k, v in ipairs(context.scoring_hand) do
				if v:is_suit("Spades", true) then
					RVF.cool_enhance(v, function()
						assert(SMODS.change_base(v, "Hearts", nil))
					end)
				end
				if v:is_suit("Clubs", true) then
					RVF.cool_enhance(v, function()
						assert(SMODS.change_base(v, "Diamonds", nil))
					end)
				end
			end
		end
	end,
})

SMODS.Joker({
	key = "stamp",
	atlas = "revo_jokers",
	rarity = 2,
	cost = 4,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	pos = {
		x = 0,
		y = 11,
	},
	attributes = {
		"seals",
		"modify_card",
	},
	calculate = function(self, card, context)
		if context.final_scoring_step and not context.blueprint then
			RVF.do_event(function()
				for k, v in ipairs(context.scoring_hand) do
					if not v.ability.seal then
						v:set_seal(
							SMODS.poll_seal({
								guaranteed = true,
							}),
							false,
							true
						)
					end
				end
				return true
			end)
		end
	end,
})

SMODS.Joker({
	key = "haunted_joker",
	atlas = "revo_jokers",
	rarity = 2,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	pos = {
		x = 1,
		y = 11,
	},
	attributes = {
		"generation",
		"joker",
	},
	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint then
			local jokers = {}
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] ~= card then
					jokers[#jokers + 1] = G.jokers.cards[i]
				end
			end
			if #jokers > 0 then
				local copy_joker = pseudorandom_element(jokers, pseudoseed("crv_haunted"))
				local copied_joker = SMODS.copy_card(copy_joker)
				copied_joker.ability.extra_slots_used = -1
				copied_joker:apply_status_effect("crv_temporary")
			end
		end
	end,
})

SMODS.Joker({
	key = "ketchup",
	atlas = "revo_jokers",
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 2,
		y = 11,
	},
	config = {
		extra = {
			mult = 25,
			xmult = 2,
		},
	},
	pools = {
		Food = true,
	},
	attributes = {
		"food",
		"mult",
		"xmult",
	},
	crv_credits = {
		art = { "Chainsawmert" },
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.mult, card.ability.extra.xmult },
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			if next(SMODS.find_card("j_crv_mayo")) then
				return {
					xmult = card.ability.extra.xmult,
				}
			else
				return {
					mult = card.ability.extra.mult,
				}
			end
		end
	end,
})
SMODS.Joker({
	key = "mayo",
	atlas = "revo_jokers",
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 3,
		y = 11,
	},
	config = {
		extra = {
			chips = 25,
			xchips = 2,
		},
	},
	pools = {
		Food = true,
	},
	attributes = {
		"food",
		"chips",
		"xchips",
	},
	crv_credits = {
		art = { "Chainsawmert" },
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.chips, card.ability.extra.xchips },
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			if next(SMODS.find_card("j_crv_ketchup")) then
				return {
					xmult = card.ability.extra.xchips,
				}
			else
				return {
					mult = card.ability.extra.chips,
				}
			end
		end
	end,
})

SMODS.Joker({
	key = "shadow_joker",
	atlas = "revo_jokers",
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 4,
		y = 11,
	},
	config = {
		extra_slots_used = -1,
		extra = {
			mult = 4,
		},
	},
	attributes = {
		"mult",
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.mult },
		}
	end,

	calculate = function(self, card, context)
		if context.joker_main then
			return {
				mult = card.ability.extra.mult,
			}
		end
	end,
	draw = function(self, card, layer)
		card.children.center:draw_shader("negative_shine", nil, card.ARGS.send_to_shader)
	end,
})

SMODS.Joker({
	key = "ascended_one",
	atlas = "revo_jokers",
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,

	pos = {
		x = 5,
		y = 11,
	},
	config = {
		extra = {
			multg = 5,
			mult = 0,
		},
	},
	attributes = {
		"spectral",
		"consumable",
		"scaling",
		"mult",
	},
	crv_credits = {
		art = { "mr.cr33ps" },
	},
	loc_vars = function(self, info_queue, card)
		if G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.spectral > 0 then
			return {
				vars = {
					card.ability.extra.multg,
					(card.ability.extra.mult + (G.GAME.consumeable_usage_total.spectral * card.ability.extra.multg)),
				},
			}
		else
			return {
				vars = { card.ability.extra.multg, card.ability.extra.mult },
			}
		end
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			if G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.spectral > 0 then
				return {
					mult = (G.GAME.consumeable_usage_total.spectral * card.ability.extra.multg),
				}
			end
		end
	end,
})

SMODS.Joker({
	key = "addiction",
	atlas = "revo_jokers",
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 6,
		y = 11,
	},
	config = {
		extra = {
			mult = 3,
			odds = 1,
		},
	},
	attributes = {
		"chance",
		"mult",
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		local num, den = SMODS.get_probability_vars(card, 1, cae.odds, "crv_addiction")
		return {
			vars = { card.ability.extra.mult, den, num },
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main and SMODS.pseudorandom_probability(card, "crv_addiction", 1, card.ability.extra.odds) then
			card.ability.extra.odds = card.ability.extra.odds + 1
			return {
				xmult = card.ability.extra.mult,
			}
		end
		if context.end_of_round and context.beat_boss then
			card.ability.extra.odds = 1
		end
	end,
})

SMODS.Joker({
	key = "shopmaster",
	atlas = "revo_jokers",
	rarity = 2,
	cost = 8,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	pos = {
		x = 7,
		y = 11,
	},
	attributes = {
		"passive",
		"shop",
	},
	config = {
		extra = {
			increase = 1,
		},
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		return {
			vars = { cae.increase },
		}
	end,
	add_to_deck = function(self, card, from_debuff)
		local cae = card.ability.extra
		change_shop_size(cae.increase)
	end,
	remove_from_deck = function(self, card, from_debuff)
		local cae = card.ability.extra
		change_shop_size(-cae.increase)
	end,
})

SMODS.Joker({
	key = "early_childhood",
	atlas = "revo_jokers",
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 0,
		y = 12,
	},
	config = {
		extra = {
			dollars = 3,
		},
	},
	attributes = {
		"economy",
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		return {
			vars = { cae.dollars },
		}
	end,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.individual and context.cardarea == G.play and not context.other_card:is_face() then
			return {
				dollars = cae.dollars,
			}
		end
	end,
})

SMODS.Joker({
	key = "everyone",
	atlas = "revo_jokers",
	rarity = 2,
	cost = 4,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 1,
		y = 12,
	},
	config = {
		extra = {
			mult = 3,
			chips = 6,
		},
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		return {
			vars = { cae.mult, cae.chips },
		}
	end,
	attributes = {
		"face",
		"mult",
		"chips",
	},
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.individual and context.cardarea == G.play then
			if context.other_card:is_face() then
				return {
					mult = cae.mult,
				}
			else
				return {
					chips = cae.chips,
				}
			end
		end
	end,
})

SMODS.Joker({
	key = "teen",
	atlas = "revo_jokers",
	rarity = 2,
	cost = 4,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 2,
		y = 12,
	},
	config = {
		extra = {
			rep = 1,
		},
	},
	attributes = {
		"jack",
		"retrigger",
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		return {
			vars = { cae.rep },
		}
	end,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.repetition and context.cardarea == G.play and context.other_card:get_id() == 11 then
			return {
				repetitions = cae.rep,
			}
		end
	end,
})

SMODS.Joker({
	key = "everyone_plus_ten",
	atlas = "revo_jokers",
	rarity = 2,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 3,
		y = 12,
	},
	config = {
		extra = {
			xmult = 2,
		},
	},
	attributes = {
		"ten",
		"xmult",
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		return {
			vars = { cae.xmult },
		}
	end,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.individual and context.cardarea == G.play and context.scoring_hand[1]:get_id() == 10 then
			return {
				xmult = cae.xmult,
			}
		end
	end,
})

SMODS.Joker({
	key = "mature",
	atlas = "revo_jokers",
	rarity = 2,
	cost = 4,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 4,
		y = 12,
	},
	config = {
		extra = {
			mult = 0,
			multg = 15,
		},
	},
	attributes = {
		"scaling",
		"reset",
		"mult",
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		return {
			vars = { cae.mult, cae.multg },
		}
	end,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.remove_playing_cards and not context.blueprint then
			SMODS.scale_card(card, {
				ref_table = cae,
				ref_value = "mult",
				scalar_value = "multg",
				message_colour = G.C.RED,
			})
		end
		if context.end_of_round and context.main_eval and context.beat_boss then
			SMODS.reset_card(card, {
				ref_table = cae,
				ref_value = "mult",
				reset_value = 0,
				message_colour = G.C.RED,
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
	key = "adults_only",
	atlas = "revo_jokers",
	rarity = 2,
	cost = 4,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 5,
		y = 12,
	},
	config = {
		extra = {
			chips = 50,
		},
	},
	attributes = {
		"face",
		"chips",
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		return {
			vars = { cae.chips },
		}
	end,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.joker_main then
			local faces = 0
			for k, v in ipairs(context.scoring_hand) do
				if v:is_face() then
					faces = faces + 1
				end
			end
			if faces > 0 then
				return {
					chips = cae.chips * faces,
				}
			end
		end
	end,
})

SMODS.Joker({
	key = "cookie_cats",
	atlas = "revo_jokers",
	rarity = 2,
	cost = 3,
	unlocked = true,
	discovered = true,
	pos = {
		x = 9,
		y = 8,
	},
	config = {
		extra = {
			xchips = 3,
		},
	},
	crv_credits = {
		art = { "Heaven" },
	},
	attributes = {
		"hearts",
		"xchips",
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		return {
			vars = { cae.xchips },
		}
	end,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.joker_main then
			local trigger = true
			for k, v in pairs(context.scoring_hand) do
				if v:is_suit("Hearts", true) then
					trigger = false
				end
			end
			if trigger then
				return {
					xchips = cae.xchips,
				}
			end
		end
	end,
})

SMODS.Joker({
	key = "sunrise",
	atlas = "revo_jokers",
	pos = { x = 8, y = 11 },
	rarity = 2,
	cost = 4,
	config = {
		extra = {
			rep = 1,
		},
	},
	attributes = {
		"retrigger",
		"hands",
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.rep },
		}
	end,
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play and G.GAME.current_round.hands_played == 0 then
			return {
				repetitions = card.ability.extra.rep,
			}
		end
	end,
})

SMODS.Joker({
	key = "7_ball",
	atlas = "revo_jokers",
	pos = { x = 9, y = 11 },
	rarity = 2,
	cost = 4,
	config = {
		extra = {
			odds = 6,
		},
	},
	attributes = {
		"spectral",
		"generation",
		"chance",
		"seven",
		"rank",
		"consumable",
	},
	loc_vars = function(self, info_queue, card)
		local num, den = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "7ball_seed")
		return {
			vars = { num, den },
		}
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and context.other_card:get_id() == 7 then
			if SMODS.pseudorandom_probability(card, "7ball_seed", 1, card.ability.extra.odds) then
				if RVF.has_room(G.consumeables) then
					SMODS.add_card({
						set = "Spectral",
					})
				else
					return {
						message = localize("no_room_ex"),
					}
				end
			end
		end
	end,
})

SMODS.Joker({
	key = "double_scythe",
	atlas = "revo_jokers",
	pos = { x = 6, y = 12 },
	rarity = 2,
	cost = 5,
	config = {
		extra = {
			dollars = 15,
		},
	},
	attributes = {
		"playing_card",
		"destroy_card",
		"economy",
	},
	blueprint_compat = false,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.dollars } }
	end,
	calculate = function(self, card, context)
		if
			context.destroy_card
			and (SMODS.get_enhancements(context.destroy_card)["m_crv_soul"] or context.destroy_card.ability.crv_soul)
			and context.cardarea == G.play
			and not context.blueprint
			and not context.destroy_card.ability.crv_marked_via_double_scythe
		then
			context.destroy_card.ability.crv_marked_via_double_scythe = true
			return {
				remove = true,
				dollars = card.ability.extra.dollars,
			}
		end
	end,
	in_pool = function(self)
		return RVF.find_enhancement("m_crv_soul")
	end,
})

SMODS.Joker({
	key = "grim_reaper",
	atlas = "revo_jokers",
	pos = { x = 7, y = 12 },
	blueprint_compat = false,
	rarity = 2,
	cost = 5,
	loc_vars = function(self, info_queue, card)
		return { vars = {} }
	end,
	attributes = {
		"generation",
		"playing_card",
	},
	calculate = function(self, card, context)
		if context.remove_playing_cards and not context.blueprint then
			local _card = SMODS.add_card({
				set = "Enhanced",
				area = G.deck,
				key = "m_crv_soul",
			})
			return {
				message = "!",
			}
		end
	end,
})

SMODS.Joker({
	key = "charcoal",
	atlas = "revo_jokers",
	pos = {
		x = 8,
		y = 12,
	},
	rarity = 2,
	blueprint_compat = false,
	cost = 4,
	attributes = {
		"enhancements",
		"modify_card",
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_crv_aflame
	end,
	calculate = function(self, card, context)
		if context.final_scoring_step and not context.blueprint then
			for k, v in pairs(context.scoring_hand) do
				if v.ability.set == "Default" then
					RVF.cool_enhance(v, "m_crv_aflame")
				end
			end
		end
	end,
})

SMODS.Joker({
	key = "birthday_cake",
	atlas = "revo_jokers",
	pos = {
		x = 9,
		y = 12,
	},
	rarity = 2,
	cost = 4,
	config = {
		extra = {
			mult = os.date("*t").day,
		},
	},
	attributes = {
		"mult",
	},
	crv_credits = {
		art = { "snayn3" },
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				mult = card.ability.extra.mult,
			}
		end
	end,
})

SMODS.Joker({ -- RUNES CONFIG
	key = "viking_joker",
	atlas = "revo_jokers",
	pos = {
		x = 0,
		y = 13,
	},
	config = {
		extra = {
			dollars = 3,
		},
	},
	attributes = {
		"consumable",
		"rune",
		"economy",
	},
	rarity = 2,
	cost = 4,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		return { vars = { cae.dollars } }
	end,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.end_of_round and context.main_eval then
			local a = 0
			for k, v in pairs(G.consumeables.cards) do
				if v and v.ability.set == "crv_Rune" then
					a = a + 1
				end
			end
			return {
				dollars = a * cae.dollars,
			}
		end
	end,
	crv_credits = {
		art = { "Breuhh" },
	},
})

SMODS.Joker({
	key = "snek",
	atlas = "revo_jokers",
	pos = {
		x = 1,
		y = 13,
	},
	config = {
		card_limit = 2,
		extra = {
			dollars = 3,
		},
	},
	attributes = {
		"passive",
	},
	rarity = 2,
	cost = 4,
	blueprint_compat = false,
	crv_credits = {
		art = { "isa" },
		idea = { "isa" },
	},
})

SMODS.Joker({
	key = "double_or_nothing",
	atlas = "wip",
	rarity = 2,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	pos = {
		x = 0,
		y = 0,
	},
	attributes = {
		"chance",
	},
	config = {
		extra = {
			odds = 2,
			can_use = true,
		},
	},
	loc_vars = function(self, info_queue, card)
		if card.ability.extra.can_use and G.GAME.current_round.hands_left == 1 then
			card.ability.extra.display_status = localize("s_crv_ready")
		else
			card.ability.extra.display_status = localize("s_crv_not_ready")
		end
		info_queue[#info_queue + 1] = { set = "Other", key = "crv_immutable" }
		local num, den =
			SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "crv_dobule_or_nothign", nil, true)
		return {
			vars = { num, den, card.ability.extra.display_status },
		}
	end,
	crv_use = function(self, card)
		card.ability.extra.can_use = false
		if SMODS.pseudorandom_probability(card, "crv_dobule_or_nothign", 1, card.ability.extra.odds, nil, true) then
			G.GAME.chips = G.GAME.chips * 2
			RVF.msg(card, localize("k_crv_double_ex"))
			if G.GAME.chips >= G.GAME.blind.chips then
				RVF.end_round() -- yay
			end
		else
			G.GAME.chips = 0
			RVF.msg(card, localize("k_crv_nothing_ex"))
		end
	end,
	crv_can_use = function(self, card)
		if
			G.GAME.blind
			and G.GAME.blind.in_blind
			and card.ability.extra.can_use
			and G.GAME.current_round.hands_left == 1
		then
			return true
		end
		return false
	end,
})

SMODS.Joker({
	key = "the_gambler",
	atlas = "wip",
	rarity = 2,
	cost = 4,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 0,
		y = 0,
	},
	config = {
		extra = {
			xmult = 1,
			xmultlg = 0.5,
			xmult_final = 3.5,
			odds = 2,
		},
	},
	attributes = {
		"xmult",
		"chance",
		"scaling",
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		local num, den = SMODS.get_probability_vars(card, 1, cae.odds, "tgm_seed")
		return {
			vars = {
				card.ability.extra.xmult,
				card.ability.extra.xmultlg,
				card.ability.extra.xmult_final,
				num,
				den,
			},
		}
	end,

	calculate = function(self, card, context)
		if context.joker_main then
			return {
				x_mult = card.ability.extra.xmult,
			}
		end
		if
			context.setting_blind
			and not context.blueprint
			and card.ability.extra.xmult < card.ability.extra.xmult_final
		then
			if SMODS.pseudorandom_probability(card, "tgm_seed", 1, card.ability.extra.odds) then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "xmult",
					scalar_value = "xmultlg",
				})
			else
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "xmult",
					scalar_value = "xmultlg",
					operation = "-",
					scaling_message = {
						message = localize("k_crv_downgrade"),
						colour = G.C.RED,
					},
				})
				if card.ability.extra.xmult <= 0 then
					SMODS.destroy_cards(card)
				end
			end
		end
	end,
})

SMODS.Joker({
	key = "glass_gun",
	rarity = 2,
	cost = 4,
	atlas = "revo_jokers",
	pos = { x = 3, y = 13 },
	soul_pos = { x = 4, y = 13 },
	discovered = true,
	blueprint_compat = false,
	crv_credits = {
		art = { "Heaven" },
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_crv_shattered
		return {
			vars = { card.ability.extra.multiply },
		}
	end,
	config = {
		extra = {
			multiply = 2,
		},
	},
	attributes = {
		"glass",
		"enhancement",
		"passive",
	},
	calculate = function(self, card, context)
		if context.remove_playing_cards and not context.blueprint then
			local _area, mat = G.deck, false
			if (G.hand and #G.hand.cards > 0) or (G.GAME.blind and G.GAME.blind.in_blind) then
				_area = G.hand
				mat = true
			end
			for _, pcard in ipairs(context.removed) do
				if SMODS.has_enhancement(pcard, "m_glass") then
					local acard = SMODS.copy_card(pcard, { area = _area })
					acard:set_ability(G.P_CENTERS.m_crv_shattered)
					if mat then
						acard.states.visible = nil
						G.E_MANAGER:add_event(Event({
							func = function()
								acard:start_materialize()
								return true
							end,
						}))
					end
				end
			end
		end
		if context.mod_probability and context.identifier == "glass" and not context.blueprint then
			return {
				denominator = context.denominator * card.ability.extra.multiply,
			}
		end
	end,
})

SMODS.Joker({
	key = "holographic_face",
	atlas = "revo_jokers",
	rarity = 2,
	cost = 1,
	unlocked = true,
	discovered = true,
	pos = {
		x = 5,
		y = 13,
	},
	soul_pos = {
		x = 6,
		y = 13,
	},
	loc_vars = function(self, info_queue, card)
		local crv = card.ability.extra
		return {
			vars = {},
		}
	end,
	draw = function(self, card, layer)
		card.children.center:draw_shader("hologram", nil, card.ARGS.send_to_shader)
	end,
	crv_use = function(self, card)
		G.CONTROLLER.locks.crv_holo_face = true
		for k, v in ipairs(G.hand.highlighted) do
			local card_rank, go_rank, smallest_face_id, smallest_face = v.base.id, nil, 11, nil
			for kk, vv in pairs(SMODS.Ranks) do
				if vv.id > card_rank and vv.face then
					go_rank = kk
				end
			end
			if not go_rank then
				for kk, vv in pairs(SMODS.Ranks) do
					if vv.id <= smallest_face_id and vv.face then
						smallest_face = kk
					end
				end
			end
			local final = nil
			final = go_rank or smallest_face
			if v:is_face() then
				RVF.cool_enhance(v, function()
					assert(SMODS.change_base(v, nil, final))
				end, nil, nil, nil, nil, nil, true)
			end

			if G.hand.highlighted[#G.hand.highlighted] == v then
				RVF.do_event(function() G.CONTROLLER.locks.crv_holo_face = nil return true end, nil, nil, 1)
				
			end
		end
	end,
	crv_can_use = function(self, card)
		local boolean = false
		if RVF.highlight(G.hand) and not G.CONTROLLER.locks.crv_holo_face then
			local _, area = RVF.highlight(G.hand)
			for k, v in pairs(area) do
				if v:is_face() then
					boolean = true
				end
			end
			return boolean
		end
		return false
	end,
})


-- i don't want to do quest master or whatever it is yet i hate that fucker