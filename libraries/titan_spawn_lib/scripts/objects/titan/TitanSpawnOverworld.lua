---@class TitanSpawnOverworld : Sprite
---@overload fun(...) : TitanSpawnOverworld
local TitanSpawnOverworld, super = Class(Sprite)

function TitanSpawnOverworld:init(x, y, layer, flip)
    super.init(self, "battle/bullets/titan/default/shrink", x, y)

	self:setScale(2)
	self:setOrigin(0.5)
	self:setFrame(6)
	self:setLayer(layer or WORLD_LAYERS["below_ui"])
	
	if flip ~= nil then
		self.flip_x = flip
	end

	self.fakeframe = 6
	self.alpha = 0
	self.siner_active = true
	self.siner = 0

	self.speed_modifier = 3

	self.sprite_switched = false

	-- we don have ripples
	--var finddepth = 8000
	--scr_fancy_ripple(x, y, 255, 60, 120, 1, 12, finddepth)
	--scr_fancy_ripple(x, y, 255, 80, 200, 1, 12, finddepth)

	Assets.stopAndPlaySound("tspawn", 1, MathUtils.random(0.7, 0.9))

	--Game.world.timer:lerpVar(self, "alpha", 1, 0, 30, 2, "out") -- used or not???
	Game.world.timer:lerpVar(self, "alpha", 0, 1, (4 * self.speed_modifier))
	Game.world.timer:lerpVar(self, "fakeframe", 6, 1, (6 * self.speed_modifier))
end

function TitanSpawnOverworld:update()

	if self.siner_active then
		self.siner = self.siner + (0.1 * DTMULT)
		self.y = self.y + (math.sin(self.siner) * 0.6)
	end

	if not self.sprite_switched then
		self:setFrame(math.floor(self.fakeframe))
		if self.fakeframe == 1 then
			self:setSprite("battle/bullets/titan/default/idle")
			self:setFrame(1)
			self:play((1/30)/0.2)
			self.sprite_switched = true
		end
	end

    super.update(self)
end

return TitanSpawnOverworld