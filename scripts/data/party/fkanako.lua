local character, super = Class(PartyMember, "fkanako")

function character:init()
    super.init(self)

    self.name = "Kanako"

    self:setActor("fkanako")

    self.level = 17
    self.exp = 16724
    self.love = 17
    self.kills = 128
    self.title = "Amalgamate\nAble to hold her\nform, mostly."

    self.soul_priority = 1
    self.soul_color = {255/255, 255/255, 255/255}
    self.soul_facing = "down"
    self.has_spells = true
    self.has_act = false

    self.has_xact = false
    self.xact_name = "K-Action"

    self.health = 1900

    self.stats = {
        health = 1900,
        attack = 80,
        defense = 10,
        magic = 60
    }

    self.weapon_icon = "ui/menu/equip/staff_c"

    self:setWeapon("kanakos_staff")
	self:setArmor(1, "resistance_band")
	
    self:addSpell("bellguard")

    self.lw_weapon_default = "light/rope_sling"
    self.lw_armor_default = "light/bandage"

    -- Character color (for action box outline and hp bar)
    self.color = {203/255, 67/255, 112/255}
    -- Damage color (for the number when attacking enemies) (defaults to the main color)
    self.dmg_color = {0.8, 0.3, 0.4}
    -- Attack bar color (for the target bar used in attack mode) (defaults to the main color)
    self.attack_bar_color = {0.8, 0.3, 0.4}
    -- Attack box color (for the attack area in attack mode) (defaults to darkened main color)
    self.attack_box_color = {0.8, 0.3, 0.4}
    -- X-Action color (for the color of X-Action menu items) (defaults to the main color)
    self.xact_color = {0.8, 0.3, 0.4}

    self.icon_color = {0.8, 0.3, 0.4}

    self.menu_icon = "party/future_kanako/head"
    self.head_icons = "party/future_kanako/icon"
    self.name_sprite = "party/future_kanako/name"

    self.battle_offset = {2, 1}
    self.head_icon_offset = {0, -3}
    self.menu_icon_offset = nil
	
	self.flags = {}
	
	self.future = true

    self.element = {
        "FLOWER",
        "DT" -- Determination
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
    -- if index == 1 then
        -- local icon = Assets.getTexture("ui/menu/icon/snow")
        -- Draw.draw(icon, x-26, y+6, 0, 2, 2)
        -- love.graphics.print("Coldness", x, y)
        -- local coldness = MathUtils.clamp(47 + (self:getFlag("iceshocks_used", 0) * 7), 47, 100)
        -- love.graphics.print(coldness, x+130, y)
        -- return true
    -- elseif index == 2 then
        -- local icon = Assets.getTexture("ui/menu/icon/exclamation")
        -- Draw.draw(icon, x-26, y+6, 0, 2, 2)
        -- love.graphics.print("Boldness", x, y, 0, 0.8, 1)
        -- love.graphics.print(self:getFlag("boldness", -3), x+130, y)
        -- return true
    if index == 3 then
        local icon = Assets.getTexture("ui/menu/icon/fire")
        Draw.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Guts:", x, y)

        Draw.draw(icon, x+90, y+6, 0, 2, 2)
        Draw.draw(icon, x+110, y+6, 0, 2, 2)
        return true
    end
end

return character
