--! file: physic_environment.lua.lua 

-- https://love2d.org/wiki/Tutorial:Physics

_G.PhysicEnvironment = Object.extend(Object )

function PhysicEnvironment.new(self)
    self.world = love.physics.newWorld(0, 0, true)
    self.world:setCallbacks(self.beginContact, self.endContact, self.preSolve, self.postSolve)

    self.objects = {}
end

function PhysicEnvironment.setMeter(self, meterInPx)
    love.physics.setMeter(meterInPx)
end

function PhysicEnvironment.beginContact(self, a, b, coll)
    local x,y = coll:getNormal()
    print("\n"..a:getUserData().." colliding with "..b:getUserData().." with a vector normal of: "..x..", "..y)
end

function PhysicEnvironment.endContact(self, a, b, coll)
    print("\n"..a:getUserData().." uncolliding with "..b:getUserData())
end

function PhysicEnvironment.preSolve(self, a, b, coll)
    -- only say when they first start touching
    print("\n"..a:getUserData().." touching "..b:getUserData())
end

function PhysicEnvironment.postSolve(self, a, b, coll, normalimpulse, tangentimpulse)
	
end