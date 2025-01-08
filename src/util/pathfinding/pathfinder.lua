--! file: pathfinder.lua
local Pathfinder = require ("src.util.pathfinding.jumper.pathfinder")
local Grid = require ("src.util.pathfinding.jumper.grid")

PathFinder = Object.extend(Object)

function PathFinder.new(self, sizeX, sizeY, finderType)
    self.map = {}
    self.mapSizeX = sizeX
    self.mapSizeY = sizeY
    self.walkableValue = 1
    self.nonWalkableValue = 0
    self.grid = nil
    self.finderType = finderType
    self.finder = nil
    self:initializeMap(sizeX, sizeY)
end

function PathFinder.initializeMap(self, sizeX, sizeY)
    for x = 0, sizeX do
        self.map[x] = {}
        for y = 0, sizeY do
            self.map[x][y] = self.walkableValue
        end
    end
    self.grid = Grid(self.map)
    self.finder = Pathfinder(self.grid, self.finderType, self.walkableValue)
end

function PathFinder.addObstacle(self, x, y)
    self.map[x][y] = self.nonWalkableValue
end

function PathFinder.removeObstacle(self, x, y)
    self.map[x][y] = self.walkableValue
end

function PathFinder.getPath(self, startx, starty, endx, endy)
    local path = self.finder:getPath(startx, starty, endx, endy)
    local toReturn = {}
    if path then
          for node, count in path:nodes() do    -- TODO se podría hacer más eficiente mirando el código de la librería
            table.insert(toReturn, {x = node:getX(), y = node:getY()})
          end
      end
    --   table.remove(toReturn, 1)
    return toReturn
end