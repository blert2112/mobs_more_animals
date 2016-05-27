
if mobs.mod and mobs.mod == "redo" then

-- snowman
	mobs:register_mob("mobs_snowman:snowman", {
		type = "animal",
		lifetimer = 0,

		visual = "mesh",
		--visual_size = {x=1, y=1},
		mesh = "snowman.b3d",
		--gotten_mesh = "",
		--rotate = 0,
		collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
		animation = { 
			speed_normal = 24,	speed_run = 24,
			stand_start = 41,	stand_end = 90,
			walk_start = 1,		walk_end = 40,
			run_start = 1,		run_end = 40,
			punch_start = 1,	punch_end = 40,
			--punch2_start = 0,	punch2_end = 0,
			--shoot_start = 0,	shoot_end = 0,
			--speed_punch = 0,	speed_punch2 = 0,	speed_shoot = 0
		},
		textures = {
			{"default_coal_block.png", "default_coal_block.png", "snowman.png", "wool_orange.png"}
		},
		--gotten_texture = {},
		--child_texture = {},

		stepheight = 0.6,
		fear_height = 2,
		jump = true,
		--jump_chance = 0,
		jump_height = 5,
		fly = false,
		--fly_in = "air",
		walk_chance = 75,
		walk_velocity = 0.5,
		run_velocity = 0.5,
		--fall_speed = -10,
		floats = 0,

		view_range = 12,
		--follow = {},

		passive = true,
		runaway = true,
		pathfinding = false,
		--attack_type = "shoot",
		--damage = 1,
		--reach = 3,
		--docile_by_day = false,
		--attacks_monsters = false,
		--double_melee_attack = false,
		--group_attack = false,
		--explosion_radius = 1,
		--arrow = "mobs_snowman:snowball",
		--shoot_interval = 10,
		--shoot_offset = 1,
		--dogshoot_switch = 1,
		--dogshoot_count_max = 5,

		hp_min = 5,
		hp_max = 7,
		armor = 200,
		knock_back = 1,
		lava_damage = 7,
		fall_damage = 5,
		water_damage = 5,
		--light_damage = 0,
		--recovery_time = 0.5,
		immune_to = {{"default:snow", -1}},
		--blood_amount = 5,
		blood_texture = "default_snowball.png",

		makes_footstep_sound = true,
		--sounds = {},

		drops = {
			{name = "default:snow", chance = 1, min = 5, max = 15}
		},

		replace_what = {"air"},
		replace_with = "default:snow",
		replace_rate = 50,
		--replace_offset = 0,

		do_custom = function(self, dtime)
				if math.random(1000) >= 999 then
					local p1 = self.object:getpos()
					local objs = minetest.get_objects_inside_radius(p1, self.view_range)
					for i = 1,#objs do
						if objs[i]:is_player() then
							local p2 = objs[i]:getpos()
							local vec = {
								x = p2.x - p1.x,
								y = p2.y - p1.y,
								z = p2.z - p1.z
							}
							
							if vec.x ~= 0 and vec.z ~= 0 then
								local yaw = (math.atan(vec.z / vec.x) + math.pi / 2)
								if p2.x > p1.x then
									yaw = yaw + math.pi
								end
								self.object:setyaw(yaw)
							end
							
							local ent = minetest.add_entity({x=p1.x, y=p1.y+1.5, z=p1.z}, "mobs_snowman:snowball")
							ent:setvelocity(vec)
							ent:setacceleration({x=vec.x*0.5, y=-5, z=vec.z*0.5})
							break
						end
					end
				end
			end
		--custom_attack = function(self, to_attack)
			--end,
		--on_blast = funtion(object, damage)
				--return do_damage, do_knockback, drops
			--end,
		--on_die = function(self, pos)
			--end,
		--on_rightclick = function(self, clicker)
			--end
	})

	minetest.register_node("mobs_snowman:tophat", {
		description = "Top Hat",
		tiles = {"default_coal_block.png"},
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=3,flammable=3},
		paramtype = "light",
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {		
					{-0.25, -0.5, -0.25, 0.25, -0.4375, 0.25},
					{-0.125, -0.4375, -0.125, 0.125, -0.0625, 0.125}
				}
		},
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			local p = pos
			for i = 1,3 do
				p.y = p.y - 1
				local name = minetest.get_node(p).name
				if name ~= "default:snowblock" then
					return true
				end
			end
			for i = 1,4 do
				minetest.remove_node(p)
				p.y = p.y + 1			
			end
			p.y = p.y - 4
			minetest.add_entity(p, "mobs_snowman:snowman")
			return true
		end
	})
 
	minetest.register_craft({
		output = "mobs_snowman:tophat",
		recipe = {
			{"", "wool:black", ""},
			{"", "wool:black", ""},
			{"wool:black", "wool:black", "wool:black"}
		}
	})

core.register_entity("mobs_snowman:snowball", {
	physical = false,
	weight = 5,
	collisionbox = {0,0,0,0,0,0},
	visual = "sprite",
	visual_size = {x=0.5, y=0.5},
	textures = {"default_snowball.png"},
	automatic_rotate = false,
	
	timer = 20,

	on_step = function(self, dtime)
		local pos = self.object:getpos()

		self.timer = self.timer - dtime
		if self.timer < 0 then
			core.add_item(pos, "default:snow")
			self.object:remove()
			return self
		end

		local node = core.get_node_or_nil(pos)
		if node and node.name ~= "" and node.name ~= "default:snow" then
			if core.registered_nodes[node.name].walkable then
				self.object:setvelocity({x=0, y=0, z=0})
				self.object:setacceleration({x=0, y=0, z=0})
				pos.y = pos.y + 1
				minetest.set_node(pos, {name="default:snow"})
				self.object:remove()
				core.sound_play("default_dig_dig_immediate", {pos=pos, gain=1.0, max_hear_distance=7})
				return self
			end
		end

		if self.timer > 0.2 then
			local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 1)
			for i = 1,#objs do
				local obj = objs[i]
				if obj and ((obj:is_player()) or (obj:get_luaentity() and obj:get_luaentity().physical and obj:get_luaentity().name ~= "__builtin:item" )) then
					obj:punch(self.object, 1.0, {
						full_punch_interval=1.0,
						damage_groups = {fleshy=1},
					}, nil)
					self.object:remove()
					core.sound_play("default_dig_dig_immediate", {pos=pos, gain=1.0, max_hear_distance=7})
					break
				end
			end
		end
		return self
	end
})

end
