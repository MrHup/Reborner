options = gideros.class(Sprite)

function options:init()
	--[[
	local screen = Bitmap.new(Texture.new("images/gideros_mobile.png", conf.textureFilter))
	self:addChild(screen)
	screen:setPosition((conf.width-screen:getWidth())/2, (conf.height-screen:getHeight())/2)]]
	local menu = VerticalView.new({padding = 20, easing = conf.easing})
	
	self:addChild(menu)

	--local musicOnButton = Button.new(Bitmap.new(Texture.new("images/musicon_up.png", conf.textureFilter)), Bitmap.new(Texture.new("images/musicon_down.png", conf.textureFilter)))
	--local musicOffButton = Button.new(Bitmap.new(Texture.new("images/musicoff_up.png", conf.textureFilter)), Bitmap.new(Texture.new("images/musicoff_down.png", conf.textureFilter)))
	
	--[[musicOnButton:addEventListener("click", function()
			menu:replaceChild(musicOnButton, musicOffButton)
			music:off()
	end)
	
	musicOffButton:addEventListener("click", function()
			menu:replaceChild(musicOffButton, musicOnButton)
			music:on()
	end)
	
	if sets:get("music") then
		menu:addChild(musicOnButton)
	else
		menu:addChild(musicOffButton)
	end
	
	local soundsOnButton = Button.new(Bitmap.new(Texture.new("images/soundson_up.png", conf.textureFilter)), Bitmap.new(Texture.new("images/soundson_down.png", conf.textureFilter)))
	local soundsOffButton = Button.new(Bitmap.new(Texture.new("images/soundsoff_up.png", conf.textureFilter)), Bitmap.new(Texture.new("images/soundsoff_down.png", conf.textureFilter)))
	
	soundsOnButton:addEventListener("click", 
		function()
			menu:replaceChild(soundsOnButton, soundsOffButton)
			sounds:off()
		end
	)
	
	soundsOffButton:addEventListener("click", 
		function()
			menu:replaceChild(soundsOffButton, soundsOnButton)
			sounds:on()
		end
	)
	
	if sets:get("sounds") then
		menu:addChild(soundsOnButton)
	else
		menu:addChild(soundsOffButton)
	end
	
	local backButton = Button.new(Bitmap.new(Texture.new("images/back_up.png", conf.textureFilter)), Bitmap.new(Texture.new("images/back_down.png", conf.textureFilter)))
	backButton:addEventListener("click", 
		function()
		menu:reverse()
		sceneManager:changeScene("start", 1, conf.transition, conf.easing) 
	end
	)
	menu:addChild(backButton)
	
	--position menu in center
	menu:setPosition(-menu:getWidth()/2, -menu:getHeight()/2)
	]]
	
end