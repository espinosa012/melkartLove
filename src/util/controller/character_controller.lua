--! file: character_controller.lua
require "src/util/data/list"
CharacterController = Object.extend(Object)

--TODO: hay que hacer la clase madre de los controladores, para los métodos de teclas, ratón, eventos, etc
--TODO: igual este módulo no tend'ria que estar en util, sino en una carpeta controller fuera, y dejar en util la clase madre

-- TODO: usar cámara de hump

function CharacterController.new(self)
	self.availableCharacters = {}
	self.selectedCharacter = nil
end

function CharacterController.addCharacter(self, entity)
	table.insert(self.availableCharacters, entity)
end

function CharacterController.onKeyPressed(self, key)
	if key == "1" then self:selectCharacter(0) end
	if key == "escape" then self:clearSelection() end

	if key == "up" then self:manualCharacterMoving(Vector(0, -1)) end
	if key == "down" then self:manualCharacterMoving(Vector(0, 1)) end
	if key == "right" then self:manualCharacterMoving(Vector(1, 0)) end
	if key == "left" then self:manualCharacterMoving(Vector(-1, 0)) end
end

function CharacterController.onMousePressed(self, mouseBtn, cameraPosition, cameraScale)
	-- TODO: si tenemos personaje seleccionado, lo movemos a la posición del tilemap correspondiente
	if mouseBtn == 1 then
		local mouseX, mouseY = love.mouse.getPosition()
		local clickedWorldPos = _G.tileMap:worldToMapPosition(mouseX * cameraScale.x + cameraPosition.x, 
			mouseY * cameraScale.y + cameraPosition.y)
		self:moveToWorldPosition(clickedWorldPos.x, clickedWorldPos.y)
	end
end

function CharacterController.selectCharacter(self, characterIndex)
	self.selectedCharacter = self.availableCharacters[characterIndex + 1]
	print("Character selected")
end

function CharacterController.clearSelection(self)
	if self.selectedCharacter ~= nil then
		self.selectedCharacter = nil
		print("Selection cleared")
	end
end

function CharacterController.isCharacterSelected(self)
	return  self.selectedCharacter ~= nil
end

-- no sé si va aquí...
function CharacterController.moveToWorldPosition(self, x, y)
    -- TODO usando los métodos del tilemap y el setPosition del personaje seleccionado.
	if self:isCharacterSelected() then
		local characterPosition = self.selectedCharacter:getPosition()
		local characterWorldPosition = _G.tileMap:worldToMapPosition(characterPosition.x, characterPosition.y)
		local targetPos = _G.tileMap:mapToWorldPosition(x, y) 
		local targetWorldPos = _G.tileMap:worldToMapPosition(targetPos.x, targetPos.y) -- TODO: comprobar que targetWorldPos está dentro del mundo
		
		self:followPath(self.selectedCharacter, 
			_G.astar:getPath(characterWorldPosition.x, characterWorldPosition.y, targetWorldPos.x, targetWorldPos.y))
		
		-- self.selectedCharacter:setPosition(targetPos.x, targetPos.y)

	end
end

function CharacterController.followPath(self, character, path)
	-- TODO. para movimiento basado en tiles.
	local speed = 0.8
	local nextPosReachedDist = 3	-- en pixeles
	local nextDirection = nil
	local characterPosition = nil
	local characterWorldPosition = nil
	local nextPosition = nil

	for i = 1, #path do
		nextPosition = tileMap:mapToWorldPosition(path[i].x, path[i].y)
		characterPosition = self.selectedCharacter:getPosition()
		characterWorldPosition = _G.tileMap:worldToMapPosition(characterPosition.x, characterPosition.y)	

		nextDirection = Vector(nextPosition.x - characterWorldPosition.x, nextPosition.y - characterWorldPosition.y)
		-- TODO: crear una función que vaya recorriendo todas las casillas del path una por una, a una determiada velocidad
		while self:getDistance(self.selectedCharacter:getPosition(), nextPosition) > nextPosReachedDist do 
			self:pushCharacter(self.selectedCharacter, nextDirection, speed)
		end
		-- mientras la distancia entre la posición del personaje y la nextPosition sea menor 
		-- que nextPosReachedDist, seguimos avanzando en la dirección correspondiente. cuando
		-- deje de serlo, pasarmos a la siguiente interación del for
		
		-- while true do
		-- 	characterPosition = self.selectedCharacter:getPosition()
		-- 	characterWorldPosition = _G.tileMap:worldToMapPosition(characterPosition.x, characterPosition.y)	
		-- end
		
		-- nextDirection = Vector(nextPosition.x - characterWorldPosition.x, nextPosition.y - characterWorldPosition.y)
		-- character:setPosition(nextPosition.x, nextPosition.y)
	end
end

function CharacterController.getDistance(self, p1, p2)
	return math.sqrt(math.abs(p1.x - p2.x) + math.abs(p1.y - p2.y))
end

function CharacterController.manualCharacterMoving(self, movementDirection)	-- movementDirection puede ser UP, DOWM, LEFT, RIGHT, DOWN_LEFT, DOWN_RIGHT, TOP_LEFT, TOP_RIGHT, llevar a un enum o algo
	if self.selectedCharacter == nil then return end
	self:pushCharacter(self.selectedCharacter, movementDirection, worldCellSize.x)
end

function CharacterController.pushCharacter(self, character, movementDirection, speed) -- TODO: el nombre del método no es el mejor...
	-- TODO: restringir el movimiento a los límites del mapa
	local currentCharacterPosition = character:getPosition()
	character:setPosition(currentCharacterPosition.x + movementDirection.x * speed, currentCharacterPosition.y +
			movementDirection.y * speed)
end