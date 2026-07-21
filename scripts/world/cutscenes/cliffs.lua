return {
    sign1 = function(cutscene, event)
        if not Mod:incoherent(cutscene) then
			cutscene:text("* You have reached the point of no return.")
			cutscene:text("* Pray to any gods you may have.")
		end
    end,
	
    walk1 = function(cutscene, event)
        Game:setFlag("walk1_active", true)
		Game.world:getEvent(13):walkToSpeed("fmarcy_walkto", 8)
    end,
	
    walk2 = function(cutscene, event)
        Game:setFlag("walk2_active", true)
		Game.world:getEvent(7):walkToSpeed("fnoelle_walkto", 8)
    end,
	
    bg_convo = function(cutscene, event)
		local texts = {}
        local function genText(text, x, y, actor, scale, main, wait_time)
            scale = scale or 1
            wait_time = wait_time or 0.2

            local text_o = Game.world:spawnObject(DialogueText(text, x, y, 300, 500))
            text_o.skippable = false
            text_o:setScale(scale)
            text_o.parallax_x = 0
            text_o.parallax_y = 0
			text_o.alpha = 0
			text_o:setLayer(9999)
			text_o:addFX(OutlineFX(COLORS.black, {
				thickness = 2,
				amount = 4
			}))
            table.insert(texts, text_o)

            cutscene:wait(wait_time)
			Game.world.timer:tween(1, text_o, { x = x + 15, alpha = 1 }, "linear", function()
				Game.world.timer:after(2.5, function()
					
					Game.world.timer:tween(1, text_o, {alpha = 0 }, "linear", function()
						text_o:remove()
					end)
				end)
			end)

            return text_o
        end
		
        Game:setFlag("bg_convo", true)
		cutscene:enableMovement()
		
		genText("So, you saw them too, right?", 50, 50, "fmarcy")	-- Marcy
		cutscene:wait(5)
		if Game:isDessMode() then
			genText("The outsider? Y-yeah, I saw them...", 300, 50, "fnoelle")	-- Noelle
		else
			genText("The outsiders? Y-yeah, I saw them...", 300, 50, "fnoelle")	-- Noelle
		end
		cutscene:wait(5)
		genText("But they seem... familiar, somehow.", 300, 50, "fnoelle")	-- Noelle
		cutscene:wait(5)
		genText("Agreed. So what do we do?", 50, 50, "fmarcy")	-- Marcy
		cutscene:wait(5)
		
		if Game:getFlag("future_variable") == "ceroba" then
			genText("Can't we just leave them be?", 175, 50)	-- Kanako
			cutscene:wait(5)
			genText("Negative. Remember what happened last time.", 50, 50, "fmarcy")	-- Marcy
			cutscene:wait(5)
		elseif Game:getFlag("future_variable") == "brenda" then
			genText("Worst comes to worse, we can just kill them, right?", 175, 50)	-- Celestial
			cutscene:wait(5)
			genText("True, but I'd rather we know who they are first.", 50, 50, "fmarcy")	-- Marcy
			cutscene:wait(5)
		end
		genText("Maybe we could wait to see what happens?", 300, 50)	-- Noelle
		cutscene:wait(5)
		genText("We don't know if they're malicious.", 300, 50, "fnoelle")	-- Noelle
		cutscene:wait(5)
		genText("...Probably for the best to do that.", 50, 50, "fmarcy")	-- Marcy
		cutscene:wait(5)
    end,
	
    monster	= function(cutscene, event)
		local texts = {}
        local function genText(text, x, y, actor, scale, main, wait_time)
            scale = scale or 1
            wait_time = wait_time or 0.2

            local text_o = Game.world:spawnObject(DialogueText(text, x, y, 300, 500))
            text_o.skippable = false
            text_o:setScale(scale)
            text_o.parallax_x = 0
            text_o.parallax_y = 0
			text_o.alpha = 0
			text_o:setLayer(9999)
			text_o:addFX(OutlineFX(COLORS.black, {
				thickness = 2,
				amount = 4
			}))
            table.insert(texts, text_o)

            -- cutscene:wait(wait_time)
			Game.world.timer:tween(1, text_o, { x = x + 15, alpha = 1 }, "linear", function()
				Game.world.timer:after(2.5, function()
					
					Game.world.timer:tween(1, text_o, {alpha = 0 }, "linear", function()
						text_o:remove()
					end)
				end)
			end)

            return text_o
        end

		if Game:isDessMode() then
			local dess = cutscene:getCharacter("dess")

			cutscene:detachCamera()
			
			cutscene:panTo(680, 960, 1)
			cutscene:wait(cutscene:walkTo(dess, "jamm_walkto", 1))
			
			cutscene:showNametag("Dess")
			cutscene:text("* it's quiet...", "neutral_c", "dess")
			cutscene:text("* too quiet...", "annoyed", "dess")
			cutscene:hideNametag()
        	for i = 0,5 do
            	cutscene:playSound("impact", (1 - (i/10)) ^ (4) )
            	cutscene:wait(0.2)
        	end
			cutscene:wait(1)
			cutscene:showNametag("Dess")
			cutscene:text("* uh oh", "wtf", "dess")
			cutscene:hideNametag()
			local alpha = cutscene:spawnNPC("slitherer", 1050, 960)
        	for i = 0,4 do
            	cutscene:wait(cutscene:slideTo(alpha, alpha.x - 30, alpha.y, 1, "in-out-cubic"))
        	end
			cutscene:showNametag("Dess")
			cutscene:text("* hi yes what the actual FUCK is that thing", "annoyed", "dess")
			cutscene:text("* whelp,[wait:5] guess i better kill it", "challenging", "dess")
			cutscene:hideNametag()
			cutscene:startEncounter("slitherer_intro", true, alpha)
			cutscene:wait(0.2)
			Assets.playSound("hurt")
			dess:setSprite("battle/hurt")
			cutscene:shakeCharacter(dess, 2)
			genText("Are they already down...?", 50, 50, "fmarcy")	-- Marcy
			cutscene:wait(0.3)
			cutscene:showNametag("Dess")
			cutscene:text("* what the hell did i just fight", "annoyed", "dess")
			cutscene:hideNametag()
			cutscene:wait(0.7)
			genText("They're not very strong, are they?", 300, 50, "fnoelle")	-- Noelle
			cutscene:showNametag("Dess")
			cutscene:text("* is this the end of the line for me...?", "annoyed", "dess")
			cutscene:hideNametag()
			genText("Wait, don't interfere w--", 50, 50, "fmarcy")	-- Marcy
			cutscene:wait(0.8)
			cutscene:healEffect(dess)
			cutscene:wait(1)
			cutscene:resetSprite(dess)
			Assets.playSound("noise")
			cutscene:wait(0.5)
			cutscene:showNametag("Dess")
			cutscene:text("* what", "mspaint", "dess")
			genText("We don't need them to die!", 300, 50, "fnoelle")	-- Noelle
			cutscene:text("* uhhhhhhhh", "neutral_c", "dess")
			cutscene:text("* im just gonna assume that was God saving my ass and move on", "neutral", "dess")
			genText("We're lucky the deer bailed us out.", 50, 50, "fmarcy")	-- Marcy
			cutscene:text("* okay where tf was i going again?", "angry", "dess")
			cutscene:hideNametag()
			cutscene:attachCamera(1)
			cutscene:showNametag("Dess")
			cutscene:text("* maybe i should avoid those guys...", "neutral_c", "dess")
			cutscene:text("* OR i could kill them all and get a bajillion exp", "smug", "dess")
			cutscene:hideNametag()
			return
		end
		
        local jamm = cutscene:getCharacter("jamm")
		local susie = cutscene:getCharacter("susie")
		local variant = cutscene:getCharacter(Game:getFlag("future_variable"))
		
		cutscene:detachFollowers()
		cutscene:detachCamera()
		
		cutscene:panTo(680, 960, 1)
		cutscene:walkTo(susie, "susie_walkto", 1)
        cutscene:walkTo(jamm, "jamm_walkto", 1)
		cutscene:resetSprite(variant)
        cutscene:wait(cutscene:walkTo(variant, "variant_walkto", 1))
		
		cutscene:showNametag("Jamm")
		cutscene:text("* Guys,[wait:5] I'm getting a very bad feeling about this place.", "nervous", "jamm")
		cutscene:look(susie, "down")
		cutscene:showNametag("Susie")
		cutscene:text("* Me too.[wait:10] Like,[wait:5] god damn it,[wait:5] Jamm,[wait:5] where the hell are we!?", "annoyed", "susie")
		cutscene:look(jamm, "up")
		cutscene:showNametag("Jamm")
		cutscene:text("* It's not my fault![wait:10]\n* That rift sucked me in too!", "determined", "jamm")
		cutscene:showNametag("Susie")
		cutscene:text("* You were the one who touched it in the first place!", "angry", "susie")
		if Game:getFlag("future_variable") == "ceroba" then -- just in Ceroba's case specifically
			cutscene:look(variant, "up")
			Game.world.music:fade(0, 1)
		end
		cutscene:showNametag("Jamm")
		cutscene:text("* Oh,[wait:5] don't act like you wouldn't have--", "furious", "jamm", {auto=true, skip=false})
		cutscene:look(susie, "left")
		cutscene:look(jamm, "left")
		if Game:getFlag("future_variable") == "ceroba" then
			cutscene:look(variant, "right")
			Assets.playSound("ceroba_yell")
			Game.world.camera:shake(6, 2)
			cutscene:showNametag("Ceroba")
			cutscene:text("* WOULD YOU TWO JUST STOP THAT!?", "furious", "ceroba")
			--genText("She's got the guts.", 50, 50, "fmarcy")	-- Marcy (probably) (wasn't sure if it's okay for that dialogue to appear that early in the cutscene)
			cutscene:text("* We've got enough problems as it is.", "angry", "ceroba")
			cutscene:text("* We don't know where we are,[wait:5] nor how do we get back.", "angry_alt", "ceroba")
			cutscene:text("* The LAST thing we need right now is a conflict.", "irked", "ceroba")
			Game.world.music:fade(1, 1)
		elseif Game:getFlag("future_variable") == "brenda" then
			cutscene:showNametag("Brenda")
			cutscene:text("* Oh for the love of...", "suspicious", "brenda")
			cutscene:text("* Can you two stop bickering like school children?", "angry", "brenda")
			cutscene:text("* We need to stick together.", "dissapointed", "brenda")
		end
		cutscene:showNametag("Susie")
		cutscene:text("* ...Yeah.[wait:5] You're right,[wait:5] " .. Game.party[3].name .. ".", "shy_down", "susie")
		cutscene:showNametag("Jamm")
		cutscene:text("* Yeah,[wait:5] sorry.[wait:10] I'm just...[wait:10] really stressed right now.", "shaded_frown", "jamm")
		cutscene:text("* Let's just keep going,[wait:5] alright?", "neutral", "jamm")
		cutscene:text("* If there was a way here,[wait:5] there should be a way home too.", "side_smile", "jamm")
		cutscene:look(susie, "down")
		cutscene:look(jamm, "up")
		cutscene:showNametag("Susie")
		cutscene:text("* ...Hey,[wait:5] yeah![wait:10] You're right![wait:10] There has to be one!", "surprise_smile", "susie")
		cutscene:hideNametag()
		cutscene:look(susie, "right")
		cutscene:look(jamm, "right")
        for i = 0,5 do
            cutscene:playSound("impact", (1 - (i/10)) ^ (4) )
            cutscene:wait(0.2)
        end
		cutscene:wait(1)
		if Game:getFlag("future_variable") == "ceroba" then
			cutscene:showNametag("Ceroba")
			cutscene:text("* Oh,[wait:5] for the love of...", "unamused", "ceroba")
			cutscene:text("* What is it now?", "closed_eyes", "ceroba")
		elseif Game:getFlag("future_variable") == "brenda" then
			cutscene:showNametag("Brenda")
			cutscene:text("* Uhhh you guys heard that too,[wait:5] right?", "shocked_b", "brenda")
		end
		cutscene:hideNametag()
		local alpha = cutscene:spawnNPC("slitherer", 1050, 960)
        for i = 0,4 do
			if i == 2 then
				susie:setSprite("shock_right")
				cutscene:shakeCharacter(susie, 2)
				Assets.playSound("sussurprise")
				cutscene:walkToSpeed(jamm, jamm.x - 40, jamm.y, 4, "right", true)
			end
            cutscene:wait(cutscene:slideTo(alpha, alpha.x - 30, alpha.y, 1, "in-out-cubic"))
        end
		cutscene:showNametag("Susie")
		cutscene:text("* The hell is THAT thing!?", "surprise_frown", "susie")
		cutscene:showNametag("Jamm")
		cutscene:text("* I don't know,[wait:5] but I don't think we can reason with it.", "determined", "jamm")
		cutscene:setAnimation(jamm, "battle/idle")
		cutscene:text("* Let's show it hell,[wait:5] guys!", "sling_ready", "jamm")
		cutscene:hideNametag()
		cutscene:setAnimation(susie, "battle/attack")
		Assets.playSound("laz_c")
		cutscene:wait(0.6)
		cutscene:setAnimation(susie, "battle/idle")
		cutscene:setAnimation(variant, "battle/idle")
		cutscene:showNametag("Susie")
		cutscene:text("* That,[wait:5] I can get behind!", "teeth_smile", "susie")
		cutscene:hideNametag()
		cutscene:startEncounter("slitherer_intro", true, alpha)
		local fullhealth_partymembers = 0
		for _,party in ipairs(Game.party) do
			if party.health == party:getStat("health") then
				fullhealth_partymembers = fullhealth_partymembers + 1
			end
		end
		if fullhealth_partymembers == 3 then
			cutscene:wait(0.2)
			cutscene:resetSprite(jamm)
			Assets.playSound("noise")
			genText("Impressive.", 50, 50, "fmarcy")	-- Marcy
			cutscene:wait(0.3)
			cutscene:resetSprite(variant)
			Assets.playSound("noise")
			cutscene:wait(0.2)
			cutscene:resetSprite(susie)
			Assets.playSound("noise")
			cutscene:wait(0.7)
			cutscene:showNametag("Jamm")
			cutscene:text("* Phew,[wait:5] not a scratch!", "smirk", "jamm")
			if Game:getFlag("future_variable") == "ceroba" then
				cutscene:showNametag("Ceroba")
				cutscene:text("* I'm honestly surprised we did that.", "nervous_smile", "ceroba")
				cutscene:text("* Some of the bullets were REALLY close to hitting us...", "nervous", "ceroba")
			end
			cutscene:hideNametag()
			cutscene:wait(1)
			Assets.playSound("bell", 0.5)
			susie:setSprite("pose")
			cutscene:showNametag("Susie")
			cutscene:text("* Heh,[wait:5] nothing can stand in the way of the [color:yellow]DELTA WARRIORS[color:reset]!", "teeth_smile", "susie")
			genText("\"DELTA WARRIORS\"?", 300, 50, "fnoelle")	-- Noelle
			cutscene:hideNametag()
			cutscene:wait(1)
			jamm:setFacing("up")
			cutscene:showNametag("Jamm")
			cutscene:text("* Since when were "..Game.party[3]:getName().." and I part of them?", "look_left", "jamm")
			cutscene:hideNametag()
			cutscene:wait(1)
			Assets.playSound("swallow")
			susie:setSprite("pose_what_the")
			cutscene:shakeCharacter(susie, 2)
			cutscene:wait(1)
			cutscene:showNametag("Susie")
			cutscene:text("* Uh...[wait:5] Well...[wait:5] I mean...", "nervous_side", "susie")
			Assets.playSound("noise")
			susie:setSprite("walk_unhappy/down")
			cutscene:text("* Are you...[wait:5] NOT happy about being a part of us?", "neutral", "susie")
			cutscene:showNametag("Jamm")
			cutscene:text("* I didn't say that,[wait:5] it's just...", "look_left", "jamm")
			cutscene:text("* We didn't really have an official announcement or anything...", "nervous_left", "jamm")
			susie:setSprite("walk/down")
			cutscene:showNametag("Susie")
			cutscene:text("* Okay then,[wait:5] I'm [color:yellow]officially[color:reset] announcing you two...", "smile", "susie")
			cutscene:text("* As a part of the [color:yellow]DELTA WARRIORS[color:reset] team!", "closed_grin", "susie")
			cutscene:hideNametag()
			Game.world.music:pause()
			local fanfares = Music("fanfare", 0.7, 1, false)
			cutscene:text("[speed:0.15]* (Jamm and "..Game.party[3]:getName().." became a part of the [color:yellow]DELTA WARRIORS[color:reset]!)", nil, nil, {skip=false})
			cutscene:setAnimation(susie, {"clap", 1/7, true})
			cutscene:showNametag("Susie")
			cutscene:text("* My congratulations.", "teeth_smile", "susie")
			cutscene:hideNametag()
		else
			cutscene:wait(0.2)
			Assets.playSound("hurt")
			susie:setSprite("battle_serious/idle_1")
			cutscene:shakeCharacter(susie, 2)
			cutscene:wait(0.2)
			jamm:setSprite("landed_2")
			cutscene:shakeCharacter(jamm, 1)
			Assets.playSound("noise")
			genText("Are they already down...?", 50, 50, "fmarcy")	-- Marcy
			cutscene:wait(0.3)
			variant:setSprite("battle/defeat")
			cutscene:shakeCharacter(variant, 1)
			Assets.playSound("noise")
			cutscene:wait(0.2)
			susie:setSprite("battle/defeat")
			cutscene:shakeCharacter(susie, 1)
			Assets.playSound("noise")
			cutscene:wait(0.7)
			cutscene:showNametag("Susie")
			cutscene:text("* What did we just fight...?", "surprise_frown", "susie")
			cutscene:showNametag("Jamm")
			cutscene:text("* I know,[wait:5] right!?[wait:10]\n* Talk about a welcome party...", "nervous", "jamm")
			genText("They're not very strong, are they?", 300, 50, "fnoelle")	-- Noelle
			cutscene:showNametag("Susie")
			cutscene:text("* ...", "shy_down", "susie")
			cutscene:hideNametag()
			genText("Wait, don't interfere w--", 50, 50, "fmarcy")	-- Marcy
			cutscene:wait(0.8)
			cutscene:healEffect(susie)
			cutscene:healEffect(jamm)
			cutscene:healEffect(variant)
			cutscene:wait(1)
			cutscene:resetSprite(variant)
			Assets.playSound("noise")
			cutscene:wait(0.5)
			cutscene:resetSprite(jamm)
			Assets.playSound("noise")
			cutscene:wait(0.5)
			cutscene:resetSprite(susie)
			Assets.playSound("noise")
			cutscene:wait(0.5)
			cutscene:showNametag("Susie")
			cutscene:text("* Uh...", "nervous", "susie")
			genText("Why did you do that!?", 50, 50, "fmarcy")	-- Marcy
			cutscene:look(jamm, "left")
			cutscene:look(susie, "left")
			cutscene:showNametag("Jamm")
			cutscene:text("* What just healed us...?", "nervous_left", "jamm")
			if Game:getFlag("future_variable") == "ceroba" then
				cutscene:showNametag("Ceroba")
				cutscene:text("* I'm...[wait:5] Not sure,[wait:5] honestly.", "dissapproving", "ceroba")
			elseif Game:getFlag("future_variable") == "brenda" then
				cutscene:showNametag("Brenda")
				cutscene:text("* I dunno but I don't wanna question it.", "neutral", "brenda")
				cutscene:text("* Y'know,[wait:5] don't look a gift horse in the mouth and all.", "suspicious", "brenda")
			end
			genText("We don't need them to die!", 300, 50, "fnoelle")	-- Noelle
			cutscene:look(jamm, "up")
			cutscene:showNametag("Jamm")
			cutscene:text("* ...I guess it's not that important,[wait:5] right?", "nervous_left", "jamm")
			cutscene:text("* Whatever it is helped us in the end.", "nervous_left", "jamm")
			genText("We're lucky the dumbfaced one bailed us out.", 50, 50, "fmarcy")	-- Marcy
			if Game:getFlag("future_variable") == "ceroba" then
				cutscene:showNametag("Ceroba")
				cutscene:text("* I don't feel confident about this,[wait:5] Jamm...", "unsure_alt", "ceroba")
				cutscene:text("* What if it's trying to lure us in?", "suspicious", "ceroba")
			elseif Game:getFlag("future_variable") == "brenda" then
				cutscene:showNametag("Brenda")
				cutscene:text("* I guess,[wait:5] but like...", "neutral", "brenda")
				cutscene:text("* This is all just so bizarre.", "suspicious_b", "brenda")
			end
			cutscene:showNametag("Susie")
			cutscene:text("* Well,[wait:5] so what if it feels wrong?", "smile", "susie")
			cutscene:setSprite(susie, "pose")
			cutscene:text("* If it attacks,[wait:5] we know what to do.", "closed_grin", "susie")
			genText("...How cocky.", 50, 50, "fmarcy")	-- Marcy
			cutscene:setSprite(jamm, "bt")
			cutscene:showNametag("Jamm")
			cutscene:text("* Yeah,[wait:5] we do!", "smug", "jamm")
			cutscene:hideNametag()
			cutscene:look(susie, "right")
		end
		cutscene:resetSprites()
		cutscene:interpolateFollowers()
		cutscene:attachFollowersImmediate()
		cutscene:attachCamera(1)
		cutscene:showNametag("Jamm")
		cutscene:text("* You know...[wait:10] That was just a regular enemy,[wait:5] right?", "neutral", "jamm")
		cutscene:text("* If we absolutely HAD to fight...[wait:10] DarkSling would take effect.", "look_left", "jamm")
		genText("DarkSling...? That's familiar...", 50, 50, "fmarcy")	-- Marcy
		cutscene:showNametag("Susie")
		cutscene:text("* Maybe we should try to [color:yellow]avoid these enemies[color:white]...", "neutral", "susie")
		cutscene:hideNametag()
		Game:setFlag("first_collapse_creature", true)
    end,
	
    sign2 = function(cutscene, event)
		cutscene:text("* Inside this chest contains [color:yellow]ARMOR[color:white].")
		cutscene:text("* It can help you withstand the daily horrors.")
		cutscene:text("* (Signed, The Resistance)")
		if Game:isDessMode() then
			cutscene:showNametag("Dess")
			cutscene:text("* am i in some king of [color:red]Half-Life 2[color:reset] right now", "neutral", "dess")
			cutscene:hideNametag()
			return
		end
		cutscene:showNametag("Jamm")
		cutscene:text("* Guys, I have a feeling we'll be needing this armor.", "nervous", "jamm")
		cutscene:text("* Maybe we should equip it on one of us?", "nervous_left", "jamm")
		cutscene:showNametag("Susie")
		cutscene:text("* Let's see...", "nervous", "susie")
		cutscene:hideNametag()
    end,
	
    chase_start	= function(cutscene, event)
		local texts = {}
        local function genText(text, x, y, actor, scale, main, wait_time)
            scale = scale or 1
            wait_time = wait_time or 0.2

            local text_o = Game.world:spawnObject(DialogueText(text, x, y, 300, 500))
            text_o.skippable = false
            text_o:setScale(scale)
            text_o.parallax_x = 0
            text_o.parallax_y = 0
			text_o.alpha = 0
			text_o:setLayer(9999)
			text_o:addFX(OutlineFX(COLORS.black, {
				thickness = 2,
				amount = 4
			}))
            table.insert(texts, text_o)

            -- cutscene:wait(wait_time)
			Game.world.timer:tween(1, text_o, { x = x + 15, alpha = 1 }, "linear", function()
				Game.world.timer:after(2.5, function()
					
					Game.world.timer:tween(1, text_o, {alpha = 0 }, "linear", function()
						text_o:remove()
					end)
				end)
			end)

            return text_o
        end
		
		local function createParticle(x, y)
			local sprite = Sprite("effects/icespell/snowflake", x, y)
			sprite:setOrigin(0.5, 0.5)
			sprite:setScale(1.5)
			sprite.layer = WORLD_LAYERS["above_events"]
			Game.world:addChild(sprite)
			return sprite
		end
		
        local jamm = cutscene:getCharacter("jamm")
		local susie = cutscene:getCharacter("susie")
		local variant = cutscene:getCharacter(Game:getFlag("future_variable"))
		
		cutscene:detachFollowers()
		cutscene:detachCamera()
		
		cutscene:panTo(780, 500, 1)
		cutscene:walkTo(susie, "susie_walkto", 1)
        cutscene:walkTo(jamm, "jamm_walkto", 1)
        cutscene:wait(cutscene:walkTo(variant, "variant_walkto", 1))
		
		cutscene:showNametag("Susie")
		cutscene:text("* I think I might have some idea about where we are...", "neutral", "susie")
		cutscene:look(susie, "down")
		cutscene:look(jamm, "up")
		cutscene:showNametag("Jamm")
		cutscene:text("* ...Go on.", "neutral", "jamm")
		genText("...This is taking too long.", 50, 50, "fmarcy")	-- Marcy
		cutscene:showNametag("Susie")
		cutscene:text("* With the different language on the signs and the cliffs...", "neutral_side", "susie")
		cutscene:text("* We might be in some kind of a different universe.", "neutral", "susie")
		genText("I think we should take them prisoner.", 50, 50, "fmarcy")	-- Marcy
		cutscene:showNametag("Jamm")
		cutscene:text("* Like an AU or something?", "neutral", "jamm")
		cutscene:showNametag("Susie")
		cutscene:text("* The hell is an AU?", "neutral", "susie")
		if Game:getFlag("future_variable") == "ceroba" then
			genText("And interrogate them at the base or something?", 175, 50)	-- Kanako
		elseif Game:getFlag("future_variable") == "brenda" then
			genText("Agreed, perhaps we can interrogate them as well.", 175, 50)	-- Celestial
		end
		cutscene:showNametag("Jamm")
		cutscene:text("* It means \"Alternate Universe\".", "look_left", "jamm")
		cutscene:text("* It's an alternate version of a world,[wait:5] with some change.", "neutral", "jamm")
		cutscene:text("* Swapped roles,[wait:5] everyone is evil,[wait:5] extra people...", "neutral", "jamm")
		genText("Yeah, that's what I'm thinking now.", 50, 50, "fmarcy")	-- Marcy
		cutscene:text("* There might even be one where the Roaring is real.[react:1]", "side_smile", "jamm", {reactions={
			{"Or one where\nAnia is alive...", 352, 61, "worried", "jamm"}
		}})
		cutscene:showNametag("Susie")
		cutscene:text("* Dude,[wait:5] really???[wait:10]\n* I'd want to go to that one!", "surprise_smile", "susie")
		genText("...If you think it's best, then...", 300, 50, "fnoelle")	-- Noelle
		cutscene:text("* But,[wait:5] uh...[wait:10]\n* Something like that.", "nervous", "susie")
		cutscene:look(susie, "left")
		cutscene:look(jamm, "left")
		if Game:getFlag("future_variable") == "ceroba" then
			cutscene:showNametag("Ceroba")
			cutscene:text("* ...It's the best we've got.", "dissapproving", "ceroba")
			cutscene:text("* So then,[wait:5] how would we get home?", "neutral", "ceroba")
		elseif Game:getFlag("future_variable") == "brenda" then
			cutscene:showNametag("Brenda")
			cutscene:text("* That's cool and all,[wait:5] but uh...", "dissapointed", "brenda")
			cutscene:text("* How the hell are we supposed to get home?", "suspicious", "brenda")
		end
		cutscene:setAnimation(susie, {"away_scratch", 1/3, true})
		cutscene:showNametag("Susie")
		cutscene:text("* Yeah,[wait:5] I'm still working on--", "nervous_side", "susie", {auto=true})
		cutscene:hideNametag()
		local particles = {}
		Game.world.music:stop()
		cutscene:wait(1/30)
		Assets.playSound("icespell")
        particles[1] = createParticle(755, 480)
        cutscene:wait(3/30)
		cutscene:setSprite(susie, "shock_left")
		cutscene:setSprite(jamm, "trip")
		jamm.flip_x = true
		if Game:getFlag("future_variable") == "ceroba" then
			cutscene:setSprite(variant, "fall")
			variant.flip_x = true
		elseif Game:getFlag("future_variable") == "brenda" then
			cutscene:setSprite(variant, "battle/defend_6")
		end
		cutscene:slideTo(susie, susie.x + 40, susie.y, 0.2)
		cutscene:slideTo(jamm, jamm.x + 40, jamm.y, 0.2)
		cutscene:slideTo(variant, variant.x - 40, variant.y, 0.2)
        particles[2] = createParticle(805, 480)
        cutscene:wait(3/30)
        particles[3] = createParticle(780, 520)
        cutscene:wait(3/30)
        Game.world:addChild(IceSpellBurst(780, 500))
        for _,particle in ipairs(particles) do
            for i = 0, 5 do
                local effect = IceSpellEffect(particle.x, particle.y)
                effect:setScale(0.75)
                effect.physics.direction = math.rad(60 * i)
                effect.physics.speed = 8
                effect.physics.friction = 0.2
                effect.layer = WORLD_LAYERS["above_events"] - 1
                Game.world:addChild(effect)
            end
        end
        cutscene:wait(1/30)
        for _,particle in ipairs(particles) do
            particle:remove()
        end
        cutscene:wait(1)
		cutscene:showNametag("Jamm")
		cutscene:text("* Wh-what was that!?", "speechless", "jamm")
		cutscene:hideNametag()
		cutscene:look(susie, "up")
		cutscene:resetSprite(susie)
		susie:alert()
		cutscene:wait(1)
		cutscene:setAnimation(susie, {"point_up", 1/3, true})
		Game.world.music:play("creepychase")
		cutscene:showNametag("Susie")
		cutscene:text("* HEY!", "angry", "susie")
		jamm.flip_x = false
		cutscene:look(jamm, "up")
		cutscene:resetSprite(jamm)
		variant.flip_x = false
		cutscene:look(variant, "up")
		cutscene:resetSprite(variant)
		cutscene:hideNametag()
		cutscene:panTo(780, 140, 1)
		cutscene:wait(1)
		cutscene:showNametag("???", {top=false})
		cutscene:text("* Shit,[wait:5] they spotted us!", nil, "fmarcy", {top=false})
		local fmarcy = cutscene:getCharacter("fmarcy")
		cutscene:walkToSpeed(fmarcy, 1160, fmarcy.y, 12)
		cutscene:text("* Hey,[wait:5] don't run off without me!", nil, "fmarcy", {top=false})
		cutscene:resetSprite(susie)
		cutscene:hideNametag()
		cutscene:panTo(780, 500, 1)
		cutscene:wait(1)
		cutscene:look(susie, "down")
		cutscene:showNametag("Jamm")
		cutscene:text("* C'mon,[wait:5] after them!", "determined", "jamm")
		jamm:walkToSpeed(1160, jamm.y, 12)
		variant:walkToSpeed(1160, variant.y, 12)
		cutscene:hideNametag()
		Game.world.future_chase_started = true
    end,
	
    no_return_1	= function(cutscene, event)
		cutscene:showNametag("Susie")
		cutscene:text("* I can't go back now.", "nervous", "susie")
		cutscene:hideNametag()
		local susie = cutscene:getCharacter("susie")
		cutscene:wait(cutscene:walkToSpeed(susie, susie.x + 40, susie.y, 8))
    end,
	
	jamm_jump = function(cutscene)
		local jamm = cutscene:getCharacter("jamm")
		Assets.playSound("jump")
		Game:setFlag("future_jamm_jump", true)
		jamm:jumpTo(580, 380, 20, 0.5, "ball", "landed_2")
		Game.world.timer:after(0.5, function()
			jamm:shake(2)
		end)
		Game.world.timer:after(0.7, function()
			jamm:walkToSpeed(580, 600, 8)
		end)
	end,
	
	chase_end = function(cutscene)
		-- TODO: FP chase no-hit achievement
		local in_the_running
		if (Game.party[1].health == Game.party[1]:getStat("health")) and (Game.party[2].health == Game.party[2]:getStat("health")) and (Game.party[3].health == Game.party[3]:getStat("health")) then
			in_the_running = true
		end
		
        local jamm = cutscene:getCharacter("jamm")
		local susie = cutscene:getCharacter("susie")
		local variant = cutscene:getCharacter(Game:getFlag("future_variable"))
		local fmarcy = cutscene:getCharacter("fmarcy")
		local fnoelle = cutscene:getCharacter("fnoelle")
		local fvariant = cutscene:getCharacter(Mod:getVariableFuture(Game.party[3].id))

		fmarcy.sprite.color = {0, 0, 0}
		
		cutscene:wait(cutscene:walkToSpeed(susie, "susie_meetup", 8, "down"))
		
		cutscene:showNametag("Jamm", {top=true})
		cutscene:text("* C'mon,[wait:5] we're almost there!", "determined", "jamm", {top=true})
		cutscene:hideNametag()
		
		local susie_available = false
		
		susie:setSprite("run")
		susie:walkToSpeed("susie_walkto", 8, nil, false, function()
			Assets.playSound("jump")
			susie:resetSprite()
			susie:jumpTo(840, 260, 20, 0.5, "jump_ball", "landed_2")
			Game.world.timer:after(0.5, function()
				susie_available = true
			end)
		end)
		if Game:getFlag("future_variable") == "ceroba" then
			variant:setSprite("run")
			cutscene:walkToSpeed(variant, "variant_walkto", 8, "down", false, function()
				variant:resetSprite()
			end)
		else
			cutscene:walkToSpeed(variant, "variant_walkto", 8, "down")
		end
		cutscene:wait(cutscene:walkToSpeed(jamm, "jamm_walkto", 8, "up"))

		cutscene:wait(function() return susie_available end)

		susie:setFacing("down")

		cutscene:showNametag("Jamm", {top=true})
		cutscene:text("* Everyone here?[wait:5] Now we just gotta-", "determined", "jamm", {top=true, auto=true})
		cutscene:hideNametag()
		
		local attack_fx = Sprite("effects/attack/cut_ceroba", jamm.x, jamm.y - 20)
		attack_fx:setScale(2)
		attack_fx:setOrigin(0.5)
		attack_fx:setLayer(jamm.layer+0.1)
		Game.world:addChild(attack_fx)
		attack_fx:play(1/10, false, function() attack_fx:remove() end)
		Assets.playSound("laz_c")
		
		cutscene:wait(3/10)
		
		susie:alert()
		susie:shake()
		susie:setSprite("shock_down")
		if Game:getFlag("future_variable") == "ceroba" then
			variant:alert(nil, {play_sound=false})
			variant:shake()
			variant:setSprite("shock_closed")
		end
		cutscene:setSprite(jamm, "landed_1")
		Assets.playSound("damage", 1)
		jamm:statusMessage("msg", "critical")
		cutscene:shakeCharacter(jamm, 4)
		Game.world.timer:after(0.4, function()
			Assets.playSound("damage", (1 - (1/10)) ^ (4) )
			Game.world.timer:after(0.4, function()
				Assets.playSound("damage", (1 - (2/10)) ^ (4) )
				Game.world.timer:after(0.4, function()
					Assets.playSound("damage", (1 - (3/10)) ^ (4) )
					Game.world.timer:after(0.4, function()
						Assets.playSound("damage", (1 - (4/10)) ^ (4) )
					end)
				end)
			end)
		end)

		cutscene:wait(1)
		
		susie:setSprite("walk_unhappy")
		if Game:getFlag("future_variable") == "ceroba" then variant:setSprite("walk") end
		
		cutscene:wait(0.5)
		
		cutscene:walkToSpeed(variant, jamm.x, jamm.y - 80, 8)
		cutscene:wait(cutscene:walkToSpeed(susie, jamm.x, jamm.y - 40, 8))
		
		cutscene:setSprite(susie, "landed_2")
		
		cutscene:showNametag("Susie", {top=true})
		cutscene:text("* H-hey![wait:10]\n* Jamm![wait:5] Jamm,[wait:5] are you okay!?", "sad", "susie", {top=true})
		cutscene:hideNametag()
		
		if Game:getFlag("future_variable") == "ceroba" then
			cutscene:showNametag("Ceroba", {top=true})
			cutscene:text("* ...[wait:5] I don't think he is,[wait:5] Susie.", "sorrowful", "ceroba", {top=true})
		end
		cutscene:showNametag("Susie", {top=true})
		cutscene:text("* ...", "bangs/down", "susie", {top=true})
		cutscene:hideNametag()
		
		Game.world.music:fade(0, 1)
		cutscene:wait(1)

		Assets.playSound("step1", 2, 0.9)
		variant:alert(nil, {play_sound=false})
		variant:setFacing("right")

		cutscene:wait(1)
		cutscene:wait(cutscene:panTo(Game.world.camera.x + 200, Game.world.camera.y, 2))
		cutscene:wait(1)

		if Game:getFlag("future_variable") == "ceroba" then
			cutscene:showNametag("Ceroba")
			cutscene:text("* ...[wait:5] uh,[wait:5] Susie?", "nervous", "ceroba")
		end
		cutscene:hideNametag()

		Assets.playSound("noise")
		jamm:shake()
		cutscene:wait(1)
		cutscene:showNametag("Susie")
		cutscene:text("* Come on...[wait:5] Jamm.", "bangs/down", "susie")
		cutscene:hideNametag()

		Assets.playSound("step2", 2, 0.9)
		cutscene:wait(cutscene:walkToSpeed(fmarcy, fmarcy.x - 40, fmarcy.y, 1))

		Assets.playSound("noise")
		jamm:shake()
		cutscene:wait(1)
		cutscene:showNametag("Susie")
		cutscene:text("* We gotta go...", "bangs/down", "susie")
		cutscene:hideNametag()

		Assets.playSound("step1", 2, 0.9)
		cutscene:wait(cutscene:walkToSpeed(fmarcy, fmarcy.x - 40, fmarcy.y, 1))

		Assets.playSound("noise")
		jamm:shake()
		cutscene:wait(1)
		cutscene:showNametag("Susie")
		cutscene:text("* Please...[wait:5] get up...", "bangs/down", "susie")
		cutscene:hideNametag()

		local fmarcy_origlayer = fmarcy.layer
		fmarcy.layer = WORLD_LAYERS["below_ui"] + 1
		local fade = Rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
		fade.alpha = 0.35
		fade:setParallax(0)
		fade.color = {0, 0, 0}
		fade.layer = WORLD_LAYERS["below_ui"]
		Game.world:addChild(fade)
		Assets.playSound("noise")
		cutscene:wait(1)
		if Game:getFlag("future_variable") == "ceroba" then
			variant.flip_x = true
			variant:setSprite("shock")
		end
		Assets.playSound("motor_swing_down", 1, 1.1)
		fmarcy.flip_x = true
		fmarcy:setAnimation("battle/attack_ready")
		cutscene:wait(cutscene:slideTo(fmarcy, jamm.x + 120, jamm.y - 40, 0.3, "out-cubic"))
		cutscene:slideTo(fmarcy, jamm.x + 80, jamm.y - 20, 1.5)
		Game.world.music:play("strongwind_loop", 0, 0.5)
		Game.world.timer:tween(1.5, Game.world.music, {volume = 1})
		cutscene:wait(1.5)
		Game.world.music:pause()
		Assets.playSound("noise")
		fmarcy.layer = fmarcy_origlayer
		fade.alpha = 1
		cutscene:wait(1)
		variant:setPosition(jamm.x + 60, jamm.y)
		susie:setSprite("surprised_step_back_2")
		fade:remove()

		-- third party parries/blocks/deflects/whatever Marcy's attack
		if Game:getFlag("future_variable") == "ceroba" then
			local parry_fx = Sprite("world/cutscenes/parry_impact", variant.x + 40, variant.y - 40)
			parry_fx:setScale(2)
			parry_fx:setOrigin(0.5)
			parry_fx.layer = variant.layer - 0.1
			Game.world:addChild(parry_fx)
			Game.world.timer:after(0.1, function() parry_fx:remove() end)
			variant.flip_x = false
			local s = Assets.playSound("weaponpull", 1, 2)
			s:seek(0.06)
			s = Assets.playSound("weaponpull", 1, 0.8)
			s:seek(0.06)
			variant:setAnimation("battle/attack")
			fmarcy:setAnimation("battle/attack")
			cutscene:wait(cutscene:slideTo(fmarcy, fmarcy.x + 100, fmarcy.y + 20, 0.3))
			cutscene:wait(cutscene:slideTo(fmarcy, fmarcy.x + 40, fmarcy.y, 0.8))
		end

		cutscene:wait(2)

		cutscene:showNametag("Susie", {top=true})
		cutscene:text("* ...", "shock", "susie", {top=true})
		cutscene:hideNametag()
		cutscene:wait(1)
		fmarcy.flip_x = false
		fmarcy:setSprite("walk")
		fmarcy:setFacing("left")
		cutscene:walkToSpeed(fmarcy, fmarcy.x + 40, fmarcy.y, 1, "left", true)
		cutscene:wait(1)
		if Game:getFlag("future_variable") == "ceroba" then
			Assets.playSound("noise")
			variant:setSprite("walk")
			variant:setFacing("right")
		end
		cutscene:wait(1)
		susie:setSprite("walk_angry/right")
		cutscene:look(susie, "right")
		cutscene:text("* Oh you're dead to me now!", "angry_b_alt", "susie", {top=true})
		cutscene:hideNametag()

		Game.world.music:play("tense", 1, 1)
		susie:setAnimation("battle/attack")
		Assets.playSound("laz_c", 1, 0.9)
		local attack = Sprite("effects/attack/mash", fmarcy.x, fmarcy.y-fmarcy.height)
		attack:setScale(2)
		attack:setOrigin(0.5)
		attack.layer = WORLD_LAYERS["below_ui"]
		Game.world:addChild(attack)
		attack:play(1/15, false, function() attack:remove() end)

		cutscene:walkToSpeed(fmarcy, fmarcy.x, fmarcy.y - 60, 6, "down", true)
		cutscene:wait(1.5)

		-- third party helps out Jamm while Susie distracts the attacker
		if Game:getFlag("future_variable") == "ceroba" then
			variant:setFacing("left")
			variant:alert(nil, {play_sound=false})
			Game.world.timer:after(1, function()
				variant:setAnimation("crouch")
			end)
		end

		cutscene:panTo(1040, 260, 1.5)
		cutscene:walkToSpeed(fmarcy, fmarcy.x, 260, 8, "left")
		susie:setSprite("run_serious")
		cutscene:wait(cutscene:walkToSpeed(susie, susie.x, 260, 8, "right"))

		susie:setAnimation("battle/rude_buster")
		cutscene:wait(15/30)
		Assets.playSound("rudebuster_swing")
		local x, y = susie:getRelativePos(susie.width, susie.height/2 - 10, Game.world)
		local blast = RudeBusterBeam(false, x, y, fmarcy.x + 160, fmarcy.y-fmarcy.height)
		blast.layer = WORLD_LAYERS["below_ui"]
		Game.world:addChild(blast)
		cutscene:walkToSpeed(fmarcy, fmarcy.x, fmarcy.y - 100, 8, "down", true)
		
		cutscene:wait(2)
		
		cutscene:walkToSpeed(fmarcy, 1240, 260, 4, "left", true)
		susie:setSprite("walk_bangs")
		cutscene:wait(cutscene:walkToSpeed(susie, susie.x, 260, 4, "right"))
		
		susie:setSprite("walk_bangs")
		cutscene:showNametag("Susie")
		cutscene:text("* I don't know who the hell you think you are...", "bangs/neutral", "susie")
		cutscene:hideNametag()
		
		cutscene:wait(cutscene:walkToSpeed(susie, susie.x + 80, susie.y, 4, "right"))
		
		cutscene:showNametag("Susie")
		cutscene:text("* But you messed with the wrong heroes,[wait:5] you hear me?", "bangs/neutral", "susie")
		cutscene:hideNametag()
		
		cutscene:wait(cutscene:walkToSpeed(susie, susie.x + 40, susie.y, 4, "right"))
		cutscene:panTo("camera_to_2")
		cutscene:walkToSpeed(fmarcy, fmarcy.x + 80, fmarcy.y, 2, "left", true)
		cutscene:wait(cutscene:walkToSpeed(susie, susie.x + 160, susie.y, 4, "right"))
		
		cutscene:showNametag("Susie")
		cutscene:text("* Did you not hear me?", "bangs/teeth", "susie")
		cutscene:text("* You are going to pay for making Jamm hurt like that.[react:1]", "bangs/teeth", "susie", {reactions={
			{"Hold on, did\nyou say...", 352, 61, "neutral", "fmarcy"}
		}})
		cutscene:hideNametag()
		
		cutscene:setAnimation(susie, "battle/attack")
		Assets.playSound("laz_c")
		cutscene:wait(0.5)
		
		cutscene:showNametag("Susie")
		cutscene:text("* You do NOT mess with my friends.", "bangs/teeth_eye", "susie")
		cutscene:hideNametag()
		
		cutscene:setAnimation(susie, {"laugh_right", 1/4, true})
		cutscene:wait(cutscene:playSound("suslaugh"))
		
		cutscene:resetSprite(susie)
		
		Game.party[1].health = Game.party[1]:getStat("health")
		
		local party_id = Game.party[3].id
		Game:removePartyMember(party_id)
		Game:removePartyMember("jamm")
		
		cutscene:startEncounter("fmarcy_enrage", true, fmarcy)
		
		Game:addPartyMember("jamm")
		Game:addPartyMember(party_id)

		variant:resetSprite()
		
		if in_the_running and (Game.party[1].health == Game.party[1]:getStat("health")) then
            DP:completeAchievement("chase_fparty_nohit")
		end
		
		cutscene:showNametag("Jamm")
		cutscene:text("* Susie![wait:10] Snap out of it!", "speechless", "jamm")
		
		cutscene:showNametag("Susie")
		cutscene:text("* ...Jamm?", "bangs/neutral", "susie")
		cutscene:hideNametag()
		
		Game.world.player.actor.default = "walk"
		
		cutscene:wait(cutscene:setAnimation(susie, "battle/victory"))
		
		cutscene:look(susie, "left")
		cutscene:resetSprite(susie)
		
		cutscene:showNametag("Susie")
		cutscene:text("* Dude![wait:10]\n* You're okay!", "surprise_smile", "susie")
		
		cutscene:showNametag("Jamm")
		if Game:getFlag("future_variable") == "ceroba" then
			cutscene:text("* Thank the Angel I had my secret ReviveMint...[react:1]", "smirk", "jamm", {reactions={
				{"I helped him with it\nwhile you were occupied.", "mid", "bottom", "neutral_1", "ceroba"}
			}})
		else
			cutscene:text("* Thank the Angel I had my secret ReviveMint...", "smirk", "jamm")
		end
		cutscene:text("* But Susie,[wait:5] what was that!?", "determined", "jamm")
		cutscene:text("* We were trying to get your attention for a while now!", "determined", "jamm")
		
		cutscene:showNametag("Susie")
		cutscene:text("* I...[wait:5] lost control.", "shy_down", "susie")
		cutscene:text("* But now that I know the feeling of rage...", "neutral", "susie")
		cutscene:text("* I'll be able to [color:yellow]use it to my advantage[color:white].", "smile", "susie")
		
		cutscene:showNametag("Jamm")
		cutscene:text("* At least something good came out of it,[wait:5] right?", "smirk", "jamm")
		cutscene:text("* But that begs the question...", "neutral", "jamm")
		cutscene:hideNametag()
		
		cutscene:walkToSpeed(susie, susie.x, susie.y + 40, 4, "up", true)
		cutscene:wait(cutscene:walkToSpeed(jamm, jamm.x + 120, jamm.y, 4, "right"))
		
		cutscene:look(susie, "right")
		
		cutscene:showNametag("Jamm")
		cutscene:text("* Who exactly is this?", "suspicious", "jamm")
		
		cutscene:showNametag("???")
		cutscene:text("* Have I really changed so much that you don't recognize me?", "neutral", "fmarcy")
		cutscene:text("* Seeing you again,[wait:5] you haven't changed a bit...", "closed", "fmarcy")
		cutscene:text("* Have you,[wait:5] [color:yellow]dad[color:white]?", "neutral", "fmarcy")
		
		cutscene:showNametag("Jamm")
		cutscene:text("* ...!", "speechless", "jamm")
		cutscene:text("* W-wait...[wait:5]\n* Did you just call me...", "speechless_smile", "jamm")
		
		cutscene:showNametag("???")
		cutscene:text("* It's me,[wait:5] dad.[wait:10]\n* Your only daughter.", "neutral", "fmarcy")
		
		cutscene:showNametag("Marcy")
		cutscene:text("* Marcy.", "closed", "fmarcy")
		
		cutscene:showNametag("Jamm")
		cutscene:text("* I-is it really...???", "speechless", "jamm")
		cutscene:hideNametag()
		
		cutscene:wait(cutscene:walkToSpeed(jamm, jamm.x + 60, jamm.y, 4, "right"))
		
		cutscene:showNametag("Marcy")
		cutscene:text("* I'd advise against hugging me,[wait:5] father.", "neutral", "fmarcy")
		
		cutscene:walkToSpeed(susie, variant.x, susie.y, 8, "up")
		cutscene:walkToSpeed(variant, variant.x, variant.y - 40, 4, "down")
		
		cutscene:showNametag("Jamm")
		cutscene:text("* S-sorry,[wait:5] I just...", "nervous", "jamm")
		cutscene:text("* I need to be really sure that you're my daughter.", "suspicious", "jamm")
		
		cutscene:showNametag("Marcy")
		cutscene:text("* Proving myself to you is inconsequential,[wait:5] but if you must...", "closed", "fmarcy")
		cutscene:text("* Ask me anything.", "untrusting", "fmarcy")
		
		cutscene:showNametag("Jamm")
		cutscene:text("* (Alright,[wait:5] where to start...)", "neutral", "jamm")
		cutscene:hideNametag()
		
		local choice = cutscene:choicer({"Favorite\ncolor", "Favorite\nfood"})
		
		if choice == 1 then
			cutscene:showNametag("Jamm")
			cutscene:text("* The Marcy I know had a favorite color back in preschool.", "neutral", "jamm")
		
			cutscene:showNametag("Marcy")
			cutscene:text("* Yellow.[wait:10]\n* Specifically, \"New Yeller.\"", "closed", "fmarcy")
		else
			cutscene:showNametag("Jamm")
			cutscene:text("* The Marcy I know had a favorite food.", "neutral", "jamm")
		
			cutscene:showNametag("Marcy")
			cutscene:text("* Mom's chicken terriyaki recipe.", "closed", "fmarcy")
		end
		cutscene:hideNametag()
		
		local choice = cutscene:choicer({"Outfit", "Hobby"})
		
		if choice == 1 then
			cutscene:showNametag("Jamm")
			cutscene:text("* Okay,[wait:5] but what was your favorite outfit?", "neutral", "jamm")
		
			cutscene:showNametag("Marcy")
			cutscene:text("* Sleeveless green shirt,[wait:5] gray pants.", "closed", "fmarcy")
		else
			cutscene:showNametag("Jamm")
			cutscene:text("* Okay,[wait:5] but what was your favorite hobby?", "neutral", "jamm")
		
			cutscene:showNametag("Marcy")
			cutscene:text("* Drawing with crayons.", "closed", "fmarcy")
		end
		cutscene:text("* Everyone knows that one,[wait:5] dad.", "neutral", "fmarcy")
		cutscene:hideNametag()
		
		local choice = cutscene:choicer({"The\nincident", "Characters"})
		
		if choice == 1 then
			cutscene:showNametag("Jamm")
			cutscene:text("* What was [color:yellow]the incident[color:white] back in 3rd grade?", "neutral", "jamm")
		
			cutscene:showNametag("Marcy")
			cutscene:text("* We agreed never to discuss it.", "closed", "fmarcy")
		else
			cutscene:showNametag("Jamm")
			cutscene:text("* Which Deoxynn character did you make?", "neutral", "jamm")
		
			cutscene:showNametag("Marcy")
			cutscene:text("* Trick question.[wait:10]\n* I made Pravetz in Soulsweeper.", "closed", "fmarcy")
		end
		
		cutscene:showNametag("Jamm")
		cutscene:text("* I-I...[wait:10]\n* I can't believe it...", "speechless", "jamm")
		
		cutscene:showNametag("Marcy")
		cutscene:text("* And I'm not alone.", "neutral", "fmarcy")
		cutscene:look(fmarcy, "down")
		local fparty_id = Mod:getVariableFuture(Game.party[3].id)
		cutscene:text("* Noelle.[func:reveal][wait:10] " .. Game:getPartyMember(fparty_id):getName() .. ".[wait:10]\n* You might want to see this.", "neutral", "fmarcy", {functions = {
			reveal = function()
				susie:setFacing("right")
				variant:setFacing("right")
				susie:alert()
			end
		}})
		cutscene:hideNametag()
		cutscene:look(jamm, "down")
		
		cutscene:walkToSpeed(fnoelle, fnoelle.x - 400, fnoelle.y, 6)
		cutscene:wait(cutscene:walkToSpeed(fvariant, fvariant.x - 400, fvariant.y, 6))
		
		cutscene:showNametag("Susie")
		cutscene:text("* Noelle???", "surprise", "susie")
		cutscene:hideNametag()
		
		cutscene:walkToSpeed(susie, susie.x, fnoelle.y, 6)
		cutscene:wait(cutscene:walkToSpeed(variant, variant.x, fvariant.y, 6))
		
		cutscene:walkToSpeed(susie, fnoelle.x - 120, fnoelle.y, 6)
		cutscene:wait(cutscene:walkToSpeed(variant, fvariant.x - 80, fvariant.y, 6))
		
		if Game:getFlag("future_variable") == "ceroba" then
			cutscene:showNametag("Kanako", {left=true})
			cutscene:text("* Wait...[wait:5] Are you...", "shock", "fkanako")
			cutscene:text("* My...[wait:5] mother...?", "serious", "fkanako")
			cutscene:showNametag("Ceroba", {left=true})
			cutscene:text("* K...[wait:5] Kanako?", "surprised", "ceroba")
			cutscene:showNametag("Kanako", {left=true})
			cutscene:text("* I thought you...", "neutral", "fkanako")
		end
		
		cutscene:showNametag("Susie", {left=true})
		cutscene:text("* Noelle, hey![wait:10]\n* It's cool to...", "surprise_smile", "susie")
		cutscene:text("* ...Wait a minute...", "neutral", "susie")
		cutscene:text("* Where did you get that jacket...?", "neutral", "susie")
		cutscene:text("* And your antlers and hair...", "nervous", "susie")
		
        cutscene:showNametag("Noelle", {left=true})
		cutscene:text("* It's been...", "tense/guilty_4", "fnoelle")
		cutscene:text("* It's been so long...", "tense/guilty_5", "fnoelle")
		
		cutscene:showNametag("Susie", {left=true})
		cutscene:text("* ...What?", "nervous", "susie")
		
		cutscene:showNametag("Marcy", {left=true})
		cutscene:text("* You three have been missing for a decade,[wait:5] Susie.", "closed", "fmarcy")
		
		cutscene:showNametag("Susie", {left=true})
		cutscene:text("* A decade!?[wait:10]\n* That's like...[wait:10] A hundred years!", "surprise_frown", "susie")
		
		cutscene:showNametag("Jamm", {left=true})
		cutscene:text("* ...Ten years,[wait:5] Susie.[wait:10]\n* We've been missing for ten y--", "stern", "jamm", {auto=true})
		cutscene:look(jamm, "right")
		cutscene:text("* Wait a minute,[wait:5] what do you mean we've been missing for a decade?", "nervous", "jamm")
		
		cutscene:look(fmarcy, "left")
		cutscene:showNametag("Marcy", {left=true})
		cutscene:text("* We did all we could to look for you after you disappeared...", "neutral", "fmarcy")
		cutscene:look(fmarcy, "down")
		cutscene:look(jamm, "down")
		
		if Game:getFlag("future_variable") == "ceroba" then
			variant:setSprite("shock_angry")
			variant.flip_x = true
			cutscene:showNametag("Ceroba", {left=true})
			cutscene:text("* What?![wait:10] I disappeared?!", "surprised", "ceroba")
			variant:resetSprite()
			variant.flip_x = false
			cutscene:showNametag("Kanako", {left=true})
			cutscene:text("* Well,[wait:5] one day you just...[wait:10] Didn't come back home.", "neutral", "fkanako")
			cutscene:text("* Uncle Star and the rest searched for you,[wait:5] but nobody could find you.", "eyes_closed", "fkanako")
			cutscene:text("* Then I heard Marcy and Noelle lost Jamm and Susie,[wait:5] and...", "eyes_left", "fkanako")
			cutscene:text("* We decided to look for you three together.", "neutral", "fkanako")
		end
		
		cutscene:showNametag("Susie", {left=true})
		cutscene:text("* Damn...", "shy_down", "susie")
		cutscene:text("* Can't believe we went missing.", "neutral", "susie")
		
		cutscene:showNametag("Marcy", {left=true})
		cutscene:text("* If I may ask...", "closed", "fmarcy")
		cutscene:look(fmarcy, "left")
		cutscene:look(jamm, "right")
		cutscene:text("* Why did you three choose to return here?[wait:10]\n* Why now?", "neutral", "fmarcy")
		cutscene:text("* And where the hell were you when we needed you most?", "neutral", "fmarcy")
		cutscene:look(jamm, "right")
		cutscene:showNametag("Jamm", {left=true})
		cutscene:text("* Well,[wait:5] it wasn't exactly by choice...", "nervous", "jamm")
		cutscene:hideNametag()
		
		cutscene:wait(cutscene:fadeOut())
		
		cutscene:text("* The three of you explain what happened.")
		
		-- 1160, 240
		local lore_board = Registry.createLegacyEvent("lore_board", {x = 1160, y = 240, properties = {}})
		Game.world:spawnObject(lore_board)
		
		jamm.x = 1300
		jamm.y = 240
		variant.x = 1020
		variant.y = 240
		susie.x = 1160
		susie.y = 280
		jamm:setFacing("down")
		variant:setFacing("down")
		susie:setFacing("left")
		
		fvariant.x = 1240
		fvariant.y = 400
		fnoelle.x = 1080
		fnoelle.y = 400
		fmarcy.x = 1160
		fmarcy.y = 400
		fvariant:setFacing("up")
		fnoelle:setFacing("up")
		fmarcy:setFacing("up")
		
		cutscene:wait(cutscene:fadeIn())
		
		cutscene:showNametag("Susie")
		cutscene:text("* ...And,[wait:5] uh,[wait:5] I think that covers it.", "nervous", "susie")
		susie:setFacing("down")
		
		cutscene:showNametag("Marcy", {top=true})
		cutscene:text("* I hate how much sense that makes...", "closed", "fmarcy", {top=true})
		cutscene:text("* There have been so many rifts opening up in our world.", "neutral", "fmarcy", {top=true})
		cutscene:text("* If they started opening up a decade ago...", "neutral", "fmarcy", {top=true})
		
		if Game:getFlag("future_variable") == "ceroba" then
			cutscene:showNametag("Kanako", {top=true})
			cutscene:text("* And we're just supposed to forgive that?", "unimpressed", "fkanako", {top=true})
			cutscene:text("* This is all your fault,[wait:5] you know!", "angry", "fkanako", {top=true})
			cutscene:text("* If you hadn't touched that rift,[wait:5] you'd be in your own time!", "angry", "fkanako", {top=true})
		end
		fmarcy:setFacing("right")
		
		cutscene:showNametag("Marcy", {top=true})
		cutscene:text("* Stand down,[wait:5] " .. Game:getPartyMember(fparty_id):getName() .. ".[wait:10] That's an order.", "upset", "fmarcy", {top=true})
		cutscene:text("* I get you're upset right now.[wait:10] We all are.", "upset", "fmarcy", {top=true})
		cutscene:text("* But yelling at them won't help matters at all.", "closed", "fmarcy", {top=true})
		fmarcy:setFacing("up")
		
		if Game:getFlag("future_variable") == "ceroba" then
			cutscene:showNametag("Ceroba", {top=true})
			cutscene:text("* What happened here,[wait:5] anyways?", "question", "ceroba", {top=true})
		end
		
		cutscene:showNametag("Marcy", {top=true})
		cutscene:text("* ...The Knight happened.", "neutral", "fmarcy", {top=true})
		cutscene:text("* They kept opening fountains one by one,[wait:5] until the rifts...", "neutral", "fmarcy", {top=true})
		cutscene:text("* They became too many to handle and the fountains started freezing.", "neutral", "fmarcy", {top=true})
		cutscene:text("* Before we knew it,[wait:5] the darkners were stone and the war had begun.", "closed", "fmarcy", {top=true})
		cutscene:hideNametag()
		
		cutscene:wait(cutscene:walkToSpeed(susie, jamm.x, susie.y, 4))
		cutscene:walkToSpeed(jamm, jamm.x, jamm.y - 40, 4, "down", true)
		cutscene:wait(cutscene:walkToSpeed(susie, jamm.x, susie.y - 40, 4))
		
		cutscene:setSprite(susie, "serious_kick_ready")
		
		local ready_to_proceed = false
		cutscene:showNametag("Susie")
		cutscene:text("* That damn...", "angry", "susie")
		susie:setAnimation({"serious_kick", 1/10, false}, function()
			lore_board:explode()
			Game.world.timer:after(1, function()
				ready_to_proceed = true
			end)
		end)
		cutscene:text("* KNIGHT!", "teeth", "susie")
		cutscene:hideNametag()
		
		cutscene:wait(function() return ready_to_proceed end)
		
		susie:setFacing("down")
		cutscene:resetSprite(susie)
		cutscene:showNametag("Susie")
		cutscene:text("* If only I had been able to stop them before all this happened...", "bangs_neutral", "susie")
		
		cutscene:showNametag("Jamm")
		cutscene:text("* You did the best you could...", "worried", "jamm")
		
		cutscene:showNametag("Marcy")
		cutscene:text("* ...And now,[wait:5] there's nothing you can do.", "neutral", "fmarcy")
		cutscene:text("* Let us bring you to Hometown.", "neutral", "fmarcy")
		cutscene:text("* You three will be safe there,[wait:5] I promise.", "neutral", "fmarcy")
		cutscene:hideNametag()
		
		cutscene:walkToSpeed(fmarcy, 1640, fmarcy.y, 6)
		cutscene:walkToSpeed(fnoelle, 1640, fnoelle.y, 6)
		cutscene:wait(cutscene:walkToSpeed(fvariant, 1640, fvariant.y, 6))
		
		cutscene:detachFollowers()
		jamm:convertToFollower(1)
		variant:convertToFollower(2)
		
		cutscene:attachCamera(1)
		cutscene:attachFollowers(8)
		cutscene:wait(1)

		Game:setFlag("future_chase_done", true)
		
		Game.party[1]:addSpell("rage")
		Game:getPartyMember("susie").title = "Barbarian\nTackles problems\nhead-on."
		
		Game.world.music:play("deltarune/wind_highplace", 1, 1)
	end,
	
	exit_cliffs = function(cutscene)
        local jamm = cutscene:getCharacter("jamm")
		local susie = cutscene:getCharacter("susie")
		local variant = cutscene:getCharacter(Game:getFlag("future_variable"))
		local fmarcy = cutscene:getCharacter("fmarcy")
		
		Game:setFlag("future_met_fp", true)
		
		cutscene:wait(cutscene:fadeOut())
		
		cutscene:detachFollowers()
		
		susie.x = fmarcy.x - 80
		jamm.x = susie.x - 80
		variant.x = jamm.x
		
		susie.y = fmarcy.y
		jamm.y = susie.y
		variant.y = jamm.y + 80
		
		susie:setFacing("right")
		jamm:setFacing("right")
		variant:setFacing("right")
		
		Game.world.map:getTileLayer("Tile Layer 3").visible = true
		Game.world.map:getTileLayer("Tile Layer 4").visible = true
		
		cutscene:wait(cutscene:fadeIn())
		
		cutscene:showNametag("Marcy")
		cutscene:text("* The other two already went down.", "neutral", "fmarcy")
		cutscene:text("* Follow me once you built up the courage.", "neutral", "fmarcy")
		cutscene:text("* Be warned:[wait:10] The wall ends pretty quickly.", "neutral", "fmarcy")
		cutscene:hideNametag()
		
		local sound = Assets.newSound("paper_surf")
		sound:setLooping(true)
		
		cutscene:during(function()
			sound:setVolume(math.max(sound:getVolume() - DT/2, 0))
		end)
		
		cutscene:wait(cutscene:walkToSpeed(fmarcy, fmarcy.x, fmarcy.y + 80, 4))
		cutscene:setSprite(fmarcy, "slide")
		Assets.playSound("noise")
		sound:play()
		sound:setVolume(1)
		cutscene:wait(cutscene:slideTo(fmarcy, fmarcy.x, fmarcy.y + 280, 0.5))
		
		cutscene:walkTo(susie, "susie_walkto", 1, "down")
        cutscene:walkTo(jamm, "jamm_walkto", 1, "down")
        cutscene:wait(cutscene:walkTo(variant, "variant_walkto", 1, "down"))
		
		cutscene:showNametag("Jamm")
		cutscene:text("* Hole's kinda deep...", "nervous", "jamm")
		
		if Game:getFlag("future_variable") == "ceroba" then
			cutscene:showNametag("Ceroba")
			cutscene:text("* I'm afraid it's our only way forward...", "dissapproving", "ceroba")
		end
		
		cutscene:showNametag("Susie")
		cutscene:text("* What,[wait:5] you got a fear of heights or something?", "smile", "susie")
		
		cutscene:showNametag("Jamm")
		cutscene:text("* Wh-what!?[wait:10]\n* I do not!", "nervous_left", "jamm")
		cutscene:text("* Here,[wait:5] I'll go in first,[wait:5] then!", "nervous", "jamm")
		cutscene:hideNametag()
		
		cutscene:wait(cutscene:walkToSpeed(jamm, jamm.x + 40, jamm.y, 4))
		cutscene:wait(cutscene:walkToSpeed(jamm, jamm.x, jamm.y + 40, 4))
		cutscene:setSprite(jamm, "slide")
		Assets.playSound("noise")
		sound:setVolume(1)
		cutscene:wait(cutscene:slideTo(jamm, jamm.x, jamm.y + 280, 0.5))
		
		cutscene:showNametag("Susie")
		cutscene:text("* Huh.[wait:10]\n* He actually did it.", "shock", "susie")
		
		if Game:getFlag("future_variable") == "ceroba" then
			cutscene:showNametag("Ceroba")
			cutscene:text("[speed:0.5]* ...", "nervous_1", "ceroba")
			cutscene:showNametag("Susie")
			cutscene:text("* Uh,[wait:5] you going or what?", "nervous_side", "susie")
			variant:setFacing("up")
			cutscene:showNametag("Ceroba")
			cutscene:text("* Oh?[wait:5] Uh,[wait:5] yeah,[wait:5] haha,[wait:5] of course!", "nervous_smile", "ceroba")
			cutscene:showNametag("Susie")
			cutscene:text("* Wait,[wait:5] don't tell me...", "teeth_smile", "susie")
			cutscene:text("* YOU'RE afraid of heights!?", "sincere_smile", "susie")
			cutscene:hideNametag()
			Assets.playSound("suslaugh")
			cutscene:setAnimation(susie, {"laugh_right", 1/4, true})
			cutscene:wait(1.5)
			cutscene:showNametag("Susie")
			cutscene:text("* And I thought you're supposed to be the most mature one here,[wait:5] haha!", "teeth_smile", "susie")
			cutscene:showNametag("Ceroba")
			cutscene:text("* Fearing heights doesn't make me less-", "irked", "ceroba")
			susie:resetSprite()
			cutscene:text("* Okay,[wait:5] actually,[wait:5] you know what?", "dissapproving", "ceroba")
			variant:setFacing("down")
			cutscene:text("* Let's just go.", "unamused", "ceroba")
		end
		cutscene:hideNametag()
		
		cutscene:wait(cutscene:walkToSpeed(variant, variant.x - 40, variant.y, 4))
		cutscene:wait(cutscene:walkToSpeed(variant, variant.x, variant.y + 40, 4))
		cutscene:setSprite(variant, "slide")
		Assets.playSound("noise")
		sound:setVolume(1)
		cutscene:wait(cutscene:slideTo(variant, variant.x, variant.y + 280, 0.5))
		cutscene:wait(0.5)
		
		cutscene:wait(cutscene:walkToSpeed(susie, susie.x, susie.y + 40, 4))
		cutscene:setSprite(susie, "slide")
		Assets.playSound("noise")
		sound:setVolume(1)
		cutscene:wait(cutscene:slideTo(susie, susie.x, susie.y + 280, 0.5))
		
		cutscene:wait(cutscene:fadeOut())
		cutscene:loadMap("main_hub", "landing")
		Game.world.music:stop()
		
        local jamm = cutscene:getCharacter("jamm")
		local susie = cutscene:getCharacter("susie")
		local variant = cutscene:getCharacter(Game:getFlag("future_variable"))
		local fmarcy = cutscene:getCharacter("fmarcy")
		
		cutscene:detachFollowers()
		
		local rect = Rectangle(0, 0, 9999, 9999)
		rect.color = {0, 0, 0}
		rect:setLayer(WORLD_LAYERS["above_events"])
		Game.world:addChild(rect)
		
		susie:setLayer(rect.layer + 1)
		
		jamm.x = susie.x - 80
		jamm:setFacing("up")
		
		variant.x = susie.x + 60
		variant.y = susie.y + 40
		
		susie:setAnimation({"fall", 1/15, true})
		
		cutscene:wait(cutscene:fadeIn(1.5))
		
		cutscene:wait(1)
		
		susie:setSprite("landed_1")
		Assets.playSound("dtrans_flip")
		susie:shake(2)
		
		cutscene:wait(1)
		
		Assets.playSound("him_quick")
		Game.world.timer:tween(0.65, rect, {alpha = 0})
		
		cutscene:wait(1)
		
		Game.world.music:play()
		
		cutscene:setSprite(susie, "landed_2")
		cutscene:wait(1/10)
		cutscene:resetSprite(susie)
		
		susie:setLayer(Game.world.followers[1].layer)
		
		cutscene:look(susie, "left")
		cutscene:wait(0.25)
		cutscene:look(susie, "right")
		cutscene:wait(0.25)
		cutscene:look(susie, "up")
		cutscene:wait(0.25)
		
		cutscene:showNametag("Susie")
		cutscene:text("* Jeez...[wait:10]\n* The hell is this place?", "nervous", "susie")
		cutscene:text("* It seems pretty...[wait:10]\n* Dead.", "nervous_side", "susie")
		
		cutscene:look(susie, "left")
		
		cutscene:showNametag("Jamm")
		cutscene:text("* Susie,[wait:5] I...[wait:10]\n* I think this is the hub.", "nervous_left", "jamm")
		
		cutscene:showNametag("Marcy")
		cutscene:text("* Or what's left of it,[wait:5] that is.", "closed", "fmarcy")
		cutscene:hideNametag()
		
		cutscene:wait(cutscene:panTo(fmarcy.x, fmarcy.y))
		
		cutscene:look(susie, "up")
		cutscene:look(jamm, "up")
		cutscene:look(variant, "up")
		
		cutscene:showNametag("Marcy", {top=false})
		cutscene:text("* The Endless War...[wait:10]\n* It ruined this place real bad.", "closed", "fmarcy", {top=false})
		cutscene:text("* I don't remember how to leave this place.", "neutral", "fmarcy", {top=false})
		cutscene:hideNametag()
		
		cutscene:wait(cutscene:attachCamera())
		
		cutscene:look(jamm, "right")
		cutscene:look(variant, "left")
		
		cutscene:showNametag("Susie")
		cutscene:text("* ...Right.", "nervous", "susie")
		cutscene:hideNametag()
		
		cutscene:look(susie, "down")
		
		cutscene:wait(cutscene:walkToSpeed(jamm, susie.x - 60, susie.y + 40, 4, "right"))
		
		cutscene:showNametag("Susie")
		cutscene:text("* Let's think...[wait:10]\n* How do we leave this place again?", "nervous", "susie")
		
		cutscene:showNametag("Jamm")
		cutscene:text("* Well,[wait:5] we could probably use the elevator...", "side_smile", "jamm")
		
		if Game:getFlag("future_variable") == "ceroba" then
			cutscene:showNametag("Ceroba")
			cutscene:text("* Or maybe the warp bin.", "alt", "ceroba")
		end
		
		cutscene:showNametag("Susie")
		cutscene:text("* The Great Door might be helpful,[wait:5] too.", "small_smile", "susie")
		cutscene:look(susie, "up")
		cutscene:text("* And if none of those work,[wait:5] there's always this wall.", "smile", "susie")
		
		cutscene:showNametag("Jamm")
		cutscene:text("* Let's try what we came up with first...", "nervous", "jamm")
		cutscene:hideNametag()
		cutscene:interpolateFollowers()
		cutscene:attachFollowers(8)
		cutscene:wait(1)
	end
}
