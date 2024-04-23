import "CoreLibs/graphics"
import "CoreLibs/timer"
import "CoreLibs/math"

local gfx <const> = playdate.graphics

local DEFAULT_TIME_IN_MS <const> = 30000
local POSITION_X <const> = 395
local POSITION_Y <const> = 5

local function drawText(self)
  local timeLeftInS = math.floor(self.timeLeft / 1000)
  gfx.drawTextAligned(timeLeftInS, POSITION_X, POSITION_Y, kTextAlignment.right)
end

function CreateTimer(callback, timeAmountInMS)
  local timeToRun = timeAmountInMS and timeAmountInMS or DEFAULT_TIME_IN_MS

  local timer = playdate.timer.new(timeToRun, callback);
  timer.updateCallback = drawText

  return timer
end
