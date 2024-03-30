local gfx <const> = playdate.graphics

local player_width <const> = 15
local player_height <const> = 60

local function drawPlayer()
	gfx.setLineWidth(1)
	gfx.setColor(gfx.kColorBlack)
	gfx.drawRect(0, 0, player_width, player_height)
end

local function updatePlayer()

end

function CreatePlayer()
	local playerImage = gfx.image.new("Images/player")
	assert(playerImage)

	local player = gfx.sprite.new(playerImage)
	player.draw = drawPlayer
	player.update = updatePlayer
	player:moveTo(40, 180)

	-- Setup mutable state for the player
	player.power = 0
	player.power_direction = "increase"

	return player
end
