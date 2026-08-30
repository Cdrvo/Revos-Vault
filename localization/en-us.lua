return {
	descriptions = {
		Back = {},
		Blind = {
			bl_crv_roaring_knight = {
				name = "Roaring Knight",
				text = {
					"Total Chips and",
					"Mult are halved",
					"1 in 4 chance to",
					"debuff all jokers",
					"when beaten or disabled",
				},
			},
			bl_crv_minimalizm = {
				name = "Minimalizm",
				text = {
					"Must play 3 cards or less",
				},
			},
			bl_crv_fragile = {
				name = "Fragile",
				text = {
					"Destroy a random",
					"played card after scoring",
				},
			},
			bl_crv_the_mess = {
				name = "The Mess",
				text = {
					"Sorting your hand will destroy",
					"all hand held cards",
				},
			},
		},
		Edition = {},
		Enhanced = {
			m_crv_bomb = {
				name = "Bomb",
				text = {
					"{X:mult,C:white}X#1#{} Mult",
					"{C:green}#2# in #3#{} Chance to",
					"get destroyed",
					"no rank or suit",
				},
			},
			m_crv_honey = {
				name = "Honey",
				text = {
					"{C:money}+$#1#{} when scored",
					"{C:green}#2# in #3#{} chance to",
					"return to hand",
				},
			},
		},
		Joker = {
			-- Common
			j_crv_ghostslices = {
				name = "Ghost Slices",
				text = {
					"{C:chips}+#1#{} Chips",
				},
			},
			j_crv_golden_banana = {
				name = "Golden Banana",
				text = {
					"Each scored card has",
					"a {C:green}#2# in #3#{} Chance to",
					"give {C:money}+$#1#{} when scored",
					"{C:green}#2# in #4#{} chance to",
					"get destroyed at end of round",
				},
			},
			j_crv_daily_news = {
				name = "Daily News Joker",
				text = {
					"Has a {C:green}#1# in #2#{} chance to",
					"create a {C:red}Coupon Tag{} at",
					"end of round",
				},
			},
			j_crv_henchman = {
				name = "Henchman",
				text = { "{C:mult}+#1#{} Mult" },
			},
			j_crv_rekoj = {
				name = "Rekoj",
				text = { "{C:chips}+#1#{} Chips" },
			},
			j_crv_collection = {
				name = "Collection",
				text = {
					"Gains {C:mult}+#2#{} Mult",
					"when buying a card",
					"{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
				},
			},
			j_crv_bee = {
				name = "Bee",
				text = {
					"Spreads scored {C:attention}Honey{} cards",
					"to a random adjacent card",
				},
			},
			-- Uncommon
			j_crv_those_who_joke = {
				name = "Those Who Joke",
				text = {
					"When {C:attention}Blind{} is selected",
					"{C:green}#1# in #2#{} chance to",
					"create a {C:dark_edition}Negative{C:attention} Mr. Bones{}",
					"and self-destruct",
				},
			},
			j_crv_rain_rabbit = {
				name = "Rain Rabbit",
				text = {
					"Gains {C:mult}+#1#{} Mult",
					"per unique hand played.",
					"{C:green}#3# in #4#{} chance to",
					"get destroyed at end of round",
					"if there are no {C:attention}Jokers{}",
					"around this card",
					"Resets at the end of ante",
					"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
				},
			},
			j_crv_boss = {
				name = "The Boss",
				text = {
					"{X:mult,C:white}X#1#{} Mult for",
					"each {C:attention}Henchman{} in hand",
					"(Currently {X:mult,C:white}X#2#{} Mult)",
				},
			},
			-- Rare
			j_crv_bocchi = {
				name = "Bocchi the Joker",
				text = {
					"{X:mult,C:white}X#2#{} Mult for each",
					"card {C:attention}held in hand",
				},
			},
			j_crv_ghost_banana = {
				name = "Ghost Banana",
				text = {
					"{X:chips,C:white}X#1#{} Chips.",
					"has a {C:green}#2# in #3#{} chance",
					"to split into {C:attention}#4#{}",
					"{C:attention}Ghost Slices{} at end of round",
				},
			},
			j_crv_plain_banana = {
				name = "Plain Banana",
				text = {
					"When {C:attention}Blind{} is selected,",
					"Gains {C:money}+$#1#{} sell value.",
					"{C:green}#2# in #3#{} chance",
					"to get destroyed",
				},
			},
			j_crv_mathematician = {
				name = "Mathematician",
				text = {
					"{X:mult,C:white}X#1#{} Mult",
					"if {C:attention}scoring hand{}",
					"contains a {C:attention}3",
				},
			},
			j_crv_moon_lord = {
				name = "Moon Lord",
				text = {
					"{C:red}Debuff{} a random {C:attention}Joker{}",
					"when {C:attention}Blind{} is selected",
					"for the current round.",
					"{X:mult,C:white}X#1#{} Mult",
				},
			},
			j_crv_empress_of_light = {
				name = "Empress of Light",
				text = {
					"If both sides of this",
					"{C:attention}Joker{} are full, {X:mult,C:white}X#2#{} Mult.",
					"{X:mult,C:white}X#1#{} Mult otherwise",
				},
			},
			j_crv_jarden = {
				name = "Jarden",
				text = {
					"Gains {X:mult,C:white}X#1#{} Mult",
					"at end of round",
					"Resets when a {C:attention}Joker{} is sold",
					"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
				},
			},
			j_crv_kings_impact = {
				name = "King's Impact",
				text = {
					"Increases or decreases",
					"the ranks of scored cards",
					"until they are a {C:attention}King{}",
				},
			},
			j_crv_dr_jimbo = {
				name = "Dr. Jimbo",
				text = {
					"Turns scored cards",
					"without an enhancement to {C:attention}Stone.",
					"If a {C:attention}Stone Card {}is scored, removes the",
					"enhancement and gains {X:mult,C:white}X#2#{} Mult.",
					"{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)",
				},
			},
			j_crv_clicker = {
				name = "Clicker Simulator",
				text = {
					"Gains {C:chips}+#3#{} Chips for each click {C:inactive}(#1#).",
					"{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
				},
			},
			j_crv_giftbox = {
				name = "Gift Box",
				text = {
					"Sell this {C:attention}Joker{}",
					"after {C:attention}#2#{} Rounds to get a",
					"random {C:purple,E:1}Legendary{C:attention} Joker{}",
					"and an {C:dark_edition}Eternal{} common {C:attention}Joker{}",
					"{C:inactive}(Currently {C:attention}#1#{C:inactive}/#2#)",
					"{C:inactive}(Must have room)",
				},
			},
			j_crv_killer_queen = {
				name = "Killer Queen",
				text = {
					"Turns the rightmost",
					"played card into {C:attention}Bomb{} and",
					"Gains {X:mult,C:white}X#2#{} Mult",
					"{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)",
				},
			},
			j_crv_copycat = {
				name = "Copycat",
				text = {
					"When {C:attention}Blind{} is selected",
					"transform into a random",
					"owned {C:attention}Joker{} until",
					"the end of round",
				},
			},
			j_crv_furnace = {
				name = "Furnace",
				text = {
					"Each scored card",
					"permanently gains",
					"{X:mult,C:white}X#1#{} Mult when scored",
					"Has a {C:green}#2# in #3#{} chance to destroy them",
				},
			},
			j_crv_tax_master = {
				name = "Tax Master",
				text = {
					"Refunds {C:attention}%#1#{} of",
					"all purchased cards costs",
				},
			},
			j_crv_nyancat = {
				name = "Nyan Cat",
				text = {
					"Scored cards without",
					"an edition turns {C:crv_polychrome}Polychrome",
				},
			},
			j_crv_ace_questionmark = {
				name = "Ace?",
				text = {
					"Retriggers scored {C:attention}Aces",
					"{C:attention}#1#{} times",
				},
			},
			j_crv_deal_breaker = {
				name = "Deal Breaker",
				text = {
					"Use when in a {C:attention}Blind{}",
					"to half its required chips.",
					"Self-destructs when",
					"out of uses",
				},
			},
			j_crv_rebel = {
				name = "Rebel",
				text = {
					"Scored {C:attention}face{} cards",
					"are destroyed",
					"{X:mult,C:white}X#1#{} Mult",
				},
			},
			j_crv_the_d6 = {
				name = "The D6",
				text = {
					"Use to reroll",
					"the contains of a {C:attention}Booster Pack{}",
					"up to {C:attention}#2#{} times",
					"Resets when leaving the shop",
					"{C:inactive}(Currently {C:attention}#1#{C:inactive}/#2#)",
				},
			},
			j_crv_spamton = {
				name = "Spamton J. Spamton",
				text = {
					"Press {C:attention}[[F1]]{} per ante",
					"for a {C:attention}[[specil DEAL]]{}",
					"{C:inactive}(Apply Spamton Buff to playing cards)",
				},
			},
			j_crv_the_computer = {
				name = "The Computer",
				text = {
					"Gives {C:mult}Mult{} equal",
					"to your {C:attention}FPS{}",
					"{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
				},
			},
			j_crv_eyes = {
				name = "The Eyes",
				text = {
					"When {C:attention}Blind{} is selected",
					"destroys the joker on the left",
					"and {C:attention}Duplicates{} the joker on the right",
				},
			},
			j_crv_blurry_banana = {
				name = "Blurry Banana",
				text = {
					"Retriggers all {C:crv_banana}Banana{C:attention} Jokers",
					"{C:attention}#1#{} times.",
					"at end of round,",
					"{C:green}#3# in #2#{} chance to",
					"get destroyed",
				},
			},
			j_crv_majestic_four = {
				name = "Majestic 4",
				text = {
					"{X:mult,C:white}X#1#{} Mult if played",
					"hand contains",
					"a {C:attention}Four of a Kind",
				},
			},
			j_crv_the_perfect_three = {
				name = "The Perfect 3",
				text = {
					"{X:mult,C:white}X#1#{} Mult if played",
					"hand contains",
					"a {C:attention}Three of a Kind",
				},
			},
			j_crv_kon = {
				name = "Kon",
				text = {
					"Use to destroy",
					"all the cards in",
					"the next {C:attention}scored hand.",
					"Gains {C:chips}+#1#{} Chips",
					"per destroyed card",
					"{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
				},
			},
			j_crv_jimfinity = {
				name = "Jimfinity",
				text = {
					"{X:mult,C:white}X#4{} Mult for",
					"each time this card",
					"was destroyed.",
					"{C:green}#3# in #2#{} chance to",
					"create a {C:attention}Jimfinity{} tag",
					"when destroyed",
					"{C:inactive}(Currently {X:mult,C:white}X#1{C:inactive} Mult)",
				},
			},
			-- Printer
			j_crv_blueprinter = {
				name = "Blueprinter",
				text = {
					"When {C:attention}Blind{} is selected",
					"print a {C:attention}Blueprint{}",
					"{C:inactive}(Must have room)"
				}
			},
			j_crv_broken_blueprinter = {
				name = "Broken Blueprinter",
				text = {
					"When {C:attention}Blind{} is selected",
					"print a {C:attention}Blueprint{}",
					"{C:green}#1# in #2#{} chance to",
					"{C:red}self-destruct{}",
					"{C:inactive}(Must have room)"
				}
			},
			j_crv_gros_printer = {
				name = "Gros Printer",
				text = {
					"When {C:attention}Blind{} is selected",
					"print a random {C:attention}Banana{}",
					"{C:green}#1# in #2#{} chance to",
					"print {C:dark_edition}Holy Banana{}",
					"{C:inactive}(Must have room)"
				}
			},
			j_crv_rusty_printer = {
				name = "Rusty Printer",
				text = {
					"When {C:attention}Blind{} is selected",
					"print a {C:attention}Brainstorm{}",
					"{C:inactive}(Must have room)"
				}
			},
			j_crv_default_printer = {
				name = "Default Printer",
				text = {
					"When {C:attention}Blind{} is selected",
					"print a random",
					"{C:attention}Consumable{},{C:attention} Joker{}",
					"or {C:attention}Playing Card{}",
					"{C:inactive}(Must have room)"
				}
			},
			j_crv_joker_printer = {
				name = "Joker Printer",
				text = {
					"When {C:attention}Blind{} is selected",
					"print a {C:attention}Joker{}",
					"{C:inactive}(Must have room)"
				}
			},
			j_crv_obelisk_printer = {
				name = "Obelisk Printer",
				text = {
					"When {C:attention}Blind{} is selected",
					"print a {C:attention}Obelisk{}",
					"{C:inactive}(Must have room)"
				}
			},
			j_crv_golden_printer = {
				name = "Golden Printer",
				text = {
					"When {C:attention}Blind{} is selected",
					"print a random "
					,"{C:money}Economy{} Joker.",
					"{C:inactive}(Must have room)"
				}
			},
			j_crv_spectral_printer = {
				name = "Spectral Printer",
				text = {
					"When {C:attention}Blind{} is selected",
					"print a random",
					"{C:dark_edition}Spectral{} Card",
					"{C:inactive}(Must have room)"
				}
			},
			j_crv_legendary_printer = {
				name = "Legendary Printer",
				text = {
					"When {C:attention}Blind{} is selected",
					"{C:green}#1# in #2#{} chance to",
					"print a random",
					"{C:attention}Perishable{} and {C:dark_edition}Negative{}",
					"{C:legendary,E:1}Legendary{} Joker.",
					"{C:inactive}(Must have room)"
				}
			},
			j_crv_voucher_printer = {
				name = "Voucher Printer",
				text = {
					"When {C:attention}Blind{} is selected,",
					"print a random"
					,"{C:attention}Voucher{}"
				},
			},
			j_crv_food_printer = {
				name = "Food Printer",
				text = {
					"When {C:attention}Blind{} is selected",
					"print a random",
					"{C:attention}Food{} Joker",
				},
			},
			j_crv_fax_machine = {
				name = "Fax Machine",
				text = {
					"When {C:attention}Blind{} is selected",
					"print a random",
					"{C:attention}Contract{}"
				}
			},
			-- Legendary
			j_crv_the_ace = {
				name = "The Ace",
				text = {
					"All cards are",
					"considered {C:attention}Aces{}",
					"Scored {C:attention}Aces{} give",
					"{X:mult,C:white}X#1#{} Mult",
				},
			},
			j_crv_blueberry = {
				name = "Blueberry",
				text = {
					"All scored cards",
					"without an {C:attention}Enhancement",
					"gains a random one",
				},
			},
			j_crv_pandik = {
				name = "Pandik",
				text = {
					"Has a {C:green}1 in 2{} chance to",
					"create a random {C:attention}Consumable{}",
					"per reroll",
				},
			},
			j_crv_the_ant = {
				name = "The Ant",
				text = {
					"Scored numbered cards",
					"give {X:mult,C:white}X#1#{} Mult",
					"Increase by {X:mult,C:white}+#2#{}",
					"per numbered card",
				},
			},
			j_crv_shop_sign = {
				name = "The Shop Sign",
				text = {
					"{C:attention}Rerolling{} the shop",
					"will also reroll",
					"the {C:attention}Vouchers{} and",
					"the {C:attention}Booster Packs",
				},
			},
			-- Mythical
			-- Curse
			-- Other
			j_crv_holybanana = {
				name = "Holy Banana",
				text = {
					"Gives {X:mult,C:white}X#1# {} Mult",
					"and {C:chips}+#2#{} Chips.",
					"{C:green}#3# in #4#{} chance to get",
					"destroyed at end of round",
				},
			},
		},
		Other = {
			crv_fixed_chances = {
				name = "Immutable Chances",
				text = {
					"This Card's {C:attention}listed",
					"{C:green,E:1,S:1.1}probability {C:red}cannot{}",
					"be changed",
				},
			},
			crv_spamton_buff = {
				name = "Spamton Buff",
				text = {
					"Retrigger this card",
					"twice",
				},
			},
		},
		Planet = {},
		Spectral = {},
		Stake = {},
		Tag = {
			tag_crv_jimfinity = {
				name = "Jimfinity Tag",
				text = { "Next shop has a free", "{C:attention}Jimfinity" },
			},
		},
		Tarot = {},
		Voucher = {},

		-- mod

		crv_Contracts = {
			c_crv_glass_contract = {
				name = "Glass Contract",
				text = {
					"Upgrades up to {C:attention}1{}",
					"selected {C:attention}Glass Cards{}",
					"to {C:dark_edition}Bulletproof Glass{}",
					"{C:green}#1# in #2#{} chance to",
					"destroy the card"
				}
			}
		},

		crv_cartridge = {
			c_crv_glitchy = {
				name = "Glitchy Cartridge",
				text = {
					"Wheb applied {C:red}Printer{}",
					"is triggered,",
					"retrigger the {C:red}Printer{}",
					"{C:inactive}(Must have room)"
				}
			},
			c_crv_mixed = {
				name = "Mixed Cartridge",
				text = {
					"Cards printed",
					"by the applied {C:red}Printer{}",
					"has a random {C:dark_edition}Edition"
				}
			},
			c_crv_ghostly = {
				name = "Ghostly Cartridge",
				text = {
					"Cards printed",
					"by the applied {C:red}Printer{}",
					"fills {C:dark_edition}0{} slots"
				}
			},
			c_crv_golden = {
				name = "Golden Cartridge",
				text = {
					"Cards printed",
					"by the applied {C:red}Printer{}",
					"has double the sell cost"
				}
			},
			c_crv_soul = {
				name = "Cartridge Soul",
				text = {
					"When applied {C:red}Printer",
					"is triggered,",
					"has a small chance to",
					"create {C:dark_edition}The Soul{}"
				}
			},
			c_crv_spin = {
				name = "Spinny Cartridge",
				text = {
					"Applied {C:red}Printer{}",
					"continuously spins"
				}
			},
			c_crv_anti = {
				name = "Anti Cartridge",
				text = {
					"Applied {C:red}Printer{}",
					"becomes {C:dark_edition}Negative{}"
				}
			},
			c_crv_bonus = {
				name = "Bonus Cartridge",
				text = {
					"When applied {C:red}Printer",
					"is triggered,",
					"creates a random {C:attention}Tag{}"
				}
			}
		}
	},
	misc = {
		achievement_descriptions = {},
		achievement_names = {},
		blind_states = {},
		challenge_names = {},
		collabs = {},
		dictionary = {
			-- UI
			crv_cartridges = "Cartridges",
			-- Rariities
			k_crv_holy = "Holy Banana",
			k_crv_printer = "Printer",
			-- Text
			k_crv_split = "Split!",
			k_crv_half = "Halved!",
			k_crv_ready = "Ready",
			k_crv_destroyed = "Destroyed",
			k_crv_sticky = "Sticky!",
			-- Consumabels
			k_crv_cartridge = "Cartridge",
			b_crv_cartridge_cards = "Cartridges",
		},
		high_scores = {},
		labels = {
			-- Other
			crv_spamton_buff = "Spamton Buff",
		},
		poker_hand_descriptions = {},
		poker_hands = {},
		quips = {},
		ranks = {},
		suits_plural = {},
		suits_singular = {},
		tutorial = {},
		v_dictionary = {
			crv_art = { "Art: #1#" },
			crv_code = { "Code: #1#" },
			crv_idea = { "Idea: #1#" },
			crv_shader = { "Shader: #1#" },
		},
		v_text = {},
	},
}
