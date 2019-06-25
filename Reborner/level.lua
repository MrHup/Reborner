level = gideros.class(Sprite)
require "box2d"
------------------------------
local xSpeed=0; local ySpeed = 0;
-------------------------------
-- matrici predefinite cu nivelurile

local nivel = 1
local matrice

if nivel == 0 then
	matrice = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				0,-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0,
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	}
elseif nivel == 1 then
	matrice = global.level1
elseif nivel == 2 then
	matrice = global.level2
end

-------------------------------
local MX = application:getContentWidth()
local MY = application:getContentHeight()
function setSize(imagine,newWidth, newHeight)
  imagine:setScale(1, 1)
  local originalWidth = imagine:getWidth()
  local originalHeight = imagine:getHeight()
  imagine:setScale(newWidth / originalWidth, newHeight / originalHeight)
end
function round(num, numDecimalPlaces)
  return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end
-------------------------------MOTION
local mergistanga = false
local mergidreapta = false
local froze = 1
local caracterul, podea, bg, crumbs, jump_debounce, statue, ripPoint
local spawnX, spawnY
local stanga, dreapta, sus, display_char, display_lives
function vimp()
	mergidreapta = false
	mergistanga = false
	if caracterul ~= nil then
	caracterul.body:setLinearVelocity(0,0)
	end
	sceneManager:changeScene("start", 1, conf.transition, conf.easing) 
end


function mergi()
	if caracterul ~= nil and caracterul.body~= nil and mergistanga == true then
		caracterul.body:applyForce(-5,0,0,0)
		Timer.delayedCall(10, function() mergi() end) 
	elseif caracterul ~= nil and caracterul.body~= nil and mergidreapta == true then
		local dr = caracterul.body:getLinearVelocity()
		caracterul.body:applyForce(5,0,0,0)
		Timer.delayedCall(10, function() mergi() end) 
	else
		mergidreapta=false
		mergistanga=false
	end
end

function level:onBeginContact(e)
    --getting contact bodies
    local fixtureA = e.fixtureA
    local fixtureB = e.fixtureB
    local bodyA = fixtureA:getBody()
    local bodyB = fixtureB:getBody()
	Timer.delayedCall(10, function () jump_undebounce() end)
	jump_debounce = false
	if bodyA.type and bodyA.type == "carac" and bodyB.type and bodyB.type == "podea" then
		jump_debounce = false
		print("WOOOO")
	end
end

function unfroze()
	froze = 1
end

function level:shakeScreen()
	local screenW = application:getContentWidth()
	local screenH = application:getContentHeight()
   --offset-uri
	local offsetX = 0;
	local offsetY = 0;
	--- pt camera pe latime
	if((self.worldW - caracterul:getX()) < screenW/2) then
		offsetX = -self.worldW + screenW 
	elseif(caracterul:getX() >= screenW/2) then
		offsetX = -(caracterul:getX() - screenW/2)
	end
	--- pt camera pe inaltime
	if((self.worldH - caracterul:getY()) < screenH/2) then
		offsetY = -self.worldH + screenH 
	elseif(caracterul:getY() >= screenH/2) then
		offsetY = -(caracterul:getY() - screenH/2)
	end
	self:setPosition(offsetX-10,offsetY-10)
	GTween.new(self, 0.25, {x = offsetX,y = offsetY}, {delay = 0, ease = easing.outBounce })
