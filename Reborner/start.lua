start = Core.class(Sprite)

local function randomize(elem)
	elem:setPosition(math.random(-1000, 1000), math.random(-1000, 1000))
	elem:setRotation(math.random(0, 360))
	elem:setAlpha(math.random())
	elem:setScale(math.random())
end

function start:init()
	--[[local screen = Bitmap.new(Texture.new("images/gideros_mobile.png", conf.textureFilter))
	self:addChild(screen)
	screen:setPosition((conf.width-screen:getWidth())/2, (conf.height-screen:getHeight())/2)
	self:addEventListener("enterEnd", self.onEnterEnd, self)]]
	self:addEventListener("enterEnd", self.onEnterEnd, self)
	application:setBackgroundColor(0x404152)
end

function start:onEnterEnd()
	local MX = application:getContentWidth()
	local MY = application:getContentHeight()
	local umbra = shadow.new()
	self:addChild(umbra)
	
	local menu = VerticalView.new({padding = 20, easing = conf.easing})
	self:addChild(menu)
	
	local title = Bitmap.new(Texture.new("Art/title.png"))
	title:setScale(.5,.5)
	title:setPosition(25,25)
	self:addChild(title)
	
	local hand = Bitmap.new(Texture.new("Art/Hand.png"))
	hand:setScale(2)
	self:addChild(hand)
	hand:setPosition(125,125)
	
	local mascott = Bitmap.new(Texture.new("Art/Mascott.png"))
	mascott:setAnchorPoint(.5,.5)
	mascott:setScale(2,2)
	mascott:setPosition(MX/2+MX/4,MY/2)
	self:addChild(mascott)
	
	--[[ --template
	local button = Button.new(Bitmap.new(Texture.new("images/start_up.png", conf.textureFilter)), Bitmap.new(Texture.new("images/start_down.png", conf.textureFilter)))
	randomize(button)
	button:addEventListener("click", function()
		menu:reverse()
		sceneManager:changeScene("pack_select", 1, conf.transition, conf.easing) 
	end)
	menu:addChild(button)]]
	
	local button = Button.new(Bitmap.new(Texture.new("Art/pl_but1.png", conf.textureFilter)), Bitmap.new(Texture.new("Art/pl_but2.png", conf.textureFilter)))
	randomize(button)
	button:addEventListener("click", function()
		menu:reverse()
		sceneManager:changeScene("map", 1, conf.transition, conf.easing) 
	end)
	menu:addChild(button)
	
	menu:setPosition(25, (conf.height-menu:getHeight())/2+35)
	
end