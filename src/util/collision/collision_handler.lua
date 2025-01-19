_G.windfield = require "src.lbr.windfield"

_G.collisionHandler = windfield.newWorld()
collisionHandler:addCollisionClass("TestCollision")
collisionHandler:addCollisionClass("CharacterCollision")



CollisionHandler = Object.extend(BaseEntity) -- TODO: igual no debe ser una clase, no sé...



-- Podemos definir clases con nuestros colliders usando windfield
