very easy awesome wm scratchpad. [中文版本](./readme.zh.md)

## usage

Directly download this repository and then place it in your ~/.config/awesome/ folder.

```lua
local scratchpad = require 'scratchpad'

-- Create spad, For this configuration, you can refer to https://blingcorp.github.io/bling/. However, only the following items are useful here.
local spad = scratchpad.create {
  command = '', -- Run command
  rule = { instance = 'crx_cadlkienfkclaiaibeoongdcgmdikeeg' }, -- Match client
  geometry = { x = 560, y = 290, height = 500, width = 800 }, -- Position
  floating = true,
}

-- Use spad
spad.toggle()
spad.turn_on()
spad.turn_off()

-- Also provides a method to close previously opened spad when restore the awesome configuration.
scratchpad.reset()
```

## Why implement this function by myself

I originally used [bling](https://blingcorp.github.io/bling/) to implement this function, but it has a problem. Sometimes it will recognize other normally opened applications as scratchpads and open them in float form. Then after unfocusing, the entire application disappears. This forces me to close all processes of this application first and then reopen it, which often gives me a headache.

Then I implemented this function by myself and found that the code is very simple. You can download the code to your local machine and then modify its functions. I think this is very simple.
