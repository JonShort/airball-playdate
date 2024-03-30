import "CoreLibs/sprites"

local gfx <const> = playdate.graphics

local bar_width <const> = 60
local bar_height <const> = 5

local coord_x <const> = 45
local coord_y <const> = 230

local function drawBar()
  gfx.setLineWidth(1)
  gfx.setColor(gfx.kColorBlack)
  gfx.fillRect(0, 0, bar_width, bar_height)
end

local function updateBar(self)
  if (self.power ~= -1) then
    self:setClipRect(0 + 10, coord_y - 5, (bar_width * self.power) / 100, bar_height)
    self:moveTo(coord_x, coord_y)
  end
end

local function setPower(self, power)
  self.power = power
end

local function remove(self)
  self.power = -1
  self:moveTo(-100, -100)
end

function CreatePowerbar()
  local bar = gfx.sprite.new()
  bar.draw = drawBar
  bar.update = updateBar
  bar:setSize(bar_width, bar_height)
  bar.setPower = setPower
  bar.remove = remove
  bar:moveTo(-100, -100)

  -- Setup mutable state for the power bar
  bar.power = -1

  return bar
end
