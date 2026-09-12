local MagicButton, super = HookSystem.hookScript(MagicButton)

function MagicButton:hasSpecial()
	if self.battler == nil then
        return
    end

    if self.battler.chara.id == "susie" and Game.battle:getEnemyBattler("titan_spawn") then
		if not Game:getFlag("susie_got_soul_xacts") then
			return true
		elseif Game:getFlag("susie_got_soul_xacts") and Game.tension >= 64 then
			return true
		end

		return super.hasSpecial(self)
	end

	return super.hasSpecial(self)
end

return MagicButton