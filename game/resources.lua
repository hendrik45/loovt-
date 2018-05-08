TEX_BRICK = love.graphics.newImage("brick.png")

TEX_COIN_F1 = love.graphics.newImage("coin1.png")
TEX_COIN_F2 = love.graphics.newImage("coin2.png")

FONT_DEFAULT = love.graphics.newFont(12)
FONT_RETRO   = love.graphics.newFont("ka1.ttf", SCALE)
FONT_RETRO_SMALLER = love.graphics.newFont("ka1.ttf", SCALE * 0.6)

AUDIO_OVERWORLD = love.audio.newSource("mario_overworld.ogg", "static")
AUDIO_OVERWORLD:setLooping(true)

AUDIO_DEATH = love.audio.newSource("mario_death.ogg", "static")
AUDIO_DEATH:setLooping(false)

AUDIO_COIN = love.audio.newSource("coin.ogg", "static")
AUDIO_COIN:setLooping(false)
