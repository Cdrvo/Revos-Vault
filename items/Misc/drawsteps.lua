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