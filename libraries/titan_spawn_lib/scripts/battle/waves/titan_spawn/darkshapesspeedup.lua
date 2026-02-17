local DarkShapesSpeedUp, super = Class(Wave)

function DarkShapesSpeedUp:init()
    super.init(self)

    self.time = 360/30
end

function DarkShapesSpeedUp:onStart()
    Game.battle:swapSoul(FlashlightSoul())

    local darkshape_manager = self:spawnObject(DarkShapeManager())
    darkshape_manager:patternToUse("speedup")
	darkshape_manager.attacker_num = #self:getAttackers()
	
	if Game.battle.jamm_can_strike then
		self.timer:every(2, function()
			local cutAnim = Sprite("party/jamm/dark/special/shock")
			
			local blist = {}
			
			for k,v in ipairs(self.bullets) do
				if v:includes(DarkShapeBullet) and v.xscale == 1 then
					table.insert(blist, v)
				end
			end
			
			if #blist > 0 then
				local bullet = Utils.pick(blist)
				cutAnim:setOrigin(0.5, 1)
				cutAnim:setScale(1, 2)
				cutAnim:setPosition(bullet.x, bullet.y)
				cutAnim.layer = bullet.layer + 0.01
				Game.battle:addChild(cutAnim)
				Assets.playSound("shock", 0.3, 1)
				bullet.can_chase_heart = false
				self.timer:after(0.1, function()
					bullet:destroy()
				end)
				Game.stage.timer:tween(0.5, cutAnim, {alpha = 0}, "linear", function()
					cutAnim:remove()
				end)
			end
		end)
	end
end

function DarkShapesSpeedUp:onEnd()
    if Game.battle.soul.ominous_loop then
		Game.battle.soul.ominous_loop:stop()
	end
	Game.battle.jamm_can_strike = false
end

return DarkShapesSpeedUp