--[[
This demo shows the barebone of Textbox.

Create an InputContext for each text box in your system, and call the
'keypressed' and 'textinput' methods on the object when user input is received.

The library provides no rendering mechanisms. See 'cursor.lua' for an example
cursor rendering implementation.
]]
return function(textbox)
	local context = textbox.InputContext("Basic Demo")
	love.graphics.setNewFont(32)

	function love.draw()
		love.graphics.print(context.value, x, y)
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