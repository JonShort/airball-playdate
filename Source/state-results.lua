import "CoreLibs/graphics"

import "stateMachine"

local gfx <const> = playdate.graphics

local player_score = 0

local function init(payload)
	player_score = payload.score
end

local function update()
	gfx.sprite.update()

	gfx.drawTextAligned("AIRBALL!", 200, 90, kTextAlignment.center)

	local points = player_score == 1 and "POINT" or "POINTS";
	gfx.drawTextAligned(string.format("YOU SCORED %0d %s", player_score, points), 200, 130, kTextAlignment.center)

	gfx.drawTextAligned("Press B to return to title screen", 200, 200, kTextAlignment.center)

	if (playdate.buttonJustReleased(playdate.kButtonB)) then
		SendGamestateAction("RESTART")
	end
end

local function cleanup()
end

WinnerPlayerMethods = {
	init = init,
	update = update,
	cleanup = cleanup
}
