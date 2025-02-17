--! file: collision_box.lua 
_G.CollisionBox = Object.extend(Object)


-- Simplemente define un rectángulo cuyo vértice superior izquierdo está en la posición (x, y) y con unas dimensiones de width x height


-- TODO: podríamos pasarle la función que ueremos que se ejecute al deteectar colisión...
function CollisionBox.new(self, entity, shape, x, y, width, height, collisionClass, type)  -- TODO pasar de alguna manera el tipo de collider (rectangular, circular, etc). esto viene en windfield
    self.collider = nil
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    if collisionClass then self.collisionClass = collisionClass else self.collisionClass = nil end
    if type then self.colliderType = type else self.colliderType = "static" end
    if shape then self.shape = shape else self.shape = "rectangular" end

    -- TODO: sacar de aquí los tipos y llevar a una tabla externa
    if self.shape == "rectangular" then self:setRectangularCollider(x, y) end
    self:setObject(entity)

    self.handledCollisions = {}
    self.collidingEntities = List()
    -- TODO: es mejorable...
end

function CollisionBox.setObject(self, gameEntity)
    self.collider:setObject(gameEntity)
end

function CollisionBox.getObject(self)
    return self.collider:getObject()
end

function CollisionBox.setRectangularCollider(self, x, y)
    self.collider = collisionHandler:newRectangleCollider(self.x, self.y, self.width, self.height)
    self.collider:setType(self.colliderType)
    self:setPosition(x, y)
    if self.collisionClass then self.collider:setCollisionClass(self.collisionClass) end
end

function CollisionBox.setCircularCollider(self, x, y)
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
    -- para comprobar las colisiones con otros colliders y realizar alguna acción cuando se detecte alguna
    self.handledCollisions = self:getCollisions()
    -- if self.handledCollisions and #self.handledCollisions == 0 then return end

    -- TODO: el problema con esto es que no tenemos referencia a la entidad propietaria del collider detectado

    -- TODO: gestionar las colisiones en función  del tipo, etc
    -- for i=1, #collisions do
    --     print(collisions[i])
    -- end
    -- TODO: usar el módulo de eventos, pasando funciones y argumentos, para gestionar las colisiones
end 

--- devuelve una lista con todas las colisiones actuales
function CollisionBox.getCollisions(self, collisionClassNames)
    -- TODO: se debe optimizar. podríamos llamar a este desde el update del character para poder referenciarlo en la gestión de la colisión
    local x, y = self:getPosition()
    local collisions = collisionHandler:queryRectangleArea(x, y, worldCellSize, worldCellSize, collisionClassNames)
    if #collisions <= 1 then return nil end

    local detectedColls = List()
    for i=2, #collisions do detectedColls:add(collisions[i]) end
    return detectedColls.items -- TODO: cuidado, porque lo que devuelve no son CollisionBox de las nuestras, 
    -- sino las propias de windfield, de las cuales podremos obtener cierta información interesante.
    -- podríamos convertirlas en CollisionBoxes de las nuestras
    -- hacer bien, porque tendremos que gestionarlas luego para las interaciones, etc
end


-- TODO: hay que hacer que se puedan tener collider de tipo dynamic y que cuando cambie la posición del 
-- collider por interacciones físicas, se actualicen las posiciones del character o entidad correspondiente y de su sprite si lo tiene
--  habrá que tener una referencia a la entidad propietaria de la collision box

-- TODO: penmsar en collisionBox para edificios, quizá una individual poara cada vloque cuadrado del edificio, o intenetar hacer más eficiente.

-- todo: INVESTIGAR RAYCAST