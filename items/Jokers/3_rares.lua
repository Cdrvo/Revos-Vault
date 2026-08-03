SMODS.Joker({
	key = "bocchi",
	atlas = "revo_jokers",
	rarity = 3,
	cost = 6,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 0,
		y = 1,
	},
	attributes = {
		"xmult",
	},
	config = {
		extra = {
			xmult = 0.5,
			allcards = 0,
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.allcards, card.ability.extra.xmult },
		}
	end,

	calculate = function(self, card, context)
		if context.joker_main then
			if #G.hand.cards > 0 then
				return {
					xmult = (card.ability.extra.xmult * #G.hand.cards + 1),
				}
			end
		end
	end,
})

SMODS.Joker({
	key = "ghost_banana",
	atlas = "revo_jokers",
	rarity = 3,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = false,
	no_pool_flag = "crv_ghost_nopool",
	pools = {
		Food = true,
		Banana = true,
	},
	pos = {
		x = 1,
		y = 1,
	},
	config = {
		extra = {
			xchips = 3,
			odds = 6,
			split_into = 3,
		},
	},
	attributes = {
		"xchips",
		"food",
		"chance",
		"banana",
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_crv_ghostslices
		local num, den = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "crv_ghost_odds")
		return {
			vars = { card.ability.extra.xchips, num, den, card.ability.extra.split_into },
		}
	end,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.joker_main then
			return {
				xchips = card.ability.extra.xchips,
			}
		end
		if context.end_of_round and context.main_eval and not context.blueprint then
			if SMODS.pseudorandom_probability(card, "crv_ghost_odds", 1, cae.odds) then
				SMODS.destroy_cards(card, { pinch_anim = true })
				for i = 1, cae.split_into do
					SMODS.add_card({ key = "j_crv_ghostslices", edition = "e_negative" })
				end
				G.GAME.pool_flags.crv_ghost_nopool = true
				return {
					message = localize("k_crv_split"),
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
	key = "plain_banana",
	atlas = "revo_jokers",
	no_pool_flag = "crv_plain_nopool",
	rarity = 3,
	cost = 8,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	perishable_compat = false,
	eternal_compat = false,
	pos = {
		x = 3,
		y = 1,
	},
	pools = {
		Food = true,
		Banana = true,
	},
	attributes = {
		"economy",
		"food",
		"chance",
		"sell_value",
		"scaling",
		"banana",
	},
	config = {
		extra = {
			inc = 15,
			odds = 2,
		},
	},
	loc_vars = function(self, info_queue, card)
		local num, den = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "gban_seed")
		return {
			vars = { card.ability.extra.inc, num, den },
		}
	end,
	calculate = function(self, card, context)
		if context.setting_blind then
			if
				SMODS.pseudorandom_probability(card, "gban_seed", 1, card.ability.extra.odds)
				and not context.blueprint
			then
				SMODS.destroy_cards(card, { pinch_anim = true })
				G.GAME.pool_flags.crv_plain_nopool = true
				return {
					message = localize("k_extinct_ex"),
					delay(0.6),
				}
			else
				card.ability.extra_value = (card.ability.extra_value or 0) + card.ability.extra.inc
				card:set_cost()
				return {
					message = localize("k_val_up"),
					delay(0.6),
				}
			end
		end
	end,
})

SMODS.Joker({
	key = "mathematician",
	config = {
		extra = {
			xmult = 3.14,
		},
	},
	rarity = 3,
	cost = 6,
	atlas = "revo_jokers",
	blueprint_compat = true,
	discovered = false,
	attributes = {
		"xmult",
		"three",
		"rank",
	},
	pos = {
		x = 4,
		y = 1,
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.xmult },
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			for k, v in ipairs(context.scoring_hand) do
				if v:get_id() == 3 then
					return {
						x_mult = card.ability.extra.xmult,
					}
				end
			end
		end
	end,
})

