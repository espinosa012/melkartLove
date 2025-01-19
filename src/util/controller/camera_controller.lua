--! file: camera_controller.lua
require "src.util.camera.camera"

CameraController = _G.Object.extend(Object)

function CameraController.new(self)
	self.followingObject = nil

	-- TODO: llevar estos valores a configuracion o similar
	self.zoomInc = 1.2
	self.speed = _G.worldCellSize
	self.rotationSpeed = 3

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
	return Vector2(camera.scaleX, camera.scaleY)
end

function CameraController.getCameraPosition(self)
	return Vector2(camera.x, camera.y)
end

function CameraController.onKeyPressed(self, key)
	-- zoom
	if key == _G.InputMap.CAMERA_ZOOM_IN then self:zoom(1/self.zoomInc) end
	if key == _G.InputMap.CAMERA_ZOOM_OUT then self:zoom(self.zoomInc) end

	-- position TODO: si estamos siguiendo a un objeto, no afecta
	if key == _G.InputMap.CAMERA_MOVE_UP then self:translate(0, -self.speed) end
	if key == _G.InputMap.CAMERA_MOVE_LEFT then self:translate(-self.speed, 0) end
	if key == _G.InputMap.CAMERA_MOVE_DOWN then self:translate(0, self.speed) end
	if key == _G.InputMap.CAMERA_MOVE_RIGHT then self:translate(self.speed, 0) end

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