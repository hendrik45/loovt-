function get_mario_keyboard(world)
	if(love.keyboard.isDown("left")) then
		world.mario_av.x = world.mario_av.x - 0.16
	end
	if(love.keyboard.isDown("right")) then
		world.mario_av.x = world.mario_av.x + 0.16
	end
	if(love.keyboard.isDown("up") and (not MARIO_FALLING) and JUMP_POWER > 0.0) then
		world.mario_av.y = world.mario_av.y - 0.2
		JUMP_POWER = JUMP_POWER - 1.0
	end
end

function simulate_mario_physics(world)
	world.mario_av.y = world.mario_av.y + GRAVITY
	if world.mario_av.y > TERMV then world.mario_av.y = TERMV end
	world.mario_av.x = (world.mario_av.x / 2.0)
	
	perform_collision_testing(world)
	
	world.mario_x = world.mario_x + world.mario_av.x
	world.mario_y = world.mario_y + world.mario_av.y
	
	local split_point_tile   = (love.graphics.getWidth() / SCALE) * 0.4
	local split_point_screen = love.graphics.getWidth() * 0.4
	
	if(world.mario_x > split_point_tile) then
		CAMERA_X = 0 + split_point_screen - (world.mario_x * SCALE)
	else
		CAMERA_X = 0
	end
end

function draw_mario(wd)
	love.graphics.setColor(255, 32, 32, 255)
	love.graphics.rectangle("fill", wd.mario_x * SCALE, (wd.mario_y - MARIO_HEIGHT) * SCALE, MARIO_WIDTH * SCALE, MARIO_HEIGHT * SCALE)
end

function mario_death()
	WORLD_STATE = WORLD_DOOM
	AUDIO_OVERWORLD:stop()
	AUDIO_DEATH:play()
end