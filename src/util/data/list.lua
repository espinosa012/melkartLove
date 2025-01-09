--! file: list.lua
List = Object.extend(Object)

-- TODO: necesitaríamos una manera de iterar sobre la lista sin necesidad de acceder a su 'items'. igual para acceder por índice

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
	table.insert(self.items, obj)
	self.size = #self.items
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

function List.has(self, obj)
   return self.pointers[obj]
end

-- untested
function List.remove(self, obj)
	table.remove(self.items, self:find(obj))
end

-- untested
function List.removeAtPosition(self, pos)
	table.remove(self.items, pos)
end