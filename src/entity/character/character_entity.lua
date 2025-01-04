--! file: character.lua
require "src/entity/base_entity"
require "src/util/sprite/sprite"
require "src.util.statemachine.character_state_machine"
CharacterEntity = Object.extend(BaseEntity)


function CharacterEntity.new(self, posX, posY)
    self.state_machine = nil
    self.sprite = nil

    self:loadSprite("resources/character.png")  -- TODO: test, quitar
    self:loadStateMachine()

    self:setPosition(posX, posY)
end

function CharacterEntity.loadSprite(self, imagePath)
    -- TODO: habrá que determinar qué sprite usamos en función del tipo de personaje (clases herederas, enum de tipos de personajes, etc)
    self.sprite = Sprite(imagePath, 0, 0)
    self.posX = self.sprite.posX;
    self.posY = self.sprite.posY;
end

function CharacterEntity.loadStateMachine(self)
    self.state_machine = CharacterStateMachine()
end

function CharacterEntity.update(self, dt)
    -- TODO controlar la máquina de estados, etc. Esto debería ir en el controller

end


function CharacterEntity.draw(self)
    self.sprite:draw()
end


-- Position (TODO: igual podemos llevarlo a una clase padre)
function CharacterEntity.getPositionV(self)
    return Vector(self.sprite.posX, self.sprite.posY)
end

function CharacterEntity.getPosition(self)
    return self.sprite.posX, self.sprite.posY
end

function CharacterEntity.getPosX(self)
    return self.sprite.posX
end

function CharacterEntity.getPosY(self)
    return self.sprite.posY
end

function CharacterEntity.setPositionV(self, pos)
    self:setPosition(pos.x, pos.y)
end

function CharacterEntity.setPosition(self, x, y)    -- TODO: igual deberia estar en el propio controller
    self.sprite.posX = x
    self.sprite.posY = y
end