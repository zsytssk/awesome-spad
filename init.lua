-- 参考 https://blingcorp.github.io/bling/

local awful = require 'awful'
local Scratchpad = require 'scratchpad.scratchpad'

local spad_list = {}
--- @param config Config
local create = function(config)
  local spad = Scratchpad:new(config)
  table.insert(spad_list, spad)
  return spad
end

-- 关闭所有client
local reset = function()
  local function matcher(c)
    for _, spad in ipairs(spad_list) do
      if awful.rules.match(c, spad.config.rule) then
        return true
      end
    end
    return false
  end

  local list = client.get()
  for _, c in ipairs(list) do
    if matcher(c) then
      c:kill()
    end
  end
end

return { create = create, reset = reset }
