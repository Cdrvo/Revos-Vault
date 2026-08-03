
SMODS.Sticker({ -- buff this
	key = "spamton_buff",
	pos = {
		x = 1,
		y = 0,
	},
	badge_colour = SMODS.Gradients["crv_spamton_gradient"],
	atlas = "revo_enhancements",
	rate = 0,
	needs_enable_flag = true,
	loc_vars = function(self, info_queue, card)
	return {
		vars = {},
	}
	end,
    calculate = function(self, card, context)
        if context.repetition then
            return{
                repetitions = 2
            }
        end
    end
})