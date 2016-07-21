
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

function refreshCallback()
	softKeyDisplayArea:refresh()
end

function GDU37XCallback(hdgBug,altBug,asiBug,vsiBug)
	data = {}
	data.hdgBug = hdgBug
	data.altBug = altBug
	data.asiBug = asiBug
	data.vsiBug = vsiBug
	GDU37X:Update(data)
end
	

--drives the refresh on the menu currently...will most likely become a gdu37x callback
refreshTimer = timer_start(10,100,refreshCallback)

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
	GDU37XCallback)