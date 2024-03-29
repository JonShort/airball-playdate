import "CoreLibs/graphics"
import "CoreLibs/math"

local gfx <const> = playdate.graphics

local ballRadius <const> = 5
local MIN_BALL_SPEED <const> = 0.04
local MAX_BALL_SPEED <const> = 0.05

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
	local goalX = self.arcCenterX + self.arcRadius * math.cos(angle)
	local goalY = self.arcCenterY + self.arcRadius * math.sin(angle)

	local actualX, actualY, collisions, numberOfCollisions = self:moveWithCollisions(goalX, goalY)

	if (numberOfCollisions > 0) then
		self.hasScored = true
	end

	self.ballSpeed += self.ballSpeedIncrement
	if (self.ballSpeed >= 1) then
		self:reset()
	end
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
	self.hasScored = false
end

local function launch(self, power, startPoint, endPoint)
	-- Define the center and radius of the arc
	self.arcCenterX = (startPoint.x + endPoint.x) / 2
	self.arcCenterY = (startPoint.y + endPoint.y) / 2
	self.arcRadius = math.sqrt((endPoint.x - startPoint.x) ^ 2 + (endPoint.y - startPoint.y) ^ 2) / 2

	-- Define the start and end angles of the arc
	self.arcStartAngle = math.atan(startPoint.y - self.arcCenterY, startPoint.x - self.arcCenterX)
	self.arcEndAngle = math.atan(endPoint.y - self.arcCenterY, endPoint.x - self.arcCenterX)

	self.ballSpeedIncrement = math.min(MAX_BALL_SPEED, math.max(MIN_BALL_SPEED, power / 1000));

	-- Set the starting speed
	self.ballSpeed = self.ballSpeedIncrement
end

local function checkForScore(self)
	local hasScored = self.hasScored

	if (hasScored) then
		self:reset()
	end

	return hasScored
end

function CreateBall()
	local ball = gfx.sprite.new()
	ball.draw = drawBall
	ball.update = updateBall
	ball.reset = reset
	ball.launch = launch
	ball.checkForScore = checkForScore
	ball:setSize(10, 10)
	ball:setCollideRect(1, 1, 8, 8)
	ball:reset()

	return ball
end
