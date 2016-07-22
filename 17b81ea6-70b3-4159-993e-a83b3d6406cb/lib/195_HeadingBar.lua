HeadingBar = {}

function HeadingBar:new(o)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	self.headingTape_dx = -35
	self.headingTape_dy = 47
	self.trackBug_dx = 235
	self.trackBug_dy = 65
	self.turnRateRight_dx = 120
	self.turnRateLeft_dx = 240
	
	self.images = {
		img_headingTape = img_add('headingTape.png',self.headingTape_dx,self.headingTape_dy,2350,24),
		img_headingBug = img_add('headingBug.png',0,0,480,71),
		img_trackBug = img_add('trackBug.png',self.trackBug_dx,self.trackBug_dy,11,6),
		img_turnRateR = img_add('turnRate.png',self.turnRateRight_dx,35,120,12),
		img_turnRateL = img_add('turnRate.png',self.turnRateLeft_dx,35,120,12),
		img_turnRateArrowL = img_add('turnRateArrow.png',self.turnRateRight_dx-11,35,11,12),
		img_turnRateArrowR = img_add('turnRateArrow.png',self.turnRateLeft_dx + 120,35,11,12),
		img_headingMask = img_add('headingMask.png',0,0,480,71),
	}
	
	self.text = {
		txt_heading = txt_add("000", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:right;", 221, 32, 37, 23),
	}
	
	self.viewports = {
		viewport_rect(self.images.img_turnRateR,240,35,120,12),
		viewport_rect(self.images.img_turnRateL,120,35,120,12),
	}
	img_rotate(self.images.img_turnRateArrowR,180)
	return o
end

function HeadingBar:refresh()
	--TODO move to GAD29
	--track = calculateTrack(windDir,windSpeed,heading,tas)
	local track = GAD29:safeGetData('track')
	--print('track',track)
	local headingTapeScale = -5
	local turnRateScale = 90/20
	local heading = GSU25:safeGetData('heading')
	local hbug = GDU37X:safeGetData('hdgBug')
	local turnRate = GSU25:safeGetData('turnRate')
	move(self.images.img_headingTape,self.headingTape_dx + (heading * headingTapeScale),nil,nil,nil)
	move(self.images.img_trackBug,self.trackBug_dx + ((heading-track) * headingTapeScale),nil,nil,nil) 
	move(self.images.img_headingBug,var_cap((heading - hbug),-47,47)*headingTapeScale,nil,nil,nil)
	txt_set(self.text.txt_heading,string.format("%03d",math.floor(heading+.5)))
	visible(self.images.img_turnRateArrowR, turnRate>26.67)
	visible(self.images.img_turnRateArrowL,turnRate < -26.67)
	if math.abs(turnRate)>26.67 then
		turnRate=var_cap(turnRate,-26.67,26.67)
	end
	move(self.images.img_turnRateR,self.turnRateRight_dx + (turnRate * turnRateScale),nil,nil,nil)
	move(self.images.img_turnRateL,self.turnRateLeft_dx + (turnRate * turnRateScale),nil,nil,nil)
end
