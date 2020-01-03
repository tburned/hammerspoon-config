hyper = {"ctrl", "alt", "cmd", "shift"}

hs.hotkey.bind(hyper, "W", function()
  hs.notify.new({title="Hammerspoon", informativeText="Hello World"}):send()
end)

hs.hotkey.bind(hyper, "J", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind(hyper, "L", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind(hyper, "K", function()
  hs.window.focusedWindow():minimize()
end)

hs.hotkey.bind(hyper, "I", function()
  hs.window.focusedWindow():maximize()
end)

hs.hotkey.bind(hyper, "P", function()
  hs.spotify.playpause()
end)

hs.hotkey.bind(hyper, "[", function()
  hs.spotify.previous()
end)

hs.hotkey.bind(hyper, "]", function()
  hs.spotify.next()
end)
-- Config file watcher

hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()