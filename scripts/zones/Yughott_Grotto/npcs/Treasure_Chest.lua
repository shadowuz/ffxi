-----------------------------------
-- Area: Yughott Grotto
--  NPC: Treasure Chest
-- !zone 142
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.treasure.onTrade(player, npc, trade, xi.treasure.type.CHEST)
end

entity.onTrigger = function(player, npc)
    xi.treasure.onTrigger(player, xi.treasure.type.CHEST)
end

return entity
