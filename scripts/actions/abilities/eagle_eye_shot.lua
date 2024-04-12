-----------------------------------
-- Ability: Eagle Eye Shot
-- Delivers a powerful and accurate ranged attack.
-- Obtained: Ranger Level 1
-- Recast Time: 1:00:00
-- Duration: Instant
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    local ranged = player:getStorageItem(0, 0, xi.slot.RANGED)
    local ammo   = player:getStorageItem(0, 0, xi.slot.AMMO)

    if ranged and ranged:isType(xi.itemType.WEAPON) then
        local skilltype = ranged:getSkillType()
        if
            skilltype == xi.skill.ARCHERY or
            skilltype == xi.skill.MARKSMANSHIP or
            skilltype == xi.skill.THROWING
        then
            if
                ammo and
                (
                    ammo:isType(xi.itemType.WEAPON) or
                    skilltype == xi.skill.THROWING
                )
            then
                ability:setRecast(math.max(0, ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST) * 60))
                return 0, 0
            end
        end
    end

    return xi.msg.basic.NO_RANGED_WEAPON, 0
end

abilityObject.onUseAbility = function(player, target, ability, action)
    if player:getWeaponSkillType(xi.slot.RANGED) == xi.skill.MARKSMANSHIP then
        action:setAnimation(target:getID(), action:getAnimation(target:getID()) + 1)
    end

    local params = {}

    params.numHits = 1

    -- TP params.
    local tp          = 1000 -- to ensure ftp multiplier is applied
    params.ftpMod     = { 5.0, 5.0, 5.0 }
    params.critVaries = { 0.0, 0.0, 0.0 }

    -- Stat params.
    params.str_wsc = 0
    params.dex_wsc = 0
    params.vit_wsc = 0
    params.agi_wsc = 0
    params.int_wsc = 0
    params.mnd_wsc = 0
    params.chr_wsc = 0

    params.enmityMult = 0.5

    -- Job Point Bonus Damage
    local jpValue = player:getJobPointLevel(xi.jp.EAGLE_EYE_SHOT_EFFECT)
    player:addMod(xi.mod.ALL_WSDMG_ALL_HITS, jpValue * 3)

    local damage, _, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, 0, params, tp, action, true)

    -- Set the message id ourselves
    if tpHits + extraHits > 0 then
        action:messageID(target:getID(), xi.msg.basic.JA_DAMAGE)
        action:speceffect(target:getID(), 32)
    else
        action:messageID(target:getID(), xi.msg.basic.JA_MISS_2)
        action:speceffect(target:getID(), 0)
    end

    return damage
end

return abilityObject
