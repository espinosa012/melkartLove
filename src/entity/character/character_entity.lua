--! file: character.lua
require "src/entity/base_entity"
require "src/util/sprite/sprite"
CharacterEntity = Object.extend(BaseEntity)


function CharacterEntity.new(self, posX, posY)
    self.sprite = nil
    self:loadSprite("resources/character.png")
end

function CharacterEntity.loadSprite(self, imagePath)
    -- TODO: habrá que determinar qué sprite usamos en función del tipo de personaje (clases herederas, enum de tipos de personajes, etc)
    self.sprite = Sprite(imagePath, 0, 0)
    self.posX = self.sprite.posX;
    self.posY = self.sprite.posY;
end


function CharacterEntity.update(self, dt)

end

function CharacterEntity.draw(self)
    self.sprite:draw()
end

function CharacterEntity.getPosition(self)
    return Vector(self.sprite.posX, self.sprite.posY)
end

function CharacterEntity.setPosition(self, x, y)    -- TODO: igual deberia estar en el propio controller
    self.posX = x
    self.sprite.posX = x
    self.posY = y
    self.sprite.posY = y
end