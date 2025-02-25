--! file: sprite.lua
require "src/util/data/color" 

_G.Sprite = _G.Object.extend(_G.Object)

function Sprite.new(self, imagePath, posX, posY)
	self.image = nil
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
	self:loadImage(imagePath, nil)
end

function Sprite.loadImage(self, imagePath, settings) -- TODO: ver qué es settings
	self.image = love.graphics.newImage(imagePath)
    self.image:setFilter("nearest", "linear") -- no se ve bien
end

function Sprite.getWidth(self)
	return self.image:getWidth()
end

function Sprite.getHeight(self)
	return self.image:getHeight()
end

function Sprite.rotate(self, r)
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
	love.graphics.draw(self.image, self.posX, self.posY, self.rotation, self.scaleX, self.scaleY, self.originOffsetX, self.originOffsetY, 
		self.shearingX, self.shearingY)
end