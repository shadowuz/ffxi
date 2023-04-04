-- Trust ovehaul to make all trust useable at all lvls
-- these updates was done due to server pop being low

-----------------------------------
require("modules/module_utils")
require("scripts/globals/magic")
require("scripts/globals/weaponskillids")
require("scripts/globals/status")
require("scripts/globals/trust")
require("scripts/globals/utils")
require("scripts/globals/ability")
require("scripts/globals/zone")
require("scripts/globals/gambits")
-----------------------------------
local m = Module:new("basic_trust_updates")


-- Cherukiki

m:addOverride("xi.globals.spells.trust.cherukiki.onSpellCast", function(caster, target, spell)

         local trust = caster:spawnTrust(spell:getID())

    local power = trust:getMainLvl()
    trust:addMod(xi.mod.CURE_CAST_TIME, power)
	trust:addMod(xi.mod.MACC, 1000)
	trust:addMod(xi.mod.CURE_POTENCY, 50)
	trust:addMod(xi.mod.DEF, power*2)
	trust:addMod(xi.mod.MDEF, power*3)
	trust:addMod(xi.mod.REFRESH, 10)
	trust:addMod(xi.mod.HASTE_MAGIC, power*5)
	trust:addMod(xi.mod.HASTE_GEAR, power*5)	
    trust:addMod(xi.mod.MPP, 10)
    trust:addMod(xi.mod.HPP, 20)	
    trust:addMod(xi.mod.CURE2MP_PERCENT, 10)
	
end)

-- Ferreous Coffin

m:addOverride("xi.globals.spells.trust.ferreous_coffin.onSpellCast", function(caster, target, spell)

         local trust = caster:spawnTrust(spell:getID())

    local power = trust:getMainLvl()
    trust:addMod(xi.mod.CURE_CAST_TIME, power)
	trust:addMod(xi.mod.MACC, 1000)
	trust:addMod(xi.mod.CURE_POTENCY, 50)
	trust:addMod(xi.mod.DEF, power*2)
	trust:addMod(xi.mod.MDEF, power*3)
	trust:addMod(xi.mod.REFRESH, 10)
	trust:addMod(xi.mod.HASTE_MAGIC, power*5)
	trust:addMod(xi.mod.HASTE_GEAR, power*5)	
    trust:addMod(xi.mod.MPP, 10)
    trust:addMod(xi.mod.HPP, 20)	
    trust:addMod(xi.mod.CURE2MP_PERCENT, 10)
	
end)

-- Karaha-Baruha
m:addOverride("xi.globals.spells.trust.karaha-baruha.onSpellCast", function(caster, target, spell)

         local trust = caster:spawnTrust(spell:getID())

    local power = trust:getMainLvl()
    trust:addMod(xi.mod.CURE_CAST_TIME, power)
	trust:addMod(xi.mod.MACC, 1000)
	trust:addMod(xi.mod.CURE_POTENCY, 50)
	trust:addMod(xi.mod.DEF, power*2)
	trust:addMod(xi.mod.MDEF, power*3)
	trust:addMod(xi.mod.REFRESH, 10)
	trust:addMod(xi.mod.HASTE_MAGIC, power*5)
	trust:addMod(xi.mod.HASTE_GEAR, power*5)	
    trust:addMod(xi.mod.MPP, 10)
    trust:addMod(xi.mod.HPP, 20)	
    trust:addMod(xi.mod.CURE2MP_PERCENT, 10)
	
end)
	
-- Kupipi
m:addOverride("xi.globals.spells.trust.kupipi.onSpellCast", function(caster, target, spell)

         local trust = caster:spawnTrust(spell:getID())
	
    local power = trust:getMainLvl()
    trust:addMod(xi.mod.CURE_CAST_TIME, power)
	trust:addMod(xi.mod.MACC, 1000)
	trust:addMod(xi.mod.CURE_POTENCY, 50)
	trust:addMod(xi.mod.DEF, power*2)
	trust:addMod(xi.mod.MDEF, power*3)
	trust:addMod(xi.mod.REFRESH, 10)
	trust:addMod(xi.mod.HASTE_MAGIC, power*5)
	trust:addMod(xi.mod.HASTE_GEAR, power*5)	
    trust:addMod(xi.mod.MPP, 10)
    trust:addMod(xi.mod.HPP, 20)	
    trust:addMod(xi.mod.CURE2MP_PERCENT, 10)
	
end)
	
-- Mihli Aliapoh
m:addOverride("xi.globals.spells.trust.mihli_aliapoh.onSpellCast", function(caster, target, spell)

         local trust = caster:spawnTrust(spell:getID())
	
    local power = trust:getMainLvl()
    trust:addMod(xi.mod.CURE_CAST_TIME, power)
	trust:addMod(xi.mod.MACC, 1000)
	trust:addMod(xi.mod.CURE_POTENCY, 50)
	trust:addMod(xi.mod.DEF, power*2)
	trust:addMod(xi.mod.MDEF, power*3)
	trust:addMod(xi.mod.REFRESH, 10)
	trust:addMod(xi.mod.HASTE_MAGIC, power*5)
	trust:addMod(xi.mod.HASTE_GEAR, power*5)	
    trust:addMod(xi.mod.MPP, 10)
    trust:addMod(xi.mod.HPP, 20)	
    trust:addMod(xi.mod.CURE2MP_PERCENT, 10)
	
end)
	
