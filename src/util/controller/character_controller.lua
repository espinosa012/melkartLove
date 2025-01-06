--! file: character_controller.lua
require "src/util/data/list"
CharacterController = Object.extend(Object)

--	TODO: hay que hacer la clase madre de los controladores, para los métodos de teclas, ratón, eventos, etc
--	TODO: igual este módulo no tend'ria que estar en util, sino en una carpeta controller fuera, y dejar en util la clase madre
-- 	TODO: usar cámara de hump

function CharacterController.new(self)
	self.availableCharacters = {}
	self.selectedCharacter = nil
end

function CharacterController.addCharacter(self, entity)
	table.insert(self.availableCharacters, entity)
end

function CharacterController.update(self, dt)
	-- TODO: temporal
	if not self:isCharacterSelected() then return end
	if self.selectedCharacter:getStateMachine():getState() == "MOVING" then
		-- self:translateCharacterAlongPath(self.selectedCharacter, dt)
		self:moveCharacterAlongPath(self.selectedCharacter, dt)
	end
end

function CharacterController.onKeyPressed(self, key)
	if key == "1" then self:selectCharacter(0) end
	if key == "escape" then self:clearSelection() end

	if self.selectedCharacter ~= nil then
		if key == "up" then self:manualCharacterMoving(self.selectedCharacter, Vector(0, -1)) end
		if key == "down" then self:manualCharacterMoving(self.selectedCharacter, Vector(0, 1)) end
		if key == "right" then self:manualCharacterMoving(self.selectedCharacter, Vector(1, 0)) end
		if key == "left" then self:manualCharacterMoving(self.selectedCharacter, Vector(-1, 0)) end
	end
end

function CharacterController.onMousePressed(self, mouseBtn, cameraPosition, cameraScale)
	if mouseBtn == 1 then return self:onMouseLeftClick(cameraPosition, cameraScale) end
	if mouseBtn == 2 then return print("Left click not implemented") end
	if mouseBtn == 3 then return print("Central click not implemented") end
end

function CharacterController.onMouseLeftClick(self, cameraPosition, cameraScale)
	if not self:isCharacterSelected() then return end
		local mouseX, mouseY = love.mouse.getPosition()
		local clickedWorldPosX, clickedWorldPosY = _G.tileMap:worldToMapPosition(mouseX * cameraScale.x + cameraPosition.x,
			mouseY * cameraScale.y + cameraPosition.y)
		self:setCharacterPath(self.selectedCharacter, clickedWorldPosX, clickedWorldPosY)
end

function CharacterController.selectCharacter(self, characterIndex)
	self.selectedCharacter = self.availableCharacters[characterIndex + 1]
	print("Character selected")
end

function CharacterController.clearSelection(self)
	self.selectedCharacter = nil
	print("Selection cleared")
end

function CharacterController.isCharacterSelected(self)
	return  self.selectedCharacter ~= nil
end

function CharacterController.getWorldPath(self, mapPath)
	local worldPath = {}
	for _index, value in ipairs(mapPath) do
		local targetPositionX, targetPositionY = _G.tileMap:mapToWorldPosition(value.x, value.y)	-- TODO: quitar y recibir durectamente las posiciiones del mundo
		table.insert(worldPath, Vector(targetPositionX, targetPositionY))	-- TODO: se podría insertar directamente el Vector2
	end
	return worldPath
end

function CharacterController.setCharacterPath(self, character, targetX, targetY)
	-- TODO: comprobar que targetPos está dentro del mundo
	if character == nil then return end

	local characterMapPositionX, characterMapPositionY = _G.tileMap:worldToMapPosition(self.selectedCharacter:getPosition())
	local worldPath = self:getWorldPath(_G.astar:getPath(characterMapPositionX, characterMapPositionY, targetX, targetY))

	self.selectedCharacter.state_machine.path = worldPath
	self.selectedCharacter.state_machine.currentPathPosition = 1
	self.selectedCharacter.state_machine:setState("MOVING")	-- TODO: en función de la dirección en que nos movamos, el estado será uno u otro, para aniumación del sprite. en um de estados
end

function CharacterController.moveCharacterAlongPath(self, character)
	-- nos movemos hacia character.state_machine.path[character.state_machine.currentPathPosition]. 
	-- Cuando lo alcancemos, incrementamos el índice
	-- comprobamos si estamos lo suficientemente cerca de targetPosition como para asumir que ya hemos llegado. 
	-- En caso contrario, seguimos deslizando
	local targetPosition = character:getStateMachine().path[character:getStateMachine().currentPathPosition]
	local characterCurrentPosX, characterCurrentPosY = character:getPosition()
	local dx = targetPosition.x - characterCurrentPosX
	local dy = targetPosition.y - characterCurrentPosY
	local distance = math.sqrt(dx * dx + dy * dy)
	-- local stepSpeed = character.movementSpeed * dt
	local stepSpeed = character.movementSpeed

	if distance < stepSpeed then
		character:setPosition(targetPosition.x, targetPosition.y)
		-- actualizamos el índice actual. si hemmos llegado al final del path, nos ponemos en IDLE
		if self:isCharacterPathCompleted(character) then
			character.state_machine:setState("IDLE")
		else
			character:getStateMachine():incCurrentPathPosition()
		end
	else
		character:setPosition(characterCurrentPosX + dx / distance * stepSpeed, characterCurrentPosY + dy / distance * stepSpeed)
	end
end

function CharacterController.isCharacterPathCompleted(self, character)
	return character:getStateMachine().currentPathPosition == #character:getStateMachine().path
end

function CharacterController.manualCharacterMoving(self, character, movementDirection)
	local currentCharacterPosition = self.selectedCharacter:getPositionV()
	character:setPosition(currentCharacterPosition.x + movementDirection.x * character.movementSpeed,
		currentCharacterPosition.y + movementDirection.y * character.movementSpeed)
end