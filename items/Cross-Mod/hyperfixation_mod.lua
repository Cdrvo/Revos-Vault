-- SUPERIOR DECEIT

SMODS.Atlas({
    key = "Superior_HPFX",
    path = "Cross-Mod/hyperfixation/superior.png",
    px = 71,
    py = 95,
})
SMODS.Consumable({
	key = "suphpfx_iji_deceit",
	set = "Superior",
	atlas = "Superior_HPFX",
	hidden = true,
	soul_set = "Spectral",
	sout_rate = 0.1,
	pos = {
		x = 0,
		y = 0
	},
	pools = {
		SuperiorSpectral = true,
	},
	discovered = true,
	config = {
		extra = { cards = 1 },
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards } }
	end,
    dependencies = "hyperfixation_mod",
    can_use = function(self,card)
        if G.jokers and G.jokers.highlighted and #G.jokers.highlighted==1 then
            return true
        end
        return false
    end,
	use = function(self, card, area, copier)
		G.jokers.highlighted[1]:Transfodd()
        G.jokers:unhighlight_all()
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_s"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})