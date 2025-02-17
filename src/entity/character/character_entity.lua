--! file: character_entity.lua
require "src.entity.game_entity"
require "src.util.sprite.sprite"
require "src.util.statemachine.character_state_machine"
require "src.util.collision.collision_box"

_G.CharacterEntity = Object.extend(GameEntity)

function CharacterEntity.new(self, posX, posY, name)
    -- TODO: llevar a un componente de atributos de este tipo
    GameEntity.new(self)
    if name then self.name = name else self.name = "unamed" end
    self.movementSpeed = 2  -- px per frame

    self:loadSprite("resources/character.png")  -- TODO: test, quitar
    self:loadCollider()
    self:loadStateMachine()

    self:setPosition(posX, posY)
end

-- love2D 
function CharacterEntity.update(self, dt)
    GameEntity.update(self, dt)

    self:handleCollisions(dt)
    -- TODO: quizás al seleccionar el personaje, deberíamos desactivar su collider, para que no lo encuentre
    -- otra opción es cambiarle la clase al collider del personaje al seleccionar, para que no lo devuelva la query
end

function CharacterEntity.setPosition(self, x, y)
    GameEntity.setPosition(self, x, y)
end

-- Sprite
function CharacterEntity.loadSprite(self, imagePath)
    GameEntity.loadSprite(self, imagePath)
    -- TODO: obtenemos el sprite en base al tipo de character
end

-- Collider
function CharacterEntity.loadCollider(self)
    local x,  y = self:getPosition()
    self.collider = CollisionBox(self, "rectangular", x+worldCellSize/2, y+worldCellSize/2, worldCellSize, worldCellSize, "CharacterCollision", "static")
end

function CharacterEntity.handleCollisions(self, dt)
    self.collider:update(dt)    -- actualizamos la collision box para setear sus colisiones en el momento del frame
    collisionHandler:handleCollisions(self) -- llamamos al método de gestión de colisiones del personaje ya con las colisiones actualizadas
end

-- State machine
function CharacterEntity.loadStateMachine(self)
    self.state_machine = CharacterStateMachine()
end