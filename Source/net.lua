local gfx <const> = playdate.graphics

local width <const> = 40
local height <const> = 30
local speed <const> = 4

-- Initial positioning
local startX <const> = 400 - width
local startY <const> = 180

local maxX <const> = 400 - width
local minX <const> = 40 + width

local function drawNet()
  gfx.setLineWidth(1)
  gfx.setColor(gfx.kColorBlack)
  gfx.drawRect(0, 0, width, height)
end

local function updateNet(self)
  if (self.direction == "left" and self.x <= minX) then
    self.direction = "right"
  elseif (self.x >= maxX) then
    self.direction = "left"
  end

  local extraX = self.direction == "right" and speed or -speed

  self.x += extraX

  self:moveTo(self.x, self.y)
end

function CreateNet()
  local netImage = gfx.image.new("Images/net")
  assert(netImage)

  local net = gfx.sprite.new(netImage)
  net.draw = drawNet
  net.update = updateNet
  net:moveTo(startX, startY)
  net:setCollideRect(0, 0, width, 5)

  -- Setup mutable state for the net
  net.x = startX
  net.y = startY
  net.direction = "left"

  return net
end
