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
	
	--Timecycle modifier to use for screen effect:
	--	https://wiki.rage.mp/index.php?title=Timecycle_Modifiers
	config.tcmEffect = "dying"
	
	--The timecycle modifier index to check for:
	--	First set the config.tcmEffect then start the resource
	--	and read the index from the client console and insert it here.
	config.tcmIndex = 60

	--Maximum effect strength:
	config.maxeffectstrength = 0.9
	

-------------------------------------------------------------------------------------------------------------
	--STATIC HEALTH INDICATOR
-------------------------------------------------------------------------------------------------------------
	
	--At what percantage of health (minus deadhealth*) should the static effect start? (0.0 - 1.0):
	config.percentagestaticeffecthealthfraction = 1.0
	
	--Effect strength multiplier for static health indicator:
	config.staticindicatorstrengthmultiplier = 0.1
	
	
-------------------------------------------------------------------------------------------------------------
	--ACCUTE / IMPACT DAMAGE INDICATOR
-------------------------------------------------------------------------------------------------------------
	
	--At what percantage of health (minus deadhealth*) should impact effects start? (0.0 - 1.0):
	config.percentageimpacteffecthealthfraction = 1.0
	
	--Adds a screeneffect ontop of the bloody edges.
	config.impacteffectboosteffect = false
	
	--Effect strength multiplier for damage impacts:
	config.impacteffectstrengthmultiplier = 18.0

	--Value between 0.0 and 1.0 for how fast the screen effect fades away after a damage impact:
	config.accutedamagerecoveryrate = 0.02


-------------------------------------------------------------------------------------------------------------
	--PULSATING SCREENEFFECT
-------------------------------------------------------------------------------------------------------------

	--At what percantage of health (minus deadhealth*) should the pulsating effect start? (0.0 - 1.0):
	config.percentagepulsatingeffecthealthfraction = 0.49
	
	--Adds a screeneffect ontop of the bloody edges:
	config.pulsatingboosteffect = true
	
	-- At what percentage the screeneffect starts playing:
	config.effectthreshold = 0.3
	
	--Variable interval for pulse indicator depending on health. (lower value -> faster):
	config.minpulseinterval = 30
	config.maxpulseinterval = 133

	--Effect strength multiplier for pulsating effect:
	config.pulsatingmultiplier = 0.5
	
	--Heartbeat audio when screen is pulsating:
	config.pulsatingheartbeataudio = true
	
	--Heartbeat volume:
	config.pulsatingheartbeatvolume = 0.8
	
	--Pulse recovery rate multiplier:
	config.pulserecoveryratemultiplier = 1.5
	
	
-- *: Players usally die at a health below 100, not 0. That value is subtracted in the code to get a better relative 
--    value towards the maximum health.


-------------------------------------------------------------------------------------------------------------
	--END CONFIG--
-------------------------------------------------------------------------------------------------------------
config.initialized = true