--! file: game_entity.lua
_G.entityIdCounter = 1

GameEntity = _G.Object.extend(Object)

function GameEntity.new(self)
    self.entityId = nil
    self:setId()
	self.state_machine = nil
    self.sprite = nil
    self.collider = nil
    self.name = ""
end

function GameEntity.setId(self) -- autoincrement
    self.entityId = entityIdCounter
    _G.entityIdCounter = entityIdCounter + 1
end

-- love2D functions
function GameEntity.load(self)
end

function GameEntity.update(self, dt)
end

function GameEntity.draw(self)
    self.sprite:draw()
end	-- TODO: quiozás estos métodos deberían estar en cada una de las clases hijas

-- Sprite
function GameEntity.loadSprite(self, imagePath)
    self.sprite = Sprite(imagePath, 0, 0)
    self.posX = self.sprite.posX;
    self.posY = self.sprite.posY;
end

-- Entity position
function GameEntity.getPositionV(self)
    return Vector2(self.sprite.posX, self.sprite.posY)
end

function GameEntity.getPosition(self)
    return self.sprite.posX, self.sprite.posY
end

function GameEntity.setPositionV(self, pos)
    self:setPosition(pos.x, pos.y)
end

function GameEntity.setPosition(self, x, y)
    -- udpating sprite position
    self:setSpritePosition(x, y)
    -- udpating collider position
    self:setColliderPosition(x, y)
end

function GameEntity.setColliderPosition(self, x, y)
    self.collider:setPosition(x+worldCellSize/2, y+worldCellSize/2)    -- TODO: igual esto debería ir en nuestro CollisionHandler
end

function GameEntity.setSpritePosition(self, x, y)
    self.sprite.posX = x
    self.sprite.posY = y
end


function GameEntity.getCollider(self)
    return self.collider
end

