import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "ball"
import "player"
import "stateMachine"

local gfx <const> = playdate.graphics
local snd <const> = playdate.sound

-- sounds
local synth = snd.synth.new(snd.kWaveSawtooth)
synth:setADSR(0, 0.1, 0, 0)

-- sprites
local player <const> = CreatePlayer()
local ball <const> = CreateBall()

-- values
local power_increase <const> = 3

-- scores (mutable)
local player_score = 0

-- gameplay (mutable)
local power = 0
local power_direction = "increase"

local function init()
	player_score = 0
	power = 0
	power_direction = "increase"

	-- setup sprites
	player:add()
	ball:add()
end

local function update()
	if (playdate.buttonJustPressed(playdate.kButtonA)) then
		power = 0
		power_direction = "increase"
	elseif (playdate.buttonIsPressed(playdate.kButtonA)) then
		-- Handle top of power bar
		if (power_direction == "increase" and power >= 100) then
			power_direction = "decrease"
			power = 100
		end

		-- Handle bottom of power bar
		if (power_direction == "decrease" and power <= 0) then
			power_direction = "increase"
			power = 0
		end

		local amount = power_direction == "increase" and power_increase or -power_increase

		power += amount
	elseif (playdate.buttonJustReleased(playdate.kButtonA)) then
		local endX = 340 * (power / 100) + 60
		ball:launch(power, { x = 40, y = 180 }, { x = endX, y = 220 })
	end

	gfx.sprite.update()
	playdate.timer.updateTimers()
	gfx.drawText(string.format("pow %i", power), 20, 220)
	gfx.drawText(string.format("score %i", player_score), 175, 5)
end

local function cleanup()
	player_score = 0
	power = 0
	power_direction = "increase"

	gfx.sprite.removeSprite(player)
	gfx.sprite.removeSprite(ball)
end

GameMethods = {
	init = init,
	update = update,
	cleanup = cleanup
}
