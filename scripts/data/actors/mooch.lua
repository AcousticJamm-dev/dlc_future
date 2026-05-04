local actor, super = Class(Actor, "mooch")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Mooch"

    -- Width and height for this actor, used to determine its center
    self.width = 29
    self.height = 44

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {5, 44, 14, 8}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {0, 1, 1}

    -- Path to this actor's sprites (defaults to "")
    self.path = "world/npcs/mooch"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "walk"

    -- Sound to play when this actor speaks (optional)
    self.voice = "mooch"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = "face/mooch"
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = {-20, -11}

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    self.talk_sprites = {
        ["talk/down"] = 1/6,
        ["talk/right"] = 1/6,
        ["talk/left"] = 1/6,
        ["talk/up"] = 1/6
    }

    -- Table of sprite animations
    self.animations = {}

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {}

    self.directional_talking = true
end

function actor:onTextSound()
    Assets.stopAndPlaySound("voice/mooch")
    return true
end

return actor