-- Nashmeira II
m:addOverride("xi.globals.spells.trust.nashmeira_ii.onSpellCast", function(caster, target, spell)

    local trust = caster:spawnTrust(spell:getID())
	
    trust:addSimpleGambit(ai.t.PARTY, ai.c.HPP_LT, 75, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.CURE)

    trust:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, xi.effect.SLEEP_I, ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.CURE)
    trust:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, xi.effect.SLEEP_II, ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.CURE)

    trust:addSimpleGambit(ai.t.PARTY, ai.c.HPP_LT, 50, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.CURE)

    trust:addSimpleGambit(ai.t.PARTY, ai.c.NOT_STATUS, xi.effect.PROTECT, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.PROTECTRA)
    trust:addSimpleGambit(ai.t.PARTY, ai.c.NOT_STATUS, xi.effect.SHELL, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.SHELLRA)

    trust:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, xi.effect.POISON, ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.POISONA)
    trust:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, xi.effect.PARALYSIS, ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.PARALYNA)
    trust:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, xi.effect.BLINDNESS, ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.BLINDNA)
    trust:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, xi.effect.SILENCE, ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.SILENA)
    trust:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, xi.effect.PETRIFICATION, ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.STONA)
    trust:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, xi.effect.DISEASE, ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.VIRUNA)
   
    trust:addSimpleGambit(ai.t.SELF, ai.c.STATUS_FLAG, xi.effectFlag.ERASABLE, ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.ERASE)
    trust:addSimpleGambit(ai.t.PARTY, ai.c.STATUS_FLAG, xi.effectFlag.ERASABLE, ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.ERASE)

     local power = trust:getMainLvl()
    trust:addMod(xi.mod.CURE_CAST_TIME, power)
	trust:addMod(xi.mod.MACC, 1000)
	trust:addMod(xi.mod.CURE_POTENCY, 50)
	trust:addMod(xi.mod.DEF, power*2)
	trust:addMod(xi.mod.MDEF, power*3)
	trust:addMod(xi.mod.REFRESH, 10)
	trust:addMod(xi.mod.HASTE_MAGIC, power*5)
	trust:addMod(xi.mod.HASTE_GEAR, power*5)	
    trust:addMod(xi.mod.MPP, 10)
    trust:addMod(xi.mod.HPP, 20)	
    trust:addMod(xi.mod.CURE2MP_PERCENT, 10)
	
end)

-- Ygnas
m:addOverride("xi.globals.spells.trust.ygnas.onSpellCast", function(caster, target, spell)

    local trust = caster:spawnTrust(spell:getID())
	
    trust:addSimpleGambit(ai.t.PARTY, ai.c.HPP_LT, 25, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.CURE)

    trust:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, xi.effect.SLEEP_I, ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.CURE)
    trust:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, xi.effect.SLEEP_II, ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.CURE)

    trust:addSimpleGambit(ai.t.PARTY, ai.c.HPP_LT, 75, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.CURE)

    trust:addSimpleGambit(ai.t.PARTY, ai.c.NOT_STATUS, xi.effect.PROTECT, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.PROTECTRA)
    trust:addSimpleGambit(ai.t.PARTY, ai.c.NOT_STATUS, xi.effect.SHELL, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.SHELLRA)

    trust:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, xi.effect.POISON, ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.POISONA)
    trust:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, xi.effect.PARALYSIS, ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.PARALYNA)
    trust:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, xi.effect.BLINDNESS, ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.BLINDNA)
    trust:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, xi.effect.SILENCE, ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.SILENA)
    trust:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, xi.effect.PETRIFICATION, ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.STONA)
    trust:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, xi.effect.DISEASE, ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.VIRUNA)
   
    trust:addSimpleGambit(ai.t.SELF, ai.c.STATUS_FLAG, xi.effectFlag.ERASABLE, ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.ERASE)
    trust:addSimpleGambit(ai.t.PARTY, ai.c.STATUS_FLAG, xi.effectFlag.ERASABLE, ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.ERASE)

    local power = trust:getMainLvl()
    trust:addMod(xi.mod.CURE_CAST_TIME, power)
	trust:addMod(xi.mod.MACC, 1000)
	trust:addMod(xi.mod.CURE_POTENCY, 50)
	trust:addMod(xi.mod.DEF, power*2)
	trust:addMod(xi.mod.MDEF, power*3)
	trust:addMod(xi.mod.REFRESH, 10)
	trust:addMod(xi.mod.HASTE_MAGIC, power*5)
	trust:addMod(xi.mod.HASTE_GEAR, power*5)	
    trust:addMod(xi.mod.MPP, 10)
    trust:addMod(xi.mod.HPP, 20)	
    trust:addMod(xi.mod.CURE2MP_PERCENT, 10)
	trust:SetAutoAttackEnabled(false)

end)

-- Tank
-- Amchuchu

