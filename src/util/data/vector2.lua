--! file: vector.lua
local Vector2 = {}
Vector2.__index = Vector2

local function new( x, y )
    return setmetatable( { x = x or 0, y = y or 0 }, Vector2 )
end

function _G.isVector( vTbl )
    return getmetatable( vTbl ) == Vector2
end

function Vector2.__unm( vTbl )
    return new( -vTbl.x, -vTbl.y )
end

function Vector2.__add( a, b )
    return new( a.x + b.x, a.y + b.y )
end

function Vector2.__sub( a, b )
    return new( a.x - b.x, a.y - b.y )
end

function Vector2.__mul( a, b )
    if type( a ) == "number" then
        return new( a * b.x, a * b.y )
    elseif type( b ) == "number" then
        return new( a.x * b, a.y * b )
    else
        return new( a.x * b.x, a.y * b.y )
    end
end

function Vector2.__div( a, b )
    return new( a.x / b, a.y / b )
end

function Vector2.__eq( a, b )
    return a.x == b.x and a.y == b.y
end

function Vector2:__tostring()
    return "(" .. self.x .. ", " .. self.y .. ")"
end

function Vector2:ID()
    if self._ID == nil then
        local x, y = self.x, self.y
        self._ID = 0.5 * ( ( x + y ) * ( x + y + 1 ) + y )
    end
    return self._ID
end

return setmetatable( Vector2, { __call = function( _, ... ) return new( ... ) end } )