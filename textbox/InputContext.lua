local InputContext = {
	prototype = {},
	platform = nil
}

if (love) then
	InputContext.platform = love.system.getOS()
end

--[[
	Creates a new InputContext with the given text, which defaults to an empty
	string.
]]
function InputContext:new(value)
	value = value or ""

	local new = setmetatable({
		value = value,
		cursor = value:len(),
		selectionEnd = value:len(),
		onUpdate = nil
	}, {
		__index = InputContext.prototype
	})

	return new
end

--[[
	Internal method to trigger the onUpdate event.
]]
function InputContext.prototype:_triggerUpdate()
	if (self._updating) then
		return
	end

	self._updating = true

	if (self.onUpdate) then
		self:onUpdate()
	end

	self._updating = false
end

function InputContext.prototype:_isMetaDown()
	if (InputContext.platform == "OS X") then
		return love.keyboard.isDown("lgui", "gui")
	end

	return love.keyboard.isDown("lctrl", "rctrl")
end

--[[
	Call this method when receiving text from the user.
]]
function InputContext.prototype:textinput(text)
	self:insert(text)
end

--[[
	Call this method when the user presses a key.
]]
function InputContext.prototype:keypressed(key)
	if (key == "backspace") then
		self:backspace()
	elseif (key == "delete") then
		self:forwardDelete()
	elseif (key == "left") then
		local selection = self.selectionEnd
		self:moveCursor(-1)

		if (love.keyboard.isDown("lshift", "rshift")) then
			self.selectionEnd = selection
		end
	elseif (key == "right") then
		local selection = self.selectionEnd
		self:moveCursor(1)

		if (love.keyboard.isDown("lshift", "rshift")) then
			self.selectionEnd = selection
		end
	elseif (key == "home") then
		local selection = self.selectionEnd
		self:moveCursorHome()

		if (love.keyboard.isDown("lshift", "rshift")) then
			self.selectionEnd = selection
		end
	elseif (key == "end") then
		local selection = self.selectionEnd
		self:moveCursorEnd()

		if (love.keyboard.isDown("lshift", "rshift")) then
			self.selectionEnd = selection
		end
	elseif (self:_isMetaDown()) then
		if (key == "a") then
			self:selectAll()
		elseif (key == "c") then
			love.system.setClipboardText(self:getSelection())
		elseif (key == "x") then
			love.system.setClipboardText(self:getSelection())
			self:backspace()
		elseif (key == "v") then
			local text = love.system.getClipboardText()
			self:insert(text)
		end
	end
end

--[[
	Inserts the given text at the current cursor position.
]]
function InputContext.prototype:insert(text)
	local min = math.min(self.cursor, self.selectionEnd)
	local max = math.max(self.cursor, self.selectionEnd)

	local before = self.value:sub(1, min)
	local after = self.value:sub(max + 1)

	self.value = before .. text .. after
	self:setCursor(min + text:len())

	self:_triggerUpdate()
end

--[[
	Returns the currently selected text
]]
function InputContext.prototype:getSelection()
	local min = math.min(self.cursor, self.selectionEnd)
	local max = math.max(self.cursor, self.selectionEnd)

	return self.value:sub(min, max)
end

--[[
	Equivalent to pressing the 'backspace' key.
]]
function InputContext.prototype:backspace()
	local min = math.min(self.cursor, self.selectionEnd)
	local max = math.max(self.cursor, self.selectionEnd)

	if (min == max) then
		min = math.max(0, min - 1)
	end

	local before = self.value:sub(1, min)
	local after = self.value:sub(max + 1)

	self.value = before .. after
	self:setCursor(min)

	self:_triggerUpdate()
end

--[[
	Equivalent to pressing the 'delete' key.
]]
function InputContext.prototype:forwardDelete()
	local min = math.min(self.cursor, self.selectionEnd)
	local max = math.max(self.cursor, self.selectionEnd)

	if (min == max) then
		max = max + 1
	end

	local before = self.value:sub(1, min)
	local after = self.value:sub(max + 1)

	self.value = before .. after
	self:setCursor(min)

	self:_triggerUpdate()
end

--[[
	Moves the cursor to the beginning of the line.
]]
function InputContext.prototype:moveCursorHome()
	self:setCursor(-math.huge)
end

--[[
	Moves the cursor for the end of the line.
]]
function InputContext.prototype:moveCursorEnd()
	self:setCursor(math.huge)
end

--[[
	Moves the cursor by the specified amount.
]]
function InputContext.prototype:moveCursor(x)
	x = x or 0

	self:setCursor(self.cursor + x)
end

--[[
	Sets the cursor to the given position.
]]
function InputContext.prototype:setCursor(x)
	self.cursor = math.max(0, math.min(#self.value, x))
	self.selectionEnd = self.cursor
end

--[[
	Selects all text in the text box.
]]
function InputContext.prototype:selectAll()
	self:moveCursorEnd()
	self.selectionEnd = 0
end

return setmetatable(InputContext, {
	__call = function(self, ...)
		return self:new(...)
	end
})