m:addOverride("xi.globals.spells.trust.cherukiki.onSpellCast", function(caster, target, spell)

         local trust = caster:spawnTrust(spell:getID())

 	local power = trust:getMainLvl()
    trust:addMod(xi.mod.MATT, power*10)
	trust:addMod(xi.mod.ATT, power*15)
	trust:addMod(xi.mod.DEF, power*25)
    trust:addMod(xi.mod.MACC, power*10)
	trust:addMod(xi.mod.ACC, power*10)
	trust:addMod(xi.mod.DOUBLE_ATTACK, 25)
	trust:addMod(xi.mod.WSACC, power*10)
	trust:addMod(xi.mod.MDEF, power*25)
	trust:addMod(xi.mod.DEF, power*25)
    trust:addMod(xi.mod.ALL_WSDMG_ALL_HITS, power*10)
	trust:addMod(xi.mod.REFRESH, 10)
	trust:addMod(xi.mod.REGAIN, 10)
	trust:addMod(xi.mod.ENMITY, power*255)	
	
end)

-- Ark Angel EV

m:addOverride("xi.globals.spells.trust.cherukiki.onSpellCast", function(caster, target, spell)

         local trust = caster:spawnTrust(spell:getID())

	local power = trust:getMainLvl()
    trust:addMod(xi.mod.MATT, power*10)
	trust:addMod(xi.mod.ATT, power*15)
	trust:addMod(xi.mod.DEF, power*25)
    trust:addMod(xi.mod.MACC, power*10)
	trust:addMod(xi.mod.ACC, power*10)
	trust:addMod(xi.mod.DOUBLE_ATTACK, 25)
	trust:addMod(xi.mod.WSACC, power*10)
	trust:addMod(xi.mod.MDEF, power*25)
	trust:addMod(xi.mod.DEF, power*25)
    trust:addMod(xi.mod.ALL_WSDMG_ALL_HITS, power*10)
	trust:addMod(xi.mod.REFRESH, 10)
	trust:addMod(xi.mod.REGAIN, 10)
	trust:addMod(xi.mod.ENMITY, power*255)	
	
end)

-- Ark Angel HM

m:addOverride("xi.globals.spells.trust.cherukiki.onSpellCast", function(caster, target, spell)

         local trust = caster:spawnTrust(spell:getID())

	local power = trust:getMainLvl()
    trust:addMod(xi.mod.MATT, power*10)
	trust:addMod(xi.mod.ATT, power*15)
	trust:addMod(xi.mod.DEF, power*25)
    trust:addMod(xi.mod.MACC, power*10)
	trust:addMod(xi.mod.ACC, power*10)
	trust:addMod(xi.mod.DOUBLE_ATTACK, 25)
	trust:addMod(xi.mod.WSACC, power*10)
	trust:addMod(xi.mod.MDEF, power*25)
	trust:addMod(xi.mod.DEF, power*25)
    trust:addMod(xi.mod.ALL_WSDMG_ALL_HITS, power*10)
	trust:addMod(xi.mod.REFRESH, 10)
	trust:addMod(xi.mod.REGAIN, 10)
	trust:addMod(xi.mod.ENMITY, power*255)	
	
end)

-- August

m:addOverride("xi.globals.spells.trust.cherukiki.onSpellCast", function(caster, target, spell)

         local trust = caster:spawnTrust(spell:getID())

	local power = trust:getMainLvl()
    trust:addMod(xi.mod.MATT, power*10)
	trust:addMod(xi.mod.ATT, power*15)
	trust:addMod(xi.mod.DEF, power*25)
    trust:addMod(xi.mod.MACC, power*10)
	trust:addMod(xi.mod.ACC, power*10)
	trust:addMod(xi.mod.DOUBLE_ATTACK, 25)
	trust:addMod(xi.mod.WSACC, power*10)
	trust:addMod(xi.mod.MDEF, power*25)
	trust:addMod(xi.mod.DEF, power*25)
    trust:addMod(xi.mod.ALL_WSDMG_ALL_HITS, power*10)
	trust:addMod(xi.mod.REFRESH, 10)
	trust:addMod(xi.mod.REGAIN, 10)
	trust:addMod(xi.mod.ENMITY, power*255)	
	
end)

-- Curilla

m:addOverride("xi.globals.spells.trust.cherukiki.onSpellCast", function(caster, target, spell)

         local trust = caster:spawnTrust(spell:getID())

	local power = trust:getMainLvl()
    trust:addMod(xi.mod.MATT, power*10)
	trust:addMod(xi.mod.ATT, power*15)
	trust:addMod(xi.mod.DEF, power*25)
    trust:addMod(xi.mod.MACC, power*10)
	trust:addMod(xi.mod.ACC, power*10)
	trust:addMod(xi.mod.DOUBLE_ATTACK, 25)
	trust:addMod(xi.mod.WSACC, power*10)
	trust:addMod(xi.mod.MDEF, power*25)
	trust:addMod(xi.mod.DEF, power*25)
    trust:addMod(xi.mod.ALL_WSDMG_ALL_HITS, power*10)
	trust:addMod(xi.mod.REFRESH, 10)
	trust:addMod(xi.mod.REGAIN, 10)
	trust:addMod(xi.mod.ENMITY, power*255)	
	
end)