SMODS.Joker({
	key = "moon_lord",
	atlas = "revo_jokers",
	rarity = 3,
	cost = 7,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	attributes = {
		"xmult",
	},
	pos = {
		x = 6,
		y = 1,
	},
	empress_atlas = "crv_eol",
	config = {
		extra = {
			xmult = 5,
			dcard = nil,
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.xmult },
		}
	end,
	calculate = function(self, card, context)
		if context.setting_blind and not context.repetition and not context.blueprint then
			local jokers = {}
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] ~= card then
					jokers[#jokers + 1] = G.jokers.cards[i]
				end
			end
			if #jokers > 1 then
				if not context.blueprint then
					local chosen_joker = pseudorandom_element(jokers, pseudoseed("ml"))
					if chosen_joker then
						SMODS.debuff_card(chosen_joker, true, "jimlord_debuff")
						card.ability.extra.dcard = chosen_joker
					end
				end
			end
		end
		if context.end_of_round and context.main_eval and not context.blueprint and card.ability.extra.dcard then
			SMODS.debuff_card(card.ability.extra.dcard, false, "jimlord_debuff")
			card.ability.extra.dcard = nil
		end
		if context.joker_main then
			return {
				x_mult = card.ability.extra.xmult,
			}
		end
	end,
})

SMODS.Joker({
	key = "empress_of_light",
	atlas = "revo_jokers",
	rarity = 3,
	cost = 7,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	crv_modicon_compatible = false,
	pos = {
		x = 6,
		y = 1,
	},
	empress_atlas = "crv_eol",
	attributes = {
		"xmult",
	},
	config = {
		extra = {
			xmult = 3,
			xmult2 = 1.5,
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.xmult, card.ability.extra.xmult2 },
		}
	end,

	calculate = function(self, card, context)
		if context.joker_main then
			local rr = RVF.card_position(card)

			if rr.inbetween then
				return {
					x_mult = card.ability.extra.xmult2,
				}
			else
				return {
					x_mult = card.ability.extra.xmult,
				}
			end
		end
	end,
})

SMODS.Joker({
	key = "jarden",
	atlas = "revo_jokers",
	rarity = 3,
	cost = 10,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 7,
		y = 1,
	},
	attributes = {
		"xmult",
		"scaling",
		"reset",
	},
	config = {
		extra = {
			xmult = 1,
			xmult_gain = 0.5,
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.xmult_gain, card.ability.extra.xmult },
		}
	end,

	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.joker_main then
			return {
				xmult = cae.xmult,
			}
		end
		if context.selling_card and context.card ~= card and not context.blueprint then
			cae.xmult = 1
			return {
				message = localize("k_reset"),
			}
		end
		if context.end_of_round and not context.blueprint and context.main_eval then
			SMODS.scale_card(card, {
				ref_table = cae,
				ref_value = "xmult",
				scalar_value = "xmult_gain",
				message_colour = G.C.RED,
			})
		end
	end,
})

SMODS.Joker({
	key = "kings_impact",
	atlas = "revo_jokers",
	rarity = 3,
	cost = 8,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 8,
		y = 1,
	},
	attributes = {
		"rank",
		"modify_card",
	},
	config = {
		extra = {},
	},
	crv_credits = {
		art = { "mr.cr33ps" },
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {},
		}
	end,

	calculate = function(self, card, context)
		if context.final_scoring_step and not context.blueprint then
			for k, v in pairs(context.scoring_hand) do
				local mcard = v
				if v.base.id ~= 13 then
					RVF.cool_enhance(v, function()
						if mcard.base.id > 13 then
							SMODS.modify_rank(mcard, -1)
						elseif mcard.base.id < 13 then
							SMODS.modify_rank(mcard, 1)
						end
					end)
				end
			end
		end
	end,
})

SMODS.Joker({
	key = "dr_jimbo",
	config = {
		extra = {
			xmult = 1,
			xmult_gain = 0.25,
		},
	},
	rarity = 3,
	atlas = "revo_jokers",
	blueprint_compat = true,
	discovered = false,
	pos = {
		x = 9,
		y = 1,
	},
	attributes = {
		"scaling",
		"modify_card",
		"xmult",
	},
	cost = 7,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
		return {
			vars = { card.ability.extra.xmult, card.ability.extra.xmult_gain },
		}
	end,
	calculate = function(self, card, context)
		if context.final_scoring_step and not context.blueprint then
			for k, v in pairs(context.scoring_hand) do
				if SMODS.has_enhancement(v, "m_stone") then
					RVF.cool_enhance(v, "c_base", true)
					SMODS.scale_card(card, {
						ref_table = card.ability.extra,
						ref_value = "xmult",
						scalar_value = "xmult_gain",
						message_colour = G.C.RED,
					})
				end
			end
		end
		if context.joker_main then
			return {
				x_mult = card.ability.extra.xmult,
			}
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return true
	end,
})

