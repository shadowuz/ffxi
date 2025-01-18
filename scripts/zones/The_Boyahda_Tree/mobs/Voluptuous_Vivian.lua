-----------------------------------
-- Area: The Boyahda Tree
--   NM: Voluptuous Vivian
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
end

entity.onMobRoam = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
end

entity.onMobFight = function(mob, target)
    local spawnPos = mob:getSpawnPos()
    local drawInTable =
    {
        conditions =
        {
            target:checkDistance(spawnPos.x, spawnPos.y, spawnPos.z) > 25,
        },
        position = mob:getPos(),
        wait = 3,
    }
    if drawInTable.conditions[1] then
        mob:setMobMod(xi.mobMod.NO_MOVE, 1)
        utils.drawIn(target, drawInTable)
    else
        mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.THE_VIVISECTOR)
end

return entity
