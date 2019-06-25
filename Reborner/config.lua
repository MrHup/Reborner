conf = {
	orientation = Stage.LANDSCAPE_LEFT,
	transition = SceneManager.flip, --crossfade, flip
	easing = easing.outBack,
	textureFilter = true,
	scaleMode = "stretch",
	keepAwake = true,
	width = 480,
	height = 400,
	fps = 60,
	dx = application:getLogicalTranslateX() / application:getLogicalScaleX(),
	dy = application:getLogicalTranslateY() / application:getLogicalScaleY(),
	smallFont = TTFont.new("OtherAssets/tahoma.ttf", 20),
	largeFont = TTFont.new("OtherAssets/tahoma.ttf", 40),
	jumpPow = -600,
	dimensiune= 64,
	scalar = 2,
	speed = 2.5
}

global = {
	level0 = {  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	},
	level1  = {  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0,
				0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 4, 0,
				0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0,
				0, -1, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0,
				0, 2, 1, 1, 3, 0, 0, 0, 0, 0, 0, 0
	}
}