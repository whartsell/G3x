MinimumsMenuState = BaroMenuState:new()

function MinimumsMenuState:enter()
	BaroMenuState.enter(self)
	self.buttons[3].active=true
	self.buttons[4].active=false
	return self
end

function MinimumsMenuState:handleSoftKeys(softKeys)
	if softKeys[4] == 1 and self.buttons[4].state == false then
		self.buttons[4].state = true
		self.context.currentMenuState = self.context.baroMenuState:enter()
	elseif softKeys[3] == 1 and self.buttons[3].state == false then
		self.buttons[3].state = true
		self.context.currentMenuState = self.context.rootMenuState:enter()
	end
	for key,value in pairs(softKeys) do
		if value == 0 and self.buttons[key].state == true then
			self.buttons[key].state = false
		end
	end
end



