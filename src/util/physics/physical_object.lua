--! file: physical_object.lua 

_G.PhysicalObject = Object.extend(Object)


function PhysicalObject.new(self, gameEntity, world, posX, posY, width, height, type, collisionClassName)
    self.entity = gameEntity
    if type then self.type = type else self.type = "static" end
    self.body = love.physics.newBody(world, posX, posY, type)
    self.shape = love.physics.newRectangleShape(height, width)   -- TODO: de momento sólo con rectángulos
    self.fixture = love.physics.newFixture(self.body, self.shape)
    if collisionClassName then self.fixture:setUserData(collisionClassName) end
end

function PhysicalObject.setMass(self, mass)
   self.body:setMass(mass)
end

function PhysicalObject.getMass(self)
    return self.body:getMass()  -- TODO: untested
end