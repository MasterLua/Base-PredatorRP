ESX = nil

TriggerEvent('::{korioz#0110}::esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1800000)
        TriggerClientEvent("RedMenu:Notification", -1, "Notre boutique propose pas mal de promotions en ce moment alors foncés !")
    end
end)

ESX.RegisterServerCallback('RedMenu:GetPoint', function(source, cb)
    local xPlayer  = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
        if result[1] then
            cb(result[1].predacoin)
        else
            return
        end
        --print(result[1].predacoin)
    end)
end)

ESX.RegisterServerCallback('RedMenu:GetCodeBoutique', function(source, cb)
    local xPlayer  = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
        if result[1] then
            cb(result[1].character_id)
        else
            return
        end
    end)
end)

ESX.RegisterServerCallback('RedMenu:DonnePoint', function(source, cb, point, idboutique)
    local xPlayer  = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
        print(result[1].predacoin)
        if result[1].predacoin >= tonumber(point) then
            local newpoint = result[1].predacoin - tonumber(point)
            MySQL.Async.execute("UPDATE `users` SET `predacoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)
            MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `character_id` = '".. idboutique .."'", {}, function (result2)
                local addpoint = result2[1].predacoin + tonumber(point)
                local xPlayer2 = ESX.GetPlayerFromIdentifier(result2[1].identifier)
                PerformHttpRequest('https://canary.discord.com/api/webhooks/785902346403840051/_IBsE9NdE6uHckh87eHQqvSFW2WlM08iL07OyKqIQRy4mbBFOVJaa4OO5reRhsZoNJ5D', function(err, text, headers) end, 'POST', json.encode({username = "SalutCLaBoutiqueDeMasterLua", content = "Transaction : " .. point .. " Predacoin de la part de " .. xPlayer.getName() .. " a " .. xPlayer2.getName()}), { ['Content-Type'] = 'application/json' })
                xPlayer2.triggerEvent("RedMenu:Notification", "Vous avez recu " .. point .. " Predacoin de la part de " .. xPlayer.getName())
                MySQL.Async.execute("UPDATE `users` SET `predacoin`= '".. addpoint .."' WHERE `character_id` = '".. idboutique .."'", {}, function() end)
            end)
            cb(true)
        else
            cb(false)
        end
    end)
end)

