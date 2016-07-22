SlipIndicator = {}

function SlipIndicator:new(o)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	self.slipBall_dx = 227
	self.images = {
		img_slipMask = img_add('slipMask.png',152,340,176,30),
		img_slipBall = img_add('slipBall.png',self.slipBall_dx,342,25,25),
	}
	
return o

end

function SlipIndicator:refresh()
	local slipRatio = -5
	local slip = GSU25:safeGetData('slip')
	move(self.images.img_slipBall,self.slipBall_dx + (slip * slipRatio),nil,nil,nil)
end
