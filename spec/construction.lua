local textbox = require("textbox")
local InputContext = textbox.InputContext

describe("InputContext construction", function()
	it("should work with a function call", function()
		local context = InputContext()

		assert(context)
		assert.equal("", context.value)
	end)

	it("should work with an explicit constructor", function()
		local context = InputContext:new()

		assert(context)
		assert.equal("", context.value)
	end)

	it("should set values from parameters", function()
		local context = InputContext("Hello, world!")

		assert.equal("Hello, world!", context.value)
	end)
end)