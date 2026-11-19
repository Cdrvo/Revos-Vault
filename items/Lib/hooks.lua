local get_id_old = Card.get_id
function Card:get_id(...)
    if next(SMODS.find_card("j_crv_the_ace")) then
        return 14
    else
        return get_id_old(self, ...)
    end
end

local click_old = Card.click
function Card:click()
    local ret = click_old(self)
    if self.config.center.crv_clicked then
        self.config.center:crv_clicked(self)
    end
    if G.GAME.crv_printer_list then
        G.GAME.crv_selected_printer = self.config.center.key
        G.FUNCS.crv_open_printer_selection()
    end
    if
        self:crv_has_statuseffect("crv_explosive")
        and self.area
        and not self.area.config.collection
        and not self.getting_sliced
    then
        RVF.do_event(function()
            self.ability.crv_diffused = true
            self:remove_status_effect("crv_explosive")
            RVF.msg(self, localize("k_saved_ex"))
            self:juice_up()
            play_sound("tarot1")
            return true
        end)
    end
    return ret
end

-- game objects
local init_game_object_old = Game.init_game_object
Game.init_game_object = function(self)
    local igo = init_game_object_old(self)
    igo.crv_cartridge_limit = 3
    igo.crv_jimfinity = 0
    igo.crv_old_area_locations = {}

    igo.crv_fun = math.random(1, 500)

    igo.curse_cashout = 1

    local gem_index = {}
    for k, v in pairs(G.P_CENTER_POOLS.crv_Gem) do
        gem_index[v.key] = 0
    end
    igo.crv_activated_gems = gem_index

    igo.crv_double_earnings = 0

    return igo
end

local G_UIDEF_use_and_sell_buttons_old = G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
    if card.area == G.jokers and card.config.center.crv_use then
        local sell = {
            n = G.UIT.C,
            config = { align = "cr" },
            nodes = {
                {
                    n = G.UIT.C,
                    config = {
                        ref_table = card,
                        align = "cr",
                        padding = 0.1,
                        r = 0.08,
                        minw = 1.25,
                        hover = true,
                        shadow = true,
                        colour = G.C.UI.BACKGROUND_INACTIVE,
                        one_press = true,
                        button = "sell_card",
                        func = "can_sell_card",
                        handy_insta_action = "sell",
                    },
                    nodes = {
                        { n = G.UIT.B, config = { w = 0.1, h = 0.6 } },
                        {
                            n = G.UIT.C,
                            config = { align = "tm" },
                            nodes = {
                                {
                                    n = G.UIT.R,
                                    config = { align = "cm", maxw = 1.25 },
                                    nodes = {
                                        {
                                            n = G.UIT.T,
                                            config = {
                                                text = localize("b_sell"),
                                                colour = G.C.UI.TEXT_LIGHT,
                                                scale = 0.4,
                                                shadow = true,
                                            },
                                        },
                                    },
                                },
                                {
                                    n = G.UIT.R,
                                    config = { align = "cm" },
                                    nodes = {
                                        {
                                            n = G.UIT.T,
                                            config = {
                                                text = localize("$"),
                                                colour = G.C.WHITE,
                                                scale = 0.4,
                                                shadow = true,
                                            },
                                        },
                                        {
                                            n = G.UIT.T,
                                            config = {
                                                ref_table = card,
                                                ref_value = "sell_cost_label",
                                                colour = G.C.WHITE,
                                                scale = 0.55,
                                                shadow = true,
                                            },
                                        },
                                    },
                                },
                            },
                        },
                    },
                },
            },
        }
        local use = {
            n = G.UIT.C,
            config = { align = "cr" },
            nodes = {
                {
                    n = G.UIT.C,
                    config = {
                        ref_table = card,
                        align = "cm",
                        padding = 0.1,
                        r = 0.08,
                        minw = 1.25,
                        minh = 0.8,
                        hover = true,
                        shadow = true,
                        colour = G.C.UI.BACKGROUND_INACTIVE,
                        button = "crv_use_joker",
                        func = "can_crv_use_joker",
                    },
                    nodes = {
                        { n = G.UIT.B, config = { w = 0.1, h = 0.6 } },
                        {
                            n = G.UIT.C,
                            config = { align = "cm" },
                            nodes = {
                                {
                                    n = G.UIT.R,
                                    config = { align = "cm", maxw = 1.25 },
                                    nodes = {
                                        {
                                            n = G.UIT.T,
                                            config = {
                                                text = card.config.center.crv_use_button_text or localize("b_use"),
                                                colour = G.C.UI.TEXT_LIGHT,
                                                scale = 0.55,
                                                shadow = true,
                                            },
                                        },
                                    },
                                },
                            },
                        },
                    },
                },
            },
        }
        return {
            n = G.UIT.ROOT,
            config = { padding = 0, colour = G.C.CLEAR },
            nodes = {
                {
                    n = G.UIT.C,
                    config = { padding = 0.15, align = "cl" },
                    nodes = {
                        {
                            n = G.UIT.R,
                            config = { align = "cl" },
                            nodes = {
                                sell,
                            }
                        },
                        {
                            n = G.UIT.R,
                            config = { align = "cl" },
                            nodes = {
                                use,
                            }
                        },
                    },
                },
            },
        }
    end
    return G_UIDEF_use_and_sell_buttons_old(card)
