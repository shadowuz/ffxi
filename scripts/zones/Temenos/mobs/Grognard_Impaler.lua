-----------------------------------
-- Area: Temenos
--  Mob: Grognard Impaler
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.CALL_WYVERN, hpp = 100 },
        },
    })

    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
