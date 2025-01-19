--! file: base_entity.lua
BaseEntity = _G.Object.extend(Object)

function BaseEntity.new(self)
	self.state_machine = nil
    self.sprite = nil
    self.collider = nil
    self.name = ""
end

-- love2D functions
function BaseEntity.load(self)
end

function BaseEntity.update(self, dt)
end

function BaseEntity.draw(self)
    self.sprite:draw()
end	-- TODO: quiozás estos métodos deberían estar en cada una de las clases hijas

-- Sprite
function BaseEntity.loadSprite(self, imagePath)
    self.sprite = Sprite(imagePath, 0, 0)
    self.posX = self.sprite.posX;
    self.posY = self.sprite.posY;
end

-- Entity position
function BaseEntity.getPositionV(self)
    return Vector2(self.sprite.posX, self.sprite.posY)
end

function BaseEntity.getPosition(self)
    return self.sprite.posX, self.sprite.posY
end

function BaseEntity.setPositionV(self, pos)
    self:setPosition(pos.x, pos.y)
end

function BaseEntity.setPosition(self, x, y)
    -- udpating sprite position
    self:setSpritePosition(x, y)
    -- udpating collider position
    self:setColliderPosition(x+8, y+8)  -- TODO: el 8 a pelo son pruebas por el tamaño del sprite, guardar en variable en función de características del character
end

function BaseEntity.setColliderPosition(self, x, y)
    self.collider.body:setPosition(x, y)    -- TODO: igual esto debería ir en nuestro CollisionHandler
end

function BaseEntity.setSpritePosition(self, x, y)
    self.sprite.posX = x
    self.sprite.posY = y
end


