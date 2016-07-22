FullPfdDisplayArea = {}

function FullPfdDisplayArea:new(o)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	self.components = {}
	self.components.AsiTape = AirSpeedTape:new()
	
	return o
end

function FullPfdDisplayArea:refresh()
	self.components.AsiTape:refresh()
end