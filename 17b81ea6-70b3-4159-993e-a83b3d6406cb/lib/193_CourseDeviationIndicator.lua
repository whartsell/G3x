CourseDeviationIndicator = {}

function CourseDeviationIndicator:new(o)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	
	
	return o
end

function CourseDeviationIndicator:refresh()


end