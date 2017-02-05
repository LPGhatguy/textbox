local textbox = require("textbox")
local InputContext = textbox.InputContext

describe("hotkeys", function()
	it("should backspace", function()
		local context = InputContext("Hello")

		context:backspace()
		assert.equal("Hell", context.value)

		context:setCursor(1)
		context:backspace()
		assert.equal("ell", context.value)
		assert.equal(0, context.cursor)

		context:backspace()
		assert.equal("ell", context.value)
	end)

	it("should forward-delete", function()
		local context = InputContext("Hello")

		context:forwardDelete()
		assert.equal("Hello", context.value)

		context:setCursor(0)
		context:forwardDelete()
		assert.equal("ello", context.value)
		assert.equal(0, context.cursor)

		context:setCursor(1)
		context:forwardDelete()
		assert.equal("elo", context.value)
		assert.equal(1, context.cursor)
	end)

	it("should arrow left and right", function()
		local context = InputContext("Hello, world!")

		context:setCursor(0)
		context:moveCursor(1)
		assert.equal(1, context.cursor)

		context:moveCursor(2)
		assert.equal(3, context.cursor)

		context:moveCursor(-1)
		assert.equal(2, context.cursor)
	end)

	it("should seek to home", function()
		local context = InputContext("Hello")

		context:moveCursorHome()
		assert.equal(0, context.cursor)

		context.cursor = 3
		context:moveCursorHome()
		assert.equal(0, context.cursor)
	end)

	it("should seek to end", function()
		local context = InputContext("Hello")

		context:moveCursorEnd()
		assert.equal(5, context.cursor)

		context:setCursor(3)
		context:moveCursorEnd()
		assert.equal(5, context.cursor)
	end)

	it("should select all", function()
		local context = InputContext("Hello, world!")

		context:selectAll()
		assert.equal(context.value:len(), context.cursor)
		assert.equal(0, context.selectionEnd)
	end)
end)