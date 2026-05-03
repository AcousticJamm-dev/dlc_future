local character, super = Class(PartyMember, "fmarcy")

function character:init()
    super.init(self)

    self.name = "Marcy"

    self:setActor("fmarcy")

    self.level = 19
    self.exp = 76525
    self.love = 19
    self.kills = 224
    self.title = "Light Reaper\nEmpty attacker who\ndeals heavy damage"

    self.soul_priority = 1
    self.soul_color = {39/255, 106/255, 179/255}
    self.soul_facing = "up"
    self.has_spells = true
    self.has_act = false

    self.has_xact = false
    self.xact_name = "M-Action"

    self.health = 1800

    self.stats = {
        health = 1800,
        attack = 100,
        defense = 20,
        magic = 30
    }

    self.weapon_icon = "ui/menu/equip/sword"

    self:setWeapon("liberator")
	self:setArmor(1, "resistance_band")
	
	self:addSpell("true_slash")
    self:addSpell("ultra_break")
    self:addSpell("life_sever")
    self:addSpell("vslash")

    self.lw_weapon_default = "light/rope_sling"
    self.lw_armor_default = "light/bandage"

    self.color = {0, 0, 1}
    self.dmg_color = nil
    self.attack_bar_color = {0, 0, 0.5}
    self.attack_box_color = {39/255, 106/255, 179/255}
    self.xact_color = nil
	
	self.attack_sprite = "effects/attack/cut_ceroba"
    self.attack_sound = "laz_c"
    self.attack_pitch = 1

    self.menu_icon = "party/future_marcy/head"
    self.head_icons = "party/future_marcy/icon"
    self.name_sprite = "party/future_marcy/name"

    self.battle_offset = {2, 1}
    self.head_icon_offset = {0, -3}
    self.menu_icon_offset = nil
	
	self.future = true

    self.element = {
        "FIRE",
        "DARK"
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
        local icon = Assets.getTexture("ui/menu/icon/demon")
        love.graphics.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Heart", x, y, 0, 0.7, 1)
        love.graphics.print("No", x+130, y)
        return true
    elseif index == 2 then
        local icon = Assets.getTexture("ui/menu/icon/magic")
        love.graphics.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Years Alone", x, y, 0, 0.7, 1)
        love.graphics.print("10", x+130, y, 0)
        return true
    elseif index == 3 then
        local icon = Assets.getTexture("ui/menu/icon/fire")
        love.graphics.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Guts:", x, y)

        love.graphics.draw(icon, x+90, y+6, 0, 2, 2)
        love.graphics.print("x", x+111, y)
        love.graphics.print("14", x+122, y+3)
        
        return true
    end
end

function character:canEquip(item, slot_type, slot_index)
    if slot_type == "weapon" then
        return false
    end
    return super.canEquip(self, item, slot_type, slot_index)
end

function character:onEquip(item, item2) 
	if item and item.id == "flowerbrace" then
		if not Game:getFlag("fmarcy_flowerbrace") then
			Game:setFlag("fmarcy_flowerbrace", true)
			Game.world.menu:closeBox()
			Kristal.Console:log("TEST 2")
			Game.world.timer:after(1/60, function()
				Game.world:closeMenu()
				Assets.stopSound("ui_cant_select")
				Game.world:startCutscene(function(cutscene)
					cutscene:showNametag("Marcy")
					cutscene:text("* Wait,[wait:5] is this...[wait:10]\n* Mom's...?", "neutral", "fmarcy")
					cutscene:showNametag("Jamm")
					cutscene:text("* Do you recognize this,[wait:5] Marcy?", "neutral", "jamm")
					cutscene:showNametag("Marcy")
					cutscene:text("* Yeah,[wait:5] this is the flower bracelet I helped mom make for you.", "neutral", "fmarcy")
					cutscene:text("* ...", "closed", "fmarcy")
					cutscene:showNametag("Jamm")
					cutscene:text("* Marcy,[wait:5] are you...", "worried", "jamm")
					cutscene:showNametag("Marcy")
					cutscene:text("* Don't worry about it,[wait:5] dad.[wait:10]\n* I'm fine.", "tears", "fmarcy")
					cutscene:text("* (Weakness isn't something I can show...)", "tears_closed", "fmarcy")
					cutscene:text("* (Don't let him see the tears...)", "tears_closed", "fmarcy")
					cutscene:showNametag("Jamm")
					cutscene:text("* We can talk about it if you--", "worried", "jamm", {auto=true})
					cutscene:showNametag("Marcy")
					cutscene:text("* Let's keep going.[wait:10]\n* That's an order,[wait:5] dad.", "neutral", "fmarcy")
					cutscene:text("* (...)", "closed", "fmarcy")
					cutscene:hideNametag()
				end)
			end)
		end
		return false
	end
	return true
end

function character:getReaction(item, user)
    if ((item and item.type ~= "weapon") or not item) or user.id ~= self.id then
        return super.getReaction(self, item, user)
    else
        return "Try it and your head comes off."
    end
end

function character:getGameOverMessage(main)
	if main:getName() == "Jamm" then
		return {
			"I knew bringing\nyou along was\na mistake.",
			"Dad,[wait:5]\nyou gonna get\nup?"
		}
	else
		return {
			"I knew bringing\nyou along was\na mistake.",
			main:getName()..",[wait:5]\nyou gonna get\nup?"
		}
	end
end

return character
