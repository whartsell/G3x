AltMenuState = RootMenuState:new()

function AltMenuState:enter()
	RootMenuState.enter(self)
	self.buttons[5].active=true
	return self
end

function AltMenuState:handleSoftKeys(softKeys)
	if softKeys[5] == 1 and self.buttons[5].state == false then
		self.buttons[5].state = true
		self.context.currentMenuState = self.context.rootMenuState:enter()
	end
	for key,value in pairs(softKeys) do
		if value == 0 and self.buttons[key].state == true then
			self.buttons[key].state = false
		end
	end
end

function AltMenuState:handleJoystick(joystick)
	local currentAltBug = GDU37X:safeGetData('altBug')
		local newAltBug = var_round((self:processEncoder(joystick.encoder)*100 + currentAltBug)/100,0) * 100
		newAltBug = var_cap(newAltBug,-1000,30000)
		--local newAltBug = (self:processEncoder(joystick.encoder)+ 50) / 100 * 100 + currentAltBug
		print("new AltBug", newAltBug)
		
		xpl_dataref_write("sim/cockpit/autopilot/altitude", "FLOAT",newAltBug) 
end




