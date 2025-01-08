--! file: list.lua
List = Object.extend(Object)


function List.new(self)
	self.items = nil
	self.pointers = nil
	self.size = 0
	self:clear()
end

function List.clear(self)
   self.items = {}
   self.pointers = {}
   self.size = 0
end

function List.add(self, obj)
	local size = self.size + 1
	table.insert(self.items, obj)
	self.size = size
end

function List.insertAtPosition(self, obj, position)
	table.insert(self.items, position, obj)
end

function List.get(self, index)
   return self.items[index]
end

function List.find(self, obj)
	for index, value in ipairs(self.items) do if value == obj then return index end end
	return nil
end

function List.has(obj)
   return self.pointers[obj]
end
