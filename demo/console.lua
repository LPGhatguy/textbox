--[[
This demo shows a simple console with history, evaluating the input as Lua code.

It doesn't report output back to the console history, but it does report errors
to the console. Any extra functionality is left as an exercise to the reader.
]]
return function(textbox)
	local history = {}
	local context = textbox.InputContext()

	love.graphics.setNewFont(20)

	function love.draw()
		local height = love.graphics.getFont():getHeight()
		local y = love.graphics.getHeight() - height - 8

		love.graphics.print("> " .. context.value, 8, y)

		y = y - height - 4

		for i = #history, 1, -1 do
			love.graphics.print(history[i], 8, y)
			y = y - height - 4
		end
	end

	function love.textinput(text)
		context:textinput(text)
	end

	function love.keypressed(key)
		if (key == "return") then
			local ok, err = pcall(function()
				local chunk, err = loadstring(context.value)

				if (not chunk) then
					print("CONSOLE ERROR:", err)
					return
				end

				chunk()
			end)

			if (not ok) then
				print("CONSOLE ERROR", err)
			end

			table.insert(history, context.value)
			context.value = ""
			context.cursor = 0
			return
		end

		if (key == "escape") then
			love.event.push("quit")
			return
		end

		context:keypressed(key)
	end
end