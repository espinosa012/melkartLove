--! file: collision_handler.lua
CollisionHandler = Object.extend(Object)

function CollisionHandler.new(self)
    self.windfield = require "src.lbr.windfield"
    self.world = self.windfield.newWorld()
    self:loadCollisionClasses()
end

function CollisionHandler.loadCollisionClasses(self)
    -- TODO: cargar de una tabla externa en la que guardemos todas las clases que definamos
    self.world:addCollisionClass("TestCollision")
    self.world:addCollisionClass("CharacterCollision")
end

function CollisionHandler.update(self, dt)
    self.world:update(dt)
end

function CollisionHandler.draw(self)
    self.world:draw()
end

function CollisionHandler.newRectangleCollider(self, x, y, w, h)
    return self.world:newRectangleCollider(x, y, w, h)
end


function CollisionHandler.queryRectangleArea(self, x, y, h, w, collisionClasses)
    return self.world:queryRectangleArea(x, y, h, w, collisionClasses)
end

