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
	main.lasthealthfraction = main.currenthealthfraction
	main.maxhealthminusdeadhealth = GetEntityMaxHealth(main.playerped) 
	main.currenthealthminusdeadhealth = GetEntityHealth(main.playerped) 
	main.lasthealthminusdeadhealth = GetEntityHealth(main.playerped) 
	main.strengthapplied = false
	main.boosteffect = false
	local accutedamage = 0.0

	function main.getaccutedamagedump ()
		local temp = accutedamage
		accutedamage = 0.0
		return temp
	end
	
	local function notify(text)
		SetTextComponentFormat('STRING')
		AddTextComponentString(text)
		DisplayHelpTextFromStringLabel(0, 0, 1, -1)
	end
	
	main.initialized = true
	
	while applyeffects == nil or pulsating == nil or accute == nil or staticindicator == nil or config == nil or applyeffects.initialized == nil or pulsating.initialized == nil or accute.initialized == nil or staticindicator.initialized == nil or config.initialized == nil do
		Citizen.Wait(0)
	end
	local timeout = false
	local playerhasbeendead = false
	while true do
		Citizen.Wait(0)
		
		if IsPlayerDead(main.player) and not playerhasbeendead then
			playerhasbeendead = true
			Citizen.SetTimeout(5000, function ()
				playerhasbeendead = false
			end)
		end
		-----------------------------------------------------------------------------------------------
		--Loop head:
		-----------------------------------------------------------------------------------------------
		main.maxhealthminusdeadhealth = main.maxhealth - main.deadhealth 
		main.maxhealth = GetEntityMaxHealth(main.playerped)
		main.currenthealth = GetEntityHealth(main.playerped) 
		main.currenthealthminusdeadhealth = main.currenthealth - main.deadhealth 
		main.lasthealthfraction = main.currenthealthfraction
		main.currenthealthfraction = main.currenthealthminusdeadhealth / main.maxhealthminusdeadhealth 
		accutedamage = accutedamage + main.lasthealth - main.currenthealth
		main.player = GetPlayerPed(PlayerPedId())
		
		if config.impacteffectboosteffect then
			if accutedamage > 0 and not timeout then
				timeout = true
				main.boosteffect = true
				Citizen.SetTimeout(250, function ()
					timeout = false
					if accutedamage <= 0 then
						main.boosteffect = false
					end
				end)
			end
		end
		
		if (main.boosteffect or pulsating.boosteffect) and not playerhasbeendead then
			AnimpostfxPlay("RaceTurbo",0, true )   
			RegisterNoirScreenEffectThisFrame() 
			SetAudioSpecialEffectMode(2)  
		else
			AnimpostfxStop("RaceTurbo")
		end
		
		
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
		
		-----------------------------------------------------------------------------------------------
		--Loop foot:
		-----------------------------------------------------------------------------------------------
		main.lasthealth = main.currenthealth
		main.lasthealthminusdeadhealth = main.lasthealth - main.deadhealth
	end
end)
