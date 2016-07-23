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
	local currentHeading = GDU37X:safeGetData('hdgBug')
		local newHeading = self:processEncoder(joystick.encoder) + currentHeading
		
		if newHeading >359 then
			newHeading = newHeading - 360
		elseif newHeading < 0 then
			newHeading = newHeading + 360
		end
		xpl_dataref_write('sim/cockpit/autopilot/heading_mag','FLOAT',newHeading) 
end



