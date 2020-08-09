-------------------------------------------------------------------------------------------------------------
	--CONFIG--
-------------------------------------------------------------------------------------------------------------
config = {}

	--Pulsating screeneffect as a permanent health indicator:
	config.activatepulsatingindicator = true
	--Accute health indicator:
	config.activateaccutehealthindicator = true
	
	--Static screeneffect as a permanent health indicator:
	config.activatestatichealthindicator = true

	--Maximum effect strength:
	config.maxeffectstrength = 10.0
	

-------------------------------------------------------------------------------------------------------------
	--STATIC HEALTH INDICATOR
-------------------------------------------------------------------------------------------------------------
	
	--Effect strength multiplier for static health indicator:
	config.staticindicatorstrengthmultiplier = 0.32
	
	
-------------------------------------------------------------------------------------------------------------
	--ACCUTE / IMPACT DAMAGE INDICATOR
-------------------------------------------------------------------------------------------------------------
	
	--Effect strength multiplier for damage impacts:
	config.impacteffectstrengthmultiplier = 14.0

	--Value between 0.0 and 1.0 for how fast the screen effect fades away after a damage impact:
	config.accutedamagerecoveryrate = 0.01


-------------------------------------------------------------------------------------------------------------
	--PULSATING SCREENEFFECT
-------------------------------------------------------------------------------------------------------------

	--At what percantage of health (minus deadhealth*) should the pulsating effect start? (0.0 - 1.0):
	config.percentagepulsatingeffecthealthfraction = 0.49
	
	--Variable interval for pulse indicator depending on health. (lower value -> faster):
	config.minpulseinterval = 35
	config.maxpulseinterval = 133

	--Effect strength multiplier for pulsating effect:
	config.pulsatingmultiplier = 0.3
	
	--Pulse recovery rate multiplier:
	config.pulserecoveryratemultiplier = 2.0
	
	
-- *: Players usally die at a health below 100, not 0. That value is subtracted in the code to get a better relative 
--    value towards the maximum health.


-------------------------------------------------------------------------------------------------------------
	--END CONFIG--
-------------------------------------------------------------------------------------------------------------
config.initialized = true