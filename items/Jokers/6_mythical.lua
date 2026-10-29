SMODS.Joker({
	key = "master_of_jokers",
	atlas = "revo_jokers",
	rarity = "crv_mythical",
	cost = 30,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	pos = {
		x = 0,
		y = 15,
	},
	soul_pos = {
		x = 1,
		y = 15
	},
	config = {
		extra = {multi = 4},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.multi} }
	end,
	add_to_deck = function(self,card,from_debuff)
		local old, new = G.jokers.config.card_limit, 0
		new = G.jokers.config.card_limit * card.ability.extra.multi
		G.jokers.config.card_limit = G.jokers.config.card_limit * card.ability.extra.multi
		card.ability.extra.multi_aftermath = new - old
	end,
	remove_from_deck = function(self,card,from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.multi_aftermath
	end
})

SMODS.Joker({
	key = "mythtical_printer",
	atlas = "revo_jokers",
	rarity = "crv_mythical",
	cost = 30,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 2,
		y = 15,
	},
	soul_pos = {
		x = 3,
		y = 15
	},
	config = {
		extra = {rt = 1},
	},
	loc_vars = function(self, info_queue, card)
        local num, den = SMODS.get_probability_vars(card, 1, 8, "crv_mythical_printer", nil, true)
		return { vars = {num, den} }
	end,
	calculate = function(self,card,context)
		if context.setting_blind then
			if SMODS.pseudorandom_probability(card, "crv_mythical_printer", 1, 8, nil, true) and (SMODS.get_clean_pool("Joker", "crv_chaos") and SMODS.get_clean_pool("Joker", "crv_chaos")[1] ~= "j_joker") then
				SMODS.add_card{
					set = "Joker",
					rarity = "crv_mythical",
					edition = "e_negative"
				}
			else
				SMODS.add_card{
					set = "Joker",
					rarity = "Legendary",
					edition = "e_negative"
				}
			end
		end
	end

})

SMODS.Joker({
	key = "ascended_chicot",
	atlas = "revo_jokers",
	rarity = "crv_mythical",
	cost = 30,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 4,
		y = 15,
	},
	soul_pos = {
		x = 5,
		y = 15
	},
	config = {
		extra = {rt = 1},
	},
	loc_vars = function(self, info_queue, card)
        local num, den = SMODS.get_probability_vars(card, 1, 8, "crv_mythical_printer", nil, true)
		return { vars = {num, den} }
	end,
	add_to_deck = function(self, card, from_debuff)
        RVF.reset_all_blinds()
    end

})