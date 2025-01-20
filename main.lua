--! file: main.lua
_G.love = require "love"
_G.Object = require("src.lbr.classic")

require "src.debug"
require "src.entity.character.character_entity"
require "src.util.controller.character_controller"
require "src.util.controller.camera_controller"
require "src.util.pathfinding.pathfinder"
require "src.util.tilemap.tilemap"
require "src.util.event.event_handler"
require "src.util.data.vector2"
require "src.util.data.list"
require "src.util.statemachine.state"
require "src.util.event.key"
require "src.util.collision.collision_handler"
require "src.util.timemanager.timemanager"

_G.worldSize = Vector2(512, 512)
_G.worldCellSize = 16    -- para casillas del tilemap, movimiento, etc.

local sceneObjects = {} -- almacenamos los distintos objetos de la escena (personajes, npcs, items, etc)

-- CONTROLLERS
local characterController = CharacterController()
local cameraController = CameraController()

-- COLLISIONS (Se podría meter en nuestro collisionHandler)
-- añadir otro collider al character para interacciones (CharacterInteractionCollider)

-- TIME MANAGER 
_G.timeManager = TimeManager()

-- GLOBAL
_G.tileMap = TileMap(worldSize, Vector2(worldCellSize, worldCellSize), "resources/terrainAtlas.png")
_G.astar = PathFinder(worldSize.x, worldSize.y, 'ASTAR') -- tODO: debería recargarse con cada chunk o algo así
_G.eventHandler = EventHandler()

-- TESTING
local testCharacter = CharacterEntity(_G.tileMap:mapToWorldPosition(0, 0))
local testCharacter2 = CharacterEntity(_G.tileMap:mapToWorldPosition(4, 4))
local testCharacter3 = CharacterEntity(_G.tileMap:mapToWorldPosition(9, 12))


function love.load()
    characterController:addCharacter(testCharacter)
    characterController:addCharacter(testCharacter2)
    characterController:addCharacter(testCharacter3)
    tileMap:load()
    timeManager:start()
end

function love.update(dt)
    characterController:update(dt)    -- TODO: no hay que actualizar los personajes individualmente, sino el manager, controller o como lo hagamos
    for index, character in ipairs(characterController.availableCharacters.items) do
		character:update(dt)
	end	-- TODO: mejora, quitar de aquí
    collisionHandler:update(dt)
    tileMap:update(dt)
    timeManager:update(dt)
end

function love.textinput(t)
    -- TODO comprobar si hay algun input con el focus
end

function love.keypressed(key)
    characterController:onKeyPressed(key)
    cameraController:onKeyPressed(key)
end

function love.mousepressed(x, y, button)
    characterController:onMousePressed(button, Vector2(cameraController:getCamera().x, cameraController:getCamera().y), 
        Vector2(cameraController:getCamera().scaleX, cameraController:getCamera().scaleY))
end

function love.mousemoved(x, y)
end

function love.wheelmoved(x, y)
end

function love.directorydropped(x, y)
end

function love.filedropped(x, y)
end

function love.draw()
    cameraController.setCamera()
    tileMap:draw()
    -- TODO necesitamos la manera de dibujar automáticamente todos los personajes que tengamos
    testCharacter:draw()
    testCharacter2:draw()
    testCharacter3:draw()

    -- TODO: pruebas. para ver los colliders
    collisionHandler:draw()

    cameraController.unsetCamera()
end

function love.quit()
end

local function addGameObject(name, obj)
    table.insert(sceneObjects, {name=obj})  -- TODO: añadir elementos como un diccionario donde la key es la posición en el mundo 
                                            -- para mayor eficiencia. Cuando se actualice la posición se debe cambiar también la key
end