--setting up some configurations
application:setOrientation(conf.orientation)
--application:setLogicalDimensions(conf.width, conf.height)
application:setScaleMode(conf.scaleMode)
application:setFps(conf.fps)
application:setKeepAwake(conf.keepAwake)

--get new dimensions


application:setBackgroundColor(0xC9C9C9)


local function onEnterFrame()

end

stage:addEventListener(Event.ENTER_FRAME, onEnterFrame) 

--define scenes
sceneManager = SceneManager.new({
	--start scene
	["start"] = start,
	--options scene
	["options"] = options,
	--pack select scene
	["map"] = map,
	["level"] = level
})
--add manager to stage
stage:addChild(sceneManager)

--start start scene
sceneManager:changeScene("start", 1, conf.transition, conf.easing)

--- scene --
-- meniu principal  ]
	-- maps         ]  - same scene
	-- level select ]
	
	-- level itself - dif scene....saaaau...sa fie totul pe o scena? nush ce sa zic... Ar fi mai usor teoretic totul pe o scena.. <- idiot