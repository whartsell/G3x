
softKeyDisplayArea = SoftKeyDisplayArea:new()
dataBarDisplayArea = DataBarDisplayArea:new()
fullPfdDisplayArea = FullPfdDisplayArea:new()

function softKeyHandler(skey1,skey2,skey3,skey4,skey5)
	local skeys = {skey1,skey2,skey3,skey4,skey5}
	softKeyDisplayArea:handleSoftKeys(skeys)
end
function joystickHandler(encoder)
	local joystick = {}
	joystick["encoder"] = encoder
	joystick['dec'] = dec
	softKeyDisplayArea:handleJoystick(joystick)
end

function dataBarsRefresh()
	dataBarDisplayArea:refresh()
	softKeyDisplayArea:refresh()
	
end

function pfdRefresh()
	fullPfdDisplayArea:refresh()
end

function GDU37XCallback(hdgBug,altBug,asiBug,vsiBug)
	data = {}
	data.hdgBug = hdgBug
	data.altBug = altBug
	data.asiBug = asiBug
	data.vsiBug = vsiBug
	GDU37X:Update(data)
end

function GAD29Callback(GpsCurrentWaypoint,GpsBearing,GpsDistance,GpsTime)
	data = {}
	data.GpsCurrentWaypoint = GpsCurrentWaypoint
	data.GpsBearing = GpsBearing
	data.GpsDistance = GpsDistance
	data.GpsTime = GpsTime
	GAD29:Update(data)
end

function GSU25Callback(airspeed,machNo,oat,heading,turnRate)
	data = {}
	data.airspeed = airspeed
	data.machNo = machNo
	data.oat = oat
	data.heading = heading
	data.turnRate = turnRate
	GSU25:Update(data)
end
--drives the refresh on the menu currently...will most likely become a gdu37x callback
refreshTimers = {
	menuTimer = timer_start(100,100,dataBarsRefresh),
	pfdTimer = timer_start(33,33,pfdRefresh)
	}


--These probably should be with the GDU37x as they are buttons on it but im keeping them separate 
-- due to the fact they are driven by a plugin.  If/when Airmanager has hardware support I will 
-- change it
xpl_dataref_subscribe('whartsell/g3x/softKey1','INT',
	'whartsell/g3x/softKey2','INT',
	'whartsell/g3x/softKey3','INT',
	'whartsell/g3x/softKey4','INT',
	'whartsell/g3x/softKey5','INT',
	softKeyHandler)

xpl_dataref_subscribe('whartsell/g3x/joystick/encoder_delta',"INT",
	joystickHandler)

xpl_dataref_subscribe(
	'sim/cockpit/autopilot/heading_mag', 'FLOAT',
	"sim/cockpit/autopilot/altitude", "FLOAT",
	'sim/cockpit/autopilot/airspeed', 'FLOAT',
	'sim/cockpit/autopilot/vertical_velocity', 'FLOAT',
	-- TODO integrate below
	--'sim/cockpit/autopilot/heading_mag', 'FLOAT',
	GDU37XCallback)
	
xpl_dataref_subscribe('whartsell/g3x/current_wpt','STRING',
	'sim/cockpit2/radios/indicators/gps_bearing_deg_mag','FLOAT',
	'sim/cockpit2/radios/indicators/gps_dme_distance_nm','FLOAT',
	'sim/cockpit2/radios/indicators/gps_dme_time_min','FLOAT',
	-- TODO integrate below
	--'sim/cockpit2/gauges/indicators/wind_speed_kts', "FLOAT",
	--'sim/cockpit2/gauges/indicators/wind_heading_deg_mag','FLOAT',
	--"sim/flightmodel/position/groundspeed", "FLOAT",
	GAD29Callback)
	
xpl_dataref_subscribe(
	'sim/cockpit2/gauges/indicators/airspeed_kts_pilot', 'FLOAT',
	'sim/flightmodel/misc/machno','FLOAT',
	'sim/cockpit2/temperature/outside_air_temp_degc', 'FLOAT',
	'sim/cockpit2/gauges/indicators/heading_AHARS_deg_mag_pilot','FLOAT',
	'sim/flightmodel/misc/turnrate_noroll','FLOAT',
	GSU25Callback)