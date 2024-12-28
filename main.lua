--! file: main.lua
_G.love = require "love"
_G.Object = require("src/lbr/classic")
require("src/debug")
require("src/entity/character/character_entity")
require("src/util/controller/character_controller")
require("src/util/controller/camera_controller")
require("src/util/pathfinding/astar")
require("src/util/tilemap/tilemap")

local sceneObjects = {} -- almacenamos los distintos objetos de la escena (personajes, npcs, items, etc)
local characterController = CharacterController()
local cameraController = CameraController()

local testCharacter = CharacterEntity(128, 64)

local astar = AStar(512, 512)

local tileMap = TileMap(Vector(256, 256), Vector(16, 16))

function love.load()
    characterController:addCharacter(testCharacter)
    tileMap:load()
end

function love.update(dt)
    testCharacter:update(dt)
    tileMap:update(dt)
end

function love.textinput(t)

end

function love.keypressed(key)
    characterController:onKeyPressed(key)
    cameraController:onKeyPressed(key)
end

function love.draw()
    cameraController.setCamera()
    -- testCharacter:draw()
    tileMap:draw()
    cameraController.unsetCamera()
end

function love.quit()

end

-- function love.errorhandler(msg)
-- end

local function addGameObject(name, obj)
    table.insert(sceneObjects, {name=obj})
end
