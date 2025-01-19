--! file: tilemap.lua
require("src.util.tilemap.tileset")
TileMap = Object.extend(Object)

-- https://love2d.org/wiki/Tutorial:Efficient_Tile-based_Scrolling

function TileMap.new(self, mapSize, tileSize, tileSetPath)
    self.world = nil    -- TODO: el tilemap debe conocer el mundo que está renderizando (o al menos cierta información)
    self.position = Vector2(0, 0)
    self.mapSize = mapSize
    self.tileSize = tileSize
    self.zoom = Vector2(1, 1)
    self.tileset = nil
    self.cells = {}
    self.tileSetPath = tileSetPath  -- podríamos tener más de un tileset...
    self.mapSpriteBatch = nil -- la propia imagen del mapa
end

function TileMap.load(self)
    -- TODO: para pruebas. formar el tileset
    self.tileset = Tileset(self.tileSize)
    self.tileset:load(self.tileSetPath)

    local quadWidth = self.tileset.sourceImage:getWidth()
    local quadHeight = self.tileset.sourceImage:getHeight()

    -- pruebas
    self.tileset.atlas:insertAtPosition(love.graphics.newQuad(0 * self.tileSize.x, 0, self.tileSize.x, self.tileSize.y, quadWidth, quadHeight), 1)
    self.tileset.atlas:insertAtPosition(love.graphics.newQuad(0 * self.tileSize.x, 0, self.tileSize.x, self.tileSize.y, quadWidth, quadHeight), 2)
    self.tileset.atlas:insertAtPosition(love.graphics.newQuad(0 * self.tileSize.x, 0, self.tileSize.x, self.tileSize.y, quadWidth, quadHeight), 3)
    self.tileset.atlas:insertAtPosition(love.graphics.newQuad(0 * self.tileSize.x, 0, self.tileSize.x, self.tileSize.y, quadWidth, quadHeight), 4)
    self.tileset.atlas:insertAtPosition(love.graphics.newQuad(0 * self.tileSize.x, 0, self.tileSize.x, self.tileSize.y, quadWidth, quadHeight), 5)

    self.mapSpriteBatch = love.graphics.newSpriteBatch(self.tileset.sourceImage, self.mapSize.x * self.mapSize.x)
    self:renderRegion(Vector2(0, 0), Vector2(5, 5))
end

function TileMap.update(self, dt)
    
end

function TileMap.draw(self)
    love.graphics.draw(self.mapSpriteBatch)
end

function TileMap.setTileSet(self, sourceFilename)
    self.tileset = Tileset(self.tileSize, sourceFilename)
end

function TileMap.renderRegion(self, regionOrigin, regionSize)
    for x = regionOrigin.x, regionSize.x do
        for y = regionOrigin.y, regionSize.y do
            self:setCell(x, y, self.tileset.atlas:get(1))     -- TODO: esto es una prueba, hay que pasar la cell que sea en función de la información del mundo
        end
    end
end

function TileMap.setCell(self, x, y, cell)
    -- TODO Hay que pensar que será cell, si la imagen, un diccionario con información de la tile, etc. (clase Cell??)
    self.mapSpriteBatch:add(cell, x*self.tileSize.x, y*self.tileSize.y)
end

function TileMap.mapToWorldPosition(self, x, y)
    return self.position.x + x * self.tileSize.x, self.position.y + y * self.tileSize.y
end

function TileMap.worldToMapPosition(self, x, y)
    return math.floor(x / self.tileSize.x), math.floor(y / self.tileSize.y)
end