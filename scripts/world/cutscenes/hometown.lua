return {
	not_yet = function(cutscene, event)
		cutscene:showNametag("Jamm")
		cutscene:text("* Wait,[wait:5] didn't Noelle say to go to the graveyard?", "nervous", "jamm")
		cutscene:showNametag("Susie")
		cutscene:text("* Yeah.[wait:10]\n* Where the hell are you going,[wait:5] Jamm?", "nervous", "susie")
		cutscene:hideNametag()
		cutscene:wait(cutscene:walkTo(Game.world.player, Game.world.player.x - 40, Game.world.player.y + 40, 1))
    end,
	
	not_yet_church = function(cutscene, event)
		if not Game:getFlag("future_hometown_graveyard_cutscene") then
			cutscene:showNametag("Jamm")
			cutscene:text("* Wait,[wait:5] didn't Noelle say to go to the graveyard?", "nervous", "jamm")
			cutscene:showNametag("Susie")
			cutscene:text("* Yeah.[wait:10]\n* Where the hell are you going,[wait:5] Jamm?", "nervous", "susie")
			cutscene:hideNametag()
			cutscene:wait(cutscene:walkTo(Game.world.player, Game.world.player.x, Game.world.player.y + 40, 1))
		else
			Assets.playSound("dooropen")
			cutscene:mapTransition("hometown/church/entrance", "south", "up")
			cutscene:wait(0.5)
			Assets.playSound("doorclose")
			cutscene:wait(0.5)
		end
    end,
	
	berdly_graveyard = function(cutscene, event)
		if not Game:getFlag("future_berdly_graveyard") then
			Game:setFlag("future_berdly_graveyard", true)
			cutscene:showNametag("Susie")
			cutscene:text("* Wait,[wait:5] is that...", "nervous_side", "susie")
			cutscene:hideNametag()
			
			local jamm = cutscene:getCharacter("jamm")
			local susie = cutscene:getCharacter("susie")
			local variant = cutscene:getCharacter(Game:getFlag("future_variable"))
			
			local fmarcy = cutscene:getCharacter("fmarcy")
			local fberdly = cutscene:getCharacter("fberdly")
			
			Game.world.music:fade(0, 0.8)
			
			cutscene:wait(cutscene:panTo(440, 320, 1))
			
			cutscene:detachFollowers()
			
			jamm.x = 854.5
			jamm.y = 320
			susie.x = 902.5
			susie.y = 320
			variant.x = 950.5
			variant.y = 320
			
			cutscene:interpolateFollowers()
			cutscene:attachFollowers()
			
			Game.world.music:play("berdly_theme", 1, 1)
			
			cutscene:showNametag("Berdly")
			cutscene:text("* Ah,[wait:5] the Light Reaper has returned.", "neutral", "fberdly")
			cutscene:text("* Tell me,[wait:5] what did you find in that little mission of yours?", "questioning", "fberdly")
			cutscene:showNametag("Marcy")
			cutscene:text("* All reports must be made in writing first,[wait:5] Berdly.", "neutral", "fmarcy")
			cutscene:showNametag("Berdly")
			cutscene:text("* Strict on the rules as always,[wait:5] are you,[wait:5] Marcy?", "doubtful", "fberdly")
			cutscene:text("* I suppose after years of experiencing hackers,[wait:5] I sort of understand.", "smirk", "fberdly")
			cutscene:showNametag("Marcy")
			cutscene:text("* I do what I must to ensure the safety of everyone.", "closed", "fmarcy")
			cutscene:text("* Rules are put in place for a reason,[wait:5] and we must follow them.", "neutral", "fmarcy")
			cutscene:showNametag("Berdly")
			cutscene:text("* But that is why you should tell me!", "surprised", "fberdly")
			cutscene:look(fberdly, "up")
			cutscene:text("* Surely if there's any danger,[wait:5] it's our responsibility to...", "worried_smile", "fberdly")
			cutscene:look(fberdly, "right")
			cutscene:showNametag("Marcy")
			cutscene:text("* You will be briefed on my findings later.", "neutral", "fmarcy")
			cutscene:text("* As a leader,[wait:5] you do deserve to know,[wait:5] but I am following protocol.", "neutral", "fmarcy")
			cutscene:text("* A threat is not imminent,[wait:5] so stand down.", "neutral", "fmarcy")
			cutscene:showNametag("Berdly")
			cutscene:text("* I-I see...[wait:5]\n* That's all I needed to know,[wait:5] then.", "worried_smile", "fberdly")
			cutscene:text("* If that's the case,[wait:5] then I'll be on my...", "look_up", "fberdly")
			cutscene:text("* ...Hold on a moment...", "neutral", "fberdly")
			cutscene:hideNametag()
			
			susie:setSprite("fail_avoid_gaze")
			if Game:hasUnlockedPartyMember("berdly") then
				jamm:setSprite("fail_avoid_gaze")
			end
			
			cutscene:wait(cutscene:panTo(720, 320, 1))
			
			cutscene:wait(cutscene:walkToSpeed(fberdly, fberdly.x, fberdly.y + 40, 5))
			cutscene:wait(cutscene:walkToSpeed(fberdly, fberdly.x + 200, fberdly.y, 5))
			cutscene:look(fmarcy, "right")
			
			cutscene:alert(fberdly)
			fberdly:setSprite("shocked")
			cutscene:shakeCharacter(fberdly, 3)
			
			cutscene:wait(0.5)
			
			cutscene:showNametag("Berdly", {top = true})
			if Game:hasUnlockedPartyMember("berdly") then
				cutscene:text("* S-Susan!?[wait:10] Luthane!?[react:1][react:2]", "surprised", "fberdly", {top = true, reactions={
					{"Crud...", 352, 61, "sus_nervous", "susie"},
					{"", 472, 61, "worried", "jamm"},
				}})
			else
				cutscene:text("* S-Susan!?[react:1]", "surprised", "fberdly", {top = true, reactions={
					{"Crud...", 352, 61, "sus_nervous", "susie"},
				}})
			end
			
			susie:resetSprite()
			jamm:resetSprite()
			fberdly:resetSprite()
			cutscene:text("* What the...[wait:10] How th...", "surprised", "fberdly", {top = true})
			cutscene:text("* How are you here right now!?", "scared", "fberdly", {top = true})
			if Game:hasUnlockedPartyMember("berdly") then
				cutscene:showNametag("Jamm", {top = true})
				cutscene:text("* ...My daughter brought us here.", "nervous", "jamm", {top = true})
				cutscene:showNametag("Berdly", {top = true})
				cutscene:text("* But you were missing for a decade!", "angry_b", "fberdly", {top = true})
				cutscene:text("* What were you doing all this time!?", "angry", "fberdly", {top = true})
				cutscene:text("* What,[wait:5] did she find you 15 minutes ago or something!?", "angry", "fberdly", {top = true})
				cutscene:showNametag("Jamm", {top = true})
				cutscene:text("* Hey,[wait:5] 15 minutes ago,[wait:5] we were 10 years in the past.", "stern", "jamm", {top = true})
				cutscene:showNametag("Berdly", {top = true})
				cutscene:text("* That doesn't even make any sense!", "angry_sweat", "fberdly", {top = true})
				
				if Game:getFlag("future_variable") == "ceroba" then
					cutscene:showNametag("Ceroba", {top = true})
					cutscene:text("* We traveled in time against our wills.", "neutral", "ceroba", {top = true})
				end
				
				cutscene:showNametag("Susie", {top = true})
				cutscene:text("* And we can't get back,[wait:5] so...", "annoyed", "susie", {top = true})
			else
				cutscene:showNametag("Susie", {top = true})
				cutscene:text("* ...We...[wait:10] walked here???", "nervous", "susie", {top = true})
				cutscene:showNametag("Berdly", {top = true})
				cutscene:text("* But you were missing for a decade!", "surprised", "fberdly", {top = true})
				cutscene:showNametag("Jamm", {top = true})
				cutscene:text("* You weren't exactly here when we weren't missing.", "nervous", "jamm", {top = true})
				cutscene:showNametag("Susie", {top = true})
				cutscene:text("* Yeah,[wait:5] so where were you,[wait:5] then?", "annoyed", "susie", {top = true})
				cutscene:look(fberdly, "down")
				cutscene:showNametag("Berdly", {top = true})
				cutscene:text("* I was trapped...", "sad_b", "fberdly", {top = true})
				cutscene:text("* I was trapped in a poorly-designed video game.", "sad_c", "fberdly", {top = true})
				cutscene:text("* All the terrible enemy designs and bad collision...", "sad", "fberdly", {top = true})
				cutscene:look(fberdly, "right")
				
				if Game:getFlag("future_variable") == "ceroba" then
					cutscene:showNametag("Ceroba", {top = true})
					cutscene:text("* I mean,[wait:5] I don't know a lot about electronics,[wait:5] but...", "neutral", "ceroba", {top = true})
					cutscene:text("* ...How did you get out?", "question", "ceroba", {top = true})
				end
				
				cutscene:showNametag("Berdly", {top = true})
				cutscene:text("* A poorly-designed game like that couldn't be free of glitches...", "doubtful", "fberdly", {top = true})
				cutscene:text("* So I spent years studying the game's terrible physics.", "laugh", "fberdly", {top = true})
				cutscene:text("* I eventually found an exploit that gave me infinite strength...", "smirk", "fberdly", {top = true})
				cutscene:text("* And used that strength to defeat the final boss!", "glorious", "fberdly", {top = true})
				cutscene:showNametag("Susie", {top = true})
				cutscene:text("* Right...", "nervous_side", "susie", {top = true})
				cutscene:showNametag("Berdly", {top = true})
				cutscene:text("* Marcy's group was waiting for me when I got out.[react:1]", "surprised", "fberdly", {top = true, reactions={
					{"We just got\nthere...", 352, 61, "neutral", "fmarcy"},
				}})
				cutscene:text("* They thought I could be a valuable asset to the Resistance...[react:1]", "surprised", "fberdly", {top = true, reactions={
					{"We never said\nthat...", 352, 61, "neutral", "fmarcy"},
				}})
				cutscene:text("* And so,[wait:5] I've been putting my brilliant stupidity to good use!", "surprised", "fberdly", {top = true})
				cutscene:look(jamm, "right")
				cutscene:showNametag("Jamm", {top = true})
				cutscene:text("* (...His what now?)", "nervous", "jamm", {top = true})
				cutscene:showNametag("Susie", {top = true})
				cutscene:text("* (Long story.)", "annoyed", "susie", {top = true})
				cutscene:look(jamm, "left")
			end
			cutscene:look(fmarcy, "down")
			cutscene:look(fberdly, "up")
			cutscene:showNametag("Marcy", {top = true})
			cutscene:text("* Berdly,[wait:5] if you don't mind,[wait:5] I have business with them.", "closed", "fmarcy", {top = true})
			cutscene:text("* And don't you have your own assignments to get done?", "neutral", "fmarcy", {top = true})
			cutscene:showNametag("Berdly", {top = true})
			cutscene:text("* Well put,[wait:5] my reaper-wielding rival![react:1]", "laugh", "fberdly", {top = true, reactions={
				{"We're not rivals.", 352, 61, "neutral", "fmarcy"},
			}})
			cutscene:look(fmarcy, "right")
			cutscene:look(fberdly, "right")
			cutscene:text("* It was nice running into you,[wait:5] Susan,[wait:5] but I must be off.", "laugh", "fberdly", {top = true})
			cutscene:text("* I've got a game to complete.[react:1][wait:5][react:2]", "look_up", "fberdly", {top = true, reactions={
				{"...What?", 120, 61, "nervous", "susie"},
				{"Don't ask.", 302, 61, "closed", "fmarcy"},
			}})
			cutscene:hideNametag()
			Game.world.music:fade(0, 1)
			cutscene:wait(cutscene:walkToSpeed(fberdly, 1240, fberdly.y, 10))
			fberdly:remove()
			Game.world.music:play("future_world", 1)
			cutscene:showNametag("Susie", {top = true})
			cutscene:text("* ...Hey,[wait:5] uh...", "neutral", "susie", {top = true})
			cutscene:text("* Did anyone else notice that he looked like he did ten years ago?", "nervous", "susie", {top = true})
			cutscene:showNametag("Marcy", {top = true})
			cutscene:text("* Right...[wait:5] the Collapse affects everyone differently.", "closed", "fmarcy", {top = true})
			cutscene:text("* Some attune to the dark,[wait:5] some start to forget stuff...", "neutral", "fmarcy", {top = true})
			cutscene:text("* In Berdly's case,[wait:5] it halted his aging completely.", "closed", "fmarcy", {top = true})
			cutscene:text("* I guess that helps him out a bit...", "lookright", "fmarcy", {top = true})
			cutscene:look(fmarcy, "left")
			cutscene:text("* Now come.[wait:10]\n* There's something we need to talk about.", "closed", "fmarcy", {top = true})
			cutscene:hideNametag()
			cutscene:walkToSpeed(fmarcy, fmarcy.x - 60, fmarcy.y, 4)
			cutscene:attachFollowers(4)
			cutscene:wait(cutscene:attachCamera(1))
			fmarcy:remove()
		end
    end,
	
	our_graves = function(cutscene, event)
		local jamm = cutscene:getCharacter("jamm")
		local susie = cutscene:getCharacter("susie")
		local variant = cutscene:getCharacter(Game:getFlag("future_variable"))
		
		local fmarcy = cutscene:getCharacter("fmarcy")
		local fnoelle = cutscene:getCharacter("fnoelle")
		local fv = Mod:getVariableFuture(Game.party[3].id)
		local fvariant = cutscene:getCharacter(fv)
		
		Game:setFlag("third_party_member_future", Game.party[3].id)
		
		cutscene:look(susie, "up")
		
		cutscene:showNametag("Susie")
		cutscene:text("* There they are...", "neutral", "susie")
		cutscene:hideNametag()
			
		cutscene:wait(cutscene:panTo("camto", 1))
		
		cutscene:detachFollowers()
		
		jamm.x = fmarcy.x
		jamm.y = 920
		susie.x = fnoelle.x
		susie.y = 920
		variant.x = fvariant.x
		variant.y = 920
		
		cutscene:look(fmarcy, "down")
		cutscene:look(fnoelle, "down")
		cutscene:look(fvariant, "down")
		
		cutscene:walkToSpeed(jamm, jamm.x, jamm.y - 200, 6)
		cutscene:walkToSpeed(susie, susie.x, susie.y - 200, 6)
		cutscene:wait(cutscene:walkToSpeed(variant, variant.x, variant.y - 200, 6))
		
		cutscene:showNametag("Susie")
		cutscene:text("* Arright,[wait:5] so what did you guys want to talk about?", "neutral", "susie")
        cutscene:showNametag("Noelle")
		cutscene:text("* Well...", "normal/awkward_talk", "fnoelle")
		cutscene:hideNametag()
		cutscene:wait(cutscene:walkToSpeed(fnoelle, fnoelle.x - 60, fnoelle.y, 2, "down"))
        cutscene:showNametag("Noelle")
		cutscene:text("* We needed you to be aware of this.", "tense/guilty_2", "fnoelle")
		cutscene:walkToSpeed(jamm, jamm.x, fmarcy.y + 60, 4)
		cutscene:showNametag("Susie")
		cutscene:text("* ...A gravestone?", "neutral", "susie")
		susie:setAnimation("away_scratch")
		cutscene:text("* Why would we care about somethin' like that?", "neutral", "susie")
		cutscene:hideNametag()
		cutscene:wait(function() return jamm.y == fmarcy.y + 60 end)
		cutscene:walkToSpeed(jamm, jamm.x, fmarcy.y, 4)
		cutscene:walkToSpeed(fmarcy, fmarcy.x - 60, fmarcy.y, 4, "right")
        cutscene:showNametag("Noelle")
		cutscene:text("* You see...", "tense/guilty_1", "fnoelle")
		cutscene:hideNametag()
		cutscene:wait(function() return jamm.y == fmarcy.y end)
		cutscene:resetSprite(susie)
		cutscene:showNametag("Jamm", {top = true})
		cutscene:text("* Guys...?", "speechless", "jamm", {top = true})
		cutscene:look(jamm, "right")
		cutscene:text("* You may want to take a look at the graves...", "speechless_smile", "jamm", {top = true})
		cutscene:look(jamm, "up")
		cutscene:hideNametag()
		cutscene:walkToSpeed(variant, variant.x, fvariant.y, 4)
		cutscene:walkToSpeed(fvariant, fvariant.x - 60, fvariant.y, 4, "right")
		cutscene:look(susie, "right")
		cutscene:wait(0.837)
		cutscene:wait(cutscene:walkToSpeed(susie, susie.x, fnoelle.y, 6))
		cutscene:look(fnoelle, "right")
		cutscene:showNametag("Susie", {top = true})
		cutscene:text("* ...Wait a minute...", "neutral_side", "susie", {top = true})
		cutscene:hideNametag()
		susie:setSprite("exasperated_left")
		susie:shake(3)
		Assets.playSound("whip_crack_only")
		cutscene:wait(0.4)
		cutscene:showNametag("Susie", {top = true})
		cutscene:text("* The hell!?[wait:10]\n* These are our names!", "teeth", "susie", {top = true})
		cutscene:look(susie, "left")
		cutscene:resetSprite(susie)
		cutscene:look(fvariant, "left")
		cutscene:look(fnoelle, "left")
		cutscene:look(variant, "left")
		cutscene:look(jamm, "left")
		cutscene:showNametag("Marcy", {top = true})
		cutscene:text("* We knew you three were strong,[wait:5] but...", "neutral", "fmarcy", {top = true})
		cutscene:text("* Thinking you'd win against those creatures was unrealistic.", "neutral", "fmarcy", {top = true})
		cutscene:text("* It was better to accept we'd never see you again.", "closed", "fmarcy", {top = true})
		cutscene:showNametag("Susie", {top = true})
		cutscene:look(susie, "down")
		cutscene:text("* ...", "annoyed_down", "susie", {top = true})
		cutscene:look(fnoelle, "right")
		cutscene:look(jamm, "right")
		cutscene:text("* How'd you do it?", "annoyed_down_smile", "susie", {top = true})
		cutscene:showNametag("Marcy", {top = true})
		cutscene:text("* Well...", "neutral", "fmarcy", {top = true})
		cutscene:hideNametag()
		Game.world.music:fade(0, 1)
		cutscene:wait(cutscene:fadeOut(1))
		Game.sepia_shader = Game.stage:addFX(ShaderFX("sepia", {intensity = 1}))
		Game:setFlag("tempflag", Game.inventory:save())
		Game.inventory:clear()
		cutscene:wait(1)
		cutscene:showNametag("Marcy")
		cutscene:text("* We're almost there!", "neutral", "fmarcy")
		Game:setPartyMembers("fmarcy", "fnoelle", fv)
		
		cutscene:loadMap("flashback/field_1", -40, 800)
		cutscene:wait(cutscene:fadeIn(0.75))
		cutscene:wait(cutscene:walkToSpeed(Game.world.player, 280, 800, 4))
		local fmarcy = cutscene:getCharacter("fmarcy")
		local fnoelle = cutscene:getCharacter("fnoelle")
		local fvariant = cutscene:getCharacter(fv)
		
		if Game:getFlag("future_variable") == "ceroba" then
			cutscene:showNametag("Kanako")
			cutscene:text("* I'm not liking how quiet it is...", "unimpressed", "fkanako")
		end
        cutscene:showNametag("Noelle")
		cutscene:text("* The place seems pretty untouched too...", "normal/oh", "fnoelle")
		cutscene:showNametag("Marcy")
		cutscene:text("* The reports show that the Knight keeps a clean footprint.", "neutral", "fmarcy")
		cutscene:text("* Keep your guards up,[wait:5] you two.", "neutral", "fmarcy")
		Game.party[1]:setArmor(1, "resistance_band")
		Game.party[2]:setArmor(1, "resistance_band")
		Game.party[2]:setArmor(2, "silver_watch")
		Game.party[3]:setArmor(1, "resistance_band")
    end,
	
	town_hall_chair = function(cutscene, event)
		cutscene:text("* (You could've sworn there was a chair here...)")
		if cutscene:getCharacter("susie") and cutscene:getCharacter("jamm") and not Game:getFlag("future_jamm_susie_bet") then
			cutscene:showNametag("Jamm")
			cutscene:text("* 50 D$ says it's being used to barricade that door over there.", "smirk", "jamm")
			cutscene:showNametag("Susie")
			cutscene:text("* You're on,[wait:5] Jamm.", "smile", "susie")
			cutscene:hideNametag()
			Game:setFlag("future_jamm_susie_bet", true)
		end
    end,
	
	town_hall_door = function(cutscene, event)
		cutscene:text("* It's a door to the rest of town hall.")
		if cutscene:getCharacter("susie") and cutscene:getCharacter("jamm") and Game:getFlag("future_jamm_susie_bet") and not Game:getFlag("future_jamm_susie_door") then
			cutscene:text("* You check to see how it's being blocked...")
			cutscene:text("* The door seems to be barricaded using a chair.[react:1][react:2]", nil, nil, {reactions={
				{"Pay up, Susie.", 160, 61, "smirk", "jamm"},
				{"DAMN IT!!", 352, 61, "teeth", "susie"},
			}})
			Game:setFlag("future_jamm_susie_door", true)
		end
    end,

    hospitalroom2bed = function(cutscene, event)
        if Game:getFlag("POST_SNOWGRAVE") then
            cutscene:text("* (He's no longer breathing...)")
        else
            cutscene:text("* (It's an empty bed.)")
        end
    end,
	
	end_flashback = function(cutscene, event)
		Game.world.music:fade(0, 1)
		cutscene:wait(cutscene:fadeOut(1))
		Game.stage:removeFX(Game.sepia_shader)
		Game.inventory:load(Game:getFlag("tempflag"))
		cutscene:wait(1)
		cutscene:showNametag("Marcy")
		cutscene:text("* And that's...[wait:10] that's how it happened.", "closed", "fmarcy")
		cutscene:hideNametag()
		Game:setPartyMembers("susie", "jamm", Game:getFlag("third_party_member_future", "ceroba"))
		
		Game:setFlag("future_hometown_graveyard_cutscene", true)
		Game:setFlag("future_graveyard_convo", true)
		
		cutscene:loadMap("hometown/deep_graveyard", 98, 1840)
		Game.world.player:setSprite("bangs_wall_right")
		
		cutscene:detachFollowers()
		cutscene:detachCamera()
		
		local jamm = cutscene:getCharacter("jamm")
		local susie = cutscene:getCharacter("susie")
		local variant = cutscene:getCharacter(Game:getFlag("future_variable"))
		
		local fmarcy = cutscene:spawnNPC("fmarcy", 320, 1840, {facing = "up"})
		local fnoelle = cutscene:spawnNPC("fnoelle", 480, 1880, {facing = "right"})
		local fvariant = cutscene:spawnNPC(Mod:getVariableFuture(Game.party[3].id), 480, 1960, {facing = "left"})
		
		susie.y = 1920
		
		jamm.x = 120
		jamm.y = 1820
		jamm:setAnimation("sit")
		
		variant.x = 320
		variant.y = 2000
		cutscene:look(variant, "up")
		-- y'all can set whatever x, y, and animation for your variants
		
		cutscene:wait(cutscene:fadeIn(0.75))
		
		cutscene:look(fmarcy, "left")
		
		cutscene:wait(1)
		
		cutscene:showNametag("Marcy")
		cutscene:text("* The Knight may be dead,[wait:5] but the war lives on.", "closed", "fmarcy")
		cutscene:text("* The growing darkness,[wait:5] the Collapse Creatures...", "closed", "fmarcy")
		cutscene:text("* That is what we stand against.", "neutral", "fmarcy")
		if Game:getFlag("future_variable") == "ceroba" then
			cutscene:showNametag("Ceroba")
			cutscene:text("* You three fight for a noble cause.", "neutral", "ceroba")
			cutscene:text("* Defending the world,[wait:5] even when it all feels bleak...", "dissapproving", "ceroba")
			cutscene:text("* It reminds me of...", "sorrowful", "ceroba")
			cutscene:look(variant, "right")
			cutscene:showNametag("Kanako")
			cutscene:text("* ...Clover?", "unimpressed", "fkanako")
			cutscene:showNametag("Ceroba")
			cutscene:text("* How did you...", "surprised", "ceroba")
			cutscene:showNametag("Kanako")
			cutscene:text("* Uncle Star told us all about what happened.", "neutral", "fkanako")
			cutscene:look(fmarcy, "down")
			cutscene:look(variant, "up")
			cutscene:showNametag("Marcy")
			cutscene:text("* Right,[wait:5] that...", "closed", "fmarcy")
			cutscene:text("* Selfish.[react:1]", "upset", "fmarcy", {reactions={
				{"Not really your place\nto chime in, Marcy...", 220, 61, "stern", "jamm"}
			}})
		end
		cutscene:look(fmarcy, "left")
		cutscene:showNametag("Susie")
		cutscene:text("* ...", "annoyed_down", "susie")
		cutscene:text("* I mean,[wait:5] it's great that the Knight was taken down,[wait:5] but...", "annoyed_down_alt", "susie")
		cutscene:text("* Somehow,[wait:5] I feel...[wait:10] awful.", "concerned", "susie")
		cutscene:showNametag("Jamm")
		cutscene:text("* Yeah...[wait:10] It's...", "nervous_left", "jamm")
		cutscene:text("* It's like something is...[wait:10] missing.", "nervous", "jamm")
		cutscene:text("* [speed:0.5]..........", "concentrate", "jamm")
		cutscene:text("* Wait,[wait:5] you said you dropped a pen in the rift.", "look_left", "jamm")
		cutscene:text("* Was it a red ballpoint pen?", "neutral", "jamm")
		cutscene:look(jamm, "right")
		jamm:resetSprite()
		cutscene:text("* Chewed slightly?[wait:10] Broken button?[wait:10] Missing the spring?", "neutral", "jamm")
		cutscene:showNametag("Marcy")
		cutscene:text("* How did you...", "lookright", "fmarcy")
		cutscene:hideNametag()
		
		cutscene:wait(cutscene:walkToSpeed(jamm, fmarcy.x - 60, fmarcy.y, 4))
		
		cutscene:showNametag("Jamm")
		cutscene:text("* I...[wait:10] found that pen.", "relief", "jamm")
		cutscene:showNametag("Marcy")
		cutscene:text("* ...", "closed", "fmarcy")
		cutscene:look(fmarcy, "right")
		cutscene:text("* So that means the Great Tear is...", "closed", "fmarcy")
		cutscene:look(susie, "right")
		susie:resetSprite()
		cutscene:showNametag("Susie")
		cutscene:text("* ...Our ticket to getting back to our time.", "closed_grin", "susie")
		if Game:getFlag("future_variable") == "ceroba" then
			cutscene:showNametag("Kanako")
			cutscene:text("* We know where it is.", "unimpressed", "fkanako")
			cutscene:text("* However,[wait:5] think you could help out around Hometown first?", "unimpressed", "fkanako")
			cutscene:text("* It's your call,[wait:5] but I think it'll help you too.", "unimpressed", "fkanako")
		end
		cutscene:showNametag("Susie")
		cutscene:text("* ...Okay.", "nervous", "susie")
		cutscene:hideNametag()
		cutscene:walkTo(susie, susie.x + 640, susie.y, 4)
		cutscene:walkTo(variant, variant.x + 640, variant.y, 4)
		cutscene:walkTo(fnoelle, fnoelle.x + 640, fnoelle.y, 4)
		cutscene:walkTo(fvariant, fvariant.x + 640, fvariant.y, 4)
		cutscene:wait(cutscene:walkTo(fmarcy, fmarcy.x + 120, fmarcy.y, 4))
		cutscene:showNametag("Jamm")
		cutscene:text("* Marcy,[wait:5] wait.", "worried", "jamm")
		cutscene:look(fmarcy, "left")
		cutscene:text("* I can tell that something's on your mind.", "worried", "jamm")
		cutscene:showNametag("Marcy")
		cutscene:text("* ...", "closed", "fmarcy")
		cutscene:text("* Do you...[wait:10] have to go back,[wait:5] dad...?", "neutral", "fmarcy")
		cutscene:showNametag("Jamm")
		cutscene:text("* What choice do I have?", "worried", "jamm")
		cutscene:text("* I have a little girl waiting for me in my own time.", "worried_down", "jamm")
		cutscene:showNametag("Marcy")
		cutscene:text("* So then...[wait:10] what about us?", "neutral", "fmarcy")
		cutscene:showNametag("Jamm")
		cutscene:text("* ...", "worried_down", "jamm")
		cutscene:text("* I'm sorry,[wait:5] Marcy...", "worried_down", "jamm")
		cutscene:text("* As much as I'd love to get to know you,[wait:5] I have responsibilities.", "worried", "jamm")
		cutscene:showNametag("Marcy")
		cutscene:text("* Okay...[wait:10] I see...", "closed", "fmarcy")
		cutscene:look(fmarcy, "right")
		cutscene:text("* Very well then.", "tears_closed", "fmarcy")
		cutscene:hideNametag()
		cutscene:walkTo(jamm, jamm.x + 400, jamm.y, 3)
		cutscene:walkTo(fmarcy, fmarcy.x + 400, fmarcy.y, 3)
		
		cutscene:wait(cutscene:fadeOut(2))
		
		cutscene:loadMap("hometown/town_graveyard", "deep", "down")
		
		Game:addFollower("fmarcy")
		Game:addFollower("fnoelle")
		Game:addFollower(Mod:getVariableFuture(Game.party[3].id))
		
		cutscene:wait(cutscene:fadeIn(0.75))
    end,
	
	no_enter_tent = function(cutscene, event)
		cutscene:text("* You get the feeling you shouldn't enter this tent.")
		cutscene:wait(cutscene:walkToSpeed(Game.world.player, Game.world.player.x, Game.world.player.y + 40, 4))
	end,
	
	tori_house = function(cutscene, event)
		cutscene:text("* You don't think it's a good idea to talk to her.")
	end,
	
	fmarcy_training = function(cutscene, event)
		local fmarcy = cutscene:getCharacter("fmarcy")
		
		local jamm = cutscene:getCharacter("jamm")
		local susie = cutscene:getCharacter("susie")
		local variant = cutscene:getCharacter(Game:getFlag("future_variable"))
		
		local choice = 1
		
		if not Game:getFlag("fmarcy_do_rematch") then
			Game:setFlag("fmarcy_do_rematch", true)
			cutscene:detachFollowers()
			cutscene:detachCamera()
			
			cutscene:wait(cutscene:panTo("camto", 2))
			
			jamm.x = fmarcy.x
			susie.x = jamm.x - 80
			variant.x = jamm.x + 80
			jamm.y = susie.y
			variant.y = susie.y
			
			cutscene:walkToSpeed(jamm, jamm.x, 360, 4)
			cutscene:walkToSpeed(susie, susie.x, 360, 4)
			cutscene:wait(cutscene:walkToSpeed(variant, variant.x, 360, 4))
			
			cutscene:showNametag("Marcy")
			cutscene:text("* ...I'm almost glad you actually came here.", "closed", "fmarcy")
			cutscene:showNametag("Susie")
			cutscene:text("* Where even is this place?", "nervous_side", "susie")
			cutscene:text("* I mean,[wait:5] when we come from,[wait:5] this path didn't even exist...", "nervous", "susie")
			cutscene:showNametag("Marcy")
			cutscene:text("* This...[wait:10] is where I've set up camp.", "neutral", "fmarcy")
			cutscene:text("* " .. Game:getPartyMember(Mod:getVariableFuture(Game.party[3].id)):getName() .. " and I sleep in those tents over there.", "neutral", "fmarcy")
			cutscene:text("* As for Noelle,[wait:5] she sleeps in what remains of her family's home...", "closed", "fmarcy")
			cutscene:text("* Trust me,[wait:5] she insisted.", "neutral", "fmarcy")
			if Game:getFlag("future_variable") == "ceroba" then
				cutscene:showNametag("Ceroba")
				cutscene:text("* Did you need anything from us?", "neutral", "ceroba")
			end
			cutscene:showNametag("Marcy")
			cutscene:text("* ...There is one thing.", "closed", "fmarcy")
			cutscene:text("* Dad,[wait:5] I need you to duel me.", "upset", "fmarcy")
			cutscene:showNametag("Jamm")
			cutscene:text("* ...You said what now?", "speechless", "jamm")
			cutscene:showNametag("Marcy")
			cutscene:text("* There was this one curiosity I've always had about you.", "closed", "fmarcy")
			cutscene:text("* One thing I remember is that you were always persistent...", "closed", "fmarcy")
			cutscene:text("* I need to see if that will work for you now.", "neutral", "fmarcy")
			cutscene:showNametag("Jamm")
			cutscene:text("* I mean,[wait:5] okay,[wait:5] I guess I can do that...", "nervous", "jamm")
			cutscene:hideNametag()
			
			cutscene:walkToSpeed(jamm, 320, 300, 4, "right")
			cutscene:walkToSpeed(susie, 420, 380, 4, "up")
			cutscene:walkToSpeed(variant, 660, 380, 4, "up")
			cutscene:wait(cutscene:walkToSpeed(fmarcy, 760, 300, 4, "left"))
			
			Game:setPartyMembers("jamm")
			susie = susie:convertToCharacter()
			jamm = jamm:convertToPlayer()
			
			cutscene:showNametag("Susie")
			cutscene:text("* Kick her ass,[wait:5] Jamm!", "teeth_smile", "susie")
			cutscene:showNametag("Marcy")
			cutscene:text("* Ready,[wait:5] dad?", "neutral", "fmarcy")
			cutscene:showNametag("Jamm")
			cutscene:text("* Let's do this,[wait:5] Marcy.", "sling_ready", "jamm")
			cutscene:hideNametag()
		else
			cutscene:showNametag("Marcy")
			cutscene:text("* As many times as you need,[wait:5] dad...", "closed", "fmarcy")
			cutscene:text("* You ready?", "upset", "fmarcy")
			cutscene:showNametag("Jamm")
			cutscene:text("* Think I can do this,[wait:5] Susie?", "sling_ready", "jamm")
			cutscene:hideNametag()
			
			choice = cutscene:choicer({"Kick her\nass, Jamm!", "Not yet."})
			
			if choice == 1 then
				cutscene:detachFollowers()
				cutscene:detachCamera()
				
				cutscene:panTo("camto", 1)
				
				cutscene:walkToSpeed(jamm, 320, 300, 4, "right")
				cutscene:walkToSpeed(susie, 420, 380, 6, "up")
				cutscene:walkToSpeed(variant, 660, 380, 6, "up")
				cutscene:wait(cutscene:walkToSpeed(fmarcy, 760, 300, 4, "left"))
				
				Game:setPartyMembers("jamm")
				susie = susie:convertToCharacter()
				jamm = jamm:convertToPlayer()
				
				cutscene:showNametag("Marcy")
				cutscene:text("* Then let us begin.", "upset", "fmarcy")
				cutscene:hideNametag()
			else
				cutscene:showNametag("Marcy")
				cutscene:text("* Then make all the preparations you need.", "closed", "fmarcy")
			end
		end
		
		if choice == 1 then
			cutscene:startEncounter("fmarcy_training", false, {fmarcy})
				
			Game:setPartyMembers("susie", "jamm", Game:getFlag("third_party_member_future", "ceroba"))
			jamm = jamm:convertToFollower(1)
			susie = susie:convertToPlayer()
			Game.party[2].health = Game.party[2]:getStat("health")
			
			if not Game:getFlag("fmarcy_spar_complete") then
				jamm:setSprite("landed_1")
				cutscene:wait(1)
				cutscene:fadeIn(2, {global = true})
				cutscene:wait(3)
				if not Game:getFlag("fmarcy_first_loss") then
					cutscene:showNametag("Jamm")
					cutscene:text("* J-jeez,[wait:5] Marcy...", "ouch", "jamm")
					cutscene:showNametag("Marcy")
					cutscene:text("* Of course you wouldn't win the first time...", "closed", "fmarcy")
				end
				cutscene:showNametag("Marcy")
				cutscene:text("* Well,[wait:5] dust yourself off and try again.", "neutral", "fmarcy")
				if not Game:getFlag("fmarcy_first_loss") then
					Game:setFlag("fmarcy_first_loss", true)
					cutscene:showNametag("Jamm")
					cutscene:text("* You're giving me another try?", "nervous_left", "jamm")
					cutscene:showNametag("Marcy")
					cutscene:text("* Like I said,[wait:5] I want to see how far that persistence can go.", "neutral", "fmarcy")
					cutscene:text("* Give it another shot when you're ready.", "neutral", "fmarcy")
				end
				cutscene:hideNametag()
				jamm:shake(2)
				jamm:resetSprite()
				cutscene:wait(0.5)
				
				cutscene:walkTo(fmarcy, 540, 240, 1, "down")
				
				cutscene:attachCamera(1)
				cutscene:interpolateFollowers()
				cutscene:attachFollowers(8)
				cutscene:wait(1)
			else
				cutscene:detachFollowers()
				fmarcy:setSprite("defeat")
				fmarcy.flip_x = true
				jamm:setAnimation("battle/idle")
				cutscene:wait(1)
				cutscene:fadeIn(2, {global = true})
				cutscene:wait(3)
				cutscene:showNametag("Jamm")
				cutscene:text("* H-hah...", "shaded_pissed", "jamm")
				jamm:resetSprite()
				cutscene:text("* I...[wait:10] won...?", "nervous_left", "jamm")
				cutscene:showNametag("Susie")
				cutscene:text("* Hell yeah you did!", "smile", "susie")
				cutscene:hideNametag()
				cutscene:walkToSpeed(variant, 320, 360, 8, "up")
				cutscene:wait(cutscene:walkToSpeed(susie, 376, 300, 8, "up"))
				cutscene:look(jamm, "down")
				susie:setSprite("playful_punch_1")
				cutscene:wait(0.3)
				susie:setSprite("playful_punch_2")
				jamm:shake(2)
				Assets.playSound("impact")
				cutscene:wait(0.6)
				cutscene:showNametag("Susie")
				cutscene:text("* You were freaking awesome out there!", "sincere_smile", "susie")
				cutscene:showNametag("Jamm")
				cutscene:text("* I was,[wait:5] wasn't I?", "smirk", "jamm")
				cutscene:text("* But what about...", "nervous", "jamm")
				cutscene:hideNametag()
				
				cutscene:look(jamm, "right")
				cutscene:look(susie, "right")
				susie:resetSprite()
				cutscene:look(variant, "right")
				cutscene:wait(1)
				
				if Game:getFlag("future_variable") == "ceroba" then
					cutscene:showNametag("Ceroba")
					cutscene:text("* Do you think she's okay?", "nervous", "ceroba")
				end
				cutscene:showNametag("Jamm")
				cutscene:text("* Well,[wait:5] why wouldn't she be?", "nervous", "jamm")
				cutscene:hideNametag()
				cutscene:walkToSpeed(susie, 380, 260, 4, "down", true)
				cutscene:wait(cutscene:walkToSpeed(jamm, 760, 320, 4, "up"))
				cutscene:look(susie, "right")
				cutscene:showNametag("Jamm")
				cutscene:text("* I'm sure all she needs is a little rest.", "nostalgia", "jamm")
				cutscene:hideNametag()
				
				Game:setFlag("future_carrying_marcy", true)
				jamm:resetSprite()
				jamm:shake(2)
				fmarcy:remove()
				Assets.playSound("noise")
				
				cutscene:wait(1)
				cutscene:look(jamm, "left")
				cutscene:wait(1)
				
				cutscene:showNametag("Jamm")
				cutscene:text("* I'm going to bring her to her tent.", "neutral", "jamm")
				cutscene:text("* Stay safe,[wait:5] you two.", "worried", "jamm")
				cutscene:hideNametag()
				
				cutscene:walkToSpeed(jamm, jamm.x, jamm.y + 200, 4)
				
				cutscene:wait(cutscene:fadeOut(1))
				
				Game:setFlag("future_carrying_marcy", false)
				
				cutscene:loadMap("hometown/fmarcy_tent", 98, 1840)
				
				jamm = Game.world:getEvent(3)
				fmarcy = Game.world:getEvent(2)
				
				fmarcy.actor.default = "walk_noarmor"
				fmarcy:resetSprite()
				
				cutscene:wait(cutscene:fadeIn(2))
				
				cutscene:showNametag("Marcy", {top = false})
				cutscene:text("* Ugh...", "closed", "fmarcy", {top = false})
				cutscene:hideNametag()
				
				cutscene:wait(cutscene:walkToSpeed(fmarcy, fmarcy.x - 80, fmarcy.y, 4, "up"))
				
				Game.world:getEvent(1).sprite:setFrame(2)
				Assets.playSound("locker")
				cutscene:wait(0.5)
				Assets.playSound("noise")
				fmarcy.actor.default = "walk"
				fmarcy:resetSprite()
				cutscene:wait(1)
				cutscene:look(fmarcy, "left")
				cutscene:wait(0.5)
				cutscene:showNametag("Marcy", {top = false})
				cutscene:text("* ...Dad...?", "neutral", "fmarcy", {top = false})
				Game:setFlag("jamm_has_glasses", true)
				jamm:setSprite("read_notice")
				cutscene:showNametag("Jamm", {top = false})
				cutscene:text("* Oh, you're awake!", "look_left", "jamm", {top = false})
				cutscene:hideNametag()
				Game:setFlag("jamm_has_glasses", false)
				
				cutscene:look(jamm, "right")
				jamm:resetSprite()
				
				cutscene:wait(cutscene:walkToSpeed(jamm, fmarcy.x - 80, fmarcy.y, 4))
				cutscene:showNametag("Jamm", {top = false})
				cutscene:text("* How are you feeling?", "relief", "jamm", {top = false})
				cutscene:showNametag("Marcy", {top = false})
				cutscene:text("* I...[wait:5] My head's kinda hurting...", "neutral", "fmarcy", {top = false})
				cutscene:text("* What happened?[wait:10]\n* Last I remember,[wait:5] we were sparring...", "closed", "fmarcy", {top = false})
				cutscene:showNametag("Jamm", {top = false})
				cutscene:text("* And I hit you with my Numbshot spell.", "neutral", "jamm", {top = false})
				cutscene:hideNametag()
				
				cutscene:wait(cutscene:walkToSpeed(fmarcy, fmarcy.x, fmarcy.y + 40, 2))
				
				cutscene:showNametag("Marcy", {top = false})
				cutscene:text("* That's...[wait:10] that's right...", "neutral", "fmarcy", {top = false})
				cutscene:showNametag("Jamm", {top = false})
				cutscene:text("* ...", "nervous", "jamm", {top = false})
				Game.world.music:play("noelle_normal")
				cutscene:text("* So...[wait:10] you live like this,[wait:5] Marcy?", "nervous_left", "jamm", {top = false})
				cutscene:showNametag("Marcy", {top = false})
				cutscene:text("* I know.[wait:10]\n* It's not much,[wait:5] is it?", "neutral", "fmarcy", {top = false})
				cutscene:text("* I built a bed of straw and a chair from some sticks...", "neutral", "fmarcy", {top = false})
				cutscene:look(fmarcy, "left")
				cutscene:text("* ...And the rest came from Noelle.", "closed", "fmarcy", {top = false})
				cutscene:text("* When her family disappeared,[wait:5] she started treating us like family.", "closed", "fmarcy", {top = false})
				cutscene:text("* She insisted on giving me some of her parents' stuff...", "closed", "fmarcy", {top = false})
				cutscene:look(fmarcy, "up")
				cutscene:text("* It makes this place feel a little more alive,[wait:5] actually.", "neutral", "fmarcy", {top = false})
				cutscene:showNametag("Jamm", {top = false})
				cutscene:text("* ...That's...[wait:10] really cute,[wait:5] actually.", "relief", "jamm", {top = false})
				cutscene:look(fmarcy, "left")
				cutscene:showNametag("Marcy", {top = false})
				cutscene:text("* If you think so...", "neutral", "fmarcy", {top = false})
				cutscene:text("* You should get going.[wait:10]\n* I'm gonna need a minute.", "neutral", "fmarcy", {top = false})
				cutscene:hideNametag()
				Game.world.music:fade(0, 1)
				cutscene:wait(cutscene:walkToSpeed(jamm, jamm.x + 40, jamm.y + 160, 4))
				cutscene:wait(1)
				cutscene:look(fmarcy, "down")
				cutscene:look(jamm, "up")
				cutscene:showNametag("Jamm")
				cutscene:text("* Before that...[wait:10]\n* I have one more thing to ask.", "neutral", "jamm")
				cutscene:hideNametag()
				
				Game:getPartyMember("jamm"):addSpell("disarm")
				
				cutscene:wait(cutscene:fadeOut(1))
				
				cutscene:loadMap("hometown/fmarcy_camp", 98, 1840)
				
				cutscene:detachFollowers()
				cutscene:panTo("tentcam", 0)
				
				local jamm = cutscene:getCharacter("jamm")
				local susie = cutscene:getCharacter("susie")
				local variant = cutscene:getCharacter(Game:getFlag("future_variable"))
				
				susie.x = 660
				susie.y = 1090
				variant.x = 660
				variant.y = 1200
				jamm.x = 740
				jamm.y = 1080
				jamm.alpha = 0
				
				variant:setFacing("up")
				jamm:setFacing("down")
				
				susie:setSprite("chuckle_2")
				
				cutscene:wait(cutscene:fadeIn(2))
				
				if Game:getFlag("future_variable") == "ceroba" then
					cutscene:showNametag("Susie")
					cutscene:text("* Hey,[wait:5] all I'm saying is,[wait:5] we've got this in the bag.", "sincere_smile", "susie")
				end
				cutscene:hideNametag()
				
				Game.world.timer:tween(1, jamm, {alpha = 1})
				
				cutscene:wait(1)
				
				cutscene:wait(cutscene:walkToSpeed(jamm, jamm.x, jamm.y + 40, 4, "left"))
				
				cutscene:look(susie, "right")
				susie:resetSprite()
				cutscene:look(variant, "right")
				
				cutscene:showNametag("Jamm")
				cutscene:text("* Did I miss anything?", "side_smile", "jamm")
				cutscene:hideNametag()
				cutscene:wait(cutscene:walkToSpeed(susie, susie.x, susie.y + 40, 4, "right"))
				cutscene:showNametag("Susie")
				cutscene:text("* Nah,[wait:5] we were just talkin' about stuff.", "smile", "susie")
				
				if Game:getFlag("future_variable") == "ceroba" then
					cutscene:showNametag("Ceroba")
					cutscene:text("* Did you learn the ability?", "neutral", "ceroba")
				end
				cutscene:showNametag("Jamm")
				cutscene:text("* Yeah,[wait:5] I did!", "smirk", "jamm")
				cutscene:text("* I even made Marcy drop her weapon!", "sling_ready", "jamm")
				cutscene:showNametag("Susie")
				cutscene:text("* Dude,[wait:5] that's awesome!", "surprise", "susie")
				cutscene:hideNametag()
				cutscene:look(susie, "left")
				
				Game:addFlag("future_reputation", 5)
				
				cutscene:attachCamera(1)
				cutscene:alignFollowers("left")
				cutscene:attachFollowers(8)
				cutscene:wait(1)
			end
		end
	end,

	hospitalpiano = function(cutscene, event)
        cutscene:text("* (It's an obligatory hospital piano,[wait:5] shrunk to fit in the corner.)")
        cutscene:text("* (As a result,[wait:5] it's missing most of the good keys.)")
        cutscene:text("* (Play it?)")
        local opinion = cutscene:choicer({"Yes", "No"})
        if opinion == 1 then
            Assets.playSound("pianonoise")
            cutscene:text("* (Plink...)")
        else
            cutscene:text("* (Your hands linger over the keys doing nothing.)")
        end
    end,

	hospitaltoy = function(cutscene, event)
        cutscene:text("* (It's a toy with beads on a track.)")
        if Game:getFlag("POST_SNOWGRAVE") then
            cutscene:text("* (One of the beads seems to be completely missing,[wait:5] however.)")
        else
            cutscene:text("* (The beads of the toy march on.)")
        end
    end,

	asgorefridge = function(cutscene, event)
        cutscene:text("* (It's a rusty fridge with some photos on it.)")
        local opinion = cutscene:choicer({"Open\nFridge\n", "Don't", "See photos"})
        if opinion == 1 then
            cutscene:text("* (All that's inside is a jar with a single pickle in it...)")
        elseif opinion == 3 then
            cutscene:text("* (A photo of Toriel and Asgore on their wedding day.)")
            cutscene:text("* (She's holding a bouquet of seven flowers.)")
            cutscene:text("* (A reindeer-looking monster stands nearby in a tuxedo.)")
            cutscene:text("* (They all look happy.)")
        else
            cutscene:text("* (You decide not to look.)")
        end
    end,

    asgoretruck = function(cutscene, event)
        cutscene:text("* (It's a blue pickup truck.)")
        cutscene:text("* (The floor of the front seat is littered with old papers and country CDs...)")
    end,

	librarybook1 = function(cutscene, event)
      	cutscene:text("* How To Care For A Human")
      	cutscene:text("* (It's a book for monsters about how to care for humans.)")
      	local opinion = cutscene:choicer({"Look in\nthe back", "Look inside"})
        if opinion == 1 then
          	cutscene:text("* (According to the card in the back...)")
          	cutscene:text("* (... looks like your mother took it repeatedly many years ago.)")
        else
            cutscene:text("* (There are photos of unfamiliar humans inside.)")
        end
    end,

    librarybook2 = function(cutscene, event)
      	cutscene:text("* (It's BOOK 1 about SOULS. Read it?)")
      	local opinion = cutscene:choicer({"Read", "Don't"})
        if opinion == 1 then
          	cutscene:text("* The SOUL has been called many things.")
          	cutscene:text("* The font of our compassion. The source of our will.")
          	cutscene:text("* The container of our \"life force.\"")
          	cutscene:text("* But even now,[wait:5] the true function of it is unknown.")
        end
    end,

	librarybook3 = function(cutscene, event)
      	cutscene:text("* (It's a book about Monster Funerals. Read it?)")
      	local opinion = cutscene:choicer({"Read", "Do not"})
        if opinion == 1 then
          	cutscene:text("* ...[wait:5] When monsters die,[wait:5] their dust will be spread over what they loved.")
          	cutscene:text("* An object that symbolizes their existence. That object will be buried...")
          	cutscene:text("* And in such a way,[wait:5] their soul be able to rest,[wait:5] within that object,[wait:5] and the earth.")
          	cutscene:text("* Of course,[wait:5] everyone knows that. That's why this is the introduction...")
        end
    end,

	fberdly = function(cutscene, event)
		if Game:getFlag("POST_SNOWGRAVE") then
			cutscene:text("* (No librarian in sight.)")
			return
		end
		local fberdly = cutscene:getCharacter("fberdly")
		fberdly:facePlayer()
		cutscene:showNametag("Berdly")
        cutscene:text("* Placeholder", "glorious", "fberdly")
		cutscene:hideNametag()
		fberdly:setFacing("up")
    end,

	school_closet = function(cutscene, event)
		if not Game:getFlag("future_schoolcloset_dialogue") then
			cutscene:showNametag("Susie")
			cutscene:text("* Hey,[wait:5] uh,[wait:5] is the Castle Town still down there?[wait:5] Can we go in?", "nervous_side", "susie")
			cutscene:showNametag("Marcy")
			cutscene:text("* It is there,[wait:5] but be careful.", "closed", "fmarcy")
			cutscene:text("* There's a giant pit right behind the door.", "neutral", "fmarcy")
			cutscene:text("* As for going in,[wait:5] there's not much to look at there.", "lookright", "fmarcy")
			cutscene:text("* But,[wait:5] I suppose we can pay a quick visit there.", "closed", "fmarcy")
			cutscene:showNametag("Susie")
			cutscene:text("* ...[wait:5] alright.", "annoyed_down", "susie")
			cutscene:hideNametag()
			Game:setFlag("future_schoolcloset_dialogue", true)
		end
		local go_in = cutscene:textChoicer("* Go to Castle Town?", {"Yes", "No"})
		if go_in == 1 then
			Game.world.music:fade(0, 0.5)
			cutscene:wait(0.5)
			Assets.playSound("locker")
			Game.world:getEvent("darkdoor").sprite:setFrame(2)
			cutscene:wait(1)
			cutscene:wait(cutscene:fadeOut(0.75))
			cutscene:wait(0.5)
			Assets.playSound("wing")
            cutscene:wait(0.3)
            Assets.playSound("wing")
            cutscene:wait(0.3)
            Assets.playSound("wing")
            cutscene:wait(1)
            Assets.playSound("jump")
            cutscene:wait(0.75)
            Assets.playSound("noise")
            cutscene:wait(1.5)
			cutscene:loadMap("castletown/area_1", 320, 360)
			cutscene:wait(cutscene:fadeIn(0.75))
		end
    end,
}
