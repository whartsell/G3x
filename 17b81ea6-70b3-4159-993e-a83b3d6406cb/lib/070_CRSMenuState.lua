CRSMenuState = RootMenuState:new()

function CRSMenuState:enter()
	RootMenuState.enter(self)
	--self.context:invertKey(2,true)
	self.buttons[2].active=true
		return self
end

function CRSMenuState:handleSoftKeys(softKeys)
		if softKeys[2] == 1 and self.buttons[2].state == false then
		self.buttons[2].state = true
		self.context.currentMenuState = self.context.rootMenuState:enter()
		end
		RootMenuState.handleSoftKeys(self,softKeys)
end

function CRSMenuState:handleJoystick(joystick)
	local currentCourse = GAD29:safeGetData('course')
		local newCourse = self:processEncoder(joystick.encoder) + currentCourse
		if newCourse >359 then
			newCourse = newCourse - 360
		elseif newCourse < 0 then
			newCourse = newCourse + 360
		end
		xpl_dataref_write('sim/cockpit2/radios/actuators/hsi_obs_deg_mag_pilot','FLOAT',newCourse) 
	
	
end

