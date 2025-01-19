--! file: collision_box.lua 
CollisionBox = Object.extend(Object)

-- TODO: habría que pasarle el sprite al que le vamos a asociar
function CollisionBox.new(self, sprite)
    self.x = sprite.posX
    self.y = sprite.posY
    self.width = sprite:getWidth()
    self.height = sprite:getHeight()
end

function CollisionBox.update(self)  -- debe recibir dt??
    self.x = self.sprite.posX
    self.y = self.sprite.posY
    self.width = self.sprite:getWidth()
    self.height = self.sprite:getHeight()
end

-- TODO: hay que encontrar la manera de que detecte automáticamente una colisión, sin tener que recibir explícitamente el collisionBox
function CollisionBox.checkCollision(self, collBox)
    return self.x + self.width > collBox.x
    and self.x < collBox.x + collBox.width
    and self.y + self.height > collBox.y
    and self.y < collBox.y + collBox.height
end