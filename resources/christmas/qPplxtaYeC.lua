Citizen.CreateThread(function()
    while true 
        do
        
    SetWeatherTypePersist("XMAS")
        SetWeatherTypeNowPersist("XMAS")
        SetWeatherTypeNow("XMAS")
        SetOverrideWeather("XMAS")
        SetForcePedFootstepsTracks(true)
	SetForceVehicleTrails(true)
        Citizen.Wait(1)
    end
end)