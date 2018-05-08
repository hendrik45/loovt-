function perform_collision_testing_downward(world, count, pattern, by)
	if(count >= 2 and world.mario_av.y > 0) then
		MARIO_ON_GROUND = true
		MARIO_FALLING   = false
		JUMP_POWER = JUMP_POWER_DEFAULT
		world.mario_av.y = 0.0
		world.mario_y    = by - 1
	elseif(pattern[1] and world.mario_av.y > 0) then
		world.mario_av.x = 0.05
	elseif(pattern[4] and world.mario_av.y > 0) then
		world.mario_av.x = (0 - 0.05)
	elseif(count == 0 and world.mario_av.y > 0) then
		MARIO_FALLING = true
	end
end

function perform_collision_testing_upward(world, count, pattern)
	if(count >= 1 and world.mario_av.y < 0) then
		world.mario_av.y = 0.0
	end
end

function perform_collision_testing(world)
	if(world.mario_y > (world.height + 3)) then mario_death() end

	local ay = math.floor(world.mario_y - 0.2) + 1
	local by = math.floor(world.mario_y + 0.1) + 1
	local uy = math.floor(world.mario_y - MARIO_HEIGHT) + 1
	
	local x1 = math.floor(world.mario_x + 0.1) + 1
	local x2 = math.floor(world.mario_x + 0.3) + 1
	local x3 = math.floor(world.mario_x + 0.6) + 1
	local x4 = math.floor(world.mario_x + 0.9) + 1
	
	local x1u = math.floor(world.mario_x + 0.1) + 1
	local x4u = math.floor(world.mario_x + 0.9) + 1
	
	local pattern_down = {false, false, false, false}
	local pattern_up   = {false, false, false, false}
	
	if(in_range(by, 1, world.height)) then
		if(in_range(x1, 1, world.width)) then pattern_down[1] = world[x1][by] ~= AIR end
		if(in_range(x2, 1, world.width)) then pattern_down[2] = world[x2][by] ~= AIR end
		if(in_range(x3, 1, world.width)) then pattern_down[3] = world[x3][by] ~= AIR end
		if(in_range(x4, 1, world.width)) then pattern_down[4] = world[x4][by] ~= AIR end
	end
	
	if(in_range(uy, 1, world.height)) then
		if(in_range(x1u, 1, world.width)) then pattern_up[1] = world[x1u][uy] ~= AIR end
		if(in_range(x2, 1, world.width)) then pattern_up[2] = world[x2][uy] ~= AIR end
		if(in_range(x3, 1, world.width)) then pattern_up[3] = world[x3][uy] ~= AIR end
		if(in_range(x4u, 1, world.width)) then pattern_up[4] = world[x4u][uy] ~= AIR end
	end
	
	local next_tilexr = math.floor(world.mario_av.x + world.mario_x + MARIO_WIDTH) + 1.0
	local next_tilexl = math.floor(world.mario_av.x + world.mario_x) + 1.0
	
	if(in_range(next_tilexr, 1, world.width) and world.mario_av.x > 0 and next_tilexr > math.floor(world.mario_x) + 1.0) then
		if(world[next_tilexr][ay] ~= AIR) then
			world.mario_x = next_tilexr - MARIO_WIDTH - 1
			world.mario_av.x = 0.0
		end
	end
	
	if(in_range(next_tilexl, 1, world.width) and world.mario_av.x < 0 and next_tilexl < math.floor(world.mario_x) + 1.0) then
		if(world[next_tilexl][ay] ~= AIR) then
			world.mario_x = next_tilexl
			world.mario_av.x = 0.0
		end
	end
	
	local count_down = 0
	for k, v in pairs(pattern_down) do
		if v then count_down = count_down + 1 end
	end
	
	local count_up = 0
	for k, v in pairs(pattern_up) do
		if v then count_up = count_up + 1 end
	end
	
	if(in_range(x1, 1, world.width) and in_range(ay, 1, world.height)) then
		if(world[x1][ay] ~= AIR and world.mario_av.x < 0) then
			world.mario_av.x = 0.0
		end
	end
	
	if(in_range(x4, 1, world.width) and in_range(ay, 1, world.height)) then
		if(world[x4][ay] ~= AIR and world.mario_av.x > 0) then
			world.mario_av.x = 0.0
		end
	end
	
	if(x4 - 1 + world.mario_av.x < 0.0) then
		world.mario_av.x = 0.0
	end
	
	perform_collision_testing_downward(world, count_down, pattern_down, by)
	perform_collision_testing_upward(world, count_up, pattern_up)
