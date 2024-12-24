--! file: camera_controller.lua
require("util/camera/camera")
CameraController = Object.extend(Object)


function CameraController.new(self)
	self.followingObject = nil

	self.posX = 0
	self.posY = 0

	self.zoomInc = 1.2
	self.speed = 3
	self.rotationSpeed = 3

	self.setKeyRepeat = true
	self:initialize()
end

function CameraController.initialize(self)
	self:moveTo(self.posX, self.posY)
    love.keyboard.setKeyRepeat(self.setKeyRepeat) -- enable key repeat so backspace can be held down to trigger love.keypressed multiple times.
end

function CameraController.setCamera()
    camera:set()
end

function CameraController.unsetCamera()
    camera:unset()
end

function CameraController.getCamera()
	return camera
end


function CameraController.onKeyPressed(self, key)
	-- zoom
	if key == "pageup" then self:zoom(1/self.zoomInc) end
	if key == "pagedown" then self:zoom(self.zoomInc) end

	-- rotation

	-- position TODO: si estamos siguiendo a un objeto, no afecta
	if key == "w" then self:translate(0, -self.speed) end
	if key == "a" then self:translate(-self.speed, 0) end
	if key == "s" then self:translate(0, self.speed) end
	if key == "d" then self:translate(self.speed, 0) end
end



function CameraController.setFollowingObject(self, obj)
	self.followingObject = obj
end

function CameraController.followObject(self)
	-- seguimiento suave del objeto	
end



-- Camera controls
function CameraController.zoom(self, inc)
	camera:scale(inc)
end

function CameraController.translate(self, dx, dy)
	camera:move(dx, dy)
end

function CameraController.moveTo(self, x, y)
	camera:setPosition(x, y)
end

function CameraController.rotate(self, dr)
	camera:rotate(dr)
end

