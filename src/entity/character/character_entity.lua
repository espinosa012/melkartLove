--! file: character_entity.lua
require "src.entity.base_entity"
require "src.util.sprite.sprite"
require "src.util.statemachine.character_state_machine"

CharacterEntity = Object.extend(BaseEntity)

function CharacterEntity.new(self, posX, posY)
    -- TODO: llevar a un componente de atributos de este tipo
    self.movementSpeed = 2  -- px per frame

    self:loadSprite("resources/character.png")  -- TODO: test, quitar
    self:loadStateMachine()

    self:setPosition(posX, posY)
end

-- love2D 
function CharacterEntity.update(self, dt)
    BaseEntity.update(self, dt)
end

-- Sprite
function CharacterEntity.loadSprite(self, imagePath)
    BaseEntity.loadSprite(self, imagePath)
end

-- State machine
function CharacterEntity.loadStateMachine(self)
    self.state_machine = CharacterStateMachine()
end