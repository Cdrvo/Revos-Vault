SMODS.ConsumableType({
	key = "crv_Rune",
	collection_rows = { 4, 5 },
	primary_colour = G.C.PURPLE,
	secondary_colour = G.C.PURPLE,
	shop_rate = 0.05,
})

RevosVault.Rune = SMODS.Consumable:extend({
	set = "crv_Rune",
	config = {
		extra = {
			active = false,
			rounds = 1,
			rounds_left = 1
		}
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		return {
			vars = { cae.rounds, cae.rounds_left },
		}
	end,
	use = function(self, card, area, copier)
		card.ability.extra.active = true
		local eval = function()
			return card.ability.extra.active == true
		end
		juice_card_until(card, eval, true)
	end,
	keep_on_use = function(self,card)
		return true
	end,
	 can_use = function(self,card)
        return not card.ability.extra.active
    end,
	crv_credits = {
		art = {"Tatteredlurker"},
		idea = {"theOfficialFem"}
	}
})

RevosVault.Rune({
	key = "fehu",
	set = "crv_Rune",
	atlas = "runes",
	pos = {
		x = 0,
		y = 1,
	},
	config = {
		extra = {
			dollars = 3,
			rounds = 1,
			rounds_left = 1,
			active = false,
		},
	},
	cost = 5,
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		return {
			vars = { cae.rounds, cae.rounds_left, cae.dollars },
		}
	end,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if cae.active then
			if context.individual and context.cardarea == "unscored" then
				return {
					dollars = cae.dollars,
				}
			end
			if context.end_of_round and context.main_eval then
				RevosVault.calculate_rounds_left(card)
			end
		end
	end,
})

RevosVault.Rune({
	key = "uruz",
	set = "crv_Rune",
	atlas = "runes",
	pos = {
		x = 1,
		y = 1,
	},
	config = {
		extra = {
			rep = 1,
			rounds = 1,
			rounds_left = 1,
            active = false
		},
	},
	cost = 5,
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		return {
			vars = { cae.rounds, cae.rounds_left, cae.rep },
		}
	end,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if cae.active then
			local cae = card.ability.extra
			if context.end_of_round and context.main_eval then
				RevosVault.calculate_rounds_left(card)
			end
			if context.repetition and context.cardarea == G.play then
				return {
					repetitions = cae.rep,
				}
			end
		end
	end,
	crv_credits = {
		art = {"Tatteredlurker"}
	}
})

RevosVault.Rune({
	key = "thurisaz",
	set = "crv_Rune",
	atlas = "runes",
	pos = {
		x = 0,
		y = 0,
	},
	config = {
		extra = {
			rounds = 1,
			rounds_left = 1,
			active = false
		},
	},
	cost = 5,
		loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		return {
			vars = { cae.rounds, cae.rounds_left },
		}
	end,
	use = function(self, card, area, copier)
		card.ability.extra.active = true
		G.GAME.rare_mod = G.GAME.rare_mod + 0.5
		local eval = function()
			return card.ability.extra.active == true
		end
		juice_card_until(card, eval, true)
	end,
	calculate = function(self,card,context)
		local cae = card.ability.extra
		if context.ending_shop and cae.active then
			RevosVault.calculate_rounds_left(card)
		end
	end,
	remove_from_deck = function(self,card,from_debuff)
		local cae = card.ability.extra
		if cae.active then
			G.GAME.rare_mod = G.GAME.rare_mod - 0.5
		end
	end,
})

RevosVault.Rune({
	key = "ansuz",
	set = "crv_Rune",
	atlas = "runes",
	pos = {
		x = 1,
		y = 0,
	},
	config = {
		extra = {
			odds = 20,
			rounds = 3,
			active = false	
		},
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {set = "Other", key = "crv_fixed_chances"}
		local cae = card.ability.extra
		local numerator, denominator =
			SMODS.get_probability_vars(card, (G.GAME.probabilities.normal or 1), card.ability.extra.odds, "ansuz", nil, true)
		return { vars = { numerator, denominator, cae.rounds, cae.rounds_left} }
	end,
	cost = 5,
	calculate = function(self, card, context)
		local cae = card.ability.extra
			if cae.active then
			if context.setting_blind then
				if SMODS.pseudorandom_probability(card, "ansuz", G.GAME.probabilities.normal, card.ability.extra.odds, nil, true) then
					SMODS.add_card({
						key = "c_soul" ,
					})
				end
			end
			if context.end_of_round and context.main_eval then
				RevosVault.calculate_rounds_left(cad)
			end
		end
	end,
})

RevosVault.Rune({
	key = "raidho",
	set = "crv_Rune",
	atlas = "runes",
	pos = {
		x = 2,
		y = 1,
	},
	config = {
		extra = {
			active = false,
			rounds = 3,
			rounds_left = 3
		},
	},
	cost = 5,
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		return { vars = {cae.rounds, cae.rounds_left} }
	end,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if cae.active then
			if context.end_of_round and context.main_eval then
				RevosVault.calculate_rounds_left(card)
			end
			if context.individual and not context.other_card.edition and context.cardarea == G.play then
				local a = pseudorandom_element({"Seal","Edition","Enhancement"},pseudoseed("imtryingok"))
				if a == "Seal" then
					context.other_card:set_seal(SMODS.poll_seal({guaranteed = true}), nil, true)
				elseif a == "Edition" then
					context.other_card:set_edition(poll_edition(pseudorandom("raidho"), nil, true, true))
				else
					context.other_card:set_ability(SMODS.poll_enhancement({guaranteed = true}))
				end
			end
		end
	end,
})

RevosVault.Rune({
	key = "kenaz",
	set = "crv_Rune",
	atlas = "runes",
	pos = {
		x = 3,
		y = 1,
	},
	config = {
		extra = {
			rounds = 1,
			rounds_left = 1,
			active = false
		},
	},
	cost = 5,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if cae.active then
			if context.end_of_round and context.main_eval then
				RevosVault.calculate_rounds_left(card)
			end
			if context.destroy_card and context.cardarea == "unscored" then
				return{
					remove = true
				}
			end
		end
	end,
})

RevosVault.Rune({
	key = "gebo",
	set = "crv_Rune",
	atlas = "runes",
	pos = {
		x = 4,
		y = 0,
	},
config = {
		extra = {
			rounds = 3,
			rounds_left = 3,
			active = false
		},
	},
	cost = 5,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if cae.active then
			if context.end_of_round and context.main_eval then
				RevosVault.calculate_rounds_left(card)
				for k, v in pairs(G.consumeables.cards) do
					if not v.edition or (v.edition and not v.edition.negative) then
						v:set_edition("e_negative")
					end
				end
			end
		end
	end,
})

RevosVault.Rune({
	key = "wunjo",
	set = "crv_Rune",
	atlas = "runes",
	pos = {
		x = 4,
		y = 1
	},
	config = {
		extra = {
			rounds = 1,
			rounds_left = 1,
			dollars = 2
		},
	},
	loc_vars = function(self,info_queue,card)
		local cae = card.ability.extra
		return{vars={cae.rounds,cae.rounds_left,cae.dollars}}
	end,
	cost = 5,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if cae.active then
			if context.end_of_round and context.main_eval then
				RevosVault.calculate_rounds_left(card)
			end
			if context.individual and context.cardarea == G.play then
				RevosVault.perma_upgrade(context.other_card, "p_dollars", false, cae.dollars)
				            return {
                message = localize('k_upgrade_ex'), colour = G.C.MONEY
            }
			end
		end
	end,
})

RevosVault.Rune({
	key = "hagalaz",
	set = "crv_Rune",
	atlas = "runes",
	pos = {
		x = 3,
		y = 0,
	},
	config = {
		extra = {
			rounds = 3,
			rounds_left = 3,
			extra_cards = 3
		},
	},
	loc_vars = function(self,info_queue,card)
		local cae = card.ability.extra
		return{vars={cae.rounds,cae.rounds_left,cae.extra_cards}}
	end,
	cost = 5,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if cae.active then
			if context.end_of_round and context.main_eval then
				RevosVault.calculate_rounds_left(card)
			end
			if context.pre_discard then
				cae.discarded = true
			end
			if context.crv_after_draw and cae.discarded then
				for i = 1, cae.extra_cards do
					draw_card(G.deck, G.hand)
				end
				cae.discarded = false
			end
		end
	end
})

RevosVault.Rune({
	key = "isa",
	set = "crv_Rune",
	atlas = "runes",
	pos = {
		x = 0,
		y = 2,
	},
	config = {
		extra = {
			rounds = 3,
			rounds_left = 3,
			xmult = 2
		},
	},
	loc_vars = function(self,info_queue,card)
		local cae = card.ability.extra
		return{vars={cae.rounds,cae.rounds_left,cae.xmult}}
	end,
	cost = 5,
	set_ability = function(self, card, initial, delay_sprites)
		card:set_edition("e_negative", true, true)
	end,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if cae.active then
			if context.end_of_round and context.main_eval then
				RevosVault.calculate_rounds_left(card)
			end
			if context.crv_debuff then
				SMODS.calculate_effect({xmult = cae.xmult}, context.crv_card)
			end
		end
	end,
})

RevosVault.Rune({
	key = "jera",
	set = "crv_Rune",
	atlas = "runes",
	pos = {
		x = 1,
		y = 2,
	},
	config = {
		extra = {
			rounds = 3,
			rounds_left = 3,
		},
	},
	cost = 5,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if cae.active then
		if context.before and context.scoring_hand and #context.scoring_hand>0 then
			RevosVault.calculate_rounds_left(card)
			G.playing_card = (G.playing_card and G.playing_card + 1) or 1
			local _card = copy_card(context.full_hand[1], nil, nil, G.playing_card)
			_card:add_to_deck()
			G.deck.config.card_limit = G.deck.config.card_limit + 1
			table.insert(G.playing_cards, _card)
			G.hand:emplace(_card)
			_card.states.visible = nil

			G.E_MANAGER:add_event(Event({
				func = function()
					_card:start_materialize()
					return true
				end,
			}))
			return {
				message = localize("k_copied_ex"),
				colour = G.C.CHIPS,
				card = self,
				playing_cards_created = { true },
			}
		end
	end
end
})

RevosVault.Rune({
	key = "eihwaz",
	set = "crv_Rune",
	atlas = "runes",
	pos = {
		x = 2,
		y = 2,
	},
	cost = 5,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.setting_blind and cae.active then
			G.E_MANAGER:add_event(Event({
				func = function()
					G.E_MANAGER:add_event(Event({
						func = function()
							G.GAME.blind:disable()
							play_sound("timpani")
							delay(0.4)
							return true
						end,
					}))
					card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("ph_boss_disabled") })
					RevosVault.calculate_rounds_left(card)
					return true
				end,
			}))
		end
	end,
})

