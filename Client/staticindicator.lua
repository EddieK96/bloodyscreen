Citizen.CreateThread(function()
	staticindicator = {}
	staticindicator.strength = 0.0

	staticindicator.initialized = true
	Citizen.Trace("bloodyscreen.staticindicator initialized!\n")

	while config == nil or main == nil or config.initialized == nil or main.initialized == nil do
		Citizen.Wait(0)
	end
	if config.activatestatichealthindicator then
		while true do
			Citizen.Wait(0)
			if main.currenthealthfraction <= config.percentagestaticeffecthealthfraction then 
				staticindicator.strength = (4.1 + (2 * math.log10((1.0 - main.currenthealthfraction)/2))) * config.staticindicatorstrengthmultiplier
			else
				staticindicator.strength = 0.0
			end
		end
	end
end)