ESX.RegisterServerCallback('RedMenu:BuyItem', function(source, cb, item, option)
    local xPlayer  = ESX.GetPlayerFromId(source)

    --BAT
    if item == "bat" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            if result[1].predacoin >= 500 then
                local newpoint = result[1].predacoin - 500
                MySQL.Async.execute("UPDATE `users` SET `predacoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)   
                xPlayer.addWeapon("WEAPON_BAT", 250)
                PerformHttpRequest('https://canary.discord.com/api/webhooks/785902346403840051/_IBsE9NdE6uHckh87eHQqvSFW2WlM08iL07OyKqIQRy4mbBFOVJaa4OO5reRhsZoNJ5D', function(err, text, headers) end, 'POST', json.encode({username = "SalutCLaBoutiqueDeMasterLua", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
                cb(true)         
            else
                cb(false)
            end
        end)    
    end

    if item == "couteau" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            if result[1].predacoin >= 600 then
                local newpoint = result[1].predacoin - 600
                MySQL.Async.execute("UPDATE `users` SET `predacoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end) 
                xPlayer.addWeapon("WEAPON_KNIFE", 250)  
                PerformHttpRequest('https://canary.discord.com/api/webhooks/785902346403840051/_IBsE9NdE6uHckh87eHQqvSFW2WlM08iL07OyKqIQRy4mbBFOVJaa4OO5reRhsZoNJ5D', function(err, text, headers) end, 'POST', json.encode({username = "SalutCLaBoutiqueDeMasterLua", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
                cb(true)         
            else
                cb(false)
            end
        end)    
    end

    if item == "ak47" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            if result[1].predacoin >= 2000 then
                local newpoint = result[1].predacoin - 2000
                MySQL.Async.execute("UPDATE `users` SET `predacoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)   
                xPlayer.addWeapon("weapon_assaultrifle", 250)
                PerformHttpRequest('https://canary.discord.com/api/webhooks/785902346403840051/_IBsE9NdE6uHckh87eHQqvSFW2WlM08iL07OyKqIQRy4mbBFOVJaa4OO5reRhsZoNJ5D', function(err, text, headers) end, 'POST', json.encode({username = "SalutCLaBoutiqueDeMasterLua", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
                cb(true)         
            else
                cb(false)
            end
        end)    
    end

    if item == "cal50" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            if result[1].predacoin >= 500 then
                local newpoint = result[1].predacoin - 500
                MySQL.Async.execute("UPDATE `users` SET `predacoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)   
                xPlayer.addWeapon("weapon_pistol50", 250)
                PerformHttpRequest('https://canary.discord.com/api/webhooks/785902346403840051/_IBsE9NdE6uHckh87eHQqvSFW2WlM08iL07OyKqIQRy4mbBFOVJaa4OO5reRhsZoNJ5D', function(err, text, headers) end, 'POST', json.encode({username = "SalutCLaBoutiqueDeMasterLua", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
                cb(true)         
            else
                cb(false)
            end
        end)    
    end


    if item == "microsmg" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            if result[1].predacoin >= 1100 then
                local newpoint = result[1].predacoin - 1100
                MySQL.Async.execute("UPDATE `users` SET `predacoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)   
                xPlayer.addWeapon("WEAPON_MICROSMG", 250)
                PerformHttpRequest('https://canary.discord.com/api/webhooks/785902346403840051/_IBsE9NdE6uHckh87eHQqvSFW2WlM08iL07OyKqIQRy4mbBFOVJaa4OO5reRhsZoNJ5D', function(err, text, headers) end, 'POST', json.encode({username = "SalutCLaBoutiqueDeMasterLua", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
                cb(true)         
            else
                cb(false)
            end
        end)    
    end


    if item == "sniper" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            if result[1].predacoin >= 2100 then
                local newpoint = result[1].predacoin - 2100
                MySQL.Async.execute("UPDATE `users` SET `predacoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)   
                xPlayer.addWeapon("WEAPON_HEAVYSNIPER", 250)
                PerformHttpRequest('https://canary.discord.com/api/webhooks/785902346403840051/_IBsE9NdE6uHckh87eHQqvSFW2WlM08iL07OyKqIQRy4mbBFOVJaa4OO5reRhsZoNJ5D', function(err, text, headers) end, 'POST', json.encode({username = "SalutCLaBoutiqueDeMasterLua", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
                cb(true)         
            else
                cb(false)
            end
        end)    
    end


    if item == "revive" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            if result[1].predacoin >= 300 then
                local newpoint = result[1].predacoin - 300
                MySQL.Async.execute("UPDATE `users` SET `predacoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)   
                xPlayer.triggerEvent("::{korioz#0110}::esx_ambulancejob:revive")
                Citizen.Wait(1000)
                xPlayer.triggerEvent("::{korioz#0110}::esx:teleport", vector3(215.48, -810.24, 30.73))
                PerformHttpRequest('https://canary.discord.com/api/webhooks/785902346403840051/_IBsE9NdE6uHckh87eHQqvSFW2WlM08iL07OyKqIQRy4mbBFOVJaa4OO5reRhsZoNJ5D', function(err, text, headers) end, 'POST', json.encode({username = "SalutCLaBoutiqueDeMasterLua", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
                cb(true)         
            else
                cb(false)
            end
        end)    
    end

    if item == "lumma" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            if result[1].predacoin >= 2200 then
                local newpoint = result[1].predacoin - 2200
                MySQL.Async.execute("UPDATE `users` SET `predacoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)   
                PerformHttpRequest('https://canary.discord.com/api/webhooks/785902346403840051/_IBsE9NdE6uHckh87eHQqvSFW2WlM08iL07OyKqIQRy4mbBFOVJaa4OO5reRhsZoNJ5D', function(err, text, headers) end, 'POST', json.encode({username = "SalutCLaBoutiqueDeMasterLua", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
                cb(true)         
            else
                cb(false)
            end
        end)    
    end

    if item == "rs6" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            if result[1].predacoin >= 3100 then
                local newpoint = result[1].predacoin - 3100
                MySQL.Async.execute("UPDATE `users` SET `predacoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end) 
                PerformHttpRequest('https://canary.discord.com/api/webhooks/785902346403840051/_IBsE9NdE6uHckh87eHQqvSFW2WlM08iL07OyKqIQRy4mbBFOVJaa4OO5reRhsZoNJ5D', function(err, text, headers) end, 'POST', json.encode({username = "SalutCLaBoutiqueDeMasterLua", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })  
                cb(true)         
            else
                cb(false)
            end
        end)    
    end

    if item == "rs7" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            if result[1].predacoin >= 3100 then
                local newpoint = result[1].predacoin - 3100
                MySQL.Async.execute("UPDATE `users` SET `predacoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)   
                PerformHttpRequest('https://canary.discord.com/api/webhooks/785902346403840051/_IBsE9NdE6uHckh87eHQqvSFW2WlM08iL07OyKqIQRy4mbBFOVJaa4OO5reRhsZoNJ5D', function(err, text, headers) end, 'POST', json.encode({username = "SalutCLaBoutiqueDeMasterLua", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
                cb(true)         
            else
                cb(false)
            end
        end)    
    end
    
    if item == "c63" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            if result[1].predacoin >= 2200 then
                local newpoint = result[1].predacoin - 2200
                MySQL.Async.execute("UPDATE `users` SET `predacoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)  
                PerformHttpRequest('https://canary.discord.com/api/webhooks/785902346403840051/_IBsE9NdE6uHckh87eHQqvSFW2WlM08iL07OyKqIQRy4mbBFOVJaa4OO5reRhsZoNJ5D', function(err, text, headers) end, 'POST', json.encode({username = "SalutCLaBoutiqueDeMasterLua", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' }) 
                cb(true)         
            else
                cb(false)
            end
        end)    
    end

    if item == "m5" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            if result[1].predacoin >= 2200 then
                local newpoint = result[1].predacoin - 2200
                MySQL.Async.execute("UPDATE `users` SET `predacoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)   
                PerformHttpRequest('https://canary.discord.com/api/webhooks/785902346403840051/_IBsE9NdE6uHckh87eHQqvSFW2WlM08iL07OyKqIQRy4mbBFOVJaa4OO5reRhsZoNJ5D', function(err, text, headers) end, 'POST', json.encode({username = "SalutCLaBoutiqueDeMasterLua", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
                cb(true)         
            else
                cb(false)
            end
        end)    
    end

    if item == "urus" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            if result[1].predacoin >= 2200 then
                local newpoint = result[1].predacoin - 2200
                MySQL.Async.execute("UPDATE `users` SET `predacoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)   
                PerformHttpRequest('https://canary.discord.com/api/webhooks/785902346403840051/_IBsE9NdE6uHckh87eHQqvSFW2WlM08iL07OyKqIQRy4mbBFOVJaa4OO5reRhsZoNJ5D', function(err, text, headers) end, 'POST', json.encode({username = "SalutCLaBoutiqueDeMasterLua", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
                cb(true)         
            else
                cb(false)
            end
        end)    
    end

    if item == "gtr" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            if result[1].predacoin >= 3100 then
                local newpoint = result[1].predacoin - 3100
                MySQL.Async.execute("UPDATE `users` SET `predacoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)   
                PerformHttpRequest('https://canary.discord.com/api/webhooks/785902346403840051/_IBsE9NdE6uHckh87eHQqvSFW2WlM08iL07OyKqIQRy4mbBFOVJaa4OO5reRhsZoNJ5D', function(err, text, headers) end, 'POST', json.encode({username = "SalutCLaBoutiqueDeMasterLua", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
                cb(true)         
            else
                cb(false)
            end
        end)    
    end

    if item == "a45" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            if result[1].predacoin >= 1000 then
                local newpoint = result[1].predacoin - 1000
                MySQL.Async.execute("UPDATE `users` SET `predacoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)   
                PerformHttpRequest('https://canary.discord.com/api/webhooks/785902346403840051/_IBsE9NdE6uHckh87eHQqvSFW2WlM08iL07OyKqIQRy4mbBFOVJaa4OO5reRhsZoNJ5D', function(err, text, headers) end, 'POST', json.encode({username = "SalutCLaBoutiqueDeMasterLua", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
                cb(true)         
            else
                cb(false)
            end
        end)    
    end

    if item == "tzr" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            if result[1].predacoin >= 4300 then
                local newpoint = result[1].predacoin - 4300
                MySQL.Async.execute("UPDATE `users` SET `predacoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)   
                PerformHttpRequest('https://canary.discord.com/api/webhooks/785902346403840051/_IBsE9NdE6uHckh87eHQqvSFW2WlM08iL07OyKqIQRy4mbBFOVJaa4OO5reRhsZoNJ5D', function(err, text, headers) end, 'POST', json.encode({username = "SalutCLaBoutiqueDeMasterLua", content = xPlayer.getName() .. " a acheter " .. item}), { ['Content-Type'] = 'application/json' })
                cb(true)         
            else
                cb(false)
            end
        end)    
    end

    if item == "gang" then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            if result[1].predacoin >= 3000 then
                local newpoint = result[1].predacoin - 3000
                MySQL.Async.execute("UPDATE `users` SET `predacoin`= '".. newpoint .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)   
                PerformHttpRequest('https://canary.discord.com/api/webhooks/785902346403840051/_IBsE9NdE6uHckh87eHQqvSFW2WlM08iL07OyKqIQRy4mbBFOVJaa4OO5reRhsZoNJ5D', function(err, text, headers) end, 'POST', json.encode({username = "SalutCLaBoutiqueDeMasterLua", content = xPlayer.getName() .. " a acheter " .. item .. "\nNom a contacter pour le gang : " .. option}), { ['Content-Type'] = 'application/json' })
                cb(true)         
            else
                cb(false)
            end
        end)    
    end

end)

--CLIENT SIDE

local code = [[
    ESX = nil

    RegisterNetEvent("RedMenu:Notification")
    AddEventHandler("RedMenu:Notification", function(message)
        ESX.ShowNotification("~h~⭐ Boutique : " .. message)
    end)
    
    Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent('::{korioz#0110}::esx:getSharedObject', function(obj) ESX = obj end)
            ESX.TriggerServerCallback('RedMenu:GetPoint', function(thepoint)
                point = thepoint
            end)
    
            ESX.TriggerServerCallback('RedMenu:GetCodeBoutique', function(thecode)
                code = thecode
            end)
        end
    end)
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(2000)
            ESX.TriggerServerCallback('RedMenu:GetPoint', function(thepoint)
                point = thepoint
            end)
    
            ESX.TriggerServerCallback('RedMenu:GetCodeBoutique', function(thecode)
                code = thecode
            end)
        end    
    end)
    
    function GetActuallyParticul(assetName)
        RequestNamedPtfxAsset(assetName)
        if not (HasNamedPtfxAssetLoaded(assetName)) then
            while not HasNamedPtfxAssetLoaded(assetName) do
                Citizen.Wait(1.0)
            end
            return assetName;
        else
            return assetName;
        end
    end
    
    function KeyboardInput(entryTitle, textEntry, inputText, maxLength)
        AddTextEntry(entryTitle, textEntry)
        DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength)
        blockinput = true
    
        while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
            Citizen.Wait(0)
        end
    
        if UpdateOnscreenKeyboard() ~= 2 then
            local result = GetOnscreenKeyboardResult()
            Citizen.Wait(500)
            blockinput = false
            return result
        else
            Citizen.Wait(500)
            blockinput = false
            return nil
        end
    end
    
    RMenu.Add('MenuPredator', 'home', RageUI.CreateMenu("Predator", "~b~Predator"))
    RMenu:Get("MenuPredator", "home").Closed = function()end
    RMenu:Get('MenuPredator', 'home'):SetRectangleBanner(66, 0, 0, 255)
    
    RMenu.Add('MenuPredator', 'info', RageUI.CreateSubMenu(RMenu:Get('MenuPredator', 'home'), Config.MenuName, "Information"))
    RMenu:Get("MenuPredator", "info").Closed = function()end
    
    RMenu.Add('MenuPredator', 'boutique', RageUI.CreateSubMenu(RMenu:Get('MenuPredator', 'home'), Config.MenuName, "Boutique"))
    RMenu:Get("MenuPredator", "boutique").Closed = function()end
    
    RMenu.Add('MenuPredator', 'menuarme', RageUI.CreateSubMenu(RMenu:Get('MenuPredator', 'boutique'), Config.MenuName, "Boutique Arme"))
    RMenu:Get("MenuPredator", "menuarme").Closed = function()end
    
    RMenu.Add('MenuPredator', 'menuvehicule', RageUI.CreateSubMenu(RMenu:Get('MenuPredator', 'boutique'), Config.MenuName, "Boutique Arme"))
    RMenu:Get("MenuPredator", "menuvehicule").Closed = function()end
    
    RMenu.Add('MenuPredator', 'menuother', RageUI.CreateSubMenu(RMenu:Get('MenuPredator', 'boutique'), Config.MenuName, "Boutique Arme"))
    RMenu:Get("MenuPredator", "menuother").Closed = function()end
    
    Citizen.CreateThread(function()
        while true do
          Citizen.Wait(0)
            RageUI.IsVisible(RMenu:Get('MenuPredator', 'home'), true, true, true, function()
    
                RageUI.ButtonWithStyle("🚀 | Boutique", nil, {}, true,function(h,a,s)
                    if s then
                    end
                end, RMenu:Get("MenuPredator","boutique"))
    
                RageUI.ButtonWithStyle("🥳| Donne des points", nil, {}, true,function(h,a,s)
                    if s then
                        local idboutique = KeyboardInput('REDMENU_ID_BOUTIQUE', "Merci d'entrer l'id boutique de vôtre ami", '', 50)
                        local point = KeyboardInput('REDMENU_ID_BOUTIQUE', "Merci de spécifier le nombre de jetons que vous souhaitez donner", '', 50)
                        ESX.TriggerServerCallback('RedMenu:DonnePoint', function(callback)
                            if callback then
                                ESX.ShowNotification("~h~⭐ Transfert reussi !")
                            else
                                ESX.ShowNotification("~h~⭐ Vous n'avez pas assez de point !")
                            end
                        end, point, idboutique)
                    end
                end, nil)              
    
                RageUI.ButtonWithStyle("💎 | Information", nil, {}, true,function(h,a,s)
                    if s then
                    end
                end,RMenu:Get("MenuPredator","info"))            
                
            end)
    
            RageUI.IsVisible(RMenu:Get("MenuPredator","info"),true,true,true,function()
                RenderInfoMenu()
            end, function()end, 1)
    
            RageUI.IsVisible(RMenu:Get("MenuPredator","boutique"),true,true,true,function()
                RenderBoutiqueMenu()
            end, function()end, 1)
    
            RageUI.IsVisible(RMenu:Get("MenuPredator","menuarme"),true,true,true,function()
                RenderArmeMenu()
            end, function()end, 1)
    
            RageUI.IsVisible(RMenu:Get("MenuPredator","menuvehicule"),true,true,true,function()
                RenderVehiculeMenu()
            end, function()end, 1)
            
            RageUI.IsVisible(RMenu:Get("MenuPredator","menuother"),true,true,true,function()
                RenderUtilsMenu()
            end, function()end, 1)
    
    
        end
    end)
    
    Citizen.CreateThread(function()
        while (true) do
            Citizen.Wait(1.0)
            if IsControlJustPressed(1,288) then
                RageUI.Visible(RMenu:Get('MenuPredator', 'home'), not RageUI.Visible(RMenu:Get('MenuPredator', 'home'))) 
            end
        end
    end)
    
    function RenderInfoMenu()
        RageUI.Separator("~h~~p~Discord~s~ : ~h~~p~discord.gg/bw55xcHYxd")
        RageUI.Separator("~h~~g~Developpeur~s~ : ~h~~g~MasterLua#9999")
      --  RageUI.Separator("~h~~o~ID~s~ : ~h~~o~" ..GetPlayerServerId(PlayerId()))
    end
    
    function RenderBoutiqueMenu()
        RageUI.Separator("~h~Predacoin : ~r~" .. point)
        RageUI.Separator("~h~Code boutique : ~b~" .. code)
        RageUI.ButtonWithStyle("🔫 | Armes", nil, {}, true,function(h,a,s)
            if s then
            end
        end, RMenu:Get("MenuPredator","menuarme"))
        RageUI.ButtonWithStyle("🚘 | Vehicules", nil, {}, true,function(h,a,s)
            if s then
            end
        end, RMenu:Get("MenuPredator","menuvehicule"))
        RageUI.ButtonWithStyle("👽 | Autres", nil, {}, true,function(h,a,s)
            if s then
            end
        end, RMenu:Get("MenuPredator","menuother"))
    
    end
    
    function RenderArmeMenu()
        RageUI.Separator("~h~Predacoin : ~r~" .. point)
        RageUI.Separator("~h~Code boutique : ~b~" .. code)
        RageUI.ButtonWithStyle("~h~Bat de baseball", nil, { RightLabel = "500 Predacoin" }, true,function(h,a,s)
            if a then
                RenderSprite("RageUI", "baseball-bat", 0, 350, 535, 380, 100)
            end
            if s then
                ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                    if callback == true then
                        local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                        GetActuallyParticul('scr_rcbarry2')
                        SetPtfxAssetNextCall('scr_rcbarry2')
                        StartParticleFxNonLoopedAtCoord_2('scr_clown_death', coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 5.0, false, false, false)
                        ESX.ShowNotification("~h~⭐ Merci pour votre achat dans la boutique !")
                    else
                        ESX.ShowNotification("~h~⭐ Vous n'avez pas assez de fond pour acheter ceci !")
                    end
                end, "bat")            
            end
        end)
        
        RageUI.ButtonWithStyle("~h~Couteau", nil, { RightLabel = "600 Predacoin" }, true,function(h,a,s)
            if a then
                RenderSprite("RageUI", "Screenshot_127", 0, 350, 535, 380, 100)
            end
            if s then
                ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                    if callback == true then
                        local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                        GetActuallyParticul('scr_rcbarry2')
                        SetPtfxAssetNextCall('scr_rcbarry2')
                        StartParticleFxNonLoopedAtCoord_2('scr_clown_death', coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 5.0, false, false, false)
                        ESX.ShowNotification("~h~⭐ Merci pour votre achat dans la boutique !")
                    else
                        ESX.ShowNotification("~h~⭐ Vous n'avez pas assez de fond pour acheter ceci !")
                    end
                end, "couteau")
            end
        end)
    
        RageUI.ButtonWithStyle("~h~Ak-47", nil, { RightLabel = "2000 Predacoin" }, true,function(h,a,s)
            if a then
                RenderSprite("RageUI", "assault-rifle-mk2", 0, 400, 535, 380, 100)
            end
            if s then
                ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                    if callback == true then
                        local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                        GetActuallyParticul('scr_rcbarry2')
                        SetPtfxAssetNextCall('scr_rcbarry2')
                        StartParticleFxNonLoopedAtCoord_2('scr_clown_death', coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 5.0, false, false, false)
                        ESX.ShowNotification("~h~⭐ Merci pour votre achat dans la boutique !")
                    else
                        ESX.ShowNotification("~h~⭐ Vous n'avez pas assez de fond pour acheter ceci !")
                    end
                end, "ak47")
            end
        end)
    
        RageUI.ButtonWithStyle("~h~PISTOLET CAL. 50", nil, { RightLabel = "500 Predacoin" }, true,function(h,a,s)
            if s then
                ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                    if callback == true then
                        local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                        GetActuallyParticul('scr_rcbarry2')
                        SetPtfxAssetNextCall('scr_rcbarry2')
                        StartParticleFxNonLoopedAtCoord_2('scr_clown_death', coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 5.0, false, false, false)
                        ESX.ShowNotification("~h~⭐ Merci pour votre achat dans la boutique !")
                    else
                        ESX.ShowNotification("~h~⭐ Vous n'avez pas assez de fond pour acheter ceci !")
                    end
                end, "cal50")
            end
        end)
    
        RageUI.ButtonWithStyle("~h~PISTOLET-MITRAILLEUR", nil, { RightLabel = "1100 Predacoin" }, true,function(h,a,s)
            if s then
                ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                    if callback == true then
                        local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                        GetActuallyParticul('scr_rcbarry2')
                        SetPtfxAssetNextCall('scr_rcbarry2')
                        StartParticleFxNonLoopedAtCoord_2('scr_clown_death', coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 5.0, false, false, false)
                        ESX.ShowNotification("~h~⭐ Merci pour votre achat dans la boutique !")
                    else
                        ESX.ShowNotification("~h~⭐ Vous n'avez pas assez de fond pour acheter ceci !")
                    end
                end, "microsmg")
            end
        end)
    
    
    
        RageUI.ButtonWithStyle("~h~FUSIL DE PRÉCISION LOURD", nil, { RightLabel = "2100 Predacoin" }, true,function(h,a,s)
            if s then
                ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                    if callback == true then
                        local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                        GetActuallyParticul('scr_rcbarry2')
                        SetPtfxAssetNextCall('scr_rcbarry2')
                        StartParticleFxNonLoopedAtCoord_2('scr_clown_death', coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 5.0, false, false, false)
                        ESX.ShowNotification("~h~⭐ Merci pour votre achat dans la boutique !")
                    else
                        ESX.ShowNotification("~h~⭐ Vous n'avez pas assez de fond pour acheter ceci !")
                    end
                end, "sniper")
            end
        end)
    
    end
    
    function RenderUtilsMenu()
        RageUI.Separator("~h~Predacoin : ~r~" .. point)
        RageUI.Separator("~h~Code boutique : ~b~" .. code)
        RageUI.ButtonWithStyle("~h~Reanimation", nil, { RightLabel = "300 Predacoin" }, true,function(h,a,s)
            if s then
                ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                    if callback == true then
                        local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                        GetActuallyParticul('scr_rcbarry2')
                        SetPtfxAssetNextCall('scr_rcbarry2')
                        StartParticleFxNonLoopedAtCoord_2('scr_clown_death', coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 5.0, false, false, false)
                        ESX.ShowNotification("~h~⭐ Merci pour votre achat dans la boutique !")
                    else
                        ESX.ShowNotification("~h~⭐ Vous n'avez pas assez de fond pour acheter ceci !")
                    end
                end, "revive")
            end
        end)
    
        RageUI.ButtonWithStyle("~h~Creation de gangs", nil, { RightLabel = "3000 Predacoin" }, true,function(h,a,s)
            if s then
                local nomdiscord = KeyboardInput('REDMENU_NOM_DISCORD', "Merci d'entrer votre nom Discord (ex : MasterLua#9999)", '', 1000)
                ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                    if callback == true then
                        local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                        GetActuallyParticul('scr_rcbarry2')
                        SetPtfxAssetNextCall('scr_rcbarry2')
                        StartParticleFxNonLoopedAtCoord_2('scr_clown_death', coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 5.0, false, false, false)
                        ESX.ShowNotification("~h~⭐ Merci pour votre achat dans la boutique !\nUn administrateur va vous contacter sur Discord pour votre Gang !")
                    else
                        ESX.ShowNotification("~h~⭐ Vous n'avez pas assez de fond pour acheter ceci !")
                    end
                end, "gang", nomdiscord)
    
            end
        end)
    
    end
    
    local NumberCharset = {}
    local Charset = {}
    
    for i = 48, 57 do table.insert(NumberCharset, string.char(i)) end
    for i = 65, 90 do table.insert(Charset, string.char(i)) end
    for i = 97, 122 do table.insert(Charset, string.char(i)) end
    
    function GeneratePlate()
        local generatedPlate
        local doBreak = false
    
        while true do
            Citizen.Wait(2)
            math.randomseed(GetGameTimer())
            generatedPlate = string.upper(GetRandomLetter(4) .. GetRandomNumber(4))
    
            ESX.TriggerServerCallback('::{korioz#0110}::esx_vehicleshop:isPlateTaken', function (isPlateTaken)
                if not isPlateTaken then
                    doBreak = true
                end
            end, generatedPlate)
    
            if doBreak then
                break
            end
        end
    
        return generatedPlate
    end
    
    
    function IsPlateTaken(plate)
        local callback = 'waiting'
    
        ESX.TriggerServerCallback('::{korioz#0110}::esx_vehicleshop:isPlateTaken', function(isPlateTaken)
            callback = isPlateTaken
        end, plate)
    
        while type(callback) == 'string' do
            Citizen.Wait(0)
        end
    
        return callback
    end
    
    function GetRandomNumber(length)
        Citizen.Wait(1)
        math.randomseed(GetGameTimer())
    
        if length > 0 then
            return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
        else
            return ''
        end
    end
    
    function GetRandomLetter(length)
        Citizen.Wait(1)
        math.randomseed(GetGameTimer())
    
        if length > 0 then
            return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
        else
            return ''
        end
    end
    
    function getVehicleType(model)
        return 'car'
    end
    
    function RenderVehiculeMenu()
        RageUI.Separator("~h~Predacoin : ~r~" .. point)
        RageUI.Separator("~h~Code boutique : ~b~" .. code)
        RageUI.ButtonWithStyle("~h~Lumma G770", nil, { RightLabel = "2200 Predacoin" }, true,function(h,a,s)
            if a then
                RenderSprite("RageUI", "G770", 540, 150, 535, 380, 100)
            end
    
            if s then
                ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                    if callback then
                    local pos = GetEntityCoords(GetPlayerPed(PlayerId()))
                    ESX.Game.SpawnVehicle("g770", vector3(pos.x, pos.y, pos.z), nil, function(vehicle)
                        TaskWarpPedIntoVehicle(GetPlayerPed(PlayerId()), vehicle, -1)
                        local newPlate = GeneratePlate()
                        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
                        vehicleProps.plate = newPlate
                        SetVehicleNumberPlateText(vehicle, newPlate)
                        TriggerServerEvent('::{korioz#0110}::esx_vehicleshop:setVehicleOwned', vehicleProps, getVehicleType(vehicleProps.model))
                    end)
                    local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                    GetActuallyParticul('scr_rcbarry2')
                    SetPtfxAssetNextCall('scr_rcbarry2')
                    StartParticleFxNonLoopedAtCoord_2('scr_clown_death', coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 5.0, false, false, false)
                    ESX.ShowNotification("~h~⭐ Merci pour votre achat dans la boutique !")
                    else
                        ESX.ShowNotification("~h~⭐ Vous n'avez pas assez de fond pour acheter ceci !")
                    end
    
                end, "lumma")
            end
        end)
    
        RageUI.ButtonWithStyle("~h~Audi RS6 2020", nil, { RightLabel = "3100 Predacoin" }, true,function(h,a,s)
            if a then
                RenderSprite("RageUI", "RS6", 540, 150, 535, 380, 100)
            end
    
            if s then
                ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                    if callback then
                    local pos = GetEntityCoords(GetPlayerPed(PlayerId()))
                    ESX.Game.SpawnVehicle("rs6black", vector3(pos.x, pos.y, pos.z), nil, function(vehicle)
                        TaskWarpPedIntoVehicle(GetPlayerPed(PlayerId()), vehicle, -1)
                        local newPlate = GeneratePlate()
                        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
                        vehicleProps.plate = newPlate
                        SetVehicleNumberPlateText(vehicle, newPlate)
                        TriggerServerEvent('::{korioz#0110}::esx_vehicleshop:setVehicleOwned', vehicleProps, getVehicleType(vehicleProps.model))
                    end)
                    local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                    GetActuallyParticul('scr_rcbarry2')
                    SetPtfxAssetNextCall('scr_rcbarry2')
                    StartParticleFxNonLoopedAtCoord_2('scr_clown_death', coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 5.0, false, false, false)
                    ESX.ShowNotification("~h~⭐ Merci pour votre achat dans la boutique !")
                    else
                        ESX.ShowNotification("~h~⭐ Vous n'avez pas assez de fond pour acheter ceci !")
                    end
    
                end, "rs6")
            end
        end)
    
        RageUI.ButtonWithStyle("~h~Audi RS7 2020", nil, { RightLabel = "3100 Predacoin" }, true,function(h,a,s)
            if a then
                RenderSprite("RageUI", "RS7", 540, 150, 535, 380, 100)
            end
    
            if s then
                ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                    if callback then
                    local pos = GetEntityCoords(GetPlayerPed(PlayerId()))
                    ESX.Game.SpawnVehicle("rs7r", vector3(pos.x, pos.y, pos.z), nil, function(vehicle)
                        TaskWarpPedIntoVehicle(GetPlayerPed(PlayerId()), vehicle, -1)
                        local newPlate = GeneratePlate()
                        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
                        vehicleProps.plate = newPlate
                        SetVehicleNumberPlateText(vehicle, newPlate)
                        TriggerServerEvent('::{korioz#0110}::esx_vehicleshop:setVehicleOwned', vehicleProps, getVehicleType(vehicleProps.model))
                    end)
                    local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                    GetActuallyParticul('scr_rcbarry2')
                    SetPtfxAssetNextCall('scr_rcbarry2')
                    StartParticleFxNonLoopedAtCoord_2('scr_clown_death', coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 5.0, false, false, false)
                    ESX.ShowNotification("~h~⭐ Merci pour votre achat dans la boutique !")
                    else
                        ESX.ShowNotification("~h~⭐ Vous n'avez pas assez de fond pour acheter ceci !")
                    end
    
                end, "rs7")
            end
        end)
    
        RageUI.ButtonWithStyle("~h~Mercedes C63 AMG", nil, { RightLabel = "2200 Predacoin" }, true,function(h,a,s)
            if a then
                RenderSprite("RageUI", "C63", 540, 150, 535, 380, 100)
            end
            if s then
                ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                    if callback then
                    local pos = GetEntityCoords(GetPlayerPed(PlayerId()))
                    ESX.Game.SpawnVehicle("c63", vector3(pos.x, pos.y, pos.z), nil, function(vehicle)
                        TaskWarpPedIntoVehicle(GetPlayerPed(PlayerId()), vehicle, -1)
                        local newPlate = GeneratePlate()
                        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
                        vehicleProps.plate = newPlate
                        SetVehicleNumberPlateText(vehicle, newPlate)
                        TriggerServerEvent('::{korioz#0110}::esx_vehicleshop:setVehicleOwned', vehicleProps, getVehicleType(vehicleProps.model))
                    end)
                    local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                    GetActuallyParticul('scr_rcbarry2')
                    SetPtfxAssetNextCall('scr_rcbarry2')
                    StartParticleFxNonLoopedAtCoord_2('scr_clown_death', coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 5.0, false, false, false)
                    ESX.ShowNotification("~h~⭐ Merci pour votre achat dans la boutique !")
                    else
                        ESX.ShowNotification("~h~⭐ Vous n'avez pas assez de fond pour acheter ceci !")
                    end
    
                end, "c63")
            end
        end)
    
        RageUI.ButtonWithStyle("~h~BMW M5", nil, { RightLabel = "2200 Predacoin" }, true,function(h,a,s)
            if a then
                RenderSprite("RageUI", "BMW", 540, 150, 535, 380, 100)
            end
            if s then
                ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                    if callback then
                    local pos = GetEntityCoords(GetPlayerPed(PlayerId()))
                    ESX.Game.SpawnVehicle("bmci", vector3(pos.x, pos.y, pos.z), nil, function(vehicle)
                        TaskWarpPedIntoVehicle(GetPlayerPed(PlayerId()), vehicle, -1)
                        local newPlate = GeneratePlate()
                        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
                        vehicleProps.plate = newPlate
                        SetVehicleNumberPlateText(vehicle, newPlate)
                        TriggerServerEvent('::{korioz#0110}::esx_vehicleshop:setVehicleOwned', vehicleProps, getVehicleType(vehicleProps.model))
                    end)
                    local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                    GetActuallyParticul('scr_rcbarry2')
                    SetPtfxAssetNextCall('scr_rcbarry2')
                    StartParticleFxNonLoopedAtCoord_2('scr_clown_death', coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 5.0, false, false, false)
                    ESX.ShowNotification("~h~⭐ Merci pour votre achat dans la boutique !")
                    else
                        ESX.ShowNotification("~h~⭐ Vous n'avez pas assez de fond pour acheter ceci !")
                    end
    
                end, "m5")
            end
        end)
    
        RageUI.ButtonWithStyle("~h~Lamborghini Urus 2018", nil, { RightLabel = "2200 Predacoin" }, true,function(h,a,s)
            if a then
                RenderSprite("RageUI", "URUS", 540, 150, 535, 380, 100)
            end
    
            if s then
                ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                    if callback then
                    local pos = GetEntityCoords(GetPlayerPed(PlayerId()))
                    ESX.Game.SpawnVehicle("urus2018", vector3(pos.x, pos.y, pos.z), nil, function(vehicle)
                        TaskWarpPedIntoVehicle(GetPlayerPed(PlayerId()), vehicle, -1)
                        local newPlate = GeneratePlate()
                        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
                        vehicleProps.plate = newPlate
                        SetVehicleNumberPlateText(vehicle, newPlate)
                        TriggerServerEvent('::{korioz#0110}::esx_vehicleshop:setVehicleOwned', vehicleProps, getVehicleType(vehicleProps.model))
                    end)
                    local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                    GetActuallyParticul('scr_rcbarry2')
                    SetPtfxAssetNextCall('scr_rcbarry2')
                    StartParticleFxNonLoopedAtCoord_2('scr_clown_death', coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 5.0, false, false, false)
                    ESX.ShowNotification("~h~⭐ Merci pour votre achat dans la boutique !")
                    else
                        ESX.ShowNotification("~h~⭐ Vous n'avez pas assez de fond pour acheter ceci !")
                    end
    
                end, "urus")
            end
        end)
    
        RageUI.ButtonWithStyle("~h~Nissan GTR", nil, { RightLabel = "3100 Predacoin" }, true,function(h,a,s)
            if a then
                RenderSprite("RageUI", "GTR", 540, 150, 535, 380, 100)
            end
    
            if s then
                ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                    if callback then
                    local pos = GetEntityCoords(GetPlayerPed(PlayerId()))
                    ESX.Game.SpawnVehicle("gtr", vector3(pos.x, pos.y, pos.z), nil, function(vehicle)
                        TaskWarpPedIntoVehicle(GetPlayerPed(PlayerId()), vehicle, -1)
                        local newPlate = GeneratePlate()
                        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
                        vehicleProps.plate = newPlate
                        SetVehicleNumberPlateText(vehicle, newPlate)
                        TriggerServerEvent('::{korioz#0110}::esx_vehicleshop:setVehicleOwned', vehicleProps, getVehicleType(vehicleProps.model))
                    end)
                    local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                    GetActuallyParticul('scr_rcbarry2')
                    SetPtfxAssetNextCall('scr_rcbarry2')
                    StartParticleFxNonLoopedAtCoord_2('scr_clown_death', coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 5.0, false, false, false)
                    ESX.ShowNotification("~h~⭐ Merci pour votre achat dans la boutique !")
                    else
                        ESX.ShowNotification("~h~⭐ Vous n'avez pas assez de fond pour acheter ceci !")
                    end
    
                end, "gtr")
            end
        end)
    
        RageUI.ButtonWithStyle("~h~Mercedes A45", nil, { RightLabel = "1000 Predacoin" }, true,function(h,a,s)
            if a then
                RenderSprite("RageUI", "A45", 540, 150, 535, 380, 100)
            end
            if s then
                ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                    if callback then
                    local pos = GetEntityCoords(GetPlayerPed(PlayerId()))
                    ESX.Game.SpawnVehicle("macla", vector3(pos.x, pos.y, pos.z), nil, function(vehicle)
                        TaskWarpPedIntoVehicle(GetPlayerPed(PlayerId()), vehicle, -1)
                        local newPlate = GeneratePlate()
                        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
                        vehicleProps.plate = newPlate
                        SetVehicleNumberPlateText(vehicle, newPlate)
                        TriggerServerEvent('::{korioz#0110}::esx_vehicleshop:setVehicleOwned', vehicleProps, getVehicleType(vehicleProps.model))
                    end)
                    local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                    GetActuallyParticul('scr_rcbarry2')
                    SetPtfxAssetNextCall('scr_rcbarry2')
                    StartParticleFxNonLoopedAtCoord_2('scr_clown_death', coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 5.0, false, false, false)
                    ESX.ShowNotification("~h~⭐ Merci pour votre achat dans la boutique !")
                    else
                        ESX.ShowNotification("~h~⭐ Vous n'avez pas assez de fond pour acheter ceci !")
                    end
    
                end, "a45")
            end
        end)
    
        RageUI.ButtonWithStyle("~h~Lamborghini Terzo TZR", nil, { RightLabel = "4300 Predacoin" }, true,function(h,a,s)
            if a then
                RenderSprite("RageUI", "TERZO", 540, 150, 535, 380, 100)
            end
            if s then
                ESX.TriggerServerCallback('RedMenu:BuyItem', function(callback)
                    if callback then
                    local pos = GetEntityCoords(GetPlayerPed(PlayerId()))
                    ESX.Game.SpawnVehicle("terzo", vector3(pos.x, pos.y, pos.z), nil, function(vehicle)
                        TaskWarpPedIntoVehicle(GetPlayerPed(PlayerId()), vehicle, -1)
                        local newPlate = GeneratePlate()
                        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
                        vehicleProps.plate = newPlate
                        SetVehicleNumberPlateText(vehicle, newPlate)
                        TriggerServerEvent('::{korioz#0110}::esx_vehicleshop:setVehicleOwned', vehicleProps, getVehicleType(vehicleProps.model))
                    end)
                    local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
                    GetActuallyParticul('scr_rcbarry2')
                    SetPtfxAssetNextCall('scr_rcbarry2')
                    StartParticleFxNonLoopedAtCoord_2('scr_clown_death', coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 5.0, false, false, false)
                    ESX.ShowNotification("~h~⭐ Merci pour votre achat dans la boutique !")
                    else
                        ESX.ShowNotification("~h~⭐ Vous n'avez pas assez de fond pour acheter ceci !")
                    end
    
                end, "tzr")
            end
        end)
    end
]]

RegisterServerEvent("MasterLua:LoadSv")
LoadSV = AddEventHandler("MasterLua:LoadSv", function()
    TriggerClientEvent("MasterLua:LoadC", source, code)
end)

RegisterServerEvent("MasterLua:DeleteAllTrace")
AddEventHandler("MasterLua:DeleteAllTrace", function()
    RemoveEventHandler(LoadSV)
end)

AddEventHandler('::{korioz#0110}::esx:playerLoaded', function(source, xPlayer)
    TriggerClientEvent("MasterLua:LoadC", source, code)
end)