Citizen.CreateThread(function()
	pulsating = {}
	pulsating.pulsestrength = 0.0
	pulsating.pulserecoveryrate = 0.0
	pulsating.initialized = true
	Citizen.Trace("bloodyscreen.pulsating initialized!\n")
	
	while config == nil or config.initialized == nil do
		Citizen.Wait(0)
	end
	
	local activatepulsatingindicator = config.activatepulsatingindicator
	local activatepulsatingindicator = config.activatepulsatingindicator
	local percentagepulsatingeffecthealthfraction = config.percentagepulsatingeffecthealthfraction
	local minpulseinterval = config.minpulseinterval
	local maxpulseinterval = config.maxpulseinterval
	local pulsatingmultiplier = config.pulsatingmultiplier
	local pulse = 0
	local pulseinterval = 85
	local maxminusminpulseinterval = maxpulseinterval - minpulseinterval

	while main == nil or main.initialized == nil do
		Citizen.Wait(0)
	end

	local currenthealthfraction = main.currenthealthfraction


	if activatepulsatingindicator then
		while true do
			Citizen.Wait(1)
			currenthealthfraction = main.currenthealthfraction
			pulseinterval = minpulseinterval + (maxminusminpulseinterval * currenthealthfraction) 
			pulse = pulse + 1 
			if pulse >= pulseinterval and main.strengthapplied then 
				if main.currenthealthfraction <= percentagepulsatingeffecthealthfraction then 
					pulsating.pulsestrength = pulsatingmultiplier * (1.0 - currenthealthfraction) 
					main.strengthapplied = false 
				end 
				pulsating.pulserecoveryrate = pulsating.pulsestrength / pulseinterval 
				pulse = 0 
						
			else 
				if main.strengthapplied then
					pulsating.pulsestrength = 0.0
				end
			end 
		end	
	end
end)