SMODS.Joker({
	key = "clicker",
	config = {
		extra = {
			clicks = 0,
			chips = 0,
			chipgain = 0.5,
		},
	},
	rarity = 3,
	atlas = "revo_jokers",
	blueprint_compat = false,
	discovered = false,
	no_collection = false,
	pos = {
		x = 0,
		y = 2,
	},
	attributes = {
		"scaling",
		"chips",
	},
	cost = 6,
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		return {
			vars = { cae.clicks, cae.chips, cae.chipgain },
		}
	end,
	crv_clicked = function(self, card)
		local cae = card.ability.extra
		cae.clicks = cae.clicks + 1
		SMODS.scale_card(card, {
			ref_table = cae,
			ref_value = "chips",
			scalar_value = "chipgain",
			scaling_message = {},
		})
	end,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.joker_main then
			return {
				chips = cae.chips,
			}
		end
	end,
})

SMODS.Joker({
	key = "giftbox",
	atlas = "revo_jokers",
	rarity = 3,
	cost = 8,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	pos = {
		x = 1,
		y = 2,
	},
	config = {
		extra = {
			timer = 0,
			timer_max = 3,
		},
	},
	attributes = {
		"generation",
		"on_sell",
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		return {
			vars = { cae.timer, cae.timer_max },
		}
	end,
	crv_credits = {
		art = { "mr.cr33ps" },
	},
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.end_of_round and context.main_eval and not context.blueprint and cae.timer < cae.timer_max then
			cae.timer = cae.timer + 1
			RVF.msg(
				card,
				(cae.timer < cae.timer_max and (cae.timer .. "/" .. cae.timer_max)) or localize("k_active_ex")
			)
			if cae.timer == cae.timer_max then
				local eval = function()
					return card.ability.extra.timer == cae.timer_max
				end
				juice_card_until(card, eval, true)
			end
		end
		if context.selling_self and cae.timer >= 3 then
			if RVF.has_room(G.jokers, ((card.ability.card_limit > 0 and 0) or 1), true) >= 2 then
				local a = SMODS.add_card({
					set = "Joker",
					area = G.jokers,
					rarity = 0,
				})
				a:add_sticker("eternal", true)
				SMODS.add_card({
					set = "Joker",
					area = G.jokers,
					legendary = true,
				})
			else
				return {
					message = localize("k_no_room_ex"),
				}
			end
		end
	end,
})

SMODS.Joker({
	key = "killer_queen",
	atlas = "revo_jokers",
	rarity = 3,
	cost = 8,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 2,
		y = 2,
	},
	config = {
		extra = {
			xmult = 1,
			xmult_gain = 0.75,
		},
	},
	crv_credits = {
		art = { "Chainsawmert" },
	},
	attributes = {
		"xmult",
		"scaling",
		"modify_card",
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_crv_bomb
		return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_gain } }
	end,
	calculate = function(self, card, context)
		if context.final_scoring_step and not context.blueprint then
			if
				G.play
				and #G.play.cards > 0
				and not SMODS.has_enhancement(G.play.cards[#G.play.cards], "m_crv_bomb")
			then
				RVF.cool_enhance(G.play.cards[#G.play.cards], "m_crv_bomb")
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "xmult",
					scalar_value = "xmult_gain",
					message_colour = G.C.RED,
				})
			end
		end
		if context.joker_main then
			return {
				xmult = card.ability.extra.xmult,
			}
		end
	end,
})

SMODS.Joker({
	key = "copycat",
	atlas = "revo_jokers",
	rarity = 3,
	cost = 8,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	pos = {
		x = 3,
		y = 2,
	},
	config = {
		extra = {},
	},
	attributes = {
		--???
	},
	loc_vars = function(self, info_queue, card) end,

	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint then
			RVF.cool_enhance(card, function()
				local copy_table, copy = {}, nil
				for k, v in pairs(G.jokers.cards) do
					if v ~= card then
						copy_table[#copy_table + 1] = v
					end
				end
				if #copy_table > 0 then
					copy = pseudorandom_element(copy_table, pseudoseed("copycat_random"))
				end

				if copy then
					copy = copy.config.center.key
					card:set_ability(copy)
					card.ability.crv_copycat = true
				end
			end)
		end
	end,
})

SMODS.Joker({
	key = "furnace",
	config = {
		extra = {
			odds = 3,
			xmult_add = 0.5,
		},
	},
	rarity = 3,
	atlas = "revo_jokers",
	blueprint_compat = false,
	discovered = false,
	pos = {
		x = 4,
		y = 2,
	},
	cost = 7,
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		local n, d = SMODS.get_probability_vars(card, 1, cae.odds, "furnace_seed")
		return {
			vars = { cae.xmult_add, n, d },
		}
	end,
	attributes = {
		"xmult",
		"scaling",
		"destroy_card",
		"perma_bonus",
		"modify_card",
	},
	calculate = function(self, card, context)
		if context.final_scoring_step and not context.blueprint then
			for k, v in pairs(context.scoring_hand) do
				v.ability.perma_xmult = v.ability.perma_xmult or 1
				if SMODS.pseudorandom_probability(card, "furnace_seed", 1, card.ability.extra.odds) then
					SMODS.destroy_cards(v)
				else
					SMODS.scale_card(v, {
						ref_table = v.ability,
						ref_value = "perma_x_mult",
						scalar_table = card.ability.extra,
						scalar_value = "xmult_add",
						message_colour = G.C.RED,
					})
				end
			end
		end
	end,
})

SMODS.Joker({
	key = "tax_master",
	atlas = "revo_jokers",
	rarity = 3,
	cost = 8,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	pos = {
		x = 5,
		y = 2,
	},
	config = {
		extra = {
			precentage = 30,
		},
	},
	attributes = {
		"economy",
	},
	crv_credits = {
		art = { "WombatCountry" },
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.precentage },
		}
	end,

	calculate = function(self, card, context)
		if context.buying_card and context.card and not context.blueprint then
			local from, final = context.card.cost, nil
			final = math.ceil((from / 100) * card.ability.extra.precentage)
			ease_dollars(final)
		end
	end,
})

SMODS.Joker({
	key = "nyancat",
	atlas = "revo_jokers",
	rarity = 3,
	cost = 7,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	pos = {
		x = 6,
		y = 2,
	},
	config = {
		extra = {},
	},
	attributes = {
		"modify_card",
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {},
		}
	end,
	calculate = function(self, card, context)
		if context.final_scoring_step and not context.blueprint then
			for k, v in ipairs(context.scoring_hand) do
				if not v.edition and not v.ability.polychrome then
					RVF.cool_enhance(v, function()
						v:set_edition({ polychrome = true }, true)
					end, true, nil, true)
				end
			end
		end
	end,
})

SMODS.Joker({
	key = "ace_questionmark",
	atlas = "revo_jokers",
	rarity = 3,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,

	pos = {
		x = 8,
		y = 2,
	},
	config = {
		extra = {
			rep = 2,
		},
	},
	attributes = {
		"rank",
		"ace",
		"retrigger",
	},
	crv_credits = {
		art = { "Heaven" },
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.rep },
		}
	end,

	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play and context.other_card:get_id() == 14 then
			return {
				repetitions = card.ability.extra.rep,
			}
		end
	end,
})

