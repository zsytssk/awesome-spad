local awful = require 'awful'

local set_timeout = function(func, time)
  if not (type(time) == 'number') then
    time = 0
  end

  ---@diagnostic disable-next-line: undefined-global
  local task = timer { timeout = time }
  task:connect_signal('timeout', function()
    func()
    task:stop()
  end)
  task:start()
end

local wait_client_open = function(rule, callback, end_time)
  if not (type(end_time) == 'number') then
    end_time = 5
  end

  local watch_open
  watch_open = function(c)
    if awful.rules.match(c, rule) then
      callback(c)
      client.disconnect_signal('manage', watch_open)
    end
  end

  set_timeout(function()
    client.disconnect_signal('manage', watch_open)
  end, end_time)
  client.connect_signal('manage', watch_open)
end

local hide_client = function(c)
  c.sticky = false
  c.hidden = true
  c.ontop = false
end

local show_client = function(c)
  c.sticky = true
  c.hidden = false
  c.ontop = true
  client.focus = c
  c:raise()
end

return {
  wait_client_open = wait_client_open,
  hide_client = hide_client,
  show_client = show_client,
}
