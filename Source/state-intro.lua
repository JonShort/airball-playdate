import "CoreLibs/graphics"

import "stateMachine"

local gfx <const> = playdate.graphics

local function init()
end

local function update()
	gfx.drawTextAligned("AIRBALL!", 200, 90, kTextAlignment.center)

	gfx.drawTextAligned("PRESS A TO PLAY", 200, 130, kTextAlignment.center)

	if (playdate.buttonJustReleased(playdate.kButtonA)) then
		SendGamestateAction("START_GAME")
	end
end

local function cleanup()
end

IntroMethods = {
	init = init,
	update = update,
	cleanup = cleanup
}
