SimData = {}

function SimData:new()
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	
	self.data = {}
	return o
end

function SimData:Update(aData)
	for key,value in pairs(aData) do
		self.data[key] = value
		print(key,value)
	end
	
end

-- this needs to be global so we'll init it here
--SimData = SimData:new()
