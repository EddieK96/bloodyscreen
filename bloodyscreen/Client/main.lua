Citizen.CreateThread(function()
	main = {}
	main.strength = 0.0
	main.playerped = PlayerPedId() --PLAYER.
	main.player = GetPlayerPed(PlayerPedId()) --PLAYER.
	main.lasthealth = GetEntityHealth(main.playerped)
	main.currenthealth = GetEntityHealth(main.playerped)
	main.deadhealth = 100.0
	main.maxhealth = GetEntityMaxHealth(main.playerped)
	main.currenthealthfraction = GetEntityHealth(main.playerped) / GetEntityMaxHealth(main.playerped) 
	main.maxhealthminusdeadhealth = GetEntityMaxHealth(main.playerped) 
	main.currenthealthminusdeadhealth = GetEntityHealth(main.playerped) 
	main.lasthealthminusdeadhealth = GetEntityHealth(main.playerped) 
	main.strengthapplied = false
	local accutedamage = 0.0

	function main.getaccutedamagedump ()
		local temp = accutedamage
		accutedamage = 0.0
		return temp
	end

	main.initialized = true
	Citizen.Trace("bloodyscreen.main initialized!\n")
	
	while applyeffects == nil or pulsating == nil or accute == nil or staticindicator == nil or config == nil or applyeffects.initialized == nil or pulsating.initialized == nil or accute.initialized == nil or staticindicator.initialized == nil or config.initialized == nil do
		Citizen.Wait(0)
	end

	while true do
		Citizen.Wait(0)
		-----------------------------------------------------------------------------------------------
		--Loop head:
		-----------------------------------------------------------------------------------------------
		main.maxhealthminusdeadhealth = main.maxhealth - main.deadhealth 
		main.currenthealth = GetEntityHealth(main.playerped) 
		main.currenthealthminusdeadhealth = main.currenthealth - main.deadhealth 
		main.currenthealthfraction = main.currenthealthminusdeadhealth / main.maxhealthminusdeadhealth 
		accutedamage = accutedamage + main.lasthealth - main.currenthealth
		
		-----------------------------------------------------------------------------------------------
		--Calculate value for effect strength:
		-----------------------------------------------------------------------------------------------
		main.strength = main.strength + accute.getaccutedamagestrengthdump() + pulsating.pulsestrength - pulsating.pulserecoveryrate - config.accutedamagerecoveryrate
		applyeffects.strength = main.strength
		main.strengthapplied = true
		if main.strength > config.maxeffectstrength then
			main.strength = config.maxeffectstrength
			applyeffects.strength = main.strength
		else 
			if main.strength < 0.0 then
				main.strength = 0.0
				applyeffects.strength = main.strength
			end
		end
		--Citizen.Trace("Max. Health: "..tostring(main.maxhealth).."\n")
		--Citizen.Trace("Dead Health: "..tostring(main.deadhealth).."\n")
		
		-----------------------------------------------------------------------------------------------
		--Loop foot:
		-----------------------------------------------------------------------------------------------
		main.lasthealth = main.currenthealth
		main.lasthealthminusdeadhealth = main.lasthealth - main.deadhealth
	end
end)