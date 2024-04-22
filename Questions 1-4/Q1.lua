--Fixes
-- Use variables instead of hardcoding 
-- add an else case to return false to signify failed logout

local delayTime = 1000 
local storageValue = 1000

local function releaseStorage(player)
	player:setStorageValue(storageValue, -1)
end

function onLogout(player)
	if player:getStorageValue(storageValue) == 1 then
		addEvent(releaseStorage, delayTime, player)
  else
    return false
  end
	return true
end

