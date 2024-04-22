AREA_TEST = {
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0},
	{0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0},
	{0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0},
	{1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0},
	{0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0},
	{0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0},
	{0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2}
}

function spellCallback(cid, position, count)
	if Creature(cid) then
		--if count > 0 or math.random(0, 1) == 1 then
		if count > 0 then
			position:sendMagicEffect(CONST_ME_ICETORNADO)
			--doAreaCombat(cid, COMBAT_ICEDAMAGE, position, 0, -100, -100, CONST_ME_ICETORNADO)
		end

		if count < 3 then
			count = count + 1
			addEvent(spellCallback, math.random(100, 900), cid, position, count)
		end
	end
end

--the idea was to shift the player to theh center of the storm
function onTargetTile(creature, position)
	position.y = position.y - 5
	position.x = position.x - 6
	spellCallback(creature:getId(), position, 0)
end

local combat = Combat()
combat:setArea(createCombatArea(AREA_TEST))
combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")

function onCastSpell(creature, variant, isHotkey)
	return combat:execute(creature, variant)
end

