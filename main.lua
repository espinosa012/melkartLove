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
require "src.util.data.vector"
require "src.util.data.list"
require "src.util.statemachine.state"
require "src.util.event.key"

_G.worldSize = Vector(512, 512)
_G.worldCellSize = 16    -- para casillas del tilemap, movimiento, etc.

local sceneObjects = {} -- almacenamos los distintos objetos de la escena (personajes, npcs, items, etc)
local characterController = CharacterController()
local cameraController = CameraController()

_G.tileMap = TileMap(worldSize, Vector(worldCellSize, worldCellSize), "resources/terrainAtlas.png")
_G.astar = PathFinder(worldSize.x, worldSize.y, 'ASTAR') -- tODO: debería recargarse con cada chunk o algo así
_G.eventHandler = EventHandler()

local testCharacter = CharacterEntity(_G.tileMap:mapToWorldPosition(0, 0))
local testCharacter2 = CharacterEntity(_G.tileMap:mapToWorldPosition(4, 4))

function love.load()
    characterController:addCharacter(testCharacter)
    characterController:addCharacter(testCharacter2)
    tileMap:load()
end

function love.update(dt)
    characterController:update(dt)    -- TODO: no hay que actualizar los personajes individualmente, sino el manager, controller o como lo hagamos
    tileMap:update(dt)
end

function love.textinput(t)
    -- TODO comprobar si hay algun input con el focus
end

function love.keypressed(key)
    if key == "space" then
        eventHandler:invoke("on_space_pressed")
    end
    characterController:onKeyPressed(key)
    cameraController:onKeyPressed(key)
end

function love.mousepressed(x, y, button)
    characterController:onMousePressed(button, Vector(cameraController.getCamera().x, cameraController.getCamera().y), 
        Vector(cameraController.getCamera().scaleX, cameraController.getCamera().scaleY))
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
    cameraController.unsetCamera()
end

function love.quit()
end

local function addGameObject(name, obj)
    table.insert(sceneObjects, {name=obj})
end