RootMenuState = SoftKeyState:new{ buttons = {
				{text='HDG',active=false,state = false},
				{text='CRS',active=false,state = false},
				{text='CDI SRC',active=false,state = false},
				{text='BARO',active=false,state = false},
				{text='ALT',active=false,state = false}
				}
			}

function RootMenuState:handleSoftKeys(softKeys)

	if softKeys[1] == 1 and self.buttons[1].state == false then
		self.buttons[1].state = true
		self.context.currentMenuState = self.context.hdgMenuState:enter()
	elseif softKeys[2] == 1 and self.buttons[2].state == false then
		self.buttons[2].state = true
		self.context.currentMenuState = self.context.crsMenuState:enter()
	elseif softKeys[3] == 1 and self.buttons[3].state == false then
		self.buttons[3].state = true
		self.buttons[3].active = true
	elseif softKeys[4] == 1 and self.buttons[4].state == false then
		self.buttons[4].state = true
		self.context.currentMenuState = self.context.baroMenuState:enter()
	elseif softKeys[5] == 1 and self.buttons[5].state == false then
		self.buttons[5].state = true
		self.context.currentMenuState = self.context.altMenuState:enter()
	end
	
	for key,value in pairs(softKeys) do
		if value == 0 and self.buttons[key].state == true then
			self.buttons[key].state = false
			if key == 3 then 
				self.buttons[key].active = not self.buttons[key].active
			end
		end
	end
end