SMODS.Joker({
	key = "deal_breaker",
	atlas = "revo_jokers",
	rarity = 3,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,

	pos = {
		x = 9,
		y = 2,
	},
	config = {
		extra = {
			uses = 3,
		},
	},
	crv_use = function(self, card)
		local cae = card.ability.extra
		cae.uses = cae.uses - 1
		G.GAME.blind.chips = G.GAME.blind.chips / 2
		G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
		RVF.msg(card, localize("k_crv_half"))
		if card.ability.extra.uses == 0 then
			SMODS.destroy_cards(card)
		end
	end,
	crv_can_use = function(self, card)
		if G.GAME.blind and G.GAME.blind.in_blind and card.ability.extra.uses > 0 then
			return true
		end
		return false
	end,
	attributes = {},
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.uses },
		}
	end,
})

SMODS.Joker({
	key = "rebel",
	atlas = "revo_jokers",
	rarity = 3,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 0,
		y = 3,
	},
	config = {
		extra = {
			xmult = 3,
		},
	},
	attributes = {
		"xmult",
		"destroy_card",
		"face",
	},
	loc_vars = function(self, info_queue, card)
		local crv = card.ability.extra
		return {
			vars = { crv.xmult },
		}
	end,
	calculate = function(self, card, context)
		local crv = card.ability.extra
		if context.destroy_card and context.cardarea == G.play then
			for k, v in pairs(context.scoring_hand) do
				if v:is_face() and context.destroy_card == v then
					return {
						remove = true,
					}
				end
			end
		end
		if context.joker_main then
			return {
				xmult = crv.xmult,
			}
		end
	end,
})

