local character, super = Class(PartyMember, "fnoelle")

function character:init()
    super.init(self)

    self.name = "Noelle"

    self:setActor("fnoelle")

    self.level = 20
    self.exp = 99999
    self.love = 20
	if Game:getFlag("POST_SNOWGRAVE") then
		self.kills = 573
	else
		self.kills = 224
	end
    self.title = "Snowceress\nCovers the dark\nin thick ice."

    self.soul_priority = 1
    self.soul_color = {255/255, 255/255, 255/255}
    self.soul_facing = "down"
    self.has_spells = true
    self.has_act = false

    self.has_xact = false
    self.xact_name = "N-Action"

    self.health = 1700

    self.stats = {
        health = 1700,
        attack = 20,
        defense = 23,
        magic = 70
    }

    self.weapon_icon = "ui/menu/equip/ring"

    self:setWeapon("crimsonspire")
	self:setArmor(1, "resistance_band")
	
    self:addSpell("frostspite")
    self:addSpell("coldsnap")
    self:addSpell("whiteout")
    self:addSpell("snow_veil")
    self:addSpell("frostcrypt")

    self.lw_weapon_default = "light/rope_sling"
    self.lw_armor_default = "light/bandage"

    -- Character color (for action box outline and hp bar)
    self.color = {1, 1, 0}
    -- Damage color (for the number when attacking enemies) (defaults to the main color)
    self.dmg_color = {1, 1, 0.3}
    -- Attack bar color (for the target bar used in attack mode) (defaults to the main color)
    self.attack_bar_color = {1, 1, 153/255}
    -- Attack box color (for the attack area in attack mode) (defaults to darkened main color)
    self.attack_box_color = {1, 1, 0}
    -- X-Action color (for the color of X-Action menu items) (defaults to the main color)
    self.xact_color = {1, 1, 0.5}

    self.icon_color = {1, 1, 0}

    self.menu_icon = "party/future_noelle/head"
    self.head_icons = "party/future_noelle/icon"
    self.name_sprite = "party/future_noelle/name"

    self.battle_offset = {2, 1}
    self.head_icon_offset = {0, -3}
    self.menu_icon_offset = nil
	
	self.flags = {
        ["iceshocks_used"] = 0,
        ["boldness"] = -3,
        ["weird"] = false
    }
	
	self.future = true

    self.element = {
		"ICE"
	}
end

function character:getLevel() return self.love end

function character:onLevelUp(level)
    self:increaseStat("health", 10)
    if level % 10 == 0 then
        self:increaseStat("attack", 4)
    end
end

function character:onLevelUpLVLib(level)
    self:increaseStat("health", 50)
    self:increaseStat("attack", 5)
    self:increaseStat("defense", 3)
    self:increaseStat("magic", 2)
end

function character:drawPowerStat(index, x, y, menu)
    if index == 1 then
        local icon = Assets.getTexture("ui/menu/icon/snow")
        Draw.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Coldness", x, y)
        local coldness = MathUtils.clamp(47 + (self:getFlag("iceshocks_used", 0) * 7), 47, 900)
        love.graphics.print(coldness, x+130, y)
        return true
    elseif index == 2 then
        local icon = Assets.getTexture("ui/menu/icon/exclamation")
        Draw.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Boldness", x, y, 0, 0.8, 1)
        love.graphics.print(self:getFlag("boldness", -3), x+130, y)
        return true
    elseif index == 3 then
        local icon = Assets.getTexture("ui/menu/icon/fire")
        Draw.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Guts:", x, y)

        Draw.draw(icon, x+90, y+6, 0, 2, 2)
        Draw.draw(icon, x+110, y+6, 0, 2, 2)
        return true
    end
end

return character
