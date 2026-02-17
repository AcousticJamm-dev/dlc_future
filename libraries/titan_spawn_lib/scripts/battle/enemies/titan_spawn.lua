local TitanSpawn, super = Class(EnemyBattler, "titan_spawn")

function TitanSpawn:init()
    super.init(self)

    self.name = "Titan Spawn"
    self:setActor("titan_spawn")

    self.max_health = 3000
    self.health = 3000
    self.attack = 18
    self.defense = 0
    self.money = 0

    self.disable_mercy = true

    self.tired = false
    self.tired_percentage = -1

    self.can_freeze = false

    self.text = {
        "* You hear your heart beating in \nyour ears.",
        "* When did you start being \nyourself?",
        "* It sputtered in a voice like \ncrushed glass."
    }
    if Game:hasPartyMember("ralsei") then
        table.insert(self.text, "* Ralsei mutters to himself to \nstay calm.")
    end

	self.low_health_text = nil
	self.tired_text = nil
	self.spareable_text = nil

    self:getAct("Check").description = "Consider\nstrategy"
    self:registerAct("Brighten", "Powerup\nlight", "all", 4)
    self:registerAct("DualHeal", "Heal\nparty", {"susie", "ralsei"}, 16)
    self:registerAct("Banish",   "Defeat\nenemy",  nil,   64)

    self.dualhealcount = 0

	self.t_siner = 0
    if Game:hasPartyMember("susie") and Game:hasPartyMember("ralsei") then
        self.banish_act_index = 4
    else
        self.banish_act_index = 3
    end

    self.first_barrage = true
    self.phaseturn = 1
    self.difficulty = 0

	self.wake_kris_count = 0

    -- DPR
    self.service_mercy = 0
end

function TitanSpawn:update()
    super.update(self)
    if Game.battle.state == "MENUSELECT" and Game.battle.state_reason == "ACT" and Game.tension >= 64 then
        self.t_siner = self.t_siner + (1 * DTMULT)
        if Game.battle.menu_items[self.banish_act_index] then
            Game.battle.menu_items[self.banish_act_index].color = function()
                return (ColorUtils.mergeColor(COLORS.yellow, COLORS.white, 0.5 + (math.sin(self.t_siner / 4) * 0.5)))
            end
        end
    end

    -- DPR
    if Game.battle.current_selecting == 1 and Game.battle.state == "MENUSELECT" and Game.battle.state_reason == "SPELL" and Game:getFlag("susie_got_soul_xacts") and Game.tension >= 64 then
        self.t_siner = self.t_siner + (1 * DTMULT)
        local sb_slot = Game.battle.encounter.default_xactions and 3 or 2
        if Game.battle.menu_items[sb_slot] then
            Game.battle.menu_items[sb_slot].color = function()
                return (ColorUtils.mergeColor(COLORS.yellow, {Game.battle.party[1].chara:getXActColor()}, 0.5 + (math.sin(self.t_siner / 4) * 0.5)))
            end
        end
    end

    -- shining S-Action
    if Game.battle.current_selecting == 1 and Game.battle.state == "MENUSELECT" and Game.battle.state_reason == "SPELL" and not Game:getFlag("susie_got_soul_xacts") then
        self.t_siner = self.t_siner + (1 * DTMULT)
        if Game.battle.menu_items[1] then
            Game.battle.menu_items[1].color = function()
                return (ColorUtils.mergeColor(COLORS.yellow, {Game.battle.party[1].chara:getXActColor()}, 0.5 + (math.sin(self.t_siner / 4) * 0.5)))
            end
        end
    end
end

function TitanSpawn:getGrazeTension()
    return 0
end

function TitanSpawn:getSpareText(battler, success)
    return "* But, it was not something that \ncan understand MERCY."
end

function TitanSpawn:getXAction(battler)
    if battler.chara.id == "susie" then -- DPR exclusive function here
	    return "Analysis"
    end
    return super.getXAction(self, battler)
end

function TitanSpawn:isXActionShort(battler)
	if self:getXAction(battler) == "Standard" then
		return true
	else
		return false
	end
end

-- note about damage to PARTY: if ShadowMantle is equipped, then the next happens:
-- damage = round(damage * 0.5)
-- (data.win of chapter 4, scr_damage, line 86)
-- (adding this to not forget to add it to bullet code)
function TitanSpawn:getAttackDamage(damage, battler, points)
    if battler.chara:checkWeapon("blackshard") or battler.chara:checkWeapon("twistedswd") then
        local dmg = super.getAttackDamage(self, damage, battler, points)
        return math.ceil(dmg * 10)
    end
    return super.getAttackDamage(self, damage, battler, points)
end

