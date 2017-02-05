local InputContext = {
	prototype = {}
}

--[[
	Creates a new InputContext with the given text, which defaults to an empty
	string.
]]
function InputContext:new(value)
	value = value or ""

	local new = setmetatable({
		value = value,
		cursor = value:len(),
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
	if (self.onUpdate) then
		self:onUpdate()
	end
end

--[[
	Call this method when receiving text from the user.
]]
function InputContext.prototype:textinput(text)
	local before = self.value:sub(1, self.cursor)
	local after = self.value:sub(self.cursor + 1)

	self.value = before .. text .. after
	self.cursor = self.cursor + text:len()

	self:_triggerUpdate()
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
		self:moveCursor(-1)
	elseif (key == "right") then
		self:moveCursor(1)
	elseif (key == "home") then
		self:moveCursor(-math.huge)
	elseif (key == "end") then
		self:moveCursor(math.huge)
	end
end

--[[
	Equivalent to pressing the 'backspace' key.
]]
function InputContext.prototype:backspace()
	local before = self.value:sub(1, self.cursor - 1)
	local after = self.value:sub(self.cursor + 1)

	self.value = before .. after
	self.cursor = math.max(0, self.cursor - 1)

	self:_triggerUpdate()
end

--[[
	Equivalent to pressing the 'delete' key.
]]
function InputContext.prototype:forwardDelete()
	local before = self.value:sub(1, self.cursor)
	local after = self.value:sub(self.cursor + 2)

	self.value = before .. after

	self:_triggerUpdate()
end

--[[
	Moves the cursor by the specified amount.
]]
function InputContext.prototype:moveCursor(x)
	x = x or 0

	self.cursor = math.max(0, math.min(#self.value, self.cursor + x))

	self:_triggerUpdate()
end

return setmetatable(InputContext, {
	__call = function(self, ...)
		return self:new(...)
	end
})