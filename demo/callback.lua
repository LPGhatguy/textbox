--[[
This demo shows one technique to integrate Textbox with an existing UI library.

Set the 'onUpdate' property of an InputContext to receive a callback whenever
the state of the InputContext changes. Use this to update any retained-mode UI
components that depend on the state.

Here, our input component is 'myTextBox', which just stores its own text value.
]]
return function(textbox)
	local myTextBox = {
		text = ""
	}

	local context = textbox.InputContext(myTextBox.text)
	love.graphics.setNewFont(32)

	context.onUpdate = function(self)
		myTextBox.text = self.value
	end

	function love.draw()
		love.graphics.print(myTextBox.text, x, y)
	end

	function love.keypressed(key)
		if (key == "escape") then
			love.event.push("quit")
			return
		end

		context:keypressed(key)
	end

	function love.textinput(text)
		context:textinput(text)
	end
end