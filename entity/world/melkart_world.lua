--! file: melkart_world.lua
require "entity/base_entity"
MelkartWorld = Object.extend(BaseEntity)


function MelkartWorld.new(self, sizeX, sizeY)
	self.sizeX = sizeX
	self.sizeY = sizeY
end

function MelkartWorld.update(self, dt)
end

function MelkartWorld.draw(self)
end