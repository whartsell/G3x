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



