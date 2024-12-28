--! file: tileset.lua
Tileset = Object.extend(Object)

function Tileset.new(self, tileSize)
    self.sourceImage = nil
    self.spriteBatch = nil
    self.atlas = nil  -- son los distintos quads
    self.tileSize = tileSize

end

function  Tileset.load(self, sourceFilename)
    self:setSource(sourceFilename)
    self.atlas = {}
end

function Tileset.setSource(self, sourceFilename)
    self.sourceImage = love.graphics.newImage(sourceFilename)
    self.sourceImage:setFilter("nearest", "linear")
end