end
----------------------------------------------------------
-- lives
local font = Font.new("Textures/font.txt", "Textures/font.png")
local lives = 25
display_lives = TextWrap.new(" x25", 330, "left")
display_lives:setFont(font)
display_lives:setTextColor(0xffffff)
display_lives:setScale(1)
display_lives:setPosition(25,display_lives:getHeight()+5)
local pack_display = TexturePack.new("Textures/Zombie.txt", "Textures/Zombie.png")
display_char =Bitmap.new(pack_display:getTextureRegion("zom_0.png"))
display_char:setX(20)
display_char:setScale(2)
-----------------------------------------------------------------------------          [[[[[[[[[[[[[[[[[[             INIT
function level:init()
	application:setBackgroundColor(0x404152)
	bg = Bitmap.new(Texture.new("Art/bg.png"))
	setSize(bg,application:getContentWidth(), application:getContentHeight())
	self:addChild(bg)
	self.world = b2.World.new(0, 10, true)
	-------------------CONTROLS--------------------------
	--stanga
	local s2 = Bitmap.new(Texture.new("Art/left1.png", conf.textureFilter))
	s2:setScale(.95)
	stanga = Button.new(Bitmap.new(Texture.new("Art/left1.png", conf.textureFilter)), s2)
	stanga:setScale(.8)
	function st_down(target,event)
		if target:hitTestPoint(event.x, event.y) then
			xSpeed = -conf.speed
			caracterul:setRotationY(180)
		end
	end
	function st_up(target,event)
		if xSpeed == -conf.speed then xSpeed = 0 end
	end
	stanga:addEventListener(Event.MOUSE_DOWN, st_down, stanga)
	stanga:addEventListener(Event.MOUSE_UP, st_up, stanga)
	stanga:setPosition(15, application:getContentHeight()-stanga:getHeight()-20)
	--dreapta
	local r2 = Bitmap.new(Texture.new("Art/right1.png", conf.textureFilter))
	r2:setScale(.95)
	dreapta = Button.new(Bitmap.new(Texture.new("Art/right1.png", conf.textureFilter)), r2)
	dreapta:setScale(.8)
	function dr_down(target,event)
		if target:hitTestPoint(event.x, event.y) then
			xSpeed = conf.speed
			caracterul:setRotationY(0)
		end
	end
	function dr_up(target,event)
		if xSpeed == conf.speed then xSpeed = 0 end
	end
	dreapta:addEventListener(Event.MOUSE_DOWN, dr_down, dreapta)
	dreapta:addEventListener(Event.MOUSE_UP, dr_up, dreapta)
	dreapta:setPosition(stanga:getWidth()+35, application:getContentHeight()-dreapta:getHeight()-20)
	--sus
	jump_debounce= false
	function jump_undebounce()
		jump_debounce=false
	end
	local r2 = Bitmap.new(Texture.new("Art/up.png", conf.textureFilter))
	r2:setScale(.95)
	sus = Button.new(Bitmap.new(Texture.new("Art/up.png", conf.textureFilter)), r2)
	sus:setScale(.8)
	function sus_down(target,event)
		if target:hitTestPoint(event.x, event.y) and jump_debounce == false and froze ==1 then
			jump_debounce = true
			caracterul.body:applyForce(0,conf.jumpPow,0,0)
		end
	end
	sus:addEventListener(Event.MOUSE_DOWN, sus_down, sus)
	sus:setPosition(application:getContentWidth()-sus:getWidth()-25,application:getContentHeight()-sus:getHeight()-25)
	--transform ------------------------------------------ TRANSFORMARE
	local transform_debounce = false
	function transform_undebounce()
		transform_debounce=false
	end
	local t2 = Bitmap.new(Texture.new("Art/skull_1.png", conf.textureFilter))
	transform = Button.new(Bitmap.new(Texture.new("Art/skull_0.png", conf.textureFilter)), t2)
	transform:setScale(1.2)
	transform:setPosition(sus:getX()-20-sus:getWidth(),sus:getY())
	function addRipTile(x,y)
		self:tile(x,y,conf.dimensiune,conf.dimensiune,5)
		statue:setPosition(-MX,-3*MY)
		ripPoint:setPosition(-MX,-3*MY)
		froze = 3
		self:redresareCamera()
	end
	
	function freeze(target,event)
		if target:hitTestPoint(event.x, event.y) then
			froze = 2
			self:shakeScreen()
			-- misca caracterul la pozitia initiala
			-- genereaza animatie impietrire
			statue:setGotoAction(54,1)
			statue:setPosition(caracterul:getX(),caracterul:getY())
			statue:setRotationY(caracterul:getRotationY())
			-- spawneaaza un bloc deasupra ecranului la pozitia x corespunzatoare
			local pozX = round(caracterul:getX()/64,0) * 64
			local pozY = round(caracterul:getY()/64,0) * 64
			ripPoint:setPosition(pozX,pozY-application:getContentHeight())
			caracterul.body:setPosition(spawnX,spawnY)
			-- da tween catre y corespunzator
			GTween.new(ripPoint, 1, {y=pozY}, {delay = 0, ease = easing.inSine })
			Timer.delayedCall(1500, function() addRipTile(pozX,pozY) end) 
		end
	end
	transform:addEventListener(Event.MOUSE_DOWN, freeze, transform)
	----------------------------------------------------------------------------------
	--------------DEBUG CONTROLS-----------------------------
	self:addEventListener(Event.KEY_DOWN, function(event)
    if event.keyCode == KeyCode.SPACE then
        if jump_debounce == false and froze ==1 then
			jump_debounce = true
			caracterul.body:applyForce(0,conf.jumpPow,0,0)
		end
	elseif event.keyCode == KeyCode.A then
		xSpeed = -conf.speed
		caracterul:setRotationY(180)
		crumbs:setRotationY(180)
		
	elseif event.keyCode == KeyCode.D then
		xSpeed = conf.speed
		caracterul:setRotationY(0)
		crumbs:setRotationY(0)
    end
	end)
	
	self:addEventListener(Event.KEY_UP, function(event)
		if event.keyCode == KeyCode.A then
			if xSpeed == -conf.speed then xSpeed = 0 end
		elseif event.keyCode == KeyCode.D then
			if xSpeed == conf.speed then xSpeed = 0 end
		end
	end)
	-----------------------------------------------------
	
	local screenW = application:getContentWidth()
	local screenH = application:getContentHeight()
	
	self.worldW = screenW*2
	self.worldH = screenH*126

	self:wall(0,screenH/2,10,screenH)
	--self:wall(screenW/2,0,screenW,10)
	--self:wall(screenW,screenH/2,10,screenH)
	podea = self:wall(screenW/2,-5000,screenW,10)
	podea.body.type = "podea"
	
	-------------------------------------GENERARE NIVEL---------------
	
	local n=12;local c=1;local y=1;local dim=conf.dimensiune;
	for ii,vv in pairs(matrice) do
		if vv>0 then
			self:tile(c*dim,y*dim,dim,dim,vv)
		elseif vv==-1 then
			spawnX = c*dim
			spawnY = y*dim
		end
		c=c+1
		if c==13 then
			c=1
			y=y+1
		end
	end
	
	--------------------------------------------------------------------------
	-- insert tombstone animations --
	local pack1 = TexturePack.new("Textures/StatueCrumble.txt", "Textures/StatueCrumble.png")
	local statue0 = Bitmap.new(pack1:getTextureRegion("statue_0.png"))
	local statue1 = Bitmap.new(pack1:getTextureRegion("statue_1.png"))
	local statue2 = Bitmap.new(pack1:getTextureRegion("statue_2.png"))
	local statue3 = Bitmap.new(pack1:getTextureRegion("statue_3.png"))
	local statue4 = Bitmap.new(pack1:getTextureRegion("statue_4.png"))
	local statue5 = Bitmap.new(pack1:getTextureRegion("statue_5.png"))
	local statue6 = Bitmap.new(pack1:getTextureRegion("statue_6.png"))
	local statue7 = Bitmap.new(pack1:getTextureRegion("statue_7.png"))
	statue = MovieClip.new{
	{1, 12, statue0},	
	{13, 18, statue1},
	{19, 24, statue2},
	{25, 30, statue3},
	{31, 36, statue4},
	{37, 42, statue5},
	{43, 48, statue6},
	{49, 54, statue7}
	}
	statue:setScale(1.25)
	statue:setGotoAction(54,1)
	statue:setAnchorPoint(.5,.5)
	statue:setPosition(-MX,-3*MY)
	self:addChild(statue)
	local pack2 = TexturePack.new("Textures/Tileset.txt", "Textures/Tileset.png")	
	ripPoint = Bitmap.new(pack2:getTextureRegion("tile_5.png"))	
	ripPoint:setSize(conf.dimensiune,conf.dimensiune)
	ripPoint:setAnchorPoint(.5,.5)
	ripPoint:setPosition(-MX,-3*MY)
	self:addChild(ripPoint)
	-- insert crumbs --
	local pachet = TexturePack.new("Textures/crumbs.txt", "Textures/crumbs.png")
	local crumb0 = Bitmap.new(pachet:getTextureRegion("crumb_0.png"))	
	local crumb1 = Bitmap.new(pachet:getTextureRegion("crumb_1.png"))	
	local crumb2 = Bitmap.new(pachet:getTextureRegion("crumb_2.png"))	
	local crumb3 = Bitmap.new(pachet:getTextureRegion("crumb_3.png"))	
	local crumb4 = Bitmap.new(pachet:getTextureRegion("crumb_4.png"))	
	crumbs = MovieClip.new{
	{1, 4, crumb0},	
	{5, 8, crumb1},
	{9, 12, crumb2},
	{13, 16, crumb3},
	{17, 20, crumb4}
	}
	crumbs:setScale(conf.scalar)
	crumbs:setAnchorPoint(1,1)
	crumbs:setGotoAction(20,1)
	self:addChild(crumbs)
	--
	caracterul=self:char(spawnX,spawnY)
	caracterul:setAnchorPoint(.5,.5)
	local debugDraw = b2.DebugDraw.new()
	self.world:setDebugDraw(debugDraw)
	--self:addChild(debugDraw)    ------------------------- DEBUG !!!!!!
	self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
	--Timer.delayedCall(20000, function() vimp() end) 
	self.world:addEventListener(Event.BEGIN_CONTACT, self.onBeginContact, self)
	self:addChild(display_char)
	self:addChild(display_lives)
	self:addChild(transform)
	self:addChild(sus)
	self:addChild(stanga)
	self:addChild(dreapta)
	--self:redresareCamera()
end
-----------------------------------------------------------------------------------------------           ]]]]]]]]]]]
function level:wall(x, y, width, height)
	local wall = Shape.new()
	wall:beginPath()
	wall:moveTo(-width/2,-height/2)
	wall:lineTo(width/2, -height/2)
	wall:lineTo(width/2, height/2)
	wall:lineTo(-width/2, height/2)
	wall:closePath()
	wall:endPath()
	wall:setPosition(x,y)
	
	--create box2d physical object
	local body = self.world:createBody{type = b2.STATIC_BODY}
	body:setPosition(wall:getX(), wall:getY())
	body:setAngle(wall:getRotation() * math.pi/180)
	local poly = b2.PolygonShape.new()
	poly:setAsBox(wall:getWidth()/2, wall:getHeight()/2)
	local fixture = body:createFixture{shape = poly, density = 1.0, 
	friction = 0.1, restitution = 0}
	wall.body = body
	wall.body.type = "wall"
	
	self:addChild(wall)
	return wall
end

function level:tile(x, y, width, height, id)
	local pack = TexturePack.new("Textures/Tileset.txt", "Textures/Tileset.png")
	
	local sir = "tile_" .. id .. ".png"
	local tile = Bitmap.new(pack:getTextureRegion(sir))	
	
	tile:setAnchorPoint(0.5,0.5)
	--tile:setScale(1.5,1.5)
	tile:setSize(width,height)
	tile:setPosition(x,y)
	
	--create box2d physical object
	local body = self.world:createBody{type = b2.STATIC_BODY}
	body:setPosition(tile:getX(), tile:getY())
	body:setAngle(tile:getRotation() * math.pi/180)
	local poly = b2.PolygonShape.new()
	poly:setAsBox(tile:getWidth()/2, tile:getHeight()/2)
	local fixture = body:createFixture{shape = poly, density = 1.0, 
	friction = 0.1, restitution = 0}
	tile.body = body
	tile.body.type = "tile"
	
	self:addChild(tile)
	return tile
end

function level:char(x, y)
	local pack = TexturePack.new("Textures/Zombie.txt", "Textures/Zombie.png")
	char1 = Bitmap.new(pack:getTextureRegion("zom_0.png"))
	--char1:setScale(2,2)
	char2 = Bitmap.new(pack:getTextureRegion("zom_1.png"))
	--char2:setScale(2,2)
	
	local carac = MovieClip.new{
	{1, 10, char1},	
	{11, 20, char2}
	}
	carac:setAnchorPoint(.5,.5)
	carac:setScale(conf.scalar)
	carac:setGotoAction(20,1)
	carac:setPosition(x,y)
	
	local radius = carac:getWidth()/2
	
	local body = self.world:createBody{type = b2.DYNAMIC_BODY}
	body:setPosition(carac:getX(), carac:getY())
	body:setAngle(carac:getRotation() * math.pi/180)
	body:setAngularVelocity(0)
	body:setFixedRotation(true)
	body:setSleepingAllowed(false)
	local poly = b2.PolygonShape.new()
	poly:setAsBox(carac:getWidth()/2,carac:getHeight()/2)
	local fixture = body:createFixture{shape = poly, density = 1, 
	friction = 0.1, restitution = 0}
	carac.body = body
	carac.body.type = "char"
	
	self:addChild(carac)
	return carac
end
-----------------------------------------------------------------ON ENTER FRAME-----------------------------------
function level:redresareCamera() -- redresare camera in baza temporara
	--get screen dimensions
	local screenW = application:getContentWidth()
	local screenH = application:getContentHeight()
	--offset-uri
	local offsetX = 0;
	local offsetY = 0;
	
		--- pt camera pe latime
		if((self.worldW - caracterul:getX()) < screenW/2) then
			offsetX = -self.worldW + screenW 
		elseif(caracterul:getX() >= screenW/2) then
			offsetX = -(caracterul:getX() - screenW/2)
		end
		--self:setX(offsetX)
		--- pt camera pe inaltime
		if((self.worldH - caracterul:getY()) < screenH/2) then
			offsetY = -self.worldH + screenH 
		elseif(caracterul:getY() >= screenH/2) then
			offsetY = -(caracterul:getY() - screenH/2)
		end
		--self:setY(offsetY)
		local tic = 1
		GTween.new(self, tic, {x=offsetX,y=offsetY}, {delay = 0, ease = easing.Sine })
		if stanga then
			GTween.new(display_char, tic, {x=15-offsetX,y=-offsetY}, {delay = 0, ease = easing.Sine })
			GTween.new(display_lives, tic, {x=-offsetX+40,y=display_lives:getHeight()+5-offsetY}, {delay = 0, ease = easing.Sine })
			GTween.new(stanga, tic, {x=-offsetX+15,y=application:getContentHeight()-stanga:getHeight()-20-offsetY}, {delay = 0, ease = easing.Sine })
			GTween.new(dreapta, tic, {x=-offsetX+stanga:getWidth()+35,y=application:getContentHeight()-dreapta:getHeight()-20-offsetY}, {delay = 0, ease = easing.Sine })
			GTween.new(sus, tic, {x=-offsetX+application:getContentWidth()-sus:getWidth()-25,y=application:getContentHeight()-sus:getHeight()-25-offsetY}, {delay = 0, ease = easing.Sine })
			GTween.new(transform, tic, {x=-offsetX+application:getContentWidth()-sus:getWidth()-45-sus:getWidth(),y=application:getContentHeight()-sus:getHeight()-25-offsetY}, {delay = 0, ease = easing.Sine })
			GTween.new(bg, tic, {x=-offsetX,y=-offsetY}, {delay = 0, ease = easing.Sine })
			if xSpeed < 0 and jump_debounce == false then
				crumbs:setPosition(caracterul:getX()+caracterul:getWidth()/2,caracterul:getY() + caracterul:getHeight()/2)
			elseif xSpeed >0 and jump_debounce == false then
				crumbs:setPosition(caracterul:getX()-caracterul:getWidth()/2,caracterul:getY() + caracterul:getHeight()/2)
			else
				crumbs:setPosition(MX*3,-MY*3)
			end
		end
	
	--froze = 1
	Timer.delayedCall(1000, function() unfroze() end)  -- C.E. timp de la timer >= timp de la Tween
end

function level:onEnterFrame()
	self.world:step(1/60, 8, 3)
	for i = 1, self:getNumChildren() do
		local sprite = self:getChildAt(i)
		if sprite.body then
			local body = sprite.body
			local bodyX, bodyY = body:getPosition()
			sprite:setPosition(bodyX, bodyY)
			sprite:setRotation(body:getAngle() * 180 / math.pi)
		end
	end
	
	heroX, heroY = caracterul.body:getPosition();
	
	---------[ CAMERA ] ---------------------------
	--get screen dimensions
	local screenW = application:getContentWidth()
	local screenH = application:getContentHeight()
	--offset-uri
	local offsetX = 0;
	local offsetY = 0;
	if froze == 1 then
		caracterul.body:setPosition(heroX+xSpeed, heroY)
		--- pt camera pe latime
		if((self.worldW - caracterul:getX()) < screenW/2) then
			offsetX = -self.worldW + screenW 
		elseif(caracterul:getX() >= screenW/2) then
			offsetX = -(caracterul:getX() - screenW/2)
		end
		--- pt camera pe inaltime
		if((self.worldH - caracterul:getY()) < screenH/2) then
			offsetY = -self.worldH + screenH 
		elseif(caracterul:getY() >= screenH/2) then
			offsetY = -(caracterul:getY() - screenH/2)
		end
		self:setX(offsetX)
		self:setY(offsetY)
		if stanga then
			display_char:setPosition(15-offsetX,-offsetY)
			display_lives:setPosition(-offsetX+40,display_lives:getHeight()+5-offsetY)
			stanga:setPosition(-offsetX+15, application:getContentHeight()-stanga:getHeight()-20-offsetY)
			dreapta:setPosition(-offsetX+stanga:getWidth()+35, application:getContentHeight()-dreapta:getHeight()-20-offsetY)
			sus:setPosition(-offsetX+application:getContentWidth()-sus:getWidth()-25,application:getContentHeight()-sus:getHeight()-25-offsetY)
			transform:setPosition(sus:getX()-20-sus:getWidth(),sus:getY())
			bg:setPosition(-offsetX,-offsetY)
			if xSpeed < 0 and jump_debounce == false then
				crumbs:setPosition(caracterul:getX()+caracterul:getWidth()/2,caracterul:getY() + caracterul:getHeight()/2)
			elseif xSpeed >0 and jump_debounce == false then
				crumbs:setPosition(caracterul:getX()-caracterul:getWidth()/2,caracterul:getY() + caracterul:getHeight()/2)
			else
				crumbs:setPosition(MX*3,-MY*3)
			end
		end		
	end--]]
	
	-----------------------------------------------
end