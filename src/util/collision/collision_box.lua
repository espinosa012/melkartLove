--! file: collision_box.lua 
_G.CollisionBox = Object.extend(Object)

-- Simplemente define un rectángulo cuyo vértice superior izquierdo está en la posición (x, y) y con unas dimensiones de width x height


-- TODO: habría que pasarle el sprite al que le vamos a asociar
-- TODO: podríamos pasarle la función que ueremos que se ejecute al deteectar coliksión...
function CollisionBox.new(self, x, y, width, height, collisionClass, type)
    self.collider = nil
    self.x = nil
    self.y = nil
    self.width = width
    self.height = height
    if collisionClass then self.collisionClass = collisionClass else self.collisionClass = nil end
    if type then self.colliderType = type else self.colliderType = "static" end
    self:setCollider(x, y)
    -- TODO: es mejorable...
end

function CollisionBox.setCollider(self, x, y)
    self.collider = collisionHandler:newRectangleCollider(self.x, self.y, self.width, self.height)
    self.collider:setType(self.colliderType)
    self:setPosition(x, y)
    if self.collisionClass then self.collider:setCollisionClass(self.collisionClass) end
end

function CollisionBox.setPosition(self, x, y)
    self.x = x
    self.y = y
    self.collider.body:setPosition(x, y)    -- TODO: igual esto debería ir en nuestro CollisionHandler
end

function CollisionBox.getPosition(self)
    return self.collider.body:getPosition()
end

function CollisionBox.update(self, dt)  -- debe recibir dt??
    -- TODO: para comprobar las colisiones con otros colliders y realizar alguna acción cuando se detecte alguna
    local collisions = collisionHandler:queryRectangleArea(self.x, self.y, worldCellSize/2, worldCellSize/2, {"CharacterCollision"})   -- TODO: las detecta siempre, quizás detecte la propia
    -- eliminar de la lista devuelta por la query el propio collider (o hacer que tenga otra clase)
    if #collisions > 1 then -- TODO: así si... ,mayor que 1 pq el del character siempre está
    -- TODO: gestionar colisiones
        print(collisions[1])
    end
end -- TODO: desde el update del personaje (no sé...) se llama al update del collision box

-- TODO: usar el módulo de eventos, pasando funciones y argumentos, para gestionar las colisiones
