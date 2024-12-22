--! file: main_controller.lua
CharacterController = Object.extend(Object)

require "util/data/list"

function CharacterController.new(self)
	self.availableCharacters = List()	-- la clase creo que no está del todo bien definida, buscar algo más robusto
	self.selectedCharacter = nil
end


function CharacterController.addCharacter(self, entity)
	self.availableCharacters:add(entity)
end

function CharacterController.selectCharacter(self, characterIndex)
	self.selectedCharacter = self.availableCharacters:get(characterIndex)
	self.selectedCharacter.sprite:setDrawMode("fill")
end

function CharacterController.clearSelection(self)
	self.selectedCharacter.sprite:setDrawMode("line")
end


function CharacterController.onTextInput(self, key)
end

function CharacterController.onKeyPressed(self, key)
	if key == "1" then self:selectCharacter(0) end
	if key == "escape" then self:clearSelection() end
end

function CharacterController.onActionKeyPressed(self, key)

end

