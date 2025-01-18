-----------------------------------
-- Area: Davoi
--  Mob: Bilopdop
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addMod(xi.mod.SLEEP_MEVA, 90)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
