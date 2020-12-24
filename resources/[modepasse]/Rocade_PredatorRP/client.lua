local connecte = false

AddEventHandler("playerSpawned", function()

	if (connecte == false) then

		TriggerServerEvent("Rocade_Raven:playerConnected")

		connecte = true

	end

end)