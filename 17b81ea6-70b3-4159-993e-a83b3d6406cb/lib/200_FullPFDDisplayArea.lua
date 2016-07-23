FullPfdDisplayArea = {}

function FullPfdDisplayArea:new(o)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	self.components = {}
	self.components.AttitudeIndicator = AttitudeIndicator:new()
	self.components.HeadingBar = HeadingBar:new()
	self.components.AsiTape = AirSpeedTape:new()
	self.components.AltTape = AltitudeTape:new()
	self.components.SlipIndicator = SlipIndicator:new()
	self.components.VnavIndicator = VnavIndicator:new()
	self.components.CDI = CourseDeviationIndicator:new()
	self.components.HSI = HorizontalSituationIndicator:new()
	
	return o
end

function FullPfdDisplayArea:refresh()
	self.components.AttitudeIndicator:refresh()
	self.components.AsiTape:refresh()
	self.components.AltTape:refresh()
	self.components.HeadingBar:refresh()
	self.components.SlipIndicator:refresh()
	self.components.VnavIndicator:refresh()
	self.components.CDI:refresh()
	self.components.HSI:refresh()
end