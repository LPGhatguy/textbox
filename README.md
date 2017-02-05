# Textbox
[![Travis CI Build Status](https://api.travis-ci.org/LPGhatguy/textbox.svg?branch=master)](https://travis-ci.org/LPGhatguy/textbox)

Textbox is a library used to manage text box state. It is meant to be used as the input manager for any LÖVE UI widget or toolkit.

Textbox is based around the lifecycle of `InputContext` objects. One `InputContext` object is intended to map to one text input field. While the input has focus, you should call the `textinput` and `keypressed` methods on the `InputContext` object when appropriate. These correspond to the arguments and semantics of the LÖVE API.

## Installation
Textbox requires **LÖVE 0.10.0** or newer.

Put the `textbox` folder into your project and require it.

## Features
Textbox provides these features:

- Text entry
- Selection
- Cursor movement
- Backspace and forward-delete
- Home/End keys
- Select all
- Copy/Cut/Paste

## Sample Usage
See the `demo` folder for more detailed examples.

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
- Explicit UTF-8 support
- IME support
- Multiline editing