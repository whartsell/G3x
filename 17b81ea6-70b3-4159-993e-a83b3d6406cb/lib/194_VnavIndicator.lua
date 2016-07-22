VnavIndicator = {}

function VnavIndicator:new(o)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	self.vnavDiamond_dy = 235
	self.images = {
		img_vnavMask = img_add('vnavMask.png',335,109,22,242),
		img_vnavDiamondGPS = img_add('vnavDiamondGPS.png',340,self.vnavDiamond_dy,12,12),
		img_vnavDiamondNAV = img_add('vnavDiamondNAV.png',340,self.vnavDiamond_dy,11,11),
	}
	
	self.text = {
		txt_vnavGPS = txt_add("G", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:18px; -fx-fill: magenta; -fx-font-weight:bold; -fx-text-alignment:right;", 339, 108, 12, 30),
		txt_vnavNAV = txt_add("G", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:18px; -fx-fill: green; -fx-font-weight:bold; -fx-text-alignment:right;", 339, 108, 12, 30),
	}
	
	self.groups = {
		GpsGroup = group_add(self.images.img_vnavDiamondGPS,self.text.txt_vnavGPS),
		NavGroup = group_add(self.images.img_vnavDiamondNAV,self.text.txt_vnavNAV),
	}
	return o
end

function VnavIndicator:refresh()
	local isVerticalSignal = GAD29:safeGetData('isVerticalSignal')
	local vdef = GAD29:safeGetData('vdef')
	local navSource = GAD29:safeGetData('navSource')
	
	visible(self.images.img_vnavMask,isVerticalSignal)
	visible(self.groups.GpsGroup,isVerticalSignal==1 and navSource == 2)
	visible(self.groups.NavGroup,isVerticalSignal==1 and navSource <2)

	move(self.images.img_vnavDiamondGPS,nil,self.vnavDiamond_dy + (vdef * 43),nil,nil)
	move(self.images.img_vnavDiamondNAV,nil,self.vnavDiamond_dy + (vdef * 43),nil,nil)

end