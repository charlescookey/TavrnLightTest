jumpWindow = nil
jumpButton = nil
randButton = nil
callbackevent = nil

local maxWidthMargin 
local maxHeightMargin 

function init()
  jumpWindow = g_ui.displayUI('jump')
  jumpWindow:hide()

  jumpButton = modules.client_topmenu.addRightGameToggleButton('jumpButton', 
    tr('Jump'), '/images/topbuttons/logout', toggle)
  jumpButton:setOn(true)

  randButton = jumpWindow:getChildById('randomizeButton')

  --we set the maximun margins that we can set for the height and width
  maxWidthMargin = jumpWindow:getWidth() - randButton:getWidth() - 30 
  maxHeightMargin = jumpWindow:getHeight() - randButton:getHeight() - 45

  if g_game.isOnline() then
    online()
  end
end

function terminate()
  jumpWindow:destroy()
  jumpButton:destroy()
end


function toggle()
  if jumpButton:isOn() then
    jumpButton:setOn(false)
    jumpWindow:hide()
    callbackevent:cancel()
  else
    jumpButton:setOn(true)
    jumpWindow:show()
    jumpWindow:raise()
    jumpWindow:focus()
    callbackevent = cycleEvent(moveLeft, 70)
  end
end

function online()
  if g_game.getFeature(GameSpellList) then
    jumpButton:show()
  else
    jumpButton:hide()
  end
end
--The idea here is to go to a random height but get it fixed tto the right side
function randomPosition() 
  local randomMargin = math.random(5, maxHeightMargin)

  randButton:setMarginRight(5)
  randButton:setMarginTop(randomMargin)

end
--This is to add a little to the right margin, so it keeps moving left
function moveLeft()
  local currMargin = randButton:getMarginRight()

  if currMargin >= maxWidthMargin then
    randomPosition()
  else
    randButton:setMarginRight(currMargin + 5)
  end
end