-- Gessho

m:addOverride("xi.globals.spells.trust.cherukiki.onSpellCast", function(caster, target, spell)

         local trust = caster:spawnTrust(spell:getID())

	local power = trust:getMainLvl()
    trust:addMod(xi.mod.MATT, power*10)
	trust:addMod(xi.mod.ATT, power*15)
	trust:addMod(xi.mod.DEF, power*25)
    trust:addMod(xi.mod.MACC, power*10)
	trust:addMod(xi.mod.ACC, power*10)
	trust:addMod(xi.mod.DOUBLE_ATTACK, 25)
	trust:addMod(xi.mod.WSACC, power*10)
	trust:addMod(xi.mod.MDEF, power*25)
	trust:addMod(xi.mod.DEF, power*25)
    trust:addMod(xi.mod.ALL_WSDMG_ALL_HITS, power*10)
	trust:addMod(xi.mod.REFRESH, 10)
	trust:addMod(xi.mod.REGAIN, 10)
	trust:addMod(xi.mod.ENMITY, power*255)	
	
end)

-- Mnejing

m:addOverride("xi.globals.spells.trust.cherukiki.onSpellCast", function(caster, target, spell)

         local trust = caster:spawnTrust(spell:getID())

	local power = trust:getMainLvl()
    trust:addMod(xi.mod.MATT, power*10)
	trust:addMod(xi.mod.ATT, power*15)
	trust:addMod(xi.mod.DEF, power*25)
    trust:addMod(xi.mod.MACC, power*10)
	trust:addMod(xi.mod.ACC, power*10)
	trust:addMod(xi.mod.DOUBLE_ATTACK, 25)
	trust:addMod(xi.mod.WSACC, power*10)
	trust:addMod(xi.mod.MDEF, power*25)
	trust:addMod(xi.mod.DEF, power*25)
    trust:addMod(xi.mod.ALL_WSDMG_ALL_HITS, power*10)
	trust:addMod(xi.mod.REFRESH, 10)
	trust:addMod(xi.mod.REGAIN, 10)
	trust:addMod(xi.mod.ENMITY, power*255)	
	
end)

-- Rahal

m:addOverride("xi.globals.spells.trust.cherukiki.onSpellCast", function(caster, target, spell)

         local trust = caster:spawnTrust(spell:getID())

	local power = trust:getMainLvl()
    trust:addMod(xi.mod.MATT, power*10)
	trust:addMod(xi.mod.ATT, power*15)
	trust:addMod(xi.mod.DEF, power*25)
    trust:addMod(xi.mod.MACC, power*10)
	trust:addMod(xi.mod.ACC, power*10)
	trust:addMod(xi.mod.DOUBLE_ATTACK, 25)
	trust:addMod(xi.mod.WSACC, power*10)
	trust:addMod(xi.mod.MDEF, power*25)
	trust:addMod(xi.mod.DEF, power*25)
    trust:addMod(xi.mod.ALL_WSDMG_ALL_HITS, power*10)
	trust:addMod(xi.mod.REFRESH, 10)
	trust:addMod(xi.mod.REGAIN, 10)
	trust:addMod(xi.mod.ENMITY, power*255)	
	
end)

-- Rughadjeen

m:addOverride("xi.globals.spells.trust.cherukiki.onSpellCast", function(caster, target, spell)

         local trust = caster:spawnTrust(spell:getID())

 	local power = trust:getMainLvl()
    trust:addMod(xi.mod.MATT, power*10)
	trust:addMod(xi.mod.ATT, power*15)
	trust:addMod(xi.mod.DEF, power*25)
    trust:addMod(xi.mod.MACC, power*10)
	trust:addMod(xi.mod.ACC, power*10)
	trust:addMod(xi.mod.DOUBLE_ATTACK, 25)
	trust:addMod(xi.mod.WSACC, power*10)
	trust:addMod(xi.mod.MDEF, power*25)
	trust:addMod(xi.mod.DEF, power*25)
    trust:addMod(xi.mod.ALL_WSDMG_ALL_HITS, power*10)
	trust:addMod(xi.mod.REFRESH, 10)
	trust:addMod(xi.mod.REGAIN, 10)
	trust:addMod(xi.mod.ENMITY, power*255)	
	
end)

-- Trion

m:addOverride("xi.globals.spells.trust.cherukiki.onSpellCast", function(caster, target, spell)

         local trust = caster:spawnTrust(spell:getID())

	local power = trust:getMainLvl()
    trust:addMod(xi.mod.MATT, power*10)
	trust:addMod(xi.mod.ATT, power*15)
	trust:addMod(xi.mod.DEF, power*25)
    trust:addMod(xi.mod.MACC, power*10)
	trust:addMod(xi.mod.ACC, power*10)
	trust:addMod(xi.mod.DOUBLE_ATTACK, 25)
	trust:addMod(xi.mod.WSACC, power*10)
	trust:addMod(xi.mod.MDEF, power*25)
	trust:addMod(xi.mod.DEF, power*25)
    trust:addMod(xi.mod.ALL_WSDMG_ALL_HITS, power*10)
	trust:addMod(xi.mod.REFRESH, 10)
	trust:addMod(xi.mod.REGAIN, 10)
	trust:addMod(xi.mod.ENMITY, power*255)	
	
end)

