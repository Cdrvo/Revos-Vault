SMODS.Blind({
	key = "roaring_knight",
	atlas = "revo_blinds",
	pos = { x = 0, y = 0 },
	boss = { boss = true, min = 4 },
	boss_colour = HEX("520004"),
	calculate = function(self, blind, context)
		if not self.disabled then
			if context.final_scoring_step and G.GAME.chips < G.GAME.blind.chips then
				SMODS.calculate_effect({ xmult = 0.5, xchips = 0.5 }, blind)
			end
		end
	end,
	defeat = function()
		if SMODS.pseudorandom_probability(blind, "roaring_seed", 1, 4, nil, true) then
			RVF.swoon()
		end
	end,
	disable = function()
		if SMODS.pseudorandom_probability(blind, "roaring_seed", 1, 4, nil, true) then
			RVF.swoon()
		end
	end,
})

SMODS.Blind({
	key = "minimalizm",
	debuff = {
		h_size_le = 3,
	},
	atlas = "revo_blinds",
	pos = { x = 0, y = 1 },
	boss = { min = 3, max = 10 },
	boss_colour = HEX("f84b4b"),
})

SMODS.Blind({
	key = "fragile",
	boss = { min = 3, max = 10 },
	atlas = "revo_blinds",
	pos = { x = 0, y = 2 },
	boss_colour = HEX("ffffff"),
	calculate = function(self, blind, context)
		if context.before then
			self.prepped = true
		end
		if context.destroy_card and not (self.disabled or self.defeated) and self.prepped then
			self.prepped = false
			local card_to_destroy = pseudorandom_element(G.play.cards, pseudoseed("crv_fragile_seed"))
			SMODS.destroy_cards(card_to_destroy) -- for some reason return wouldnt check for unscored cards??
		end
	end,
	crv_credits = {
		art = "Astro",
	},
})

SMODS.Blind({
	key = "the_mess",
	boss = {
		min = 1,
		max = 10,
	},
	atlas = "revo_blinds",
	pos = { x = 0, y = 3 },
	boss_colour = HEX("5e5e5e"),
	calculate = function(self, blind, context)
		if not self.disabled then
            if context.crv_sort_hand then
			    G.GAME.blind:wiggle()
                SMODS.destroy_cards(G.hand.cards)
            end
		end
	end,
})
