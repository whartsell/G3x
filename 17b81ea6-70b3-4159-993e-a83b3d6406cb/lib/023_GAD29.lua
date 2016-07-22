-- The GAD 29 is the AirInc interface to nav equipment e.g external NAV/Com, GTN/GNS 
GAD29 = SimData:new()

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