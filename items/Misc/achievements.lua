RevosVault.Achievement = SMODS.Achievement :extend({
    atlas = "crv_ach",
    pos = {x=0,y=0},
    hidden_pos = {x=1,y=0},
    bypass_all_unlocked = true
})

RevosVault.Achievement ({
    key = "get_all_stickers",
    unlock_condition = function(self, args)
        if args.type == "howdidwegethere" then
            return true
        end
    end
})

RevosVault.Achievement ({
    key = "printing_away",
    unlock_condition = function(self, args)
        if args.type == "obtain_printer" then
            return true
        end
    end
})

RevosVault.Achievement ({
    key = "mega_printer",
    unlock_condition = function(self, args)
        if args.type == "megaify" then
            return true
        end
    end
})

RevosVault.Achievement ({
    key = "buckshotifying",
    unlock_condition = function(self, args)
        if args.type == "buckshotify" then
            return true
        end
    end
})

RevosVault.Achievement ({
    key = "vaultingify",
    unlock_condition = function(self, args)
        if args.type == "vaulting_it" then
            return true
        end
    end
})

RevosVault.Achievement ({
    key = "lame_card",
    unlock_condition = function(self, args)
        if args.type == "revoing_it" then
            return true
        end
    end
})

RevosVault.Achievement ({
    key = "welcome_mine",
    unlock_condition = function(self, args)
        if args.type == "gemming_it" then
            return true
        end
    end
})


RevosVault.Achievement ({
    key = "pedro_mayhem",
    unlock_condition = function(self, args)
        if args.type == "pedro_go_brr" then
            return true
        end
    end
})

RevosVault.Achievement ({
    key = "cursed",
    unlock_condition = function(self, args)
        if args.type == "clovering_it" then
            return true
        end
    end
})

RevosVault.Achievement ({
    key = "purification",
    unlock_condition = function(self, args)
        if args.type == "purifying_it" then
            return true
        end
    end
})

RevosVault.Achievement ({
    key = "appreciation",
    unlock_condition = function(self, args)
        if args.type == "crv_appreciation" then
            return true
        end
    end
})

RevosVault.Achievement ({
    key = "twisted",
    unlock_condition = function(self, args)
        if args.type == "crv_twisted" then
            return true
        end
    end
})

RevosVault.Achievement ({
    key = "mythical",
    unlock_condition = function(self, args)
        if args.type == "crv_myths" then
            return true
        end
    end
})

RevosVault.Achievement ({
    key = "flip",
    unlock_condition = function(self, args)
        if args.type == "crv_iamtheone" then
            return true
        end
    end
})



-- last
RevosVault.Achievement ({
    key = "secret_joker",
    hidden_text = true,
    unlock_condition = function(self, args)
        if args.type == "secretify" then
            return true
        end
    end
})