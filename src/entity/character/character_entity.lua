--! file: character.lua
require "src/entity/base_entity"
require "src/util/sprite/sprite"
CharacterEntity = Object.extend(BaseEntity)


function CharacterEntity.new(self, posX, posY)
    self.sprite = nil
    self:loadSprite("resources/bread.png")
end

function CharacterEntity.loadSprite(self, imagePath)
    self.sprite = Sprite(imagePath, 0, 0)
end


function CharacterEntity.update(self, dt)

end


function CharacterEntity.draw(self)
    self.sprite:draw()
end