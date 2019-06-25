
Plate = Core.class(Sprite)
MY = application:getContentHeight()

function Sprite:setSize(newWidth, newHeight)
  self:setScale(1, 1)  -- to get original width and height without scaling
  local originalWidth = self:getWidth()
  local originalHeight = self:getHeight()
  self:setScale(newWidth / originalWidth, newHeight / originalHeight)
  parent:addChildAt(self, 25)
end

function Plate:init()
	self:addChild(Bitmap.new(Texture.new("Art/black.png")))
	self:setPosition(540, y)
	self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)	
end

function Plate:onEnterFrame()
	local x,y = self:getPosition()
	x = x - self.speedx
	self:setPosition(x, y)
	self:setSize(310,155)
	local jj = self:getY()/100
	if jj < 0.7 then
		jj=0.3
	end
	if jj > 1.7 then
		jj=1
	end
	self:setScale(jj,jj)
	--self:setScale(jj,jj)
	
end
