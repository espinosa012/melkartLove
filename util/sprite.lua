--! file: sprite.lua
Sprite = Object.extend(BaseEntity)	-- TODO no se si debe heredar de aqui...

function Sprite.new(self, width, height, posX, posY)
	self.width = width
	self.height = height
	self.drawMode = "line"
	self:updatePosition(posX, posY)
	
	self.colorR = nil
	self.colorG = nil
	self.colorB = nil
	
end

function Sprite.setDrawMode(self, drawMode)
	self.drawMode = drawMode
end

function Sprite.setColor(self, r, g, b)
	self.colorR = r
	self.colorG = g
	self.colorB = b
end

function Sprite.draw(self)
	love.graphics.setColor(love.math.colorFromBytes(self.R, self.G, self.B))
    love.graphics.circle(self.drawMode, self.posX, self.posY, self.width/2)
end