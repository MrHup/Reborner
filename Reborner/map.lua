map = gideros.class(Sprite)
local MX = application:getContentWidth()
local MY = application:getContentHeight()

local layer1 = Sprite.new()
local layer2 = Sprite.new()
local layer3 = Sprite.new()
local play_b, caracter
local inMers = false
------------------ variabile statistice----
local lvl = 1 --- nivelul la care se afla jucatorul
local zon = 1 -- zona la care se afla caracterul
-- sa ai un tabel cu 3 valori pe linie, prima fiind numarul nivelului si restu coordonata x si coordonata y la fiecare pawn corespunzator
local table_pawns = {1, 164, 206,
					2, 200, 172,
					3, 242, 207,
					4, 306, 206,
					}

function reactualizare()
	layer1:removeChild(zone)
end

function pozitionare_carac(poz) -- poz fiind pozitia pe care sa se duca
	if lvl < poz then
		for i,v in pairs(table_pawns) do
			if v == lvl then
				lvl = table_pawns[i+3]
				GTween.new(caracter,1, {x=table_pawns[i+4], y=table_pawns[i+5]}, {delay = 0, ease = easing.Sine })
				Timer.delayedCall(1000, function() pozitionare_carac(poz) end)
				caracter:setRotationY(0)
				break
			end
		end
		
	elseif lvl > poz then
		for i,v in pairs(table_pawns) do
			if v == lvl then
				lvl = table_pawns[i-3]
				GTween.new(caracter,1, {x=table_pawns[i-2], y=table_pawns[i-1]}, {delay = 0, ease = easing.Sine })
				Timer.delayedCall(1000, function() pozitionare_carac(poz) end)
				caracter:setRotationY(180)
				break
			end
		end
	elseif lvl == poz then
		inMers = false
		print("gata")
		--reactualizare()
	end
end
----------------functii miscellaneous-----
function setSize(imagine,newWidth, newHeight)
  imagine:setScale(1, 1)
  local originalWidth = imagine:getWidth()
  local originalHeight = imagine:getHeight()
  imagine:setScale(newWidth / originalWidth, newHeight / originalHeight)
end
---------
function map:init()
	application:setBackgroundColor(0x404152)
	local umbra = shadow.new()
	--layer1:addChild(umbra)
	layer2:bloc(0,MY/7)
	layer2:bloc(MX-MX/7,MY/7)
	layer1:zone(1,MX/2,MY/2)
	caracter = layer1:char(164,206)
	layer3:titlu()
	self:addChild(layer1)
	self:addChild(layer2)
	self:addChild(layer3)
	
	play_b= Button.new(Bitmap.new(Texture.new("Art/bplay_0.png", conf.textureFilter)), Bitmap.new(Texture.new("Art/bplay_1.png", conf.textureFilter)))
	layer3:addChild(play_b)
	play_b:setAnchorPoint(.5,.5)
	play_b:setScale(.8)
	play_b:setPosition(MX/2,MY-play_b:getHeight()/2 - 5)
	
	function play(target,event)
		if target:hitTestPoint(event.x, event.y) then
			print("TEST")
			sceneManager:changeScene("level", 1, conf.transition, conf.easing) 
		elseif event.y > 160 and event.y < 220 and inMers == false then
				inMers = true
				if event.x >=150 and event.x < 180 then
					pozitionare_carac(1)
				elseif event.x >=180 and event.x < 220 then
					pozitionare_carac(2)
				elseif event.x >=220 and event.x < 270 then
					pozitionare_carac(3)
				elseif event.x >=270 and event.x < 330 then
					pozitionare_carac(4)
				end
		end
		print(event.x, event.y)
	end
	play_b:addEventListener(Event.MOUSE_DOWN, play, play_b)
end

function layer1:char(x,y)
	local pachet = TexturePack.new("Textures/Zombie.txt", "Textures/Zombie.png")
	local char1=Bitmap.new(pachet:getTextureRegion("zom_0.png"))
	local char2=Bitmap.new(pachet:getTextureRegion("zom_1.png"))
	local char = MovieClip.new{
	{1, 10, char1},	
	{11, 20, char2}
	}
	self:addChild(char)
	char:setPosition(x,y)
	char:setAnchorPoint(.5,1)
	char:setGotoAction(20,1)
	return char
end

