-- require 'scratchpad.type.config'
local awful = require 'awful'
local utils = require 'scratchpad.utils'

--- @class Scratchpad
--- @field is_run boolean 是否启动
--- @field is_on boolean 是否显示
--- @field config Config
--- @field client any
local Scratchpad = {}

--- 创建一个新的 Scratchpad 实例
--- @param config Config  -- 传入的 config 是一个 Config 类型
--- @return Scratchpad    -- 返回一个 Scratchpad 实例
function Scratchpad:new(config)
  local obj = {}
  setmetatable(obj, self)
  self.__index = self

  obj:reset()
  obj.config = config
  return obj
end

function Scratchpad:toggle()
  if self.is_on then
    self:turn_off()
  else
    self:turn_on()
  end
end

function Scratchpad:turn_on()
  if self.is_run then
    self:apply(self.client)
    self.is_on = true
    return
  end
  self.is_run = true
  self.is_on = true

  local cur_tag = awful.screen.focused().selected_tag
  awful.spawn.easy_async(self.config.command)
  utils.wait_client_open(self.config.rule, function(c)
    -- 防止c因为class匹配awful.rules.rules，跳转到其他tag去了
    if c.tag ~= cur_tag then
      c:move_to_tag(cur_tag)
      cur_tag:view_only()
    end
    self:bind_client(c)
  end)
end

function Scratchpad:turn_off()
  if not self.is_run and not self.is_on then
    return
  end
  self.is_on = false
  utils.hide_client(self.client)
end

-- 绑定client,监听[close, focus, unfocus]
function Scratchpad:apply(c)
  local config = self.config
  c.floating = config.floating
  c.fullscreen = false
  c.maximized = false
  c:geometry {
    x = config.geometry.x + awful.screen.focused().geometry.x,
    y = config.geometry.y + awful.screen.focused().geometry.y,
    width = config.geometry.width,
    height = config.geometry.height,
  }

  utils.show_client(c)
end

function Scratchpad:bind_client(c)
  self.client = c
  c:connect_signal('unmanage', function()
    self:reset()
  end)

  local leave = false
  local enterFn = function()
    leave = false
  end
  local leaveFn = function()
    leave = true
    utils.set_timeout(function()
      if leave then
        self:turn_off()
      end
    end, 0.3)
  end

  c:connect_signal('focus', enterFn)
  c:connect_signal('unfocus', leaveFn)

  self:apply(c)
end

function Scratchpad:reset()
  self.client = nil
  self.is_run = false
  self.is_on = false
end

return Scratchpad
