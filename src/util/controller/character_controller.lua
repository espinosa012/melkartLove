--! file: character_controller.lua
require "src.util.data.list"
CharacterController = _G.Object.extend(Object)

--	TODO: hay que hacer la clase madre de los controladores, para los métodos de teclas, ratón, eventos, etc
--	TODO: igual este módulo no tendría que estar en util, sino en una carpeta controller fuera, y dejar en util la clase madre
-- 	TODO: usar cámara de hump

function CharacterController.new(self)
	self.availableCharacters = List()
	self.selectedCharacter = nil
end

function CharacterController.addCharacter(self, characterEntity)
	self.availableCharacters:add(characterEntity)
end

function CharacterController.update(self, dt)
	for index, character in ipairs(self.availableCharacters.items) do
		character:update(dt)
	end	-- TODO: mejorar
	self:moveCharacters()
end

function CharacterController.moveCharacters(self)	-- TODO: unificar con el update (llevar dentro?? estaríamos llevando cosas del controller),
	for _, character in ipairs(self.availableCharacters.items) do
		if character.state_machine:getState() == "MOVING" then
			self:moveCharacterAlongPath(character)
		end
	end
end

function CharacterController.onKeyPressed(self, key)
	if key == _G.InputMap.SELECT_CHARACTER_1 then self:selectCharacter(1) end
	if key == _G.InputMap.SELECT_CHARACTER_2 then self:selectCharacter(2) end
	if key == _G.InputMap.SELECT_CHARACTER_3 then self:selectCharacter(3) end
	-- TODO: hacer escalable, de modo que cada tecla de número se asocia a su personaje correspondiente

	if key == _G.InputMap.CLEAR_CHARACTER_SELECTION then self:clearSelection() end
	if self.selectedCharacter ~= nil then self:manuallyMovedCharacter(self.selectedCharacter, key) end
end

function CharacterController.onMousePressed(self, mouseBtn, cameraPosition, cameraScale)
	if mouseBtn == 1 then return self:onMouseLeftClick(cameraPosition, cameraScale) end
	if mouseBtn == 2 then return print("Right click not implemented") end
	if mouseBtn == 3 then return print("Central click not implemented") end
end

function CharacterController.onMouseLeftClick(self, cameraPosition, cameraScale)
	if not self:isCharacterSelected() then return end
	-- Al hacer click izquierdo (sobre una celda del mapa), si tenemos algún personaje seleccionado, le asignamos un nuevo path, que 
	-- va desde la celda en que se encuentre hasta aquella en la que hayamos hecho click.
	local mouseX, mouseY = love.mouse.getPosition()
	local clickedWorldPosX, clickedWorldPosY = _G.tileMap:worldToMapPosition(mouseX * cameraScale.x + cameraPosition.x,
		mouseY * cameraScale.y + cameraPosition.y)
	self:setCharacterPath(self.selectedCharacter, clickedWorldPosX, clickedWorldPosY)
end

function CharacterController.selectCharacter(self, characterIndex)
	self.selectedCharacter = self.availableCharacters.items[characterIndex]
end

function CharacterController.clearSelection(self)
	self.selectedCharacter = nil
end

function CharacterController.isCharacterSelected(self)
	return  self.selectedCharacter ~= nil
end

function CharacterController.getWorldPath(self, mapPath)
	local worldPath = {}
	for _, value in ipairs(mapPath) do
		local targetPositionX, targetPositionY = _G.tileMap:mapToWorldPosition(value.x, value.y)	-- TODO: quitar y recibir directamente las posiciones del mundo
		table.insert(worldPath, Vector2(targetPositionX, targetPositionY))
	end
	return worldPath
end

function CharacterController.setCharacterPath(self, character, targetX, targetY)
	if not character then return end

	-- TODO: comprobar que targetPos está dentro del mundo
	local characterMapPositionX, characterMapPositionY = _G.tileMap:worldToMapPosition(self.selectedCharacter:getPosition())
	local worldPath = self:getWorldPath(_G.astar:getPath(characterMapPositionX, characterMapPositionY, targetX, targetY))

	character.state_machine.path = worldPath
	character.state_machine.currentPathPosition = 1
	character.state_machine:setState("MOVING")
	-- TODO: en función de la dirección en que nos movamos, el estado será uno u otro, para la animación del sprite. enum de estados
end

function CharacterController.moveCharacterAlongPath(self, character)
	-- nos movemos hacia character.state_machine.path[character.state_machine.currentPathPosition]. 
	-- Cuando lo alcancemos, incrementamos el índice
	-- comprobamos si estamos lo suficientemente cerca de targetPosition como para asumir que ya hemos llegado. 
	-- En caso contrario, seguimos deslizando
	local targetPosition = character.state_machine.path[character.state_machine.currentPathPosition]
	local characterCurrentPosX, characterCurrentPosY = character:getPosition()
	local dx = targetPosition.x - characterCurrentPosX
	local dy = targetPosition.y - characterCurrentPosY
	local distance = math.sqrt(dx * dx + dy * dy)
	local stepSpeed = character.movementSpeed

	if distance < stepSpeed then
		character:setPosition(targetPosition.x, targetPosition.y)
		-- actualizamos el índice actual. si hemos llegado al final del path, nos ponemos en IDLE
		if self:isCharacterPathCompleted(character) then character.state_machine:setState("IDLE")
		else character.state_machine:incCurrentPathPosition() end
	else
		local nextX = characterCurrentPosX + dx / distance * stepSpeed
		local nextY = characterCurrentPosY + dy / distance * stepSpeed
		character:setPosition(nextX, nextY)
	end
end

function CharacterController.isCharacterPathCompleted(self, character)
	return character.state_machine.currentPathPosition == #character.state_machine.path
end



-- TODO: igual no lo usamos esto...
function CharacterController.manualCharacterMoving(self, character, movementDirection)
	local currentCharacterPosition = self.selectedCharacter:getPositionV()
	character:setPosition(currentCharacterPosition.x + movementDirection.x * character.movementSpeed,
		currentCharacterPosition.y + movementDirection.y * character.movementSpeed)
end	-- TODO: no funciona el movimiento manual en diagonal (dos teclas a la vez)

function CharacterController.manuallyMovedCharacter(self, character, key)
	if key == _G.InputMap.UP then self:manualCharacterMoving(character, Vector2(0, -1)) end
	if key == _G.InputMap.DOWN then self:manualCharacterMoving(character, Vector2(0, 1)) end
	if key == _G.InputMap.RIGHT then self:manualCharacterMoving(character, Vector2(1, 0)) end
	if key == _G.InputMap.LEFT then self:manualCharacterMoving(character, Vector2(-1, 0)) end
end