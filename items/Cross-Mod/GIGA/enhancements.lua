SMODS.Enhancement({
	key = "gigamega",
	atlas = "giga",
	pos = { x = 3, y = 1},
    giga_data = {
        is_upgraded = true,
    },
    dependencies = "GIGA",
	display_size = { w = RevoConfig and not RevoConfig["normal_mega_cards"] and 90 or 71, h = RevoConfig and not RevoConfig["normal_mega_cards"] and 120 or 95 },
	pixel_size = { w = 71, h = 95 },
	discovered = true,
	unlocked = true,
	replace_base_card = false,
	no_rank = false,
	no_suit = false,
	overrides_base_rank = false,
	any_suit = false,
	always_scores = false,
	weight = 0,
	config = { extra = { xmult = 6 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult } }
	end,
	calculate = function(self, card, context, effect)
		if context.main_scoring and (context.cardarea == G.play or context.cardarea == G.hand) then
			return {
				x_mult = card.ability.extra.xmult,
			}
		end
	end,
	in_pool = function(self)
		return false
	end,
})
