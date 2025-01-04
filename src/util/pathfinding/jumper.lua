local Pathfinder = require ("src.util.pathfinding.jumper.pathfinder")
local Grid = require ("src.util.pathfinding.jumper.grid")

-- mio
Jumper = Object.extend(Object)


function Jumper.new(self, sizeX, sizeY)
    self.map = {}
    self.mapSizeX = sizeX
    self.mapSizeY = sizeY

    self.walkableValue = 1
    self.nonWalkableValue = 0
    self.grid = nil

    self.finderType = 'ASTAR'
    self.finder = nil

    self:initializeMap(sizeX, sizeY)
end

function Jumper.initializeMap(self, sizeX, sizeY)
    for x = 0, sizeX do
        self.map[x] = {}
        for y = 0, sizeY do
            self.map[x][y] = self.walkableValue
        end
    end
    self.grid = Grid(self.map)
    self.finder = Pathfinder(self.grid, self.finderType, self.walkableValue)
end

function Jumper.addObstacle(self, x, y)
    self.map[x][y] = self.nonWalkableValue
end

function Jumper.removeObstacle(self, x, y)
    self.map[x][y] = self.walkableValue
end

function Jumper.getPath(self, startx, starty, endx, endy)
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



-- Set up a collision map
-- local map = {
-- 	{0,1,0,1,0},
-- 	{0,1,0,1,0},
-- 	{0,1,1,1,0},
-- 	{0,0,0,0,0},
-- }
-- -- Value for walkable tiles
-- local walkable = 0

-- -- Library setup
-- -- Calls the grid class
-- local Grid = require ("jumper.grid")
-- -- Calls the pathfinder class

-- Creates a grid object
-- local grid = Grid(map)

-- Creates a pathfinder object using Jump Point Search algorithm
-- local myFinder = Pathfinder(grid, 'JPS', walkable)

-- -- Define start and goal locations coordinates
-- local startx, starty = 1,1
-- local endx, endy = 5,1

-- Calculates the path, and its length
-- local path = myFinder:getPath(startx, starty, endx, endy)

-- Pretty-printing the results
