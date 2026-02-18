if RevoConfig["experimental_enabled"] then --yes 

	for i = 1, 5 do
		SMODS.Joker({
		key = "deathcard" .. i,
		atlas = "wip",
		rarity = 1,
		cost = 4,
		pos = {
			x = 0,
			y = 0,
		},
		no_collection = true,
		in_pool = function(self)
			return false
		end
	})
	end

	SMODS.Joker({
		key = "placeholder_death",
		atlas = "wip",
		rarity = 1,
		cost = 4,
		pos = {
			x = 0,
			y = 0,
		},
		no_collection = true,
		in_pool = function(self)
			return false
		end
	})

end