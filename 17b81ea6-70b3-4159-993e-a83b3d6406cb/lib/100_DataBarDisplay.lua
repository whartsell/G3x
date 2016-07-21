DataBarDisplayArea = {}

function DataBarDisplayArea:new(o)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	self.display = {}
	self.display.x = 0
	self.display.y = 0
	self.display.width = 480
	self.display.height = 33
	self.images = {}
	self.images.mask = img_add('dataBarMask.png',0,0,480,33)
	
	self.text = {
		wptLbl = txt_add("WPT", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:14px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:left;", 5, 10, 114, 30),
		brgLbl = txt_add("BRG", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:14px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:left;", 120, 10, 119, 30),
		dstLbl = txt_add("DST", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:14px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:left;", 240, 10, 119, 30),
		eteLbl = txt_add("ETE", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:14px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:left;", 360, 10, 119, 30),
		curWpt = txt_add("XXXXX", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: magenta; -fx-font-weight:bold; -fx-text-alignment:left;", 40, 3, 79, 30),
		bearingWpt = txt_add("000", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: magenta; -fx-font-weight:bold; -fx-text-alignment:left;", 160, 3, 79, 30),
		distanceWpt = txt_add("000.0", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: magenta; -fx-font-weight:bold; -fx-text-alignment:left;", 280, 3, 79, 30),
		timeFirst = txt_add("00:", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: magenta; -fx-font-weight:bold; -fx-text-alignment:right;", 390, 3, 43, 30),
		--timeSecondLarge = txt_add("00", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: magenta; -fx-font-weight:bold; -fx-text-alignment:left;", 433, 3, 30, 30),
		timeSecondSmall = txt_add("00", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:14px; -fx-fill: magenta; -fx-font-weight:bold; -fx-text-alignment:left;", 433, 10, 30, 30),
	}
		
	return o
end