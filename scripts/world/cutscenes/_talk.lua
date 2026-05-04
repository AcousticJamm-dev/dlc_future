return {
    ---@param cutscene WorldCutscene
    main = function(cutscene, map, partyleader)
        if Game:isDessMode() or Game.world.player:getName() == "Dess" then
            cutscene:showNametag("Dess")
            if map == "cliffs_1" then
                cutscene:text("* ", "mspaint", "dess")  -- yeah erm placeholder
            elseif map == "cliffs_2" then
                cutscene:text("* ", "mspaint", "dess")  -- yeah erm placeholder
            elseif map == "cliffs_3" then
                cutscene:text("* ", "mspaint", "dess")  -- yeah erm placeholder
            elseif map == "cliffs_4" then
                cutscene:text("* ", "mspaint", "dess")  -- yeah erm placeholder
            elseif map == "cliffs_5" then
                cutscene:text("* ", "mspaint", "dess")  -- yeah erm placeholder
            elseif map == "cliffs_6" then
                cutscene:text("* ", "mspaint", "dess")  -- yeah erm placeholder
            elseif map == "cliffs_7" then
                cutscene:text("* ", "mspaint", "dess")  -- yeah erm placeholder
            elseif map == "cliffs_8" then
                cutscene:text("* ", "mspaint", "dess")  -- yeah erm placeholder
            elseif map == "cliffs_9" then
                cutscene:text("* ", "mspaint", "dess")  -- yeah erm placeholder
            elseif map == "chase_4" then
                cutscene:text("* ", "mspaint", "dess")  -- yeah erm placeholder
            elseif map == "cliffs_10" then
                cutscene:text("* ", "mspaint", "dess")  -- yeah erm placeholder
            elseif map == "main_hub" then
                cutscene:text("* ", "mspaint", "dess")  -- yeah erm placeholder
            elseif map == "hub_marketplace" then
                cutscene:text("* ", "mspaint", "dess")  -- yeah erm placeholder
            elseif map == "hub_prefountain" then
                cutscene:text("* ", "mspaint", "dess")  -- yeah erm placeholder
            elseif map == "hub_fountain" then
                cutscene:text("* ", "mspaint", "dess")  -- yeah erm placeholder
            else
                cutscene:text("* allan please add dialogue", "neutral", "dess")
            end
            cutscene:hideNametag()
        else
            if map == "cliffs_1" then
                cutscene:showNametag("Susie")
                cutscene:text("* This place reminds me of where I first met Lancer.", "nervous", "susie")
                cutscene:text("* He ambushed me and Kris there.", "smile", "susie")
                cutscene:text("* ...[wait:5] hopefully the same won't happen here.", "nervous_side", "susie")
                cutscene:hideNametag()
            elseif map == "cliffs_2" then
                cutscene:showNametag("Susie")
                cutscene:text("* Anyone's got a guess on what is this thing on the horizon?", "nervous", "susie")
                cutscene:showNametag("Jamm")
                cutscene:text("* Not a clue.", "look_left", "jamm")
                if Game:getFlag("future_variable") == "ceroba" then
                    cutscene:showNametag("Ceroba")
			        cutscene:text("* Sorry,[wait:5] I got nothing.", "dissapproving", "ceroba")
		        end
                cutscene:showNametag("Susie")
                cutscene:text("* ...[wait:5] yeah,[wait:5] same here.", "nervous_side", "susie")
                cutscene:hideNametag()
            elseif map == "cliffs_3" then
                cutscene:showNametag("Jamm")
                cutscene:text("* Is it a little hard to breathe for anyone else?", "look_left", "jamm")
                cutscene:text("* I mean,[wait:5] it's like there's not a lot of clean air...", "worried", "jamm")
                cutscene:showNametag("Susie")
                cutscene:text("* Or a lot of air,[wait:5] to begin with...", "neutral", "susie")
                cutscene:hideNametag()
            elseif map == "cliffs_4" then
                cutscene:showNametag("Susie")
                cutscene:text("* ...I can't be the only one who saw that.", "nervous_side", "susie")
                cutscene:showNametag("Jamm")
                cutscene:text("* Saw what,[wait:5] exactly?", "nervous", "jamm")
                cutscene:showNametag("Susie")
                cutscene:text("* ...Nevermind.", "nervous", "susie")
                cutscene:hideNametag()
            elseif map == "cliffs_5" and Game:getFlag("bg_convo") then
                cutscene:showNametag("Jamm")
                cutscene:text("* So should we ignore that conversation?", "nervous", "jamm")
                if Game:getFlag("future_variable") == "ceroba" then
                    cutscene:showNametag("Ceroba")
			        cutscene:text("* We don't want them to know we heard...", "neutral", "ceroba")
		        end
                cutscene:text("* Good point.", "look_left", "jamm")
                cutscene:hideNametag()
            elseif map == "cliffs_6" then
                cutscene:showNametag("Jamm")
                cutscene:text("* So is this that Cliffside you mentioned,[wait:5] Susie?", "look_left", "jamm")
                cutscene:showNametag("Susie")
                cutscene:text("* Can't be.[wait:10]\n* Something seems off here...", "annoyed", "susie")
                cutscene:showNametag("Jamm")
                cutscene:text("* I'll take your word for it then.", "nervous", "jamm")
                cutscene:hideNametag()
            elseif map == "cliffs_7" and Game:getFlag("first_collapse_creature") then
                cutscene:showNametag("Jamm")
                cutscene:text("* ...To be continued on that argument,[wait:5] Susie?", "smirk", "jamm")
                cutscene:showNametag("Susie")
                cutscene:text("* To be continued.", "smile", "susie")
                cutscene:showNametag("Jamm")
                cutscene:text("* Okay!", "smug", "jamm")
				cutscene:hideNametag()
            elseif map == "cliffs_8" then
                cutscene:showNametag("Susie")
                cutscene:text("* Tch,[wait:5] that creature...", "annoyed_down", "susie")
                cutscene:showNametag("Jamm")
                cutscene:text("* Right???[wait:10]\n* I didn't know it was boss fight time.", "nervous", "jamm")
                if Game:getFlag("future_variable") == "ceroba" then
                    cutscene:showNametag("Ceroba")
			        cutscene:text("* Didn't you say your DarkSling is effective against them?", "question", "ceroba")
		        end
                cutscene:showNametag("Jamm")
                cutscene:text("* Okay,[wait:5] but I meant boss strength.", "nervous_left", "jamm")
                cutscene:text("* If that's just the status quo around here,[wait:5] we're screwed...", "ouch", "jamm")
                cutscene:hideNametag()
            elseif map == "cliffs_9" and not Game.world.future_chase_started then
                cutscene:showNametag("Jamm")
                cutscene:text("* I have a bad feeling about what's coming up...", "nervous_left", "jamm")
                cutscene:hideNametag()
            elseif map == "chase_4" and Game.party[1]:hasSpell("rage") then
                cutscene:showNametag("Jamm")
                cutscene:text("* Did you...[wait:10]\n* Really mean all that?", "relief", "jamm")
                cutscene:showNametag("Susie")
                cutscene:text("* ...", "annoyed_down_alt", "susie")
                cutscene:text("* Yeah,[wait:5] but I dunno why I got so...", "annoyed_down_smile", "susie")
                cutscene:showNametag("Jamm")
                cutscene:text("* ...Enraged?", "nervous", "jamm")
                cutscene:showNametag("Susie")
                cutscene:text("* ...", "annoyed_down", "susie")
                if Game:getFlag("future_variable") == "ceroba" then
                    cutscene:showNametag("Ceroba")
			        cutscene:text("* This situation is really getting to us.", "muttering", "ceroba")
			        cutscene:text("* If we need to,[wait:5] we could take a break.", "unsure", "ceroba")
					cutscene:showNametag("Jamm")
					cutscene:text("* That might be for the best.", "worried", "jamm")
		        end
                cutscene:hideNametag()
            elseif map == "cliffs_10" then
				cutscene:showNametag("Jamm")
				cutscene:text("* ...", "worried_down", "jamm")
                cutscene:showNametag("Susie")
                cutscene:text("* You okay,[wait:5] dude?", "nervous", "susie")
				cutscene:showNametag("Jamm")
				cutscene:text("* H-huh?[wait:10] Oh,[wait:5] well...", "worried", "jamm")
				cutscene:text("* It just occured to me how powerful my daughter here is.", "worried_down", "jamm")
                cutscene:showNametag("Susie")
                cutscene:text("* Hell yeah![wait:10]\n* You have a badass daughter,[wait:5] dude!", "sincere_smile", "susie")
				cutscene:showNametag("Jamm")
				cutscene:text("* Well,[wait:5] okay,[wait:5] but...", "nervous", "jamm")
				cutscene:text("* It brought me back to that...[wait:10] THING,[wait:5] that we fought.", "nervous_left", "jamm")
				cutscene:text("* How strong it really was and all...", "nervous", "jamm")
				cutscene:text("* If Marcy is that powerful,[wait:5] then is that really the status quo?", "worried", "jamm")
                cutscene:showNametag("Susie")
                cutscene:text("*", "surprise", "susie")
                if Game:getFlag("future_variable") == "ceroba" then
                    cutscene:showNametag("Ceroba")
			        cutscene:text("* That is quite thought-provoking...", "pensive", "ceroba")
		        end
                cutscene:hideNametag()
            elseif map == "main_hub" or map == "hub_prefountain" or map == "hub_fountain" then
                cutscene:showNametag("Susie")
                cutscene:text("* ...", "nervous_side", "susie") -- yeah erm placeholder
                cutscene:hideNametag()
            elseif map == "hub_marketplace" then
                cutscene:showNametag("Susie")
                cutscene:text("* ...", "nervous_side", "susie") -- yeah erm placeholder
                cutscene:hideNametag()
            else
                cutscene:text("* (But your voice echoed aimlessly.)")
            end
        end
    end,
}