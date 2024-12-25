--! file: astar.lua
require "util/pathfinding/luafinding/luafinding"
require "util/pathfinding/luafinding/vector"
AStar = Object.extend(Object)


function AStar.new(self, sizeX, sizeY)
    self.map = {}
    self.mapSizeX = sizeX
    self.mapSizeY = sizeY

    self:initializeMap(sizeX, sizeY)
end

function AStar.initializeMap(self, sizeX, sizeY)
    for x = 1, sizeX do
        self.map[x] = {}
        for y = 1, sizeY do
            self.map[x][y] = true
        end
    end
end

function AStar.addObstacle(self, x, y)
    self.map[x][y] = false
end

function AStar.removeObstacle(self, x, y)
    self.map[x][y] = true
end

function AStar.getPath(self, startX, startY, finishX, finishY)
    return Luafinding( Vector(startX, startY), Vector(finishX, finishY), self.map ):GetPath()
end

