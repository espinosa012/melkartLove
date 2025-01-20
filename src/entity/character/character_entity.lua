--! file: character_entity.lua
require "src.entity.base_entity"
require "src.util.sprite.sprite"
require "src.util.statemachine.character_state_machine"

_G.CharacterEntity = Object.extend(GameEntity)

function CharacterEntity.new(self, posX, posY)
    -- TODO: llevar a un componente de atributos de este tipo
    self.movementSpeed = 2  -- px per frame

    self:loadSprite("resources/character.png")  -- TODO: test, quitar
    self:loadCollider()
    self:loadStateMachine()

    self:setPosition(posX, posY)
end

-- love2D 
function CharacterEntity.update(self, dt)
    GameEntity.update(self, dt)

    -- Algunas colisiones (en función de la clase) podemos coprobarlas en el update del personaje
    self:updateCollisions()

    -- TODO: quizás al seleccionar el personaje, deberíamos desactivar su collider, para que no lo encuentre
    -- otra opción es cambiarle la clase al collider del personaje al seleccionar, para que no lo devuelva la query
end

function CharacterEntity.updateCollisions(self)
    local x, y = self:getPosition()
    local collisions = collisionHandler:queryRectangleArea(x, y, worldCellSize/2, worldCellSize/2, {"CharacterCollision"})   -- TODO: las detecta siempre, quizás detecte la propia
    if #collisions > 1 then -- TODO: así si... ,mayor que 1 pq el del character siempre está
    -- TODO: gestionar colisióoes
        print(collisions[1])
    end
end


-- Sprite
function CharacterEntity.loadSprite(self, imagePath)
    GameEntity.loadSprite(self, imagePath)
end

-- Collider
function CharacterEntity.loadCollider(self)
    -- TODO usar aquí nuestra clase CollisionBox
    local x,  y = self:getPosition()
    self.collider = collisionHandler:newRectangleCollider(x+8, y+8, 16, 16) -- TODO: pruebas, configurar en función del character
    self.collider:setType("static")
    self.collider:setCollisionClass("CharacterCollision")
end


-- State machine
function CharacterEntity.loadStateMachine(self)
    self.state_machine = CharacterStateMachine()
end