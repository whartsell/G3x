AirSpeedTape = {}

function AirSpeedTape:new(o)
	--TODO break out the digital mask so it can be swapped with red
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	self.images = {
		asiTape = img_add('g3xASItape.png',21,-1774,76,1944),
		asiMask= img_add("ASImask.png",0,71,97,338),
		asiOnes = img_add("LargeDigits.png",61,-200,18,492),
		asiTens = img_add("LargeDigits.png",41,-200,18,492),
		asiHundreds = img_add("LargeDigits.png",21,-200,18,492),
	}
	self.text = {
		tas = txt_add("", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:right;", 25, 378, 50, 30),
		white_KT = txt_add("KT", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:12px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:right;", 70, 388, 20, 30),
		gs = txt_add("", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: magenta; -fx-font-weight:bold; -fx-text-alignment:right;", 25, 70, 50, 30),
		magenta_KT = txt_add("KT", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:12px; -fx-fill: magenta; -fx-font-weight:bold; -fx-text-alignment:right;", 70, 80, 20, 30),
	}
	self.viewports = {
		viewport_rect(self.images.asiOnes,60,206,18,67),
		viewport_rect(self.images.asiTens,40,222,18,35), 
		viewport_rect(self.images.asiHundreds,20,222,18,35),
		viewport_rect(self.images.asiTape,0,104,96,272),
	}
	return o
end

function AirSpeedTape:refresh()

--TODO put in nifty rolling animation for tens and 100s
	local number_scale = 350/9
	local tape_scale = 1924/480
	local asi = var_cap(GSU25:safeGetData('airspeed'),0,500)
	local hundreds = math.floor(asi/100)
	local tens = math.floor(asi%100/10)
	local ones = asi%100%10
	move(self.images.asiOnes,nil,-200 + (ones * number_scale),nil,nil)
	move(self.images.asiTens,nil,-200 + (tens * number_scale),nil,nil)
	move(self.images.asiHundreds,nil,-200 + (hundreds * number_scale),nil,nil)
	move(self.images.asiTape,nil,-1774 + (asi * tape_scale)  ,nil,nil)
	txt_set(self.text.tas,string.format("%i",GSU25:safeGetData('tas')))
	txt_set(self.text.gs,string.format("%i",math.floor(GAD29:safeGetData('groundspeed')*1.94384))  )
	
end