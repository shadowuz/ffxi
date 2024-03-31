-----------------------------------
-- Stone 4
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    local dINT   = math.floor(pet:getStat(xi.mod.INT) - target:getStat(xi.mod.INT))
    local tp     = pet:getTP()
    local damage = math.floor(325 + 0.025 * tp)

    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    damage = damage + (dINT * 1.5)
    damage = xi.mobskills.mobMagicalMove(pet, target, petskill, damage, xi.element.EARTH, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0)
    damage = xi.mobskills.mobAddBonuses(pet, target, damage.dmg, xi.element.EARTH)
    damage = xi.summon.avatarFinalAdjustments(damage, pet, petskill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, 1)

    target:takeDamage(damage, pet, xi.attackType.MAGICAL, xi.damageType.EARTH)
    target:updateEnmityFromDamage(pet, damage)

    return damage
end

return abilityObject
