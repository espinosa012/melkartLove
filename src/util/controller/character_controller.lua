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
	if self:isCharacterSelected() ~= true then return end
	print(self.selectedCharacter.state_machine.currentState)
	if self.selectedCharacter.state_machine.currentState == "MOVING" then
		self:translateCharacterAlongPath(self.selectedCharacter)
	end
end

function CharacterController.onKeyPressed(self, key)
	if key == "1" then self:selectCharacter(0) end
	if key == "escape" then self:clearSelection() end

	if self.selectedCharacter ~= nil then
		if key == "up" then self:manualCharacterMoving(Vector(0, -1)) end
		if key == "down" then self:manualCharacterMoving(Vector(0, 1)) end
		if key == "right" then self:manualCharacterMoving(Vector(1, 0)) end
		if key == "left" then self:manualCharacterMoving(Vector(-1, 0)) end
	end
end

function CharacterController.onMousePressed(self, mouseBtn, cameraPosition, cameraScale)
	-- TODO: si tenemos personaje seleccionado, lo movemos a la posición del tilemap correspondiente
	if not self:isCharacterSelected() then return end

	if mouseBtn == 1 then
		local mouseX, mouseY = love.mouse.getPosition()
		local clickedWorldPosX, clickedWorldPosY = _G.tileMap:worldToMapPosition(mouseX * cameraScale.x + cameraPosition.x, 
			mouseY * cameraScale.y + cameraPosition.y)
		self:setCharacterPath(self.selectedCharacter, clickedWorldPosX, clickedWorldPosY)
	end
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

function CharacterController.isValidPath(self, path)
	return self.selectedCharacter.state_machine.path ~= nil and #path > 0 and path[1] ~= nil
end

function CharacterController.setCharacterPath(self, character, targetX, targetY)
    -- TODO usando los métodos del tilemap y el setPosition del personaje seleccionado.
	-- if self:isCharacterSelected() ~= true then return end
	if character == nil then return end

	local characterMapPositionX, characterMapPositionY = _G.tileMap:worldToMapPosition(self.selectedCharacter:getPosition())
	local targetMapPosX, targetMapPosY = _G.tileMap:worldToMapPosition(_G.tileMap:mapToWorldPosition(targetX, targetY)) -- TODO: comprobar que targetWorldPos está dentro del mundo

	-- Asignamos el path del personaje
	self.selectedCharacter.state_machine.path = _G.astar:getPath(characterMapPositionX, characterMapPositionY, targetMapPosX, targetMapPosY)
	self.selectedCharacter.state_machine:setState("MOVING")	-- en función de la dirección en que nos movamos, el estado será uno u otro.
end

function CharacterController.translateCharacterAlongPath(self, character)
	-- vamos al índice siguiente al que nos encontremos.
	if not self:isValidPath(self.selectedCharacter.state_machine.path) then return end

	local characterPosX, characterPosY, characterMapPosX, characterMapPosY, currentPathPosition
	for index, value in ipairs(self.selectedCharacter.state_machine.path) do
		characterPosX, characterPosY = character:getPosition()
		characterMapPosX, characterMapPosY = _G.tileMap:worldToMapPosition(characterPosX, characterPosY)

		if value.x == characterMapPosX and value.y == characterMapPosY then
			currentPathPosition = index + 1
			break
		end
	end
	
	if #self.selectedCharacter.state_machine.path < currentPathPosition then
		-- TODO: indicamos a la máquina de estado que volvemos a estar parados
		self.selectedCharacter.state_machine:setState("IDLE")
	else
		local targetPositionX, targetPositionY = _G.tileMap:mapToWorldPosition(self.selectedCharacter.state_machine.path[currentPathPosition].x, 
		self.selectedCharacter.state_machine.path[currentPathPosition].y) 
		character:setPosition(targetPositionX, targetPositionY)
	end
end

function CharacterController.manualCharacterMoving(self, movementDirection)	
	local speed = worldCellSize.x
	local currentCharacterPosition = self.selectedCharacter:getPositionV()
	self.selectedCharacter:setPosition(currentCharacterPosition.x + movementDirection.x * speed,
		currentCharacterPosition.y + movementDirection.y * speed)
end