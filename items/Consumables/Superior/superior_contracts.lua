--[[
if G.play then
		    local ae = RevosVault.do_contract_stuff(
            {
                context = context,
                card = context.other_card
                , dcard = context.destroy_card,
                area = G.play
            }, 
            "m_glass", true, 
            {
                return_table = {xmult = cae.xmult},
                special_effect = {
                    context_boolean = (context.repetition and context.other_card and SMODS.has_enhancement(context.other_card, "m_glass")),
                    return_table = { repetitions = cae.rep }
                }
            })
            if ae then
                return ae
            end
        end
]]

SMODS.Consumable({
	key = "supglassdocument",
	set = "Superior",
    crv_in_set = "EnchancedDocuments",
	discovered = true,
	atlas = "Superior",
	pos = { x = 5, y = 3 },
	config = {
		extra = {
			xmult = 2,
			odds = 4,
			active = false,
            rep = 2,
            rounds = 3,
            rounds_left = 3,
		},
	},
    pools = {
		SuperiorEnchancedDocuments = true,
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS["m_glass"]
        local cae = card.ability.extra
        local num, den = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "glassing")
		return { vars = { num, den, cae.rep, cae.rounds, cae.rounds_left } }
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
            if context.individual and context.cardarea == G.play then
                return{
                    xmult = cae.xmult
                }
            end
            if context.repetition and SMODS.has_enhancement(context.other_card, "m_glass") then
                return{
                    repetitions = cae.rep
                }
            end
            if context.destroy_card and SMODS.has_enhancement(context.destroy_card, "m_glass") and SMODS.pseudorandom_probability(card, "glassing", 1, cae.odds) then
                return{
                    remove = true
                }
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
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_contract"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})

SMODS.Consumable({
	key = "supsteeldocument",
	set = "Superior",
    crv_in_set = "EnchancedDocuments",
	discovered = true,
	atlas = "Superior",
	pos = { x = 8, y = 3 },
	config = {
		extra = {
			xmult = 1.5,
			active = false,
            rep = 2,
            rounds = 3,
            rounds_left = 3,
		},
	},
    pools = {
		SuperiorEnchancedDocuments = true,
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS["m_steel"]
        local cae = card.ability.extra
		return { vars = { cae.rep, cae.rounds, cae.rounds_left } }
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
            if context.individual and context.cardarea == G.hand then
                return{
                    xmult = cae.xmult
                }
            end
            if context.repetition and SMODS.has_enhancement(context.other_card, "m_steel") then
                return{
                    repetitions = cae.rep
                }
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
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_contract"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})

SMODS.Consumable({
	key = "supstaineddoc",
	set = "Superior",
    crv_in_set = "EnchancedDocuments",
	discovered = true,
	atlas = "Superior",
	pos = { x = 12, y = 3 },
	config = {
		extra = {
			xmult = 2,
			active = false,
            rep = 2,
            rounds = 3,
            rounds_left = 3,
		},
	},
    pools = {
		SuperiorEnchancedDocuments = true,
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS["m_crv_mugged"]
        local cae = card.ability.extra
		return { vars = { cae.rep, cae.rounds, cae.rounds_left } }
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
            if context.individual and context.cardarea == G.play and next(context.poker_hands["Flush"]) then
                return{
                    xmult = cae.xmult
                }
            end
            if context.repetition and SMODS.has_enhancement(context.other_card, "m_crv_mugged") then
                return{
                    repetitions = cae.rep
                }
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
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_contract"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})

SMODS.Consumable({
	key = "supaflamedoc",
	set = "Superior",
    crv_in_set = "EnchancedDocuments",
	discovered = true,
	atlas = "Superior",
	pos = { x = 6, y = 3 },
	config = {
		extra = {
			rep_o = 1,
            rep_o_2 = 2,
			active = false,
            rep = 2,
            rounds = 3,
            rounds_left = 3,
		},
	},
    pools = {
		SuperiorEnchancedDocuments = true,
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS["m_crv_aflame"]
        local cae = card.ability.extra
		return { vars = { cae.rep, cae.rounds, cae.rounds_left } }
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
            if context.repetition then
                local ae = 0
                if SMODS.has_enhancement(context.other_card, "m_crv_aflame") then
                    ae = ae + cae.rep
                end
                if context.cardarea == G.play then
                    ae = ae + pseudorandom_element({cae.rep_o, cae.rep_o_2}, pseudoseed("aflaming"))
                end
                return{
                    repetitions = ae
                }
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
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_contract"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})


SMODS.Consumable({
	key = "supmegadoc",
	set = "Superior",
    crv_in_set = "EnchancedDocuments",
	discovered = true,
    display_size = { w = 90, h = 120 },
	pixel_size = { w = 71, h = 95 },
	atlas = "Superior",
	pos = { x = 11, y = 3 },
	config = {
		extra = {
			xmult = 4,
			active = false,
            rep = 2,
            rounds = 3,
            rounds_left = 3,
		},
	},
    pools = {
		SuperiorEnchancedDocuments = true,
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS["m_crv_mega"]
        local cae = card.ability.extra
		return { vars = {cae.rep, cae.rounds, cae.rounds_left } }
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
            if context.individual and context.cardarea == G.play then
                return{
                    xmult = cae.xmult
                }
            end
            if context.repetition and SMODS.has_enhancement(context.other_card, "m_crv_mega") then
                return{
                    repetitions = cae.rep
                }
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
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_contract"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})

SMODS.Consumable({
	key = "supt1doc",
	set = "Superior",
    crv_in_set = "EnchancedDocuments",
	discovered = true,
	atlas = "Superior",
	pos = { x = 9, y = 4 },
	config = {
		extra = {
			chips = 50,
			active = false,
            rep = 2,
            rounds = 3,
            rounds_left = 3,
		},
	},
    pools = {
		SuperiorEnchancedDocuments = true,
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS["m_crv_tier1card"]
        local cae = card.ability.extra
		return { vars = {cae.rep, cae.rounds, cae.rounds_left } }
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
            if context.individual and context.cardarea == G.play then
                return{
                    chips = cae.chips
                }
            end
            if context.repetition and SMODS.has_enhancement(context.other_card, "m_crv_tier1card") then
                return{
                    repetitions = cae.rep
                }
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
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_contract"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})

SMODS.Consumable({
	key = "supt2doc",
	set = "Superior",
    crv_in_set = "EnchancedDocuments",
	discovered = true,
	atlas = "Superior",
	pos = { x = 10, y = 4 },
	config = {
		extra = {
			chips = 100,
            mult = 10,
			active = false,
            rep = 2,
            rounds = 3,
            rounds_left = 3,
		},
	},
    pools = {
		SuperiorEnchancedDocuments = true,
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS["m_crv_tier2card"]
        local cae = card.ability.extra
		return { vars = {cae.rep, cae.rounds, cae.rounds_left } }
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
            if context.individual and context.cardarea == G.play then
                return{
                    chips = cae.chips,
                    mult = cae.mult,
                }
            end
            if context.repetition and SMODS.has_enhancement(context.other_card, "m_crv_tier2card") then
                return{
                    repetitions = cae.rep
                }
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
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_contract"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})

SMODS.Consumable({
	key = "supt3doc",
	set = "Superior",
    crv_in_set = "EnchancedDocuments",
	discovered = true,
	atlas = "Superior",
	pos = { x = 11, y = 4 },
	config = {
		extra = {
			chips = 200,
            xmult = 3,
			active = false,
            rep = 2,
            rounds = 3,
            rounds_left = 3,
		},
	},
    pools = {
		SuperiorEnchancedDocuments = true,
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS["m_crv_tier3card"]
        local cae = card.ability.extra
		return { vars = {cae.rep, cae.rounds, cae.rounds_left } }
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
            if context.individual and context.cardarea == G.play then
                return{
                    chips = cae.chips,
                    xmult = cae.xmult,
                }
            end
            if context.repetition and SMODS.has_enhancement(context.other_card, "m_crv_tier3card") then
                return{
                    repetitions = cae.rep
                }
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
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_contract"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})


SMODS.Consumable({
	key = "supluckydocument",
	set = "Superior",
    crv_in_set = "EnchancedDocuments",
	discovered = true,
	atlas = "Superior",
	pos = { x = 7, y = 3 },
	config = {
		extra = {
			mult = 20,
            dollars = 20,
			odds = 5,
			odds2 = 15,
			active = false,
            rep = 2,
            rounds = 3,
            rounds_left = 3,
		},
	},
    pools = {
		SuperiorEnchancedDocuments = true,
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS["m_lucky"]
        local cae = card.ability.extra
		return { vars = {cae.rep, cae.rounds, cae.rounds_left } }
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
            if context.individual and context.cardarea == G.play then
                local effect = {}
                if pseudorandom("luckydocument") < G.GAME.probabilities.normal / card.ability.extra.odds2 then -- update to new smods!!!!
                    effect.dollars = cae.dollars
                end
                if pseudorandom("luckydocument") < G.GAME.probabilities.normal / card.ability.extra.odds then
                    effect.mult = cae.mult
                end
                return effect
            end
            if context.repetition and SMODS.has_enhancement(context.other_card, "m_lucky") then
                return{
                    repetitions = cae.rep
                }
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
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_contract"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})
