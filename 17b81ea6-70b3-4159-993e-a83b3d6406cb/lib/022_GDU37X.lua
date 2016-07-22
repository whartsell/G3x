-- GDU37x is the PFD/MFD so all data that should be derived from it should be contained here
GDU37X = SimData:new()

function GDU37XCallback(hdgBug,altBug,asiBug,vsiBug,fdMode,fdRoll,fdPitch)
	local data = {}
	data.hdgBug = hdgBug
	data.altBug = altBug
	data.asiBug = asiBug
	data.vsiBug = vsiBug
	data.fdMode = fdMode
	data.fdRoll = fdRoll
	data.fdPitch = fdPitch
	GDU37X:Update(data)
end

xpl_dataref_subscribe(
	'sim/cockpit/autopilot/heading_mag', 'FLOAT',
	"sim/cockpit/autopilot/altitude", "FLOAT",
	'sim/cockpit/autopilot/airspeed', 'FLOAT',
	'sim/cockpit/autopilot/vertical_velocity', 'FLOAT',
	'sim/cockpit2/autopilot/flight_director_mode','INT',
	'sim/cockpit2/autopilot/flight_director_roll_deg', 'FLOAT',
	'sim/cockpit2/autopilot/flight_director_pitch_deg','FLOAT',
	-- TODO integrate below
	--'sim/cockpit/autopilot/heading_mag', 'FLOAT',
	GDU37XCallback)