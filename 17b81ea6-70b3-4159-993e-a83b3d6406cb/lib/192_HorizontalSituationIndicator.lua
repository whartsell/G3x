HorizontalSituationIndicator = {}

function HorizontalSituationIndicator:new(o)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	
	self.images = {
		img_hsiCard = img_add('hsiCard.png',80,451,319,319),
		img_hsiDrift = img_add('hsiDriftLine.png',70,441,339,339),
		img_courseLineGPS = img_add('courseLineGPS.png',80,451,319,319),
		img_courseLineNAV1 = img_add('courseLineNAV1.png',80,451,319,319),
		img_courseLineNAV2 = img_add('courseLineNAV2.png',80,451,319,319),
		img_cdiGPS = img_add('cdiGPS.png',80,451,319,319),
		img_cdiNAV1 = img_add('cdiNAV1.png',80,451,319,319),
		img_cdiNAV2 = img_add('cdiNAV2.png',80,451,319,319),
		img_hsiReference = img_add('hsiReference.png',57,417,366,324),
		img_hsiHeadingBug = img_add('hsiHeadingBug.png',70,441,339,339),
	}
	
	self.text = {
		txt_GPS = txt_add("GPS", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: magenta; -fx-font-weight:bold; -fx-text-alignment:right;", 160, 550, 50, 30),
		txt_NAV1 = txt_add("NAV1", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: green; -fx-font-weight:bold; -fx-text-alignment:right;", 160, 550, 60, 30),
		txt_NAV2 = txt_add("NAV2", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: green; -fx-font-weight:bold; -fx-text-alignment:right;", 160, 550, 61, 30),
		--txt_NM = txt_add("NM", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:12px; -fx-fill: magenta; -fx-font-weight:bold; -fx-text-alignment:right;", 297, 560, 21, 30),
	}
	
	self.groups = {
		GPS = group_add(self.images.img_cdiGPS,self.images.img_courseLineGPS,self.text.txt_GPS),
		NAV1 = group_add(self.images.img_cdiNAV1,self.images.img_courseLineNAV1,self.text.txt_NAV1),
		NAV2 = group_add(self.images.img_cdiNAV2,self.images.img_courseLineNAV2,self.text.txt_NAV2),
	}
	
	
	
	
	return o
end

function HorizontalSituationIndicator:refresh()
	local navSource = GAD29:safeGetData('navSource')
	local heading = GSU25:safeGetData('heading')
	local course = GAD29:safeGetData('course')
	local hdef = GAD29:safeGetData('hdef')
	local hBug = GDU37X:safeGetData('hdgBug')
	local track = GAD29:safeGetData('track')
	local dh = hdef  * math.cos((course-heading)*math.pi/180)* 39 -- 41 : distance in pixels between 2 dots
    local dv = hdef * math.sin((course-heading)*math.pi/180)* 39 
	visible(self.groups.NAV1,navSource==0)
	visible(self.groups.NAV2,navSource==1)
	visible(self.groups.GPS,navSource==2)
	img_rotate(self.images.img_hsiCard,-heading)
	img_rotate(self.images.img_courseLineNAV1,course-heading)
	img_rotate(self.images.img_courseLineNAV2,course-heading)
	img_rotate(self.images.img_courseLineGPS,course-heading)
	move(self.images.img_cdiGPS,80 + dh,451 + dv,nil,nil)
	move(self.images.img_cdiNAV1,80 + dh,451 + dv,nil,nil)
	move(self.images.img_cdiNAV2,80 + dh,451 + dv,nil,nil)
	img_rotate(self.images.img_cdiNAV1, course-heading)
	img_rotate(self.images.img_cdiNAV2, course-heading)
	img_rotate(self.images.img_cdiGPS, course-heading)
	img_rotate(self.images.img_hsiDrift,-(heading - track))
	img_rotate(self.images.img_hsiHeadingBug,-(heading - hBug))
	
end