SMODS.Joker({
	key = "the_d6",
	rarity = 3,
	cost = 8,
	atlas = "revo_jokers",
	config = {
		extra = {
			rerolls = 3,
			max = 3,
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.rerolls, card.ability.extra.max },
		}
	end,
	pos = {
		x = 1,
		y = 3,
	},
	discovered = true,
	blueprint_compat = false,
	attributes = {},
	crv_can_use = function(self, card)
		if G.pack_cards and G.pack_cards.cards and #G.pack_cards.cards > 0 and card.ability.extra.rerolls > 0 then
			return true
		end
		return false
	end,
	crv_use = function(self, card)
		card.ability.extra.rerolls = card.ability.extra.rerolls - 1
		for k, v in pairs(G.pack_cards.cards) do
			local set = v.ability.set
			if not SMODS.is_playing_card(v) then
				local the_card = pseudorandom_element(SMODS.get_clean_pool(v.ability.set), pseudoseed("thed6_seed"))
				the_card = the_card or v.config.center.key
				RVF.cool_enhance(v, the_card)
			else
				RVF.cool_enhance(v, function()
					local edition_rate = 2
					local edition = poll_edition("standard_edition" .. G.GAME.round_resets.ante, edition_rate, true)
					v:set_seal(SMODS.poll_seal({ mod = 10 }), true, true)
					v:set_edition(edition, true, true)
					local enh = SMODS.poll_enhancement()
					if enh then
						v:set_ability(enh)
					end
					SMODS.change_base(
						v,
						pseudorandom_element(SMODS.Suits, pseudoseed("thed6_seed")).key,
						pseudorandom_element(SMODS.Ranks, pseudoseed("thed6_seed")).key
					)
				end)
			end
		end
	end,
	calculate = function(self, card, context)
		if context.ending_shop and not context.blueprint then
			card.ability.extra.rerolls = card.ability.extra.max
			RVF.msg(card, localize("k_reset"))
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

-- referenced from Spiked Ball from Smallpox

MiniSpamton = Object:extend()

function MiniSpamton:init()
	self.speed = 3
	self.x = 0
	self.y = 0
	self.scale_x = 1
	self.scale_y = 1
	self.scale_r = 0

	self.going_x = 0
	self.going_y = 0

	self.time_left = 15
end

SMODS.Joker({ -- rework some functions related to this
	key = "spamton",
	atlas = "revo_jokers",
	rarity = 3,
	cost = 7,
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
		},
	},
	crv_credits = {
		art = { "Nyxel" },
	},
	attributes = {
		"modify_card",
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "crv_spamton_buff" }
	end,
	add_to_deck = function(self, card, from_debuff)
		if (card.ability.extra.ready and G.GAME.crv_minispamton) and RevosVault.config.miniton_wander then
			RVF.summon_mini_spamton()
		end
	end,
	calculate = function(self, card, context)
		if context.crv_call_for_help and card.ability.extra.ready then
			if not RevosVault.config.miniton_wander then
				RVF.summon_mini_spamton()
			end
			card.ability.extra.ready = false
			RVF.leave_mini_spamton()
		end
		if context.ante_end and not context.blueprint and context.main_eval then
			card.ability.extra.ready = true
			if RevosVault.config.miniton_wander then
				RVF.summon_mini_spamton()
			end
		end
	end,
})

SMODS.Joker({
	key = "the_computer",
	atlas = "wip",
	pos = { x = 0, y = 0 },
	cost = 7,
	rarity = 3,
	loc_vars = function(self, info_queue, card)
		return {
			vars = { love.timer.getFPS() },
		}
	end,
	attributes = {
		"mult",
	},
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				mult = love.timer.getFPS(),
			}
		end
	end,
})

SMODS.Joker({
	key = "eyes",
	atlas = "revo_jokers",
	rarity = 3,
	cost = 10,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	attributes = {
		"destroy_card",
		"generation",
	},
	pos = {
		x = 4,
		y = 3,
	},
	crv_credits = {
		art = { "mr.cr33ps" },
	},
	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint then
			if RVF.card_position(card, G.jokers) then
				local pos = RVF.card_position(card, G.jokers).pos
				if
					G.jokers.cards[pos - 1]
					and G.jokers.cards[pos + 1]
					and not SMODS.is_eternal(G.jokers.cards[pos - 1])
				then
					SMODS.destroy_cards(G.jokers.cards[pos - 1])
					SMODS.copy_card(G.jokers.cards[pos + 1])
				end
			end
		end
	end,
})

