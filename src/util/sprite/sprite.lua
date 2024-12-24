--! file: sprite.lua
require "util/data/color" 
Sprite = Object.extend(Object)	-- TODO no se si debe heredar de aqui...

function Sprite.new(self, imagePath, posX, posY)
	self:loadImage(imagePath, nil)
	self.posX = posX
	self.posY = posY
	self.scaleX = 1
	self.scaleY = 1
	self.originOffsetX = 0
	self.originOffsetY = 0
	self.shearingX = 0
	self.shearingY = 0

	self.rotation = 0

	self.color = nil

	self.drawMode = "line"
end

function Sprite.setDrawMode(self, drawMode)
	self.drawMode = drawMode
end

function Sprite.loadImage(self, imagePath, settings)
	self.image = love.graphics.newImage(imagePath)
end

function Sprite.rotate(r)
	self.rotation = r
end

function Sprite.mirrorImageX(self)
	self.scaleX = self.scaleX * -1
end

function Sprite.mirrorImageY()
	self.scaleY = self.scaleY * -1
end

function Sprite.setColor(self, r, g, b)
	self.color = Color(r, g, b) 
end

function Sprite.draw(self)
	-- love.graphics.setColor(love.math.colorFromBytes(self.color.R, self.color.G, self.color.B))
    -- love.graphics.circle(self.drawMode, self.posX, self.posY, self.sizeX/2)
	love.graphics.draw(self.image, self.posX, self.posY, self.rotation, self.scaleX, self.scaleY, self.originOffsetX, self.originOffsetY, 
		self.shearingX, self.shearingY)

end