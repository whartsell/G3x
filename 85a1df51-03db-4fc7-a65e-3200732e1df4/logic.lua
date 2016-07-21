


--Helpers
function calculateTrack(phi1,r1,phi2,r2)
	--print(phi1,r1,phi2,r2)
	if phi1 >= 180 then 
		phi1 = phi1 - 180
	else phi1 = phi1 + 180
	end
	--print(phi1)
	
	 if r1 == 0 or r2 < 60 then
		track =  phi2
		-- print(track)
		-- print('2 pi', math.pi*2)
		return track
	else
		x1 = r1 * math.cos(math.rad(phi1))
		y1 = r1 * math.sin(math.rad(phi1))
		x2 = r2 * math.cos(math.rad(phi2))
		y2 = r2 * math.sin(math.rad(phi2))
		xt = x1 + x2
		yt = y1 + y2
		track = math.atan(yt/xt)
		if xt < 0 then 
			track = track + math.pi
		elseif yt < 0 then
			track = track + (2*math.pi)
		end
		return math.deg(track)
	end
end

--Globals
track = 0
use6kVSI = true


--TODO attitude director
--TODO different attitude bars
txt_load_font("FuturaCondensedMedium.ttf")
horizon_deltax = -320	
horizon_deltay = -320
img_horizon = img_add("g3x_horizion.png",horizon_deltax,horizon_deltay,1120,1120)
img_waterline=img_add_fullscreen("g3x_waterline.png")
ladder_deltax = 172
ladder_deltay = -378
img_ladder1 = img_add("g3x_ladder1.png",ladder_deltax,ladder_deltay,136,1239)
img_rollScale = img_add("g3xrollscale.png",40,40,400,400)
img_rollIndex = img_add("g3xrollindex.png",230,89,20,17)
viewport_rect(img_ladder1,120,120,206,206)
fdPitch_dy = 238
fdRoll_dx = 239
img_fdPitch = img_add('fdPitch.png',158,fdPitch_dy,165,3)	
img_fdRoll = img_add('fdRoll.png',fdRoll_dx,157,3,165)	
function attitude(roll, pitch,mode,fdRoll,fdPitch)
		local scale=612/90
		local fdRollScale = 77/30
	--scale=1
	img_rotate(img_horizon  , roll * -1)
	img_rotate(img_ladder1, roll * -1)
	img_rotate(img_rollScale, roll * -1)
    --pitch = var_cap(pitch,-90,90)
	local radial = math.rad(roll * -1)
	local x = -(math.sin(radial) * pitch * scale)
    local y = (math.cos(radial) * pitch * scale)
	move(img_horizon, x + horizon_deltax, y + horizon_deltay, nil, nil)
	move(img_ladder1, x + ladder_deltax, y + ladder_deltay, nil,nil)
	--print('radial', radial)
	--flight director
	if mode > 0 then
		visible(img_fdPitch,1)
		visible(img_fdRoll,1)
		move(img_fdPitch,nil,fdPitch_dy + ((pitch-fdPitch)*scale),nil,nil)
		move(img_fdRoll,fdRoll_dx - ((roll - fdRoll)*fdRollScale),nil,nil,nil)
	else
		visible(img_fdPitch,0)
		visible(img_fdRoll,0)
	end
	--print ('pitch',pitch)
	--print ('roll',roll)
	mode = (mode <1 and 'off' or 'on')
	--print (mode)
	
end

xpl_dataref_subscribe("sim/flightmodel/position/phi", "FLOAT",
                        "sim/flightmodel/position/theta", "FLOAT",
						'sim/cockpit2/autopilot/flight_director_mode','INT',
						'sim/cockpit2/autopilot/flight_director_roll_deg', 'FLOAT',
						'sim/cockpit2/autopilot/flight_director_pitch_deg','FLOAT',
						attitude)


-- ASI
--TODO trend vector pg.72
--TODO airspeed color changes pg.72
--TODO vspeed references pg.73
asiOnes_dx = 61
asiOnes_dy = -200
asiTens_dx = 41
asiTens_dy = -200
asiHundreds_dx = 21
asiHundreds_dy = -200
asiTape_dx = 21
asiTape_dy = -1774 

img_asiTape = img_add('g3xASItape.png',asiTape_dx,asiTape_dy,76,1944)
img_asiMask= img_add("ASImask.png",0,71,97,338)
--TODO break out the digital mask so it can be swapped with red

