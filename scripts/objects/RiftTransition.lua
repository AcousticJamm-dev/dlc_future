local RiftTransition, super = Class(Event)

function RiftTransition:init(x, y, properties)
    super.init(self, x, y)
	
	self.properties = properties or {}
	
	self.rift = Sprite("world/events/rift/unopened_1")
	self.rift:setOrigin(0.5, 1)
	self.rift:setScale(2)
	
	self:addChild(self.rift)
	
	self:setHitbox(-12, -8, 24, 16)
	
	self.solid = true
	
	local rift_fx = ShaderFX("unstable", {
		strength = function() return 2 + math.sin(os.time() * 15) * 2 end,
		time = function() return os.time() end
	})
	
	self.rift:addFX(rift_fx)
	
	self.target = {
        map = properties.map,
        marker = properties.marker or "spawn",
        facing = properties.facing or "down"
    }
end

function RiftTransition:getDebugInfo()
    local info = super.getDebugInfo(self)
    if self.target.map then table.insert(info, "Map: " .. self.target.map) end
    if self.target.marker then table.insert(info, "Marker: " .. self.target.marker) end
    if self.target.facing then table.insert(info, "Facing: " .. self.target.facing) end
    return info
end

function RiftTransition:onInteract()
    Game.world:startCutscene(function(cutscene)
		local waver = ShaderFX("wave_quad", {
			["wave_sine"] = function () return (Kristal.getTime()) * 100 end,
            ["wave_mag"] = 0,
            ["wave_height"] = 1,
			["texsize"] = {Game.world.player.width, Game.world.player.height}
		})
		Game.world.player:addFX(waver)
		Game.world.timer:tween(1, waver.vars, {wave_mag = 0.25})
		
		cutscene:wait(1)
		
		cutscene:fadeOut(0.4, {color = {1, 1, 1}})
		cutscene:wait(0.4)
		cutscene:loadMap(self.target.map, self.target.marker, self.target.facing)
		cutscene:fadeIn(0.4, {color = {1, 1, 1}})
		cutscene:wait(0.4)
    end)
end

return RiftTransition
