--! file: ui_text_box.lua
utf8 = require("utf8")
require "entity/base_entity"


UiTextBox = Object.extend(BaseEntity)


function UiTextBox.new(self, text, isActive)
	self.text = text
	self.isActive = isActive
	self:load(true)
end

function UiTextBox.load(self, setKeyRepeat)
    love.keyboard.setKeyRepeat(setKeyRepeat) -- enable key repeat so backspace can be held down to trigger love.keypressed multiple times.
end

function UiTextBox.onTextInput(self, textInp)
	if self.isActive == false then
		return
	end
    self.text = self.text .. textInp
end

function UiTextBox.onKeyPressed(self, key)
	if self.isActive == false then
		return
	end
	if key == "backspace" then
	    -- get the byte offset to the last UTF-8 character in the string.
	    local byteoffset = utf8.offset(self.text, -1)
	    if byteoffset then
	        -- remove the last UTF-8 character.
	        -- string.sub operates on bytes rather than UTF-8 characters, so we couldn't do string.sub(text, 1, -2).
	        self.text = string.sub(self.text, 1, byteoffset - 1)
	    end
	end
	-- si pulsamos ENTER...
end


function UiTextBox.draw(self)
    love.graphics.printf(self.text, 0, 0, love.graphics.getWidth())
end