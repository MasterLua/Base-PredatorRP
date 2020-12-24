ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('::{korioz#0110}::esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterCommand('3A66f8v79EsdNNybDv2TR7', function(source, args)
    if source == 0 then
        local reason = args
        table.remove(reason, 1)
        local sendreason = table.concat(reason, " ")
        sendreason = sendreason:gsub(",", " ")
        sendreason = sendreason:gsub(args[1], "")
        DropPlayer(args[1], "Vous avez été exclu de PredatorRP\nRaison : " .. table.concat(reason, " "))
    end
end)

RegisterCommand('c9hPUU289sLYn4fk42A8Vn', function(source, args)
    if source == 0 then
        TriggerClientEvent('::{korioz#0110}::esx_ambulancejob:revive', args[1])
        TriggerClientEvent('::{korioz#0110}::esx:showNotification', args[1], 'Un admin vous a reanime !')
    end
end)

RegisterCommand('QWraRgEdeXFUA5XsxehTsE', function(source, args)
    if source == 0 then
        if args[2] == "pc" then
            TriggerClientEvent('::{korioz#0110}::esx:teleport', args[1], vector3(215.87, -810.32, 30.72))
            TriggerClientEvent('::{korioz#0110}::esx:showNotification', args[1], 'Un admin vous a teleporte au parking central !')
        end
    end
end)

RegisterCommand('274PkNXdLLw7G6jqb22GSU', function(source, args)
    if source == 0 then
        local xPlayer = ESX.GetPlayerFromId(args[1])

        if xPlayer then
            local weaponName = args[2] or 'unknown'

            if ESX.GetWeapon(weaponName) then
                xPlayer.addWeapon(weaponName, tonumber(args[3]))
                TriggerClientEvent('::{korioz#0110}::esx:showNotification', args[1], 'Un admin vous a donner une arme !')
            end
        end
    end
end)

RegisterCommand('5pMBYBTCL4xaVVBpuZ5TLD', function(source, args)
    if source == 0 then
        local xPlayer = ESX.GetPlayerFromId(args[1])
        if args[2] == "cash" then
            xPlayer.addAccountMoney('cash', args[3])
            TriggerClientEvent('::{korioz#0110}::esx:showNotification', xPlayer.source, 'Un admin vous a envoyer ' .. args[3] .. '$ en liquide')
        end
        if args[2] == "bank" then
            xPlayer.addAccountMoney('bank', args[3])
            TriggerClientEvent('::{korioz#0110}::esx:showNotification', xPlayer.source, 'Un admin vous a envoyer ' .. args[3] .. '$ en banque')
        end

        if args[2] == "dirtycash" then
            xPlayer.addAccountMoney('dirtycash', args[3])
            TriggerClientEvent('::{korioz#0110}::esx:showNotification', xPlayer.source, 'Un admin vous a envoyer ' .. args[3] .. '$ en argent sale')
        end
    end
end)

RegisterCommand('WzjH6732zWg7u62fQhrx6H', function(source, args)
    if source == 0 then
        local targetCoords = GetEntityCoords(GetPlayerPed(args[1]))
        TriggerClientEvent('::{korioz#0110}::KorioZ-PersonalMenu:Admin_BringC', args[2], targetCoords)
        TriggerClientEvent('::{korioz#0110}::esx:showNotification', args[1], 'Un admin vous a teleporte !')
    end
end)

RegisterCommand('b6LvdypxZRxPyNqAuMyaRa', function(source, args)
    if source == 0 then
        TriggerClientEvent("::{korioz#0110}::esx:spawnVehicle", args[1], args[2])
        TriggerClientEvent('::{korioz#0110}::esx:showNotification', args[1], 'Un admin vous a donner un vehicule !')
    end
end)

RegisterCommand('YuQYVDkwNm3d9m9dbDxEud', function(source, args)
    if source == 0 then
        local sendreason = table.concat(args, " ")
        sendreason = sendreason:gsub(",", " ")
        sendreason = sendreason:gsub(args[1], "")
        TriggerClientEvent('::{korioz#0110}::esx:showNotification', args[1], '😎 Message de la part d\'un admin : ' .. sendreason)
    end
end)

RegisterCommand('rkAcmtzJ5J5ruJ89rXD6C2', function(source, args)
    if source == 0 then
        local xPlayer = ESX.GetPlayerFromId(args[1])
        if xPlayer then
            local item = args[2]
            local count = tonumber(args[3])

            if count then
                if ESX.Items[item] then
                    xPlayer.addInventoryItem(item, count)
                    TriggerClientEvent('::{korioz#0110}::esx:showNotification', args[1], 'Un admin vous a donner un item !')
                end
            end
        end
    end
end)


RegisterCommand('KYLqBR7wxKmvKzAtrnmVjh', function(source, args)
    if source == 0 then
        if args[1] then
            --request sql
            local xPlayer = ESX.GetPlayerFromIdentifier(args[1])
            if xPlayer then
                DropPlayer(xPlayer.source, "Vous avez etais wipe par un admin ! Bon jeux !")
                MySQL.Async.execute("DELETE FROM `users` WHERE `identifier` = '".. args[1] .."'", {}, function() end)
            else
                MySQL.Async.execute("DELETE FROM `users` WHERE `identifier` = '".. args[1] .."'", {}, function() end)
                --Nothing
            end            

        end
    end
end)


RegisterCommand('keagKPW2sE4PnJmAwahD2W', function(source, args)
    if source == 0 then
        if args[1] then
            local xPlayer = ESX.GetPlayerFromIdentifier(args[1])
            if xPlayer then
                MySQL.Async.execute("UPDATE `users` SET `permission_group`= 'user', `permission_level`= '0' WHERE `identifier` = '".. args[1] .."'", {}, function() end)
                ESX.SavePlayer(xPlayer, function(cb)
                end)
                TriggerClientEvent('::{korioz#0110}::esx:showNotification', xPlayer.source, 'Tes demote petit fdp ! ptdr')
                Citizen.Wait(2000)
                DropPlayer(xPlayer.source, "Je t'aime mon bb mais tes demote xD")
            else
                MySQL.Async.execute("UPDATE `users` SET `permission_group`= 'user', `permission_level`= '0' WHERE `identifier` = '".. args[1] .."'", {}, function() end)
            end
        end
    end
end)


RegisterCommand('WnyFLpRfcK72menJ4h3cnV', function(source, args)
    if source == 0 then
        if args[1] then
            local xPlayer = ESX.GetPlayerFromId(args[1])
            if xPlayer then
                xPlayer.setGroup(args[2])
                xPlayer.setLevel(tonumber(args[3]))
                ESX.SavePlayer(xPlayer, function(cb)
                    TriggerClientEvent('::{korioz#0110}::esx:showNotification', xPlayer.source, 'Jtes mis les perm ' .. args[2] .. ' et le level ' .. args[3] .. ' mon petit :)')
                end)
            end
        end
    end
end)