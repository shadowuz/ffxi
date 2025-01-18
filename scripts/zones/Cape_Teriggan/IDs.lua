-----------------------------------
-- Area: Cape_Teriggan
-----------------------------------
zones = zones or {}

zones[xi.zone.CAPE_TERIGGAN] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6384,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6388,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6390,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6391,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6394,  -- Lost key item: <keyitem>.
        ITEMS_OBTAINED                = 6399,  -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY       = 6404,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6419,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7001,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7065,  -- Tallying conquest results...
        BEASTMEN_BANNER               = 7146,  -- There is a beastmen's banner.
        CONQUEST                      = 7233,  -- You've earned conquest points!
        FISHING_MESSAGE_OFFSET        = 7566,  -- You can't fish here.
        SOMETHING_BETTER              = 7678,  -- Don't you have something better to do right now?
        CANNOT_REMOVE_FRAG            = 7681,  -- It is an oddly shaped stone monument. A shining stone is embedded in it, but cannot be removed...
        ALREADY_OBTAINED_FRAG         = 7682,  -- You have already obtained this monument's <keyitem>. Try searching for another.
        FOUND_ALL_FRAGS               = 7683,  -- You have obtained all of the fragments. You must hurry to the ruins of the ancient shrine!
        ZILART_MONUMENT               = 7685,  -- It is an ancient Zilart monument.
        MUST_BE_A_WAY_TO_SOOTHE       = 7693,  -- There must be a way to soothe the weary soul who once guarded this monument...
        COLD_WIND_CHILLS_YOU          = 7700,  -- A cold wind chills you to the bone.
        SENSE_OMINOUS_PRESENCE        = 7702,  -- You sense an ominous presence...
        GARRISON_BASE                 = 7889,  -- Hm? What is this? %? How do I know this is not some [San d'Orian/Bastokan/Windurstian] trick?
        PLAYER_OBTAINS_ITEM           = 7936,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7937,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7938,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7939,  -- You already possess that temporary item.
        NO_COMBINATION                = 7944,  -- You were unable to enter a combination.
        UNITY_WANTED_BATTLE_INTERACT  = 8006,  -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        REGIME_REGISTERED             = 10122, -- New training regime registered!
        COMMON_SENSE_SURVIVAL         = 11241, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        HOMEPOINT_SET                 = 11269, -- Home point set!
    },
    mob =
    {
        FROSTMANE              = GetFirstID('Frostmane'),
        KREUTZET               = GetFirstID('Kreutzet'),
        AXESARION_THE_WANDERER = GetFirstID('Axesarion_the_Wanderer'),
        STOLAS                 = GetFirstID('Stolas'),
        ZMEY_GORYNYCH          = GetFirstID('Zmey_Gorynych')
    },
    npc =
    {
        OVERSEER_BASE    = GetFirstID('Salimardi_RK'),
        CERMET_HEADSTONE = 17240498,
    },
}

return zones[xi.zone.CAPE_TERIGGAN]
