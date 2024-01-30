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
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  local Height = {
    FULL = max.h,
    HALF = math.floor(max.h / 2),
    OTHER = "other"
  }

  local VerticalLocation = {
    TOP = max.y,
    BOTTOM_HALF =  math.floor(max.y + (max.h / 2)),
    OTHER = "other"
  }

  local PossibleLocations = {
    FULL_AND_TOP = {
      height = Height.FULL,
      y = VerticalLocation.TOP
    },
    HALF_AND_TOP = {
      height = Height.HALF,
      y = VerticalLocation.TOP
    },
    HALF_AND_BOTTOM = {
      height = Height.HALF,
      y = VerticalLocation.BOTTOM_HALF
    },
    OTHER = {
      height = Height.OTHER,
      y = VerticalLocation.OTHER
    }

  }

  local locationFromHeightAndY = function(height, y)
    local intHeight = math.floor(height)
    local intY = math.floor(y)
    for name, location in pairs(PossibleLocations) do
      if (type(location) ~= "function" and location.height == intHeight and location.y == intY) then return location end
    end
    return PossibleLocations.OTHER
  end

  local getNextLocation = function(location)
    if (location == PossibleLocations.FULL_AND_TOP) then return PossibleLocations.HALF_AND_TOP
    elseif (location == PossibleLocations.HALF_AND_TOP) then return PossibleLocations.HALF_AND_BOTTOM
    else return PossibleLocations.FULL_AND_TOP end
  end

  local setLocation = function(desiredLocation)
    print("Value: ", table.unpack(desiredLocation))
    f.h, f.y = desiredLocation.height, desiredLocation.y
    win:setFrame(f)
  end

  local currentLocation = locationFromHeightAndY(f.h, f.y)
  local nextLocation = getNextLocation(currentLocation)
  setLocation(nextLocation)
end)

hs.hotkey.bind(hyper, "I", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.y = max.y
  f.h = max.h

  local full_screen_x = math.floor(max.x)
  local full_screen_w = math.floor(max.w)

  local third_screen_x = math.floor(max.x + (max.w / 3))
  local third_screen_w = math.floor(max.w / 3)

  local two_third_screen_x = math.floor(max.x + (max.w / 6))
  local two_third_screen_w = math.floor(max.w / 3 * 2)

  if (full_screen_x == f.x and full_screen_w == f.w)
  then
  	print("Found full screen; going to third")
  	f.x = third_screen_x
  	f.w = third_screen_w
    win:setFrame(f)
  elseif (third_screen_x == f.x and third_screen_w == f.w)
  then
  	 print("Found third screen; going to two thirds")
  	f.x = two_third_screen_x
  	f.w = two_third_screen_w
    win:setFrame(f)
  else
  	print("Going to full screen")
    print("current x " .. f.x)
    print("full x " .. full_screen_x)
    print("current w " .. f.w)
    print("full w " .. full_screen_w)

    hs.window.focusedWindow():maximize()
  end

  -- win:setFrame(f)
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

toggleVpn = function ()
  hs.osascript.applescriptFromFile("/Users/tburns/src/scripts/toggle-globalprotect.scpt")
end

local running = false
notificationDebouncer = function(callback)
    if running == false then
      running = true
      callback()

      if timeoutInSec ~= nil then
        task.wait(timeoutInSec)
      end
      running = false
    end
end

hs.wifi.watcher.new(function(watcherObj, message, interface)
  local currentNetwork = hs.wifi.currentNetwork(interface)
  if (currentNetwork ~= nil and currentNetwork ~= "HS-Corp")
  then
    print("Connected to network " .. currentNetwork)
    local max = hs.screen.mainScreen():frame()

    local half_screen_x = math.floor(max.x / 2)
    local half_screen_y = math.floor(max.y / 2)

      throttler.run(function()
        hs.dialog.alert(half_screen_x, half_screen_y, function(result)
          if(result == "Yes") then toggleVpn() end
        end, "New Wifi Detected", "New non corp wifi connected. Want to connect to the VPN?", "Yes", "No", "informational")
      end, 0.5)
    end
end):start()
print("---- Loaded VPN network prompter")

newUsbWatcher = function ()
  hs.usb.watcher.new(function(usb)
    hs.notify.new({title="USB device " .. usb.eventType, informativeText=usb.productName .. " " .. usb.eventType}):send()
  end):start()
end

newUsbWatcher()
print("---- Loaded usb watcher")


