--afcs = AFCS:new()
softKeyDisplayArea = SoftKeyDisplayArea:new()

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

function afcsCallback(hdgBug,altBug,asiBug,vsiBug)
	data = {}
	data.hdgBug = hdgBug
	data.altBug = altBug
	data.asiBug = asiBug
	data.vsiBug = vsiBug
	AFCS:Update(data)
end
	


refreshTimer = timer_start(10,100,refreshCallback)
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
	afcsCallback)