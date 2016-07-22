VSI6k = {}

function VSI6k:new(o)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	self.vsiPointerDy = 232
	self.vsiBarDx = 473
	self.vsiBarDy = 240
	
	self.images = {
		img_vsiBarPos = img_add('vsiBar.png',self.vsiBarDx,self.vsiBarDy,6,130),
		img_vsiBarNeg = img_add('vsiBar.png',self.vsiBarDx,self.vsiBarDy-130,6,130),
		img_vsiTape = img_add("vsiTape6k.png",454,105,26,272),
		img_vsiPointer = img_add('vsiPointer.png',461,232,19,17),
	}
	
	self.viewports = {
		viewport_rect(self.images.img_vsiBarPos,self.vsiBarDx,self.vsiBarDy-130,11,125),
		viewport_rect(self.images.img_vsiBarNeg,self.vsiBarDx,self.vsiBarDy,11,125),
	}
	
	return o
end


function VSI6k:refresh()
	local displacement = 0
	local vsi = GSU25:safeGetData('vsi')
	if math.abs(vsi) < 500 then -- should be 500 for low scale
			if vsi > 0 then
				displacement = self.vsiPointerDy - (vsi* 49/500 )
			else 
				displacement = self.vsiPointerDy + (math.abs(vsi)* 49/500 )
			end

		elseif math.abs(vsi) < 1000 then -- 68 is 1000 
			if vsi > 0 then
				displacement = self.vsiPointerDy  - 49 - ((vsi-500) * 19/500)
			else
				displacement = self.vsiPointerDy  + 49 + ((math.abs(vsi)-500) * 19/500)
			end
		elseif math.abs(vsi) < 2000 then -- 87 is 2000
			if vsi > 0 then
				displacement = self.vsiPointerDy  - 68 - ((vsi-1000) * 19/1000)
			else 
				displacement = self.vsiPointerDy  + 68 + ((math.abs(vsi)-1000) * 19/1000)
			end
			
		else -- 129 is 6000
			if vsi > 0 then
				displacement = self.vsiPointerDy  - 87 - ((vsi-2000) * 42/4000)
			else 
				displacement = self.vsiPointerDy  + 87 + ((math.abs(vsi)-2000) * 42/4000)
			end
		end
		move(self.images.img_vsiPointer,nil,displacement,nil,nil)
		move(self.images.img_vsiBarPos,nil,displacement+8,nil,nil)
		move(self.images.img_vsiBarNeg,nil,displacement+8-130,nil,nil)
end