img_asiOnes = img_add("LargeDigits.png",asiOnes_dx,asiOnes_dy,18,492)
img_asiTens = img_add("LargeDigits.png",asiTens_dx,asiTens_dy,18,492)
img_asiHundreds = img_add("LargeDigits.png",asiHundreds_dx,asiHundreds_dy,18,492)

txt_tas = txt_add("", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:right;", 25, 378, 50, 30)
txt_white_KT = txt_add("KT", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:12px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:right;", 70, 388, 20, 30)
txt_gs = txt_add("", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: magenta; -fx-font-weight:bold; -fx-text-alignment:right;", 25, 70, 50, 30)
txt_magenta_KT = txt_add("KT", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:12px; -fx-fill: magenta; -fx-font-weight:bold; -fx-text-alignment:right;", 70, 80, 20, 30)

viewport_rect(img_asiOnes,60,206,18,67)
viewport_rect(img_asiTens,40,222,18,35) 
viewport_rect(img_asiHundreds,20,222,18,35)
viewport_rect(img_asiTape,0,104,96,272)

--heading
headingTape_dx = -35
headingTape_dy = 47
trackBug_dx = 235
trackBug_dy = 65
turnRateRight_dx = 120
turnRateLeft_dx = 240
img_headingTape = img_add('headingTape.png',headingTape_dx,headingTape_dy,2350,24)
img_headingBug = img_add('headingBug.png',0,0,480,71)
img_trackBug = img_add('trackBug.png',trackBug_dx,trackBug_dy,11,6)
img_turnRateR = img_add('turnRate.png',turnRateRight_dx,35,120,12)
img_turnRateL = img_add('turnRate.png',turnRateLeft_dx,35,120,12)
img_turnRateArrowL = img_add('turnRateArrow.png',turnRateRight_dx-11,35,11,12)
img_turnRateArrowR = img_add('turnRateArrow.png',turnRateLeft_dx + 120,35,11,12)
img_rotate(img_turnRateArrowR,180)
img_headingMask = img_add('headingMask.png',0,0,480,71)
txt_heading = txt_add("000", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:right;", 221, 32, 37, 23)
--txt_track = txt_add("TRACK", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:right;", 240, 400, 37, 23)
viewport_rect(img_turnRateR,240,35,120,12)
viewport_rect(img_turnRateL,120,35,120,12)
function airspeed_heading_track(asi,mach,oat,groundspeed,heading,turnRate,hbug,windSpeed,windDir)
    
	--TODO put in nifty rolling animation for tens and 100s
	local number_scale = 350/9
	local tape_scale = 1924/480
	local turnRateScale = 90/20
	asi = var_cap(asi,0,500)
	local hundreds = math.floor(asi/100)
	local tens = math.floor(asi%100/10)
	local ones = asi%100%10
	tas = 661.47 * mach * math.sqrt((oat + 273.15) / 288.15)
	--print('asi',hundreds,tens,ones)
	move(img_asiOnes,nil,asiOnes_dy + (ones * number_scale),nil,nil)
	move(img_asiTens,nil,asiTens_dy + (tens * number_scale),nil,nil)
	move(img_asiHundreds,nil,asiHundreds_dy + (hundreds * number_scale),nil,nil)
	move(img_asiTape,nil,asiTape_dy + (asi * tape_scale)  ,nil,nil)
	txt_set(txt_tas,string.format("%i",tas))
--	txt_set(txt_tas,string.format("%i",math.floor(tas*1.94384)))
	txt_set(txt_gs,string.format("%i",math.floor(groundspeed*1.94384))  )
	--heading and track
	track = calculateTrack(windDir,windSpeed,heading,tas)
	local headingTapeScale = -5
	move(img_headingTape,headingTape_dx + (heading * headingTapeScale),nil,nil,nil)
	move(img_trackBug,trackBug_dx + ((heading-track) * headingTapeScale),nil,nil,nil) 
	move(img_headingBug,var_cap((heading - hbug),-47,47)*headingTapeScale,nil,nil,nil)
	txt_set(txt_heading,string.format("%03d",math.floor(heading+.5)))
	visible(img_turnRateArrowR, turnRate>26.67)
	visible(img_turnRateArrowL,turnRate < -26.67)
	if math.abs(turnRate)>26.67 then
		turnRate=var_cap(turnRate,-26.67,26.67)
	end
	move(img_turnRateR,turnRateRight_dx + (turnRate * turnRateScale),nil,nil,nil)
	move(img_turnRateL,turnRateLeft_dx + (turnRate * turnRateScale),nil,nil,nil)
	--txt_set(txt_track,string.format("%d",math.floor(track + .5)))
	
end

xpl_dataref_subscribe("sim/cockpit2/gauges/indicators/airspeed_kts_pilot", "FLOAT",
						"sim/flightmodel/misc/machno","FLOAT",
						"sim/cockpit2/temperature/outside_air_temp_degc", "FLOAT",
--						"sim/flightmodel/position/true_airspeed","FLOAT",
						"sim/flightmodel/position/groundspeed", "FLOAT",
						'sim/cockpit2/gauges/indicators/heading_AHARS_deg_mag_pilot','FLOAT',
						'sim/flightmodel/misc/turnrate_noroll','FLOAT',
						'sim/cockpit/autopilot/heading_mag', 'FLOAT',
						'sim/cockpit2/gauges/indicators/wind_speed_kts', "FLOAT",
						'sim/cockpit2/gauges/indicators/wind_heading_deg_mag','FLOAT',airspeed_heading_track)

-- Alt
--TODO alt bug should stick to ends of tape if off screen alt or not defined
--TODO baro minumum bar
--research altitude alerting
altTT_dx = 372
altTT_dy = -200
altT_dx = 390
altT_dy =  -200
altH_dx = 410
altH_dy = -97
altTw_dx = 426
altTw_dy = 83
altBug_dx = 358
altBug_dy = 222
 
altTape_dx = 357
altTape_dy = -969

img_altTape0 = img_add("AltTape0.png",altTape_dx,altTape_dy,72,1208)
img_altTape1 = img_add("AltTape1.png",altTape_dx,altTape_dy,65,1208)
img_altTape2 = img_add("AltTape2.png",altTape_dx,altTape_dy,65,1208)
img_altTape3 = img_add("AltTape3.png",altTape_dx,altTape_dy,65,1208)
img_altTape4 = img_add("AltTape4.png",altTape_dx,altTape_dy,65,1208)
img_altTape5 = img_add("AltTape5.png",altTape_dx,altTape_dy,65,1208)
img_altTape6 = img_add("AltTape6.png",altTape_dx,altTape_dy,65,1208)
img_altTape7 = img_add("AltTape7.png",altTape_dx,altTape_dy,65,1208)
img_altTape8 = img_add("AltTape8.png",altTape_dx,altTape_dy,65,1208)
img_altTape9 = img_add("AltTape9.png",altTape_dx,altTape_dy,65,1208)
img_altTape10 = img_add("AltTape10.png",altTape_dx,altTape_dy,65,1208)
img_altTape11 = img_add("AltTape11.png",altTape_dx,altTape_dy,65,1208)
img_altTape12 = img_add("AltTape12.png",altTape_dx,altTape_dy,65,1208)
img_altTape13 = img_add("AltTape13.png",altTape_dx,altTape_dy,65,1208)
img_altTape14 = img_add("AltTape14.png",altTape_dx,altTape_dy,65,1208)
img_altTape15 = img_add("AltTape15.png",altTape_dx,altTape_dy,65,1208)


img_altMask = img_add("altMask.png", 357,71,123,338)
img_altBugIcon = img_add("altBug.png",360,77,7,18)
img_altBug = img_add("altBug.png",altBug_dx,altBug_dy,11,36)
txt_altBug = txt_add("____", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: cyan; -fx-font-weight:bold; -fx-text-alignment:right;", 385, 70, 61, 30)
txt_FT = txt_add("FT", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:12px; -fx-fill: cyan; -fx-font-weight:bold; -fx-text-alignment:right;", 440, 80, 20, 30)
txt_baro = txt_add("29.92", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: cyan; -fx-font-weight:bold; -fx-text-alignment:right;", 385, 378, 61, 30)
txt_IN = txt_add("IN", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:12px; -fx-fill: cyan; -fx-font-weight:bold; -fx-text-alignment:right;", 440, 388, 20, 30)

img_altTT = img_add("LargeDigits.png",altTT_dx,altTT_dy,18,492)
img_altT = img_add("LargeDigits.png",altT_dx,altT_dy,18,492)
img_altH = img_add("AltHundreds.png",altH_dx,altH_dy,14,378)
img_alt20s = img_add("AltTwenties.png",altTw_dx,altTw_dy,27,197)
viewport_rect(img_altTape0,357,104,122,272)
viewport_rect(img_altTape1,357,104,122,272)
viewport_rect(img_altTape2,357,104,122,272)
viewport_rect(img_altTape3,357,104,122,272)
viewport_rect(img_altTape4,357,104,122,272)
viewport_rect(img_altTape5,357,104,122,272)
viewport_rect(img_altTape6,357,104,122,272)
viewport_rect(img_altTape7,357,104,122,272)
viewport_rect(img_altTape8,357,104,122,272)
viewport_rect(img_altTape9,357,104,122,272)
viewport_rect(img_altTape10,357,104,122,272)
viewport_rect(img_altTape11,357,104,122,272)
viewport_rect(img_altTape12,357,104,122,272)
viewport_rect(img_altTape13,357,104,122,272)
viewport_rect(img_altTape14,357,104,122,272)
viewport_rect(img_altTape15,357,104,122,272)
viewport_rect(img_altTT,371,222,18,35)
viewport_rect(img_altT,391,222,18,35)
viewport_rect(img_altH,411,222,13,35)
viewport_rect(img_alt20s,424,212,28,56)
viewport_rect(img_altBug,357,104,12,272)

function altitudeTape(alt,baro,altBug)
--TODO need smoother transition on alt wheels..they can read low when just a bit below alt.
-- e.g 8499.999 is reading 8400 instead of 85
	local altBug = var_cap(altBug,-1000,30000)
	local tape_scale = 12/20
	local bigAlt_scale = 350/9
	local smlAlt_scale = 299/10
	local tens_scale = 149/100
	local tenThousands = math.floor(alt/10000)
	local thousands = math.floor(alt%10000/1000)
	local hundreds = math.floor(alt%10000%1000/100)
	local tens = math.floor(alt%10000%1000%100)
	--print('alt',tenThousands,thousands,hundreds,tens)
	
	move(img_altTape0,nil, 1*1200 + altTape_dy + (alt * tape_scale), nil, nil)
	move(img_altTape1,nil, 0*1208 + altTape_dy + (alt * tape_scale), nil, nil)
	move(img_altTape2,nil,-1*1200 + altTape_dy + (alt * tape_scale), nil, nil)
	move(img_altTape3,nil,-2*1200 + altTape_dy + (alt * tape_scale), nil, nil)
	move(img_altTape4,nil,-3*1200 + altTape_dy + (alt * tape_scale), nil, nil)
	move(img_altTape5,nil,-4*1200 + altTape_dy + (alt * tape_scale), nil, nil)
	move(img_altTape6,nil,-5*1200 + altTape_dy + (alt * tape_scale), nil, nil)
	move(img_altTape7,nil,-6*1200 + altTape_dy + (alt * tape_scale), nil, nil)
	move(img_altTape8,nil,-7*1200 + altTape_dy + (alt * tape_scale), nil, nil)
	move(img_altTape9,nil,-8*1200 + altTape_dy + (alt * tape_scale), nil, nil)
	move(img_altTape10,nil,-9*1200 + altTape_dy + (alt * tape_scale), nil, nil)
	move(img_altTape11,nil,-10*1200 + altTape_dy + (alt * tape_scale), nil, nil)
	move(img_altTape12,nil,-11*1200 + altTape_dy + (alt * tape_scale), nil, nil)
	move(img_altTape13,nil,-12*1200 + altTape_dy + (alt * tape_scale), nil, nil)
	move(img_altTape14,nil,-13*1200 + altTape_dy + (alt * tape_scale), nil, nil)
	move(img_altTape15,nil,-14*1200 + altTape_dy + (alt * tape_scale), nil, nil)
	move(img_altTT,nil,altTT_dy + (tenThousands * bigAlt_scale), nil, nil)
	move(img_altT,nil,altT_dy + (thousands * bigAlt_scale), nil, nil)
	move(img_altH,nil,altH_dy + (hundreds * smlAlt_scale), nil,nil)
	move(img_alt20s,nil,altTw_dy + (tens * tens_scale), nil, nil)
	txt_set(txt_altBug,(string.format("%i",altBug)))
	txt_set(txt_baro,(string.format("%.2f",baro)))
	move(img_altBug,nil, altBug_dy + ((alt-altBug)*tape_scale),nil,nil)
end

xpl_dataref_subscribe("sim/cockpit2/gauges/indicators/altitude_ft_pilot", "FLOAT",
			            "sim/cockpit/misc/barometer_setting", "FLOAT",
			            "sim/cockpit/autopilot/altitude", "FLOAT", altitudeTape)		
						
--VSI

vsiPointer_dx = 461
vsiPointer_dy = 232
vsiBar_dx = 473
vsiBar_dy = 240
img_vsiBarPos = img_add('vsiBar.png',vsiBar_dx,vsiBar_dy,6,130)
img_vsiBarNeg = img_add('vsiBar.png',vsiBar_dx,vsiBar_dy-130,6,130)
if use6kVSI then
	img_vsiTape = img_add("vsiTape6k.png",454,105,26,272)
else 
	img_vsiTape = img_add("vsiTape2k.png",454,105,26,272)
end

img_vsiPointer = img_add('vsiPointer.png',461,232,19,17)
viewport_rect(img_vsiBarPos,vsiBar_dx,vsiBar_dy-130,11,125)
viewport_rect(img_vsiBarNeg,vsiBar_dx,vsiBar_dy,11,125)



function verticalSpeedIndicator(vsi)
	local displacement = 0
	if use6kVSI then
		
		if math.abs(vsi) < 500 then -- should be 500 for low scale
			--print('500 scale')
			if vsi > 0 then
				displacement = vsiPointer_dy - (vsi* 49/500 )
			else 
				--print('negative vs')
				displacement = vsiPointer_dy + (math.abs(vsi)* 49/500 )
				--print (displacement)
			end

		elseif math.abs(vsi) < 1000 then -- 68 is 1000 
			if vsi > 0 then
				displacement = vsiPointer_dy  - 49 - ((vsi-500) * 19/500)
			else
				displacement = vsiPointer_dy  + 49 + ((math.abs(vsi)-500) * 19/500)
			end
			--displacement = vsiPointer_dy - vsi
		elseif math.abs(vsi) < 2000 then -- 87 is 2000
			if vsi > 0 then
				displacement = vsiPointer_dy  - 68 - ((vsi-1000) * 19/1000)
			else 
				displacement = vsiPointer_dy  + 68 + ((math.abs(vsi)-1000) * 19/1000)
			--displacement = vsiPointer_dy - vsi
			end
			
		else -- 129 is 6000
			if vsi > 0 then
				displacement = vsiPointer_dy  - 87 - ((vsi-2000) * 42/4000)
			else 
				displacement = vsiPointer_dy  + 87 + ((math.abs(vsi)-2000) * 42/4000)
			--displacement = vsiPointer_dy - vsi
			end
		end
		move(img_vsiPointer,nil,displacement,nil,nil)
		move(img_vsiBarPos,nil,displacement+8,nil,nil)
		move(img_vsiBarNeg,nil,displacement+8-130,nil,nil)
	
	else
		local sensitivity = 1000
		--print ('vsi',vsi)
		local vsi_scaleLow = -98/sensitivity
		local vsi_scaleHigh = -31/sensitivity
		local highOffset = -98
		local vsi = var_cap(vsi,-2000,2000)
		local vsi_displacement = 0
		if (-sensitivity < vsi) and (vsi < sensitivity) then 
			--print('low')
			vsi_displacement = vsiPointer_dy + (vsi * vsi_scaleLow)
			--move(img_vsiPointer,nil,vsiPointer_dy + (vsi * vsi_scaleLow),nil,nil)
		else
			--print('high')
			if (vsi > 0) then
				vsi_displacement = vsiPointer_dy + highOffset + ((vsi - sensitivity) * vsi_scaleHigh)
				--move(img_vsiPointer,nil,vsiPointer_dy + highOffset + ((vsi - sensitivity) * vsi_scaleHigh),nil,nil)
			else
				vsi_displacement = vsiPointer_dy - highOffset + ((vsi + sensitivity) * vsi_scaleHigh)
				--move(img_vsiPointer,nil,vsiPointer_dy - highOffset + ((vsi + sensitivity) * vsi_scaleHigh),nil,nil)
			end	
		end
		move(img_vsiPointer,nil,vsi_displacement,nil,nil)
		move(img_vsiBarPos,nil,vsi_displacement+8,nil,nil)
		move(img_vsiBarNeg,nil,vsi_displacement+8-130,nil,nil)
	end
	
end

xpl_dataref_subscribe('sim/cockpit2/gauges/indicators/vvi_fpm_pilot','FLOAT',verticalSpeedIndicator)

--TODO slip Skid indicator pg.74
--Slip Indicator
slipBall_dx = 227
img_slipMask = img_add('slipMask.png',152,340,176,30)
img_slipBall = img_add('slipBall.png',227,342,25,25)

function skidIndicator(slip)
	local slipRatio = -5
	move(img_slipBall,slipBall_dx + (slip * slipRatio),nil,nil,nil)
end

xpl_dataref_subscribe('sim/cockpit2/gauges/indicators/slip_deg','FLOAT',skidIndicator)

--HSI section
--TODO fix color differences in NAV
--TODO add to/from on HSI card
--TODO add bearing pointers
--TODO add fields for heading and course

cdiNeedle_dx = 233
vnavDiamond_dy = 235
img_hsiCard = img_add('hsiCard.png',80,451,319,319)
img_cdiMask = img_add('cdiMask.png',130,376,222,22)
img_vnavMask = img_add('vnavMask.png',335,109,22,242)
img_vnavDiamondGPS = img_add('vnavDiamondGPS.png',340,vnavDiamond_dy,12,12)
img_vnavDiamondNAV = img_add('vnavDiamondNAV.png',340,vnavDiamond_dy,11,11)
img_cdiNeedleGPS = img_add('cdiNeedleGPS.png',cdiNeedle_dx,381,16,13)
img_cdiNeedleNAV = img_add('cdiNeedleNav.png',cdiNeedle_dx,381,16,13)
txt_GPS = txt_add("GPS", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: magenta; -fx-font-weight:bold; -fx-text-alignment:right;", 160, 550, 50, 30)
txt_NAV1 = txt_add("NAV1", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: green; -fx-font-weight:bold; -fx-text-alignment:right;", 160, 550, 60, 30)
txt_NAV2 = txt_add("NAV2", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: green; -fx-font-weight:bold; -fx-text-alignment:right;", 160, 550, 61, 30)
--txt_NM = txt_add("NM", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:12px; -fx-fill: magenta; -fx-font-weight:bold; -fx-text-alignment:right;", 297, 560, 21, 30)
txt_vnavGPS = txt_add("G", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:18px; -fx-fill: magenta; -fx-font-weight:bold; -fx-text-alignment:right;", 339, 108, 12, 30)
txt_vnavNAV = txt_add("G", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:18px; -fx-fill: green; -fx-font-weight:bold; -fx-text-alignment:right;", 339, 108, 12, 30)
img_hsiDrift = img_add('hsiDriftLine.png',70,441,339,339)
img_courseLineGPS = img_add('courseLineGPS.png',80,451,319,319)
img_courseLineNAV1 = img_add('courseLineNAV1.png',80,451,319,319)
img_courseLineNAV2 = img_add('courseLineNAV2.png',80,451,319,319)
img_cdiGPS = img_add('cdiGPS.png',80,451,319,319)
img_cdiNAV1 = img_add('cdiNAV1.png',80,451,319,319)
img_cdiNAV2 = img_add('cdiNAV2.png',80,451,319,319)
img_hsiReference = img_add('hsiReference.png',57,417,366,324)
img_hsiHeadingBug = img_add('hsiHeadingBug.png',70,441,339,339)

function hsi_callback(heading,hBug,course,hdef,vdef,toFrom,isVerticalSignal,navSource)
	
	visible(img_vnavMask,isVerticalSignal)
	
	visible(img_vnavDiamondGPS,isVerticalSignal==1 and navSource==2)
	visible(txt_vnavGPS, isVerticalSignal==1 and navSource==2)
	
	visible(img_vnavDiamondNAV,isVerticalSignal ==1 and navSource <2)
	visible(txt_vnavNAV, isVerticalSignal==1 and navSource <2)
	visible(img_courseLineNAV2, navSource ==0)
	visible(img_cdiNAV2, navSource ==0)
	visible(txt_NAV2,navSource ==0)
	
	visible(img_courseLineNAV1, navSource ==1)
	visible(img_cdiNAV1, navSource ==1)
	visible(txt_NAV1,navSource ==1)
	
	visible(img_courseLineGPS, navSource ==2)
	visible(img_cdiGPS, navSource ==2)
	visible(txt_GPS,navSource ==2)
	visible(img_cdiNeedleGPS,navSource==2)

	visible(img_cdiNeedleNAV,navSource <2)
	
	
	img_rotate(img_hsiCard,-heading)
	img_rotate(img_courseLineNAV1,course-heading)
	img_rotate(img_courseLineNAV2,course-heading)
	img_rotate(img_courseLineGPS,course-heading)
	local dh = hdef  * math.cos((course-heading)*math.pi/180)* 39 -- 41 : distance in pixels between 2 dots
    local dv = hdef * math.sin((course-heading)*math.pi/180)* 39 
	move(img_cdiGPS,80 + dh,451 + dv,nil,nil)
	move(img_cdiNAV1,80 + dh,451 + dv,nil,nil)
	move(img_cdiNAV2,80 + dh,451 + dv,nil,nil)
	move(img_cdiNeedleGPS, cdiNeedle_dx + (hdef * 43),nil,nil,nil)
	move(img_cdiNeedleNAV, cdiNeedle_dx + (hdef * 43),nil,nil,nil)
	move(img_vnavDiamondGPS,nil,vnavDiamond_dy + (vdef * 43),nil,nil)
	move(img_vnavDiamondNAV,nil,vnavDiamond_dy + (vdef * 43),nil,nil)
	img_rotate(img_cdiNAV1, course-heading)
	img_rotate(img_cdiNAV2, course-heading)
	img_rotate(img_cdiGPS, course-heading)
	img_rotate(img_hsiDrift,-(heading - track))
	img_rotate(img_hsiHeadingBug,-(heading - hBug))
	if toFrom ==1 then
		img_rotate(img_cdiNeedleGPS,0)
		img_rotate(img_cdiNeedleNAV,0)
	elseif toFrom ==2 then
		img_rotate(img_cdiNeedleGPS,180)
		img_rotate(img_cdiNeedleNAV,180)
	end
end

xpl_dataref_subscribe('sim/cockpit2/gauges/indicators/heading_AHARS_deg_mag_pilot','FLOAT',
	'sim/cockpit/autopilot/heading_mag', 'FLOAT',
	'sim/cockpit2/radios/actuators/hsi_obs_deg_mag_pilot','FLOAT',
	'sim/cockpit2/radios/indicators/hsi_hdef_dots_pilot', 'FLOAT',
	'sim/cockpit2/radios/indicators/hsi_vdef_dots_pilot', 'FLOAT',
	'sim/cockpit2/radios/indicators/hsi_flag_from_to_pilot','INT',
	'sim/cockpit2/radios/indicators/hsi_display_vertical_pilot','INT',
	'sim/cockpit/switches/HSI_selector','INT',hsi_callback)


--header info strip
time_first_dx = 400
time_second_dx = 433

time_min_dx = 430
txt_wptLbl = txt_add("WPT", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:14px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:left;", 5, 10, 31, 30)
txt_brgLbl = txt_add("BRG", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:14px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:left;", 120, 10, 31, 30)
txt_dstLbl = txt_add("DST", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:14px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:left;", 240, 10, 31, 30)
txt_eteLbl = txt_add("ETE", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:14px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:left;", 360, 10, 31, 30)

txt_curWpt = txt_add("XXXX", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: magenta; -fx-font-weight:bold; -fx-text-alignment:left;", 40, 3, 70, 30)
txt_bearingWpt = txt_add("000", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: magenta; -fx-font-weight:bold; -fx-text-alignment:left;", 160, 3, 60, 30)
txt_distanceWpt = txt_add("000.0", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: magenta; -fx-font-weight:bold; -fx-text-alignment:left;", 280, 3, 60, 30)
--txt_eteInf = txt_add("__:__", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: magenta; -fx-font-weight:bold; -fx-text-alignment:left;", 400, 3, 60, 30)
txt_timeFirst = txt_add("00:", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: magenta; -fx-font-weight:bold; -fx-text-alignment:right;", time_first_dx, 3, 33, 30)
txt_timeSecondLarge = txt_add("00", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: magenta; -fx-font-weight:bold; -fx-text-alignment:left;", time_second_dx, 3, 30, 30)
txt_timeSecondSmall = txt_add("00", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:14px; -fx-fill: magenta; -fx-font-weight:bold; -fx-text-alignment:left;", time_second_dx, 10, 30, 30)
function headerStrip(wpt,bearing,distance,ete)

	local timeFirstValue = 0
	local timeSecondValue = 0
	
	
	-- distance should only show tenths if less than 100
	if distance > 100 then
		distance = var_round(distance,0)
	else distance = var_round(distance,1)
	end
	
	-- if were stopped time will return infinite so replace it with blank
	--print('ete',ete)
	if ete == math.huge then
		visible(txt_timeSecondLarge,1)
		visible(txt_timeSecondSmall,0)
		timeFirstValue = '__:'
		timeSecondValue = '__'
		txt_set(txt_timeFirst,timeFirstValue)
		txt_set(txt_timeSecondLarge,timeSecondValue)
	else
		if ete >=60 then
			visible(txt_timeSecondLarge,1)
			visible(txt_timeSecondSmall,0)
			timeFirstValue = math.floor(ete/60)
			--print('hours',timeFirstValue)
			timeSecondValue = var_round(ete%60)
			--print('minutes',timeSecondValue)
		else
			visible(txt_timeSecondLarge,0)
			visible(txt_timeSecondSmall,1)
			timeFirstValue = math.floor(ete)
			timeSecondValue = var_round((ete%1 *60))
			--print('Minutes', timeFirstValue)
			--print('Seconds', timeSecondValue)
		
		end
		txt_set(txt_timeFirst,string.format('%02d:',timeFirstValue))
		txt_set(txt_timeSecondLarge,string.format('%02d',timeSecondValue))
		txt_set(txt_timeSecondSmall,string.format('%02d',timeSecondValue))
	end
	
	--txt_set(txt_timeWpt,ete)
	
	txt_set(txt_curWpt,wpt)
	txt_set(txt_distanceWpt,distance)
	txt_set(txt_bearingWpt,var_round(bearing,0))
	
end


xpl_dataref_subscribe('whartsell/g3x/current_wpt','STRING',
	'sim/cockpit2/radios/indicators/gps_bearing_deg_mag','FLOAT',
	'sim/cockpit2/radios/indicators/gps_dme_distance_nm','FLOAT',
	'sim/cockpit2/radios/indicators/gps_dme_time_min','FLOAT',headerStrip)

	
--SoftKeys and Display
img_softKeyMask = img_add('softKeyMask.png',0,775,480,25)
img_invSoftKeys = {}
txt_softKeys = {}
txt_softKeys_Inv = {}
img_invSoftKeys[1] = img_add('invertedSoftKey.png',1,776,94,23)
img_invSoftKeys[2] = img_add('invertedSoftKey.png',96+1,776,94,23)
img_invSoftKeys[3] = img_add('invertedSoftKey.png',96*2+1,776,94,23)
img_invSoftKeys[4] = img_add('invertedSoftKey.png',96*3+1,776,94,23)
img_invSoftKeys[5] = img_add('invertedSoftKey.png',96*4+1,776,94,23)
txt_softKeys[1] = txt_add("KEY 1", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:center;", 0, 771, 96, 25)
txt_softKeys[2] = txt_add("KEY 2", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:center;", 96, 771, 96, 25)
txt_softKeys[3] = txt_add("KEY 3", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:center;", 96*2, 771, 96, 25)
txt_softKeys[4] = txt_add("KEY 4", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:center;", 96*3, 771, 96, 25)
txt_softKeys[5] = txt_add("KEY 5", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:center;", 96*4, 771, 96, 25)	

txt_softKeys_Inv[1] = txt_add("KEY 1", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: black; -fx-font-weight:bold; -fx-text-alignment:center;", 0, 771, 96, 25)
txt_softKeys_Inv[2] = txt_add("KEY 2", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: black; -fx-font-weight:bold; -fx-text-alignment:center;", 96, 771, 96, 25)
txt_softKeys_Inv[3] = txt_add("KEY 3", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: black; -fx-font-weight:bold; -fx-text-alignment:center;", 96*2, 771, 96, 25)
txt_softKeys_Inv[4] = txt_add("KEY 4", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: black; -fx-font-weight:bold; -fx-text-alignment:center;", 96*3, 771, 96, 25)
txt_softKeys_Inv[5] = txt_add("KEY 5", "-fx-font-family:FuturaCondensedMedium; -fx-font-size:21px; -fx-fill: black; -fx-font-weight:bold; -fx-text-alignment:center;", 96*4, 771, 96, 25)	

function setVisibleTable(aTable,isVisible)
	for key,value in ipairs(aTable) do
		visible(aTable[key],isVisible)
	end
end

setVisibleTable(img_invSoftKeys,0)
setVisibleTable(txt_softKeys_Inv,0)


function softKeyHandler(softKeys)
	for key,value in pairs(softKeys) do
		if value == 1 then
			print("button", key , "pressed")
		end
	end
end


xpl_dataref_subscribe('whartsell/g3x/softKeys','INT[5]',
	softKeyHandler)

				