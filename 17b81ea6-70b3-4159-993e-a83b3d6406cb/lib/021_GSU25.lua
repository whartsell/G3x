-- The GSU25 is the ADAHRS Air Data Computer and the Attitude and Heading Reference System
-- all data derived by the GSU25 should be contained here
GSU25Impl = SimData:new()

function GSU25Impl:calculateTAS()
	if self.data.machNo ~= nil  and self.data.oat ~= nil then 
		self.data.tas = 661.47 * self.data.machNo * math.sqrt((self.data.oat + 273.15) / 288.15)
	else 
		self.data.tas = 0
	end
end


function GSU25Impl:Update(aData)
	SimData.Update(self,aData)
	self:calculateTAS()
end

GSU25 = GSU25Impl:new{}

function GSU25Callback(airspeed,machNo,oat,heading,turnRate,altitude,baro,roll,pitch,vsi,slip)
	local data = {}
	data.airspeed = airspeed
	data.machNo = machNo
	data.oat = oat
	data.heading = heading
	data.turnRate = turnRate
	data.altitude = altitude
	data.baro = baro
	data.roll = roll
	data.pitch = pitch
	data.vsi = vsi
	data.slip = slip
	GSU25:Update(data)
	
end


xpl_dataref_subscribe(
	'sim/cockpit2/gauges/indicators/airspeed_kts_pilot', 'FLOAT',
	'sim/flightmodel/misc/machno','FLOAT',
	'sim/cockpit2/temperature/outside_air_temp_degc', 'FLOAT',
	'sim/cockpit2/gauges/indicators/heading_AHARS_deg_mag_pilot','FLOAT',
	'sim/flightmodel/misc/turnrate_noroll','FLOAT',
	'sim/cockpit2/gauges/indicators/altitude_ft_pilot', 'FLOAT',
	'sim/cockpit/misc/barometer_setting', 'FLOAT',
	'sim/flightmodel/position/phi', 'FLOAT',
	'sim/flightmodel/position/theta', 'FLOAT',
	'sim/cockpit2/gauges/indicators/vvi_fpm_pilot','FLOAT',
	'sim/cockpit2/gauges/indicators/slip_deg','FLOAT',
	GSU25Callback)