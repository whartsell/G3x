-- The GAD 29 is the AirInc interface to nav equipment e.g external NAV/Com, GTN/GNS 
GAD29Impl = SimData:new()

function GAD29Impl:calculateTrack()
	--track = calculateTrack(windDir,windSpeed,heading,tas)
	local heading = GSU25:safeGetData('heading')
	local tas = GSU25:safeGetData('tas')-- need this implemented in GSU25
	local windDir = self:safeGetData('windHeading')
	local windSpeed = self:safeGetData('windSpeed')
	local track
	if windDir >= 180 then 
		windDir = windDir - 180
	else windDir = windDir + 180
	end
	--print(windDir)
	
	 if windSpeed == 0 or tas < 60 then
		track =  heading
	else
		x1 = windSpeed * math.cos(math.rad(windDir))
		y1 = windSpeed * math.sin(math.rad(windDir))
		x2 = tas * math.cos(math.rad(heading))
		y2 = tas * math.sin(math.rad(heading))
		xt = x1 + x2
		yt = y1 + y2
		track = math.atan(yt/xt)
		if xt < 0 then 
			track = track + math.pi
		elseif yt < 0 then
			track = track + (2*math.pi)
		end
		track = math.deg(track)
	end
	self.data.track = track
end




function GAD29Impl:Update(aData)
	SimData.Update(self,aData)
	self:calculateTrack()
end

GAD29 = GAD29Impl:new{}

function GAD29Callback(GpsCurrentWaypoint,GpsBearing,GpsDistance,GpsTime,windSpeed,windHeading,groundspeed)
	local data = {}
	data.GpsCurrentWaypoint = GpsCurrentWaypoint
	data.GpsBearing = GpsBearing
	data.GpsDistance = GpsDistance
	data.GpsTime = GpsTime
	data.windSpeed = windSpeed
	data.windHeading = windHeading
	data.groundspeed = groundspeed
	GAD29:Update(data)
end

xpl_dataref_subscribe('whartsell/g3x/current_wpt','STRING',
	'sim/cockpit2/radios/indicators/gps_bearing_deg_mag','FLOAT',
	'sim/cockpit2/radios/indicators/gps_dme_distance_nm','FLOAT',
	'sim/cockpit2/radios/indicators/gps_dme_time_min','FLOAT',
	'sim/cockpit2/gauges/indicators/wind_speed_kts', "FLOAT",
	'sim/cockpit2/gauges/indicators/wind_heading_deg_mag','FLOAT',
	"sim/flightmodel/position/groundspeed", "FLOAT",
	GAD29Callback)