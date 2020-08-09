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
	
	while true do
		Citizen.Wait(0)
		accutedamage = main.getaccutedamagedump()
		accute.accutedamagestrengthdump = accute.accutedamagestrengthdump + (config.impacteffectstrengthmultiplier * (accutedamage / main.maxhealthminusdeadhealth))
	end
end)