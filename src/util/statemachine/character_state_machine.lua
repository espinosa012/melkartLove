--! file: character_state_machine.lua
require "src.util.statemachine.base_state_machine"
CharacterStateMachine = Object.extend(BaseStateMachine)


function CharacterStateMachine.new(self)
    self.path = nil
    self:setState("IDLE")   -- estado por defecto para characters
end

function CharacterStateMachine.getPath(self)
    return self.path
end