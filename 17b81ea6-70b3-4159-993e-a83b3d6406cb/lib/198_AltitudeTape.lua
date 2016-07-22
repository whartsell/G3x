AltitudeTape = {}

function AltitudeTape:new(o)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	self.altTapeDx = 357
	self.altTapeDy = -969
	self.altTTDy = -200
	self.altTDy = -200
	self.altHDy = -97
	self.altTwDy = 83
	self.altBugDy = 222
	self.images = {
		altTape0 = img_add("AltTape0.png",self.altTapeDx,self.altTapeDy,72,1208),
		altTape1 = img_add("AltTape1.png",self.altTapeDx,self.altTapeDy,65,1208),
		altTape2 = img_add("AltTape2.png",self.altTapeDx,self.altTapeDy,65,1208),
		altTape3 = img_add("AltTape3.png",self.altTapeDx,self.altTapeDy,65,1208),
		altTape4 = img_add("AltTape4.png",self.altTapeDx,self.altTapeDy,65,1208),
		altTape5 = img_add("AltTape5.png",self.altTapeDx,self.altTapeDy,65,1208),
		altTape6 = img_add("AltTape6.png",self.altTapeDx,self.altTapeDy,65,1208),
		altTape7 = img_add("AltTape7.png",self.altTapeDx,self.altTapeDy,65,1208),
		altTape8 = img_add("AltTape8.png",self.altTapeDx,self.altTapeDy,65,1208),
		altTape9 = img_add("AltTape9.png",self.altTapeDx,self.altTapeDy,65,1208),
		altTape10 = img_add("AltTape10.png",self.altTapeDx,self.altTapeDy,65,1208),
		altTape11 = img_add("AltTape11.png",self.altTapeDx,self.altTapeDy,65,1208),
		altTape12 = img_add("AltTape12.png",self.altTapeDx,self.altTapeDy,65,1208),
		altTape13 = img_add("AltTape13.png",self.altTapeDx,self.altTapeDy,65,1208),
		altTape14 = img_add("AltTape14.png",self.altTapeDx,self.altTapeDy,65,1208),
		altTape15 = img_add("AltTape15.png",self.altTapeDx,self.altTapeDy,65,1208),
		altMask = img_add("altMask.png", 357,71,123,338),
		altBugIcon = img_add("altBug.png",360,77,7,18),
		altBug = img_add("altBug.png",357,-969,11,36),
		altTT = img_add("LargeDigits.png",372,self.altTTDy,18,492),
		altT = img_add("LargeDigits.png",390,self.altTDy,18,492),
		altH = img_add("AltHundreds.png",410,self.altHDy,14,378),
		alt20s = img_add("AltTwenties.png",426,self.altTwDy,27,197),
	}
	
	self.text = {
		altBugText = txt_add("____", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: cyan; -fx-font-weight:bold; -fx-text-alignment:right;", 385, 70, 61, 30),
		FT = txt_add("FT", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:12px; -fx-fill: cyan; -fx-font-weight:bold; -fx-text-alignment:right;", 440, 80, 20, 30),
		baro = txt_add("29.92", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: cyan; -fx-font-weight:bold; -fx-text-alignment:right;", 385, 378, 61, 30),
		IN = txt_add("IN", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:12px; -fx-fill: cyan; -fx-font-weight:bold; -fx-text-alignment:right;", 440, 388, 20, 30),
	}
	
	self.viewports = {
		viewport_rect(self.images.altTape0,357,104,122,272),
		viewport_rect(self.images.altTape1,357,104,122,272),
		viewport_rect(self.images.altTape2,357,104,122,272),
		viewport_rect(self.images.altTape3,357,104,122,272),
		viewport_rect(self.images.altTape4,357,104,122,272),
		viewport_rect(self.images.altTape5,357,104,122,272),
		viewport_rect(self.images.altTape6,357,104,122,272),
		viewport_rect(self.images.altTape7,357,104,122,272),
		viewport_rect(self.images.altTape8,357,104,122,272),
		viewport_rect(self.images.altTape9,357,104,122,272),
		viewport_rect(self.images.altTape10,357,104,122,272),
		viewport_rect(self.images.altTape11,357,104,122,272),
		viewport_rect(self.images.altTape12,357,104,122,272),
		viewport_rect(self.images.altTape13,357,104,122,272),
		viewport_rect(self.images.altTape14,357,104,122,272),
		viewport_rect(self.images.altTape15,357,104,122,272),
		viewport_rect(self.images.altTT,371,222,18,35),
		viewport_rect(self.images.altT,391,222,18,35),
		viewport_rect(self.images.altH,411,222,13,35),
		viewport_rect(self.images.alt20s,424,212,28,56),
		viewport_rect(self.images.altBug,357,104,12,272),
	}
	return o
end

function AltitudeTape:refresh()

	--TODO need smoother transition on alt wheels..they can read low when just a bit below alt.
-- e.g 8499.999 is reading 8400 instead of 85
	local alt = var_cap(GSU25:safeGetData('altitude'),-2000,30000)
	local altitudeBug = var_cap(GDU37X:safeGetData('altBug'),-1000,30000)
	local tape_scale = 12/20
	local bigAlt_scale = 350/9
	local smlAlt_scale = 299/10
	local tens_scale = 149/100
	local tenThousands = math.floor(alt/10000)
	local thousands = math.floor(alt%10000/1000)
	local hundreds = math.floor(alt%10000%1000/100)
	local tens = math.floor(alt%10000%1000%100)
	--print('alt',tenThousands,thousands,hundreds,tens)
	
	move(self.images.altTape0,nil, 1*1200 + self.altTapeDy + (alt * tape_scale), nil, nil)
	move(self.images.altTape1,nil, 0*1208 + self.altTapeDy + (alt * tape_scale), nil, nil)
	move(self.images.altTape2,nil,-1*1200 + self.altTapeDy + (alt * tape_scale), nil, nil)
	move(self.images.altTape3,nil,-2*1200 + self.altTapeDy + (alt * tape_scale), nil, nil)
	move(self.images.altTape4,nil,-3*1200 + self.altTapeDy + (alt * tape_scale), nil, nil)
	move(self.images.altTape5,nil,-4*1200 + self.altTapeDy + (alt * tape_scale), nil, nil)
	move(self.images.altTape6,nil,-5*1200 + self.altTapeDy + (alt * tape_scale), nil, nil)
	move(self.images.altTape7,nil,-6*1200 + self.altTapeDy + (alt * tape_scale), nil, nil)
	move(self.images.altTape8,nil,-7*1200 + self.altTapeDy + (alt * tape_scale), nil, nil)
	move(self.images.altTape9,nil,-8*1200 + self.altTapeDy + (alt * tape_scale), nil, nil)
	move(self.images.altTape10,nil,-9*1200 + self.altTapeDy + (alt * tape_scale), nil, nil)
	move(self.images.altTape11,nil,-10*1200 + self.altTapeDy + (alt * tape_scale), nil, nil)
	move(self.images.altTape12,nil,-11*1200 + self.altTapeDy + (alt * tape_scale), nil, nil)
	move(self.images.altTape13,nil,-12*1200 + self.altTapeDy + (alt * tape_scale), nil, nil)
	move(self.images.altTape14,nil,-13*1200 + self.altTapeDy + (alt * tape_scale), nil, nil)
	move(self.images.altTape15,nil,-14*1200 + self.altTapeDy + (alt * tape_scale), nil, nil)
	move(self.images.altTT,nil,self.altTTDy + (tenThousands * bigAlt_scale), nil, nil)
	move(self.images.altT,nil,self.altTDy + (thousands * bigAlt_scale), nil, nil)
	move(self.images.altH,nil,self.altHDy + (hundreds * smlAlt_scale), nil,nil)
	move(self.images.alt20s,nil,self.altTwDy + (tens * tens_scale), nil, nil)
	txt_set(self.text.altBugText,(string.format("%i",altitudeBug)))
	txt_set(self.text.baro,(string.format("%.2f",GSU25:safeGetData('baro'))))
	move(self.images.altBug,nil, 222 + ((alt-altitudeBug)*tape_scale),nil,nil)
end