RevosVault.Rune({
	key = "perthro",
	set = "crv_Rune",
	atlas = "runes",
	pos = {
		x = 2,
		y = 0,
	},
	config = {
		extra = {
			rounds = 3,
			rounds_left = 3,
		},
	},
	cost = 5,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.end_of_round and context.main_eval and cae.active then
			RevosVault.calculate_rounds_left(card)
			G.E_MANAGER:add_event(Event({
				func = function()
					add_tag(Tag(pseudorandom_element(G.P_CENTER_POOLS.Tag).key))
					play_sound("generic1", 0.9 + math.random() * 0.1, 0.8)
					play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
					return true
				end,
			}))
		end
	end,
})

RevosVault.Rune({
	key = "algiz",
	set = "crv_Rune",
	atlas = "runes",
	pos = {
		x = 3,
		y = 2,
	},
	config = {
		extra = { rounds = 3, rounds_left = 3, blindreq = 0.8 },
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		return {
			vars = { cae.rounds, cae.rounds_left, cae.blindreq },
		}
	end,
	cost = 5,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.first_hand_drawn and cae.active then
			RevosVault.calculate_rounds_left(card)
			G.GAME.blind.chips = G.GAME.blind.chips * cae.blindreq
			G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			card:juice_up(0.3, 0.4)
			return {
				message = "Blind Lowered",
			}
		end
	end,
})

RevosVault.Rune({
	key = "sowilo",
	set = "crv_Rune",
	atlas = "runes",
	pos = {
		x = 4,
		y = 2,
	},
	config = {
		extra = {
			rounds = 3,
			rounds_left = 3
		}
	},
	cost = 5,
	calculate = function(self,card,context)
		local cae = card.ability.extra
		if cae.active then
			if context.end_of_round and context.main_eval then
				RevosVault.calculate_rounds_left(card)
			end
			if context.individual and context.cardarea == "unscored" then
				return{
					chips = context.other_card.base.nominal
				}
			end
		end
	end
})

RevosVault.Rune({
	key = "towaz",
	set = "crv_Rune",
	atlas = "runes",
	pos = {
		x = 0,
		y = 3,
	},
	config = {
		extra = {
			rounds_left = 3,
			rounds = 3,
			add = 2,
		},
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		return {
			vars = { cae.rounds, cae.rounds_left,cae.add },
		}
	end,
	cost = 5,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if cae.active then
			if context.end_of_round and context.main_eval then
				RevosVault.calculate_rounds_left(card)
			end
		end
	end,
	use = function(self, card, area, copier)
		card.ability.extra.active = true
		local eval = function()
			return card.ability.extra.active == true
		end
		juice_card_until(card, eval, true)
		local cae = card.ability.extra
		SMODS.change_play_limit(cae.add)
		SMODS.change_discard_limit(cae.add)
	end,
	remove_from_deck = function(self, card, from_debuff)
		local cae = card.ability.extra
		if cae.active then
			SMODS.change_play_limit(-cae.add)
			SMODS.change_discard_limit(-cae.add)
		end
	end,
})

RevosVault.Rune({
	key = "mannaz",
	set = "crv_Rune",
	atlas = "runes",
	pos = {
		x = 1,
		y = 3,
	},
	config = {
		extra = {
			rounds = 3,
			rounds_left = 3,
			xchips = 1.5
		},
	},
	loc_vars = function(self,info_queue,card)
		local cae = card.ability.extra
		return{vars={cae.rounds,cae.rounds_left,cae.xchips}}
	end,
	cost = 5,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if cae.active then
			if context.end_of_round and context.main_eval then
				RevosVault.calculate_rounds_left(card)
			end
			if context.individual and (context.cardarea == "unscored" or context.cardarea == G.play) and context.other_card:is_face() then
				return{
					xchips = cae.xchips
				}
			end
			if context.crv_debuff and context.crv_card:is_face(true) then
				SMODS.calculate_effect({xchips = cae.xchips}, context.crv_card)
			end
		end
	end,
})

RevosVault.Rune({
	key = "berkana",
	set = "crv_Rune",
	atlas = "runes",
	pos = {
		x = 2,
		y = 3,
	},
	config = {
		extra = {
			rounds = 3,
			rounds_left = 3,
			add = 3,
		},
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		return {
			vars = { cae.rounds, cae.rounds_left, cae.add },
		}
	end,
	cost = 5,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.end_of_round and context.main_eval and cae.active then
			RevosVault.calculate_rounds_left(card)
		end
	end,
	use = function(self, card, area, copier)
		card.ability.extra.active = true
		local eval = function()
			return card.ability.extra.active == true
		end
		juice_card_until(card, eval, true)
		local cae = card.ability.extra
		G.hand:change_size(cae.add)
	end,
	remove_from_deck = function(self, card, from_debuff)
		local cae = card.ability.extra
		if cae.active then
			G.hand:change_size(-cae.add)
		end
	end,
})

RevosVault.Rune({
	key = "othala",
	set = "crv_Rune",
	atlas = "runes",
	pos = {
		x = 3,
		y = 3,
	},
	config = {
		extra = {
			rounds_left = 3,
			rounds = 3,
			add = 2,
		},
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		return {
			vars = { cae.rounds, cae.rounds_left, cae.add },
		}
	end,
	cost = 5,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.end_of_round and context.main_eval and cae.active then
			RevosVault.calculate_rounds_left(card)
		end
	end,
	use = function(self, card, area, copier)
		card.ability.extra.active = true
		local eval = function()
			return card.ability.extra.active == true
		end
		juice_card_until(card, eval, true)
		local cae = card.ability.extra
		G.GAME.round_resets.hands = G.GAME.round_resets.hands + cae.add
        ease_hands_played(cae.add)
	end,
	remove_from_deck = function(self, card, from_debuff)
		local cae = card.ability.extra
		if cae.active then
			G.GAME.round_resets.hands = G.GAME.round_resets.hands - cae.add
			ease_hands_played(-cae.add)
		end
	end,
})

RevosVault.Rune({
	key = "inguz",
	set = "crv_Rune",
	atlas = "runes",
	pos = {
		x = 4,
		y = 3,
	},
	config = {
		extra = {
			rounds_left = 3,
			rounds = 3,
			add = 2,
		},
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		return {
			vars = { cae.rounds, cae.rounds_left, cae.add },
		}
	end,
	cost = 5,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.end_of_round and context.main_eval and cae.active then
			RevosVault.calculate_rounds_left(card)
		end
	end,
	use = function(self, card, area, copier)
		card.ability.extra.active = true
		local eval = function()
			return card.ability.extra.active == true
		end
		juice_card_until(card, eval, true)
		local cae = card.ability.extra
		G.GAME.round_resets.discards = G.GAME.round_resets.discards + cae.add
        ease_discard(cae.add)
	end,
	remove_from_deck = function(self, card, from_debuff)
		local cae = card.ability.extra
		if cae.active then
			G.GAME.round_resets.discards = G.GAME.round_resets.discards - cae.add
			ease_discard(-cae.add)
		end
	end,
})
