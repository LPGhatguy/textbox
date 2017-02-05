local textbox = require("textbox")
local InputContext = textbox.InputContext

describe("basic input", function()
	it("should append to the end of the value", function()
		local context = InputContext()

		context:insert("a")
		assert.equal("a", context.value)

		context:insert("bc")
		assert.equal("abc", context.value)
	end)

	it("should input after the cursor", function()
		local context = InputContext()

		context:insert("a")
		assert.equal("a", context.value)

		context.cursor = 0
		context:insert("b")
		assert.equal("ba", context.value)

		context:insert("c")
		assert.equal("bca", context.value)
	end)
end)