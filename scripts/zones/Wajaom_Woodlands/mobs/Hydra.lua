-----------------------------------
-- Area: Wajaom Woodlands
--  Mob: Hydra
-- !pos -282 -24 -1 51
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
    local targetPos = target:getPos()
    local spawnPos = mob:getSpawnPos()

    local drawInPositions =
    {
        { -279.879,    -24,  -1.103, targetPos.rot },
        { -268.899,  -23.5, -11.148, targetPos.rot },
        { -279.844, -23.75, -11.462, targetPos.rot },
        { -268.952, -23.75,  -0.583, targetPos.rot },
    }

    local drawInTable =
    {
        conditions =
        {
            utils.distanceSquared(targetPos, spawnPos) > math.pow(18, 2),
        },
        position = utils.randomEntry(drawInPositions),
        wait = 2,
    }

    for _, condition in ipairs(drawInTable.conditions) do
        if condition then
            mob:setMobMod(xi.mobMod.NO_MOVE, 1)
            utils.drawIn(target, drawInTable)
            break
        else
            mob:setMobMod(xi.mobMod.NO_MOVE, 0)
        end
    end

    local battletime = mob:getBattleTime()
    local headgrow = mob:getLocalVar('headgrow')
    local broken = mob:getAnimationSub()

    if headgrow < battletime and broken > 4 then
        mob:setAnimationSub(broken - 1)
        mob:setLocalVar('headgrow', battletime + 300)
    end
end

entity.onCriticalHit = function(mob)
    local battletime = mob:getBattleTime()
    local headbreak  = mob:getLocalVar('headbreak')
    local broken     = mob:getAnimationSub()

    if math.random(1, 100) <= 15 and battletime >= headbreak and broken < 6 then
        mob:setAnimationSub(broken + 1)
        mob:setLocalVar('headgrow', battletime + math.random(120, 240))
        mob:setLocalVar('headbreak', battletime + 300)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.HYDRA_HEADHUNTER)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(48, 72) * 3600) -- 48 to 72 hours, in 1 hour windows
end

return entity
