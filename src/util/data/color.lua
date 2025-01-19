--! file: color.lua
Color = _G.Object.extend(Object)

function Color.new(self, r, g, b)
	self.R = r
	self.G = g
	self.B = b
end