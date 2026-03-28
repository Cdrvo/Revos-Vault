SMODS.Seal({
	key = "ps",
	atlas = "enh",
	pos = { x = 3, y = 0 },
	discovered = true,
	badge_colour = HEX("A020F0"),
	rarity = 3,
	sound = { sound = "gold_seal", per = 1.2, vol = 0.4 },
	calculate = function(self, card, context)
		if context.main_scoring and context.cardarea == G.play then
			local card = copy_card(card)
			G.deck.config.card_limit = G.deck.config.card_limit + 1
			table.insert(G.playing_cards, card)
			card:set_seal()
			card:add_to_deck()
			G.hand:emplace(card)
			card.states.visible = nil
			G.E_MANAGER:add_event(Event({
				func = function()
					card:start_materialize()
					return true
				end,
			}))
			return {
				message = "Printed!",
			}
		end
	end,
})


SMODS.Seal({
	key = "superior_seal",
	atlas = "enh",
	pos = { x = 4, y = 0 },
	discovered = true,
	badge_colour = RevosVault.C.SUP,
	rarity = 3,
	sound = { sound = "gold_seal", per = 1.2, vol = 0.4 },
	config = { extra = { rep = 2, money = 3 } },
	loc_vars = function(self,info_queue,card)
		local case = card.ability.seal.extra
		return{vars={case.rep,case.money}}
	end,
	get_p_dollars = function(self, card)
		local case = card.ability.seal.extra
        return case.money
    end,
	calculate = function(self, card, context)
		local case = card.ability.seal.extra
		if context.repetition then
            return {
                repetitions = case.rep,
            }
        end
		if ((context.playing_card_end_of_round and context.cardarea == G.hand) or (context.discard and context.other_card == card)) and #G.consumeables.cards < G.consumeables.config.card_limit and not context.repetition then
            local cons_set = "Tarot"
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = function()
                    cons_set = crvps(SMODS.ConsumableTypes).key
					SMODS.add_card{set = cons_set}
                    return true
                end
            }))
            return { message = localize('k_crv_plus_consumable'), colour = G.C.SECONDARY_SET[cons_set] }
        end
	end,
	in_pool = function(self,card)
		return false
	end
})

-- am i dumb

--[[SMODS.Seal({
	key = "themoon",
	atlas = "enh",
	pos = { x = 2, y = 1 },
	discovered = true,
	badge_colour = HEX("A020F0"),
	rarity = 3,
	sound = { sound = "gold_seal", per = 1.2, vol = 0.4 },
	calculate = function(self, card, context)
		if context.final_scoring_step and context.cardarea == G.play then
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.1,
			func = function()
                local suit = card.base.suit
                local suit_suffix = tostring(suit)
                local rank = card.base.id
            if rank == 11 then
                rank = "Jack"
            elseif rank == 12 then
                rank = "Queen"
            elseif rank == 13 then
                rank = "King"
            elseif rank == 14 then
                rank = "Ace"
            else
                rank = tostring(rank)
            end
				local _rank_suffix = tostring(rank)
                card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
            for i = 1, 2 do
                local acard = create_playing_card({
                    front = G.P_CARDS[suit_suffix .. "_" .. rank],
                    center = G.P_CENTERS.c_base,
                }, G.hand, nil, nil, { G.C.SECONDARY_SET.Enhanced })
                assert(SMODS.change_base(acard, suit_suffix, rank))
            end

			RevosVault.c_message(card, localize("k_upgrade"))
			return true
		end
		}))
		end
    end
})]]

SMODS.Seal({
	key = "royal",
	atlas = "enh",
	pos = {x=4,y=1},
	discovered = true,
	badge_colour = HEX("4f6367"),
	rarity = 3,
	sound = { sound = "gold_seal", per = 1.2, vol = 0.4 },
})