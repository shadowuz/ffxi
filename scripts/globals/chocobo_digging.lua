-----------------------------------
-- Chocobo Digging
-- http://ffxiclopedia.wikia.com/wiki/Chocobo_Digging
-- https://www.bg-wiki.com/bg/Category:Chocobo_Digging
-----------------------------------
require('scripts/globals/roe')
require('scripts/globals/utils')
require('scripts/missions/amk/helpers')
-----------------------------------
xi = xi or {}
xi.chocoboDig = xi.chocoboDig or {}

-- This contais all digging zones with the ones without loot tables defined commented out.
local diggingZoneList =
set{
    xi.zone.CARPENTERS_LANDING,
    xi.zone.BIBIKI_BAY,
    -- xi.zone.ULEGUERAND_RANGE,
    -- xi.zone.ATTOHWA_CHASM,
    -- xi.zone.LUFAISE_MEADOWS,
    -- xi.zone.MISAREAUX_COAST,
    xi.zone.WAJAOM_WOODLANDS,
    xi.zone.BHAFLAU_THICKETS,
    -- xi.zone.CAEDARVA_MIRE,
    -- xi.zone.EAST_RONFAURE_S,
    -- xi.zone.JUGNER_FOREST_S,
    -- xi.zone.VUNKERL_INLET_S,
    -- xi.zone.BATALLIA_DOWNS_S,
    -- xi.zone.NORTH_GUSTABERG_S,
    -- xi.zone.GRAUBERG_S,
    -- xi.zone.PASHHOW_MARSHLANDS_S,
    -- xi.zone.ROLANBERRY_FIELDS_S,
    -- xi.zone.WEST_SARUTABARUTA_S,
    -- xi.zone.FORT_KARUGO_NARUGO_S,
    -- xi.zone.MERIPHATAUD_MOUNTAINS_S,
    -- xi.zone.SAUROMUGUE_CHAMPAIGN_S,
    xi.zone.WEST_RONFAURE,
    xi.zone.EAST_RONFAURE,
    xi.zone.LA_THEINE_PLATEAU,
    xi.zone.VALKURM_DUNES,
    xi.zone.JUGNER_FOREST,
    xi.zone.BATALLIA_DOWNS,
    xi.zone.NORTH_GUSTABERG,
    xi.zone.SOUTH_GUSTABERG,
    xi.zone.KONSCHTAT_HIGHLANDS,
    xi.zone.PASHHOW_MARSHLANDS,
    xi.zone.ROLANBERRY_FIELDS,
    -- xi.zone.BEAUCEDINE_GLACIER,
    -- xi.zone.XARCABARD,
    -- xi.zone.CAPE_TERIGGAN,
    xi.zone.EASTERN_ALTEPA_DESERT,
    xi.zone.WEST_SARUTABARUTA,
    xi.zone.EAST_SARUTABARUTA,
    xi.zone.TAHRONGI_CANYON,
    xi.zone.BUBURIMU_PENINSULA,
    xi.zone.MERIPHATAUD_MOUNTAINS,
    xi.zone.SAUROMUGUE_CHAMPAIGN,
    xi.zone.THE_SANCTUARY_OF_ZITAH,
    xi.zone.YUHTUNGA_JUNGLE,
    xi.zone.YHOATOR_JUNGLE,
    xi.zone.WESTERN_ALTEPA_DESERT,
    -- xi.zone.QUFIM_ISLAND,
    -- xi.zone.BEHEMOTHS_DOMINION,
    -- xi.zone.VALLEY_OF_SORROWS,
    -- xi.zone.BEAUCEDINE_GLACIER_S,
    -- xi.zone.XARCABARD_S,
    -- xi.zone.YAHSE_HUNTING_GROUNDS,
    -- xi.zone.CEIZAK_BATTLEGROUNDS,
    -- xi.zone.FORET_DE_HENNETIEL,
    -- xi.zone.YORCIA_WEALD,
    -- xi.zone.MORIMAR_BASALT_FIELDS,
    -- xi.zone.MARJAMI_RAVINE,
    -- xi.zone.KAMIHR_DRIFTS,
}

local elementalOreZoneTable =
set{
    xi.zone.LA_THEINE_PLATEAU,
    xi.zone.JUGNER_FOREST,
    xi.zone.BATALLIA_DOWNS,
    xi.zone.KONSCHTAT_HIGHLANDS,
    xi.zone.PASHHOW_MARSHLANDS,
    xi.zone.ROLANBERRY_FIELDS,
    xi.zone.TAHRONGI_CANYON,
    xi.zone.MERIPHATAUD_MOUNTAINS,
    xi.zone.SAUROMUGUE_CHAMPAIGN,
}

local diggingWeatherTable =
{
    -- Single weather by elemental order.
    [xi.weather.HOT_SPELL    ] = { xi.item.FIRE_CRYSTAL      },
    [xi.weather.SNOW         ] = { xi.item.ICE_CRYSTAL       },
    [xi.weather.WIND         ] = { xi.item.WIND_CRYSTAL      },
    [xi.weather.DUST_STORM   ] = { xi.item.EARTH_CRYSTAL     },
    [xi.weather.THUNDER      ] = { xi.item.LIGHTNING_CRYSTAL },
    [xi.weather.RAIN         ] = { xi.item.WATER_CRYSTAL     },
    [xi.weather.AURORAS      ] = { xi.item.LIGHT_CRYSTAL     },
    [xi.weather.GLOOM        ] = { xi.item.DARK_CRYSTAL      },

    -- Double weather by elemental order.
    [xi.weather.HEAT_WAVE    ] = { xi.item.FIRE_CLUSTER      },
    [xi.weather.BLIZZARDS    ] = { xi.item.ICE_CLUSTER       },
    [xi.weather.GALES        ] = { xi.item.WIND_CLUSTER      },
    [xi.weather.SAND_STORM   ] = { xi.item.EARTH_CLUSTER     },
    [xi.weather.THUNDERSTORMS] = { xi.item.LIGHTNING_CLUSTER },
    [xi.weather.SQUALL       ] = { xi.item.WATER_CLUSTER     },
    [xi.weather.STELLAR_GLARE] = { xi.item.LIGHT_CLUSTER     },
    [xi.weather.DARKNESS     ] = { xi.item.DARK_CLUSTER      },
}

local diggingDayTable =
{
    [xi.day.FIRESDAY    ] = { xi.item.RED_ROCK,         xi.item.CHUNK_OF_FIRE_ORE      },
    [xi.day.ICEDAY      ] = { xi.item.TRANSLUCENT_ROCK, xi.item.CHUNK_OF_ICE_ORE       },
    [xi.day.WINDSDAY    ] = { xi.item.GREEN_ROCK,       xi.item.CHUNK_OF_WIND_ORE      },
    [xi.day.EARTHSDAY   ] = { xi.item.YELLOW_ROCK,      xi.item.CHUNK_OF_EARTH_ORE     },
    [xi.day.LIGHTNINGDAY] = { xi.item.PURPLE_ROCK,      xi.item.CHUNK_OF_LIGHTNING_ORE },
    [xi.day.WATERSDAY   ] = { xi.item.BLUE_ROCK,        xi.item.CHUNK_OF_WATER_ORE     },
    [xi.day.LIGHTSDAY   ] = { xi.item.WHITE_ROCK,       xi.item.CHUNK_OF_LIGHT_ORE     },
    [xi.day.DARKSDAY    ] = { xi.item.BLACK_ROCK,       xi.item.CHUNK_OF_DARK_ORE      },
}

-----------------------------------
-- Table for common items without special conditions. [Zone ID] = { itemId, weight, dig requirement }
-- Data from BG wiki: https://www.bg-wiki.com/ffxi/Category:Chocobo_Digging
-----------------------------------
local diggingLayer =
{
    TREASURE = 1, -- This layer takes precedence over all others AND no other layer will trigger if we manage to dig something from it.
    REGULAR  = 2, -- Regular layers. Crystals from weather and ores are applied here.
    BURROW   = 3, -- Special "Raised chocobo only" layer. Requires the mounted chocobo to have a concrete skill. It's an independent AND additional item dig.
    BORE     = 4, -- Special "Raised chocobo only" layer. Requires the mounted chocobo to have a concrete skill. It's an independent AND additional item dig.
}

