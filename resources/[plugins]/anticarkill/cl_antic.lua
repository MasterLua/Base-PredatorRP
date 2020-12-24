local carkill = { 133987706, -1553120962 }

  function verif (a, val)
    for name, value in ipairs(a) do
        if value == val then
            return true
        end
    end
    return false
end

RegisterCommand('carkill', function()
local ped = GetPlayerPed(-1)
local cd = GetPedCauseOfDeath(ped)
    if verif(carkill, cd) then
        TriggerEvent('esx_ambulancejob:revive')
        TriggerEvent('esx:showNotification', '~g~Vous avez été réanimé suite à une mort causé par un véhicule.')
        Citizen.Wait(2500)
        TriggerEvent('esx:showNotification', '~y~Si le carkill était justifié et justifiable, un admin pourra décider de votre sanction.')
    else
        TriggerEvent('esx:showNotification', '~r~Vous n\'avez pas été tué suite à un accident causé par un véhicule.')
    end
end, false)
