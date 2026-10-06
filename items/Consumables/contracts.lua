SMODS.ConsumableType({
	key = "crv_Contracts",
	collection_rows = { 4, 5 },
	primary_colour = G.C.BLACK,
	secondary_colour = HEX("676767") -- it was an accident
})


SMODS.Consumable({
    set = "crv_Contracts",
    key = "glass_contract",
    config = {
        extra = {
            odds = 3
        }
    },
    atlas = "revo_contracts",
    crv_credits = {
        art = {"mr.cr33ps"}
    },
    pos = {x=2,y=0},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_crv_reinforced_glass
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
            RVF.cool_enhance(check[1], "m_crv_reinforced_glass")
        end
    end
})

SMODS.Consumable({
    set = "crv_Contracts",
    key = "steel_contract",
    config = {
        extra = {
            odds = 3
        }
    },
    atlas = "revo_contracts",
    crv_credits = {
        art = {"mr.cr33ps"}
    },
    pos = {x=3,y=0},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_crv_diamond
        local num, den = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "steel_contract_seed")
        return{vars={num, den}}
    end,
    can_use = function(self, card)
        local _, check = RVF.highlight(G.hand)
        if check and #check == 1 then
            if SMODS.has_enhancement(check[1], "m_steel") then
                return true
            end
        end
        return false
    end,
    use = function(self, card)
        local _, check = RVF.highlight(G.hand)
        if SMODS.pseudorandom_probability(card, "steel_contract_seed", 1, card.ability.extra.odds) then
            SMODS.destroy_cards(check[1])
        else
            RVF.cool_enhance(check[1], "m_crv_diamond")
        end
    end
})

SMODS.Consumable({
    set = "crv_Contracts",
    key = "gold_contract",
    config = {
        extra = {
            odds = 3
        }
    },
    atlas = "revo_contracts",
    crv_credits = {
        art = {"mr.cr33ps"}
    },
    pos = {x=4,y=0},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_crv_rhodium
        local num, den = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "gold_contract_seed")
        return{vars={num, den}}
    end,
    can_use = function(self, card)
        local _, check = RVF.highlight(G.hand)
        if check and #check == 1 then
            if SMODS.has_enhancement(check[1], "m_gold") then
                return true
            end
        end
        return false
    end,
    use = function(self, card)
        local _, check = RVF.highlight(G.hand)
        if SMODS.pseudorandom_probability(card, "gold_contract_seed", 1, card.ability.extra.odds) then
            SMODS.destroy_cards(check[1])
        else
            RVF.cool_enhance(check[1], "m_crv_rhodium")
        end
    end
})

SMODS.Consumable({
    set = "crv_Contracts",
    key = "mult_contract",
    config = {
        extra = {
            odds = 3
        }
    },
    atlas = "revo_contracts",
    crv_credits = {
        art = {"mr.cr33ps"}
    },
    pos = {x=1,y=0},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_crv_xmult
        local num, den = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "mult_contract_seed")
        return{vars={num, den}}
    end,
    can_use = function(self, card)
        local _, check = RVF.highlight(G.hand)
        if check and #check == 1 then
            if SMODS.has_enhancement(check[1], "m_mult") then
                return true
            end
        end
        return false
    end,
    use = function(self, card)
        local _, check = RVF.highlight(G.hand)
        if SMODS.pseudorandom_probability(card, "mult_contract_seed", 1, card.ability.extra.odds) then
            SMODS.destroy_cards(check[1])
        else
            RVF.cool_enhance(check[1], "m_crv_xmult")
        end
    end
})

SMODS.Consumable({
    set = "crv_Contracts",
    key = "lucky_contract",
    config = {
        extra = {
            odds = 3
        }
    },
    atlas = "revo_contracts",
    crv_credits = {
        art = {"mr.cr33ps"}
    },
    pos = {x=5,y=0},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_crv_blessed
        local num, den = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "lucky_contract_seed")
        return{vars={num, den}}
    end,
    can_use = function(self, card)
        local _, check = RVF.highlight(G.hand)
        if check and #check == 1 then
            if SMODS.has_enhancement(check[1], "m_lucky") then
                return true
            end
        end
        return false
    end,
    use = function(self, card)
        local _, check = RVF.highlight(G.hand)
        if SMODS.pseudorandom_probability(card, "lucky_contract_seed", 1, card.ability.extra.odds) then
            SMODS.destroy_cards(check[1])
        else
            RVF.cool_enhance(check[1], "m_crv_blessed")
        end
    end
})

SMODS.Consumable({
    set = "crv_Contracts",
    key = "bonus_contract",
    config = {
        extra = {
            odds = 3
        }
    },
    atlas = "revo_contracts",
    crv_credits = {
        art = {"mr.cr33ps"}
    },
    pos = {x=0,y=0},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_crv_boosted
        local num, den = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "bonus_contract_seed")
        return{vars={num, den}}
    end,
    can_use = function(self, card)
        local _, check = RVF.highlight(G.hand)
        if check and #check == 1 then
            if SMODS.has_enhancement(check[1], "m_bonus") then
                return true
            end
        end
        return false
    end,
    use = function(self, card)
        local _, check = RVF.highlight(G.hand)
        if SMODS.pseudorandom_probability(card, "bonus_contract_seed", 1, card.ability.extra.odds) then
            SMODS.destroy_cards(check[1])
        else
            RVF.cool_enhance(check[1], "m_crv_boosted")
        end
    end
})