SoftKeyState ={ buttons = {
				{text='btn1',active=false,state = false},
				{text='btn2',active=false,state = false},
				{text='btn3',active=false,state = false},
				{text='btn4',active=false,state = false},
				{text='btn5',active=false,state = false}
				}
			}


function SoftKeyState:new(o)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	self.encoderDelta = 0
	return o
end
function SoftKeyState:setContext(context)
	self.context = context
end

function SoftKeyState:refreshMenu()
	print('-->refresh')
	
	print('<--refresh')
end
function SoftKeyState:handleSoftKeys(softKeys)
	for key,value in pairs(softKeys) do
		if value == 1 and self.buttons[key].state == false then
			self.buttons[key].state = true
		elseif value == 0 and self.buttons[key].state == true then
			self.buttons[key].state = false
		end
	end
end

function SoftKeyState:handleJoystick(joystick)
	for key,value in pairs(joystick) do
	
		--print(key,value)
	end
end

function SoftKeyState:processEncoder(encoder)
	local offset = 0
	if encoder ~=0 then
		offset = encoder - self.encoderDelta
		self.encoderDelta = encoder
	else 
		self.encoderDelta = 0
	end
	print('offset',offset,'delta',self.encoderDelta)
	return offset
end


function SoftKeyState:enter()
	for i = 1,5 do
		self.buttons[i].active=false
	end
	return self
end


