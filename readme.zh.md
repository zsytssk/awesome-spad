十分简单的 awesomewm 的 scratchpad

## usage

直接下载这个仓库，然后丢到你的`~/.config/awesome/`文件夹中。
他提供了两个方法

```lua
local scratchpad = require 'scratchpad'

-- 创建spad, 这个配置你可以参考 https://blingcorp.github.io/bling/#/，但是只有下面几条在这里有用
local spad = scratchpad.create {
    command = "wezterm start --class spad",           -- How to spawn the scratchpad
    rule = { instance = "spad" },                     -- The rule that the scratchpad will be searched by
    floating = true,                                  -- Whether it should be floating (MUST BE TRUE FOR ANIMATIONS)
    geometry = {x=360, y=90, height=900, width=1200}, -- The geometry in a floating state
}

-- 使用 spad
spad.toggle()
spad.turn_on()
spad.turn_off()

-- 还提供一个方法，在重置awesome配置时关闭以前打开的spad
scratchpad.reset()
```

## 为什么要自己实现这个功能

我本来是使用[bling](https://blingcorp.github.io/bling/)实现这个功能，但是他有一个问题
有时候他会把其他正常打开的应用识别成 scratchpad，用 float 形式打开，然后在 unfocus 后整个应用就都不见了
这让我不得不先关闭所有这个应用的进程再重新打开，这常常让我很头痛。

然后我自己实现这个功能，我发现代码十分的简单。你可以把代码下载到自己本地，然后去修改其中的功能，我想这是十分简单的。
