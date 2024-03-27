import "CoreLibs/graphics"

import "state-intro"
import "state-game"
import "state-results"

local gfx <const> = playdate.graphics

-- -- states
-- INTRO
-- GAME
-- RESULTS

-- -- actions
-- START_GAME
-- FINISH_GAME
-- RESTART

local current_state = "INTRO"
local state_methods = IntroMethods

-- this handles the very first init of intro
-- other inits are handled when state changes
state_methods.init()

local methodMap = {
	INTRO = IntroMethods,
	GAME = GameMethods,
	RESULTS = WinnerPlayerMethods,
}

local stateMap = {
	INTRO = {
		START_GAME = "GAME"
	},
	GAME = {
		FINISH_GAME = "RESULTS",
	},
	RESULTS = {
		RESTART = "INTRO"
	},
}

local function newState(new_state)
	-- cleanup
	state_methods.cleanup()

	-- setting up the new state
	current_state = new_state
	state_methods = methodMap[new_state]
	state_methods.init()
end

function SendGamestateAction(action)
	newState(stateMap[current_state][action])
	gfx.clear()
end

function StateUpdate()
	state_methods.update()
end
