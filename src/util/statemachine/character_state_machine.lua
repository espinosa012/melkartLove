--! file: character_state_machine.lua
require "src.util.statemachine.base_state_machine"
CharacterStateMachine = Object.extend(BaseStateMachine)


function CharacterStateMachine.new(self)
    self.path = nil
    self.currentPathPosition = nil
    self:setState("IDLE")   -- estado por defecto para characters
end

function CharacterStateMachine.setCurrentPathPosition(self, index)
    self.currentPathPosition = index
end

function CharacterStateMachine.incCurrentPathPosition(self, index)
    self.currentPathPosition = self.currentPathPosition + 1
end

function CharacterStateMachine.getPath(self)
    return self.path
end