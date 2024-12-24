--! file: base_entity.lua
BaseEntity = Object.extend(Object)


function BaseEntity.new(self)
	self.posX = nil
	self.posY = nil
end

function BaseEntity.update(self, dt)
end

function BaseEntity.draw(self)
end

function BaseEntity.updatePosition(self, x, y)
	self.posX = x
	self.posY = y
end
