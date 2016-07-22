fullPfdDisplayArea = FullPfdDisplayArea:new()
softKeyDisplayArea = SoftKeyDisplayArea:new()
dataBarDisplayArea = DataBarDisplayArea:new()


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


function GAD29Callback(GpsCurrentWaypoint,GpsBearing,GpsDistance,GpsTime)
	data = {}
	data.GpsCurrentWaypoint = GpsCurrentWaypoint
	data.GpsBearing = GpsBearing
	data.GpsDistance = GpsDistance
	data.GpsTime = GpsTime
	GAD29:Update(data)
end


--drives the refresh on the menu currently...will most likely become a gdu37x callback
refreshTimers = {
	menuTimer = timer_start(100,100,dataBarsRefresh),
	pfdTimer = timer_start(100,100,pfdRefresh)
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


	
xpl_dataref_subscribe('whartsell/g3x/current_wpt','STRING',
	'sim/cockpit2/radios/indicators/gps_bearing_deg_mag','FLOAT',
	'sim/cockpit2/radios/indicators/gps_dme_distance_nm','FLOAT',
	'sim/cockpit2/radios/indicators/gps_dme_time_min','FLOAT',
	-- TODO integrate below
	--'sim/cockpit2/gauges/indicators/wind_speed_kts', "FLOAT",
	--'sim/cockpit2/gauges/indicators/wind_heading_deg_mag','FLOAT',
	--"sim/flightmodel/position/groundspeed", "FLOAT",
	GAD29Callback)
	
