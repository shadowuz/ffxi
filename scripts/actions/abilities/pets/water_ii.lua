-----------------------------------
-- Aero 2
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill)
    local dINT = math.floor(pet:getStat(xi.mod.INT) - target:getStat(xi.mod.INT))
    local tp   = pet:getTP()

    xi.job_utils.summoner.onUseBloodPact(pet:getMaster(), pet, target, petskill)

    local damage = math.floor(45 + 0.025 * tp)
    damage = damage + (dINT * 1.5)
    damage = xi.mobskills.mobMagicalMove(pet, target, petskill, damage, xi.element.WATER, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0)
    damage = xi.mobskills.mobAddBonuses(pet, target, damage.dmg, xi.element.WATER)
    damage = xi.summon.avatarFinalAdjustments(damage, pet, petskill, target, xi.attackType.MAGICAL, xi.damageType.WATER, 1)

    target:takeDamage(damage, pet, xi.attackType.MAGICAL, xi.damageType.WATER)
    target:updateEnmityFromDamage(pet, damage)

    return damage
end

return abilityObject
