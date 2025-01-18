-----------------------------------
-- Area: The_Garden_of_RuHmet
-----------------------------------
zones = zones or {}

zones[xi.zone.THE_GARDEN_OF_RUHMET] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        TIME_IN_THE_BATTLEFIELD_IS_UP = 7070, -- Your time in the battlefield is up! Now exiting...
        PARTY_MEMBERS_ARE_ENGAGED     = 7085, -- The battlefield where your party members are engaged in combat is locked. Access is denied.
        MEMBERS_OF_YOUR_PARTY         = 7376, -- Currently, # members of your party (including yourself) have clearance to enter the battlefield.
        MEMBERS_OF_YOUR_ALLIANCE      = 7377, -- Currently, # members of your alliance (including yourself) have clearance to enter the battlefield.
        TIME_LIMIT_FOR_THIS_BATTLE_IS = 7379, -- The time limit for this battle is <number> minutes.
        PARTY_MEMBERS_HAVE_FALLEN     = 7415, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7422, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        CONQUEST_BASE                 = 7457, -- Tallying conquest results...
        ENTERING_THE_BATTLEFIELD_FOR  = 7620, -- Entering the battlefield for [When Angels Fall/]!
        YOU_MUST_MOVE_CLOSER          = 7628, -- You must move closer.
        PORTAL_WONT_OPEN_ON_THIS_SIDE = 7630, -- The portal won't open from this side.
        NO_NEED_INVESTIGATE           = 7636, -- There is no need to investigate further.
        PORTAL_SEALED                 = 7665, -- The portal is firmly sealed by a mysterious energy.
        UNKNOWN_PRESENCE              = 7773, -- You sense some unknown presence...
        NONE_HOSTILE                  = 7774, -- You sense some unknown presence, but it does not seem hostile.
        MENACING_CREATURES            = 7775, -- Menacing creatures appear out of nowhere!
        SHEER_ANIMOSITY               = 7776, -- <name> is enveloped in sheer animosity!
        HOMEPOINT_SET                 = 7781, -- Home point set!
    },

    mob =
    {
        AWAERN_DRG_GROUPS = -- First Aw'Aerns in each group. Used to randomize the mobID as the new placeholder.
        {
            16920777,
            16920781,
            16920785,
            16920789,
        },

        AWAERN_DRK_GROUPS =
        {
            16920646, -- SW
            16920651, -- NW
            16920660, -- NE
            16920665, -- SE
        },

        JAILER_OF_FORTITUDE = GetFirstID('Jailer_of_Fortitude'),
        KFGHRAH_WHM         = GetFirstID('Kfghrah_WHM'),
        KFGHRAH_BLM         = GetFirstID('Kfghrah_BLM'),
        IXAERN_DRK          = GetFirstID('Ixaern_DRK'),
        IXZDEI_RDM          = GetFirstID('Ixzdei_RDM'),
        JAILER_OF_FAITH     = GetFirstID('Jailer_of_Faith'),
        IXAERN_DRG          = GetFirstID('Ixaern_DRG'),
        IXZDEI_BASE         = GetFirstID('Ixzdei_RDM'),
        QNZDEI_OFFSET       = GetFirstID('Qnzdei'),
    },

    npc =
    {
        QM_JAILER_OF_FORTITUDE = GetFirstID('qm_jailer_of_fortitude'),
        QM_IXAERN_DRK          = GetFirstID('qm_ixaern_drk'),
        QM_JAILER_OF_FAITH     = GetFirstID('qm_jailer_of_faith'),
        QNZDEI_DOOR_OFFSET     = GetFirstID('_0zw'),
    },
}

return zones[xi.zone.THE_GARDEN_OF_RUHMET]
