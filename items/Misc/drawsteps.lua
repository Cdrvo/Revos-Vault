SMODS.DrawStep({ --am i overcomplicating things again // :(
	key = "crv_eol",
	order = 60,
	func = function(self, layer)
		if
			self.config
			and self.config.center
			and self.config.center.key
			and self.config.center.key == "j_crv_empress_of_light"
		then
			if not self.children.the_empress_of_light_wow then
				self.children.the_empress_of_light_wow =
					SMODS.create_sprite(0, 0, 0, 0, self.config.center.empress_atlas, { x = 0, y = 0 })
			end
			self.children.the_empress_of_light_wow.role.draw_major = self
			self.children.the_empress_of_light_wow:draw_shader(
				"dissolve",
				nil,
				nil,
				nil,
				self.children.center,
				nil,
				nil,
				-0.65
			)
		end

		if
			self.config
			and self.config.center
			and self.config.center.key
			and self.config.center.key == "j_crv_moon_lord"
		then
			if not self.children.the_moon_lord_wow then
				self.children.the_moon_lord_wow =
					SMODS.create_sprite(0, 0, 0, 0, self.config.center.empress_atlas, { x = 1, y = 0 })
			end
			self.children.the_moon_lord_wow.role.draw_major = self
			self.children.the_moon_lord_wow:draw_shader(
				"dissolve",
				nil,
				nil,
				nil,
				self.children.center,
				nil,
				nil,
				-0.75
			)
		end
	end,
	conditions = { vortex = false, facing = "front" },
})


SMODS.DrawStep {
    key = 'crv_shattered_soul',
    order = 50,
    func = function(card)
        if card.config.center.key == "c_crv_shattered_soul" and (card.config.center.discovered or card.bypass_discovery_center) then
            if not G.crv_shattered_soul then
                G.crv_shattered_soul = Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS["crv_revo_spectrals"], {x=2, y=0})
            end
            local scale_mod = 0.05 + 0.05 * math.sin(1.8 * G.TIMERS.REAL) +
                0.07 * math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL)) * math.pi * 14) *
                (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 3
            local rotate_mod = 0.1 * math.sin(1.219 * G.TIMERS.REAL) +
                0.07 * math.sin((G.TIMERS.REAL) * math.pi * 5) * (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 2

            G.crv_shattered_soul.role.draw_major = card
            G.crv_shattered_soul:draw_shader('dissolve', 0, nil, nil, card.children.center, scale_mod, rotate_mod, nil,
                0.1 + 0.03 * math.sin(1.8 * G.TIMERS.REAL), nil, 0.6)
            G.crv_shattered_soul:draw_shader('dissolve', nil, nil, nil, card.children.center, scale_mod, rotate_mod)
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}


-- curse
SMODS.DrawStep {
    key = 'all_card_no_card',
    order = 9999999,
    func = function(self, layer)
        G.crv_nocards = G.crv_nocards or {}
        if self.ability.set == "Joker" and next(SMODS.find_card("j_crv_the_nameless_creature_that_shouldnotbe_spoken_of"))  then
            local ccard = G.P_CENTERS.j_crv_the_nameless_creature_that_shouldnotbe_spoken_of
            if not G.crv_nocards[ccard.key] then
                G.crv_nocards[ccard.key] = SMODS.create_sprite(0, 0, self.T.w,  self.T.h, ccard.atlas, {x = ccard.pos.x, y = ccard.pos.y})
            end
            G.crv_nocards[ccard.key].role.draw_major = self
            G.crv_nocards[ccard.key]:draw_shader('dissolve', nil, nil, nil, self.children.center)
            if self.edition then G.crv_nocards[ccard.key]:draw_shader(SMODS.Edition.obj_table[self.edition.key].shader, nil, self.ARGS.send_to_shader, nil, self.children.center) end

        end
    end,
    conditions = { vortex = false, facing = 'front' },
}
