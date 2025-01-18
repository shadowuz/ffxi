-----------------------------------
-- Area: Ghelsba Outpost
--  Mob: Colo-colo
-- BCNM: Wings of Fury
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 15)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
