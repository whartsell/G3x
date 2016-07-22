
-- GDU37x is the PFD/MFD so all data that should be derived from it should be contained here
GDU37X = SimData:new()

--This will be the container for nav data..name will most likely be changed
NAV = SimData:new()

-- The GSU25 is the ADAHRS Air Data Computer and the Attitude and Heading Reference System
-- all data derived by the GSU25 should be contained here
--TODO calculate TAS in GSU25
GSU25 = SimData:new()

-- The GEA24 is the EIS Engine Information System so all EIS data will be contained here
GEA24 = SimData:new()

-- The GAD 29 is the AirInc interface to nav equipment e.g external NAV/Com, GTN/GNS 
GAD29 = SimData:new()