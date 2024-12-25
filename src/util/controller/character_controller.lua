--! file: character_controller.lua
require "util/data/list"
CharacterController = Object.extend(Object)

function CharacterController.new(self)
	self.availableCharacters = {}
	self.selectedCharacter = nil
end

function CharacterController.addCharacter(self, entity)
	table.insert(self.availableCharacters, entity)
end

function CharacterController.onKeyPressed(self, key)
	if key == "1" then self:selectCharacter(0) end
	if key == "escape" then self:clearSelection() end
end

function CharacterController.onActionKeyPressed(self, key)
end

function CharacterController.selectCharacter(self, characterIndex)
	self.selectedCharacter = self.availableCharacters[characterIndex + 1]
end

function CharacterController.clearSelection(self)
	if self.selectedCharacter ~= nil then
	end
end