function TitanSpawn:onShortAct(battler, name)
    if name == "Standard" then
        return "* " .. battler.chara:getName() .. " tried to ACT, but failed!"
    end
    return nil
end

function TitanSpawn:onAct(battler, name)
	if name == "Check" then
        if Game:getTension() >= 64 then
            return {
                "* TITAN SPAWN - AT 30 DF 200\n* A shard of fear. Appears \nin places of deep dark.",
                "* The atmosphere feels tense...\n* (You can use [color:yellow]BANISH[color:reset]!)"
            }
        else
            return {
                "* TITAN SPAWN - AT 30 DF 200\n* A shard of fear. Appears \nin places of deep dark.",
                "* Expose it to LIGHT... and gather COURAGE to gain TP.",
                "* Then, \"[color:yellow]BANISH[color:reset]\" it!",
            }
        end
    elseif name == "Brighten" then
        for _,party in ipairs(Game.battle.party) do
            party:flash()
        end
        Assets.playSound("boost")
        local bx, by = Game.battle:getSoulLocation()
        local soul = Sprite("effects/soulshine_s", bx + 5.5, by)
        soul:play(1 / 30, false, function() soul:remove() end)
        soul:setOrigin(0.5)
        soul:setScale(2, 2)
        Game.battle:addChild(soul)
		Game.battle.encounter.light_radius = 63
        return "* "..battler.chara:getName().."'s SOUL shone brighter!"
    elseif name == "DualHeal" then
        self.dualhealcount = self.dualhealcount + 1
        Game.battle:startActCutscene(function(cutscene)
            local susie = Game.battle:getPartyBattler("susie")
            local ralsei = Game.battle:getPartyBattler("ralsei")
            local canproceed = false
            local hashealed = false
            Game.battle.timer:after(7 / 30, function()
                susie:setAnimation("heal_charge") -- Susie starts the animation with the effects
                Assets.playSound("boost")
                battler:flash()
                susie:flash()
                ralsei:flash()
                local bx, by = Game.battle:getSoulLocation()
                local soul = Sprite("effects/soulshine", bx + 5.5, by)
                soul:play(1 / 30, false, function() soul:remove() end)
                soul:setOrigin(0.5)
                soul:setScale(2, 2)
                Game.battle:addChild(soul)
            end)
            Game.battle.timer:after(24 / 30, function()
                ralsei:setAnimation("battle/spell_ready") -- Ralsei starts the animation after a pause
                canproceed = true
            end)
            cutscene:text("* Your SOUL shined its power on\nRALSEI and SUSIE!")
            cutscene:wait(function() return canproceed == true end)
            susie:setAnimation("heal_end_short", function() susie:setAnimation("battle/idle") end)
            ralsei:setAnimation("battle/spell", function()
                for _,party in ipairs(Game.battle.party) do
                    local healnum = MathUtils.round((susie.chara:getStat("magic") + ralsei.chara:getStat("magic")) * 6)
                    Game.battle:applyHealBonuses(healnum, "susie") -- ralsei or susie??? Maybe needs 2 heal bonus appliers?????
                    local healmultiplier = 1.5
                    if self.dualhealcount == 2 then
                        healmultiplier = 1
                    elseif self.dualhealcount == 3 then
                        healmultiplier = 0.8
                    elseif self.dualhealcount == 4 then
                        healmultiplier = 0.3
                    elseif self.dualhealcount > 4 then
                        healmultiplier = 0.2
                    end
                    party:heal(MathUtils.round(healnum * healmultiplier))
                end
                hashealed = true
            end)
            if self.dualhealcount < 4 then
                cutscene:text("* Susie and Susie cast DUAL HEAL!\nEffectiveness of DUAL HEAL has\nlowered!")
            else
                cutscene:text("* Susie and Susie cast DUAL HEAL!")
            end
            cutscene:wait(function() return hashealed == true end)
        end)
        return
    elseif name == "J-Strike" then
        battler:setAnimation("act")
        Game.battle:startCutscene(function(cutscene)
			if not Game:getFlag("ever_j_striked") then
				Game:setFlag("ever_j_striked", true)
				cutscene:text("* Wait,[wait:5] what do you want me to do here?", "nervous_left", "jamm")
				cutscene:text("* I dunno,[wait:5] Jamm![wait:10]\n* Something!", "angry_down", "susie")
				cutscene:text("* Anything to get these things away from us!", "angry_down", "susie")
				cutscene:text("* ...", "concentrate", "jamm")
				cutscene:text("* I got an idea.", "powerful", "jamm")
			end
			Game.battle.jamm_can_strike = true
            cutscene:text("* Jamm prepares to STRIKE...")
			Game.battle:finishAction()
		end)
        return
    elseif name == "Banish" or name == "Semi-Banish" then
        battler:setAnimation("act")
        Game.battle:startCutscene(function(cutscene)
            cutscene:text("* "..battler.chara:getName().."'s SOUL emitted a brilliant \nlight!")
            battler:flash()

            local bx, by = battler:getRelativePos(battler.width/2 + 4, battler.height/2 + 4)

            local semi = false
            local texture = "player/heart_centered"
            if name == "Semi-Banish" then semi = true end
            if battler.chara.id == "susie" then texture = "player/heart_centered_flip" end -- hacky
            local soul = Game.battle:addChild(TitanSpawnPurifySoul(texture, bx, by, semi, self))
            soul.color = Game:getPartyMember(Game.party[1].id).soul_color or { 1, 0, 0 }
            soul.layer = 501

            cutscene:wait(function() return soul.t >= 500 end)
            cutscene:after(function()
                if #Game.battle.enemies == 0 then
                    Game.battle:setState("VICTORY")
                else
                    Game.battle:finishAction()
                    Game.battle:setState("ACTIONS", "CUTSCENE")
                end
            end)
        end)
        return
	elseif name == "WakeKris" then
        Game.battle:startActCutscene(function(cutscene)
            local kris = Game.battle:getPartyBattler("kris")
			self.wake_kris_count = self.wake_kris_count + 1
            cutscene:text("* "..battler.chara:getName().." used Wake Up!")
			if self.wake_kris_count == 1 then
				cutscene:text("* Hey, dumbass! Get up!")
			end
			battler:setAnimation("attack_unarmed")
			Assets.playSound("ui_cancel_small")
			Assets.playSound("damage",0.94)
            local dmg_sprite = Sprite("effects/attack/slap_s")
            dmg_sprite:setOrigin(0.5, 0.5)
            dmg_sprite:setScale(1, 1)
            local bx, by = kris:getRelativePos(kris.width / 2, kris.height / 2)
            dmg_sprite:setPosition(bx, by)
            dmg_sprite.layer = kris.layer + 0.01
            dmg_sprite:play(1 / 15, false, function(s) s:remove() end)
            kris.parent:addChild(dmg_sprite)
			kris:shake()
			cutscene:wait(0.5)
			battler:setAnimation("battle/idle")
			if kris then
				local kris_member = Game:getPartyMember("kris")
				if kris_member.health <= 0 then
					local reviveamt = math.abs(kris_member.health) + 1
					kris:heal(reviveamt)
				else
					cutscene:text("* (But, Kris wasn't DOWNed...)")
				end
			end
        end)
        return
	elseif name == "ReviveKris" then
        Game.battle:startActCutscene(function(cutscene)
            local kris = Game.battle:getPartyBattler("kris")
			local kris_member = Game:getPartyMember("kris")
            cutscene:text("* "..battler.chara:getName().." used Reviver!")
			battler:setAnimation("battle/spell")
            local bx, by = kris:getRelativePos(0, 0)
            local cherub = Game.battle:addChild(RalseiCherub(kris, bx+20, by+10))
			if kris_member.health > 0 then
				cherub.xoff = cherub.xoff - 6
				cherub.yoff = cherub.yoff - 20
			end
            cherub.layer = kris.layer
			cutscene:wait(58/30)
			battler:setAnimation("battle/idle")
			if kris then
				local starthp = kris_member.health
				if starthp <= 0 then
					kris:heal(math.abs(starthp) + math.ceil(kris_member:getStat("health") / 3))
				else
					kris:heal(math.ceil(kris_member:getStat("health") * 0.5))
				end
			end
        end)
        return
    elseif name == "Analysis" then
        Game.battle:startActCutscene(function(cutscene)
            if not Game:getFlag("susie_got_soul_xacts") then
                if self.phaseturn > 1 then -- more than one turn passed
                    cutscene:text("* (Dammit,[wait:5] they're surrounding us!)", "angry_down", "susie")
                    cutscene:text("* (I gotta think of something before they beat us to death...)", "angry_unsure", "susie")
                end
                cutscene:text("* Hey,[wait:5] wait,[wait:5] I think I know these things!", "surprise", "susie")
                cutscene:text("* You do?", "neutral", "jamm")
                cutscene:text("* Yeah,[wait:5] they're the same that were chasing us back in the Church!", "angry", "susie")
                cutscene:text("* Wait,[wait:5] if you know them...", "nervous_left", "jamm")
                cutscene:text("* How do we defeat them?", "neutral", "jamm")
                cutscene:text("* Well,[wait:5] back then we were just running away,[wait:5] but...", "nervous_side", "susie")
                cutscene:text("* Yeah,[wait:5] I don't think that'll work right now.", "nervous", "susie")
                if Game:getFlag("future_variable") == "ceroba_dw" then
                    cutscene:text("* So is there anything else we can do?", "neutral", "ceroba")
                end
                cutscene:text("* ...[wait:5] they WERE chasing us only in the dark,[wait:5] so maybe...", "nervous_side", "susie")
                cutscene:text("* Jamm,[wait:5] can you do that light thingy with your soul?", "neutral", "susie")
                cutscene:text("* What \"light thingy\"?", "suspicious", "jamm")
                cutscene:text("* Well,[wait:5] you know...[wait:5] When your soul is glowing like a flashlight.", "neutral_side", "susie")
                cutscene:text("* I thought all humans could do that?", "nervous_side", "susie")
				local texts = {"You see--", "Uh--", "Um--", "Well--", "I--"}
				for i=1, 6 do
					cutscene:text("[noskip:true]* " .. TableUtils.pick(texts), "speechless", "jamm", {auto=true})
				end
                cutscene:text("* W-wait,[wait:5] why can't you try it?", "nervous", "jamm")
                cutscene:text("* ...[wait:5] I mean,[wait:5] I could,[wait:5] but there's no guarantee it'll actually--", "neutral", "susie", {auto = true})
                battler:setSprite("shock_right")
                battler:flash()
                Assets.playSound("boost")
                local bx, by = Game.battle:getSoulLocation()
                local soul = Sprite("effects/soulshine_s", bx - 5.5, by)
                soul:play(1 / 30, false, function() soul:remove() end)
                soul:setOrigin(0.5)
                soul:setScale(2, 2)
                Game.battle:addChild(soul)
                cutscene:text("* (Susie's SOUL shined with bright light!)")
                battler:setAnimation("battle/idle")
                cutscene:text("* Oh hey,[wait:5] what do you know,[wait:5] it works!", "surprise_smile", "susie")
                cutscene:text("* (New [color:yellow]ACT[color:reset]s are now available in Susie's [color:yellow]MAGIC[color:reset] menu.)")
                Game.battle.encounter.light_radius = 48
                Game.battle:registerXAction("susie", "Brighten", "Powerup\nlight", 4)
                Game.battle:registerXAction("susie", "Semi-Banish", "Defeat one\nenemy", 64)
                Game:setFlag("susie_got_soul_xacts", true)
            else
                if Game.tension >= 64 then
                    cutscene:text("* (Alright,[wait:5] now just gotta...)", "nervous", "susie")
                    cutscene:text("* (Wait,[wait:5] how was Kris doing that again?)", "nervous_side", "susie")
                    cutscene:text("* (You can use [color:yellow]SEMI-BANISH[color:reset] from Susie's [color:yellow]MAGIC[color:reset] menu!)")
                else
                    cutscene:text("* (These things seem to be vulnerable to light...)", "neutral_side", "susie")
                    cutscene:text("* (Maybe if I collect more [color:yellow]TP[color:reset],[wait:5] I could try something.)", "neutral", "susie")
                end
            end
        end)
        return
    elseif name == "Standard" then
        Game.battle:startActCutscene(function(cutscene)
            cutscene:text("* "..battler.chara:getName().." tried to \"[color:yellow]ACT[color:reset]\"...\n* But, the enemy couldn't understand!")
        end)
        return
    end
    return super.onAct(self, battler, name)