end

local function newAnimation(image, width, height) --hmm
    local animation = {}
    animation.spriteSheet = image
    animation.quads = {}
    animation.width = width
    animation.height = height

    for y = 0, image:getHeight() - height, height do
        for x = 0, image:getWidth() - width, width do
            table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
        end
    end

    return animation
end
local love_draw_old = love.draw
function love.draw()
    love_draw_old()
    local _xscale = love.graphics.getWidth() / 1920
    local _yscale = love.graphics.getHeight() / 1080
    if G.crv_swooned and G.crv_swooned > 0 then
        local imgdata = NFS.newFileData(RevosVault.path .. "assets/Other/swoon.png")
        local img = love.image.newImageData(imgdata)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(
            assert(love.graphics.newImage(img)),
            0 * _xscale * 2,
            0 * _yscale * 2,
            0,
            _xscale * 2 * 2,
            _yscale * 2 * 2
        )
    end
end

local update_old = Game.update
function Game:update(dt)
    update_old(self, dt)
    if G.crv_swooned and G.crv_swooned > 0 then
        G.crv_swooned = G.crv_swooned - 1
        if G.crv_swooned == 1 then
            SMODS.calculate_context({ crv_swoon_shake = true })
        end
    end
    if
        G.GAME
        and G.GAME.current_round
        and SMODS.get_scoring_parameter("crv_dollar_parameter")
        and G.STATE ~= G.STATES.HAND_PLAYED
    then
        SMODS.Scoring_Parameters.crv_dollar_parameter:crv_set(G.GAME.dollars or 0)
        SMODS.Scoring_Parameters.crv_dollar_parameter:modify()
    end
end

local sort_hand_value_old = G.FUNCS.sort_hand_value
function G.FUNCS.sort_hand_value(e)
    sort_hand_value_old(e)
    SMODS.calculate_context({ crv_sort_hand = true, crv_ranks = true })
end

local sort_hand_suit_old = G.FUNCS.sort_hand_suit
function G.FUNCS.sort_hand_suit(e)
    sort_hand_suit_old(e)
    SMODS.calculate_context({ crv_sort_hand = true, crv_suits = true })
end

local cardarea_align_cards_ref = CardArea.align_cards
function CardArea:align_cards()
    cardarea_align_cards_ref(self)
    if self.config.type == "joker" or self.config.type == "title" then
        local spin_value = 0.01
        for k, card in ipairs(self.cards) do
            if card and card.ability and ((RVF.has_cartridge(card, "c_crv_spin")) or card.ability.crv_force_spin) then
                if card.states.hover.is then
                    spin_value = 0.05
                end
                if card.states.drag.is then
                    spin_value = 0.05
                end
                card.T.r = card.T.r + spin_value * (G.GAME and G.GAME.crv_spin_mult or 1)
            end
        end
    end
end

local calculate_joker_old = Card.calculate_joker -- preventing joker triggers
function Card:calculate_joker(context)
    local no_trig = false
    if self.ability.crv_no_trigger then
        no_trig = true
    end
    if not no_trig then
        return calculate_joker_old(self, context)
    end
end

local isfaceold = Card.is_face
function Card:is_face(from_boss)
    if self.debuff and not from_boss then
        return
    end
    if self.seal == "crv_royal" then
        return true
    end
    return isfaceold(self, from_boss)
end

local is_suit_old = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
    if flush_calc then
        if
            self:crv_has_border("border_crv_smudged")
            and (self.base.suit == "Hearts" or self.base.suit == "Diamonds")
            == (suit == "Hearts" or suit == "Diamonds")
        then
            return true
        end
    else
        if
            self:crv_has_border("border_crv_smudged")
            and (self.base.suit == "Hearts" or self.base.suit == "Diamonds")
            == (suit == "Hearts" or suit == "Diamonds")
        then
            return true
        end
    end
    return is_suit_old(self, suit, bypass_debuff, flush_calc)
end

local get_chip_bonus_old = Card.get_chip_bonus
function Card:get_chip_bonus()
    if self.debuff or G.GAME.modifiers.crv_chips_noscore then
        return 0
    end
    return get_chip_bonus_old(self)
end