-- Valaineral

m:addOverride("xi.globals.spells.trust.cherukiki.onSpellCast", function(caster, target, spell)

         local trust = caster:spawnTrust(spell:getID())

	local power = trust:getMainLvl()
    trust:addMod(xi.mod.MATT, power*10)
	trust:addMod(xi.mod.ATT, power*15)
	trust:addMod(xi.mod.DEF, power*25)
    trust:addMod(xi.mod.MACC, power*10)
	trust:addMod(xi.mod.ACC, power*10)
	trust:addMod(xi.mod.DOUBLE_ATTACK, 25)
	trust:addMod(xi.mod.WSACC, power*10)
	trust:addMod(xi.mod.MDEF, power*25)
	trust:addMod(xi.mod.DEF, power*25)
    trust:addMod(xi.mod.ALL_WSDMG_ALL_HITS, power*10)
	trust:addMod(xi.mod.REFRESH, 10)
	trust:addMod(xi.mod.REGAIN, 10)
	trust:addMod(xi.mod.ENMITY, power*255)	
	
end)

-- Offensive Caster

-- Adelheid

m:addOverride("xi.globals.spells.trust.adelheid.onSpellCast", function(caster, target, spell)

      local trust = caster:spawnTrust(spell:getID())
		
	local power = trust:getMainLvl()
    trust:addMod(xi.mod.CURE_CAST_TIME, power)
	trust:addMod(xi.mod.MACC, power*3)
    trust:addMod(xi.mod.MATT, power*3)
	trust:addMod(xi.mod.CURE_POTENCY, power)
	trust:addMod(xi.mod.DEF, power)
	trust:addMod(xi.mod.MDEF, power)
	trust:addMod(xi.mod.REFRESH, power)
	trust:addMod(xi.mod.HASTE_MAGIC, power)
	
end)
  
-- Ajido-Marujido

 m:addOverride("xi.globals.spells.trust.ajido-marujido.onSpellCast", function(caster, target, spell)

      local trust = caster:spawnTrust(spell:getID())
	
	trust:addSimpleGambit(ai.t.TARGET, ai.c.MB_AVAILABLE, 0, ai.r.MA, ai.s.MB_ELEMENT, xi.magic.spellFamily.NONE)
    trust:addSimpleGambit(ai.t.TARGET, ai.c.NOT_SC_AVAILABLE, 0, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.NONE)

        
	
	local power = trust:getMainLvl()
    trust:addMod(xi.mod.CURE_CAST_TIME, power)
	trust:addMod(xi.mod.MACC, power*3)
    trust:addMod(xi.mod.MATT, power*3)
	trust:addMod(xi.mod.CURE_POTENCY, power)
	trust:addMod(xi.mod.DEF, power)
	trust:addMod(xi.mod.MDEF, power)
	trust:addMod(xi.mod.REFRESH, power)
	trust:addMod(xi.mod.HASTE_MAGIC, power)
	
end)  

-- Ark Angel TT

 m:addOverride("xi.globals.spells.trust.aatt.onSpellCast", function(caster, target, spell)

  local trust = caster:spawnTrust(spell:getID())

    trust:addSimpleGambit(ai.t.TARGET, ai.c.MB_AVAILABLE, 0, ai.r.MA, ai.s.MB_ELEMENT, xi.magic.spellFamily.NONE)
    trust:addSimpleGambit(ai.t.TARGET, ai.c.NOT_SC_AVAILABLE, 0, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.NONE)


	
	local power = trust:getMainLvl()
    trust:addMod(xi.mod.CURE_CAST_TIME, power)
	trust:addMod(xi.mod.MACC, power*3)
    trust:addMod(xi.mod.MATT, power*3)
	trust:addMod(xi.mod.CURE_POTENCY, power)
	trust:addMod(xi.mod.DEF, power)
	trust:addMod(xi.mod.MDEF, power)
	trust:addMod(xi.mod.REFRESH, power)
	trust:addMod(xi.mod.HASTE_MAGIC, power)
	
end)  

-- Domina Shantotto

 m:addOverride("xi.globals.spells.trust.d_shantotto.onSpellCast", function(caster, target, spell)

  local trust = caster:spawnTrust(spell:getID())
  
    trust:addSimpleGambit(ai.t.TARGET, ai.c.MB_AVAILABLE, 0, ai.r.MA, ai.s.MB_ELEMENT, xi.magic.spellFamily.NONE)
    trust:addSimpleGambit(ai.t.TARGET, ai.c.NOT_SC_AVAILABLE, 0, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.NONE)

        
	
	local power = trust:getMainLvl()
    trust:addMod(xi.mod.CURE_CAST_TIME, power)
	trust:addMod(xi.mod.MACC, power*3)
    trust:addMod(xi.mod.MATT, power*3)
	trust:addMod(xi.mod.CURE_POTENCY, power)
	trust:addMod(xi.mod.DEF, power)
	trust:addMod(xi.mod.MDEF, power)
	trust:addMod(xi.mod.REFRESH, power)
	trust:addMod(xi.mod.HASTE_MAGIC, power)
	
end)  