local digInfo =
{
    [xi.zone.CARPENTERS_LANDING] = -- 2
    {
        [diggingLayer.TREASURE] =
        {
            [1] = { xi.item.KING_TRUFFLE, 5, xi.craftRank.ADEPT },
        },
        [diggingLayer.REGULAR] =
        {
            [1] = { xi.item.LITTLE_WORM,        100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.ARROWWOOD_LOG,      100, xi.craftRank.AMATEUR    },
            [3] = { xi.item.ACORN,               50, xi.craftRank.RECRUIT    },
            [4] = { xi.item.WILLOW_LOG,          50, xi.craftRank.RECRUIT    },
            [5] = { xi.item.MAPLE_LOG,           50, xi.craftRank.INITIATE   },
            [6] = { xi.item.HOLLY_LOG,           50, xi.craftRank.INITIATE   },
            [7] = { xi.item.SPRIG_OF_MISTLETOE,  10, xi.craftRank.JOURNEYMAN },
            [8] = { xi.item.SCREAM_FUNGUS,       10, xi.craftRank.CRAFTSMAN  },
        },
        [diggingLayer.BURROW] = -- Set: Crystals
        {
            [1] = { xi.item.FIRE_CRYSTAL,      50, xi.craftRank.AMATEUR },
            [2] = { xi.item.ICE_CRYSTAL,       50, xi.craftRank.AMATEUR },
            [3] = { xi.item.WIND_CRYSTAL,      50, xi.craftRank.AMATEUR },
            [4] = { xi.item.EARTH_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [5] = { xi.item.LIGHTNING_CRYSTAL, 50, xi.craftRank.AMATEUR },
            [6] = { xi.item.WATER_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [7] = { xi.item.LIGHT_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [8] = { xi.item.DARK_CRYSTAL,      50, xi.craftRank.AMATEUR },
        },
        [diggingLayer.BORE] = -- Set: Logs 1
        {
            [1] = { xi.item.ARROWWOOD_LOG,           240, xi.craftRank.AMATEUR    },
            [2] = { xi.item.YEW_LOG,                 150, xi.craftRank.AMATEUR    },
            [3] = { xi.item.ELM_LOG,                 100, xi.craftRank.RECRUIT    },
            [4] = { xi.item.OAK_LOG,                  50, xi.craftRank.INITIATE   },
            [5] = { xi.item.ROSEWOOD_LOG,             10, xi.craftRank.NOVICE     },
            [6] = { xi.item.MAHOGANY_LOG,              5, xi.craftRank.APPRENTICE },
            [7] = { xi.item.EBONY_LOG,                 5, xi.craftRank.JOURNEYMAN },
            [8] = { xi.item.PIECE_OF_ANCIENT_LUMBER,   1, xi.craftRank.CRAFTSMAN  },
            [9] = { xi.item.LACQUER_TREE_LOG,          1, xi.craftRank.ARTISAN    },
        },
    },

    [xi.zone.BIBIKI_BAY] = -- 4
    {
        [diggingLayer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
            [2] = { xi.item.COIN_OF_BIRTH,        5, xi.craftRank.ADEPT },
        },
        [diggingLayer.REGULAR] =
        {
            [1] = { xi.item.CHUNK_OF_TIN_ORE,       50, xi.craftRank.AMATEUR  },
            [2] = { xi.item.LUGWORM,                50, xi.craftRank.AMATEUR  },
            [3] = { xi.item.SHELL_BUG,              10, xi.craftRank.RECRUIT  },
            [4] = { xi.item.SEASHELL,              100, xi.craftRank.RECRUIT  },
            [5] = { xi.item.SHALL_SHELL,            50, xi.craftRank.INITIATE },
            [6] = { xi.item.BIRD_FEATHER,           50, xi.craftRank.INITIATE },
            [7] = { xi.item.GIANT_FEMUR,            50, xi.craftRank.INITIATE },
            [8] = { xi.item.CHUNK_OF_PLATINUM_ORE,   5, xi.craftRank.ARTISAN  },
            [9] = { xi.item.CORAL_FRAGMENT,          5, xi.craftRank.ARTISAN  },
        },
        [diggingLayer.BURROW] = -- Set: Feathers
        {
            [1] = { xi.item.CLUMP_OF_RED_MOKO_GRASS, 100, xi.craftRank.AMATEUR   },
            [2] = { xi.item.BLACK_CHOCOBO_FEATHER,    50, xi.craftRank.RECRUIT   },
            [4] = { xi.item.GIANT_BIRD_PLUME,         10, xi.craftRank.INITIATE  },
            [3] = { xi.item.SPIDER_WEB,                5, xi.craftRank.NOVICE    },
            [5] = { xi.item.PHOENIX_FEATHER,           1, xi.craftRank.CRAFTSMAN },
        },
        [diggingLayer.BORE] = -- Set: Bones
        {
            [ 1] = { xi.item.BONE_CHIP,                150, xi.craftRank.AMATEUR    },
            [ 2] = { xi.item.HANDFUL_OF_FISH_SCALES,   150, xi.craftRank.AMATEUR    },
            [ 3] = { xi.item.SEASHELL,                 150, xi.craftRank.RECRUIT    },
            [ 4] = { xi.item.HIGH_QUALITY_PUGIL_SCALE,  50, xi.craftRank.INITIATE   },
            [ 5] = { xi.item.TITANICTUS_SHELL,          50, xi.craftRank.APPRENTICE },
            [ 6] = { xi.item.DEMON_HORN,                10, xi.craftRank.JOURNEYMAN },
            [ 7] = { xi.item.HANDFUL_OF_WYVERN_SCALES,   5, xi.craftRank.CRAFTSMAN  },
            [ 8] = { xi.item.TURTLE_SHELL,               5, xi.craftRank.CRAFTSMAN  },
            [ 9] = { xi.item.DEMON_SKULL,                1, xi.craftRank.ARTISAN    },
            [10] = { xi.item.HANDFUL_OF_DRAGON_SCALES,   1, xi.craftRank.ARTISAN    },
        },
    },

    [xi.zone.ULEGUERAND_RANGE] = -- 5
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries.
        },
        [diggingLayer.REGULAR] =
        {
            -- No entries.
        },
        [diggingLayer.BURROW] = -- Set: Ores 4
        {
            [1] = { xi.item.CHUNK_OF_SILVER_ORE,       100, xi.craftRank.AMATEUR },
            [2] = { xi.item.CHUNK_OF_IRON_ORE,         100, xi.craftRank.RECRUIT },
            [3] = { xi.item.CHUNK_OF_KOPPARNICKEL_ORE, 100, xi.craftRank.RECRUIT },
            [4] = { xi.item.CHUNK_OF_MYTHRIL_ORE,      100, xi.craftRank.RECRUIT },
            [5] = { xi.item.CHUNK_OF_DARKSTEEL_ORE,     10, xi.craftRank.NOVICE  },
        },
        [diggingLayer.BORE] = -- Set: Beastcoins
        {
            [1] = { xi.item.BEASTCOIN,          100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.SILVER_BEASTCOIN,    50, xi.craftRank.RECRUIT    },
            [3] = { xi.item.GOLD_BEASTCOIN,      10, xi.craftRank.INITIATE   },
            [4] = { xi.item.MYTHRIL_BEASTCOIN,    5, xi.craftRank.NOVICE     },
            [5] = { xi.item.PLATINUM_BEASTCOIN,   1, xi.craftRank.APPRENTICE },
        },
    },

    [xi.zone.ATTOHWA_CHASM] = -- 7
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries.
        },
        [diggingLayer.REGULAR] =
        {
            -- No entries.
        },
        [diggingLayer.BURROW] = -- Set: Yellow Ginseng seeds
        {
            [1] = { xi.item.PIECE_OF_YELLOW_GINSENG, 150, xi.craftRank.AMATEUR  },
            [2] = { xi.item.BAG_OF_WILDGRASS_SEEDS,   50, xi.craftRank.RECRUIT  },
            [3] = { xi.item.BAG_OF_TREE_CUTTINGS,     10, xi.craftRank.INITIATE },
            [4] = { xi.item.BAG_OF_CACTUS_STEMS,       5, xi.craftRank.NOVICE   },
        },
        [diggingLayer.BORE] = -- Set: Ores 4
        {
            [1] = { xi.item.CHUNK_OF_SILVER_ORE,       100, xi.craftRank.AMATEUR },
            [2] = { xi.item.CHUNK_OF_IRON_ORE,         100, xi.craftRank.RECRUIT },
            [3] = { xi.item.CHUNK_OF_KOPPARNICKEL_ORE, 100, xi.craftRank.RECRUIT },
            [4] = { xi.item.CHUNK_OF_MYTHRIL_ORE,      100, xi.craftRank.RECRUIT },
            [5] = { xi.item.CHUNK_OF_DARKSTEEL_ORE,     10, xi.craftRank.NOVICE  },
        },
    },

    [xi.zone.LUFAISE_MEADOWS] = -- 24
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries.
        },
        [diggingLayer.REGULAR] =
        {
            -- No entries.
        },
        [diggingLayer.BURROW] =
        {
            -- No entries.
        },
        [diggingLayer.BORE] = -- Set: Crystals
        {
            [1] = { xi.item.FIRE_CRYSTAL,      50, xi.craftRank.AMATEUR },
            [2] = { xi.item.ICE_CRYSTAL,       50, xi.craftRank.AMATEUR },
            [3] = { xi.item.WIND_CRYSTAL,      50, xi.craftRank.AMATEUR },
            [4] = { xi.item.EARTH_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [5] = { xi.item.LIGHTNING_CRYSTAL, 50, xi.craftRank.AMATEUR },
            [6] = { xi.item.WATER_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [7] = { xi.item.LIGHT_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [8] = { xi.item.DARK_CRYSTAL,      50, xi.craftRank.AMATEUR },
        },
    },

    [xi.zone.MISAREAUX_COAST] = -- 25
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries.
        },
        [diggingLayer.REGULAR] =
        {
            -- No entries.
        },
        [diggingLayer.BURROW] = -- Set: Logs 1
        {
            [1] = { xi.item.ARROWWOOD_LOG,           240, xi.craftRank.AMATEUR    },
            [2] = { xi.item.YEW_LOG,                 150, xi.craftRank.AMATEUR    },
            [3] = { xi.item.ELM_LOG,                 100, xi.craftRank.RECRUIT    },
            [4] = { xi.item.OAK_LOG,                  50, xi.craftRank.INITIATE   },
            [5] = { xi.item.ROSEWOOD_LOG,             10, xi.craftRank.NOVICE     },
            [6] = { xi.item.MAHOGANY_LOG,              5, xi.craftRank.APPRENTICE },
            [7] = { xi.item.EBONY_LOG,                 5, xi.craftRank.JOURNEYMAN },
            [8] = { xi.item.PIECE_OF_ANCIENT_LUMBER,   1, xi.craftRank.CRAFTSMAN  },
            [9] = { xi.item.LACQUER_TREE_LOG,          1, xi.craftRank.ARTISAN    },
        },
        [diggingLayer.BORE] =
        {
            -- No entries.
        },
    },

    [xi.zone.WAJAOM_WOODLANDS] = -- 51
    {
        [diggingLayer.TREASURE] =
        {
            [1] = { xi.item.ALEXANDRITE, 5, xi.craftRank.ADEPT },
        },
        [diggingLayer.REGULAR] =
        {
            [1] = { xi.item.PEBBLE,                100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.CLUMP_OF_MOKO_GRASS,   100, xi.craftRank.AMATEUR    },
            [3] = { xi.item.HANDFUL_OF_PINE_NUTS,   50, xi.craftRank.RECRUIT    },
            [4] = { xi.item.BLACK_CHOCOBO_FEATHER,  50, xi.craftRank.RECRUIT    },
            [5] = { xi.item.EBONY_LOG,              50, xi.craftRank.INITIATE   },
            [6] = { xi.item.SPIDER_WEB,             10, xi.craftRank.NOVICE     },
            [7] = { xi.item.PEPHREDO_HIVE_CHIP,     10, xi.craftRank.APPRENTICE },
            [8] = { xi.item.CHUNK_OF_ADAMAN_ORE,    10, xi.craftRank.CRAFTSMAN  },
        },
        [diggingLayer.BURROW] = -- Set: Logs 2
        {
            [ 1] = { xi.item.CLUMP_OF_MOKO_GRASS,     240, xi.craftRank.AMATEUR    },
            [ 2] = { xi.item.ARROWWOOD_LOG,           240, xi.craftRank.AMATEUR    },
            [ 3] = { xi.item.PEPHREDO_HIVE_CHIP,      150, xi.craftRank.AMATEUR    },
            [ 4] = { xi.item.YEW_LOG,                 150, xi.craftRank.AMATEUR    },
            [ 5] = { xi.item.BLACK_CHOCOBO_FEATHER,   100, xi.craftRank.RECRUIT    },
            [ 6] = { xi.item.ELM_LOG,                 100, xi.craftRank.RECRUIT    },
            [ 7] = { xi.item.OAK_LOG,                  50, xi.craftRank.INITIATE   },
            [ 8] = { xi.item.ROSEWOOD_LOG,             10, xi.craftRank.NOVICE     },
            [ 9] = { xi.item.MAHOGANY_LOG,              5, xi.craftRank.APPRENTICE },
            [10] = { xi.item.EBONY_LOG,                 5, xi.craftRank.JOURNEYMAN },
            [11] = { xi.item.PIECE_OF_ANCIENT_LUMBER,   1, xi.craftRank.CRAFTSMAN  },
            [12] = { xi.item.LACQUER_TREE_LOG,          1, xi.craftRank.ARTISAN    },
        },
        [diggingLayer.BORE] = -- Set: Ores 2
        {
            [1] = { xi.item.FLINT_STONE,             240, xi.craftRank.AMATEUR    },
            [2] = { xi.item.CHUNK_OF_ALUMINUM_ORE,   100, xi.craftRank.RECRUIT    },
            [3] = { xi.item.CHUNK_OF_GOLD_ORE,        50, xi.craftRank.INITIATE   },
            [4] = { xi.item.CHUNK_OF_DARKSTEEL_ORE,   10, xi.craftRank.NOVICE     },
            [5] = { xi.item.CHUNK_OF_KAOLIN,          10, xi.craftRank.NOVICE     },
            [6] = { xi.item.CHUNK_OF_PLATINUM_ORE,     5, xi.craftRank.JOURNEYMAN },
            [7] = { xi.item.CHUNK_OF_ORICHALCUM_ORE,   1, xi.craftRank.CRAFTSMAN  },
        },
    },

    [xi.zone.BHAFLAU_THICKETS] = -- 52
    {
        [diggingLayer.TREASURE] =
        {
            [1] = { xi.item.ALEXANDRITE, 5, xi.craftRank.ADEPT },
        },
        [diggingLayer.REGULAR] =
        {
            [1] = { xi.item.PEBBLE,                  100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.FLINT_STONE,             100, xi.craftRank.AMATEUR    },
            [3] = { xi.item.HANDFUL_OF_PINE_NUTS,     50, xi.craftRank.AMATEUR    },
            [4] = { xi.item.PINCH_OF_DRIED_MARJORAM,  50, xi.craftRank.AMATEUR    },
            [6] = { xi.item.COLIBRI_FEATHER,          50, xi.craftRank.RECRUIT    },
            [5] = { xi.item.LESSER_CHIGOE,            10, xi.craftRank.INITIATE   },
            [8] = { xi.item.PETRIFIED_LOG,            50, xi.craftRank.NOVICE     },
            [7] = { xi.item.SPIDER_WEB,               10, xi.craftRank.APPRENTICE },
            [9] = { xi.item.CHUNK_OF_ORICHALCUM_ORE,   5, xi.craftRank.ARTISAN    },
        },
        [diggingLayer.BURROW] = -- Set: Logs 2
        {
            [ 1] = { xi.item.CLUMP_OF_MOKO_GRASS,     240, xi.craftRank.AMATEUR    },
            [ 2] = { xi.item.ARROWWOOD_LOG,           240, xi.craftRank.AMATEUR    },
            [ 3] = { xi.item.PEPHREDO_HIVE_CHIP,      150, xi.craftRank.AMATEUR    },
            [ 4] = { xi.item.YEW_LOG,                 150, xi.craftRank.AMATEUR    },
            [ 5] = { xi.item.BLACK_CHOCOBO_FEATHER,   100, xi.craftRank.RECRUIT    },
            [ 6] = { xi.item.ELM_LOG,                 100, xi.craftRank.RECRUIT    },
            [ 7] = { xi.item.OAK_LOG,                  50, xi.craftRank.INITIATE   },
            [ 8] = { xi.item.ROSEWOOD_LOG,             10, xi.craftRank.NOVICE     },
            [ 9] = { xi.item.MAHOGANY_LOG,              5, xi.craftRank.APPRENTICE },
            [10] = { xi.item.EBONY_LOG,                 5, xi.craftRank.JOURNEYMAN },
            [11] = { xi.item.PIECE_OF_ANCIENT_LUMBER,   1, xi.craftRank.CRAFTSMAN  },
            [12] = { xi.item.LACQUER_TREE_LOG,          1, xi.craftRank.ARTISAN    },
        },
        [diggingLayer.BORE] = -- Set: Ores 2
        {
            [1] = { xi.item.FLINT_STONE,             240, xi.craftRank.AMATEUR    },
            [2] = { xi.item.CHUNK_OF_ALUMINUM_ORE,   100, xi.craftRank.RECRUIT    },
            [3] = { xi.item.CHUNK_OF_GOLD_ORE,        50, xi.craftRank.INITIATE   },
            [4] = { xi.item.CHUNK_OF_DARKSTEEL_ORE,   10, xi.craftRank.NOVICE     },
            [5] = { xi.item.CHUNK_OF_KAOLIN,          10, xi.craftRank.NOVICE     },
            [6] = { xi.item.CHUNK_OF_PLATINUM_ORE,     5, xi.craftRank.JOURNEYMAN },
            [7] = { xi.item.CHUNK_OF_ORICHALCUM_ORE,   1, xi.craftRank.CRAFTSMAN  },
        },
    },

    [xi.zone.CAEDARVA_MIRE] = -- 79
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries.
        },
        [diggingLayer.REGULAR] =
        {
            -- No entries.
        },
        [diggingLayer.BURROW] = -- Set: Logs 3
        {
            [1] = { xi.item.ARROWWOOD_LOG,           240, xi.craftRank.AMATEUR    },
            [2] = { xi.item.DOGWOOD_LOG,             240, xi.craftRank.AMATEUR    },
            [3] = { xi.item.YEW_LOG,                 150, xi.craftRank.AMATEUR    },
            [4] = { xi.item.LANCEWOOD_LOG,           100, xi.craftRank.RECRUIT    },
            [5] = { xi.item.SPRIG_OF_MISTLETOE,       50, xi.craftRank.INITIATE   },
            [6] = { xi.item.ROSEWOOD_LOG,             10, xi.craftRank.NOVICE     },
            [7] = { xi.item.EBONY_LOG,                 5, xi.craftRank.JOURNEYMAN },
            [8] = { xi.item.PIECE_OF_ANCIENT_LUMBER,   1, xi.craftRank.CRAFTSMAN  },
        },
        [diggingLayer.BORE] = -- Set: Ores 2
        {
            [1] = { xi.item.FLINT_STONE,             240, xi.craftRank.AMATEUR    },
            [2] = { xi.item.CHUNK_OF_ALUMINUM_ORE,   100, xi.craftRank.RECRUIT    },
            [3] = { xi.item.CHUNK_OF_GOLD_ORE,        50, xi.craftRank.INITIATE   },
            [4] = { xi.item.CHUNK_OF_DARKSTEEL_ORE,   10, xi.craftRank.NOVICE     },
            [5] = { xi.item.CHUNK_OF_KAOLIN,          10, xi.craftRank.NOVICE     },
            [6] = { xi.item.CHUNK_OF_PLATINUM_ORE,     5, xi.craftRank.JOURNEYMAN },
            [7] = { xi.item.CHUNK_OF_ORICHALCUM_ORE,   1, xi.craftRank.CRAFTSMAN  },
        },
    },

    [xi.zone.EAST_RONFAURE_S] = -- 81
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries.
        },
        [diggingLayer.REGULAR] =
        {
            -- No entries.
        },
        [diggingLayer.BURROW] = -- Set: Gysahl Greens
        {
            [1] = { xi.item.BUNCH_OF_GYSAHL_GREENS, 150, xi.craftRank.AMATEUR  },
            [2] = { xi.item.CHAMOMILE,               50, xi.craftRank.AMATEUR  },
            [3] = { xi.item.GINGER_ROOT,             50, xi.craftRank.RECRUIT  },
            [4] = { xi.item.HEAD_OF_NAPA,            50, xi.craftRank.INITIATE },
        },
        [diggingLayer.BORE] = -- Set: Logs 4
        {
            [1] = { xi.item.ARROWWOOD_LOG,           240, xi.craftRank.AMATEUR   },
            [2] = { xi.item.YEW_LOG,                 150, xi.craftRank.AMATEUR   },
            [3] = { xi.item.ELM_LOG,                 100, xi.craftRank.RECRUIT   },
            [4] = { xi.item.FEYWEALD_LOG,             50, xi.craftRank.INITIATE  },
            [5] = { xi.item.OAK_LOG,                  50, xi.craftRank.INITIATE  },
            [6] = { xi.item.TEAK_LOG,                  1, xi.craftRank.CRAFTSMAN },
            [7] = { xi.item.PIECE_OF_ANCIENT_LUMBER,   1, xi.craftRank.CRAFTSMAN },
            [8] = { xi.item.JACARANDA_LOG,             1, xi.craftRank.ARTISAN   },
            [9] = { xi.item.LACQUER_TREE_LOG,          1, xi.craftRank.ARTISAN   },
        },
    },

    [xi.zone.JUGNER_FOREST_S] = -- 82
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries.
        },
        [diggingLayer.REGULAR] =
        {
            -- No entries.
        },
        [diggingLayer.BURROW] = -- Set: Shrooms
        {
            [1] = { xi.item.DEATHBALL,       100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.SLEEPSHROOM,     100, xi.craftRank.AMATEUR    },
            [3] = { xi.item.CORAL_FUNGUS,     50, xi.craftRank.RECRUIT    },
            [4] = { xi.item.WOOZYSHROOM,      10, xi.craftRank.INITIATE   },
            [5] = { xi.item.PUFFBALL,         10, xi.craftRank.NOVICE     },
            [6] = { xi.item.DANCESHROOM,       5, xi.craftRank.APPRENTICE },
            [7] = { xi.item.REISHI_MUSHROOM,   1, xi.craftRank.JOURNEYMAN },
            [8] = { xi.item.KING_TRUFFLE,      1, xi.craftRank.CRAFTSMAN  },
        },
        [diggingLayer.BORE] = -- Set: Logs 4
        {
            [1] = { xi.item.ARROWWOOD_LOG,           240, xi.craftRank.AMATEUR   },
            [2] = { xi.item.YEW_LOG,                 150, xi.craftRank.AMATEUR   },
            [3] = { xi.item.ELM_LOG,                 100, xi.craftRank.RECRUIT   },
            [4] = { xi.item.FEYWEALD_LOG,             50, xi.craftRank.INITIATE  },
            [5] = { xi.item.OAK_LOG,                  50, xi.craftRank.INITIATE  },
            [6] = { xi.item.TEAK_LOG,                  1, xi.craftRank.CRAFTSMAN },
            [7] = { xi.item.PIECE_OF_ANCIENT_LUMBER,   1, xi.craftRank.CRAFTSMAN },
            [8] = { xi.item.JACARANDA_LOG,             1, xi.craftRank.ARTISAN   },
            [9] = { xi.item.LACQUER_TREE_LOG,          1, xi.craftRank.ARTISAN   },
        },
    },

    [xi.zone.VUNKERL_INLET_S] = -- 83
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries.
        },
        [diggingLayer.REGULAR] =
        {
            -- No entries.
        },
        [diggingLayer.BURROW] = -- Set: Feathers
        {
            [1] = { xi.item.CLUMP_OF_RED_MOKO_GRASS, 100, xi.craftRank.AMATEUR   },
            [2] = { xi.item.BLACK_CHOCOBO_FEATHER,    50, xi.craftRank.RECRUIT   },
            [4] = { xi.item.GIANT_BIRD_PLUME,         10, xi.craftRank.INITIATE  },
            [3] = { xi.item.SPIDER_WEB,                5, xi.craftRank.NOVICE    },
            [5] = { xi.item.PHOENIX_FEATHER,           1, xi.craftRank.CRAFTSMAN },
        },
        [diggingLayer.BORE] = -- Set: Yellow Ginseng seeds
        {
            [1] = { xi.item.PIECE_OF_YELLOW_GINSENG, 150, xi.craftRank.AMATEUR  },
            [2] = { xi.item.BAG_OF_WILDGRASS_SEEDS,   50, xi.craftRank.RECRUIT  },
            [3] = { xi.item.BAG_OF_TREE_CUTTINGS,     10, xi.craftRank.INITIATE },
            [4] = { xi.item.BAG_OF_CACTUS_STEMS,       5, xi.craftRank.NOVICE   },
        },
    },

    [xi.zone.BATALLIA_DOWNS_S] = -- 84
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries.
        },
        [diggingLayer.REGULAR] =
        {
            -- No entries.
        },
        [diggingLayer.BURROW] = -- Set: Ores 3
        {
            [1] = { xi.item.FLINT_STONE,               240, xi.craftRank.AMATEUR },
            [2] = { xi.item.CHUNK_OF_SILVER_ORE,       100, xi.craftRank.AMATEUR },
            [3] = { xi.item.CHUNK_OF_IRON_ORE,         100, xi.craftRank.RECRUIT },
            [4] = { xi.item.SHARD_OF_OBSIDIAN,         100, xi.craftRank.RECRUIT },
            [5] = { xi.item.CHUNK_OF_KOPPARNICKEL_ORE, 100, xi.craftRank.RECRUIT },
            [6] = { xi.item.CHUNK_OF_MYTHRIL_ORE,      100, xi.craftRank.RECRUIT },
            [7] = { xi.item.CHUNK_OF_DARKSTEEL_ORE,     10, xi.craftRank.NOVICE  },
            [8] = { xi.item.CHUNK_OF_SWAMP_ORE,         10, xi.craftRank.NOVICE  },
        },
        [diggingLayer.BORE] = -- Set: Feathers
        {
            [1] = { xi.item.CLUMP_OF_RED_MOKO_GRASS, 100, xi.craftRank.AMATEUR   },
            [2] = { xi.item.BLACK_CHOCOBO_FEATHER,    50, xi.craftRank.RECRUIT   },
            [4] = { xi.item.GIANT_BIRD_PLUME,         10, xi.craftRank.INITIATE  },
            [3] = { xi.item.SPIDER_WEB,                5, xi.craftRank.NOVICE    },
            [5] = { xi.item.PHOENIX_FEATHER,           1, xi.craftRank.CRAFTSMAN },
        },
    },

    [xi.zone.NORTH_GUSTABERG_S] = -- 88
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries.
        },
        [diggingLayer.REGULAR] =
        {
            -- No entries.
        },
        [diggingLayer.BURROW] = -- Set: Ores 3
        {
            [1] = { xi.item.FLINT_STONE,               240, xi.craftRank.AMATEUR },
            [2] = { xi.item.CHUNK_OF_SILVER_ORE,       100, xi.craftRank.AMATEUR },
            [3] = { xi.item.CHUNK_OF_IRON_ORE,         100, xi.craftRank.RECRUIT },
            [4] = { xi.item.SHARD_OF_OBSIDIAN,         100, xi.craftRank.RECRUIT },
            [5] = { xi.item.CHUNK_OF_KOPPARNICKEL_ORE, 100, xi.craftRank.RECRUIT },
            [6] = { xi.item.CHUNK_OF_MYTHRIL_ORE,      100, xi.craftRank.RECRUIT },
            [7] = { xi.item.CHUNK_OF_DARKSTEEL_ORE,     10, xi.craftRank.NOVICE  },
            [8] = { xi.item.CHUNK_OF_SWAMP_ORE,         10, xi.craftRank.NOVICE  },
        },
        [diggingLayer.BORE] = -- Set: Feathers
        {
            [1] = { xi.item.CLUMP_OF_RED_MOKO_GRASS, 100, xi.craftRank.AMATEUR   },
            [2] = { xi.item.BLACK_CHOCOBO_FEATHER,    50, xi.craftRank.RECRUIT   },
            [4] = { xi.item.GIANT_BIRD_PLUME,         10, xi.craftRank.INITIATE  },
            [3] = { xi.item.SPIDER_WEB,                5, xi.craftRank.NOVICE    },
            [5] = { xi.item.PHOENIX_FEATHER,           1, xi.craftRank.CRAFTSMAN },
        },
    },

    [xi.zone.GRAUBERG_S] = -- 89
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries.
        },
        [diggingLayer.REGULAR] =
        {
            -- No entries.
        },
        [diggingLayer.BURROW] = -- Set: Yellow Ginseng seeds
        {
            [1] = { xi.item.PIECE_OF_YELLOW_GINSENG, 150, xi.craftRank.AMATEUR  },
            [2] = { xi.item.BAG_OF_WILDGRASS_SEEDS,   50, xi.craftRank.RECRUIT  },
            [3] = { xi.item.BAG_OF_TREE_CUTTINGS,     10, xi.craftRank.INITIATE },
            [4] = { xi.item.BAG_OF_CACTUS_STEMS,       5, xi.craftRank.NOVICE   },
        },
        [diggingLayer.BORE] = -- Set: Logs 4
        {
            [1] = { xi.item.ARROWWOOD_LOG,           240, xi.craftRank.AMATEUR   },
            [2] = { xi.item.YEW_LOG,                 150, xi.craftRank.AMATEUR   },
            [3] = { xi.item.ELM_LOG,                 100, xi.craftRank.RECRUIT   },
            [4] = { xi.item.FEYWEALD_LOG,             50, xi.craftRank.INITIATE  },
            [5] = { xi.item.OAK_LOG,                  50, xi.craftRank.INITIATE  },
            [6] = { xi.item.TEAK_LOG,                  1, xi.craftRank.CRAFTSMAN },
            [7] = { xi.item.PIECE_OF_ANCIENT_LUMBER,   1, xi.craftRank.CRAFTSMAN },
            [8] = { xi.item.JACARANDA_LOG,             1, xi.craftRank.ARTISAN   },
            [9] = { xi.item.LACQUER_TREE_LOG,          1, xi.craftRank.ARTISAN   },
        },
    },

    [xi.zone.PASHHOW_MARSHLANDS_S] = -- 90
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries.
        },
        [diggingLayer.REGULAR] =
        {
            -- No entries.
        },
        [diggingLayer.BURROW] = -- Set: Yellow Ginseng seeds
        {
            [1] = { xi.item.PIECE_OF_YELLOW_GINSENG, 150, xi.craftRank.AMATEUR  },
            [2] = { xi.item.BAG_OF_WILDGRASS_SEEDS,   50, xi.craftRank.RECRUIT  },
            [3] = { xi.item.BAG_OF_TREE_CUTTINGS,     10, xi.craftRank.INITIATE },
            [4] = { xi.item.BAG_OF_CACTUS_STEMS,       5, xi.craftRank.NOVICE   },
        },
        [diggingLayer.BORE] = -- Set: Crystals
        {
            [1] = { xi.item.FIRE_CRYSTAL,      50, xi.craftRank.AMATEUR },
            [2] = { xi.item.ICE_CRYSTAL,       50, xi.craftRank.AMATEUR },
            [3] = { xi.item.WIND_CRYSTAL,      50, xi.craftRank.AMATEUR },
            [4] = { xi.item.EARTH_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [5] = { xi.item.LIGHTNING_CRYSTAL, 50, xi.craftRank.AMATEUR },
            [6] = { xi.item.WATER_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [7] = { xi.item.LIGHT_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [8] = { xi.item.DARK_CRYSTAL,      50, xi.craftRank.AMATEUR },
        },
    },

    [xi.zone.ROLANBERRY_FIELDS_S] = -- 91
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries.
        },
        [diggingLayer.REGULAR] =
        {
            -- No entries.
        },
        [diggingLayer.BURROW] = -- Set:Beastcoins
        {
            [1] = { xi.item.BEASTCOIN,          100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.SILVER_BEASTCOIN,    50, xi.craftRank.RECRUIT    },
            [3] = { xi.item.GOLD_BEASTCOIN,      10, xi.craftRank.INITIATE   },
            [4] = { xi.item.MYTHRIL_BEASTCOIN,    5, xi.craftRank.NOVICE     },
            [5] = { xi.item.PLATINUM_BEASTCOIN,   1, xi.craftRank.APPRENTICE },
        },
        [diggingLayer.BORE] = -- Set: Shrooms
        {
            [1] = { xi.item.DEATHBALL,       100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.SLEEPSHROOM,     100, xi.craftRank.AMATEUR    },
            [3] = { xi.item.CORAL_FUNGUS,     50, xi.craftRank.RECRUIT    },
            [4] = { xi.item.WOOZYSHROOM,      10, xi.craftRank.INITIATE   },
            [5] = { xi.item.PUFFBALL,         10, xi.craftRank.NOVICE     },
            [6] = { xi.item.DANCESHROOM,       5, xi.craftRank.APPRENTICE },
            [7] = { xi.item.REISHI_MUSHROOM,   1, xi.craftRank.JOURNEYMAN },
            [8] = { xi.item.KING_TRUFFLE,      1, xi.craftRank.CRAFTSMAN  },
        },
    },

    [xi.zone.WEST_SARUTABARUTA_S] = -- 95
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries.
        },
        [diggingLayer.REGULAR] =
        {
            -- No entries.
        },
        [diggingLayer.BURROW] = -- Set: Gysahl Greens
        {
            [1] = { xi.item.BUNCH_OF_GYSAHL_GREENS, 150, xi.craftRank.AMATEUR  },
            [2] = { xi.item.CHAMOMILE,               50, xi.craftRank.AMATEUR  },
            [3] = { xi.item.GINGER_ROOT,             50, xi.craftRank.RECRUIT  },
            [4] = { xi.item.HEAD_OF_NAPA,            50, xi.craftRank.INITIATE },
        },
        [diggingLayer.BORE] = -- Set: Crystals
        {
            [1] = { xi.item.FIRE_CRYSTAL,      50, xi.craftRank.AMATEUR },
            [2] = { xi.item.ICE_CRYSTAL,       50, xi.craftRank.AMATEUR },
            [3] = { xi.item.WIND_CRYSTAL,      50, xi.craftRank.AMATEUR },
            [4] = { xi.item.EARTH_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [5] = { xi.item.LIGHTNING_CRYSTAL, 50, xi.craftRank.AMATEUR },
            [6] = { xi.item.WATER_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [7] = { xi.item.LIGHT_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [8] = { xi.item.DARK_CRYSTAL,      50, xi.craftRank.AMATEUR },
        },
    },

    [xi.zone.FORT_KARUGO_NARUGO_S] = -- 96
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries.
        },
        [diggingLayer.REGULAR] =
        {
            -- No entries.
        },
        [diggingLayer.BURROW] =
        {
            -- No entries.
        },
        [diggingLayer.BORE] = -- Set: Ores 1
        {
            [1] = { xi.item.FLINT_STONE,            240, xi.craftRank.AMATEUR    },
            [2] = { xi.item.CHUNK_OF_ALUMINUM_ORE,  100, xi.craftRank.RECRUIT    },
            [3] = { xi.item.CHUNK_OF_GOLD_ORE,       50, xi.craftRank.INITIATE   },
            [4] = { xi.item.CHUNK_OF_DARKSTEEL_ORE,  10, xi.craftRank.NOVICE     },
            [5] = { xi.item.CHUNK_OF_ADAMAN_ORE,      5, xi.craftRank.JOURNEYMAN },
            [6] = { xi.item.CHUNK_OF_PLATINUM_ORE,    5, xi.craftRank.JOURNEYMAN },
            [7] = { xi.item.CHUNK_OF_ORICHALCUM_ORE,  1, xi.craftRank.CRAFTSMAN  },
        },
    },

    [xi.zone.MERIPHATAUD_MOUNTAINS_S] = -- 97
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries.
        },
        [diggingLayer.REGULAR] =
        {
            -- No entries.
        },
        [diggingLayer.BURROW] =
        {
            -- No entries.
        },
        [diggingLayer.BORE] = -- Set: Bones
        {
            [ 1] = { xi.item.BONE_CHIP,                150, xi.craftRank.AMATEUR    },
            [ 2] = { xi.item.HANDFUL_OF_FISH_SCALES,   150, xi.craftRank.AMATEUR    },
            [ 3] = { xi.item.SEASHELL,                 150, xi.craftRank.RECRUIT    },
            [ 4] = { xi.item.HIGH_QUALITY_PUGIL_SCALE,  50, xi.craftRank.INITIATE   },
            [ 5] = { xi.item.TITANICTUS_SHELL,          50, xi.craftRank.APPRENTICE },
            [ 6] = { xi.item.DEMON_HORN,                10, xi.craftRank.JOURNEYMAN },
            [ 7] = { xi.item.HANDFUL_OF_WYVERN_SCALES,   5, xi.craftRank.CRAFTSMAN  },
            [ 8] = { xi.item.TURTLE_SHELL,               5, xi.craftRank.CRAFTSMAN  },
            [ 9] = { xi.item.DEMON_SKULL,                1, xi.craftRank.ARTISAN    },
            [10] = { xi.item.HANDFUL_OF_DRAGON_SCALES,   1, xi.craftRank.ARTISAN    },
        },
    },

    [xi.zone.SAUROMUGUE_CHAMPAIGN_S] = -- 98
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries.
        },
        [diggingLayer.REGULAR] =
        {
            -- No entries.
        },
        [diggingLayer.BURROW] = -- Set: Beastcoins
        {
            [1] = { xi.item.BEASTCOIN,          100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.SILVER_BEASTCOIN,    50, xi.craftRank.RECRUIT    },
            [3] = { xi.item.GOLD_BEASTCOIN,      10, xi.craftRank.INITIATE   },
            [4] = { xi.item.MYTHRIL_BEASTCOIN,    5, xi.craftRank.NOVICE     },
            [5] = { xi.item.PLATINUM_BEASTCOIN,   1, xi.craftRank.APPRENTICE },
        },
        [diggingLayer.BORE] = -- Set: Logs 4
        {
            [1] = { xi.item.ARROWWOOD_LOG,           240, xi.craftRank.AMATEUR   },
            [2] = { xi.item.YEW_LOG,                 150, xi.craftRank.AMATEUR   },
            [3] = { xi.item.ELM_LOG,                 100, xi.craftRank.RECRUIT   },
            [4] = { xi.item.FEYWEALD_LOG,             50, xi.craftRank.INITIATE  },
            [5] = { xi.item.OAK_LOG,                  50, xi.craftRank.INITIATE  },
            [6] = { xi.item.TEAK_LOG,                  1, xi.craftRank.CRAFTSMAN },
            [7] = { xi.item.PIECE_OF_ANCIENT_LUMBER,   1, xi.craftRank.CRAFTSMAN },
            [8] = { xi.item.JACARANDA_LOG,             1, xi.craftRank.ARTISAN   },
            [9] = { xi.item.LACQUER_TREE_LOG,          1, xi.craftRank.ARTISAN   },
        },
    },

    [xi.zone.WEST_RONFAURE] = -- 100
    {
        [diggingLayer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
        },
        [diggingLayer.REGULAR] =
        {
            [ 1] = { xi.item.LITTLE_WORM,            50, xi.craftRank.AMATEUR  },
            [ 2] = { xi.item.ACORN,                  50, xi.craftRank.AMATEUR  },
            [ 3] = { xi.item.CLUMP_OF_MOKO_GRASS,    50, xi.craftRank.RECRUIT  },
            [ 4] = { xi.item.ARROWWOOD_LOG,          50, xi.craftRank.AMATEUR  },
            [ 5] = { xi.item.MAPLE_LOG,              50, xi.craftRank.RECRUIT  },
            [ 6] = { xi.item.ASH_LOG,                50, xi.craftRank.RECRUIT  },
            [ 7] = { xi.item.CHESTNUT_LOG,           10, xi.craftRank.INITIATE },
            [ 8] = { xi.item.CHOCOBO_FEATHER,        50, xi.craftRank.INITIATE },
            [ 9] = { xi.item.BAG_OF_VEGETABLE_SEEDS, 10, xi.craftRank.NOVICE   },
            [10] = { xi.item.RONFAURE_CHESTNUT,      10, xi.craftRank.NOVICE   },
            [11] = { xi.item.SPRIG_OF_MISTLETOE,     10, xi.craftRank.NOVICE   },
        },
        [diggingLayer.BURROW] = -- Set: Gysahl Greens
        {
            [1] = { xi.item.BUNCH_OF_GYSAHL_GREENS, 150, xi.craftRank.AMATEUR  },
            [2] = { xi.item.CHAMOMILE,               50, xi.craftRank.AMATEUR  },
            [3] = { xi.item.GINGER_ROOT,             50, xi.craftRank.RECRUIT  },
            [4] = { xi.item.HEAD_OF_NAPA,            50, xi.craftRank.INITIATE },
        },
        [diggingLayer.BORE] = -- Set: Crystals
        {
            [1] = { xi.item.FIRE_CRYSTAL,      50, xi.craftRank.AMATEUR },
            [2] = { xi.item.ICE_CRYSTAL,       50, xi.craftRank.AMATEUR },
            [3] = { xi.item.WIND_CRYSTAL,      50, xi.craftRank.AMATEUR },
            [4] = { xi.item.EARTH_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [5] = { xi.item.LIGHTNING_CRYSTAL, 50, xi.craftRank.AMATEUR },
            [6] = { xi.item.WATER_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [7] = { xi.item.LIGHT_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [8] = { xi.item.DARK_CRYSTAL,      50, xi.craftRank.AMATEUR },
        },
    },

    [xi.zone.EAST_RONFAURE] = -- 101
    {
        [diggingLayer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
        },
        [diggingLayer.REGULAR] =
        {
            [ 1] = { xi.item.LITTLE_WORM,        50, xi.craftRank.AMATEUR    },
            [ 2] = { xi.item.ACORN,              50, xi.craftRank.AMATEUR    },
            [ 3] = { xi.item.ARROWWOOD_LOG,      50, xi.craftRank.AMATEUR    },
            [ 4] = { xi.item.MAPLE_LOG,          50, xi.craftRank.RECRUIT    },
            [ 5] = { xi.item.ASH_LOG,            50, xi.craftRank.RECRUIT    },
            [ 6] = { xi.item.CHESTNUT_LOG,       10, xi.craftRank.INITIATE   },
            [ 7] = { xi.item.BAG_OF_FRUIT_SEEDS, 10, xi.craftRank.INITIATE   },
            [ 8] = { xi.item.RONFAURE_CHESTNUT,  10, xi.craftRank.NOVICE     },
            [ 9] = { xi.item.CHOCOBO_FEATHER,    50, xi.craftRank.NOVICE     },
            [10] = { xi.item.SPRIG_OF_MISTLETOE, 10, xi.craftRank.APPRENTICE },
            [11] = { xi.item.KING_TRUFFLE,       10, xi.craftRank.ARTISAN    },
        },
        [diggingLayer.BURROW] = -- Set: Gysahl Greens
        {
            [1] = { xi.item.BUNCH_OF_GYSAHL_GREENS, 150, xi.craftRank.AMATEUR  },
            [2] = { xi.item.CHAMOMILE,               50, xi.craftRank.AMATEUR  },
            [3] = { xi.item.GINGER_ROOT,             50, xi.craftRank.RECRUIT  },
            [4] = { xi.item.HEAD_OF_NAPA,            50, xi.craftRank.INITIATE },
        },
        [diggingLayer.BORE] = -- Set: Crystals
        {
            [1] = { xi.item.FIRE_CRYSTAL,      50, xi.craftRank.AMATEUR },
            [2] = { xi.item.ICE_CRYSTAL,       50, xi.craftRank.AMATEUR },
            [3] = { xi.item.WIND_CRYSTAL,      50, xi.craftRank.AMATEUR },
            [4] = { xi.item.EARTH_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [5] = { xi.item.LIGHTNING_CRYSTAL, 50, xi.craftRank.AMATEUR },
            [6] = { xi.item.WATER_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [7] = { xi.item.LIGHT_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [8] = { xi.item.DARK_CRYSTAL,      50, xi.craftRank.AMATEUR },
        },
    },

    [xi.zone.LA_THEINE_PLATEAU] = -- 102
    {
        [diggingLayer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
            [2] = { xi.item.COIN_OF_GLORY,        5, xi.craftRank.ADEPT },
        },
        [diggingLayer.REGULAR] =
        {
            [ 1] = { xi.item.PEBBLE,                  50, xi.craftRank.AMATEUR    },
            [ 2] = { xi.item.LITTLE_WORM,             50, xi.craftRank.AMATEUR    },
            [ 3] = { xi.item.CHOCOBO_FEATHER,         50, xi.craftRank.RECRUIT    },
            [ 4] = { xi.item.CHUNK_OF_TIN_ORE,        50, xi.craftRank.AMATEUR    },
            [ 5] = { xi.item.CHUNK_OF_ZINC_ORE,       50, xi.craftRank.RECRUIT    },
            [ 6] = { xi.item.ARROWWOOD_LOG,           50, xi.craftRank.AMATEUR    },
            [ 7] = { xi.item.YEW_LOG,                 50, xi.craftRank.RECRUIT    },
            [ 8] = { xi.item.CHESTNUT_LOG,            10, xi.craftRank.INITIATE   },
            [ 9] = { xi.item.MAHOGANY_LOG,            10, xi.craftRank.NOVICE     },
            [10] = { xi.item.PINCH_OF_DRIED_MARJORAM, 10, xi.craftRank.APPRENTICE },
        },
        [diggingLayer.BURROW] = -- Set: Gysahl Greens
        {
            [1] = { xi.item.BUNCH_OF_GYSAHL_GREENS, 150, xi.craftRank.AMATEUR  },
            [2] = { xi.item.CHAMOMILE,               50, xi.craftRank.AMATEUR  },
            [3] = { xi.item.GINGER_ROOT,             50, xi.craftRank.RECRUIT  },
            [4] = { xi.item.HEAD_OF_NAPA,            50, xi.craftRank.INITIATE },
        },
        [diggingLayer.BORE] = -- Set: Yellow Ginseng seeds
        {
            [1] = { xi.item.PIECE_OF_YELLOW_GINSENG, 150, xi.craftRank.AMATEUR  },
            [2] = { xi.item.BAG_OF_WILDGRASS_SEEDS,   50, xi.craftRank.RECRUIT  },
            [3] = { xi.item.BAG_OF_TREE_CUTTINGS,     10, xi.craftRank.INITIATE },
            [4] = { xi.item.BAG_OF_CACTUS_STEMS,       5, xi.craftRank.NOVICE   },
        },
    },

    [xi.zone.VALKURM_DUNES] = -- 103
    {
        [diggingLayer.TREASURE] =
        {
            [1] = { xi.item.COIN_OF_DECAY,       5, xi.craftRank.ADEPT },
            [2] = { xi.item.ORDELLE_BRONZEPIECE, 5, xi.craftRank.ADEPT },
            [3] = { xi.item.ONE_BYNE_BILL,       5, xi.craftRank.ADEPT },
            [4] = { xi.item.TUKUKU_WHITESHELL,   5, xi.craftRank.ADEPT },
        },
        [diggingLayer.REGULAR] =
        {
            [1] = { xi.item.LUGWORM,                 50, xi.craftRank.AMATEUR   },
            [2] = { xi.item.BONE_CHIP,              100, xi.craftRank.AMATEUR   },
            [3] = { xi.item.HANDFUL_OF_FISH_SCALES,  50, xi.craftRank.RECRUIT   },
            [4] = { xi.item.SEASHELL,               150, xi.craftRank.RECRUIT   },
            [5] = { xi.item.GIANT_FEMUR,             50, xi.craftRank.NOVICE    },
            [6] = { xi.item.SHELL_BUG,               50, xi.craftRank.INITIATE  },
            [7] = { xi.item.LIZARD_MOLT,             50, xi.craftRank.NOVICE    },
            [8] = { xi.item.SHALL_SHELL,             50, xi.craftRank.CRAFTSMAN },
            [9] = { xi.item.TURTLE_SHELL,            50, xi.craftRank.ARTISAN   },
        },
        [diggingLayer.BURROW] = -- Set: Feathers
        {
            [1] = { xi.item.CLUMP_OF_RED_MOKO_GRASS, 100, xi.craftRank.AMATEUR   },
            [2] = { xi.item.BLACK_CHOCOBO_FEATHER,    50, xi.craftRank.RECRUIT   },
            [4] = { xi.item.GIANT_BIRD_PLUME,         10, xi.craftRank.INITIATE  },
            [3] = { xi.item.SPIDER_WEB,                5, xi.craftRank.NOVICE    },
            [5] = { xi.item.PHOENIX_FEATHER,           1, xi.craftRank.CRAFTSMAN },
        },
        [diggingLayer.BORE] = -- Set: Bones
        {
            [ 1] = { xi.item.BONE_CHIP,                150, xi.craftRank.AMATEUR    },
            [ 2] = { xi.item.HANDFUL_OF_FISH_SCALES,   150, xi.craftRank.AMATEUR    },
            [ 3] = { xi.item.SEASHELL,                 150, xi.craftRank.RECRUIT    },
            [ 4] = { xi.item.HIGH_QUALITY_PUGIL_SCALE,  50, xi.craftRank.INITIATE   },
            [ 5] = { xi.item.TITANICTUS_SHELL,          50, xi.craftRank.APPRENTICE },
            [ 6] = { xi.item.DEMON_HORN,                10, xi.craftRank.JOURNEYMAN },
            [ 7] = { xi.item.HANDFUL_OF_WYVERN_SCALES,   5, xi.craftRank.CRAFTSMAN  },
            [ 8] = { xi.item.TURTLE_SHELL,               5, xi.craftRank.CRAFTSMAN  },
            [ 9] = { xi.item.DEMON_SKULL,                1, xi.craftRank.ARTISAN    },
            [10] = { xi.item.HANDFUL_OF_DRAGON_SCALES,   1, xi.craftRank.ARTISAN    },
        },
    },

    [xi.zone.JUGNER_FOREST] = -- 104
    {
        [diggingLayer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
            [2] = { xi.item.COIN_OF_BIRTH,        5, xi.craftRank.ADEPT },
            [3] = { xi.item.KING_TRUFFLE,         5, xi.craftRank.ADEPT },
        },
        [diggingLayer.REGULAR] =
        {
            [1] = { xi.item.LITTLE_WORM,        50, xi.craftRank.AMATEUR   },
            [2] = { xi.item.ACORN,              50, xi.craftRank.AMATEUR   },
            [3] = { xi.item.MAPLE_LOG,          50, xi.craftRank.RECRUIT   },
            [4] = { xi.item.WILLOW_LOG,         50, xi.craftRank.RECRUIT   },
            [5] = { xi.item.HOLLY_LOG,          50, xi.craftRank.NOVICE    },
            [6] = { xi.item.OAK_LOG,            50, xi.craftRank.INITIATE  },
            [7] = { xi.item.SPRIG_OF_MISTLETOE, 10, xi.craftRank.NOVICE    },
            [8] = { xi.item.SCREAM_FUNGUS,       5, xi.craftRank.CRAFTSMAN },
        },
        [diggingLayer.BURROW] = -- Set: Crystals
        {
            [1] = { xi.item.FIRE_CRYSTAL,      50, xi.craftRank.AMATEUR },
            [2] = { xi.item.ICE_CRYSTAL,       50, xi.craftRank.AMATEUR },
            [3] = { xi.item.WIND_CRYSTAL,      50, xi.craftRank.AMATEUR },
            [4] = { xi.item.EARTH_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [5] = { xi.item.LIGHTNING_CRYSTAL, 50, xi.craftRank.AMATEUR },
            [6] = { xi.item.WATER_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [7] = { xi.item.LIGHT_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [8] = { xi.item.DARK_CRYSTAL,      50, xi.craftRank.AMATEUR },
        },
        [diggingLayer.BORE] = -- Set: Logs 1
        {
            [1] = { xi.item.ARROWWOOD_LOG,           240, xi.craftRank.AMATEUR    },
            [2] = { xi.item.YEW_LOG,                 150, xi.craftRank.AMATEUR    },
            [3] = { xi.item.ELM_LOG,                 100, xi.craftRank.RECRUIT    },
            [4] = { xi.item.OAK_LOG,                  50, xi.craftRank.INITIATE   },
            [5] = { xi.item.ROSEWOOD_LOG,             10, xi.craftRank.NOVICE     },
            [6] = { xi.item.MAHOGANY_LOG,              5, xi.craftRank.APPRENTICE },
            [7] = { xi.item.EBONY_LOG,                 5, xi.craftRank.JOURNEYMAN },
            [8] = { xi.item.PIECE_OF_ANCIENT_LUMBER,   1, xi.craftRank.CRAFTSMAN  },
            [9] = { xi.item.LACQUER_TREE_LOG,          1, xi.craftRank.ARTISAN    },
        },
    },

    [xi.zone.BATALLIA_DOWNS] = -- 105
    {
        [diggingLayer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
            [2] = { xi.item.COIN_OF_ADVANCEMENT,  5, xi.craftRank.ADEPT },
        },
        [diggingLayer.REGULAR] =
        {
            [1] = { xi.item.PEBBLE,                50, xi.craftRank.AMATEUR    },
            [2] = { xi.item.FLINT_STONE,           50, xi.craftRank.AMATEUR    },
            [3] = { xi.item.BONE_CHIP,             50, xi.craftRank.AMATEUR    },
            [4] = { xi.item.CHUNK_OF_COPPER_ORE,   50, xi.craftRank.RECRUIT    },
            [5] = { xi.item.BIRD_FEATHER,          50, xi.craftRank.RECRUIT    },
            [6] = { xi.item.CHUNK_OF_IRON_ORE,     50, xi.craftRank.INITIATE   },
            [7] = { xi.item.RED_JAR,               50, xi.craftRank.NOVICE     },
            [8] = { xi.item.BLACK_CHOCOBO_FEATHER,  5, xi.craftRank.APPRENTICE },
            [9] = { xi.item.REISHI_MUSHROOM,        5, xi.craftRank.JOURNEYMAN },
        },
        [diggingLayer.BURROW] = -- Set: Beastcoins
        {
            [1] = { xi.item.BEASTCOIN,          100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.SILVER_BEASTCOIN,    50, xi.craftRank.RECRUIT    },
            [3] = { xi.item.GOLD_BEASTCOIN,      10, xi.craftRank.INITIATE   },
            [4] = { xi.item.MYTHRIL_BEASTCOIN,    5, xi.craftRank.NOVICE     },
            [5] = { xi.item.PLATINUM_BEASTCOIN,   1, xi.craftRank.APPRENTICE },
        },
        [diggingLayer.BORE] = -- Set: Yellow Ginseng seeds
        {
            [1] = { xi.item.PIECE_OF_YELLOW_GINSENG, 150, xi.craftRank.AMATEUR  },
            [2] = { xi.item.BAG_OF_WILDGRASS_SEEDS,   50, xi.craftRank.RECRUIT  },
            [3] = { xi.item.BAG_OF_TREE_CUTTINGS,     10, xi.craftRank.INITIATE },
            [4] = { xi.item.BAG_OF_CACTUS_STEMS,       5, xi.craftRank.NOVICE   },
        },
    },

    [xi.zone.NORTH_GUSTABERG] = -- 106
    {
        [diggingLayer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
            [2] = { xi.item.COIN_OF_GLORY,        5, xi.craftRank.ADEPT },
        },
        [diggingLayer.REGULAR] =
        {
            [ 1] = { xi.item.PEBBLE,                 50, xi.craftRank.AMATEUR    },
            [ 2] = { xi.item.LITTLE_WORM,            50, xi.craftRank.AMATEUR    },
            [ 3] = { xi.item.BONE_CHIP,              50, xi.craftRank.AMATEUR    },
            [ 4] = { xi.item.BIRD_FEATHER,           50, xi.craftRank.AMATEUR    },
            [ 5] = { xi.item.HANDFUL_OF_FISH_SCALES, 50, xi.craftRank.AMATEUR    },
            [ 6] = { xi.item.INSECT_WING,            50, xi.craftRank.AMATEUR    },
            [ 7] = { xi.item.BAG_OF_CACTUS_STEMS,    10, xi.craftRank.RECRUIT    },
            [ 8] = { xi.item.LIZARD_MOLT,            50, xi.craftRank.RECRUIT    },
            [ 9] = { xi.item.MYTHRIL_BEASTCOIN,      10, xi.craftRank.APPRENTICE },
            [10] = { xi.item.CHUNK_OF_MYTHRIL_ORE,   10, xi.craftRank.APPRENTICE },
            [11] = { xi.item.CHUNK_OF_DARKSTEEL_ORE, 10, xi.craftRank.ARTISAN    },
        },
        [diggingLayer.BURROW] = -- Set: Gysahl Greens
        {
            [1] = { xi.item.BUNCH_OF_GYSAHL_GREENS, 150, xi.craftRank.AMATEUR  },
            [2] = { xi.item.CHAMOMILE,               50, xi.craftRank.AMATEUR  },
            [3] = { xi.item.GINGER_ROOT,             50, xi.craftRank.RECRUIT  },
            [4] = { xi.item.HEAD_OF_NAPA,            50, xi.craftRank.INITIATE },
        },
        [diggingLayer.BORE] = -- Set: Crystals
        {
            [1] = { xi.item.FIRE_CRYSTAL,      50, xi.craftRank.AMATEUR },
            [2] = { xi.item.ICE_CRYSTAL,       50, xi.craftRank.AMATEUR },
            [3] = { xi.item.WIND_CRYSTAL,      50, xi.craftRank.AMATEUR },
            [4] = { xi.item.EARTH_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [5] = { xi.item.LIGHTNING_CRYSTAL, 50, xi.craftRank.AMATEUR },
            [6] = { xi.item.WATER_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [7] = { xi.item.LIGHT_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [8] = { xi.item.DARK_CRYSTAL,      50, xi.craftRank.AMATEUR },
        },
    },

    [xi.zone.SOUTH_GUSTABERG] = -- 107
    {
        [diggingLayer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
            [2] = { xi.item.COIN_OF_DECAY,        5, xi.craftRank.ADEPT },
        },
        [diggingLayer.REGULAR] =
        {
            [ 1] = { xi.item.PEBBLE,               50, xi.craftRank.AMATEUR    },
            [ 2] = { xi.item.LITTLE_WORM,          50, xi.craftRank.AMATEUR    },
            [ 3] = { xi.item.BONE_CHIP,            50, xi.craftRank.AMATEUR    },
            [ 4] = { xi.item.BIRD_FEATHER,         50, xi.craftRank.AMATEUR    },
            [ 5] = { xi.item.CHUNK_OF_ROCK_SALT,   50, xi.craftRank.AMATEUR    },
            [ 6] = { xi.item.INSECT_WING,          50, xi.craftRank.AMATEUR    },
            [ 7] = { xi.item.BAG_OF_GRAIN_SEEDS,   50, xi.craftRank.RECRUIT    },
            [ 8] = { xi.item.LIZARD_MOLT,          50, xi.craftRank.RECRUIT    },
            [ 9] = { xi.item.MYTHRIL_BEASTCOIN,    50, xi.craftRank.APPRENTICE },
            [10] = { xi.item.CHUNK_OF_MYTHRIL_ORE, 10, xi.craftRank.APPRENTICE },
        },
        [diggingLayer.BURROW] = -- Set: Gysahl Greens
        {
            [1] = { xi.item.BUNCH_OF_GYSAHL_GREENS, 150, xi.craftRank.AMATEUR  },
            [2] = { xi.item.CHAMOMILE,               50, xi.craftRank.AMATEUR  },
            [3] = { xi.item.GINGER_ROOT,             50, xi.craftRank.RECRUIT  },
            [4] = { xi.item.HEAD_OF_NAPA,            50, xi.craftRank.INITIATE },
        },
        [diggingLayer.BORE] = -- Set: Crystals
        {
            [1] = { xi.item.FIRE_CRYSTAL,      50, xi.craftRank.AMATEUR },
            [2] = { xi.item.ICE_CRYSTAL,       50, xi.craftRank.AMATEUR },
            [3] = { xi.item.WIND_CRYSTAL,      50, xi.craftRank.AMATEUR },
            [4] = { xi.item.EARTH_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [5] = { xi.item.LIGHTNING_CRYSTAL, 50, xi.craftRank.AMATEUR },
            [6] = { xi.item.WATER_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [7] = { xi.item.LIGHT_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [8] = { xi.item.DARK_CRYSTAL,      50, xi.craftRank.AMATEUR },
        },
    },

    [xi.zone.KONSCHTAT_HIGHLANDS] = -- 108
    {
        [diggingLayer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
            [2] = { xi.item.COIN_OF_BIRTH,        5, xi.craftRank.ADEPT },
        },
        [diggingLayer.REGULAR] =
        {
            [1] = { xi.item.PEBBLE,                 50, xi.craftRank.AMATEUR    },
            [2] = { xi.item.FLINT_STONE,            50, xi.craftRank.AMATEUR    },
            [3] = { xi.item.BONE_CHIP,              50, xi.craftRank.AMATEUR    },
            [4] = { xi.item.HANDFUL_OF_FISH_SCALES, 50, xi.craftRank.AMATEUR    },
            [5] = { xi.item.CHUNK_OF_ZINC_ORE,      50, xi.craftRank.AMATEUR    },
            [6] = { xi.item.BIRD_FEATHER,           10, xi.craftRank.RECRUIT    },
            [7] = { xi.item.LIZARD_MOLT,            50, xi.craftRank.RECRUIT    },
            [8] = { xi.item.MYTHRIL_BEASTCOIN,       5, xi.craftRank.APPRENTICE },
            [9] = { xi.item.ELM_LOG,                 5, xi.craftRank.APPRENTICE },
        },
        [diggingLayer.BURROW] = -- Set: Crystals
        {
            [1] = { xi.item.FIRE_CRYSTAL,      50, xi.craftRank.AMATEUR },
            [2] = { xi.item.ICE_CRYSTAL,       50, xi.craftRank.AMATEUR },
            [3] = { xi.item.WIND_CRYSTAL,      50, xi.craftRank.AMATEUR },
            [4] = { xi.item.EARTH_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [5] = { xi.item.LIGHTNING_CRYSTAL, 50, xi.craftRank.AMATEUR },
            [6] = { xi.item.WATER_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [7] = { xi.item.LIGHT_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [8] = { xi.item.DARK_CRYSTAL,      50, xi.craftRank.AMATEUR },
        },
        [diggingLayer.BORE] = -- Set: Feathers
        {
            [1] = { xi.item.CLUMP_OF_RED_MOKO_GRASS, 100, xi.craftRank.AMATEUR   },
            [2] = { xi.item.BLACK_CHOCOBO_FEATHER,    50, xi.craftRank.RECRUIT   },
            [4] = { xi.item.GIANT_BIRD_PLUME,         10, xi.craftRank.INITIATE  },
            [3] = { xi.item.SPIDER_WEB,                5, xi.craftRank.NOVICE    },
            [5] = { xi.item.PHOENIX_FEATHER,           1, xi.craftRank.CRAFTSMAN },
        },
    },

    [xi.zone.PASHHOW_MARSHLANDS] = -- 109
    {
        [diggingLayer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
            [2] = { xi.item.COIN_OF_ADVANCEMENT,  5, xi.craftRank.ADEPT },
        },
        [diggingLayer.REGULAR] =
        {
            [1] = { xi.item.PEBBLE,              50, xi.craftRank.AMATEUR    },
            [2] = { xi.item.INSECT_WING,         50, xi.craftRank.AMATEUR    },
            [3] = { xi.item.LIZARD_MOLT,         50, xi.craftRank.RECRUIT    },
            [4] = { xi.item.CHUNK_OF_SILVER_ORE, 50, xi.craftRank.RECRUIT    },
            [5] = { xi.item.MYTHRIL_BEASTCOIN,   10, xi.craftRank.INITIATE   },
            [6] = { xi.item.TURTLE_SHELL,        10, xi.craftRank.INITIATE   },
            [7] = { xi.item.WILLOW_LOG,          10, xi.craftRank.INITIATE   },
            [8] = { xi.item.PETRIFIED_LOG,        5, xi.craftRank.NOVICE     },
            [9] = { xi.item.PUFFBALL,             5, xi.craftRank.APPRENTICE },
        },
        [diggingLayer.BURROW] = -- Set: Yellow Ginseng seeds
        {
            [1] = { xi.item.PIECE_OF_YELLOW_GINSENG, 150, xi.craftRank.AMATEUR  },
            [2] = { xi.item.BAG_OF_WILDGRASS_SEEDS,   50, xi.craftRank.RECRUIT  },
            [3] = { xi.item.BAG_OF_TREE_CUTTINGS,     10, xi.craftRank.INITIATE },
            [4] = { xi.item.BAG_OF_CACTUS_STEMS,       5, xi.craftRank.NOVICE   },
        },
        [diggingLayer.BORE] = -- Set: Crystals
        {
            [1] = { xi.item.FIRE_CRYSTAL,      50, xi.craftRank.AMATEUR },
            [2] = { xi.item.ICE_CRYSTAL,       50, xi.craftRank.AMATEUR },
            [3] = { xi.item.WIND_CRYSTAL,      50, xi.craftRank.AMATEUR },
            [4] = { xi.item.EARTH_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [5] = { xi.item.LIGHTNING_CRYSTAL, 50, xi.craftRank.AMATEUR },
            [6] = { xi.item.WATER_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [7] = { xi.item.LIGHT_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [8] = { xi.item.DARK_CRYSTAL,      50, xi.craftRank.AMATEUR },
        },
    },

    [xi.zone.ROLANBERRY_FIELDS] = -- 110
    {
        [diggingLayer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
            [2] = { xi.item.COIN_OF_GLORY,        5, xi.craftRank.ADEPT },
        },
        [diggingLayer.REGULAR] =
        {
            [1] = { xi.item.PEBBLE,                  100, xi.craftRank.AMATEUR   },
            [2] = { xi.item.LITTLE_WORM,             100, xi.craftRank.AMATEUR   },
            [3] = { xi.item.FLINT_STONE,             100, xi.craftRank.AMATEUR   },
            [4] = { xi.item.INSECT_WING,              50, xi.craftRank.RECRUIT   },
            [5] = { xi.item.MYTHRIL_BEASTCOIN,        10, xi.craftRank.INITIATE  },
            [6] = { xi.item.SPRIG_OF_SAGE,            10, xi.craftRank.INITIATE  },
            [7] = { xi.item.RED_JAR,                  10, xi.craftRank.NOVICE    },
            [8] = { xi.item.GOLD_BEASTCOIN,            5, xi.craftRank.CRAFTSMAN },
            [9] = { xi.item.CHUNK_OF_ORICHALCUM_ORE,   5, xi.craftRank.CRAFTSMAN },
        },
        [diggingLayer.BURROW] = -- Set: Feathers
        {
            [1] = { xi.item.CLUMP_OF_RED_MOKO_GRASS, 100, xi.craftRank.AMATEUR   },
            [2] = { xi.item.BLACK_CHOCOBO_FEATHER,    50, xi.craftRank.RECRUIT   },
            [4] = { xi.item.GIANT_BIRD_PLUME,         10, xi.craftRank.INITIATE  },
            [3] = { xi.item.SPIDER_WEB,                5, xi.craftRank.NOVICE    },
            [5] = { xi.item.PHOENIX_FEATHER,           1, xi.craftRank.CRAFTSMAN },
        },
        [diggingLayer.BORE] = -- Set: Shrooms
        {
            [1] = { xi.item.DEATHBALL,       100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.SLEEPSHROOM,     100, xi.craftRank.AMATEUR    },
            [3] = { xi.item.CORAL_FUNGUS,     50, xi.craftRank.RECRUIT    },
            [4] = { xi.item.WOOZYSHROOM,      10, xi.craftRank.INITIATE   },
            [5] = { xi.item.PUFFBALL,         10, xi.craftRank.NOVICE     },
            [6] = { xi.item.DANCESHROOM,       5, xi.craftRank.APPRENTICE },
            [7] = { xi.item.REISHI_MUSHROOM,   1, xi.craftRank.JOURNEYMAN },
            [8] = { xi.item.KING_TRUFFLE,      1, xi.craftRank.CRAFTSMAN  },
        },
    },

    [xi.zone.BEAUCEDINE_GLACIER] = -- 111
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries.
        },
        [diggingLayer.REGULAR] =
        {
            -- No entries.
        },
        [diggingLayer.BURROW] =
        {
            -- No entries.
        },
        [diggingLayer.BORE] =
        {
            -- No entries.
        },
    },

    [xi.zone.XARCABARD] = -- 112
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries.
        },
        [diggingLayer.REGULAR] =
        {
            -- No entries.
        },
        [diggingLayer.BURROW] =
        {
            -- No entries.
        },
        [diggingLayer.BORE] =
        {
            -- No entries.
        },
    },

    [xi.zone.CAPE_TERIGGAN] = -- 113
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries.
        },
        [diggingLayer.REGULAR] =
        {
            -- No entries.
        },
        [diggingLayer.BURROW] = -- Set: Feathers
        {
            [1] = { xi.item.CLUMP_OF_RED_MOKO_GRASS, 100, xi.craftRank.AMATEUR   },
            [2] = { xi.item.BLACK_CHOCOBO_FEATHER,    50, xi.craftRank.RECRUIT   },
            [4] = { xi.item.GIANT_BIRD_PLUME,         10, xi.craftRank.INITIATE  },
            [3] = { xi.item.SPIDER_WEB,                5, xi.craftRank.NOVICE    },
            [5] = { xi.item.PHOENIX_FEATHER,           1, xi.craftRank.CRAFTSMAN },
        },
        [diggingLayer.BORE] = -- Set: Logs 1
        {
            [1] = { xi.item.ARROWWOOD_LOG,           240, xi.craftRank.AMATEUR    },
            [2] = { xi.item.YEW_LOG,                 150, xi.craftRank.AMATEUR    },
            [3] = { xi.item.ELM_LOG,                 100, xi.craftRank.RECRUIT    },
            [4] = { xi.item.OAK_LOG,                  50, xi.craftRank.INITIATE   },
            [5] = { xi.item.ROSEWOOD_LOG,             10, xi.craftRank.NOVICE     },
            [6] = { xi.item.MAHOGANY_LOG,              5, xi.craftRank.APPRENTICE },
            [7] = { xi.item.EBONY_LOG,                 5, xi.craftRank.JOURNEYMAN },
            [8] = { xi.item.PIECE_OF_ANCIENT_LUMBER,   1, xi.craftRank.CRAFTSMAN  },
            [9] = { xi.item.LACQUER_TREE_LOG,          1, xi.craftRank.ARTISAN    },
        },
    },

    [xi.zone.EASTERN_ALTEPA_DESERT] = -- 114
    {
        [diggingLayer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
        },
        [diggingLayer.REGULAR] =
        {
            [ 1] = { xi.item.FLINT_STONE,              240, xi.craftRank.AMATEUR    },
            [ 2] = { xi.item.BONE_CHIP,                100, xi.craftRank.AMATEUR    },
            [ 3] = { xi.item.PEBBLE,                    50, xi.craftRank.RECRUIT    },
            [ 4] = { xi.item.CHUNK_OF_ZINC_ORE,         50, xi.craftRank.RECRUIT    },
            [ 5] = { xi.item.CHUNK_OF_SILVER_ORE,       50, xi.craftRank.INITIATE   },
            [ 6] = { xi.item.GIANT_FEMUR,               50, xi.craftRank.NOVICE     },
            [ 7] = { xi.item.HANDFUL_OF_WYVERN_SCALES,  50, xi.craftRank.APPRENTICE },
            [ 8] = { xi.item.CHUNK_OF_MYTHRIL_ORE,      10, xi.craftRank.JOURNEYMAN },
            [ 9] = { xi.item.CHUNK_OF_PLATINUM_ORE,     10, xi.craftRank.JOURNEYMAN },
            [10] = { xi.item.PHILOSOPHERS_STONE,         5, xi.craftRank.CRAFTSMAN  },
        },
        [diggingLayer.BURROW] =
        {
            [1] = { xi.item.BAG_OF_GRAIN_SEEDS,     50, xi.craftRank.AMATEUR    },
            [2] = { xi.item.BAG_OF_VEGETABLE_SEEDS, 50, xi.craftRank.RECRUIT    },
            [3] = { xi.item.BAG_OF_HERB_SEEDS,      50, xi.craftRank.INITIATE   },
            [4] = { xi.item.BAG_OF_WILDGRASS_SEEDS, 50, xi.craftRank.NOVICE     },
            [5] = { xi.item.BAG_OF_FRUIT_SEEDS,     50, xi.craftRank.APPRENTICE },
            [6] = { xi.item.BAG_OF_TREE_CUTTINGS,   10, xi.craftRank.JOURNEYMAN },
            [7] = { xi.item.BAG_OF_CACTUS_STEMS,    10, xi.craftRank.CRAFTSMAN  },
        },
        [diggingLayer.BORE] = -- Set: Ores 1
        {
            [1] = { xi.item.FLINT_STONE,             240, xi.craftRank.AMATEUR    },
            [2] = { xi.item.CHUNK_OF_ALUMINUM_ORE,   100, xi.craftRank.RECRUIT    },
            [3] = { xi.item.CHUNK_OF_GOLD_ORE,        50, xi.craftRank.INITIATE   },
            [4] = { xi.item.CHUNK_OF_DARKSTEEL_ORE,   10, xi.craftRank.NOVICE     },
            [5] = { xi.item.CHUNK_OF_ADAMAN_ORE,       5, xi.craftRank.JOURNEYMAN },
            [6] = { xi.item.CHUNK_OF_PLATINUM_ORE,     5, xi.craftRank.JOURNEYMAN },
            [7] = { xi.item.CHUNK_OF_ORICHALCUM_ORE,   1, xi.craftRank.CRAFTSMAN  },
        },
    },

    [xi.zone.WEST_SARUTABARUTA] = -- 115
    {
        [diggingLayer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
            [2] = { xi.item.COIN_OF_DECAY,        5, xi.craftRank.ADEPT },
        },
        [diggingLayer.REGULAR] =
        {
            [1] = { xi.item.PEBBLE,                50, xi.craftRank.AMATEUR  },
            [2] = { xi.item.LITTLE_WORM,           50, xi.craftRank.AMATEUR  },
            [3] = { xi.item.CLUMP_OF_MOKO_GRASS,   50, xi.craftRank.RECRUIT  },
            [4] = { xi.item.LAUAN_LOG,             50, xi.craftRank.RECRUIT  },
            [5] = { xi.item.INSECT_WING,           50, xi.craftRank.RECRUIT  },
            [6] = { xi.item.YAGUDO_FEATHER,        50, xi.craftRank.INITIATE },
            [7] = { xi.item.BIRD_FEATHER,          10, xi.craftRank.INITIATE },
            [8] = { xi.item.BALL_OF_SARUTA_COTTON, 10, xi.craftRank.INITIATE },
            [9] = { xi.item.ROSEWOOD_LOG,           5, xi.craftRank.NOVICE   },
        },
        [diggingLayer.BURROW] = -- Set: Gysahl Greens
        {
            [1] = { xi.item.BUNCH_OF_GYSAHL_GREENS, 150, xi.craftRank.AMATEUR  },
            [2] = { xi.item.CHAMOMILE,               50, xi.craftRank.AMATEUR  },
            [3] = { xi.item.GINGER_ROOT,             50, xi.craftRank.RECRUIT  },
            [4] = { xi.item.HEAD_OF_NAPA,            50, xi.craftRank.INITIATE },
        },
        [diggingLayer.BORE] = -- Set: Crystals
        {
            [1] = { xi.item.FIRE_CRYSTAL,      50, xi.craftRank.AMATEUR },
            [2] = { xi.item.ICE_CRYSTAL,       50, xi.craftRank.AMATEUR },
            [3] = { xi.item.WIND_CRYSTAL,      50, xi.craftRank.AMATEUR },
            [4] = { xi.item.EARTH_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [5] = { xi.item.LIGHTNING_CRYSTAL, 50, xi.craftRank.AMATEUR },
            [6] = { xi.item.WATER_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [7] = { xi.item.LIGHT_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [8] = { xi.item.DARK_CRYSTAL,      50, xi.craftRank.AMATEUR },
        },
    },

    [xi.zone.EAST_SARUTABARUTA] = -- 116
    {
        [diggingLayer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
        },
        [diggingLayer.REGULAR] =
        {
            [ 1] = { xi.item.PEBBLE,                50, xi.craftRank.AMATEUR  },
            [ 2] = { xi.item.PAPAKA_GRASS,          50, xi.craftRank.AMATEUR  },
            [ 3] = { xi.item.LAUAN_LOG,             50, xi.craftRank.AMATEUR  },
            [ 4] = { xi.item.INSECT_WING,           50, xi.craftRank.RECRUIT  },
            [ 5] = { xi.item.YAGUDO_FEATHER,        50, xi.craftRank.RECRUIT  },
            [ 6] = { xi.item.BALL_OF_SARUTA_COTTON, 50, xi.craftRank.RECRUIT  },
            [ 7] = { xi.item.BAG_OF_HERB_SEEDS,     50, xi.craftRank.INITIATE },
            [ 8] = { xi.item.BIRD_FEATHER,          10, xi.craftRank.INITIATE },
            [ 9] = { xi.item.EBONY_LOG,             10, xi.craftRank.INITIATE },
            [10] = { xi.item.ROSEWOOD_LOG,           5, xi.craftRank.NOVICE   },
        },
        [diggingLayer.BURROW] = -- Set: Gysahl Greens
        {
            [1] = { xi.item.BUNCH_OF_GYSAHL_GREENS, 150, xi.craftRank.AMATEUR  },
            [2] = { xi.item.CHAMOMILE,               50, xi.craftRank.AMATEUR  },
            [3] = { xi.item.GINGER_ROOT,             50, xi.craftRank.RECRUIT  },
            [4] = { xi.item.HEAD_OF_NAPA,            50, xi.craftRank.INITIATE },
        },
        [diggingLayer.BORE] = -- Set: Crystals
        {
            [1] = { xi.item.FIRE_CRYSTAL,      50, xi.craftRank.AMATEUR },
            [2] = { xi.item.ICE_CRYSTAL,       50, xi.craftRank.AMATEUR },
            [3] = { xi.item.WIND_CRYSTAL,      50, xi.craftRank.AMATEUR },
            [4] = { xi.item.EARTH_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [5] = { xi.item.LIGHTNING_CRYSTAL, 50, xi.craftRank.AMATEUR },
            [6] = { xi.item.WATER_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [7] = { xi.item.LIGHT_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [8] = { xi.item.DARK_CRYSTAL,      50, xi.craftRank.AMATEUR },
        },
    },

    [xi.zone.TAHRONGI_CANYON] = -- 117
    {
        [diggingLayer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
            [2] = { xi.item.COIN_OF_ADVANCEMENT,  5, xi.craftRank.ADEPT },
        },
        [diggingLayer.REGULAR] =
        {
            [1] = { xi.item.PEBBLE,            50, xi.craftRank.AMATEUR    },
            [2] = { xi.item.BONE_CHIP,         50, xi.craftRank.AMATEUR    },
            [3] = { xi.item.SEASHELL,          50, xi.craftRank.RECRUIT    },
            [4] = { xi.item.CHUNK_OF_TIN_ORE,  50, xi.craftRank.RECRUIT    },
            [5] = { xi.item.GIANT_FEMUR,       50, xi.craftRank.INITIATE   },
            [6] = { xi.item.INSECT_WING,       50, xi.craftRank.INITIATE   },
            [7] = { xi.item.YAGUDO_FEATHER,    50, xi.craftRank.NOVICE     },
            [8] = { xi.item.GOLD_BEASTCOIN,    10, xi.craftRank.APPRENTICE },
            [9] = { xi.item.CHUNK_OF_GOLD_ORE, 10, xi.craftRank.APPRENTICE },
        },
        [diggingLayer.BURROW] = -- Set: Beastcoins
        {
            [1] = { xi.item.BEASTCOIN,          100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.SILVER_BEASTCOIN,    50, xi.craftRank.RECRUIT    },
            [3] = { xi.item.GOLD_BEASTCOIN,      10, xi.craftRank.INITIATE   },
            [4] = { xi.item.MYTHRIL_BEASTCOIN,    5, xi.craftRank.NOVICE     },
            [5] = { xi.item.PLATINUM_BEASTCOIN,   1, xi.craftRank.APPRENTICE },
        },
        [diggingLayer.BORE] = -- Set: Bones
        {
            [ 1] = { xi.item.BONE_CHIP,                150, xi.craftRank.AMATEUR    },
            [ 2] = { xi.item.HANDFUL_OF_FISH_SCALES,   150, xi.craftRank.AMATEUR    },
            [ 3] = { xi.item.SEASHELL,                 150, xi.craftRank.RECRUIT    },
            [ 4] = { xi.item.HIGH_QUALITY_PUGIL_SCALE,  50, xi.craftRank.INITIATE   },
            [ 5] = { xi.item.TITANICTUS_SHELL,          50, xi.craftRank.APPRENTICE },
            [ 6] = { xi.item.DEMON_HORN,                10, xi.craftRank.JOURNEYMAN },
            [ 7] = { xi.item.HANDFUL_OF_WYVERN_SCALES,   5, xi.craftRank.CRAFTSMAN  },
            [ 8] = { xi.item.TURTLE_SHELL,               5, xi.craftRank.CRAFTSMAN  },
            [ 9] = { xi.item.DEMON_SKULL,                1, xi.craftRank.ARTISAN    },
            [10] = { xi.item.HANDFUL_OF_DRAGON_SCALES,   1, xi.craftRank.ARTISAN    },
        },
    },

    [xi.zone.BUBURIMU_PENINSULA] = -- 118
    {
        [diggingLayer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
            [2] = { xi.item.COIN_OF_BIRTH,        5, xi.craftRank.ADEPT },
            [3] = { xi.item.ORDELLE_BRONZEPIECE,  5, xi.craftRank.ADEPT },
            [4] = { xi.item.ONE_BYNE_BILL,        5, xi.craftRank.ADEPT },
            [5] = { xi.item.TUKUKU_WHITESHELL,    5, xi.craftRank.ADEPT },
        },
        [diggingLayer.REGULAR] =
        {
            [1] = { xi.item.LUGWORM,               100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.SHELL_BUG,             100, xi.craftRank.AMATEUR    },
            [3] = { xi.item.SEASHELL,              100, xi.craftRank.AMATEUR    },
            [4] = { xi.item.SHALL_SHELL,            50, xi.craftRank.RECRUIT    },
            [5] = { xi.item.BIRD_FEATHER,           50, xi.craftRank.RECRUIT    },
            [6] = { xi.item.CHUNK_OF_TIN_ORE,       10, xi.craftRank.INITIATE   },
            [7] = { xi.item.GIANT_FEMUR,            10, xi.craftRank.INITIATE   },
            [8] = { xi.item.CHUNK_OF_PLATINUM_ORE,   5, xi.craftRank.APPRENTICE },
            [9] = { xi.item.CORAL_FRAGMENT,          5, xi.craftRank.CRAFTSMAN  },
        },
        [diggingLayer.BURROW] = -- Set: Feathers
        {
            [1] = { xi.item.CLUMP_OF_RED_MOKO_GRASS, 100, xi.craftRank.AMATEUR   },
            [2] = { xi.item.BLACK_CHOCOBO_FEATHER,    50, xi.craftRank.RECRUIT   },
            [4] = { xi.item.GIANT_BIRD_PLUME,         10, xi.craftRank.INITIATE  },
            [3] = { xi.item.SPIDER_WEB,                5, xi.craftRank.NOVICE    },
            [5] = { xi.item.PHOENIX_FEATHER,           1, xi.craftRank.CRAFTSMAN },
        },
        [diggingLayer.BORE] = -- Set: Bones
        {
            [ 1] = { xi.item.BONE_CHIP,                150, xi.craftRank.AMATEUR    },
            [ 2] = { xi.item.HANDFUL_OF_FISH_SCALES,   150, xi.craftRank.AMATEUR    },
            [ 3] = { xi.item.SEASHELL,                 150, xi.craftRank.RECRUIT    },
            [ 4] = { xi.item.HIGH_QUALITY_PUGIL_SCALE,  50, xi.craftRank.INITIATE   },
            [ 5] = { xi.item.TITANICTUS_SHELL,          50, xi.craftRank.APPRENTICE },
            [ 6] = { xi.item.DEMON_HORN,                10, xi.craftRank.JOURNEYMAN },
            [ 7] = { xi.item.HANDFUL_OF_WYVERN_SCALES,   5, xi.craftRank.CRAFTSMAN  },
            [ 8] = { xi.item.TURTLE_SHELL,               5, xi.craftRank.CRAFTSMAN  },
            [ 9] = { xi.item.DEMON_SKULL,                1, xi.craftRank.ARTISAN    },
            [10] = { xi.item.HANDFUL_OF_DRAGON_SCALES,   1, xi.craftRank.ARTISAN    },
        },
    },

    [xi.zone.MERIPHATAUD_MOUNTAINS] = -- 119
    {
        [diggingLayer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
            [2] = { xi.item.COIN_OF_ADVANCEMENT,  5, xi.craftRank.ADEPT },
        },
        [diggingLayer.REGULAR] =
        {
            [1] = { xi.item.FLINT_STONE,           240, xi.craftRank.AMATEUR    },
            [2] = { xi.item.PEBBLE,                100, xi.craftRank.AMATEUR    },
            [3] = { xi.item.CHUNK_OF_COPPER_ORE,    50, xi.craftRank.RECRUIT    },
            [4] = { xi.item.GIANT_FEMUR,            50, xi.craftRank.RECRUIT    },
            [5] = { xi.item.LIZARD_MOLT,            50, xi.craftRank.INITIATE   },
            [6] = { xi.item.BLACK_CHOCOBO_FEATHER,  10, xi.craftRank.NOVICE     },
            [7] = { xi.item.GOLD_BEASTCOIN,         10, xi.craftRank.APPRENTICE },
            [8] = { xi.item.CHUNK_OF_ADAMAN_ORE,     5, xi.craftRank.JOURNEYMAN },
        },
        [diggingLayer.BURROW] = -- Set: Ores 4
        {
            [1] = { xi.item.CHUNK_OF_SILVER_ORE,       100, xi.craftRank.AMATEUR },
            [2] = { xi.item.CHUNK_OF_IRON_ORE,         100, xi.craftRank.RECRUIT },
            [3] = { xi.item.CHUNK_OF_KOPPARNICKEL_ORE, 100, xi.craftRank.RECRUIT },
            [4] = { xi.item.CHUNK_OF_MYTHRIL_ORE,      100, xi.craftRank.RECRUIT },
            [5] = { xi.item.CHUNK_OF_DARKSTEEL_ORE,     10, xi.craftRank.NOVICE  },
        },
        [diggingLayer.BORE] = -- Set: Ores 1
        {
            [1] = { xi.item.FLINT_STONE,             240, xi.craftRank.AMATEUR    },
            [2] = { xi.item.CHUNK_OF_ALUMINUM_ORE,   100, xi.craftRank.RECRUIT    },
            [3] = { xi.item.CHUNK_OF_GOLD_ORE,        50, xi.craftRank.INITIATE   },
            [4] = { xi.item.CHUNK_OF_DARKSTEEL_ORE,   10, xi.craftRank.NOVICE     },
            [5] = { xi.item.CHUNK_OF_ADAMAN_ORE,       5, xi.craftRank.JOURNEYMAN },
            [6] = { xi.item.CHUNK_OF_PLATINUM_ORE,     5, xi.craftRank.JOURNEYMAN },
            [7] = { xi.item.CHUNK_OF_ORICHALCUM_ORE,   1, xi.craftRank.CRAFTSMAN  },
        },
    },

    [xi.zone.SAUROMUGUE_CHAMPAIGN] = -- 120
    {
        [diggingLayer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
            [2] = { xi.item.COIN_OF_GLORY,        5, xi.craftRank.ADEPT },
        },
        [diggingLayer.REGULAR] =
        {
            [1] = { xi.item.FLINT_STONE,           240, xi.craftRank.AMATEUR    },
            [2] = { xi.item.PEBBLE,                100, xi.craftRank.AMATEUR    },
            [3] = { xi.item.BONE_CHIP,             100, xi.craftRank.AMATEUR    },
            [4] = { xi.item.INSECT_WING,            50, xi.craftRank.RECRUIT    },
            [5] = { xi.item.LIZARD_MOLT,            50, xi.craftRank.RECRUIT    },
            [6] = { xi.item.CHUNK_OF_IRON_ORE,      50, xi.craftRank.INITIATE   },
            [7] = { xi.item.BLACK_CHOCOBO_FEATHER,  10, xi.craftRank.NOVICE     },
            [8] = { xi.item.RED_JAR,                10, xi.craftRank.NOVICE     },
            [9] = { xi.item.GOLD_BEASTCOIN,          5, xi.craftRank.APPRENTICE },
        },
        [diggingLayer.BURROW] = -- Set: Beastcoins
        {
            [1] = { xi.item.BEASTCOIN,          100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.SILVER_BEASTCOIN,    50, xi.craftRank.RECRUIT    },
            [3] = { xi.item.GOLD_BEASTCOIN,      10, xi.craftRank.INITIATE   },
            [4] = { xi.item.MYTHRIL_BEASTCOIN,    5, xi.craftRank.NOVICE     },
            [5] = { xi.item.PLATINUM_BEASTCOIN,   1, xi.craftRank.APPRENTICE },
        },
        [diggingLayer.BORE] = -- Set: Bones
        {
            [ 1] = { xi.item.BONE_CHIP,                150, xi.craftRank.AMATEUR    },
            [ 2] = { xi.item.HANDFUL_OF_FISH_SCALES,   150, xi.craftRank.AMATEUR    },
            [ 3] = { xi.item.SEASHELL,                 150, xi.craftRank.RECRUIT    },
            [ 4] = { xi.item.HIGH_QUALITY_PUGIL_SCALE,  50, xi.craftRank.INITIATE   },
            [ 5] = { xi.item.TITANICTUS_SHELL,          50, xi.craftRank.APPRENTICE },
            [ 6] = { xi.item.DEMON_HORN,                10, xi.craftRank.JOURNEYMAN },
            [ 7] = { xi.item.HANDFUL_OF_WYVERN_SCALES,   5, xi.craftRank.CRAFTSMAN  },
            [ 8] = { xi.item.TURTLE_SHELL,               5, xi.craftRank.CRAFTSMAN  },
            [ 9] = { xi.item.DEMON_SKULL,                1, xi.craftRank.ARTISAN    },
            [10] = { xi.item.HANDFUL_OF_DRAGON_SCALES,   1, xi.craftRank.ARTISAN    },
        },
    },

    [xi.zone.THE_SANCTUARY_OF_ZITAH] = -- 121
    {
        [diggingLayer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
            [2] = { xi.item.COIN_OF_DECAY,        5, xi.craftRank.ADEPT },
        },
        [diggingLayer.REGULAR] =
        {
            [1] = { xi.item.PEBBLE,              100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.CLUMP_OF_MOKO_GRASS, 100, xi.craftRank.AMATEUR    },
            [3] = { xi.item.BONE_CHIP,           100, xi.craftRank.AMATEUR    },
            [4] = { xi.item.ARROWWOOD_LOG,        50, xi.craftRank.RECRUIT    },
            [5] = { xi.item.YEW_LOG,              50, xi.craftRank.RECRUIT    },
            [6] = { xi.item.ELM_LOG,              50, xi.craftRank.INITIATE   },
            [7] = { xi.item.KING_TRUFFLE,          5, xi.craftRank.NOVICE     },
            [8] = { xi.item.PETRIFIED_LOG,         5, xi.craftRank.APPRENTICE },
        },
        [diggingLayer.BURROW] = -- Set: Beastcoins
        {
            [1] = { xi.item.BEASTCOIN,          100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.SILVER_BEASTCOIN,    50, xi.craftRank.RECRUIT    },
            [3] = { xi.item.GOLD_BEASTCOIN,      10, xi.craftRank.INITIATE   },
            [4] = { xi.item.MYTHRIL_BEASTCOIN,    5, xi.craftRank.NOVICE     },
            [5] = { xi.item.PLATINUM_BEASTCOIN,   1, xi.craftRank.APPRENTICE },
        },
        [diggingLayer.BORE] = -- Set: Logs 1
        {
            [1] = { xi.item.ARROWWOOD_LOG,           240, xi.craftRank.AMATEUR    },
            [2] = { xi.item.YEW_LOG,                 150, xi.craftRank.AMATEUR    },
            [3] = { xi.item.ELM_LOG,                 100, xi.craftRank.RECRUIT    },
            [4] = { xi.item.OAK_LOG,                  50, xi.craftRank.INITIATE   },
            [5] = { xi.item.ROSEWOOD_LOG,             10, xi.craftRank.NOVICE     },
            [6] = { xi.item.MAHOGANY_LOG,              5, xi.craftRank.APPRENTICE },
            [7] = { xi.item.EBONY_LOG,                 5, xi.craftRank.JOURNEYMAN },
            [8] = { xi.item.PIECE_OF_ANCIENT_LUMBER,   1, xi.craftRank.CRAFTSMAN  },
            [9] = { xi.item.LACQUER_TREE_LOG,          1, xi.craftRank.ARTISAN    },
        },
    },

    [xi.zone.YUHTUNGA_JUNGLE] = -- 123
    {
        [diggingLayer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
        },
        [diggingLayer.REGULAR] =
        {
            [1] = { xi.item.BONE_CHIP,              100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.DANCESHROOM,            100, xi.craftRank.AMATEUR    },
            [3] = { xi.item.STICK_OF_CINNAMON,       50, xi.craftRank.RECRUIT    },
            [4] = { xi.item.PIECE_OF_RATTAN_LUMBER,  50, xi.craftRank.RECRUIT    },
            [5] = { xi.item.ROSEWOOD_LOG,            50, xi.craftRank.INITIATE   },
            [6] = { xi.item.PUFFBALL,                50, xi.craftRank.INITIATE   },
            [7] = { xi.item.PETRIFIED_LOG,           10, xi.craftRank.NOVICE     },
            [8] = { xi.item.KING_TRUFFLE,            10, xi.craftRank.NOVICE     },
            [9] = { xi.item.EBONY_LOG,                5, xi.craftRank.JOURNEYMAN },
        },
        [diggingLayer.BURROW] = -- Set: Shrooms
        {
            [1] = { xi.item.DEATHBALL,       100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.SLEEPSHROOM,     100, xi.craftRank.AMATEUR    },
            [3] = { xi.item.CORAL_FUNGUS,     50, xi.craftRank.RECRUIT    },
            [4] = { xi.item.WOOZYSHROOM,      10, xi.craftRank.INITIATE   },
            [5] = { xi.item.PUFFBALL,         10, xi.craftRank.NOVICE     },
            [6] = { xi.item.DANCESHROOM,       5, xi.craftRank.APPRENTICE },
            [7] = { xi.item.REISHI_MUSHROOM,   1, xi.craftRank.JOURNEYMAN },
            [8] = { xi.item.KING_TRUFFLE,      1, xi.craftRank.CRAFTSMAN  },
        },
        [diggingLayer.BORE] = -- Set: Logs 1
        {
            [1] = { xi.item.ARROWWOOD_LOG,           240, xi.craftRank.AMATEUR    },
            [2] = { xi.item.YEW_LOG,                 150, xi.craftRank.AMATEUR    },
            [3] = { xi.item.ELM_LOG,                 100, xi.craftRank.RECRUIT    },
            [4] = { xi.item.OAK_LOG,                  50, xi.craftRank.INITIATE   },
            [5] = { xi.item.ROSEWOOD_LOG,             10, xi.craftRank.NOVICE     },
            [6] = { xi.item.MAHOGANY_LOG,              5, xi.craftRank.APPRENTICE },
            [7] = { xi.item.EBONY_LOG,                 5, xi.craftRank.JOURNEYMAN },
            [8] = { xi.item.PIECE_OF_ANCIENT_LUMBER,   1, xi.craftRank.CRAFTSMAN  },
            [9] = { xi.item.LACQUER_TREE_LOG,          1, xi.craftRank.ARTISAN    },
        },
    },

    [xi.zone.YHOATOR_JUNGLE] = -- 124
    {
        [diggingLayer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
        },
        [diggingLayer.REGULAR] =
        {
            [1] = { xi.item.BONE_CHIP,        100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.KAZHAM_PINEAPPLE,  50, xi.craftRank.AMATEUR    },
            [3] = { xi.item.LAUAN_LOG,         50, xi.craftRank.AMATEUR    },
            [4] = { xi.item.MAHOGANY_LOG,      50, xi.craftRank.RECRUIT    },
            [5] = { xi.item.DRYAD_ROOT,        50, xi.craftRank.RECRUIT    },
            [6] = { xi.item.REISHI_MUSHROOM,   10, xi.craftRank.RECRUIT    },
            [7] = { xi.item.CORAL_FUNGUS,      10, xi.craftRank.NOVICE     },
            [8] = { xi.item.EBONY_LOG,          5, xi.craftRank.JOURNEYMAN },
        },
        [diggingLayer.BURROW] = -- Set: Shrooms
        {
            [1] = { xi.item.DEATHBALL,       100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.SLEEPSHROOM,     100, xi.craftRank.AMATEUR    },
            [3] = { xi.item.CORAL_FUNGUS,     50, xi.craftRank.RECRUIT    },
            [4] = { xi.item.WOOZYSHROOM,      10, xi.craftRank.INITIATE   },
            [5] = { xi.item.PUFFBALL,         10, xi.craftRank.NOVICE     },
            [6] = { xi.item.DANCESHROOM,       5, xi.craftRank.APPRENTICE },
            [7] = { xi.item.REISHI_MUSHROOM,   1, xi.craftRank.JOURNEYMAN },
            [8] = { xi.item.KING_TRUFFLE,      1, xi.craftRank.CRAFTSMAN  },
        },
        [diggingLayer.BORE] = -- Set: Logs 1
        {
            [1] = { xi.item.ARROWWOOD_LOG,           240, xi.craftRank.AMATEUR    },
            [2] = { xi.item.YEW_LOG,                 150, xi.craftRank.AMATEUR    },
            [3] = { xi.item.ELM_LOG,                 100, xi.craftRank.RECRUIT    },
            [4] = { xi.item.OAK_LOG,                  50, xi.craftRank.INITIATE   },
            [5] = { xi.item.ROSEWOOD_LOG,             10, xi.craftRank.NOVICE     },
            [6] = { xi.item.MAHOGANY_LOG,              5, xi.craftRank.APPRENTICE },
            [7] = { xi.item.EBONY_LOG,                 5, xi.craftRank.JOURNEYMAN },
            [8] = { xi.item.PIECE_OF_ANCIENT_LUMBER,   1, xi.craftRank.CRAFTSMAN  },
            [9] = { xi.item.LACQUER_TREE_LOG,          1, xi.craftRank.ARTISAN    },
        },
    },

    [xi.zone.WESTERN_ALTEPA_DESERT] = -- 125
    {
        [diggingLayer.TREASURE] =
        {
            [1] = { xi.item.PLATE_OF_HEAVY_METAL, 5, xi.craftRank.ADEPT },
        },
        [diggingLayer.REGULAR] =
        {
            [1] = { xi.item.BONE_CHIP,              240, xi.craftRank.AMATEUR    },
            [2] = { xi.item.PEBBLE,                 150, xi.craftRank.AMATEUR    },
            [3] = { xi.item.CHUNK_OF_ZINC_ORE,      100, xi.craftRank.RECRUIT    },
            [4] = { xi.item.GIANT_FEMUR,            100, xi.craftRank.RECRUIT    },
            [5] = { xi.item.CHUNK_OF_IRON_ORE,       50, xi.craftRank.INITIATE   },
            [6] = { xi.item.CHUNK_OF_DARKSTEEL_ORE,  10, xi.craftRank.NOVICE     },
            [7] = { xi.item.CHUNK_OF_GOLD_ORE,       10, xi.craftRank.NOVICE     },
            [8] = { xi.item.CORAL_FRAGMENT,           5, xi.craftRank.APPRENTICE },
            [9] = { xi.item.PHILOSOPHERS_STONE,       5, xi.craftRank.APPRENTICE },
        },
        [diggingLayer.BURROW] = -- Set: Feathers
        {
            [1] = { xi.item.CLUMP_OF_RED_MOKO_GRASS, 100, xi.craftRank.AMATEUR   },
            [2] = { xi.item.BLACK_CHOCOBO_FEATHER,    50, xi.craftRank.RECRUIT   },
            [4] = { xi.item.GIANT_BIRD_PLUME,         10, xi.craftRank.INITIATE  },
            [3] = { xi.item.SPIDER_WEB,                5, xi.craftRank.NOVICE    },
            [5] = { xi.item.PHOENIX_FEATHER,           1, xi.craftRank.CRAFTSMAN },
        },
        [diggingLayer.BORE] = -- Set: Bones
        {
            [ 1] = { xi.item.BONE_CHIP,                150, xi.craftRank.AMATEUR    },
            [ 2] = { xi.item.HANDFUL_OF_FISH_SCALES,   150, xi.craftRank.AMATEUR    },
            [ 3] = { xi.item.SEASHELL,                 150, xi.craftRank.RECRUIT    },
            [ 4] = { xi.item.HIGH_QUALITY_PUGIL_SCALE,  50, xi.craftRank.INITIATE   },
            [ 5] = { xi.item.TITANICTUS_SHELL,          50, xi.craftRank.APPRENTICE },
            [ 6] = { xi.item.DEMON_HORN,                10, xi.craftRank.JOURNEYMAN },
            [ 7] = { xi.item.HANDFUL_OF_WYVERN_SCALES,   5, xi.craftRank.CRAFTSMAN  },
            [ 8] = { xi.item.TURTLE_SHELL,               5, xi.craftRank.CRAFTSMAN  },
            [ 9] = { xi.item.DEMON_SKULL,                1, xi.craftRank.ARTISAN    },
            [10] = { xi.item.HANDFUL_OF_DRAGON_SCALES,   1, xi.craftRank.ARTISAN    },
        },
    },

    [xi.zone.QUFIM_ISLAND] = -- 126
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries.
        },
        [diggingLayer.REGULAR] =
        {
            -- No entries.
        },
        [diggingLayer.BURROW] = -- Set: Beastcoins
        {
            [1] = { xi.item.BEASTCOIN,          100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.SILVER_BEASTCOIN,    50, xi.craftRank.RECRUIT    },
            [3] = { xi.item.GOLD_BEASTCOIN,      10, xi.craftRank.INITIATE   },
            [4] = { xi.item.MYTHRIL_BEASTCOIN,    5, xi.craftRank.NOVICE     },
            [5] = { xi.item.PLATINUM_BEASTCOIN,   1, xi.craftRank.APPRENTICE },
        },
        [diggingLayer.BORE] = -- Set: Crystals
        {
            [1] = { xi.item.FIRE_CRYSTAL,      50, xi.craftRank.AMATEUR },
            [2] = { xi.item.ICE_CRYSTAL,       50, xi.craftRank.AMATEUR },
            [3] = { xi.item.WIND_CRYSTAL,      50, xi.craftRank.AMATEUR },
            [4] = { xi.item.EARTH_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [5] = { xi.item.LIGHTNING_CRYSTAL, 50, xi.craftRank.AMATEUR },
            [6] = { xi.item.WATER_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [7] = { xi.item.LIGHT_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [8] = { xi.item.DARK_CRYSTAL,      50, xi.craftRank.AMATEUR },
        },
    },

    [xi.zone.BEHEMOTHS_DOMINION] = -- 127
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries.
        },
        [diggingLayer.REGULAR] =
        {
            -- No entries.
        },
        [diggingLayer.BURROW] = -- Set: Yellow Ginseng seeds
        {
            [1] = { xi.item.PIECE_OF_YELLOW_GINSENG, 150, xi.craftRank.AMATEUR  },
            [2] = { xi.item.BAG_OF_WILDGRASS_SEEDS,   50, xi.craftRank.RECRUIT  },
            [3] = { xi.item.BAG_OF_TREE_CUTTINGS,     10, xi.craftRank.INITIATE },
            [4] = { xi.item.BAG_OF_CACTUS_STEMS,       5, xi.craftRank.NOVICE   },
        },
        [diggingLayer.BORE] = -- Set: Ores 1
        {
            [1] = { xi.item.FLINT_STONE,             240, xi.craftRank.AMATEUR    },
            [2] = { xi.item.CHUNK_OF_ALUMINUM_ORE,   100, xi.craftRank.RECRUIT    },
            [3] = { xi.item.CHUNK_OF_GOLD_ORE,        50, xi.craftRank.INITIATE   },
            [4] = { xi.item.CHUNK_OF_DARKSTEEL_ORE,   10, xi.craftRank.NOVICE     },
            [5] = { xi.item.CHUNK_OF_ADAMAN_ORE,       5, xi.craftRank.JOURNEYMAN },
            [6] = { xi.item.CHUNK_OF_PLATINUM_ORE,     5, xi.craftRank.JOURNEYMAN },
            [7] = { xi.item.CHUNK_OF_ORICHALCUM_ORE,   1, xi.craftRank.CRAFTSMAN  },
        },
    },

    [xi.zone.VALLEY_OF_SORROWS] = -- 128
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries.
        },
        [diggingLayer.REGULAR] =
        {
            -- No entries.
        },
        [diggingLayer.BURROW] = -- Set: Feathers
        {
            [1] = { xi.item.CLUMP_OF_RED_MOKO_GRASS, 100, xi.craftRank.AMATEUR   },
            [2] = { xi.item.BLACK_CHOCOBO_FEATHER,    50, xi.craftRank.RECRUIT   },
            [4] = { xi.item.GIANT_BIRD_PLUME,         10, xi.craftRank.INITIATE  },
            [3] = { xi.item.SPIDER_WEB,                5, xi.craftRank.NOVICE    },
            [5] = { xi.item.PHOENIX_FEATHER,           1, xi.craftRank.CRAFTSMAN },
        },
        [diggingLayer.BORE] =
        {
            -- No entries.
        },
    },

    [xi.zone.BEAUCEDINE_GLACIER_S] = -- 136
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries.
        },
        [diggingLayer.REGULAR] =
        {
            -- No entries.
        },
        [diggingLayer.BURROW] = -- Set Ores 3
        {
            [1] = { xi.item.FLINT_STONE,               240, xi.craftRank.AMATEUR },
            [2] = { xi.item.CHUNK_OF_SILVER_ORE,       100, xi.craftRank.AMATEUR },
            [3] = { xi.item.CHUNK_OF_IRON_ORE,         100, xi.craftRank.RECRUIT },
            [4] = { xi.item.SHARD_OF_OBSIDIAN,         100, xi.craftRank.RECRUIT },
            [5] = { xi.item.CHUNK_OF_KOPPARNICKEL_ORE, 100, xi.craftRank.RECRUIT },
            [6] = { xi.item.CHUNK_OF_MYTHRIL_ORE,      100, xi.craftRank.RECRUIT },
            [7] = { xi.item.CHUNK_OF_DARKSTEEL_ORE,     10, xi.craftRank.NOVICE  },
            [8] = { xi.item.CHUNK_OF_SWAMP_ORE,         10, xi.craftRank.NOVICE  },
        },
        [diggingLayer.BORE] = -- Set: Crystals
        {
            [1] = { xi.item.FIRE_CRYSTAL,      50, xi.craftRank.AMATEUR },
            [2] = { xi.item.ICE_CRYSTAL,       50, xi.craftRank.AMATEUR },
            [3] = { xi.item.WIND_CRYSTAL,      50, xi.craftRank.AMATEUR },
            [4] = { xi.item.EARTH_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [5] = { xi.item.LIGHTNING_CRYSTAL, 50, xi.craftRank.AMATEUR },
            [6] = { xi.item.WATER_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [7] = { xi.item.LIGHT_CRYSTAL,     50, xi.craftRank.AMATEUR },
            [8] = { xi.item.DARK_CRYSTAL,      50, xi.craftRank.AMATEUR },
        },
    },

    [xi.zone.XARCABARD_S] = -- 137
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries.
        },
        [diggingLayer.REGULAR] =
        {
            -- No entries.
        },
        [diggingLayer.BURROW] = -- Set: Beastcoins
        {
            [1] = { xi.item.BEASTCOIN,          100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.SILVER_BEASTCOIN,    50, xi.craftRank.RECRUIT    },
            [3] = { xi.item.GOLD_BEASTCOIN,      10, xi.craftRank.INITIATE   },
            [4] = { xi.item.MYTHRIL_BEASTCOIN,    5, xi.craftRank.NOVICE     },
            [5] = { xi.item.PLATINUM_BEASTCOIN,   1, xi.craftRank.APPRENTICE },
        },
        [diggingLayer.BORE] = -- Set: Logs 4
        {
            [1] = { xi.item.ARROWWOOD_LOG,           240, xi.craftRank.AMATEUR   },
            [2] = { xi.item.YEW_LOG,                 150, xi.craftRank.AMATEUR   },
            [3] = { xi.item.ELM_LOG,                 100, xi.craftRank.RECRUIT   },
            [4] = { xi.item.FEYWEALD_LOG,             50, xi.craftRank.INITIATE  },
            [5] = { xi.item.OAK_LOG,                  50, xi.craftRank.INITIATE  },
            [6] = { xi.item.TEAK_LOG,                  1, xi.craftRank.CRAFTSMAN },
            [7] = { xi.item.PIECE_OF_ANCIENT_LUMBER,   1, xi.craftRank.CRAFTSMAN },
            [8] = { xi.item.JACARANDA_LOG,             1, xi.craftRank.ARTISAN   },
            [9] = { xi.item.LACQUER_TREE_LOG,          1, xi.craftRank.ARTISAN   },
        },
    },

    [xi.zone.YAHSE_HUNTING_GROUNDS] = -- 260
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries.
        },
        [diggingLayer.REGULAR] =
        {
            -- No entries.
        },
        [diggingLayer.BURROW] =
        {
            -- No entries.
        },
        [diggingLayer.BORE] =
        {
            -- No entries.
        },
    },

    [xi.zone.CEIZAK_BATTLEGROUNDS] = -- 261
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries.
        },
        [diggingLayer.REGULAR] =
        {
            -- No entries.
        },
        [diggingLayer.BURROW] =
        {
            -- No entries.
        },
        [diggingLayer.BORE] =
        {
            -- No entries.
        },
    },

    [xi.zone.FORET_DE_HENNETIEL] = -- 262
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries.
        },
        [diggingLayer.REGULAR] =
        {
            -- No entries.
        },
        [diggingLayer.BURROW] = -- Set: Shrooms
        {
            [1] = { xi.item.DEATHBALL,       100, xi.craftRank.AMATEUR    },
            [2] = { xi.item.SLEEPSHROOM,     100, xi.craftRank.AMATEUR    },
            [3] = { xi.item.CORAL_FUNGUS,     50, xi.craftRank.RECRUIT    },
            [4] = { xi.item.WOOZYSHROOM,      10, xi.craftRank.INITIATE   },
            [5] = { xi.item.PUFFBALL,         10, xi.craftRank.NOVICE     },
            [6] = { xi.item.DANCESHROOM,       5, xi.craftRank.APPRENTICE },
            [7] = { xi.item.REISHI_MUSHROOM,   1, xi.craftRank.JOURNEYMAN },
            [8] = { xi.item.KING_TRUFFLE,      1, xi.craftRank.CRAFTSMAN  },
        },
        [diggingLayer.BORE] = -- Set: Ores 1
        {
            [1] = { xi.item.FLINT_STONE,            240, xi.craftRank.AMATEUR    },
            [2] = { xi.item.CHUNK_OF_ALUMINUM_ORE,  100, xi.craftRank.RECRUIT    },
            [3] = { xi.item.CHUNK_OF_GOLD_ORE,       50, xi.craftRank.INITIATE   },
            [4] = { xi.item.CHUNK_OF_DARKSTEEL_ORE,  10, xi.craftRank.NOVICE     },
            [5] = { xi.item.CHUNK_OF_ADAMAN_ORE,      5, xi.craftRank.JOURNEYMAN },
            [6] = { xi.item.CHUNK_OF_PLATINUM_ORE,    5, xi.craftRank.JOURNEYMAN },
            [7] = { xi.item.CHUNK_OF_ORICHALCUM_ORE,  1, xi.craftRank.CRAFTSMAN  },
        },
    },

    [xi.zone.YORCIA_WEALD] = -- 263
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries.
        },
        [diggingLayer.REGULAR] =
        {
            -- No entries.
        },
        [diggingLayer.BURROW] =
        {
            -- No entries.
        },
        [diggingLayer.BORE] = -- Set: Yellow Ginseng seeds
        {
            [1] = { xi.item.PIECE_OF_YELLOW_GINSENG, 150, xi.craftRank.AMATEUR  },
            [2] = { xi.item.BAG_OF_WILDGRASS_SEEDS,   50, xi.craftRank.RECRUIT  },
            [3] = { xi.item.BAG_OF_TREE_CUTTINGS,     10, xi.craftRank.INITIATE },
            [4] = { xi.item.BAG_OF_CACTUS_STEMS,       5, xi.craftRank.NOVICE   },
        },
    },

    [xi.zone.MORIMAR_BASALT_FIELDS] = -- 265
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries.
        },
        [diggingLayer.REGULAR] =
        {
            -- No entries.
        },
        [diggingLayer.BURROW] = -- Set: Yellow Ginseng seeds
        {
            [1] = { xi.item.PIECE_OF_YELLOW_GINSENG, 150, xi.craftRank.AMATEUR  },
            [2] = { xi.item.BAG_OF_WILDGRASS_SEEDS,   50, xi.craftRank.RECRUIT  },
            [3] = { xi.item.BAG_OF_TREE_CUTTINGS,     10, xi.craftRank.INITIATE },
            [4] = { xi.item.BAG_OF_CACTUS_STEMS,       5, xi.craftRank.NOVICE   },
        },
        [diggingLayer.BORE] =
        {
            -- No entries.
        },
    },

    [xi.zone.MARJAMI_RAVINE] = -- 266
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries.
        },
        [diggingLayer.REGULAR] =
        {
            -- No entries.
        },
        [diggingLayer.BURROW] =
        {
            -- No entries.
        },
        [diggingLayer.BORE] =
        {
            -- No entries.
        },
    },

    [xi.zone.KAMIHR_DRIFTS] = -- 267
    {
        [diggingLayer.TREASURE] =
        {
            -- No entries.
        },
        [diggingLayer.REGULAR] =
        {
            -- No entries.
        },
        [diggingLayer.BURROW] = -- Set: Logs 1
        {
            [1] = { xi.item.ARROWWOOD_LOG,           240, xi.craftRank.AMATEUR    },
            [2] = { xi.item.YEW_LOG,                 150, xi.craftRank.AMATEUR    },
            [3] = { xi.item.ELM_LOG,                 100, xi.craftRank.RECRUIT    },
            [4] = { xi.item.OAK_LOG,                  50, xi.craftRank.INITIATE   },
            [5] = { xi.item.ROSEWOOD_LOG,             10, xi.craftRank.NOVICE     },
            [6] = { xi.item.MAHOGANY_LOG,              5, xi.craftRank.APPRENTICE },
            [7] = { xi.item.EBONY_LOG,                 5, xi.craftRank.JOURNEYMAN },
            [8] = { xi.item.PIECE_OF_ANCIENT_LUMBER,   1, xi.craftRank.CRAFTSMAN  },
            [9] = { xi.item.LACQUER_TREE_LOG,          1, xi.craftRank.ARTISAN    },
        },
        [diggingLayer.BORE] =
        {
            -- No entries.
        },
    },
}

-- This function handles zone and cooldown checks before digging can be attempted, before any animation is sent.
local function checkDiggingCooldowns(player)
    -- Check if current zone has digging enabled.
    local isAllowedZone = diggingZoneList[player:getZoneID()] or false

    if not isAllowedZone then
        player:messageBasic(xi.msg.basic.WAIT_LONGER, 0, 0)

        return false
    end

    -- Check digging cooldowns.
    local currentTime  = os.time()
    local skillRank    = player:getSkillRank(xi.skill.DIG)
    local zoneCooldown = player:getLocalVar('ZoneInTime') + utils.clamp(60 - skillRank * 5, 10, 60)
    local digCooldown  = player:getLocalVar('[DIG]LastDigTime') + utils.clamp(15 - skillRank * 5, 3, 16)

    if
        currentTime < zoneCooldown or
        currentTime < digCooldown
    then
        player:messageBasic(xi.msg.basic.WAIT_LONGER, 0, 0)

        return false
    end

    return true
end

local function calculateSkillUp(player)
    local skillRank = player:getSkillRank(xi.skill.DIG)
    local maxSkill  = utils.clamp((skillRank + 1) * 100, 0, 1000)
    local realSkill = player:getCharSkillLevel(xi.skill.DIG)
    local increment = 1

    -- this probably needs correcting
    local roll = math.random(1, 100)

    -- make sure our skill isn't capped
    if realSkill < maxSkill then
        -- can we skill up?
        if roll <= 15 then
            if (increment + realSkill) > maxSkill then
                increment = maxSkill - realSkill
            end

            -- skill up!
            player:setSkillLevel(xi.skill.DIG, realSkill + increment)

            -- update the skill rank
            -- Digging does not have test items, so increment rank once player hits 10.0, 20.0, .. 100.0
            if (realSkill + increment) >= (skillRank * 100) + 100 then
                player:setSkillRank(xi.skill.DIG, skillRank + 1)
            end
        end
    end
end

local function  handleDiggingLayer(player, zoneId, currentLayer)
    local digTable = digInfo[zoneId][currentLayer]

    -- Early return.
    if
        not digTable or
        #digTable <= 0
    then
        return 0
    end

    local dTableItemIds  = {}
    local rewardItem     = 0
    local rollMultiplier = 1 -- Determined by moon and certain gear. Higher = WORSE

    -- Determine moon multiplier.
    local moon = VanadielMoonPhase()

    if moon >= 40 and moon <= 60 then
        rollMultiplier = rollMultiplier * 2
    end

    -- TODO: Implement pants that lower common item chance and raise rare item chance.

    -- Add valid items to dynamic table
    local playerRank = player:getSkillRank(xi.skill.DIG)
    local randomRoll = 1000

    for i = 1, #digTable do
        randomRoll = utils.clamp(math.floor(math.random(1, 1000) * rollMultiplier), 1, 1000)

        if
            randomRoll <= digTable[i][2] and -- Roll check
            playerRank >= digTable[i][3]     -- Rank check
        then
            table.insert(dTableItemIds, #dTableItemIds + 1, digTable[i][1]) -- Insert item ID to table.
        end
    end

    -- Add weather crystals and ores to regular layer only.
    if currentLayer == diggingLayer.REGULAR then
        local weather            = player:getWeather()
        local currentDay         = VanadielDayOfTheWeek()
        local isElementalOreZone = elementalOreZoneTable[player:getZoneID()] or false

        -- Crystals and Clusters.
        if diggingWeatherTable[weather] then
            table.insert(dTableItemIds, #dTableItemIds + 1, diggingWeatherTable[weather][1]) -- Insert item ID to table.
        end

        -- Geodes / Colored Rocks.
        if
            diggingDayTable[currentDay] and
            playerRank >= xi.craftRank.NOVICE
        then
            table.insert(dTableItemIds, #dTableItemIds + 1, diggingDayTable[currentDay][1]) -- Insert item ID to table.
        end

        -- Elemenal Ores.
        if
            diggingDayTable[currentDay] and
            playerRank >= xi.craftRank.CRAFTSMAN and
            isElementalOreZone and
            weather ~= xi.weather.NONE and
            moon >= 7 and moon <= 21
        then
            table.insert(dTableItemIds, #dTableItemIds + 1, diggingDayTable[currentDay][2]) -- Insert item ID to table.
        end
    end

    -- Choose a random entry from the valid item table.
    if #dTableItemIds > 0 then
        local chosenItem = math.random(1, #dTableItemIds)

        rewardItem = dTableItemIds[chosenItem]
    end

    return rewardItem
end

local function handleItemObtained(player, text, itemId)
    if itemId > 0 then
        -- Make sure we have enough room for the item.
        if player:addItem(itemId) then
            player:messageSpecial(text.ITEM_OBTAINED, itemId)
        else
            player:messageSpecial(text.DIG_THROW_AWAY, itemId)
        end
    end
end

xi.chocoboDig.start = function(player)
    local zoneId        = player:getZoneID()
    local text          = zones[zoneId].text
    local todayDigCount = player:getCharVar('[DIG]DigCount')
    local currentX      = player:getXPos()
    local currentZ      = player:getZPos()
    local currentXSign  = 0
    local currentZSign  = 0

    if currentX < 0 then
        currentXSign = 2
    end

    if currentZ < 0 then
        currentZSign = 2
    end

    -----------------------------------
    -- Early returns and exceptions
    -----------------------------------

    -- Handle valid zones and digging cooldowns.
    if not checkDiggingCooldowns(player) then
        return false -- This means we do not send a digging animation.
    end

    -- Handle AMK mission 7 (index 6) exception.
    if
        xi.settings.main.ENABLE_AMK == 1 and
        player:getCurrentMission(xi.mission.log_id.AMK) == xi.mission.id.amk.SHOCK_ARRANT_ABUSE_OF_AUTHORITY and
        xi.amk.helpers.chocoboDig(player, zoneId, text)
    then
        -- Note: The helper function handles the messages.
        player:setLocalVar('[DIG]LastDigTime', os.time())

        return true
    end

    -- Handle auto-fail from fatigue.
    if
        xi.settings.main.DIG_FATIGUE > 0 and
        xi.settings.main.DIG_FATIGUE <= todayDigCount
    then
        player:messageText(player, text.FIND_NOTHING)
        player:setLocalVar('[DIG]LastDigTime', os.time())

        return true
    end

    -- Handle auto-fail from position.
    local lastX = player:getLocalVar('[DIG]LastXPos') * (1 - player:getLocalVar('[DIG]LastXPosSign'))
    local lastZ = player:getLocalVar('[DIG]LastZPos') * (1 - player:getLocalVar('[DIG]LastZPosSign'))

    if
        currentX >= lastX - 5 and currentX <= lastX + 5 and -- Check current X axis to see if you are too close to your last X.
        currentZ >= lastZ - 5 and currentZ <= lastZ + 5     -- Check current Z axis to see if you are too close to your last Z.
    then
        player:messageText(player, text.FIND_NOTHING)
        player:setLocalVar('[DIG]LastDigTime', os.time())

        return true
    end

    -----------------------------------
    -- Perform digging
    -----------------------------------

    -- Set player variables, no matter the result.
    player:setLocalVar('[DIG]LastXPos', currentX)
    player:setLocalVar('[DIG]LastZPos', currentZ)
    player:setLocalVar('[DIG]LastXPosSign', currentXSign)
    player:setLocalVar('[DIG]LastZPosSign', currentZSign)
    player:setLocalVar('[DIG]LastDigTime', os.time())
    player:setVar('[DIG]DigCount', todayDigCount + 1, NextJstDay())

    -- Handle trasure layer. Incompatible with the other 3 layers. "Early" return.
    local trasureItemId = handleDiggingLayer(player, zoneId, diggingLayer.TREASURE)

    if trasureItemId > 0 then
        handleItemObtained(player, text, trasureItemId)
        calculateSkillUp(player)
        player:triggerRoeEvent(xi.roeTrigger.CHOCOBO_DIG_SUCCESS)

        return true
    end

    -- Handle regional currency here. Incompatible with the other 3 layers. "Early" return.
    -- TODO: Implement logic and message to zones.

    -- Handle regular layer. This also contains, elemental ores, weather crystals and day-element geodes.
    local regularItemId = handleDiggingLayer(player, zoneId, diggingLayer.REGULAR)

    handleItemObtained(player, text, regularItemId)

    -- Handle Burrow layer. Requires Burrow skill.
    local burrowItemId = 0

    if xi.settings.main.DIG_GRANT_BURROW > 0 then -- TODO: Implement Chocobo Raising and Burrow chocobo skill. Good luck
        burrowItemId = handleDiggingLayer(player, zoneId, diggingLayer.BURROW)

        handleItemObtained(player, text, burrowItemId)
    end

    -- Handle Bore layer. Requires Bore skill.
    local boreItemId = 0

    if xi.settings.main.DIG_GRANT_BORE > 0 then -- TODO: Implement Chocobo Raising and Bore chocobo skill. Good luck
        boreItemId = handleDiggingLayer(player, zoneId, diggingLayer.BORE)

        handleItemObtained(player, text, boreItemId)
    end

    -- Handle skill-up
    calculateSkillUp(player)

    -- Handle no item OR record of eminence.
    if
        regularItemId == 0 and
        burrowItemId == 0 and
        boreItemId == 0
    then
        player:messageText(player, text.FIND_NOTHING)
    else
        player:triggerRoeEvent(xi.roeTrigger.CHOCOBO_DIG_SUCCESS)
    end

    -- Dig ended. Send digging animation to players.
    return true
end
