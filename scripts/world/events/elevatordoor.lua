local ElevatorDoor, super = Class(Event)

function ElevatorDoor:init(data)
    super.init(self, data.x, data.y, {data.width, data.height})

    self.solid = true

    local properties = data.properties or {}
    self.sprite_frame      = Sprite("world/events/busted_elevator_floorone")
    self:addChild(self.sprite_frame)
    self.sprite_frame:setScale(2)

    self.sprite_frame.x = 15
    self.sprite_frame.y = -65
end

function ElevatorDoor:onInteract()
	Game.world:startCutscene(function(cutscene)
		cutscene:text("* The elevator seems out of order.")
		if not Game:getFlag("future_elevator_checked") then
			Game:setFlag("future_elevator_checked", true)
			cutscene:showNametag("Jamm")
			cutscene:text("* Well,[wait:5] that's my idea shot.", "neutral", "jamm")
			cutscene:text("* Damn...[wait:10]\n* Kinda wanted to see my place.", "nervous_left", "jamm")
			cutscene:showNametag("Marcy")
			cutscene:text("* It's empty.[wait:10]\n* Some looters took everything.", "neutral", "fmarcy")
			cutscene:showNametag("Jamm")
			cutscene:text("*", "speechless", "jamm")
			
			if not Game:getFlag("future_fountain_checked") then
				cutscene:showNametag("Susie")
				cutscene:text("* Well,[wait:5] maybe the Great Door will give us better luck?", "nervous", "susie")
				if not Game:getFlag("future_bin_checked") then
					if Game:getFlag("future_variable") == "ceroba" then
						cutscene:showNametag("Ceroba")
						cutscene:text("* And we still haven't checked the bin,[wait:5] either...", "closed_eyes", "ceroba")
					end
				end
			elseif not Game:getFlag("future_bin_checked") then
				if Game:getFlag("future_variable") == "ceroba" then
					cutscene:showNametag("Ceroba")
					cutscene:text("* The only thing left to check is the bin.", "neutral", "ceroba")
				end
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
		end
		cutscene:hideNametag()
	end)
end

return ElevatorDoor