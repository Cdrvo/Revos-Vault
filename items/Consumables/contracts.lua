SMODS.ConsumableType({
	key = "crv_Contracts",
	collection_rows = { 4, 5 },
	primary_colour = G.C.WHITE,
	secondary_colour = G.C.BLACK,
})


SMODS.Consumable({
    set = "crv_Contracts",
    key = "glass_contract",
    config = {
        extra = {
            odds = 3
        }
    },
    loc_vars = function(self, info_queue, card)
        local num, den = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "glass_contract_seed")
        return{vars={num, den}}
    end,
    can_use = function(self, card)
        local _, check = RVF.highlight(G.hand)
        if check and #check == 1 then
            if SMODS.has_enhancement(check[1], "m_glass") then
                return true
            end
        end
        return false
    end,
    use = function(self, card)
        local _, check = RVF.highlight(G.hand)
        if SMODS.pseudorandom_probability(card, "glass_contract_seed", 1, card.ability.extra.odds) then
            SMODS.destroy_cards(check[1])
        else
            RVF.cool_enhance(check[1], "m_glass")
        end
    end
})