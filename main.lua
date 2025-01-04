--! file: main.lua
_G.love = require "love"
_G.Object = require("src/lbr/classic")
require("src/debug")
require("src/entity/character/character_entity")
require("src/util/controller/character_controller")
require("src/util/controller/camera_controller")
require("src/util/pathfinding/astar")
require("src/util/pathfinding/jumper")
require("src/util/tilemap/tilemap")


_G.worldSize =  Vector(512, 512)
_G.worldCellSize = Vector(16, 16)    -- para casillas del tilemap, movimiento, etc.

local sceneObjects = {} -- almacenamos los distintos objetos de la escena (personajes, npcs, items, etc)
local characterController = CharacterController()
local cameraController = CameraController()


-- TODO igual podriamos hacer globales todas estas 
_G.tileMap = TileMap(worldSize, worldCellSize)
_G.astar = Jumper(worldSize.x, worldSize.y) -- tODO: debería revargarse con cada chunk Wo algo así


local testCharacter = CharacterEntity(_G.tileMap:mapToWorldPosition(0, 0)) 


function love.load()
    characterController:addCharacter(testCharacter)
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
    characterController:onKeyPressed(key)
    cameraController:onKeyPressed(key)
end

function love.mousepressed(x, y, button)
    characterController:onMousePressed(button, Vector(cameraController.getCamera().x, cameraController.getCamera().y), 
        Vector(cameraController.getCamera().scaleX, cameraController.getCamera().scaleY))
end

function love.draw()
    cameraController.setCamera()
    tileMap:draw()
    testCharacter:draw()
    cameraController.unsetCamera()
end

function love.quit()

end

-- function love.errorhandler(msg)
-- end

local function addGameObject(name, obj)
    table.insert(sceneObjects, {name=obj})
end
