Citizen.CreateThread(function()
	accute = {}
	accute.accutedamagestrengthdump = 0.0

	function accute.getaccutedamagestrengthdump ()
		local temp = accute.accutedamagestrengthdump
		accute.accutedamagestrengthdump = 0.0
		return temp
	end
	accute.initialized = true
	Citizen.Trace("bloodyscreen.accute initialized!\n")
	
	local accutedamage = 0.0

	while config == nil or main == nil or config.initialized == nil or main.initialized == nil do
		Citizen.Wait(0)
	end
	
	if config.activateaccutehealthindicator then
		while true do
			Citizen.Wait(0)
			accutedamage = main.getaccutedamagedump()
			if main.currenthealthfraction <= config.percentageimpacteffecthealthfraction then
				accute.accutedamagestrengthdump = accute.accutedamagestrengthdump + (config.impacteffectstrengthmultiplier * (accutedamage / main.maxhealthminusdeadhealth))
			else
				accute.accutedamagestrengthdump = 0
			end
		end
	end
end)