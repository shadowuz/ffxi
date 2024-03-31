-----------------------------------
-- Geocrush
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    local dINT   = math.floor(pet:getStat(xi.mod.INT) - target:getStat(xi.mod.INT))
    local tp     = pet:getTP() / 10
    local merits = 0

    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    if summoner ~= nil and summoner:isPC() then
        merits = summoner:getMerit(xi.merit.METEOR_STRIKE)
    end

    tp = tp + (merits - 40)
    if tp > 300 then
        tp = 300
    end

    --note: this formula is only accurate for level 75 - 76+ may have a different intercept and/or slope
    local damage = math.floor(512 + 1.72 * (tp + 1))
    damage = damage + (dINT * 1.5)
    damage = xi.mobskills.mobMagicalMove(pet, target, petskill, damage, xi.element.FIRE, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0)
    damage = xi.mobskills.mobAddBonuses(pet, target, damage.dmg, xi.element.FIRE)
    damage = xi.summon.avatarFinalAdjustments(damage, pet, petskill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, 1)

    target:takeDamage(damage, pet, xi.attackType.MAGICAL, xi.damageType.FIRE)
    target:updateEnmityFromDamage(pet, damage)

    return damage
end

return abilityObject
