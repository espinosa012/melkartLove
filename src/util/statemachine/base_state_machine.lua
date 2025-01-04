--! file: base_state_machine.lua
BaseStateMachine = Object.extend(Object)

function BaseStateMachine.new(self)
    self.states = {  -- TODO: convertir en un enum...
        "IDLE", 
        "MOVING_UP", "MOVING_DOWN", "MOVING_LEFT", "MOVING_RIGHT", "MOVING_UP_RIGHT", "MOVING_UP_LEFT", "MOVING_DOWN_RIGHT", "MOVING_DOWN_LEFT"
    }
    self.currentState = nil
end


function BaseStateMachine.setState(self, state)
    self.currentState = state 
end