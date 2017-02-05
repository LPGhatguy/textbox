local textbox = require("textbox")

local demos = {
	"basic",
	"cursor",
	"callback",
	"console"
}

print("Enter a number, or press 'q' to quit:")

for key, value in ipairs(demos) do
	print("\t" .. key .. ". " .. value)
end

local demo

while (true) do
	local input = 2 --io.read()

	if (input == "q") then
		love.event.push("quit")
		return
	end

	demo = demos[tonumber(input)]

	if (demo) then
		break
	end

	print("Please enter a valid demo number, or enter 'q' to quit")
end

love.keyboard.setKeyRepeat(true)

require("demo." .. demo)(textbox)