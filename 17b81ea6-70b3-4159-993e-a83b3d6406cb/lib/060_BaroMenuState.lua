BaroMenuState = RootMenuState:new{ buttons = {
				{text='',active=false,state = false},
				{text='',active=false,state = false},
				{text='MINIMUMS',active=false,state = false},
				{text='BARO',active=false,state = false},
				{text='BACK',active=false,state = false}
				}
			}

function BaroMenuState:enter()
	RootMenuState.enter(self)
	self.buttons[4].active=true
	return self
end


function BaroMenuState:handleSoftKeys(softKeys)
	if softKeys[3] == 1 and self.buttons[3].state == false then
		self.context.currentMenuState = self.context.minimumsMenuState:enter()
	elseif softKeys[5] == 1 and self.buttons[5].state == false then
		self.context.currentMenuState = self.context.rootMenuState:enter()
	elseif softKeys[4] == 1 and self.buttons[4].state == false then
		self.context.currentMenuState = self.context.rootMenuState:enter()
	end
	for key,value in pairs(softKeys) do
		if value == 0 and self.buttons[key].state == true then
			self.buttons[key].state = false
		end
	end
end

function BaroMenuState:handleJoystick(joystick)
	--TODO need var_cap for max/min baro
	local currentBaro = GSU25:safeGetData('baro')
		local newBaro = self:processEncoder(joystick.encoder)*0.01 + currentBaro
		print("new baro", newBaro)
		
		xpl_dataref_write('sim/cockpit/misc/barometer_setting', 'FLOAT',newBaro) 
end