SMODS.Joker({
	key = "blurry_banana",
	atlas = "revo_jokers",
	no_pool_flag = "crv_blurry_nopool",
	rarity = 3,
	cost = 8,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	perishable_compat = false,
	eternal_compat = false,
	pos = {
		x = 5,
		y = 3,
	},
	config = {
		extra = {
			repetitions = 2,
			odds = 6,
		},
	},
	pools = {
		Food = true,
		Banana = true,
	},
	attributes = {
		"banana",
		"joker",
		"food"
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		local n, d = SMODS.get_probability_vars(card, 1, cae.odds, "crv_blurry_seed")
		return {
			vars = { card.ability.extra.repetitions, d, n },
		}
	end,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if
			context.retrigger_joker_check
			and not context.retrigger_joker
			and context.other_card.config.center.key ~= "j_crv_blurry_banana"
			and context.other_card:has_attribute("banana")
		then
			return {
				repetitions = card.ability.extra.repetitions,
			}
		end
		if context.end_of_round and context.main_eval and not context.blueprint then
			if SMODS.pseudorandom_probability(card, "crv_blurry_seed", 1, cae.odds) then
				SMODS.destroy_cards(card, { pinch_anim = true })
				G.GAME.pool_flags.crv_blurry_nopool = true
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
	key = "majestic_four",
	atlas = "revo_jokers",
	rarity = 3,
	cost = 7,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	attributes = {
		"xmult",
		"hand_type"
	},
	pos = {
		x = 6,
		y = 3,
	},
	config = {
		extra = {
			xmult = 4.4,
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.xmult },
		}
	end,

	calculate = function(self, card, context)
		if context.joker_main and next(context.poker_hands["Four of a Kind"]) then
			return {
				x_mult = card.ability.extra.xmult,
			}
		end
	end,
})

SMODS.Joker({ 
	key = "the_perfect_three",
	atlas = "revo_jokers",
	rarity = 3,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 7,
		y = 3,
	},
	config = {
		extra = {
			xmult = 3.3,
		},
	},
	attributes = {
		"xmult",
		"hand_type"
	},
	crv_credits = {
		art = { "Chainsawmert" },
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.xmult },
		}
	end,

	calculate = function(self, card, context)
		if context.joker_main and next(context.poker_hands["Three of a Kind"]) then
			return {
				x_mult = card.ability.extra.xmult,
			}
		end
	end,
})

SMODS.Joker({ 
	key = "kon",
	config = {
		extra = {
			chip_gain = 15,
			chips = 0,
			active = false
		},
	},
	rarity = 3,
	atlas = "revo_jokers",
	blueprint_compat = false,
	discovered = false,
	pos = {
		x = 8,
		y = 3,
	},
	attributes = {

	},
	crv_credits = {
		art = { "Chainsawmert" },
	},
	cost = 7,
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.chip_gain, card.ability.extra.chips,  },
		}
	end,
	crv_can_use = function(self, card)
		if not card.ability.extra.active then
			return true
		end
		return false
	end,
	crv_use = function(self, card)
		card.ability.extra.active = true
		local eval = function()
			return card.ability.extra.active
		end
		juice_card_until(card, eval, true)
	end,
	calculate = function(self, card, context)
		if context.destroy_card and card.ability.extra.active and context.destroying_card then
			local cards = 0
			for k, v in pairs(context.scoring_hand) do
				cards = cards + 1
			end
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "chips",
				scalar_value = "chip_gain",
				scalar_factor = cards,
				message_colour = G.C.CHIPS
			}
		)
		return{
			remove = true
		}
		end
		if context.after then
			card.ability.extra.active = false
		end
		if context.joker_main then
			return{
				chips = card.ability.extra.chips
			}
		end
	end
})

SMODS.Joker({
	key = "jimfinity",
	atlas = "revo_jokers",
	rarity = 3,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = false,
	pos = {
		x = 0,
		y = 4,
	},
	config = {
		extra = {
			xmult = 2,
			odds = 2,
		},
	},
	attributes = {
		"xmult",
		"scaling"
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "crv_fixed_chances" }
		local crv = card.ability.extra
		return {
			vars = { crv.xmult * (G.GAME.crv_jimfinity+1), crv.odds, 1, G.GAME.crv_jimfinity+1 },
		}
	end,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.joker_type_destroyed and SMODS.pseudorandom_probability(card, "crv_jimfinity_seed", 1, cae.odds) and context.card == card and not context.blueprint then
			G.GAME.crv_jimfinity = G.GAME.crv_jimfinity + 1
			RVF.add_tag("tag_crv_jimfinity")
		end
		if context.joker_main then
			return {
				xmult = cae.xmult * (G.GAME.crv_jimfinity+1),
			}
		end
	end,
})