-- Gadalar

 m:addOverride("xi.globals.spells.trust.gadalar.onSpellCast", function(caster, target, spell)

  local trust = caster:spawnTrust(spell:getID())
  
    trust:addSimpleGambit(ai.t.TARGET, ai.c.MB_AVAILABLE, 0, ai.r.MA, ai.s.MB_ELEMENT, xi.magic.spellFamily.NONE)
    trust:addSimpleGambit(ai.t.TARGET, ai.c.NOT_SC_AVAILABLE, 0, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.NONE)


	
	local power = trust:getMainLvl()
    trust:addMod(xi.mod.CURE_CAST_TIME, power)
	trust:addMod(xi.mod.MACC, power*3)
    trust:addMod(xi.mod.MATT, power*3)
	trust:addMod(xi.mod.CURE_POTENCY, power)
	trust:addMod(xi.mod.DEF, power)
	trust:addMod(xi.mod.MDEF, power)
	trust:addMod(xi.mod.REFRESH, power)
	trust:addMod(xi.mod.HASTE_MAGIC, power)
	
end)
  
-- Ingrid

 m:addOverride("xi.globals.spells.trust.ingrid.onSpellCast", function(caster, target, spell)

  local trust = caster:spawnTrust(spell:getID())
  
    trust:addSimpleGambit(ai.t.TARGET, ai.c.MB_AVAILABLE, 0, ai.r.MA, ai.s.MB_ELEMENT, xi.magic.spellFamily.NONE)
    trust:addSimpleGambit(ai.t.TARGET, ai.c.NOT_SC_AVAILABLE, 0, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.NONE)


	
	local power = trust:getMainLvl()
    trust:addMod(xi.mod.CURE_CAST_TIME, power)
	trust:addMod(xi.mod.MACC, power*3)
    trust:addMod(xi.mod.MATT, power*3)
	trust:addMod(xi.mod.CURE_POTENCY, power)
	trust:addMod(xi.mod.DEF, power)
	trust:addMod(xi.mod.MDEF, power)
	trust:addMod(xi.mod.REFRESH, power)
	trust:addMod(xi.mod.HASTE_MAGIC, power)
	
end)  

-- Kayeel-Payeel

 m:addOverride("xi.globals.spells.trust.kayeel-payeel.onSpellCast", function(caster, target, spell)
 
   local trust = caster:spawnTrust(spell:getID())
  
  trust:addSimpleGambit(ai.t.TARGET, ai.c.MB_AVAILABLE, 0, ai.r.MA, ai.s.MB_ELEMENT, xi.magic.spellFamily.NONE)
  trust:addSimpleGambit(ai.t.TARGET, ai.c.NOT_SC_AVAILABLE, 0, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.NONE)
	
	local power = trust:getMainLvl()
    trust:addMod(xi.mod.CURE_CAST_TIME, power)
	trust:addMod(xi.mod.MACC, power*3)
    trust:addMod(xi.mod.MATT, power*3)
	trust:addMod(xi.mod.CURE_POTENCY, power)
	trust:addMod(xi.mod.DEF, power)
	trust:addMod(xi.mod.MDEF, power)
	trust:addMod(xi.mod.REFRESH, power)
	trust:addMod(xi.mod.HASTE_MAGIC, power)
	
end)  

-- Kukki-Chebukki

 m:addOverride("xi.globals.spells.trust.kukki-chebukki.onSpellCast", function(caster, target, spell)

      local trust = caster:spawnTrust(spell:getID())

    trust:addSimpleGambit(ai.t.TARGET, ai.c.MB_AVAILABLE, 0, ai.r.MA, ai.s.MB_ELEMENT, xi.magic.spellFamily.NONE)
    trust:addSimpleGambit(ai.t.TARGET, ai.c.NOT_SC_AVAILABLE, 0, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.NONE)

         
	
	local power = trust:getMainLvl()
    trust:addMod(xi.mod.CURE_CAST_TIME, power)
	trust:addMod(xi.mod.MACC, power*3)
    trust:addMod(xi.mod.MATT, power*3)
	trust:addMod(xi.mod.CURE_POTENCY, power)
	trust:addMod(xi.mod.DEF, power)
	trust:addMod(xi.mod.MDEF, power)
	trust:addMod(xi.mod.REFRESH, power)
	trust:addMod(xi.mod.HASTE_MAGIC, power)
	
end)  

-- Leonoyne

 m:addOverride("xi.globals.spells.trust.leonoyne.onSpellCast", function(caster, target, spell)

 local trust = caster:spawnTrust(spell:getID())
 
    trust:addSimpleGambit(ai.t.TARGET, ai.c.MB_AVAILABLE, 0, ai.r.MA, ai.s.MB_ELEMENT, xi.magic.spellFamily.NONE)
    trust:addSimpleGambit(ai.t.TARGET, ai.c.NOT_SC_AVAILABLE, 0, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.NONE)

	
	local power = trust:getMainLvl()
    trust:addMod(xi.mod.CURE_CAST_TIME, power)
	trust:addMod(xi.mod.MACC, power*3)
    trust:addMod(xi.mod.MATT, power*3)
	trust:addMod(xi.mod.CURE_POTENCY, power)
	trust:addMod(xi.mod.DEF, power)
	trust:addMod(xi.mod.MDEF, power)
	trust:addMod(xi.mod.REFRESH, power)
	trust:addMod(xi.mod.HASTE_MAGIC, power)
	
end)  

