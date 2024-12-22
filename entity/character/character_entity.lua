--! file: character.lua
require "entity/base_entity"
require "util/sprite"
CharacterEntity = Object.extend(BaseEntity)


function CharacterEntity.new(self, posX, posY)
    self.sprite = Sprite(16, 16, posX, posY)
end


function CharacterEntity.update(self, dt)
   
end


function CharacterEntity.draw(self)
    self.sprite:draw()
end