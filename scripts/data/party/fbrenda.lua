local character, super = Class(PartyMember, "fbrenda")

function character:init()
    super.init(self)

    self.name = "Brenda"

    self:setActor("fbrenda")

    self.level = 18
    self.exp = 48923
    self.love = 18
    self.kills = 146
    self.title = "Battlepriest\nDelivers judgement\n& supports w/ FAITH"

    self.soul_priority = 1
    self.soul_color = {255/255, 255/255, 255/255}
    self.soul_facing = "down"
    self.has_spells = true
    self.has_act = false

    self.has_xact = false
    self.xact_name = "B-Action"

    self.health = 1500

    self.stats = {
        health = 1500,
        attack = 135,
        defense = 16,
        magic = 50
    }

    self.weapon_icon = "ui/menu/equip/gun"

    self:setWeapon("judgement")
	self:setArmor(1, "resistance_band")
	--- Common spells
    -- self:addSpell("stancechange")
    -- self:addSpell("retribution")
    --- Judgement Stance spells
    -- self:addSpell("flareshot")
    -- self:addSpell("rapidfire")
    --- Excalibur Stance spells
    -- self:addSpell("holybuster")
    -- self:addSpell("greatslash")
    --- Prayers
    -- self:addPrayer("genesis")
    -- self:addPrayer("smite")
    -- self:addPrayer("guardianangel")

    self.lw_weapon_default = "light/foam_dart_rifle"
    self.lw_armor_default = "light/bandage"

    -- Character color (for action box outline and hp bar)
    self.color = {0, 0, 1}
    self.dmg_color = nil
    self.attack_bar_color = {0, 0, 232/255}
    self.attack_box_color = {0, 0, 0.5}
    self.xact_color = nil

    self.icon_color = {12/255, 48/255, 205/255}

    self.menu_icon = "party/future_brenda/head"
    self.head_icons = "party/future_brenda/icon"
    self.name_sprite = "party/future_brenda/name"

    self.battle_offset = {2, 1}
    self.head_icon_offset = {0, -3}
    self.menu_icon_offset = nil

    self.flags = {
        ["zelotry"] = 102,
        ["righteousness"] = 12,
    }
	
	self.future = true

    self.element = {
        "HOLY",
        "FIRE"
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
    if index == 1  then
        local icon = Assets.getTexture("ui/menu/icon/magic")
        love.graphics.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Zelotry", x, y, 0, 1, 1)
        love.graphics.print(self:getFlag("zelotry"), x+130, y)
        return true
    elseif index == 2 then
        local icon = Assets.getTexture("ui/menu/icon/star")
        love.graphics.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Righteousness", x, y, 0, 0.7, 1)
        love.graphics.print(self:getFlag("righteousness"), x+130, y, 0)
        return true
    elseif index == 3 then
        local icon = Assets.getTexture("ui/menu/icon/fire")
        love.graphics.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Guts:", x, y)

        love.graphics.draw(icon, x+90, y+6, 0, 2, 2)
        love.graphics.print("x", x+111, y)
        love.graphics.print("11", x+122, y+3)
        
        return true
    end
end

return character