-- Mumor II

 m:addOverride("xi.globals.spells.trust.mumor_ii.onSpellCast", function(caster, target, spell)

         local trust = caster:spawnTrust(spell:getID())

    trust:addSimpleGambit(ai.t.TARGET, ai.c.MB_AVAILABLE, 0, ai.r.MA, ai.s.MB_ELEMENT, xi.magic.spellFamily.NONE)
    trust:addSimpleGambit(ai.t.TARGET, ai.c.NOT_SC_AVAILABLE, 0, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.NONE)


	
	local power = trust:getMainLvl()
    trust:addMod(xi.mod.CURE_CAST_TIME, power)
	trust:addMod(xi.mod.MACC, power*3)
    trust:addMod(xi.mod.MATT, power*3)
	trust:addMod(xi.mod.CURE_POTENCY, power)
	trust:addMod(xi.mod.DEF, power)
	trust:addMod(xi.mod.MDEF, power)
	trust:addMod(xi.mod.REFRESH, power)
	trust:addMod(xi.mod.HASTE_MAGIC, power)
	
end) 
 
-- Ovjang

 m:addOverride("xi.globals.spells.trust.ovjang.onSpellCast", function(caster, target, spell)

         local trust = caster:spawnTrust(spell:getID())

    trust:addSimpleGambit(ai.t.TARGET, ai.c.MB_AVAILABLE, 0, ai.r.MA, ai.s.MB_ELEMENT, xi.magic.spellFamily.NONE)
    trust:addSimpleGambit(ai.t.TARGET, ai.c.NOT_SC_AVAILABLE, 0, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.NONE)


	
	local power = trust:getMainLvl()
    trust:addMod(xi.mod.CURE_CAST_TIME, power)
	trust:addMod(xi.mod.MACC, power*3)
    trust:addMod(xi.mod.MATT, power*3)
	trust:addMod(xi.mod.CURE_POTENCY, power)
	trust:addMod(xi.mod.DEF, power)
	trust:addMod(xi.mod.MDEF, power)
	trust:addMod(xi.mod.REFRESH, power)
	trust:addMod(xi.mod.HASTE_MAGIC, power)
	
end)  

-- Robel-Akbel

 m:addOverride("xi.globals.spells.trust.robel-akbel.onSpellCast", function(caster, target, spell)

         local trust = caster:spawnTrust(spell:getID())

    trust:addSimpleGambit(ai.t.TARGET, ai.c.MB_AVAILABLE, 0, ai.r.MA, ai.s.MB_ELEMENT, xi.magic.spellFamily.NONE)
    trust:addSimpleGambit(ai.t.TARGET, ai.c.NOT_SC_AVAILABLE, 0, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.NONE)


	
	local power = trust:getMainLvl()
    trust:addMod(xi.mod.CURE_CAST_TIME, power)
	trust:addMod(xi.mod.MACC, power*3)
    trust:addMod(xi.mod.MATT, power*3)
	trust:addMod(xi.mod.CURE_POTENCY, power)
	trust:addMod(xi.mod.DEF, power)
	trust:addMod(xi.mod.MDEF, power)
	trust:addMod(xi.mod.REFRESH, power)
	trust:addMod(xi.mod.HASTE_MAGIC, power)
	
end)  

-- Rosulatia

 m:addOverride("xi.globals.spells.trust.rosulatia.onSpellCast", function(caster, target, spell)

         local trust = caster:spawnTrust(spell:getID())

    trust:addSimpleGambit(ai.t.TARGET, ai.c.MB_AVAILABLE, 0, ai.r.MA, ai.s.MB_ELEMENT, xi.magic.spellFamily.NONE)
    trust:addSimpleGambit(ai.t.TARGET, ai.c.NOT_SC_AVAILABLE, 0, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.NONE)


	
	local power = trust:getMainLvl()
    trust:addMod(xi.mod.CURE_CAST_TIME, power)
	trust:addMod(xi.mod.MACC, power*3)
    trust:addMod(xi.mod.MATT, power*3)
	trust:addMod(xi.mod.CURE_POTENCY, power)
	trust:addMod(xi.mod.DEF, power)
	trust:addMod(xi.mod.MDEF, power)
	trust:addMod(xi.mod.REFRESH, power)
	trust:addMod(xi.mod.HASTE_MAGIC, power)
	
end)  

-- Shantotto

-- Shantotto II