local old_exit_menu = G.FUNCS.exit_overlay_menu
G.FUNCS.exit_overlay_menu = function()
    if G.current_printer and G.current_printer.cards and #G.current_printer.cards > 0 then
        SMODS.copy_card(G.current_printer.cards[1], { area = G.jokers })
        SMODS.destroy_cards(
            G.current_printer.cards,
            { bypass_eternal = true, immediate = true, silent = true, dissolve_time_fac = 0 }
        )
    end
    G.GAME.crv_printer_list = false
    G.GAME.crv_selected_printer = nil
    old_exit_menu()
end


local old_SMODS_get_new_blind = SMODS.get_new_blind
SMODS.get_new_blind = function(blind_type)
    if next(SMODS.find_card("j_crv_sdms_nightmare")) then
        return "bl_crv_the_balance"
    end
    if G.GAME.crv_all_small or next(SMODS.find_card("j_crv_ascended_chicot")) then
        return "bl_small"
    end
    return old_SMODS_get_new_blind(blind_type)
end

local ease_dollars_old = ease_dollars
function ease_dollars(mod, instant)
    SMODS.calculate_context({ crv_pre_money_altered = true, amount = mod })
    if G.GAME.crv_double_earnings and G.GAME.crv_double_earnings > 0 then
        ease_dollars_old(mod * 2, instant)
    else
        ease_dollars_old(mod, instant)
    end
end

local set_ability_old = Card.set_ability
function Card:set_ability(center, initial, delay_sprites)
    set_ability_old(self, center, initial, delay_sprites)

    G.E_MANAGER:add_event(Event({
        trigger = "immediate",
        delay = 0,
        func = function()
            if ((type(center) == "string" and G.P_CENTERS[center] and G.P_CENTERS[center].set == "Enhanced") or center.set and center.set == "Enhanced") then
                SMODS.calculate_context({ card_enhanced = true, card = self, enhancement = center, area = self.area })
            end
            return true
        end
    }))
end

local start_run_old = Game.start_run
function Game:start_run(args)
    RevosVault.MISC.curse_text = localize("crv_curses")

    start_run_old(self, args)

    -- taken from JoyousSpring (N' my goat)
    self.curse_button = UIBox {
        definition = {
            n = G.UIT.ROOT,
            config = {
                align = "cm",
                minw = 1,
                minh = 0.3,
                padding = 0.15,
                r = 0.1,
                colour = G.C.CLEAR,
            },
            nodes = {
                {
                    n = G.UIT.C,
                    config = {
                        align = "tm",
                        minw = 2,
                        padding = 0.1,
                        r = 0.1,
                        hover = true,
                        colour = G.C.L_BLACK,
                        shadow = true,
                        button = "crv_cj_switch",
                        func = "crv_cj_available"
                    },
                    nodes = {
                        {
                            n = G.UIT.R,
                            config = { align = "bcm", padding = 0 },
                            nodes = {
                                {
                                    n = G.UIT.T,
                                    config = {
                                        ref_table = RevosVault.MISC,
                                        ref_value = "curse_text",
                                        scale = 0.35,
                                        colour = G.C.UI.TEXT_LIGHT
                                    }
                                }
                            }
                        },
                    }
                },

            }
        },
        config = {
            align = "tr",
            offset = { x = -7.5, y = 0.1 },
            major = G.ROOM_ATTACH,
            bond = 'Weak'
        }
    }
    if not G.crv_curses or (G.crv_curses and #G.crv_curses.cards == 0) then G.curse_button.states.visible = false end
    self.HUD:recalculate()
end

local emplace_old = CardArea.emplace
function CardArea:emplace(card, location, stay_flipped)
    emplace_old(self, card, location, stay_flipped)
    if self.config.type == "shop" then
        if next(SMODS.find_card("j_crv_inflation")) then
            if card and card.base_cost then
                card.base_cost = card.base_cost * 2
                card:set_cost()
            end
        end
    end
    if self == G.jokers and card.config.center.rarity == "crv_curse" then
        RVF.move_card(card, G.crv_curses)
        if G.crv_curses.T.y < G.jokers.T.y then
            G.FUNCS.crv_cj_switch()
            G.curse_button.states.visible = true
        end
    elseif self == G.jokers and G.crv_curses.T.y > G.jokers.T.y then
        G.FUNCS.crv_cj_switch()
    end
end

local card_highlight_old = Card.highlight
function Card:highlight(is_highlighted)
    self.highlighted = is_highlighted
    if self.highlighted and self.ability.crv_no_buttons or self.config.center.rarity == "crv_curse" then
        if self.children.use_button then
            self.children.use_button:remove()
            self.children.use_button = nil
        end
    else
        card_highlight_old(self, is_highlighted)
    end
end


local arer_ref = add_round_eval_row --thank's to haya for this bit :D
function add_round_eval_row(config)
	config.dollars = (((config.dollars or 0) * 1) / G.GAME.curse_cashout) -- 1 will change later
	return arer_ref(config)
end
