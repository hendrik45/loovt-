------ KONSTANDID
SCALE = 48.0 -- ühe ruudu suurus

AIR   = 0
BRICK = 1

MARIO_WIDTH  = 1.0
MARIO_HEIGHT = 1.3

JUMP_POWER_DEFAULT = 3.0

GRAVITY  = 0.04 -- accel per second
TERMV    = 0.2 -- max gravity velocity per second

WORLD_LOADS = 0
WORLD_PLAY  = 1
WORLD_DOOM  = 2

GOOMBA_SPAWNER_TIMER = 4.0

LOADS_MAX_TIME   = 2.0 -- sekundid TODO

DEBUG_PLAY_MUSIC = false -- TODO

---------------

CAMERA_X = 0.0
CAMERA_Y = 0.0

JUMP_POWER      = JUMP_POWER_DEFAULT
MARIO_ON_GROUND = false
MARIO_FALLING   = true

MARIO_LIVES = 3
MARIO_SCORE = 0
MARIO_COINS = 0

SCORE_COIN        = 100
SCORE_GOOMBA_KILL = 1000

WORLD_STATE = WORLD_LOADS
WORLD_NUMBER = 1 -- world X-x
WORLD_LEVEL  = 1 -- world x-X

require("util")
Goomba = require("entity_goomba")
Coin   = require("entity_coin")
GoombaSpawner = require("entity_goomba_spawner")

require("resources")

-- loo tühi maailm
function create_empty_world(w, h)
	-- mario_x ja mario_y märgivad Mario asukoha
	-- mario_av on Mario kiirendusvektor järgmise kaadri jaoks
	local t = {entities = {}, width = w, height = h, mario_x = 1.1, mario_y = 12.0, mario_av = {x = 0.0, y = 0.0}}
	for ww = 1, w do
		t[ww] = {}
		for hh = 1, h do
			t[ww][hh] = AIR
		end
	end
	return t
end

