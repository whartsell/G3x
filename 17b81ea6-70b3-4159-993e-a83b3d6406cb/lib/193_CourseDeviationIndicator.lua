CourseDeviationIndicator = {}

function CourseDeviationIndicator:new(o)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	self.cdiNeedle_dx = 233
	self.images = {
		img_cdiMask = img_add('cdiMask.png',130,376,222,22),
		img_cdiNeedleGPS = img_add('cdiNeedleGPS.png',self.cdiNeedle_dx,381,16,13),
		img_cdiNeedleNAV = img_add('cdiNeedleNav.png',self.cdiNeedle_dx,381,16,13),

	}
	
	return o
end

function CourseDeviationIndicator:refresh()
	local navSource = GAD29:safeGetData('navSource')
	local hdef = GAD29:safeGetData('hdef')
	local toFrom = GAD29:safeGetData('toFrom')
	visible(self.images.img_cdiNeedleGPS,navSource==2)
	visible(self.images.img_cdiNeedleNAV,navSource <2)

	move(self.images.img_cdiNeedleGPS, self.cdiNeedle_dx + (hdef * 43),nil,nil,nil)
	move(self.images.img_cdiNeedleNAV, self.cdiNeedle_dx + (hdef * 43),nil,nil,nil)
	
	if toFrom ==1 then
		img_rotate(self.images.img_cdiNeedleGPS,0)
		img_rotate(self.images.img_cdiNeedleNAV,0)
	elseif toFrom ==2 then
		img_rotate(self.images.img_cdiNeedleGPS,180)
		img_rotate(self.images.img_cdiNeedleNAV,180)
	end
end