SMODS.Tag({
	key = "crv_jimfinity",
	atlas = "revo_tags",
	pos = { x = 0, y = 0 },
	apply = function(self, tag, context)
		if context.type == "store_joker_create" then
			card = create_card("Joker", context.area, nil, nil, nil, nil, "j_crv_jimfinity")
			create_shop_card_ui(card, "Joker", context.area)
			card.states.visible = false
			tag:yep("+", G.C.BLUE, function()
				card:start_materialize()
				card.ability.couponed = true
				card:set_cost()
				return true
			end)
			tag.triggered = true
			return card
		end
	end,
	in_pool = function(self)
		return false
	end,
})