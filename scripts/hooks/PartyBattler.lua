local PartyBattler, super = Class(PartyBattler)

function PartyBattler:hurt(amount, exact, color, options)
	options = options or {}
	if self.chara.future and not options["future_proof"] then
		super.hurt(self, amount * MathUtils.random(7.2, 7.6), exact, color, options)
	else
		super.hurt(self, amount, exact, color, options)
	end
end

function PartyBattler:critical()
    self.chara:setHealth(-999)
    self:statusMessage("msg", "critical")
    self.criticond = true
	self.crititimer = 3
    self.is_down = true
    self.sleeping = false
    self.hurting = false
    self:toggleOverlay(true)
    self.overlay_sprite:setAnimation("battle/critical")
    if self.action then
        Game.battle:removeAction(Game.battle:getPartyIndex(self.chara.id), true)
    end
    Game.battle:checkGameOver()
end

function PartyBattler:criticalCure(playsound)
	if playsound == nil or playsound then
        Assets.stopAndPlaySound("power")
    end
	self:statusMessage("msg", "down", COLORS.red, nil, 1)
    self.chara:setHealth(MathUtils.round(((-self.chara:getStat("health")) / 2)))
    self.criticond = false
    self.overlay_sprite:setAnimation("battle/down")
    if self.action then
        Game.battle:removeAction(Game.battle:getPartyIndex(self.chara.id), true)
    end
    Game.battle:checkGameOver()
end

function PartyBattler:succumb()
	self.criticond = false
    super.succumb(self)
end

function PartyBattler:heal(amount, sparkle_color, show_up)
	if self.criticond then
		self:criticalCure(playsound)
		return
	end
    return super.heal(self, amount, sparkle_color, show_up)
end

function PartyBattler:fakeSwoon()
    self.is_down = true
    self.sleeping = false
    self.hurting = false
    self:toggleOverlay(true)
    self.overlay_sprite:setAnimation("battle/swooned")
    if self.action then
        Game.battle:removeAction(Game.battle:getPartyIndex(self.chara.id), true)
    end
	self.chara.health = -999
	self:statusMessage("msg", "swoon", COLORS.red, true)
	Game.battle:shakeCamera(8)
end

return PartyBattler