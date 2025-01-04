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

function CharacterController.setCharacterPath(self, character, targetX, targetY)
	-- TODO: comprobar que targetPos está dentro del mundo
	if character == nil then return end

	local characterMapPositionX, characterMapPositionY = _G.tileMap:worldToMapPosition(self.selectedCharacter:getPosition())
	-- Asignamos el path del personaje
	local worldPath = self:getWorldPath(_G.astar:getPath(characterMapPositionX, characterMapPositionY, targetX, targetY))

	-- TODO: Definimos dos variables, dx, dy, dependientes de la velocidad, para crear un nuevo array path con valores del mundo intercalando entre
	-- los de mapPath otros intermedios.

	self.selectedCharacter.state_machine.path = worldPath
	self.selectedCharacter.state_machine:setState("MOVING")	-- TODO: en función de la dirección en que nos movamos, el estado será uno u otro, para aniumación del sprite. en um de estados
end

function CharacterController.getWorldPath(self, mapPath)
	local worldPath = {}
	for _index, value in ipairs(mapPath) do
		local targetPositionX, targetPositionY = _G.tileMap:mapToWorldPosition(value.x, value.y)	-- TODO: quitar y recibir durectamente las posiciiones del mundo
		table.insert(worldPath, Vector(targetPositionX, targetPositionY))	-- TODO: se podría insertar directamente el Vector2
	end
	return worldPath
end	-- TODO: habrá que pasarle algún argumento para indicar la velocidad

function CharacterController.translateCharacterAlongPath(self, character)
	-- vamos al índice siguiente al que nos encontremos.
	if not self:isValidPath(self.selectedCharacter.state_machine.path) then return end

	local characterPosX, characterPosY = character:getPosition()
	local currentPathPosition = self:getCurrentPathPosition(characterPosX, characterPosY)

	if #character.state_machine.path < currentPathPosition then
		character.state_machine:setState("IDLE")
	else
		character:setPosition(character:getStateMachine():getPath()[currentPathPosition].x,
			character:getStateMachine():getPath()[currentPathPosition].y)
		-- love.timer.sleep(0.1)	
	end
end

function CharacterController.getCurrentPathPosition(self, characterPosX, characterPosY)
	for index, value in ipairs(self.selectedCharacter.state_machine.path) do
		if value.x == characterPosX and value.y == characterPosY then
			return index + 1
		end
	end
	return nil
end

function CharacterController.isValidPath(self, path)
	return self.selectedCharacter.state_machine.path ~= nil and #path > 0 and path[1] ~= nil
end

function CharacterController.manualCharacterMoving(self, movementDirection)	
	local speed = worldCellSize.x
	local currentCharacterPosition = self.selectedCharacter:getPositionV()
	self.selectedCharacter:setPosition(currentCharacterPosition.x + movementDirection.x * speed,
		currentCharacterPosition.y + movementDirection.y * speed)
end