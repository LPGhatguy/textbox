local InputContext = {
	prototype = {}
}

function InputContext:new(value)
	local new = setmetatable({
		value = value or "",
		cursor = 0,
		onUpdate = nil
	}, {
		__index = InputContext.prototype
	})

	return new
end

function InputContext.prototype:_triggerUpdate()
	if (self.onUpdate) then
		self:onUpdate()
	end
end

function InputContext.prototype:textinput(text)
	local before = self.value:sub(1, self.cursor)
	local after = self.value:sub(self.cursor + 1)

	self.value = before .. text .. after
	self.cursor = self.cursor + text:len()

	self:_triggerUpdate()
end

function InputContext.prototype:keypressed(key)
	if (key == "backspace") then
		self:backspace()
	elseif (key == "left") then
		self:moveCursor(-1)
	elseif (key == "right") then
		self:moveCursor(1)
	end
end

function InputContext.prototype:backspace()
	local before = self.value:sub(1, self.cursor - 1)
	local after = self.value:sub(self.cursor + 1)

	self.value = before .. after
	self.cursor = math.max(0, self.cursor - 1)

	self:_triggerUpdate()
end

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