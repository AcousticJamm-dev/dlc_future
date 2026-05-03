local character, super = Class(PartyMember, "neo_armor")

function character:init()
    super.init(self)

    self.name = "NEO Armor"

    self:setActor("fmarcy")	-- temporary

    self.title = "Puppet Armor\nTakes you where\nthe strings pull"

    self.has_spells = false
    self.has_act = false

    self.has_xact = false

    self.health = 2000

    self.stats = {
        health = 2000,
        attack = 100,
        defense = 20,
        magic = 30
    }

    self.weapon_icon = "ui/menu/equip/sword"	-- temporary

    self:setWeapon("liberator")	-- temporary

    self.color = {0.5, 0.5, 0.5}
	
	self.attack_sprite = "effects/attack/cut_ceroba"
    self.attack_sound = "laz_c"
    self.attack_pitch = 1

    self.menu_icon = "party/future_marcy/head"	-- temporary
    self.head_icons = "party/future_marcy/icon"
    self.name_sprite = "party/future_marcy/name"

    self.battle_offset = {2, 1}
    self.head_icon_offset = {0, -3}
    self.menu_icon_offset = nil
	
	self.future = true	-- temporary

    self.element = {
        "PUPPET"
    }
end

function character:onTurnStart(battler)
    Game.battle:pushForcedAction(battler, "SKIP")
end

return character
