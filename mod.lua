function Mod:init()
    print("Loaded "..self.info.name.."!")

	-- iirc all Deltarune music is 0.7 volume
	TableUtils.merge(MUSIC_VOLUMES, {
		berdly_theme = 0.7,
        creepychase = 0.7,
		fanfare = 0.7,
		susie = 0.7,
		vs_susie = 0.7,
		wind = 0.7,
    })
	
	Game:registerEvent("rift_transition", function(data)
        return RiftTransition(data.x, data.y, data.properties)
    end)
end

function Mod:postInit(new_file)
    if new_file then
        Game:setFlag("library_love", 1)
        Game:setFlag("library_experience", 0)
        Game:setFlag("library_kills", 0)
    end
    if Game:getFlag("future_variable") == "ceroba_dw" then
        Game:setFlag("future_variable", "ceroba")
    end
    local fnoelle = Game:getPartyMember("fnoelle")
    -- if she doesn't have the first one, then probably the others too
    if not fnoelle:hasSpell("frostspite") then
        fnoelle:addSpell("frostspite")
        fnoelle:addSpell("coldsnap")
        fnoelle:addSpell("whiteout")
        fnoelle:addSpell("snow_veil")
        fnoelle:addSpell("frostcrypt")
    end
end

function Mod:getVariablePartyMember()	-- Assuming Jamm and Susie are the only other ones in the party
	for _, value in ipairs(Game.party) do
		if value.id ~= "jamm" and value.id ~= "susie" then
			return value:getActor().id
		end
	end
end

function Mod:getVariableFuture(chara)
	local list = {
		ceroba = "fkanako",
		brenda = "fcelestial",
		celestial = "fbrenda",
	}
	return list[chara]
end

function Mod:incoherent(cutscene)
	if not (
		Game:hasPartyMember("fmarcy")
		or Game:hasPartyMember("fnoelle")
		or Game:hasPartyMember("fkanako")
		or Game:hasPartyMember("fbrenda")
	) then	-- Add the other future characters when they get made
		cutscene:text("* (It's written in a language you don't understand.)")
		return true
	end
	return false
end