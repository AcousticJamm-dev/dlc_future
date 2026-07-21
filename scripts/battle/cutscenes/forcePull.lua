return function(cutscene)
	local first=Game.battle.enemies[1].wake_first
	local loss=Game.battle.enemies[1].fail_first
	local win=Game.battle.enemies[1].win_first
	
	local s=Game.battle.enemies[1].susie_pull
	local j=Game.battle.enemies[1].jamm_pull
	local v=Game.battle.enemies[1].var_pull
	
	local function reviveIfNeeded(ally)
		local health = ally.chara:getHealth()
		local heal_amount
		if health >= 1 then return false end
		heal_amount = math.abs(health) + MathUtils.randomInt(10, 25)
		-- healitemspell doesn't show UP I think
		ally:heal(heal_amount)
		return true
	end

	local function createForcePull()
		local data = {}
		
		data.value = 0
		data.keys = {"confirm", "menu", "cancel"}
		data.chosen_key = TableUtils.pick(data.keys)
		
		data.playtime = MathUtils.random(3.7, 5.3)
		
		data.noelle_flash = false
		
		data.bg = Rectangle(91, 108, 449, 19)
		data.bg.color = {0, 0, 0}
		data.bg.layer = BATTLE_LAYERS["top"]+10
		data.bg.alpha = 0
		Game.battle.timer:tween(0.5, data.bg, {alpha = 1})
		Game.battle:addChild(data.bg)
		data.bar_player = Rectangle(93, 110, 0, 15)
		data.bar_player.color = {1, 0, 0}
		data.bar_player.layer = BATTLE_LAYERS["top"]+13
		data.bar_player.alpha = 0
		Game.battle.timer:tween(0.5, data.bar_player, {alpha = 1})
		Game.battle:addChild(data.bar_player)
		data.bar_back = Rectangle(93, 110, 445, 15)
		data.bar_back.color = {0.2, 0.2, 0.2}
		data.bar_back.layer = BATTLE_LAYERS["top"] + 12
		data.bar_back.alpha = 0
		Game.battle.timer:tween(0.5, data.bar_back, {alpha = 1})
		Game.battle:addChild(data.bar_back)
		
		data.text=Text("", 150, 40, {style = "none"})
		data.text.layer=BATTLE_LAYERS["top"]+14
		Game.battle:addChild(data.text)
		
		data.text2=Text("", 205, 72, {style = "none"})
		data.text2.layer=BATTLE_LAYERS["top"]+14
		Game.battle:addChild(data.text2)

		return data
	end
	
	for _, member in ipairs(Game.battle.party) do
		reviveIfNeeded(member)
	end

	local susie=cutscene:getCharacter("susie")
	local jamm=cutscene:getCharacter("jamm")
	local variant=Game.battle.party[3]
	local noelle=cutscene:getCharacter("fnoelle_weird")
	if first then
		cutscene:text("* Hold on!", "surprise_frown", "susie")
	    cutscene:text("* That weird ring on her finger...", "surprise", "susie")
	    cutscene:text("* It...[wait:10] looks like a torture device...", "nervous_side", "susie")
		cutscene:text("* It...[wait:10] it must be!", "speechless", "jamm")
		if Game:getFlag("future_variable") == "ceroba" then
			cutscene:text("* Perhaps removing it would help us?", "surprised", "ceroba")
		end
		cutscene:text("* It's the best we've got...", "nervous", "jamm")
	end
    local forcePull = createForcePull()
    local orig_susie_x, orig_jamm_x, orig_var_x, orig_noelle_x=susie.x, jamm.x, variant.x, noelle.x
    local orig_susie_y, orig_jamm_y, orig_var_y, orig_noelle_y=susie.y, jamm.y, variant.y, noelle.y
	if s then
		cutscene:slideTo(susie, 305, noelle.y, 0.3, "out-cubic")
	end
	
	if j then
		cutscene:slideTo(jamm, 284, noelle.y + 20, 0.3, "out-cubic")
	end
	
	if v then
		cutscene:slideTo(variant, 305, noelle.y + 40, 0.3, "out-cubic")
	end
	
    cutscene:slideTo(noelle, 346, noelle.y + 20, 0.3, "out-cubic")
    cutscene:wait(0.5)
    Assets.playSound("noise")
    cutscene:wait(0.25)
    if first then
    	cutscene:text("* Wh-Wha-", "trance-surprise", "noelle")
		if s then
			cutscene:text("* Merry Christmas!!!", "teeth", "susie")
		elseif j then
			cutscene:text("* Hold still,[wait:5] Noelle!", "powerful", "jamm")
		else
			if Game:getFlag("future_variable") == "ceroba" then
				cutscene:text("* This is for your own good.", "nervous", "ceroba")
			end
		end
    else
    	cutscene:wait(0.5)
    end
    
	forcePull.text:setText("Hold down " .. Input.getText("left") .. " when ready.")
	
	cutscene:wait(function() return Input.down("left") end)
	
	forcePull.text:setText("Release " .. Input.getText("left") .. " to escape!")
	forcePull.text2:setText("Press "..Input.getText(forcePull.chosen_key).."!")
	
	local minigame_done = false
	local success
	
	cutscene:during(function()
		if not Input.down("left") then
			success = true
			minigame_done = true
			goto loop_end
		end
		
		forcePull.playtime = forcePull.playtime - DT
		if forcePull.playtime <= 0.5 and not forcePull.noelle_flash then
			forcePull.noelle_flash = true
			noelle:flash()
			Assets.playSound("boost_fast")
		end
		if forcePull.playtime <= 0 then
			success = false
			minigame_done = true
			goto loop_end
		end
		
		local wrong_pressed = false
		
		for i,key in ipairs(forcePull.keys) do
	    	if key ~= forcePull.chosen_key and Input.pressed(key) then
				wrong_pressed = true
				break
			end
	    end
		
		if wrong_pressed then
			forcePull["value"] = math.max(forcePull["value"] - 0.2, 0)
			Assets.playSound("error")
			forcePull["chosen_key"] = TableUtils.pick(forcePull["keys"])
			forcePull.text2:setText("Press "..Input.getText(forcePull["chosen_key"]).."!", 205, 40, {style = "none"})
		elseif Input.pressed(forcePull["chosen_key"]) then
			forcePull["value"] = math.min(forcePull["value"] + 0.1, 1)
			Assets.playSound("noise")
			forcePull["chosen_key"] = TableUtils.pick(forcePull["keys"])
			forcePull.text2:setText("Press "..Input.getText(forcePull["chosen_key"]).."!", 205, 40, {style = "none"})
		end
		
		forcePull.bar_player.width=(445*forcePull.value)
		
		::loop_end::
	end, true)
	
	cutscene:wait(function() return minigame_done end)
	
	Game.battle.timer:tween(0, forcePull.bg, {alpha = 0})
	Game.battle.timer:tween(0, forcePull.bar_player, {alpha = 0})
	Game.battle.timer:tween(0, forcePull.bar_back, {alpha = 0})
	
	forcePull.text:setText("")
	forcePull.text2:setText("")
	forcePull.text:remove()
	forcePull.text2:remove()
	
	cutscene:during(function() end, true)
	
	if not success then
		local particles = {}
		
		local function createParticle(x, y)
			local sprite = Sprite("effects/icespell/snowflake", x, y)
			sprite:setOrigin(0.5, 0.5)
			sprite:setScale(1.5)
			sprite.layer = BATTLE_LAYERS["above_battlers"]
			Game.battle:addChild(sprite)
			return sprite
		end
		
		cutscene:wait(1/30)
        Assets.playSound("icespell")
        particles[1] = createParticle(325, noelle.y - 40)
        cutscene:wait(3/30)
        particles[2] = createParticle(275, noelle.y - 40)
        cutscene:wait(3/30)
        particles[3] = createParticle(300, noelle.y)
        cutscene:wait(3/30)
        Game.battle:addChild(IceSpellBurst(300, noelle.y))
        for _,particle in ipairs(particles) do
            for i = 0, 5 do
                local effect = IceSpellEffect(particle.x, particle.y)
                effect:setScale(0.75)
                effect.physics.direction = math.rad(60 * i)
                effect.physics.speed = 8
                effect.physics.friction = 0.2
                effect.layer = BATTLE_LAYERS["above_battlers"] - 1
                Game.battle:addChild(effect)
            end
        end
		
        cutscene:wait(1/30)
        for _,particle in ipairs(particles) do
            particle:remove()
        end
        cutscene:wait(4/30)

        if s then
			Game.battle.party[1]:hurt(math.ceil(Game.battle.party[1].chara:getStat("health")/5), true)
		end
        if j then
			Game.battle.party[2]:hurt(math.ceil(Game.battle.party[2].chara:getStat("health")/5), true)
		end
        if v then
			Game.battle.party[3]:hurt(math.ceil(Game.battle.party[3].chara:getStat("health")/5), true)
		end
        cutscene:wait(0.5)
	else
		local num = 4
		if s then num = num - 1 end
		if j then num = num - 1 end
		if v then num = num - 1 end
		Game.battle.enemies[1]:addMercy(Utils.round((10*forcePull.value)/num))
	end
	
	if s then
		cutscene:slideTo(susie, orig_susie_x, orig_susie_y, 0.3, "out-cubic")
	end
	if j then
		cutscene:slideTo(jamm, orig_jamm_x, orig_jamm_y, 0.3, "out-cubic")
	end
	if v then
		cutscene:slideTo(variant, orig_var_x, orig_var_y, 0.3, "out-cubic")
	end
    cutscene:slideTo(noelle, orig_noelle_x, orig_noelle_y, 0.3, "out-cubic")
	
	if s then
		Game.battle.enemies[1].susie_pull = false
	end
	if j then
		Game.battle.enemies[1].jamm_pull = false
	end
	if v then
		Game.battle.enemies[1].var_pull = false
	end
	
	if success and forcePull.value > 0 then
		if Game.battle.enemies[1].mercy < 100 then
			cutscene:wait(1)
			Assets.playSound("hurt")
			local num = 0
			if s then num = num + 1 end
			if j then num = num + 1 end
			if v then num = num + 1 end
			Game.battle.enemies[1]:hurt(Utils.round(20*num*(forcePull.value+Utils.random())), nil, function()
				Game.battle.enemies[1]:onDefeatThorn()
				Game.battle:setState("NONE")
				cutscene:endCutscene()
			end)
			if Game.battle.enemies[1].health < 0 then
				return
			end
			cutscene:text("* Noelle got hurt by the CrimsonSpire!")
			if win then
				Game.battle.enemies[1].win_first = false
				cutscene:text("* Oh great,[wait:5] we also have to be careful of that.", "annoyed", "susie")
				cutscene:text("* That's not an issue for me,[wait:5] Susie.", "smirk", "jamm")
				cutscene:text("* Jamm's courage is showing...[wait:10]\n* HealSling became Healsling+!")
				Game:setFlag("healsling_plus", true)
			end
			if s then
				Game.battle:finishActionBy(Game.battle.party[1])
			end
			if j then
				Game.battle:finishActionBy(Game.battle.party[2])
			end
			if v then
				Game.battle:finishActionBy(Game.battle.party[3])
			end
		else
			Assets.playSound("noise")
			Assets.playSound("snd_ominous_cancel")
			cutscene:wait(1)
			Game.battle.timer:tween(2, Game.battle.music, {volume=0})
			cutscene:wait(2.5)
			cutscene:text("* You got the CrimsonSpire!")
			Game:setFlag("dark_future_ending", "weird_mercy")
			cutscene:after(function() Game.battle:returnToWorld() end)

			Game.battle:setState("TRANSITIONOUT")
			cutscene:wait(1)
			if s then
				Game.battle:finishActionBy(Game.battle.party[1])
			end
			if j then
				Game.battle:finishActionBy(Game.battle.party[2])
			end
			if v then
				Game.battle:finishActionBy(Game.battle.party[3])
			end
		end
	elseif loss then
		Game.battle.enemies[1].fail_first = false
		cutscene:text("* That's going to be an issue...", "ouch", "jamm")
		if Game:getFlag("future_variable") == "ceroba" then
			cutscene:text("* I don't feel like we made any progress...", "dissapproving", "ceroba")
		end
		cutscene:text("* The ring slipped back up due to her counterattack...", "annoyed", "susie")
		cutscene:text("* Looks like we need to be careful of how long we're pulling.", "powerful", "jamm")
		cutscene:text("* Next time,[wait:5] let's [color:yellow]back out just before she attacks[color:white].", "stern", "jamm")
		if s then
			Game.battle:finishActionBy(Game.battle.party[1])
		end
		if j then
			Game.battle:finishActionBy(Game.battle.party[2])
		end
		if v then
			Game.battle:finishActionBy(Game.battle.party[3])
		end
	end
end