function layer1:zone(id,x,y)
	local pachet = TexturePack.new("Textures/maps.txt", "Textures/maps.png")
	local map0 = Bitmap.new(pachet:getTextureRegion("map_00.png"))
	local map1 = Bitmap.new(pachet:getTextureRegion("map_01.png"))
	local map2 = Bitmap.new(pachet:getTextureRegion("map_02.png"))
	local map3 = Bitmap.new(pachet:getTextureRegion("map_03.png"))
	local map4 = Bitmap.new(pachet:getTextureRegion("map_04.png"))
	local map5 = Bitmap.new(pachet:getTextureRegion("map_05.png"))
	local map6 = Bitmap.new(pachet:getTextureRegion("map_06.png"))
	local map7 = Bitmap.new(pachet:getTextureRegion("map_07.png"))
	local map8 = Bitmap.new(pachet:getTextureRegion("map_08.png"))
	local map9 = Bitmap.new(pachet:getTextureRegion("map_09.png"))
	local map10 = Bitmap.new(pachet:getTextureRegion("map_10.png"))
	local map11 = Bitmap.new(pachet:getTextureRegion("map_11.png"))
	local map12 = Bitmap.new(pachet:getTextureRegion("map_12.png"))
	local map13 = Bitmap.new(pachet:getTextureRegion("map_13.png"))
	local map14 = Bitmap.new(pachet:getTextureRegion("map_14.png"))
	local map15 = Bitmap.new(pachet:getTextureRegion("map_15.png"))
	local map16 = Bitmap.new(pachet:getTextureRegion("map_16.png"))
	local map17 = Bitmap.new(pachet:getTextureRegion("map_17.png"))
	local map18 = Bitmap.new(pachet:getTextureRegion("map_18.png"))
	zona = MovieClip.new{
	{	1	,	4	,	map0	},
	{	5	,	8	,	map1	},
	{	9	,	12	,	map2	},
	{	13	,	16	,	map3	},
	{	17	,	20	,	map4	},
	{	21	,	24	,	map5	},
	{	25	,	28	,	map6	},
	{	29	,	32	,	map7	},
	{	33	,	36	,	map8	},
	{	37	,	40	,	map9	},
	{	41	,	44	,	map10	},
	{	45	,	48	,	map11	},
	{	49	,	52	,	map12	},
	{	53	,	56	,	map13	},
	{	57	,	60	,	map14	},
	{	61	,	64	,	map15	},
	{	65	,	68	,	map16	},
	{	69	,	70	,	map17	},
	{	71	,	73	,	map18	}
	}
	zona:setGotoAction(73,1)
	zona:setScale(1.5,1.5)
	zona:setPosition(x-zona:getWidth()/2,y-zona:getHeight()/2)
	self:addChild(zona)
	
	local pack = TexturePack.new("Textures/labels.txt", "Textures/labels.png")
	
	local lvl_label = Bitmap.new(pack:getTextureRegion("level_"..id..".png"))
	local zone_label = Bitmap.new(pack:getTextureRegion("zona_"..id..".png"))
	zone_label:setAnchorPoint(0,0)
	lvl_label:setAnchorPoint(.5,.5)
	zona:addChild(zone_label)
	zona:addChild(lvl_label)
	setSize(zone_label,zona:getWidth()/10, zona:getWidth()/10 / 3.35)
	setSize(lvl_label,zona:getWidth()/9, zona:getWidth()/9 / 3.65)
	zone_label:setPosition(zone_label:getWidth()/2,zona:getHeight()/9)
	lvl_label:setPosition(zone_label:getX()+zone_label:getWidth()/2, zone_label:getY() + zone_label:getHeight() + lvl_label:getHeight()/2 + 7)
end

function layer3:titlu()
	local title = Bitmap.new(Texture.new("Art/textmap.png"))
	title:setAnchorPoint(.5,.5)
	title:setPosition(MX/2,title:getHeight())
	self:addChild(title)
end

function layer2:bloc(x,y)
	local matter = Bitmap.new(Texture.new("Art/block.png"))
	setSize(matter,MX/7,MY/2+MY/4)
	matter:setPosition(x,y)
	self:addChild(matter)
end

--- map loadout:
-- ai practic totu structurat pe zone a cate 4 nivele fiecare
-- iti trebe o functie clasa pt map layout
-- o variabila de despartire
-- butoane principale
-- aici sa ai save/load?