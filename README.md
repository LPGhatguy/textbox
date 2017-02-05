# Textbox
Textbox is a library used to manage text box state. It is meant to be used as the input manager for any Lua UI toolkit.

Textbox is based around the lifecycle of `InputContext` objects. One `InputContext` object is intended to map to one text input field. While the input has focus, you should call the `textinput` and `keypressed` methods on the `InputContext` object when appropriate. These correspond to the arguments and semantics of the LÖVE API.

## Installation
Textbox is built to target **LÖVE 0.10.0** and newer, but has no specific dependence on it.

Put the `textbox` folder into your project and require it.

## Usage
See the `demo` folder for a more detailed example.

```lua
local textbox = require("textbox")

local context = textbox.InputContext()

function love.draw()
	love.graphics.print(context.value, 0, 0)
end

function love.keypressed(key)
	context:keypressed(key)
end

function love.textinput(text)
	context:textinput(text)
end
```

## TODO
- Tests
- Explicit UTF-8 support
- Selection support
- Multiline editing
- Shortcuts
	- Select all
	- Cut, Copy, Paste