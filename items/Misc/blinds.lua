SMODS.Blind({
	key = "roaring_knight",
	atlas = "revo_blinds",
	pos = { x = 0, y = 0 },
	boss = { boss = true, min = 3 },
	boss_colour = HEX("520004"),
	loc_vars = function(self)
		local num, den = SMODS.get_probability_vars(self, 1, 4, "roaring_seed")
		return { vars = { (num or 1), (den or 4) } }
	end,
	defeat = function()
		if SMODS.pseudorandom_probability(blind, "roaring_seed", 1, 4, nil) then
			RVF.swoon()
		end
	end,
	disable = function()
		if SMODS.pseudorandom_probability(blind, "roaring_seed", 1, 4, nil) then
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

SMODS.Blind({
	key = "geomancer",
	boss = {
		min = 4,
		max = 10,
	},
	atlas = "revo_blinds",
	pos = { x = 0, y = 4 },
	boss_colour = HEX("4e4e4e"),
	calculate = function(self, blind, context)
		if context.hand_drawn and not self.disabled or self.defeated then
			local no_explosive = true
			for k, v in pairs(G.jokers.cards) do
				if v and v:crv_has_statuseffect("crv_explosive") then
					no_explosive = false
				end
			end
			if no_explosive then
				local random_joker = pseudorandom_element(G.jokers.cards, pseudoseed("geomancer_seed"))
				if random_joker then
					random_joker:apply_status_effect("crv_explosive")
					play_sound("tarot2")
					random_joker:juice_up()
				end
			end
		end
	end,
	crv_credits = {
		art = { "mr.cr33ps" },
	},
	defeat = function(self)
		self.disabled = false
	end,
})

SMODS.Blind({
	key = "the_hole",
	boss = {
		min = 3,
		max = 10,
		showdown = false,
	},
	atlas = "revo_blinds",
	pos = { x = 0, y = 5 },
	boss_colour = HEX("3c4b4e"),
	set_blind = function(self)
		G.GAME.modifiers.crv_chips_noscore = true
	end,
	defeat = function(self)
		self.disabled = false
		G.GAME.modifiers.crv_chips_noscore = false
	end,
	disable = function(self)
		G.GAME.modifiers.crv_chips_noscore = false
	end,
})

SMODS.Blind({
	key = "ancient_eye",
	boss = {
		min = 4,
		max = 10,
	},
	atlas = "revo_blinds",
	pos = { x = 0, y = 6 },
	boss_colour = HEX("ffc954"),
	recalc_debuff = function(self, card, from_blind)
		if card.ability.set == "Enhanced" and not self.disabled then
			return true
		end
		return false
	end,
	defeat = function(self)
		self.disabled = false
	end,
})

SMODS.Blind({
	key = "the_balance",
	boss = {
		min = 4,
		max = 8,
		showdown = false,
	},
	config = {},
	atlas = "revo_blinds",
	pos = { x = 0, y = 7 },
	boss_colour = HEX("a9189e"),
	set_blind = function(self)
		if not self.triggered and not self.disabled then
			self.triggered = true
			if #G.playing_cards % 2 ~= 0 then
				for k, v in pairs(G.playing_cards) do
					if v then
						SMODS.debuff_card(v, true, "crv_balance")
					end
				end
			end
		end
	end,
	defeat = function(self)
		self.triggered = false
		self.disabled = false
		for k, v in pairs(G.playing_cards) do
			if v then
				SMODS.debuff_card(v, false, "crv_balance")
			end
		end
	end,
	disable = function(self)
		self.triggered = false
		self.disabled = true
		for k, v in pairs(G.playing_cards) do
			if v and v.ability then
				SMODS.debuff_card(v, false, "crv_balance")
			end
		end
	end,
})


SMODS.Blind({
	key = "the_hater",
	boss = {
		min = 5,
		max = 10,
	},
	atlas = "revo_blinds",
	loc_vars = function(self)
		local num, den = SMODS.get_probability_vars(self, 1, 6, "crv_the_hater")
		return { vars = { num or 1, den or 6 } }
	end,
	pos = { x = 0, y = 10 },
	boss_colour = HEX("3f00a9"),
	calculate = function(self, blind, context)
		if context.final_scoring_step and not self.disabled then
			if SMODS.pseudorandom_probability(blind, "crv_the_hater", 1, 6) then
				SMODS.Scoring_Parameters.chips:modify(-SMODS.Scoring_Parameters.chips.current+1)
				RVF.do_event(
					function()
						play_sound("highlight1")
						play_sound("chips2")
						return true
					end
				)
			end
		end
	end,
	defeat = function(self)
		self.disabled = false
	end,
})

SMODS.Blind({
	key = "the_rent",
	boss = {
		min = 3,
		max = 10,
	},
	atlas = "revo_blinds",
	pos = { x = 0, y = 11 },
	boss_colour = HEX("f0b900"),
	press_play = function(self)
		local cards = {}
		if G.GAME.dollars > 10 and not self.disabled then
			ease_dollars(-3)
		end
	end,
	defeat = function(self)
		self.disabled = false
	end,
})

SMODS.Blind({
	key = "the_swarm",
	boss = { min = 1, max = 10, showdown = true },
	atlas = "revo_blinds",
	pos = { x = 0, y = 8 },
	boss_colour = HEX("9d6f77"),
	set_blind = function(self)
		if #G.jokers.cards > 0 then
			self.old_chips = G.GAME.blind.chips
			G.GAME.blind.chips = G.GAME.blind.chips * #G.jokers.cards
			--G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			self.triggered = true
		end
	end,
	defeat = function(self) -- no need
		self.triggered = false
		self.old_chips = nil
	end,
	disable = function(self)
		self.triggered = false
		if self.old_chips then
			G.GAME.blind.chips = self.old_chips
			--G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
		end
		self.old_chips = nil
	end,
})

SMODS.Blind({
	key = "stygian_spade",
	boss = {
		min = 1,
		max = 10,
		showdown = true,
	},
	config = {
		current_suit = nil
	},
	atlas = "revo_blinds",
	pos = { x = 0, y = 9 },
	boss_colour = HEX("3c4b4e"),
	calculate = function(self, blind, context)
		if context.first_hand_drawn or (context.hand_drawn and self.prepped and not self.disabled) then
			local cards, suits, final_suits = {}, {}, {}
			for k, v in pairs(G.playing_cards) do
				if not suits[v.base.suit] and not v:is_suit(self.config.current_suit, true) then
					suits[v.base.suit] = v.base.suit
				end
			end
			self.prepped = false
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.3,
				func = function()
					if suits then

						self.config.current_suit = pseudorandom_element(suits, pseudoseed("crv_ssp_blind"))

						RVF.attention_msg(localize(self.config.current_suit, "suits_plural"))

						for k, v in pairs(G.playing_cards) do
							if v:is_suit(self.config.current_suit) then
								SMODS.debuff_card(v, true, "crv_ssp")
							else
								SMODS.debuff_card(v, false, "crv_ssp")
							end
						end

						G.GAME.blind:wiggle()
					end
					return true
				end,
			}))
		end
	end,
	press_play = function(self)
		self.prepped = true
	end,	
	defeat = function(self)
		self.disabled = false
		for k, v in pairs(G.playing_cards) do
			SMODS.debuff_card(v, false, "crv_ssp")
		end
	end,
	disable = function(self)
		for k, v in pairs(G.playing_cards) do
			SMODS.debuff_card(v, false, "crv_ssp")
		end
	end,
})