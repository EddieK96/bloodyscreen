Citizen.CreateThread(function()
	while main == nil or main.initialized == nil or pulsating == nil or accute == nil or staticindicator == nil or config == nil or pulsating.initialized == nil or accute.initialized == nil or staticindicator.initialized == nil or config.initialized == nil do
		Citizen.Wait(0)
	end
	
	while true do
		Citizen.Wait(0)
		
		main.playerped = PlayerPedId() --PLAYER. 
		main.player = GetPlayerPed(PlayerPedId()) --PLAYER. 
	end
end)