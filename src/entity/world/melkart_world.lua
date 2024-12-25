--! file: melkart_world.lua
require "entity/base_entity"
MelkartWorld = Object.extend(BaseEntity)


function MelkartWorld.new(self, sizeX, sizeY, squareSizeX, squareSizeY)
	self.sizeX = sizeX
	self.sizeY = sizeY
	self.squareSizeX = squareSizeX
	self.squareSizeY = squareSizeY
end

function MelkartWorld.update(self, dt)
end

function MelkartWorld.draw(self)
end