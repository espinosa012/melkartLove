--! file: list.lua
List = Object.extend(Object)


function List.new(self)
	self.objects = {}
	self.pointers = {}
	self.size = 0	
end

function List.clear()
   self.objects = {}
   self.pointers = {}
   self.size = 0
end

function List.add(self, object)
	local size = self.size + 1	
	self.objects[size-1] = object
	self.pointers[object] = size
	self.size = size
end

function List.get(self, index)
   return self.objects[index]
end

function List.has(obj)
   return self.pointers[obj]
end
