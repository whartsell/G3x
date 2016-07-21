-- This is the main graphics class for the Soft Key Menu Bar
-- It handles all the drawing of the Menu Bar as well as contains its state


SoftKeyDisplayArea = {}

function SoftKeyDisplayArea:new(o)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	
	self.img_softKeyMask = img_add('softKeyMask.png',0,775,480,25)
	self.img_invSoftKeys = {}
	self.txt_softKeys = {}
	self.txt_softKeys_Inv = {}
	self.img_invSoftKeys[1] = img_add('invertedSoftKey.png',1,776,94,23)
	self.img_invSoftKeys[2] = img_add('invertedSoftKey.png',96+1,776,94,23)
	self.img_invSoftKeys[3] = img_add('invertedSoftKey.png',96*2+1,776,94,23)
	self.img_invSoftKeys[4] = img_add('invertedSoftKey.png',96*3+1,776,94,23)
	self.img_invSoftKeys[5] = img_add('invertedSoftKey.png',96*4+1,776,94,23)
	self.txt_softKeys[1] = txt_add("KEY 1", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:center;", 0, 771, 96, 25)
	self.txt_softKeys[2] = txt_add("KEY 2", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:center;", 96, 771, 96, 25)
	self.txt_softKeys[3] = txt_add("KEY 3", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:center;", 96*2, 771, 96, 25)
	self.txt_softKeys[4] = txt_add("KEY 4", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:center;", 96*3, 771, 96, 25)
	self.txt_softKeys[5] = txt_add("KEY 5", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:center;", 96*4, 771, 96, 25)	

	self.txt_softKeys_Inv[1] = txt_add("KEY 1", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: black; -fx-font-weight:bold; -fx-text-alignment:center;", 0, 771, 96, 25)
	self.txt_softKeys_Inv[2] = txt_add("KEY 2", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: black; -fx-font-weight:bold; -fx-text-alignment:center;", 96, 771, 96, 25)
	self.txt_softKeys_Inv[3] = txt_add("KEY 3", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: black; -fx-font-weight:bold; -fx-text-alignment:center;", 96*2, 771, 96, 25)
	self.txt_softKeys_Inv[4] = txt_add("KEY 4", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: black; -fx-font-weight:bold; -fx-text-alignment:center;", 96*3, 771, 96, 25)
	self.txt_softKeys_Inv[5] = txt_add("KEY 5", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: black; -fx-font-weight:bold; -fx-text-alignment:center;", 96*4, 771, 96, 25)	

	-- create the menu states for the state machine
	self.rootMenuState = RootMenuState:new()
	self.rootMenuState:setContext(self)
	self.hdgMenuState = HDGMenuState:new()
	self.hdgMenuState:setContext(self)
	self.crsMenuState = CRSMenuState:new()
	self.crsMenuState:setContext(self)
	self.baroMenuState = BaroMenuState:new()
	self.baroMenuState:setContext(self)
	self.minimumsMenuState = MinimumsMenuState:new()
	self.minimumsMenuState:setContext(self)
	self.altMenuState = AltMenuState:new()
	self.altMenuState:setContext(self)
	self.currentMenuState = self.rootMenuState:enter()
	return o
end

function SoftKeyDisplayArea:refresh()
	-- update the menu area
	-- since it appears that callbacks happen on their own thread we redraw at a fixed interval
	for i=1,5 do
		local button = self.currentMenuState.buttons[i]
		txt_set(self.txt_softKeys[i],button.text)
		txt_set(self.txt_softKeys_Inv[i],button.text)
		self:invertKey(i,button.active)
	end
end
function SoftKeyDisplayArea:invertKey(index,state)
	visible(self.img_invSoftKeys[index],state)
	visible(self.txt_softKeys_Inv[index],state)
	visible(self.txt_softKeys[index], not state)
end

function SoftKeyDisplayArea:handleSoftKeys(softKeys)
	self.currentMenuState:handleSoftKeys(softKeys)
end

function SoftKeyDisplayArea:handleJoystick(joystick)
	self.currentMenuState:handleJoystick(joystick)
end