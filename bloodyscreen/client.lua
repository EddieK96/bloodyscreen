Citizen.CreateThread(function()
	
	--CONFIG--

	--Effect strength multiplier for damage impacts:
	local impacteffectstrengthmultiplier = 14.5

	--Value between 0.0 and 1.0 for how fast the screen effect fades away after a damage impact:
	local accutedamagerecoveryrate = 0.02
	
	--Pulsating screeneffect as a permanent health indicator:
	local activatepulsatingindicator = true
	
	--Variable interval for pulse indicator depending on health. (lower value -> faster)
	local minpulseinterval = 35
	local maxpulseinterval = 133

	--Effect strength multiplier for pulsating effect:
	local pulsatingmultiplier = 3.0

	--Maximum effect strength:
	local maxeffectstrength = 10.0
	
	--END CONFIG--

	local pulse = 0
	local pulseinterval = 85
	local strength = 0.0
	local playerped = PlayerPedId() --PLAYER.
	local player = GetPlayerPed(PlayerPedId()) --PLAYER.
	local lasthealth = GetEntityHealth(playerped)
	local currenthealth = GetEntityHealth(playerped)
	local deadhealth = 100.0
	local maxhealth = GetEntityMaxHealth(playerped)
	local pulsestrength = 0.0
	local accutedamagestrength = 0.0
	local pulserecoveryrate = 0.0
	
	local function capminmax (min, max, value)
		if value > max then
			return max
		
		else	
			if value < min then
				return min
			end
		end
		
		return value
	end

	while true do
		Citizen.Wait(1)


		playerped = PlayerPedId() --PLAYER.
		player = GetPlayerPed(PlayerPedId()) --PLAYER.
		currenthealth = GetEntityHealth(playerped)
		maxhealth = GetEntityMaxHealth(playerped)

		if activatepulsatingindicator then
			pulseinterval = minpulseinterval + ((maxpulseinterval - minpulseinterval) * ((currenthealth-deadhealth) / (maxhealth - deadhealth)))
			pulse = pulse + 1
			if pulse >= pulseinterval  then
				pulsestrength = capminmax(0.0, maxeffectstrength, pulsatingmultiplier * (1.0 - ((currenthealth - deadhealth) / ( maxhealth - deadhealth))))
				pulserecoveryrate = pulsestrength / pulseinterval
			pulse = 0
			
			else
				pulsestrength = 0.0
			end

		end

		if currenthealth < lasthealth then
			accutedamagestrength = capminmax(0.0, maxeffectstrength, (impacteffectstrengthmultiplier * ((lasthealth-deadhealth) - (currenthealth-deadhealth)) / (maxhealth - deadhealth)))

		else
			accutedamagestrength = 0.0
		end

		strength = capminmax(0.0, maxeffectstrength, strength + accutedamagestrength + pulsestrength - pulserecoveryrate - accutedamagerecoveryrate)		

		if currenthealth >= deadhealth then
			if currenthealth < maxhealth then
				SetTimecycleModifier("damage")
				SetTimecycleModifierStrength(strength)
			else
				SetTimecycleModifier("damage")
				SetTimecycleModifierStrength(0.0)
				strength = 0.0
			end
		else
			SetTimecycleModifier("dying")
			SetTimecycleModifierStrength(maxeffectstrength)
		end
		lasthealth = currenthealth
	end
end)