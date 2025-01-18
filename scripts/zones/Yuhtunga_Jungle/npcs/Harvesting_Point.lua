-----------------------------------
-- Area: Yuhtunga Jungle
--  NPC: Harvesting Point
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.helm.onTrade(player, npc, trade, xi.helmType.HARVESTING, 206)
end

entity.onTrigger = function(player, npc)
    xi.helm.onTrigger(player, xi.helmType.HARVESTING)
end

return entity
