--! file: camera_controller.lua
require("src.util.camera.camera")
CameraController = Object.extend(Object)

function CameraController.new(self)
	self.followingObject = nil

	self.posX = 0
	self.posY = 0

	self.zoomInc = 1.2
	self.speed = worldCellSize
	self.rotationSpeed = 3

	self:initialize()
end

function CameraController.initialize(self)
	self:moveTo(self.posX, self.posY)
    love.keyboard.setKeyRepeat(true) -- enable key repeat so backspace can be held down to trigger love.keypressed multiple times.
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

function CameraController.getCameraScale()
	return Vector(camera.scaleX, camera.scaleY)
end

function CameraController.getCameraPosition(self)
	return Vector(camera.x, camera.y)
end

function CameraController.onKeyPressed(self, key)
	-- zoom
	if key == Key.CAMERA_ZOOM_IN then self:zoom(1/self.zoomInc) end
	if key == Key.CAMERA_ZOOM_OUT then self:zoom(self.zoomInc) end

	-- position TODO: si estamos siguiendo a un objeto, no afecta
	if key == Key.CAMERA_MOVE_UP then self:translate(0, -self.speed) end
	if key == Key.CAMERA_MOVE_LEFT then self:translate(-self.speed, 0) end
	if key == Key.CAMERA_MOVE_DOWN then self:translate(0, self.speed) end
	if key == Key.CAMERA_MOVE_RIGHT then self:translate(self.speed, 0) end

	-- rotation

end

function CameraController.setFollowingObject(self, obj)
	self.followingObject = obj
end

function CameraController.followObject(self, dt)
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