end

--------------------------
-------- GENERIC ---------
--------------------------

function perform_collision_testing_downward_entity(world, entity, count, pattern)
	if(count >= 2 and entity.av.y > 0) then
		entity.av.y = 0.0
		entity.on_ground = true
	elseif(pattern[1] and entity.av.y > 0) then
		fdebug("ONE DOWNWARD")
		entity.av.x = 0.05
	elseif(pattern[4] and entity.av.y > 0) then
		entity.av.x = (0 - 0.05)
	end
end

function perform_collision_testing_upward_entity(world, entity, count, pattern)
	if(count >= 1 and entity.av.y < 0) then
		entity.av.y = 0.0
	end
end

function perform_collision_testing_entity(world, entity)
	local ay = math.floor(entity.y - 0.2) + 1
	local by = math.floor(entity.y + 0.1) + 1
	local uy = math.floor(entity.y - entity.height) + 1
	
	local x1 = math.floor(entity.x) + 1
	local x2 = math.floor(entity.x + 0.3) + 1
	local x3 = math.floor(entity.x + 0.6) + 1
	local x4 = math.floor(entity.x + 1.0) + 1
	
	local pattern_down = {false, false, false, false}
	local pattern_up   = {false, false, false, false}
	
	if(in_range(by, 1, world.height)) then
		if(in_range(x1, 1, world.width)) then pattern_down[1] = world[x1][by] ~= AIR end
		if(in_range(x2, 1, world.width)) then pattern_down[2] = world[x2][by] ~= AIR end
		if(in_range(x3, 1, world.width)) then pattern_down[3] = world[x3][by] ~= AIR end
		if(in_range(x4, 1, world.width)) then pattern_down[4] = world[x4][by] ~= AIR end
	end
	
	if(in_range(uy, 1, world.height)) then
		if(in_range(x1, 1, world.width)) then pattern_up[1] = world[x1][uy] ~= AIR end
		if(in_range(x2, 1, world.width)) then pattern_up[2] = world[x2][uy] ~= AIR end
		if(in_range(x3, 1, world.width)) then pattern_up[3] = world[x3][uy] ~= AIR end
		if(in_range(x4, 1, world.width)) then pattern_up[4] = world[x4][uy] ~= AIR end
	end
	
	local count_down = 0
	for k, v in pairs(pattern_down) do
		if v then count_down = count_down + 1 end
	end
	
	local count_up = 0
	for k, v in pairs(pattern_up) do
		if v then count_up = count_up + 1 end
	end
	
	entity.left_wall  = false
	entity.right_wall = false
	
	if(in_range(x1, 1, world.width) and in_range(ay, 1, world.height)) then
		if(world[x1][ay] ~= AIR and entity.av.x < 0) then
			entity.left_wall = true
			entity.av.x      = 0.0
		end
	end
	
	if(in_range(x4, 1, world.width) and in_range(ay, 1, world.height)) then
		if(world[x4][ay] ~= AIR and entity.av.x > 0) then
			entity.right_wall = true
			entity.av.x = 0.0
		end
	end
	
	if(x4 - 1 + entity.av.x < 0.0) then
		entity.av.x = 0.0
	end
	
	perform_collision_testing_downward_entity(world, entity, count_down, pattern_down)
	perform_collision_testing_upward_entity(world, entity, count_up, pattern_up)
end

function simulate_physics(world, entity)
	entity.av.y = entity.av.y + GRAVITY
	if entity.av.y > TERMV then entity.av.y = TERMV end
	entity.av.x = (entity.av.x / 2.0)
	
	perform_collision_testing_entity(world, entity)
	
	entity.x = entity.x + entity.av.x
	entity.y = entity.y + entity.av.y
end
