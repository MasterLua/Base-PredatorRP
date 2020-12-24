ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('loutzesnacks:buy')
AddEventHandler('loutzesnacks:buy', function(price, item, label)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getMoney() >= price then
	xPlayer.removeMoney(price)
    	xPlayer.addInventoryItem(item, 1)

        TriggerClientEvent('esx:showNotification', source, "Vous avez acheté un ~r~bandana~s~ pour 75$ !", "", 1)
     else
          TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas assez ~r~d'argent sur vous !")    end
end)

ESX.RegisterUsableItem('bloodsbandana', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('sup_bandana:bloodsbandana', source)
end)

ESX.RegisterUsableItem('greenbandana', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('sup_bandana:greenbandana', source)
end)

ESX.RegisterUsableItem('ballasbandana', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('sup_bandana:ballasbandana', source)
end)

ESX.RegisterUsableItem('vagosbandana', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('sup_bandana:vagosbandana', source)
end)

ESX.RegisterUsableItem('cripsbandana', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('sup_bandana:cripsbandana', source)
end)

ESX.RegisterUsableItem('whitebandana', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('sup_bandana:whitebandana', source)
end)

ESX.RegisterUsableItem('blackbandana', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('sup_bandana:blackbandana', source)
end)

ESX.RegisterUsableItem('orangebandana', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('sup_bandana:orangebandana', source)
end)