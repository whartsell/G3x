HDGMenuState = RootMenuState:new()

function HDGMenuState:enter()
	RootMenuState.enter(self)
	self.delta = 0
	self.buttons[1].active=true
	return self
end

function HDGMenuState:handleSoftKeys(softKeys)
	if softKeys[1] == 1 and self.buttons[1].state == false then
		self.buttons[1].state = true
--		self.buttons[1].active = not self.buttons[1].active
		self.context.currentMenuState = self.context.rootMenuState:enter()
	end
	for key,value in pairs(softKeys) do
		if value == 0 and self.buttons[key].state == true then
				self.buttons[key].state = false
			
		end
	end
end

function HDGMenuState:handleJoystick(joystick)
	if joystick.encoder ~= 0 then
	-- this is just a test..it needs to be cleaned up but works
	-- should rename to joystick/encoder_delta
		local offset = math.floor(joystick.encoder/4)
		local newHeading = offset - self.delta + AFCS.data.hdgBug
		xpl_dataref_write('sim/cockpit/autopilot/heading_mag','FLOAT',newHeading)
		self.delta =offset
		print(offset)
	else 
		self.delta = 0
	end
	
	
end



