SMODS.Consumable({
	key = "brush",
	set = "Spectral",
	config = { extra = { cards = 1 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_SEALS["crv_ps"]
		return { vars = { card.ability.extra.cards } }
	end,
	pos = { x = 0, y = 0 },
	atlas = "spec",
	cost = 3,
	unlocked = true,
	discovered = true,
	can_use = function(self, card)
		if G and G.hand then
			if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then 
				return true
			end
		end
		return false
	end,
	use = function(self, card)
		for i, card in pairs(G.hand.highlighted) do
			card:set_seal("crv_ps")
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					G.hand:unhighlight_all()
					return true
				end,
			}))
			delay(0.5)
		end
	end,
})


if RevoConfig["8_curses_enabled"] then
	SMODS.Consumable({
		key = "pruification",
		set = "Spectral",
		config = { extra = { cards = 1 } },
		loc_vars = function(self, info_queue, card)
			return { vars = { card.ability.extra.cards } }
		end,
		pos = { x = 0, y = 1 },
		atlas = "spec",
		cost = 5,
		unlocked = true,
		discovered = true,
		can_use = function(self, card)
			if G and G.crv_curses then
				if #G.crv_curses.highlighted ~= 0 and #G.crv_curses.highlighted <= card.ability.extra.cards then 
					for k, v in pairs(G.crv_curses.highlighted) do
						if v.config.center.rarity == "crv_curse" then
							return true
						end
					end
				end
			end
			return false
		end,
		use = function(self, card)
			RevosVault.purified_curse = true
			for i, card in pairs(G.crv_curses.highlighted) do
				if card.config.center.rarity == "crv_curse" then
					SMODS.destroy_cards(card, true)
					check_for_unlock({type = "purifying_it"})
				end
			end
		end,
		after_use = function()
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.5,
				func = function()
					RevosVault.purified_curse = false
					return true
				end
			}))
		end,
		in_pool = function(self)
			return (RevosVault.rarity_in("crv_curse") and (RevosVault.rarity_in("crv_curse")>0))
		end
	})
end

SMODS.Consumable({
	key = "planetary_contract",
	set = "Spectral",
	discovered = true,
	atlas = "spec",
	pos = { x = 1, y = 0 },
	hidden = true,
	soul_set = "Planet",
	soul_rate = 0.003, --too rare? idfk
	config = {
		extra = {
			active = false,
            rounds = 5,
            rounds_left = 5,
		},
	},
	loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
		return { vars = {cae.rounds, cae.rounds_left } }
	end,
	can_use = function(self, card)
		return card.ability.extra.active == false
	end,
	keep_on_use = function(self, card)
		return true
	end,
	use = function(self, card, area, copier)
		card.ability.extra.active = true
		local eval = function()
			return card.ability.extra.active == true
		end
		juice_card_until(card, eval, true)
	end,
	calculate = function(self, card, context)
        local cae = card.ability.extra
        if cae.active then
            local cae = card.ability.extra
            if context.modify_hand then
					hand_chips = mod_chips(hand_chips * 2)
					mult = mod_mult(mult * 2)
					RevosVault.c_message(card, localize("k_crv_double"))
            end
            if context.end_of_round and context.main_eval then
                card.ability.extra.active = false
                RevosVault.c_message(card, "-1")
                if cae.rounds_left > 1  then
                    cae.rounds_left = cae.rounds_left - 1
                else
                    SMODS.destroy_cards(card)
                end
                
            end
        end
        
	end,
})


SMODS.Consumable {
    key = 'crown',
    atlas = 'spec',
	set = "Spectral",
    pos = { x = 1, y = 1 },
    config = { extra = { seal = 'crv_royal' }, max_highlighted = 1 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
        return { vars = { card.ability.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        local conv_card = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                conv_card:set_seal(card.ability.extra.seal, nil, true)
                return true
            end
        }))

        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
    end,

}

--[[SMODS.Consumable { idk if i want to add this rn
    key = 'black_hole',
    set = 'Spectral',
	atlas = "spec",
    pos = { x = 2, y = 0 },
    hidden = true,
    soul_set = 'Planet',
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                G.TAROT_INTERRUPT_PULSE = true
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.9,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.9,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                G.TAROT_INTERRUPT_PULSE = nil
                return true
            end
        }))
        SMODS.upgrade_poker_hands({hands = {RevosVault.most_played()}, level_up = to_number(G.GAME.hands[RevosVault.most_played()].level )})
    end,
    can_use = function(self, card)
        return true
    end,
}]]