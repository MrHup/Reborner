shadow = Core.class(Sprite)
MX = application:getContentWidth()
MY = application:getContentHeight()

function Sprite:setSize(newWidth, newHeight)
  self:setScale(1, 1)
  local originalWidth = self:getWidth()
  local originalHeight = self:getHeight()
  self:setScale(newWidth / originalWidth, newHeight / originalHeight)
end

local shad
function shadow:init()
	shad = Bitmap.new(Texture.new("Art/shadow.png"))
	shad:setAnchorPoint(.5,.5)
	--shad:setScale(2.5,2.5)
	shad:setSize(MX+100,MX+100)
	shad:setPosition(MX/2,MY/2)
	--self:setAnchorPoint(.5,.5)
	self:addChild(shad)
	self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
end

local rot = 0
function shadow:onEnterFrame()
	shad:setRotation(rot)
	rot=rot+.5
end