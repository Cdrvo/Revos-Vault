SMODS.Atlas({
	key = "inc_superior",
	path = "Cross-Mod/incognito/superior.png",
	px = 71,
	py = 95,
})

SMODS.ObjectType({
	key = "SuperiorZenGarden",
	cards = {},
})

SMODS.Consumable({
	key = "supmysteryvase",
	discovered = true, 
	unlocked = true,
	set = "Superior",
	atlas = "inc_superior",
    crv_in_set = "ZenGarden",
	cost = 8,
	pos = { x = 0, y = 1 },
	soul_pos = { x = 0, y = 0 },
	dependencies = "Incognito",
	can_use = function(self, card)
		return true
	end,
    pools = {
        SuperiorZenGarden = true
    },
	use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            func = function()
                local crazy = 1
                if next(SMODS.find_card("j_nic_crazydave")) then
                    crazy = 0
                else
                    crazy = 1
                end
                local random = pseudorandom('c_nic_mysteryvase', 1 + crazy, 4)
                play_sound('nic_vasebreak')

                if random == 1 then
                    SMODS.calculate_effect({message = "Plants", colour = G.C.NIC_PLANTS }, card)
                    if #G.zengarden.cards < G.zengarden.config.card_limit then
						for i = 1, 3 do
                        	SMODS.add_card({ area = G.zengarden, set = 'Joker', rarity = 'nic_plants', edition = "e_polychrome" })
						end
                    end
                elseif random == 2 then
                    SMODS.calculate_effect({message = "Joker" }, card)
					
					for i = 1, 3 do
						local edition = pseudorandom_element({"e_polychrome", "e_negative"})
						if #G.jokers.cards < G.jokers.config.card_limit or edition == "e_negative" then
							SMODS.add_card({ set = "Joker", edition = edition })
						end
					end

                elseif random == 3 then
                    SMODS.calculate_effect({message = "Consumeables" }, card)
                    for i = 1, 3 do
						local edition = pseudorandom_element({"e_polychrome", "e_negative"})
						if #G.consumeables.cards < G.consumeables.config.card_limit or edition == "e_negative" then
							SMODS.add_card({ set = "Consumeables", edition = edition })
						end
					end
                elseif random == 4 then
                    SMODS.calculate_effect({message = "Playing Card" }, card)
					for i = 1, 3 do
						local _card = SMODS.create_card { 
							set = "Base", 
							edition = pseudorandom_element({"e_polychrome", "e_negative"}),
							seal = SMODS.poll_seal({ mod = 10 }), 
							area = G.discard 
						}
						G.playing_card = (G.playing_card and G.playing_card + 1) or 1
						_card.playing_card = G.playing_card
						table.insert(G.playing_cards, _card)
						
						_card:start_materialize()
						G.play:emplace(_card)
						delay(1)
						draw_card(G.play, G.deck, 90, 'up')
					end
                end

                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)
    end,
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_zen"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})

SMODS.Consumable({
	key = "supplantsvase",
	discovered = true, 
	unlocked = true,
	set = "Superior",
	atlas = "inc_superior",
    crv_in_set = "ZenGarden",
	cost = 8,
	pos = { x = 1, y = 1 },
	soul_pos = { x = 1, y = 0 },
	dependencies = "Incognito",
    pools = {
        SuperiorZenGarden = true
    },
	use = function(self, card, area, copier)
       G.E_MANAGER:add_event(Event({
            func = function()
                SMODS.calculate_effect({message = "Plants", colour = G.C.NIC_PLANTS }, card)
                play_sound('nic_vasebreak')
				for i = 1, 5 do
					SMODS.add_card({ area = G.zengarden, set = 'Joker', rarity = 'nic_plants', edition = "e_negative" })
					card:juice_up(0.3, 0.5)
				end
                return true
            end
        }))
        delay(0.6)
    end,
	can_use = function(self, card)
        return G.zengarden and #G.zengarden.cards < G.zengarden.config.card_limit and next(SMODS.find_card("j_nic_crazydave"))
    end,
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_zen"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})

SMODS.Consumable({
	key = "supshovel",
	discovered = true, 
	unlocked = true,
	set = "Superior",
	atlas = "inc_superior",
    crv_in_set = "ZenGarden",
	cost = 8,
	pos = { x = 2, y = 1 },
	soul_pos = { x = 2, y = 0 },
	dependencies = "Incognito",
    pools = {
        SuperiorZenGarden = true
    },
	config = {
		extra = {
			odds = 4
		}
	},
	loc_vars = function(self, info_queue, card)
		local num, den = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "ss")
		local t = {}
        if card.area and card.area == G.zengarden or card.area == G.consumeables then
            local compatible = #G.zengarden.highlighted > 0 and #G.zengarden.highlighted == 1 and G.zengarden.highlighted[1].config.center.rarity == "nic_plants"
            t = {
                {
                    n = G.UIT.C,
                    config = { align = "bm", minh = 0.4 },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = { ref_table = card, align = "m", colour = compatible and mix_colours(G.C.GOLD, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                            nodes = {
                                { n = G.UIT.T, config = { text = ' ' .. (compatible and (G.localization.descriptions.Joker[G.zengarden.highlighted[1].config.center.key].name .. ': $' .. G.zengarden.highlighted[1].config.center.cost*3) or 'Nothing') .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                            }
                        }
                    }
                }
            }
        end
		return { main_end = t, vars = {num, den} }
    end,

    use = function(self, card, area, copier)
		local cae = card.ability.extra
        SMODS.calculate_effect({message = ("$" .. G.zengarden.highlighted[1].config.center.cost), colour = G.C.GOLD}, G.zengarden.highlighted[1])
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.6,
            func = function()
                ease_dollars(G.zengarden.highlighted[1].config.center.cost*3, true)
                G.zengarden.highlighted[1]:juice_up()
                return true 
            end 
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 1.2,
            func = function()
				if not SMODS.pseudorandom_probability(card, "ss", 1, cae.odds) then
                	SMODS.destroy_cards(G.zengarden.highlighted[1])
				else
					RevosVault.c_message(G.zengarden.highlighted[1], "Kept!")
				end
                play_sound('nic_shovel', 1.2, 0.4)
                card:juice_up()
                return true 
            end 
        }))
    end,

    keep_on_use = function (self,card)
        return true
    end,

    can_use = function (self, card) 
        return #G.zengarden.highlighted > 0 and #G.zengarden.highlighted == 1 and G.zengarden.highlighted[1].config.center.rarity == "nic_plants"
    end,
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_zen"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})