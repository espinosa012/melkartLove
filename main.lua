--! file: main.lua
_G.love = require "love"
_G.Object = require "lbr/classic"
require("entity/character/character_entity")
require("util/controller/character_controller")


function love.load()
    controller = CharacterController()
    c = CharacterEntity(128, 64)
    controller:addCharacter(c)
end


function love.update(dt)
    c:update(dt)
end


function love.textinput(t)
end


function love.keypressed(key)
    controller:onKeyPressed(key)
end

function love.draw()
    c:draw()
end

function love.quit()
end

-- function love.errorhandler(msg)
-- end
