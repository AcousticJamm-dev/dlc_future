return function(cutscene)
    cutscene:text("* The warp bin is so damaged, it doesn't even seem to open anymore.")
	
	if not Game:getFlag("future_bin_checked") then
		Game:setFlag("future_bin_checked", true)
		if Game:getFlag("future_variable") == "ceroba" then
			cutscene:showNametag("Ceroba")
			cutscene:text("* This thing is really dented...", "dissapproving", "ceroba")
			cutscene:text("* I can only imagine something heavy did this.", "alt", "ceroba")
			cutscene:showNametag("Kanako")
			cutscene:text("* Either that,[wait:5] or something really strong...", "eyes_left", "fkanako")
			cutscene:text("* Those Collapse Creatures are tough to take down sometimes...", "unimpressed", "fkanako")
		end
		
		if not Game:getFlag("future_elevator_checked") then
			cutscene:showNametag("Jamm")
			cutscene:text("* Hey,[wait:5] chin up![wait:10]\n* We still gotta check the elevator!", "side_smile", "jamm")
			if not Game:getFlag("future_fountain_checked") then
				cutscene:showNametag("Susie")
				cutscene:text("* And we haven't checked the Great Door either...", "nervous", "susie")
			end
		elseif not Game:getFlag("future_fountain_checked") then
			cutscene:showNametag("Susie")
			cutscene:text("* I'm sure we can leave using the Great Door,[wait:5] right?", "sincere_smile", "susie")
		else
			Game:setFlag("future_exhausted_all_options", true)
			cutscene:showNametag("Jamm")
			cutscene:text("* So the Warp Bin,[wait:5] elevator,[wait:5] and Great Door are all not working...", "neutral", "jamm")
			cutscene:text("* Well,[wait:5] I'm all out of ideas.", "nervous_left", "jamm")
			cutscene:showNametag("Susie")
			cutscene:text("* ...You know,[wait:5] there is always that one wall...", "neutral", "susie")
			cutscene:showNametag("Jamm")
			cutscene:text("* You sure?[wait:10]\n* You couldn't do it before...", "nervous", "jamm")
			cutscene:showNametag("Susie")
			cutscene:text("* I have a feeling about this time.", "smile", "susie")
		end
		cutscene:hideNametag()
	end
end