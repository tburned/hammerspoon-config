-- Config file watcher

hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

-- Code

hyper = {"ctrl", "alt", "cmd", "shift"}

hs.hotkey.bind(hyper, "W", function()
  hs.notify.new({title="Hammerspoon", informativeText="Hello World"}):send()
end)

hs.hotkey.bind(hyper, "J", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.y = max.y
  f.h = max.h

  local half_screen_x = math.floor(max.x)
  local half_screen_w = math.floor(max.w / 2)

  local third_screen_x = math.floor(max.x)
  local third_screen_w = math.floor(max.w / 3)

  local two_third_screen_x = math.floor(max.x)
  local two_third_screen_w = math.floor(max.w / 3 * 2)

  -- half -> 1/3 -> 2/3 -> half
  if (half_screen_x == f.x and half_screen_w == f.w)
  then
  	print("Found half screen; going to third")
  	f.x = third_screen_x
  	f.w = third_screen_w
  elseif (third_screen_x == f.x and third_screen_w == f.w)
  then
  	 print("Found third screen; going to two thirds")
  	f.x = two_third_screen_x
  	f.w = two_third_screen_w
  else
  	print("Going to half screen")
  	f.x = half_screen_x
  	f.w = half_screen_w
  end

  win:setFrame(f)
end)

hs.hotkey.bind(hyper, "L", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.y = max.y
  f.h = max.h

  local half_screen_x = math.floor(max.x + (max.w / 2))
  local half_screen_w = math.floor(max.w / 2)

  local third_screen_x = math.floor(max.x + (max.w / 3 * 2))
  local third_screen_w = math.floor(max.w / 3)

  local two_third_screen_x = math.floor(max.x + (max.w / 3))
  local two_third_screen_w = math.floor(max.w / 3 * 2)

  if (half_screen_x == f.x and half_screen_w == f.w)
  then
  	print("Found half screen; going to third")
  	f.x = third_screen_x
  	f.w = third_screen_w
  elseif (third_screen_x == f.x and third_screen_w == f.w)
  then
  	 print("Found third screen; going to two thirds")
  	f.x = two_third_screen_x
  	f.w = two_third_screen_w
  else
  	print("Going to half screen")
  	f.x = half_screen_x
  	f.w = half_screen_w
  end

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

newUsbWatcher = function ()
  hs.usb.watcher.new(function(usb)
    hs.notify.new({title="USB device " .. usb.eventType, informativeText=usb.productName .. " " .. usb.eventType}):send()
  end):start()
end

newUsbWatcher()


