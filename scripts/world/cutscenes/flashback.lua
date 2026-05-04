return {
	progress = function(cutscene, event)
		cutscene:showNametag("Marcy")
		cutscene:text("* We're so close to finishing our mission...", "neutral", "fmarcy")
		cutscene:hideNametag()
		cutscene:wait(cutscene:walkTo(Game.world.player, Game.world.player.x + 40, Game.world.player.y, 1))
    end,
	
	slitherer = function(cutscene, event)
		Game:setFlag("future_f_slitherer", true)
		cutscene:showNametag("Marcy")
		cutscene:text("* Another one of these things...", "neutral", "fmarcy")
		if Game:getFlag("future_variable") == "ceroba" then
			cutscene:showNametag("Kanako")
			cutscene:text("* We just can't catch a break, can we?", "unimpressed", "fkanako")
		end
		cutscene:hideNametag()
		local s = cutscene:getCharacter("slitherer")
		local w, e = cutscene:startEncounter("slitherer", true, {s}, {wait = false})
		s:remove()
		cutscene:wait(function() return w end)
    end,
	
	spawn = function(cutscene, event)
		Game:setFlag("future_f_spawn", true)
		local s1 = Game.world:addChild(TitanSpawnOverworld(Game.world.player.x + 220, Game.world.player.y - 20, nil, false))
		cutscene:wait(0.4)
		local s2 = Game.world:addChild(TitanSpawnOverworld(Game.world.player.x - 200, Game.world.player.y - 130, nil, true))
		cutscene:wait(0.4)
		local s3 = Game.world:addChild(TitanSpawnOverworld(Game.world.player.x - 260, Game.world.player.y + 110, nil, true))
		cutscene:wait(1)
		cutscene:showNametag("Marcy")
		cutscene:text("* Huh...[wait:5] That's new.", "closed", "fmarcy")
		cutscene:showNametag("Noelle")
		cutscene:text("* And yet somehow,[wait:5] familiar...", "tense/guilty_1", "fnoelle")
		cutscene:hideNametag()
		Game.world.timer:tween(0.8, s1, {alpha = 0})
		Game.world.timer:tween(0.8, s2, {alpha = 0})
		Game.world.timer:tween(0.8, s3, {alpha = 0})
		cutscene:wait(1)
		cutscene:startEncounter("spawn_solo")
		if Game:getFlag("future_variable") == "ceroba" then
			cutscene:showNametag("Kanako")
			cutscene:text("* That...[wait:5] was creepy...", "shock", "fkanako")
		end
		cutscene:showNametag("Marcy")
		cutscene:text("* Did you two feel that?[wait:10]\n* It somehow restricted us.", "closed", "fmarcy")
		cutscene:showNametag("Noelle")
		cutscene:text("* And how easy it was to...", "shaded/scared_shade_2", "fnoelle")
		cutscene:showNametag("Marcy")
		cutscene:text("* ...", "closed", "fmarcy")
		cutscene:text("* Let's keep going.", "neutral", "fmarcy")
    end,
	
	chase = function(cutscene, event)
		cutscene:wait(cutscene:mapTransition("flashback/field_4", "marcy_marker"))
		local fmarcy = cutscene:getCharacter("fmarcy")
		local fnoelle = cutscene:getCharacter("fnoelle")
		local fvariant = cutscene:getCharacter(Game.party[3].id)
		
		cutscene:detachFollowers()
		
		fnoelle.x = 160
		fnoelle.y = 3120
		
		fvariant.x = 480
		fvariant.y = 3120
		
		cutscene:walkToSpeed(fnoelle, fnoelle.x, fnoelle.y - 280, 6)
		cutscene:walkToSpeed(fvariant, fvariant.x, fvariant.y - 280, 6)
		cutscene:wait(cutscene:walkToSpeed(fmarcy, fmarcy.x, fmarcy.y - 280, 6))
		
		cutscene:showNametag("Marcy", {top=true})
		cutscene:text("* ...The Knight must be up ahead.", "closed", "fmarcy", {top=true})
		if Game:getFlag("future_variable") == "ceroba" then
			cutscene:showNametag("Kanako", {top=true})
			cutscene:text("* Great![wait:10]\n* We can just--", "shock", "fkanako", {auto=true,top=true})
		end
		cutscene:hideNametag()
		
		Game.world.cw = Game.world:addChild(ChurchWind(0, 2480))
		Game.world.cw:setLayer(WORLD_LAYERS["above_events"])
		
		Assets.playSound("knightroar")
		
		cutscene:wait(0.4)
		
		fmarcy:setSprite("heavy_walk_1")
		fmarcy.scarf = fmarcy:addChild(Sprite("party/future_marcy/dark/scarf_flap_1"))
		fmarcy.scarf:setAnimation({"party/future_marcy/dark/scarf_flap", 1/15, true})
		-- TODO: Heavy walk for F!Noelle and F!Variant
		
		cutscene:slideTo(fmarcy, fmarcy.x, fmarcy.y + 40, 0.6, "out-cubic")
		cutscene:slideTo(fnoelle, fnoelle.x, fnoelle.y + 40, 0.6, "out-cubic")
		cutscene:slideTo(fvariant, fvariant.x, fvariant.y + 40, 0.6, "out-cubic")
		
		cutscene:wait(3.4)
		
		cutscene:showNametag("Marcy", {top=true})
		cutscene:text("* The hell is this wind...!", "mad", "fmarcy", {top=true})
		cutscene:hideNametag()
		
		local sword = Sprite("bullets/world/knight_sword")
		sword:setOrigin(0.5, 0)
		sword.x = 480
		sword.y = 2520
		sword.alpha = 0
		sword:setScale(2)
		sword:setLayer(WORLD_LAYERS["above_events"])
		Game.world:addChild(sword)
		
		Assets.playSound("knight_jump_quick")
		
		Game.world.timer:tween(0.4, sword, {alpha = 1})
		cutscene:wait(0.5)
		
		Game.world.timer:tween(0.3, sword, {color = {1, 0, 0}})
		Game.world.timer:tween(0.3, sword, {y = 2480}, "out-quad")
		cutscene:wait(0.3)
		
		sword:remove()
		
		local swords = {}
		
		for i=1, 8 do
			local sword = Sprite("bullets/world/knight_sword")
			sword:setOrigin(0.5, 0)
			sword.x = 480
			sword.y = 2520 + ((i-1) * 60)
			sword.alpha = (1/9) * i
			sword:setScale(2)
			sword:setLayer(WORLD_LAYERS["above_events"])
			Game.world:addChild(sword)
			table.insert(swords, sword)
		end
		
		cutscene:wait(0.1)
		
		for i=8, 1, -1 do
			swords[i]:remove()
		end
		
		Game.world.music:play("creepychase", 1)
		
		Assets.playSound("t_down", 0.35)
		
		Game.world:addChild(DamageNumber("msg", "down", fvariant.x + 20, fvariant.y - 50))
		
		cutscene:slideTo(fvariant, fvariant.x, fvariant.y + 200, 0.2)
		
		cutscene:wait(1)
		
		cutscene:showNametag("Noelle", {top=true})
		cutscene:text("* " .. Game.party[3]:getName() .. "!!", "normal/shocked", "fnoelle", {top=true})

		if Game:getFlag("future_variable") == "ceroba" then
			cutscene:showNametag("Kanako", {top=true})
			cutscene:text("* I-I'm okay...!", nil, "fkanako", {top=true})
			cutscene:text("* Go on without me![wait:10]\n* I'll catch up!", nil, "fkanako", {top=true})
		end
		
		cutscene:showNametag("Marcy", {top=true})
		cutscene:text("* Now or never,[wait:5] Noelle!", "shaded_neutral", "fmarcy", {top=true})
		cutscene:hideNametag()
		
		Game.world:setBattle(true)
		Game.world.player:setState("WINDWALK")
		
		Game:setFlag("tempflag2", Game.party[3].id)
		
		Game:removePartyMember("fnoelle")
		Game:removePartyMember(Game.party[2].id)
    end,
	
	end_chase = function(cutscene, event)
		Game.world:setBattle(false)
		Game.world.player:setState("WALK")
		Game.world.player:resetSprite()
		Game.world.player:setSprite("heavy_walk_1")
		Game.world.cw:remove()
		Game:setPartyMembers("fmarcy", "fnoelle", Game:getFlag("tempflag2", "fkanako"))
		
		Game.world.music:fade(0, 1)
		
		cutscene:wait(1)
		
		cutscene:shakeCharacter(Game.world.player, 4)
		Game.world.player:resetSprite()
		cutscene:look(Game.world.player, "up")
		Assets.playSound("wing")
		Game.world.player.scarf:remove()
		
		cutscene:wait(1)
		
		cutscene:showNametag("Marcy")
		cutscene:text("* ...That was quite the onslaught...", "closed", "fmarcy")
		if Game.party[1].health == 1800 then
			-- TODO: Knight chase no-hit achievement
			cutscene:text("* Made it through unharmed,[wait:5] sure,[wait:5] but still...", "neutral", "fmarcy")
            
            DP:completeAchievement("chase_knight_nohit")
		end
		cutscene:text("* ...Hope that made the Knight more tired.", "closed", "fmarcy")
		cutscene:hideNametag()
		
		Game.world.player:walkTo(Game.world.player.x, 80, 3)
		
		cutscene:wait(cutscene:fadeOut(3))
		
		cutscene:loadMap("flashback/field_5", 320, 1200)
		
		local fmarcy = cutscene:getCharacter("fmarcy")
		local fnoelle = cutscene:getCharacter("fnoelle")
		local fvariant = cutscene:getCharacter(Game.party[3].id)
		
		cutscene:detachFollowers()
		
		fnoelle.x = 320
		fnoelle.y = 920
		
		fvariant.x = 320
		fvariant.y = 1280
		
		cutscene:wait(cutscene:fadeIn(0.75))
		cutscene:wait(cutscene:walkToSpeed(Game.world.player, 320, 1000, 4))
		
		cutscene:look(fnoelle, "down")
		cutscene:showNametag("Marcy")
		cutscene:text("* Glad that's over...", "closed", "fmarcy")
		cutscene:showNametag("Noelle")
		cutscene:text("* You could say that again.", "tense/guilty_1", "fnoelle")
		cutscene:look(fnoelle, "up")
		cutscene:text("* But we're not done for too long...", "normal/neutral", "fnoelle")
		cutscene:hideNametag()
		
		cutscene:detachCamera()
		
		cutscene:wait(cutscene:panTo(320, 160, 2))
		cutscene:wait(1)
		
		cutscene:showNametag("Marcy")
		cutscene:text("* We made it.[wait:10]\n* The Knight is within our reach.", "neutral", "fmarcy")
		cutscene:text("* Just what are they planning...?", "mad", "fmarcy")
		cutscene:showNametag("Noelle")
		cutscene:text("* Do they even know we're here...?", "normal/scared", "fnoelle")
		cutscene:hideNametag()
		
		fvariant.y = 1100
		
		cutscene:wait(cutscene:attachCamera(2))
		
		cutscene:showNametag("Marcy")
		cutscene:text("* Come on,[wait:10] you two.[wait:5]\n* Let's finish this.", "closed", "fmarcy")
		cutscene:hideNametag()
		
		cutscene:wait(cutscene:attachFollowers(4))
    end,
	
	ENGAGE = function(cutscene, event)	-- no I did not have caps lock on
		local fmarcy = cutscene:getCharacter("fmarcy")
		local fnoelle = cutscene:getCharacter("fnoelle")
		local fvariant = cutscene:getCharacter(Game.party[3].id)
		
		local knight = cutscene:getCharacter("knight")
		
		cutscene:detachFollowers()
		
		cutscene:showNametag("Marcy")
		cutscene:text("* Hold on...", "neutral", "fmarcy")
		cutscene:hideNametag()
		
		cutscene:walkToSpeed(fmarcy, 500, 600, 6, "up")
		cutscene:walkToSpeed(fnoelle, 120, 660, 6, "right")
		cutscene:wait(cutscene:walkToSpeed(fvariant, 180, 600, 6, "up"))
		
		cutscene:wait(cutscene:panTo(320, 160, 2))
		cutscene:wait(1)
		
		knight:setSprite("idle")
		
		Game.world.timer:tween(0.8, knight, {x = 390}, "in-out-back")
		cutscene:wait(1.2)
		
		Assets.playSound("knight_cut")
		knight:setAnimation("attack_nl")
		cutscene:wait(3/25)
		
		local rift = Game.world:addChild(GreatTear(320, 160))
		rift:setScale(0.03)
		rift:setLayer(0.2)
		
		Game.world.timer:tween(0.6, rift, {scale_y = 2}, "out-cubic")
		cutscene:wait(0.6)
		
		Assets.playSound("battleenter")
		Game.world.timer:tween(0.6, rift, {scale_x = 2}, "in-quart")
		cutscene:wait(0.6)
		
		Assets.playSound("ominous_shine")
		
		local rift2 = Sprite("world/cutscenes/great_tear")
		rift2:setScale(0.2)
		rift2:setOrigin(0.5)
		rift2:setLayer(2)
		rift2.x = 320
		rift2.y = 160
		rift2.alpha = 0.5
		
		Game.world:addChild(rift2)
		Game.world.timer:tween(0.5, rift2, {scale_x = 2.5, scale_y = 2.5, alpha = 0}, "in-quart")
		cutscene:wait(1.3)
		
		knight:setSprite("idle")
		cutscene:wait(0.2)
		
		Game.world.timer:tween(0.8, knight, {x = 320}, "in-out-back")
		cutscene:wait(1.3)
		
		knight:setSprite("looking_up")
		
		Game.world.timer:tween(0.8, knight, {y = 360}, "out-cubic")
		cutscene:wait(1.3)
		
		cutscene:wait(cutscene:attachCamera(2))

		if Game:getFlag("future_variable") == "ceroba" then
			cutscene:showNametag("Kanako")
			cutscene:text("* That's the biggest rift I've ever seen...!", "shock", "fkanako")
		end
		
		cutscene:showNametag("Marcy")
		cutscene:text("* Unstable too...", "mad", "fmarcy")
		
		cutscene:showNametag("Noelle")
		cutscene:text("* Where do you think it leads?", "normal/neutral", "fnoelle")
		
		cutscene:look(fmarcy, "left")
		cutscene:look(fvariant, "right")
		
		cutscene:showNametag("Marcy")
		cutscene:text("* I don't know,[wait:5] but one thing's for sure...", "neutral", "fmarcy")
		cutscene:text("* We have to--", "neutral", "fmarcy", {auto = true})
		cutscene:hideNametag()
		
		local sword = Sprite("bullets/world/knight_sword")
		sword:setOrigin(0.5, 0)
		sword.x = 600
		sword.y = 600
		sword.alpha = 0
		sword.rotation = math.rad(90)
		sword:setScale(2)
		sword:setLayer(WORLD_LAYERS["above_events"])
		Game.world:addChild(sword)
		
		local sword2 = Sprite("bullets/world/knight_sword")
		sword2:setOrigin(0.5, 0)
		sword2.x = 40
		sword2.y = 600
		sword2.alpha = 0
		sword2.rotation = math.rad(270)
		sword2:setScale(2)
		sword2:setLayer(WORLD_LAYERS["above_events"])
		Game.world:addChild(sword2)
		
		Assets.playSound("knight_jump_quick")
		
		Game.world.timer:tween(0.4, sword, {alpha = 1})
		Game.world.timer:tween(0.4, sword2, {alpha = 1})
		cutscene:wait(0.5)
		
		Game.world.timer:tween(0.3, sword, {color = {1, 0, 0}})
		Game.world.timer:tween(0.3, sword, {x = 640}, "out-quad")
		Game.world.timer:tween(0.3, sword2, {color = {1, 0, 0}})
		Game.world.timer:tween(0.3, sword2, {x = 0}, "out-quad")
		cutscene:wait(0.3)
		
		sword:remove()
		sword2:remove()
		
		local swords = {}
		
		for i=1, 8 do
			local sword = Sprite("bullets/world/knight_sword")
			sword:setOrigin(0.5, 0)
			sword.x = 600 - ((i-1) * 60)
			sword.y = 600
			sword.alpha = (1/9) * i
			sword:setScale(2)
			sword.rotation = math.rad(90)
			sword:setLayer(WORLD_LAYERS["above_events"])
			Game.world:addChild(sword)
			table.insert(swords, sword)
			local sword2 = Sprite("bullets/world/knight_sword")
			sword2:setOrigin(0.5, 0)
			sword2.x = 40 + ((i-1) * 60)
			sword2.y = 600
			sword2.alpha = (1/9) * i
			sword2:setScale(2)
			sword2.rotation = math.rad(270)
			sword2:setLayer(WORLD_LAYERS["above_events"])
			Game.world:addChild(sword2)
			table.insert(swords, sword2)
		end
		
		cutscene:wait(0.1)
		
		for i=16, 1, -1 do
			swords[i]:remove()
		end
		
		Assets.playSound("hurt")
		
		Game.world.music:play("GALLERY", 0.7, 0.75)
		
		fmarcy:setAnimation("battle/defeat")
		-- fnoelle:setAnimation("battle/defeat")
		-- fvariant:setAnimation("battle/defeat")
		
		cutscene:slideTo(fmarcy, 380, 600, 0.5, "out-cubic")
		cutscene:slideTo(fnoelle, 340, 660, 0.5, "out-cubic")
		cutscene:wait(cutscene:slideTo(fvariant, 300, 600, 0.6, "out-cubic"))
		knight.sprite.aetrail = false
		
		cutscene:wait(0.3)
		
		cutscene:shakeCharacter(fmarcy, 3)
		Assets.playSound("wing")
		
		cutscene:wait(0.8)
		
		cutscene:shakeCharacter(fmarcy, 3)
		Assets.playSound("wing")
		
		cutscene:wait(0.3)
		
		cutscene:shakeCharacter(fmarcy, 3)
		Assets.playSound("wing")
		cutscene:setSprite(fmarcy, "threaten")
		
		cutscene:wait(0.8)
		
		cutscene:showNametag("Marcy")
		cutscene:text("* You...", "closed", "fmarcy")
		cutscene:hideNametag()
		
		cutscene:wait(cutscene:panTo(320, 320, 2))
		
		cutscene:resetSprite(fmarcy)
		cutscene:wait(cutscene:walkToSpeed(fmarcy, knight.x, knight.y + 60, 3, "up"))
		
		cutscene:wait(0.3)
		
		knight:setAnimation({"turn", 0.2, false})
		
		cutscene:wait(2.4)
		
		cutscene:showNametag("Marcy", {top = false})
		cutscene:text("* There's only one way this will end,[wait:5] Knight.", "neutral", "fmarcy", {top = false})
		cutscene:text("* One way or another,[wait:5] you've already lost...", "neutral", "fmarcy", {top = false})
		cutscene:setSprite(fmarcy, "threaten")
		cutscene:text("* So will this go the easy way or the hard way?", "neutral", "fmarcy", {top = false})
		cutscene:hideNametag()
		
		local laugh = Assets.playSound("knight_laugh")
		laugh:setLooping(true)
		knight:setAnimation("laughing_anim")
		knight.sprite.floating = false
		
		cutscene:wait(1.2)
		
		cutscene:resetSprite(fnoelle)
		cutscene:resetSprite(fvariant)
		
		cutscene:walkToSpeed(fnoelle, fmarcy.x - 40, fmarcy.y + 40, 6, "up")
		cutscene:wait(cutscene:walkToSpeed(fvariant, fmarcy.x + 40, fmarcy.y + 40, 6, "up"))

		if Game:getFlag("future_variable") == "ceroba" then
			cutscene:showNametag("Kanako", {top = false})
			cutscene:text("* It's laughing...[wait:10]\n* Wh-why is it laughing!?", "shock", "fkanako", {top = false})
		end
		
		cutscene:showNametag("Noelle", {top = false})
		cutscene:text("* I-I...[wait:10]\n* I don't think it's giving in...", "tense/guilty_2", "fnoelle", {top = false})
		
		cutscene:showNametag("Marcy", {top = false})
		cutscene:text("* Then you two know what we must do,[wait:5] don't you?", "closed", "fmarcy", {top = false})
		knight:setAnimation({"laugh_stop", 1, false})
		laugh:stop()
		cutscene:text("* It's as I always say.[wait:10]\n* If you don't see the dawn...", "closed", "fmarcy", {top = false})
		cutscene:hideNametag()
		
		cutscene:resetSprite(fmarcy)
		
		cutscene:walkToSpeed(fmarcy, 120, 280, 6, "right")
		cutscene:walkToSpeed(fnoelle, 100, 340, 6, "right")
		cutscene:wait(cutscene:walkToSpeed(fvariant, 80, 400, 6, "right"))
		
		knight:setSprite("idle")
		
		fmarcy:setAnimation("battle/attack")
		-- fnoelle:setAnimation("battle/attack")
		-- fvariant:setAnimation("battle/attack")
		
		Assets.playSound("laz_c")
		
		cutscene:wait(1.2)
		
		cutscene:showNametag("Marcy", {top = false})
		cutscene:text("* [speed:0.5]...then make it worth fighting for.", "mad", "fmarcy", {top = false})
		cutscene:hideNametag()
		
		fmarcy:setAnimation("battle/idle")
		-- fnoelle:setAnimation("battle/idle")
		-- fvariant:setAnimation("battle/idle")
		
		Game.world.timer:tween(0.8, knight, {x = 540}, "in-out-back")
		cutscene:wait(1)
		
		Game.world.music:stop()
		
		cutscene:text("* TODO: Fight intro and encounter")
		
		cutscene:resetSprite(fmarcy)
		cutscene:resetSprite(fnoelle)
		cutscene:resetSprite(fvariant)
		
		knight.sprite.aetrail = true
		
		Game.world.music:play("wind_highplace", 0, 0.5)
		
		cutscene:wait(1)
		
		Game.world.timer:tween(2, Game.world.music, {volume = 1})
		
		cutscene:wait(2)
		
		cutscene:showNametag("Marcy")
		cutscene:text("* Noelle,[wait:5] now's our chance!", "mad", "fmarcy")
		
		if not Game:getFlag("POST_SNOWGRAVE") then
			cutscene:showNametag("Noelle")
			cutscene:text("* Marcy,[wait:5] are you sure?", "normal/neutral", "fnoelle")
			cutscene:showNametag("Marcy")
			cutscene:text("* I'm not about to let this freak go,[wait:5] Noelle.", "mad", "fmarcy")
			cutscene:text("* Freeze them in a Frostcrypt![wait:10]\n* Hurry!", "mad", "fmarcy")
		end
		cutscene:hideNametag()
		
		local continue_var = false
		
		local fc = FrostcryptController(knight.x, knight.y - knight.height/2 - 50, function()
			knight.sprite.frozen = true
			knight.sprite.freeze_progress = 1
			knight.sprite.aetrail = false
			continue_var = true
		end)
		
		Game.world:addChild(fc)
		fc:setLayer(knight.layer + 1)
		
		cutscene:wait(function() return continue_var end)
		
		cutscene:wait(1)
		cutscene:hideNametag()
		
		cutscene:showNametag("Marcy")
		cutscene:text("* ...", "closed", "fmarcy")
		cutscene:text("* We finally...", "closed", "fmarcy")
		cutscene:text("* We finally did it.", "neutral", "fmarcy")
		cutscene:hideNametag()
		
		cutscene:wait(cutscene:walkToSpeed(fmarcy, 320, 300, 4, "right"))
		
		if Game:getFlag("future_variable") == "ceroba" then
			cutscene:showNametag("Kanako")
			cutscene:text("* The war isn't over yet,[wait:5] you know...", "unimpressed", "fkanako")
		end
		cutscene:showNametag("Marcy")
		cutscene:text("* True,[wait:5] but it is a massive turning point.", "neutral", "fmarcy")
		cutscene:text("* You two should feel proud.[wait:10]\n* I know I am.", "closed", "fmarcy")
		
		cutscene:look(fmarcy, "up")
		
		cutscene:showNametag("Marcy")
		cutscene:text("* Now,[wait:5] about this rift...", "neutral", "fmarcy")
		cutscene:hideNametag()
		
		cutscene:panTo(320, 200, 2)
		cutscene:walkTo(fnoelle, 240, 300, 2, "up")
		cutscene:wait(cutscene:walkTo(fvariant, 380, 300, 2, "up"))
		
		cutscene:showNametag("Noelle")
		cutscene:text("* Now that it's open,[wait:5] what should we do about it?", "normal/awkward", "fnoelle")
		if Game:getFlag("future_variable") == "ceroba" then
			cutscene:showNametag("Kanako")
			cutscene:text("* We can't just leave it here unguarded,[wait:5] can we?", "eyes_left", "fkanako")
		end
		cutscene:showNametag("Marcy")
		cutscene:text("* One of us will have to stay behind...", "closed", "fmarcy")
		cutscene:text("* I'll do it.[wait:10]\n* You two,[wait:5] go and make the report.", "neutral", "fmarcy")
		cutscene:text("* I will wait for your return,[wait:5] alright?", "neutral", "fmarcy")
		cutscene:showNametag("Noelle")
		cutscene:text("* ...Are you sure,[wait:5] Marcy?", "normal/neutral", "fnoelle")
		cutscene:text("* We can always call them and let them know.", "normal/smile", "fnoelle")
		if Game:getFlag("future_variable") == "ceroba" then
			cutscene:showNametag("Kanako")
			cutscene:text("* Aren't the phone lines still down,[wait:5] Noelle?", "eyes_left", "fkanako")
		end
		cutscene:showNametag("Noelle")
		cutscene:text("* O-oh,[wait:5] right...", "normal/oh", "fnoelle")
		cutscene:showNametag("Marcy")
		cutscene:text("* I'll be fine,[wait:5] you two.", "closed", "fmarcy")
		if Game:getFlag("future_variable") == "ceroba" then
			cutscene:showNametag("Kanako")
			cutscene:text("* Then we'll be back as soon as we can!", "neutral", "fkanako")
		end
		cutscene:hideNametag()
		cutscene:walkToSpeed(fnoelle, 240, 640, 6)
		cutscene:wait(cutscene:walkToSpeed(fvariant, 380, 640, 6))
		
		cutscene:showNametag("Marcy")
		cutscene:text("* ...*sigh*", "closed", "fmarcy")
		
		fmarcy:setAnimation("hold_look")
		
		cutscene:text("* Maybe this pen will see what's on the other side...", "closed", "fmarcy")
		cutscene:text("* Who knows?[wait:10]\n* Maybe it could find my father...", "tears_closed", "fmarcy")
		cutscene:hideNametag()
		cutscene:gotoCutscene("hometown.end_flashback")
    end,
}
