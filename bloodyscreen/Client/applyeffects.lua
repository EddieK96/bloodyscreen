Citizen.CreateThread(function()
	applyeffects = {}
	applyeffects.strength = 0.0
	applyeffects.initialized = true
	Citizen.Trace("bloodyscreen.applyeffects initialized!\n")
	while main == nil or main.initialized == nil or pulsating == nil or accute == nil or staticindicator == nil or config == nil or pulsating.initialized == nil or accute.initialized == nil or staticindicator.initialized == nil or config.initialized == nil do
		Citizen.Wait(0)
	end
	Citizen.Trace("bloodyscreen fully initialized!\n")
	local index = -1
	local function notify(text)
		SetTextComponentFormat('STRING')
		AddTextComponentString(text)
		DisplayHelpTextFromStringLabel(0, 0, 1, -1)
	end

	function loop ()
		SetTimecycleModifier("damage") 
		--notify("Effect loop running!")
		while true do
			Citizen.Wait(0)
			-----------------------------------------------------------------------------------------------
			--Apply screen effect:
			-----------------------------------------------------------------------------------------------
			if main.currenthealth >= main.deadhealth and main.currenthealth < main.maxhealth then 
				if not (GetTimecycleModifierIndex() == 58) then
					--notify("Effect loop exciting!")
					return 0
				end
				SetTimecycleModifierStrength(applyeffects.strength + staticindicator.strength)
				applyeffects.strength = applyeffects.strength + 0.02
			else
				main.strength = 0.0
				if not (GetTimecycleModifierIndex() == 58) then
					--notify("Effect loop exciting!")
					return 0
				end
				--notify(tostring(GetTimecycleModifierIndex()))
				SetTimecycleModifierStrength(0.0)
				applyeffects.strength = applyeffects.strength + 0.02
			end
		end
	end
	
	while true do
		Citizen.Wait(0)
		--notify(tostring(GetTimecycleModifierIndex()))
		if GetTimecycleModifierIndex() == -1 or GetTimecycleModifierIndex() == 58 then
			loop()
		end
	end
end)