--! file: tilemap.lua
require("src.util.tilemap.tileset")
TileMap = Object.extend(Object)

-- https://love2d.org/wiki/Tutorial:Efficient_Tile-based_Scrolling

function TileMap.new(self, mapSize, tileSize)
    self.world = nil    -- TODO: el tilemap debe conocer el mundo que está renderizando (o al menos cierta información)
    self.position = Vector(0, 0)
    self.mapSize = mapSize
    self.tileSize = tileSize
    self.zoom = Vector(1, 1)
    self.tileset = nil
    self.cells = {}

    self.mapSpriteBatch = nil -- la propia imagen del mapa

end

--#region    love2d functions
function TileMap.load(self)
    -- TODO: para pruebas. formar el tileset
    self.tileset = Tileset(self.tileSize)
    self.tileset:load("resources/terrainAtlas.png")

    local quadWidth = self.tileset.sourceImage:getWidth()
    local quaHeight = self.tileset.sourceImage:getHeight()
    self.tileset.atlas[0] = love.graphics.newQuad(0 * self.tileSize.x, 0, self.tileSize.x, self.tileSize.y, quadWidth, quaHeight)
    self.tileset.atlas[1] = love.graphics.newQuad(1 * self.tileSize.x, 0, self.tileSize.x, self.tileSize.y, quadWidth, quaHeight)
    self.tileset.atlas[2] = love.graphics.newQuad(2 * self.tileSize.x, 0, self.tileSize.x, self.tileSize.y, quadWidth, quaHeight)
    self.tileset.atlas[3] = love.graphics.newQuad(3 * self.tileSize.x, 0, self.tileSize.x, self.tileSize.y, quadWidth, quaHeight)
    self.tileset.atlas[4] = love.graphics.newQuad(4 * self.tileSize.x, 0, self.tileSize.x, self.tileSize.y, quadWidth, quaHeight)

    self.mapSpriteBatch = love.graphics.newSpriteBatch(self.tileset.sourceImage, self.mapSize.x * self.mapSize.x)
    self:renderRegion(Vector(0, 0), Vector(5, 5))
end

function TileMap.update(self, dt)
    
end

function TileMap.draw(self)
    love.graphics.draw(self.mapSpriteBatch)
end
--#endregion

function TileMap.setTileSet(self, sourceFilename)
    self.tileset = Tileset(self.tileSize, sourceFilename)
end

-- inicializamos los valores, sin nada de información visual
function TileMap.initialize(self)
    for x = 1, self.mapSize.X do
        for y = 1, self.mapSize.Y do
            self.cells[x][y] = love.math.random(0, 3) -- test, quitar
        end
    end
end


function TileMap.renderRegion(self, regionOrigin, regionSize)
    for x = regionOrigin.x, regionSize.x do
        for y = regionOrigin.y, regionSize.y do
            self:setCell(x, y, self.tileset.atlas[3])     -- TODO: hay que pasar la cell que sea en función de la información del mundo
        end
    end
end

function TileMap.setCell(self, x, y, cell)
    -- para colocar una tile de algún tileset en la posición (x, y). Hay que pensar que será cell, si la imagen, un diccionario con información de la tile, etc. (clase Cell??)
    self.mapSpriteBatch:add(cell, x*self.tileSize.x, y*self.tileSize.y)
end


-- todo: para traducir coordenadas, en ambos sentidos
function TileMap.mapToWorldPosition(self, x, y)
    -- devolvemos el topleft de la casilla en función de tileSize,x e y 
    return Vector(self.position.x + x * self.tileSize.x, self.position.y + y * self.tileSize.y)
end

function TileMap.worldToMapPosition(self, x, y)
    -- tenemos que obtener la celda dentro del cual está (x, y) (división entera)
end