-- Ullegore

 m:addOverride("xi.globals.spells.trust.ullegore.onSpellCast", function(caster, target, spell)

         local trust = caster:spawnTrust(spell:getID())

    trust:addSimpleGambit(ai.t.TARGET, ai.c.MB_AVAILABLE, 0, ai.r.MA, ai.s.MB_ELEMENT, xi.magic.spellFamily.NONE)
    trust:addSimpleGambit(ai.t.TARGET, ai.c.NOT_SC_AVAILABLE, 0, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.NONE)


	
	local power = trust:getMainLvl()
    trust:addMod(xi.mod.CURE_CAST_TIME, power)
	trust:addMod(xi.mod.MACC, power*3)
    trust:addMod(xi.mod.MATT, power*3)
	trust:addMod(xi.mod.CURE_POTENCY, power)
	trust:addMod(xi.mod.DEF, power)
	trust:addMod(xi.mod.MDEF, power)
	trust:addMod(xi.mod.REFRESH, power)
	trust:addMod(xi.mod.HASTE_MAGIC, power)
	
end)  

-- Melee Fighter
-- Abenzio
-- Abquhbah
-- Aldo
-- Areuhat
-- Ark Angel GK
-- Ark Angel MR

--ayame

m:addOverride("xi.globals.spells.trust.ayame.onSpellCast", function(caster, target, spell)

    local trust = caster:spawnTrust(spell:getID())


local power = trust:getMainLvl()
	trust:addMod(xi.mod.DEF, power)
	trust:addMod(xi.mod.MDEF, power)
	trust:addMod(xi.mod.ACC, power*9)
	trust:addMod(xi.mod.ATT, power)
    trust:addMod(xi.mod.WSACC, power*3)

end)

-- Babban Mheillea
-- Balamor
-- Chacharoon

-- cid
m:addOverride("xi.globals.spells.trust.cid.onSpellCast", function(caster, target, spell)

    local trust = caster:spawnTrust(spell:getID())

    trust:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, xi.effect.BERSERK, ai.r.JA, ai.s.SPECIFIC, xi.ja.BERSERK)
    trust:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, xi.effect.WARCRY, ai.r.JA, ai.s.SPECIFIC, xi.ja.WARCRY)

    trust:setTrustTPSkillSettings(ai.tp.ASAP, ai.s.RANDOM)

local power = trust:getMainLvl()
	trust:addMod(xi.mod.DEF, power)
	trust:addMod(xi.mod.MDEF, power)
	trust:addMod(xi.mod.ACC, power*9)
	trust:addMod(xi.mod.ATT, power)
	trust:addMod(xi.mod.DOUBLE_ATTACK, 25)
    trust:addMod(xi.mod.WSACC, power*3)

end)

-- Darrcuiln
-- Excenmille
-- Excenmille (S)
-- Fablinix
-- Gilgamesh
-- Halver
-- Ingrid II
-- Iroha
-- Iroha II
-- Iron Eater
-- Klara
-- Lehko Habhoka
-- Lhe Lhangavo
-- Lhu Mhakaracca
-- Lilisette
-- Lilisette II
-- Lion
-- Lion II
-- Luzaf
-- Maat
-- Matsui-P
-- Maximilian
-- Mayakov
-- Mildaurion
-- Morimar
-- Mumor
-- Naja Salaheem
-- Naji
-- Nanaa Mihgo
-- Nashmeira
-- Noillurie
-- Prishe
-- Prishe II
-- Rainemard
-- Romaa Mihgo
-- Rongelouts
-- Selh'teus
-- Shikaree Z
-- Tenzen
-- Teodor
-- Uka Totlihn
-- Volker
-- Zazarg

-- zeid
m:addOverride("xi.globals.spells.trust.zeid.onSpellCast", function(caster, target, spell)

    local trust = caster:spawnTrust(spell:getID())


local power = trust:getMainLvl()
	trust:addMod(xi.mod.DEF, power)
	trust:addMod(xi.mod.MDEF, power)
	trust:addMod(xi.mod.ACC, power*9)
	trust:addMod(xi.mod.ATT, power)
    trust:addMod(xi.mod.WSACC, power*3)

end)

-- Zeid II
m:addOverride("xi.globals.spells.trust.zeid_ii.onSpellCast", function(caster, target, spell)

    local trust = caster:spawnTrust(spell:getID())


local power = trust:getMainLvl()
	trust:addMod(xi.mod.DEF, power)
	trust:addMod(xi.mod.MDEF, power)
	trust:addMod(xi.mod.ACC, power*9)
	trust:addMod(xi.mod.ATT, power)
    trust:addMod(xi.mod.WSACC, power*3)

end)

-- Ranged Fighter
-- Elivira
-- Makki-Chebukki
-- Margret
-- Najelith
-- Semih Lafihna
-- Tenzen II

-- Support
-- Arciela
-- Arciela II
-- Joachim
-- King of Hearts
-- Koru-Moru
-- Qultada
-- Ulmia

-- Special
-- Brygid
-- Cornelia
-- Kupofried
-- Kuyin Hathdenna
-- Moogle
-- Sakura
-- Star Sibyl

-- Unity Concord
-- Aldo (UC)
-- Apururu (UC)
-- Ayame (UC)
-- Flaviria (UC)
-- Invincible Shield (UC)
-- Jakoh Wahcondalo (UC)
-- Maat (UC)
-- Naja Salaheem (UC)
-- Pieuje (UC)
-- Sylvie (UC)
-- Yoran-Oran (UC)

return m 