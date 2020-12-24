local showHUD = true

RegisterNetEvent("car_hud:updateCARHUD")
AddEventHandler("car_hud:updateCARHUD", function(boolean)
	showHUD = boolean
end)

Citizen.CreateThread(function()
	local wait = 100
	local turnSignals = {left = false, right = false}
	local maxSpeed = tonumber(GetResourceMetadata("speedometer","max_speed") or "250")

	while true do
		local ped = GetPlayerPed(-1)
		local veh = GetVehiclePedIsIn(ped)
		
		if showHUD then
			if veh ~= 0 and  GetPedInVehicleSeat(veh, -1) == ped then
				if IsControlJustPressed(1, 308) then -- < is pressed
					turnSignals.left = not turnSignals.left
					SetVehicleIndicatorLights(veh, 1, turnSignals.left)
				end
				if IsControlJustPressed(1, 307) then -- > is pressed
					turnSignals.right = not turnSignals.right
					SetVehicleIndicatorLights(veh, 0, turnSignals.right)
				end

				local running =  GetIsVehicleEngineRunning(veh)

				SendNUIMessage({
					showhud = true,
					speed = running and math.ceil(GetEntitySpeed(veh) * 3.6) or 0,
					acceleration = running and math.ceil(GetVehicleCurrentRpm(veh) * 100) or 0,
					turnRight = turnSignals.right,
					turnLeft = turnSignals.left,
					fuel = GetVehicleFuelLevel(veh),
					maxSpeed = maxSpeed
				})

				wait = 1
			else
				wait = 1000
				turnSignals.left = false
				turnSignals.right = false
				
				SendNUIMessage({
					showhud = false
				})
			end
		else
			SendNUIMessage({
				showhud = false
			})
		end

		Citizen.Wait(wait)
	end
end)