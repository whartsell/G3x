DataBarDisplayArea = {}

function DataBarDisplayArea:new(o)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	self.display = {}
	self.display.x = 0
	self.display.y = 0
	self.display.width = 480
	self.display.height = 33
	self.images = {}
	self.images.mask = img_add('dataBarMask.png',0,0,480,33)
	
	self.text = {
		wptLbl = txt_add("WPT", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:14px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:left;", 5, 10, 114, 30),
		brgLbl = txt_add("BRG", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:14px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:left;", 120, 10, 119, 30),
		dstLbl = txt_add("DST", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:14px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:left;", 240, 10, 119, 30),
		eteLbl = txt_add("ETE", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:14px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:left;", 360, 10, 119, 30),
		curWpt = txt_add("XXXXX", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: magenta; -fx-font-weight:bold; -fx-text-alignment:left;", 40, 3, 79, 30),
		bearingWpt = txt_add("000", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: magenta; -fx-font-weight:bold; -fx-text-alignment:left;", 160, 3, 79, 30),
		distanceWpt = txt_add("000.0", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: magenta; -fx-font-weight:bold; -fx-text-alignment:left;", 280, 3, 79, 30),
		timeFirst = txt_add("00:", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: magenta; -fx-font-weight:bold; -fx-text-alignment:right;", 390, 3, 43, 30),
		timeSecondLarge = txt_add("00", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: magenta; -fx-font-weight:bold; -fx-text-alignment:left;", 433, 3, 30, 30),
		timeSecondSmall = txt_add("00", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:14px; -fx-fill: magenta; -fx-font-weight:bold; -fx-text-alignment:left;", 433, 10, 30, 30),
	}
		
	return o
end

function DataBarDisplayArea:refresh()
	local timeFirstValue = 0
	local timeSecondValue = 0
	local distance = GAD29.data.GpsDistance
	local ete = GAD29.data.GpsTime
	
	-- distance should only show tenths if less than 100
	if distance > 100 then
		distance = var_round(distance,0)
	else distance = var_round(distance,1)
	end
	
	-- if were stopped time will return infinite so replace it with blank
	--print('ete',ete)
	if ete == math.huge then
		visible(self.text.timeSecondLarge,1)
		visible(self.text.timeSecondSmall,0)
		timeFirstValue = '__:'
		timeSecondValue = '__'
		txt_set(self.text.timeFirst,timeFirstValue)
		txt_set(self.text.timeSecondLarge,timeSecondValue)
	else
		if ete >=60 then
			visible(self.text.timeSecondLarge,1)
			visible(self.text.timeSecondSmall,0)
			timeFirstValue = math.floor(ete/60)
			--print('hours',timeFirstValue)
			timeSecondValue = var_round(ete%60)
			--print('minutes',timeSecondValue)
		else
			visible(self.text.timeSecondLarge,0)
			visible(self.text.timeSecondSmall,1)
			timeFirstValue = math.floor(ete)
			timeSecondValue = var_round((ete%1 *60))
			--print('Minutes', timeFirstValue)
			--print('Seconds', timeSecondValue)
		
		end
		txt_set(self.text.timeFirst,string.format('%02d:',timeFirstValue))
		txt_set(self.text.timeSecondLarge,string.format('%02d',timeSecondValue))
		txt_set(self.text.timeSecondSmall,string.format('%02d',timeSecondValue))
	end
	
	--txt_set(txt_timeWpt,ete)
	
	txt_set(self.text.curWpt,GAD29.data.GpsCurrentWaypoint)
	txt_set(self.text.distanceWpt,distance)
	txt_set(self.text.bearingWpt,var_round(GAD29.data.GpsBearing,0))

end