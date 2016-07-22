-- The GSU25 is the ADAHRS Air Data Computer and the Attitude and Heading Reference System
-- all data derived by the GSU25 should be contained here
GSU25 = SimData:new()

function GSU25:Update(aData)
	SimData.Update(self,aData)
	if self.data.machNo ~= nil  and self.data.oat ~= nil then 
		self.data.tas = 661.47 * self.data.machNo * math.sqrt((self.data.oat + 273.15) / 288.15)
	else 
		self.data.tas = 0
	end

end
