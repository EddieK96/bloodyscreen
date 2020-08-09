Citizen.CreateThread(function()
	staticindicator = {}
	staticindicator.strength = 0.0

	staticindicator.initialized = true
	Citizen.Trace("bloodyscreen.staticindicator initialized!\n")
	
	--Locals...

	while config == nil or main == nil or config.initialized == nil or main.initialized == nil do
		Citizen.Wait(0)
	end
	if config.activatestatichealthindicator then
		while true do
			Citizen.Wait(0)
			staticindicator.strength = (4.1 + (2 * math.log10((1.0 - main.currenthealthfraction)/2))) * config.staticindicatorstrengthmultiplier
			--SetEntityHealth(main.playerped, 101)
			--Citizen.Trace(tostring(staticindicator.strength).."\n")
			--Citizen.Wait(1000)
		end
	end
end)