-- loo maailm üks
function create_world_one()
	local w1 = create_empty_world(128, 16)
	
	local GOOMBA_RAMP_OFFSET = 15
	local GOOMBA_JUMP_OFFSET = GOOMBA_RAMP_OFFSET + 32
	
	for i = 1, GOOMBA_RAMP_OFFSET + 29 do
		w1[i][16] = BRICK
	end
	w1[1][15] = BRICK
	w1[5][15] = BRICK
	w1[7][12] = BRICK
	w1[8][12] = BRICK
	w1[9][12] = BRICK
	w1[10][12] = BRICK
	
	table.insert(w1.entities, Coin.new(7, 10))
	table.insert(w1.entities, Coin.new(8, 10))
	table.insert(w1.entities, Coin.new(9, 10))
	table.insert(w1.entities, Coin.new(10, 10))
	
	table.insert(w1.entities, Goomba.new(11, 13))
	
	w1[15][15] = BRICK
	
	-------- PLATFORMS SECTION
	
	w1[18][12] = BRICK
	w1[19][12] = BRICK
	w1[20][12] = BRICK
	w1[27][12] = BRICK
	w1[28][12] = BRICK
	w1[29][12] = BRICK
	
	table.insert(w1.entities, Coin.new(18, 10))
	table.insert(w1.entities, Coin.new(19, 10))
	table.insert(w1.entities, Coin.new(20, 10))
	table.insert(w1.entities, Coin.new(27, 14))
	table.insert(w1.entities, Coin.new(28, 14))
	table.insert(w1.entities, Coin.new(29, 14))
	
	-------- GOOMBA RAMP SECTION
	
	local tx = GOOMBA_RAMP_OFFSET
	
	for x = 25, 29 do
		for y = 11, 15 do
			w1[tx + x][y] = BRICK
		end
	end
	
	w1[tx + 22][13] = BRICK
	
	table.insert(w1.entities, Goomba.new(tx + 29, 9))
	table.insert(w1.entities, Goomba.new(tx + 26, 9))
	
	table.insert(w1.entities, Coin.new(tx + 26, 8))
	table.insert(w1.entities, Coin.new(tx + 27, 8))
	table.insert(w1.entities, Coin.new(tx + 28, 8))
	table.insert(w1.entities, Coin.new(tx + 26, 7))
	table.insert(w1.entities, Coin.new(tx + 27, 7))
	table.insert(w1.entities, Coin.new(tx + 28, 7))
	
	tx = GOOMBA_JUMP_OFFSET
	
	for i = tx, tx + 8 do
		w1[i][16] = BRICK
	end
	
	for x = (tx + 8), (tx + 12) do
		for y = 11, 16 do
			w1[x][y] = BRICK
		end
	end
	
	table.insert(w1.entities, GoombaSpawner.new(tx + 11, 8))
	
	table.insert(w1.entities, Coin.new(tx + 14, 8))
	table.insert(w1.entities, Coin.new(tx + 15, 8))
	table.insert(w1.entities, Coin.new(tx + 16, 8))
	
	table.insert(w1.entities, Coin.new(tx + 14, 9))
	table.insert(w1.entities, Coin.new(tx + 15, 9))
	table.insert(w1.entities, Coin.new(tx + 16, 9))
	
	w1[tx + 14][11] = BRICK
	w1[tx + 15][11] = BRICK
	w1[tx + 16][11] = BRICK
	w1[tx + 16][12] = BRICK
	w1[tx + 17][12] = BRICK
	w1[tx + 17][13] = BRICK
	w1[tx + 18][13] = BRICK
	w1[tx + 18][14] = BRICK
	w1[tx + 19][14] = BRICK
	w1[tx + 19][15] = BRICK
	w1[tx + 20][15] = BRICK
	w1[tx + 20][16] = BRICK
	w1[tx + 21][16] = BRICK
	w1[tx + 22][16] = BRICK
	w1[tx + 23][16] = BRICK
	w1[tx + 24][16] = BRICK
	
	w1[tx + 28][16] = BRICK
	w1[tx + 29][16] = BRICK
	w1[tx + 30][16] = BRICK
	w1[tx + 31][16] = BRICK
	w1[tx + 31][15] = BRICK
	w1[tx + 32][16] = BRICK
	w1[tx + 32][15] = BRICK
	w1[tx + 32][14] = BRICK
	w1[tx + 33][16] = BRICK
	w1[tx + 33][15] = BRICK
	w1[tx + 33][14] = BRICK
	w1[tx + 33][13] = BRICK
	w1[tx + 34][16] = BRICK
	w1[tx + 34][15] = BRICK
	w1[tx + 34][14] = BRICK
	w1[tx + 34][13] = BRICK
	w1[tx + 34][12] = BRICK
	w1[tx + 35][16] = BRICK
	w1[tx + 35][15] = BRICK
	w1[tx + 35][14] = BRICK
	w1[tx + 35][13] = BRICK
	w1[tx + 35][12] = BRICK
	w1[tx + 35][11] = BRICK
	w1[tx + 36][16] = BRICK
	w1[tx + 36][15] = BRICK
	w1[tx + 36][14] = BRICK
	w1[tx + 36][13] = BRICK
	w1[tx + 36][12] = BRICK
	w1[tx + 36][11] = BRICK
	w1[tx + 36][10] = BRICK
	
	w1[tx + 37][16] = BRICK
	w1[tx + 37][15] = BRICK
	w1[tx + 37][14] = BRICK
	w1[tx + 37][13] = BRICK
	w1[tx + 37][12] = BRICK
	w1[tx + 37][11] = BRICK
	w1[tx + 37][10] = BRICK
	
	w1[tx + 38][16] = BRICK
	w1[tx + 38][15] = BRICK
	w1[tx + 38][14] = BRICK
	w1[tx + 38][13] = BRICK
	w1[tx + 38][12] = BRICK
	w1[tx + 38][11] = BRICK
	w1[tx + 38][10] = BRICK
	
	w1[tx + 39][16] = BRICK
	w1[tx + 39][15] = BRICK
	w1[tx + 39][14] = BRICK
	w1[tx + 39][13] = BRICK
	w1[tx + 39][12] = BRICK
	w1[tx + 39][11] = BRICK
	w1[tx + 39][10] = BRICK
	
	table.insert(w1.entities, Goomba.new(tx + 38, 6))
	table.insert(w1.entities, GoombaSpawner.new(tx + 38, 7))
	w1.entities[#w1.entities].interval = 1.7
	
	return w1
end

maailm = create_world_one()

function draw_world(wd)
	for x = 1, wd.width do
		if(x_visible(wd, x - 2) or x_visible(wd, x + 1)) then
			for y = 1, wd.height do
				if(wd[x][y] == AIR) then
					love.graphics.setColor(128, 128, 225, 255)
					love.graphics.rectangle("fill", (x - 1) * SCALE, (y - 1) * SCALE, SCALE, SCALE)
				end
				if(wd[x][y] == BRICK) then
					love.graphics.setColor(255, 255, 255, 255)
					love.graphics.draw(TEX_BRICK, (x - 1) * SCALE, (y - 1) * SCALE, 0, SCALE / 128, SCALE / 128)
				end
			end
		end
	end
end

require("collision_testing")
require("mario")

function think_entities(world)
	for k, v in pairs(world.entities) do
		if(v.think) then
			v:think(world)
		end
	end
end

function draw_entities(world)
	for k, v in pairs(world.entities) do
		if(v.draw and (x_visible(wd, v.x - 2) or x_visible(wd, v.x + 1))) then
			v:draw(world)
		end
	end
end

function render_hud()
	love.graphics.setFont(FONT_RETRO_SMALLER)
	love.graphics.print("x " .. tostring(MARIO_LIVES), 16, 16)
	love.graphics.print(pad_zeroes(tostring(MARIO_SCORE), 8), love.graphics.getWidth() - (8 * SCALE * 0.6), 16)
end

LOADS_DONE      = 0
LOADS_TIMER_SET = false

function render_loads()
	if(not LOADS_TIMER_SET) then
		LOADS_DONE = love.timer.getTime() + LOADS_MAX_TIME
		LOADS_TIMER_SET = true
	end
	love.graphics.setColor(0, 0, 0, 255)
	love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
	love.graphics.setFont(FONT_RETRO)
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print("x " .. tostring(MARIO_LIVES), love.graphics.getWidth() / 2 - ((SCALE * 2) / 2), love.graphics.getHeight() / 2 - SCALE / 2)
	love.graphics.print("MAAILM  " .. tostring(WORLD_LEVEL), love.graphics.getWidth() / 2 - ((SCALE * 2)/ 2), love.graphics.getHeight() / 1.8 - SCALE / 2)
	love.graphics.setFont(FONT_DEFAULT)
	if(LOADS_TIMER_SET and LOADS_DONE < love.timer.getTime()) then
		LOADS_TIMER_SET = false
		WORLD_STATE = WORLD_PLAY
		if(DEBUG_PLAY_MUSIC) then
			AUDIO_OVERWORLD:play()
		end
	end
end

DOOM_DONE       = 0
DOOM_TIMER_SET  = false

function handle_doom()
	if(not DOOM_TIMER_SET) then
		DOOM_DONE      = love.timer.getTime() + 3.3
		DOOM_TIMER_SET = true
	end
	if(DOOM_TIMER_SET and DOOM_DONE < love.timer.getTime()) then
		DOOM_TIMER_SET = false
		WORLD_STATE    = WORLD_LOADS
		MARIO_LIVES    = MARIO_LIVES - 1
		maailm         = create_world_one()
	end
end
function love.load()
   min_dt = 1/30 --fps
   next_time = love.timer.getTime()
end
function love.update()
	next_time = next_time + min_dt
end
function love.draw()
	-------------------
	local cur_time = love.timer.getTime()
		if next_time <= cur_time then
			next_time = cur_time
			return
		end
	love.timer.sleep(next_time - cur_time)
	love.graphics.push()
	love.graphics.translate(CAMERA_X, CAMERA_Y)

	if WORLD_STATE == WORLD_PLAY then
		get_mario_keyboard(maailm)
		simulate_mario_physics(maailm)
		think_entities(maailm)
	elseif WORLD_STATE == WORLD_DOOM then
		handle_doom()
	end
	if WORLD_STATE ~= WORLD_LOADS then
		draw_world(maailm)
		draw_mario(maailm)
		draw_entities(maailm)
	end
	
	draw_debug_lines()
	DEBUG_LINES = {}
	
	love.graphics.pop()
	------------------
	
	love.graphics.print(FRAME_DEBUG, 2, 2)
	FRAME_DEBUG = ""
	
	if WORLD_STATE == WORLD_LOADS then
		render_loads()
	elseif WORLD_STATE == WORLD_PLAY or WORLD_STATE == WORLD_DOOM then
		render_hud()
	end
end

