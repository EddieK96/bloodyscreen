Citizen.CreateThread(function()
	pulsating = {}
	pulsating.pulsestrength = 0.0
	pulsating.pulserecoveryrate = 0.0
	pulsating.initialized = true
	pulsating.boosteffect = false
	
	while config == nil or config.initialized == nil do
		Citizen.Wait(0)
	end
	
	local audioplaying = false
	local pulsatingheartbeataudio = config.pulsatingheartbeataudio
	local pulsatingheartbeatvolume = config.pulsatingheartbeatvolume
	local activatepulsatingindicator = config.activatepulsatingindicator
	local percentagepulsatingeffecthealthfraction = config.percentagepulsatingeffecthealthfraction
	local minpulseinterval = config.minpulseinterval
	local maxpulseinterval = config.maxpulseinterval
	local pulsatingmultiplier = config.pulsatingmultiplier
	local pulse = 0
	local pulseinterval = 85
	local maxminusminpulseinterval = maxpulseinterval - minpulseinterval
	
	local function playAudio ()
		if pulsatingheartbeataudio and not audioplaying then	
			SendNUIMessage({
					type = "play",
					status = pulsatingheartbeatvolume
			})
			audioplaying = true
		end
	end
	
	local function pauseAudio ()
		if pulsatingheartbeataudio and audioplaying then	
			SendNUIMessage({
				type = "fadeOutAudio",
				status = true
			})	
			audioplaying = false
		end
	end	
	
	while main == nil or main.initialized == nil do
		Citizen.Wait(0)
	end
	
	local currenthealthfraction = main.currenthealthfraction
	local updateRunning = false
	local function updateAudio ()
		if audioplaying and not updateRunning then
			updateRunning = true
			Citizen.SetTimeout(10, function ()
				local volume = (1.0 - (2.0 * currenthealthfraction)) * pulsatingheartbeatvolume
				if volume < 0.0 then
					volume = 0.0
				end
				SendNUIMessage({
					type = "updateVolume",
					status = volume
				})	
				local bps = 2.0 - (currenthealthfraction * 2.25)
				if bps < 0.9 then
					bps = 0.9
				end
				SendNUIMessage({
					type = "updatePlaybackSpeed",
					status = bps
				})	
				updateRunning = false
			end)							
		end
	end

	if activatepulsatingindicator then
		while true do
			Citizen.Wait(1)
			lasthealthfraction = main.lasthealthfraction
			currenthealthfraction = main.currenthealthfraction
			pulseinterval = minpulseinterval + (maxminusminpulseinterval * currenthealthfraction) 
			pulse = pulse + 1 
			
			if main.currenthealthfraction <= percentagepulsatingeffecthealthfraction and not IsPlayerDead(PlayerId()) then
				updateAudio()
			end
			
			if pulse >= pulseinterval and main.strengthapplied then 
				if main.currenthealthfraction <= percentagepulsatingeffecthealthfraction and not IsPlayerDead(PlayerId()) then 
					if config.pulsatingboosteffect and (main.currenthealthfraction <= config.effectthreshold) then
						pulsating.boosteffect = true
					else
						pulsating.boosteffect = false
					end		
					playAudio()	
					pulsating.pulsestrength = pulsatingmultiplier * (1.0 - currenthealthfraction) 
					main.strengthapplied = false 
				else
					pauseAudio()
					if config.pulsatingboosteffect then
						pulsating.boosteffect = false
					end
				end 
				pulsating.pulserecoveryrate = config.pulserecoveryratemultiplier * (pulsating.pulsestrength / pulseinterval) 
				pulse = 0 			
			else 
				if main.strengthapplied then
					pulsating.pulsestrength = 0.0
				end
			end 
		end	
	end
end)