end

function TitanSpawn:getEnemyDialogue()
    return false
end

function TitanSpawn:onTurnEnd()
    self.phaseturn = self.phaseturn + 1

    if self.phaseturn > 3 then
        self.phaseturn = 2
    end
end

function TitanSpawn:getNextWaves()
    if self.phaseturn == 1 then
        return { "titan_spawn/darkshapesintro" }
    end
    if self.phaseturn == 2 then
        return { "titan_spawn/darkshapesspeedup" }
    end
    if self.phaseturn == 3 then
        return { "titan_spawn/darkshapeswithred" }
    end

    return super.getNextWaves(self)
end

function TitanSpawn:onSpared()
	local recruit = RecruitMessage("purified", self.target_x, self.y - 40)
	recruit.start_x = self.target_x
	Game.battle:addChild(recruit)
end

function TitanSpawn:onHurt(damage, battler)
	super.onHurt(self, damage, battler)

    Assets.stopAndPlaySound("spawn_weaker")
end

function TitanSpawn:onDefeat(damage, battler)
    self:onDefeatFatal(damage, battler)
end

function TitanSpawn:freeze()
    self:onDefeat()
end

function TitanSpawn:getEncounterText()
	if Game:getTension() < 64 and MathUtils.randomInt(100) < 4 then
		return "* Smells like adrenaline."
    elseif Game:getTension() >= 64 then
		return "* The atmosphere feels tense...\n* (You can use [color:yellow]SEMI-BANISH[color:reset]!)"
	else
		return super.getEncounterText(self)
	end
end

return TitanSpawn