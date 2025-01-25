--! file: collision_handler.lua
CollisionHandler = Object.extend(Object)

-- wrapper de windfield

function CollisionHandler.new(self)
    local windfield = require "src.lbr.windfield"
    self.world = windfield.newWorld()
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

-- Getting colliders (coll box types)
function CollisionHandler.newRectangleCollider(self, x, y, w, h)
    return self.world:newRectangleCollider(x, y, w, h)
end

function CollisionHandler.newCircleCollider(self, x, y, r)
    return self.world:newCircleCollider(x, y, r)    -- TODO: sin probar
end

-- Querying collisions
function CollisionHandler.queryRectangleArea(self, x, y, h, w, collisionClasses)
    return self.world:queryRectangleArea(x, y, h, w, collisionClasses)
end


-- Handling entity collisions
function CollisionHandler.handleCollisions(self, gameEntity)
    local detectedCollisions = gameEntity.collider:getCollisions()
    if not detectedCollisions then return end
    for i = 1, #detectedCollisions do
        -- TODO: gestionar las colisiones de la entidad que reciba. emitir evento, etc
        print(detectedCollisions[i]:getObject().name)
    end
end
