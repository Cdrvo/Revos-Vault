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
			m_crv_reinforced_glass = {
				name = "Reinforced Glass",
				text = {
					"{X:mult,C:white} X#1# {} Mult",
					"{C:green}#2# in #3#{} chance to",
					"turn back into {C:attention}Glass{}",
				},
			},
			m_crv_diamond = {
				name = "Diamond Card",
				text = {
					"{X:mult,C:white}X#1#{} Mult",
					"while this card",
					"stays in hand",
				},
			},
			m_crv_rhodium = {
				name = "Rhodium Card",
				text = {
					"{C:money}$#1#{} if this",
					"card is held in hand",
					"at end of round",
				},
			},
			m_crv_blessed = {
				name = "Blessed Card",
				text = {
					"{C:green}#1# in #2#{} chance",
					"for {X:mult,C:white}X#4#{} Mult",
					"{C:green}#6# in #3#{} chance",
					"to win {C:money}$#5#{}",
				},
			},
			m_crv_xmult = {
				name = "Xmult Card",
				text = {
					"{X:mult,C:white}X#1#{} Mult",
				},
			},
			m_crv_boosted = {
				name = "Boosted Card",
				text = {
					"{C:chips}+#1#{} Chips",
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
			j_crv_do_a_barrel_roll = {
				name = "Do a Barrel Roll",
				text = {
					"Played cards spin around",
					"before scoring",
				},
			},
			j_crv_yellow_card = {
				name = "Yellow Card",
				text = {
					"This Joker gains",
					"{C:chips}+#2#{} Chips for each",
					"{C:attention}Booster Pack{} ended",
					"without skipping",
					"{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)",
				},
			},
			j_crv_emergency_button = {
				name = "Emergency Button",
				text = {
					"Sell this {C:attention}Joker{} during",
					"a blind to gain {C:blue}+#1#{} Hands",
				},
			},
			j_crv_rainbow_octopus = {
				name = "Rainbow Octopus",
				text = {
					"Played {V:1}#2#{}",
					"has a {C:green}#3# in #4#{} chance to",
					"give {C:money}$#1#{} when scored",
					"{s:0.8}Suit changes after every round",
				},
			},
			j_crv_evil_joker = {
				name = "Evil Joker",
				text = {
					"Gains {C:mult}+#2#{} Mult",
					"when a joker is destroyed",
					"{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
				},
			},
			j_crv_rainbow = {
				name = "Rainbow",
				text = {
					"When {C:attention}first hand{} is drawn",
					"all cards in hand",
					"turns into a random suit",
					"selected from those cards",
				},
			},
			j_crv_useless_joker = {
				name = "Useless Joker",
				text = {
					"Always has a",
					"random {C:dark_edition}Edition{}",
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
			j_crv_spamton = {
				name = "Spamton J. Spamton",
				text = {
					"Press {C:attention}[[F1]]{} when {C:attention}READY{}",
					"and while in {C:attention}Blind{}",
					"to gain {C:blue}+#1#{} Hands and",
					"{C:red}+#2#{} Discard.",
					"Resets at end of ante",
					"{C:inactive}(Currently {V:1}#3#{C:inactive})",
				},
			},
			j_crv_paperwork = {
				name = "Paperwork",
				text = {
					"Scored cards between {C:attention}9{} and {C:attention}2",
					"gives {C:chips}+#1#{} Chips and",
					"{C:mult}+#2#{} Mult",
					"{C:inactive}(9 and 2 included){}",
				},
			},
			j_crv_plantain = {
				name = "Plantain",
				text = {
					"This {C:attention}Joker{} gives {X:mult,C:white}X#2#{} Mult and",
					"has {C:green}#3# in #4#{} chance to go extinct",
					"after #5# rounds have passed",
					"{C:inactive}(#1#/#5# Rounds have passed)",
				},
			},
			j_crv_red_banana = {
				name = "Red Banana",
				text = {
					"{C:mult}+#1#{} Mult",
					"{C:green}#2# in #3#{} chance",
					"this card is destroyed",
					"at end of round",
				},
			},
			j_crv_latundan = {
				name = "Latundan",
				text = {
					"Gains {C:chips}+#4#{} Chips{} for every round",
					"without a {C:attention}Gros Michel",
					"{C:green}#2# in #3#{} chance",
					"this card is destroyed",
					"at end of round",
					"{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)",
				},
			},
			j_crv_ticking_banana = {
				name = "Ticking Banana",
				text = {
					"Gives {X:mult,C:white}X#1#{} Mult",
					"{C:attention}#3#{} rounds after",
					"it has been bought",
					"and {C:red}self-destructs{}",
					"{C:inactive}({C:attention}#2#{C:inactive}/#3# Rounds passed)",
				},
			},
			j_crv_uncanny_banana = {
				name = "Uncanny Banana",
				text = {
					"{X:mult,C:white}X#1#{} Mult",
					"{C:inactive,S:0.8}Something is off..",
				},
			},
			j_crv_banana_of_doom = {
				name = "Banana of Doom",
				text = {
					"When {C:attention}Blind{} is selected",
					"destroys a random {C:attention}Joker{}",
					"until satisfied",
				},
			},
			j_crv_banana_template = {
				name = "Banana Template",
				text = {
					"Turns into a random {C:crv_banana}Banana{} Joker",
					"after #2# rounds have passed",
					"{C:inactive}(#1#/#2# Rounds have passed)",
				},
			},
			j_crv_jimbanana = {
				name = "Jimbanana",
				text = {
					"{C:mult}+#1#{} Mult.",
					"{C:green}#3# in #2#{} Chance to go extinct",
				},
			},
			j_crv_flytrap = {
				name = "Fly Trap",
				text = {
					"Each time a {C:clubs}Club{} card is",
					"scored, gain {C:chips}+#1#{} Chips.",
					"{C:inactive}(Currently {C:chips}+#2# {C:inactive}Chips)",
				},
			},
			j_crv_grosdish = {
				name = "Grosdish",
				text = {
					"{C:chips}+#1#{} Chips",
					"{C:green}#2# in #3#{} Chance to go extinct",
				},
			},
			j_crv_cavicheal = {
				name = "Caveicheal",
				text = {
					"{X:chips,C:white}X#1#{} Chips",
					"{C:green}#2# in #3#{} Chance to go extinct",
				},
			},
			j_crv_diamond_joker = {
				name = "Diamond Joker",
				text = {
					"Gives {X:mult,C:white} X#2# {} Mult",
					"for each {C:attention}Diamond Card",
					"in your {C:attention}full deck",
					"{C:inactive}(Currently {X:mult,C:white} X#1# {C:inactive} Mult)",
				},
			},
			j_crv_reinforced_glass_joker = {
				name = "Reinforced Glass Joker",
				text = {
					"Gives {X:mult,C:white} X#2# {} Mult",
					"for each {C:attention}Reinforced Glass Card",
					"in your {C:attention}full deck",
					"{C:inactive}(Currently {X:mult,C:white} X#1# {C:inactive} Mult)",
				},
			},
			j_crv_red_utopia = {
				name = "Red Utopia",
				text = {
					"{X:red,C:white} X#1# {} Mult if all",
					"cards held in hand are",
					"equal to or lower than {C:attention}4",
				},
			},
			j_crv_whiteboard = {
				name = "Whiteboard",
				text = {
					"{X:red,C:white} X#1# {} Mult if all",
					"cards held in hand are",
					"{V:1}#2#{}",
					"{s:0.8}suit changes at end of round",
				},
			},
			j_crv_checkpoint = {
				name = "Checkpoint",
				text = {
					"When sold, resets",
					"all {C:blue}hands{} and {C:red}discards{}",
					"but {C:red,E:1}halves{} your score"
				}
			},
			j_crv_goldfish = {
				name = "Goldfish",
				text = {
					"Retrigger each scored",
					"{C:gold}Gold{} card {C:attention}#1#{} times"
				}
			},
			j_crv_jimbo_show = {
				name = "Jimbo Show",
				text = {
					"Gains {X:mult,C:white}X#2#{} Mult",
					"when triggered",
					"{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)"
				}
			},
			j_crv_jnx = {
				name = "JNX",
				text = {
					"Gains {X:chips,C:white}X#2#{} Chips",
					"when triggered",
					"{C:inactive}(Currently {X:chips,C:white}X#1#{C:inactive} Chips)"
				}
			},
			j_crv_the_hand = {
				name = "The Hand",
				text = {
					"When {C:attention}Blind{} is selected",
					"destroys the {C:attention}Joker{}",
					"on the right",
					"no matter what"
				}
			},
			j_crv_stock_market = {
				name = "Stock Market",
				text = {
					"Gives {C:money}$#2#{} at end of the round.",
					"After every bonus, Multiply by {X:money,C:white}X#1#{}",
					"Has a {C:green}#3# in #4#{} chance to reset",
				},
			},
			j_crv_love_letter = {
				name = "Love Letter",
				text = {
					"Each time a {C:hearts}Heart{} card is",
					"scored, gains {C:mult}+#1#{} Mult.",
					"{C:inactive}(Currently {C:mult}+#2# {C:inactive}Mult)",
				},
			},
			j_crv_biker ={
                name="Biker",
                text={
                    "Every scored {C:attention}card{}",
                    "permanently gains",
                    "{C:mult}+#1#{} Mult when scored",
                },
            },
			j_crv_banker = {
				name = "Banker",
				text = {
					"Gain {C:money}+#1#{} when obtained",
					"Lose {C:red}-$#2#{} after every round",
					"Self-destructs when dept is fully paid",
					"{C:inactive}(Dept Paid: $#3#)",
					"{C:inactive}(Sell Value is Current Dept)",
				},
			},
			j_crv_tab_keeper = {
				name = "Tab Keeper",
				text = {
					"All rerolls are {C:green}free{}",
					"If this card is {C:red}removed{},",
					"pay {C:red}$5{} for each reroll used.",
					"{C:inactive}(Currently paying {C:red}$#1#{C:inactive})"
				},
			},
			j_crv_the_moon = {
				name = "The Moon",
				text = {
					"Scored {C:hearts}Hearts{}", "turns into {C:spades}Spades{}",
					"Scored {C:diamonds}Diamonds{}", "turns into {C:clubs}Clubs{}",
				},
			},
			j_crv_the_night_rose = {
				name = "The Night Rose",
				text = {
					"Scored {C:spades}Spades{}", "turns into {C:hearts}Hearts{}",
					"Scored {C:clubs}Clubs{}", "turns into {C:diamonds}Diamonds{}",
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
					"Turns scored {C:attention}Stone{} cards",
					"normal and gains {X:mult,C:white}X#2#{} Mult",
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
					"all purchased cards' costs",
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
			j_crv_the_knight = {
				name = "The Knight",
				text = {
					"{C:red}Discarded{} cards has",
					"a {C:green}#1# in #2#{} chance to",
					"gain {C:attention}#3#{} perma repetition"
				}
			},
			-- Printer
			j_crv_blueprinter = {
				name = "Blueprinter",
				text = {
					"When {C:attention}Blind{} is selected",
					"print a {C:attention}Blueprint{}",
					"{C:inactive}(Must have room)",
				},
			},
			j_crv_broken_blueprinter = {
				name = "Broken Blueprinter",
				text = {
					"When {C:attention}Blind{} is selected",
					"print a {C:attention}Blueprint{}",
					"{C:green}#1# in #2#{} chance to",
					"{C:red}self-destruct{}",
					"{C:inactive}(Must have room)",
				},
			},
			j_crv_gros_printer = {
				name = "Gros Printer",
				text = {
					"When {C:attention}Blind{} is selected",
					"print a random {C:attention}Banana{}",
					"{C:green}#1# in #2#{} chance to",
					"print {C:dark_edition}Holy Banana{}",
					"{C:inactive}(Must have room)",
				},
			},
			j_crv_rusty_printer = {
				name = "Rusty Printer",
				text = {
					"When {C:attention}Blind{} is selected",
					"print a {C:attention}Brainstorm{}",
					"{C:inactive}(Must have room)",
				},
			},
			j_crv_default_printer = {
				name = "Default Printer",
				text = {
					"When {C:attention}Blind{} is selected",
					"print a random",
					"{C:attention}Consumable{},{C:attention} Joker{}",
					"or {C:attention}Playing Card{}",
					"{C:inactive}(Must have room)",
				},
			},
			j_crv_joker_printer = {
				name = "Joker Printer",
				text = {
					"When {C:attention}Blind{} is selected",
					"print a {C:attention}Joker{}",
					"{C:inactive}(Must have room)",
				},
			},
			j_crv_obelisk_printer = {
				name = "Obelisk Printer",
				text = {
					"When {C:attention}Blind{} is selected",
					"print a {C:attention}Obelisk{}",
					"{C:inactive}(Must have room)",
				},
			},
			j_crv_golden_printer = {
				name = "Golden Printer",
				text = {
					"When {C:attention}Blind{} is selected",
					"print a random ",
					"{C:money}Economy{} Joker.",
					"{C:inactive}(Must have room)",
				},
			},
			j_crv_spectral_printer = {
				name = "Spectral Printer",
				text = {
					"When {C:attention}Blind{} is selected",
					"print a random",
					"{C:dark_edition}Spectral{} Card",
					"{C:inactive}(Must have room)",
				},
			},
			j_crv_legendary_printer = {
				name = "Legendary Printer",
				text = {
					"When {C:attention}Blind{} is selected",
					"{C:green}#1# in #2#{} chance to",
					"print a random",
					"{C:attention}Perishable{} and {C:dark_edition}Negative{}",
					"{C:legendary,E:1}Legendary{} Joker.",
					"{C:inactive}(Must have room)",
				},
			},
			j_crv_voucher_printer = {
				name = "Voucher Printer",
				text = {
					"When {C:attention}Blind{} is selected,",
					"print a random",
					"{C:attention}Voucher{}",
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
					"{C:attention}Contract{}",
				},
			},
			j_crv_camera = {
				name = "Camera",
				text = {
					"When {C:attention}Blind{} is selected",
					"print a {C:attention}Photograph{}",
					"if a {C:attention}Joker{} is present{}",
				},
			},
			j_crv_3d_printer = {
				name = "3D Printer",
				text = {
					"When entering {C:attention}Shop{},",
					"print a random",
					"{C:attention}Booster Pack{}",
				},
			},
			j_crv_time_printer = {
				name = "Time Printer",
				text = {
					"At end of round",
					"{C:green}#1# in #2#{} chance to",
					"print {C:attention}-#3#{} Ante.",
				},
			},
			-- Mega Printer
			j_crv_mega_printer = {
				name = "Mega Printer",
				text = {
					"When {C:attention}Blind{} is selected",
					"prints a random {C:red}Printer{}",
				},
			},
			--
			j_crv_energy_generator = {
				name = "Energy Generator",
				text = {
					"A powerful generator",
					"for something that requires",
					"efficent and much power",
					"Used to create the {C:dark_edition,E:1}Mega Printer",
					"{C:inactive}(1/3)",
				},
			},
			j_crv_printer_core = {
				name = "Printer Core",
				text = {
					"A huge printer",
					"that requires a lot",
					"of resources to function",
					"Used to create the {C:dark_edition,E:1}Mega Printer",
					"{C:inactive}(2/3)",
				},
			},
			j_crv_fluid_tank = {
				name = "Fluid Tank",
				text = {
					"Keeps a big machine",
					"suficent with any",
					"kind of fluid",
					"Used to create the {C:dark_edition,E:1}Mega Printer",
					"{C:inactive}(3/3)",
				},
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
			j_crv_chaetophobia = {
				name = "Chaetophobia",
				text = {
					"When first hand is drawn",
					"{C:attention}+#1#{} hand size for",
					"every card below {C:attention}5",
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
			-- Seals
			crv_printer_seal_seal = {
				name = "Printer's Seal",
				text = {
					"When scored, adds a copy",
					"of the card to hand",
					"{C:inactive}(Removes the seal from",
					"{C:inactive}the copied card)",
				},
			},
			--
			crv_immutable = {
				name = "Immutable Chances",
				text = {
					"This Card's {C:attention}listed",
					"{C:green,E:1,S:1.1}probabilities {C:red}cannot{}",
					"be changed via Jokers",
					"like {C:attention}Oops! All 6s",
				},
			},
		},
		Planet = {},
		Spectral = {
			c_crv_brush = {
				name = "Brush",
				text = {
					"Add a {C:purple}Printer's Seal",
					"to {C:attention}1{} selected",
					"card in your hand",
				},
			},
		},
		Stake = {},
		Tag = {
			tag_crv_jimfinity = {
				name = "Jimfinity Tag",
				text = { "Next shop has a free", "{C:attention}Jimfinity" },
			},
			tag_crv_3dprinter_tag = {
				name = "3D Printer Tag",
				text = { "Creates a random", "{C:attention}Booster Pack" },
			},
		},
		Tarot = {
			c_crv_ink_intuition = {
				name = "Ink & Intuition",
				text = {
					"{C:green}#1# in #2#{} chance to",
					"create a random {C:red}Printer{}",
				},
			},
			c_crv_dreams_desires = {
				name = "Dreams & Desires",
				text = {
					"Creates a random unowned",
					"part of the {C:dark_edition,E:1}Mega Printer{}",
				},
			},
		},
		Voucher = {},

		-- mod

		crv_Rune = {
			c_crv_fehu = {
				name = "Fehu",
				text = {
					"When active,",
					"{C:attention}Unscored cards{} give {C:money}+$#1#{}",
					"Lasts for {C:attention}#1#{C:inactive} (#2#){} round",
				},
			},
			c_crv_uruz = {
				name = "Uruz",
				text = {
					"When active,",
					"retrigger {C:attention}Scored Cards{}",
					"{C:attention}#3#{} time",
					"Lasts for {C:attention}#1#{C:inactive} (#2#){} round",
				},
			},
			c_crv_thurisaz = {
				name = "Thurisaz",
				text = {
					"When active,",
					"{C:red}Rare{} Jokers appear",
					"as much as {C:green}Uncommon{} Jokers",
					"Lasts for {C:attention}#1#{C:inactive} (#2#){} shop",
				},
			},
			c_crv_ansuz = {
				name = "Ansuz",
				text = {
					"When active,",
					"{C:green}#1# in #2#{} chance to create",
					"{C:legendary,E:1}The Soul{} after",
					"selecting a {C:attention}Blind",
					"Lasts for {C:attention}#3#{C:inactive} (#4#){} rounds",
				},
			},
			c_crv_raidho = {
				name = "Raidho",
				text = {
					"When active,",
					"{C:attention}Scored Cards{} gain a",
					"random {C:dark_edition}Enhancement{},",
					"{C:attention}Seal{} or {C:dark_edition}Edition{}",
					"Lasts for {C:attention}#1#{C:inactive} (#2#){} rounds",
				},
			},
			c_crv_kenaz = {
				name = "Kenaz",
				text = {
					"When active,",
					"{C:attention}Unscored cards{} are {C:red}destroyed",
					"Lasts for {C:attention}#1#{C:inactive} (#2#){} round",
				},
			},
			c_crv_gebo = {
				name = "Gebo",
				text = {
					"When active",
					"At the {C:attention}end of a round{},",
					"all owned Consumables",
					"turn {C:dark_edition}Negative{}",
					"Lasts for {C:attention}#1#{C:inactive} (#2#){} rounds",
				},
			},
			c_crv_wunjo = {
				name = "Wunjo",
				text = {
					"When active",
					"{C:attention}Scored cards{} gain",
					"{C:money}+$#3#{} Permanent Dollars",
					"Lasts for {C:attention}#1#{C:inactive} (#2#){} round",
				},
			},
			c_crv_hagalaz = {
				name = "Hagalaz",
				text = {
					"When active,",
					"draw {C:attention}#3#{} extra cards",
					"after {C:red}discarding{}",
					"Lasts for {C:attention}#1#{C:inactive} (#2#){} rounds",
				},
			},
			c_crv_isa = {
				name = "Isa",
				text = {
					"When active,",
					"{C:red}debuffed{} cards",
					"give {X:mult,C:white}X#3#{} Mult",
					"Lasts for {C:attention}#1#{C:inactive} (#2#){} rounds",
				},
			},
			c_crv_jera = {
				name = "Jera",
				text = {
					"When active,",
					"duplicate the {C:attention}rightmost{}",
					"scoring card",
					"Lasts for {C:attention}#1#{C:inactive} (#2#){} hands",
				},
			},
			c_crv_eihwaz = {
				name = "Eihwaz",
				text = {
					"When active,",
					"disable the selected {C:attention}Blind{}",
					"Lasts for {C:attention}#1#{C:inactive} (#2#){} blind",
				},
			},
			c_crv_perthro = {
				name = "Perthro",
				text = {
					"When active,",
					"gain a random {C:attention}Tag{}",
					"at the end of the round.",
					"Lasts for {C:attention}#1#{C:inactive} (#2#){} rounds",
				},
			},
			c_crv_algiz = {
				name = "Algiz",
				text = {
					"When active,",
					"multiply the selected {C:attention}Blinds{}",
					"requirement by {X:attention,C:white}X#3#{}",
					"Lasts for {C:attention}#1#{C:inactive} (#2#){} blinds",
				},
			},
			c_crv_sowilo = {
				name = "Sowilo",
				text = {
					"When active,",
					"{C:attention}Unscored cards{} give",
					"their rank as {C:chips}Chips",
					"Lasts for {C:attention}#1#{C:inactive} (#2#){} rounds",
				},
			},
			c_crv_towaz = {
				name = "Towaz",
				text = {
					"When active,",
					"{C:attention}+#3#{} card selection limit",
					"Lasts for {C:attention}#1#{C:inactive} (#2#){} rounds",
				},
			},
			c_crv_mannaz = {
				name = "Mannaz",
				text = {
					"When active,",
					"Played {C:attention}face cards{} give",
					"{X:chips,C:white}X#3#{} Chips",
					"{s:0.8}debuffed cards included",
					"Lasts for {C:attention}#1#{C:inactive} (#2#){} rounds",
				},
			},
			c_crv_berkana = {
				name = "Berkana",
				text = {
					"When active,",
					"{C:attention}+#3#{} hand size until",
					"Lasts for {C:attention}#1#{C:inactive} (#2#){} rounds",
				},
			},
			c_crv_othala = {
				name = "Othala",
				text = {
					"When active",
					"{C:blue}+#3#{} hands until",
					"Lasts for {C:attention}#1#{C:inactive} (#2#){} rounds",
				},
			},
			c_crv_inguz = {
				name = "Inguz",
				text = {
					"When active,",
					"{C:red}+#3#{} discards until",
					"Lasts for {C:attention}#1#{C:inactive} (#2#){} rounds",
				},
			},
		},

		crv_Contracts = {
			c_crv_glass_contract = {
				name = "Glass Contract",
				text = {
					"Upgrades up to {C:attention}1{}",
					"selected {C:attention}Glass Cards{}",
					"to {C:dark_edition}Reinforced Glass{}",
					"{C:green}#1# in #2#{} chance to",
					"destroy the card",
				},
			},
			c_crv_steel_contract = {
				name = "Steel Contract",
				text = {
					"Upgrades up to {C:attention}1{}",
					"selected {C:attention}Steel Cards{}",
					"to {C:dark_edition}Diamond Card{}",
					"{C:green}#1# in #2#{} chance to",
					"destroy the card",
				},
			},
			c_crv_gold_contract = {
				name = "Gold Contract",
				text = {
					"Upgrades up to {C:attention}1{}",
					"selected {C:attention}Gold Cards{}",
					"to {C:dark_edition}Rhodium Card{}",
					"{C:green}#1# in #2#{} chance to",
					"destroy the card",
				},
			},
			c_crv_mult_contract = {
				name = "Mult Contract",
				text = {
					"Upgrades up to {C:attention}1{}",
					"selected {C:attention}Mult Cards{}",
					"to {C:dark_edition}Xmult Card{}",
					"{C:green}#1# in #2#{} chance to",
					"destroy the card",
				},
			},
			c_crv_lucky_contract = {
				name = "Lucky Contract",
				text = {
					"Upgrades up to {C:attention}1{}",
					"selected {C:attention}Lucky Cards{}",
					"to {C:dark_edition}Blessed Card{}",
					"{C:green}#1# in #2#{} chance to",
					"destroy the card",
				},
			},
			c_crv_bonus_contract = {
				name = "Bonus Contract",
				text = {
					"Upgrades up to {C:attention}1{}",
					"selected {C:attention}Bonus Cards{}",
					"to {C:dark_edition}Boosted Card{}",
					"{C:green}#1# in #2#{} chance to",
					"destroy the card",
				},
			},
		},

		crv_cartridge = {
			c_crv_glitchy = {
				name = "Glitchy Cartridge",
				text = {
					"When applied {C:red}Printer{}",
					"is triggered,",
					"retrigger the {C:red}Printer{}",
					"{C:inactive}(Must have room)",
				},
			},
			c_crv_mixed = {
				name = "Mixed Cartridge",
				text = {
					"Cards printed",
					"by the applied {C:red}Printer{}",
					"has a random {C:dark_edition}Edition",
				},
			},
			c_crv_ghostly = {
				name = "Ghostly Cartridge",
				text = {
					"Cards printed",
					"by the applied {C:red}Printer{}",
					"fills {C:dark_edition}0{} slots",
				},
			},
			c_crv_golden = {
				name = "Golden Cartridge",
				text = {
					"Cards printed",
					"by the applied {C:red}Printer{}",
					"has double the sell cost",
				},
			},
			c_crv_soul = {
				name = "Cartridge Soul",
				text = {
					"When applied {C:red}Printer",
					"is triggered,",
					"has a small chance to",
					"create {C:dark_edition}The Soul{}",
				},
			},
			c_crv_spin = {
				name = "Spinny Cartridge",
				text = {
					"Applied {C:red}Printer{}",
					"continuously spins",
				},
			},
			c_crv_anti = {
				name = "Anti Cartridge",
				text = {
					"Applied {C:red}Printer{}",
					"becomes {C:dark_edition}Negative{}",
				},
			},
			c_crv_bonus = {
				name = "Bonus Cartridge",
				text = {
					"When applied {C:red}Printer",
					"is triggered,",
					"creates a random {C:attention}Tag{}",
				},
			},
		},
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
			crv_contracts = "Contracts",
			crv_runes = "Runes",
			-- Rariities
			k_crv_holy = "Holy Banana",
			k_crv_printer = "Printer",
			-- Text
			k_crv_split = "Split!",
			k_crv_half = "Halved!",
			k_crv_ready = "Ready",
			k_crv_destroyed = "Destroyed",
			k_crv_sticky = "Sticky!",
			s_crv_ready = "READY",
			s_crv_not_ready = "NOT READY",
			k_crv_boom_ex = "Boom!",
			k_printed_ex = "Printed!",
			-- Consumabels
			k_crv_cartridge = "Cartridge",
			b_crv_cartridge_cards = "Cartridges",

			k_crv_contracts = "Contract",
			b_crv_contracts_cards = "Contracts",

			k_crv_rune = "Rune",
			b_crv_rune_cards = "Runes",
		},
		high_scores = {},
		labels = {
			-- Seals
			crv_printer_seal_seal = "Printer's Seal", -- SEAL SEAL
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
