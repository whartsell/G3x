AttitudeIndicator = {}

function AttitudeIndicator:new(o)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	
	self.horizonDeltaX = -320
	self.horizonDeltaY = -320
	self.ladderDeltaX = 172
	self.ladderDeltaY = -378
	self.fdPitchDy = 238
	self.fdRollDx = 239
	
	self.images = {
		img_horizon = img_add("g3x_horizion.png",self.horizonDeltaX,self.horizonDeltaY,1120,1120),
		img_waterline=img_add_fullscreen("g3x_waterline.png"),
		img_ladder1 = img_add("g3x_ladder1.png",self.ladderDeltaX,self.ladderDeltaY,136,1239),
		img_rollScale = img_add("g3xrollscale.png",40,40,400,400),
		img_rollIndex = img_add("g3xrollindex.png",230,89,20,17),
		img_fdPitch = img_add('fdPitch.png',158,self.fdPitchDy,165,3),
		img_fdRoll = img_add('fdRoll.png',self.fdRollDx,157,3,165),
	}
	self.viewports = {
		viewport_rect(self.images.img_ladder1,120,120,206,206),
	}
	
	return o
end

function AttitudeIndicator:refresh()
	local scale=612/90
	local fdRollScale = 77/30
	local roll = GSU25:safeGetData('roll')
	local pitch = GSU25:safeGetData('pitch')
	local fdPitch = GDU37X:safeGetData('fdPitch')
	local fdRoll = GDU37X:safeGetData('fdRoll')
	local fdMode = GDU37X:safeGetData('fdMode')
	
	img_rotate(self.images.img_horizon, roll * -1)
	img_rotate(self.images.img_ladder1, roll * -1)
	img_rotate(self.images.img_rollScale, roll * -1)
	local radial = math.rad(roll * -1)
	local x = -(math.sin(radial) * pitch * scale)
    local y = (math.cos(radial) * pitch * scale)
	move(self.images.img_horizon, x + self.horizonDeltaX, y + self.horizonDeltaY, nil, nil)
	move(self.images.img_ladder1, x + self.ladderDeltaX, y + self.ladderDeltaY, nil,nil)
	--flight director
	if fdMode > 0 then
		visible(self.images.img_fdPitch,1)
		visible(self.images.img_fdRoll,1)
		move(self.images.img_fdPitch,nil,self.fdPitchDy + ((pitch-fdPitch)*scale),nil,nil)
		move(self.images.img_fdRoll,self.fdRollDx - ((roll - fdRoll)*fdRollScale),nil,nil,nil)
	else
		visible(self.images.img_fdPitch,0)
		visible(self.images.img_fdRoll,0)
	end

end
