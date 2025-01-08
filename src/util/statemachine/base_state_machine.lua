--! file: base_state_machine.lua
BaseStateMachine = Object.extend(Object)

function BaseStateMachine.new(self)
    self.currentState = nil
end

function BaseStateMachine.getState(self)
    return self.currentState
end

function BaseStateMachine.setState(self, state)
    self.currentState = state
end