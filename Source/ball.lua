import "CoreLibs/graphics"
import "CoreLibs/math"

local gfx <const> = playdate.graphics

local ballRadius <const> = 5

local function drawBall()
	gfx.setColor(gfx.kColorBlack)
	gfx.setLineWidth(0)
	gfx.drawCircleAtPoint(ballRadius, ballRadius, ballRadius)
end

local function updateBall(self)
	if (self.ballSpeed == 0) then
		self:moveTo(-10, -10)
		return
	end

	local angle = self.arcStartAngle + (self.arcEndAngle - self.arcStartAngle) * self.ballSpeed
	local x = self.arcCenterX + self.arcRadius * math.cos(angle)
	local y = self.arcCenterY + self.arcRadius * math.sin(angle)

	self:moveTo(x, y)

	self.ballSpeed += self.ballSpeedIncrement
	if (self.ballSpeed >= 1) then
		self:reset()
	end
end

local function collisonResponse()
	return "bounce"
end

local function reset(self)
	self:moveTo(-10, -10)
	self.ballSpeed = 0
	self.ballSpeedIncrement = 0
	self.arcStartAngle = 0
	self.arcEndAngle = 0
	self.arcCenterX = 0
	self.arcCenterY = 0
	self.arcRadius = 0
end

local function launch(self, power, startPoint, endPoint)
	-- Define the center and radius of the arc
	self.arcCenterX = (startPoint.x + endPoint.x) / 2
	self.arcCenterY = (startPoint.y + endPoint.y) / 2
	self.arcRadius = math.sqrt((endPoint.x - startPoint.x) ^ 2 + (endPoint.y - startPoint.y) ^ 2) / 2

	-- Define the start and end angles of the arc
	self.arcStartAngle = math.atan(startPoint.y - self.arcCenterY, startPoint.x - self.arcCenterX)
	self.arcEndAngle = math.atan(endPoint.y - self.arcCenterY, endPoint.x - self.arcCenterX)

	self.ballSpeedIncrement = math.min(0.05, math.max(0.02, power / 1000));

	-- Set the starting speed
	self.ballSpeed = self.ballSpeedIncrement
end

function CreateBall()
	local ball = gfx.sprite.new()
	ball.draw = drawBall
	ball.update = updateBall
	ball.collisonResponse = collisonResponse
	ball.reset = reset
	ball.launch = launch
	ball:setSize(10, 10)
	ball:setCollideRect(1, 1, 8, 8)
	ball:reset()

	return ball
end
