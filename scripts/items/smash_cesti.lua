-----------------------------------
-- ID: 18747
-- Item: smash_cesti
-- Item Effect: Attack +3
-- Duration: 30 Minutes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.SMASH_CESTI) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.SMASH_CESTI)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.SMASH_CESTI) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 1800, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.SMASH_CESTI)
    end
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.ATT, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ATT, 3)
end

return itemObject
