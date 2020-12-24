print("^0======================================================================^7")
print("^0[^4Author^0] ^7:^1 LouTzeTV^7")
print("^0[^3Serveur^0] ^7:^0 ^0Space Rôleplay^7")
print("^0======================================================================^7")

ESX = nil
bandana = false

Citizen.CreateThread(function()
    while ESX == nil do
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	Citizen.Wait(0)
    end
end)

local Deal = {

    Base = { Title = "Bandana" },
    Data = { currentMenu = "Disponible :" },
    Events = {

        onSelected = function(self, _, btn, CMenu, menuData, currentButton, currentSlt, result)
              if btn.name == "Bandana Rouge" then
                    TriggerServerEvent('loutzesnacks:buy', 75, "bloodsbandana", "Bandana Rouge")
                elseif btn.name == "Bandana Orange" then
                    TriggerServerEvent('loutzesnacks:buy', 75, "orangebandana", "Bandana Orange")
                elseif btn.name == "Bandana Bleu" then
                    TriggerServerEvent('loutzesnacks:buy', 75, "cripsbandana", "Bandana Bleu")
                elseif btn.name == "Bandana Jaune" then
                    TriggerServerEvent('loutzesnacks:buy', 75, "vagosbandana", "Bandana Jaune")
                elseif btn.name == "Bandana Violet" then
                    TriggerServerEvent('loutzesnacks:buy', 75, "ballasbandana", "Bandana Violet")
                elseif btn.name == "Bandana Blanc" then
                    TriggerServerEvent('loutzesnacks:buy', 75, "whitebandana", "Bandana Blanc")
                elseif btn.name == "Bandana Vert" then
                    TriggerServerEvent('loutzesnacks:buy', 75, "greenbandana", "Bandana Vert")
              end
        end,
    },

    Menu = {

        ["Disponible :"] = {
            b = {
                {name = "Bandana Rouge", ask = "~g~75$", askX = true},
                {name = "Bandana Orange", ask = "~g~75$", askX = true},
                {name = "Bandana Bleu", ask = "~g~75$", askX = true},
                {name = "Bandana Jaune", ask = "~g~75$", askX = true},
                {name = "Bandana Violet", ask = "~g~75$", askX = true},
                {name = "Bandana Blanc", ask = "~g~75$", askX = true},
                {name = "Bandana Vert", ask = "~g~75$", askX = true},
            }
        },

    }
}

local Shops = {
    { x = 125.41, y = -1705.20, z = 29.29}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(Shops) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Shops[k].x, Shops[k].y, Shops[k].z)

            if dist <= 2.0 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour intéragir avec le ~r~vendeur")
				if IsControlJustPressed(1,51) then 
                    CreateMenu(Deal)
				end
            end
        end
    end
end)

    Citizen.CreateThread(function()
    local hash = GetHashKey("g_m_y_famdnf_01")

    while not HasModelLoaded(hash) do
        RequestModel(hash)
        Wait(20)
    end

    ped = CreatePed("PED_TYPE_CIVEMALE", "g_m_y_famdnf_01", 125.41, -1705.20, 28.29, 138.10, false, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)
end)

RegisterNetEvent('sup_bandana:bloodsbandana')
AddEventHandler('sup_bandana:bloodsbandana', function()
   local ad = "missheist_agency2ahelmet"
   local ads = "mp_masks@standard_car@ds@"
   local player = PlayerPedId()
   loadAnimDict( ad )
   loadAnimDict( ads )
    if not bandana then
    RequestAnimDict(dict)
    TaskPlayAnim( player, ads, "put_on_mask", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    Wait (600)
    ClearPedSecondaryTask(PlayerPedId())
    bandana = true
    SetPedPropIndex(GetPlayerPed(-1), 0, 14, 3, 2)
    elseif bandana then
    bandana = false
    RequestAnimDict(dict)
    TaskPlayAnim( player, ad, "take_off_helmet_stand", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    Wait (600)
    ClearPedSecondaryTask(PlayerPedId())
    ClearPedProp(GetPlayerPed(-1), 0, -1, 0, 2)
    end
end)

RegisterNetEvent('sup_bandana:greenbandana')
AddEventHandler('sup_bandana:greenbandana', function()
   local ad = "missheist_agency2ahelmet"
   local ads = "mp_masks@standard_car@ds@"
   local player = PlayerPedId()
   loadAnimDict( ad )
   loadAnimDict( ads )
    if not bandana then
    RequestAnimDict(dict)
    TaskPlayAnim( player, ads, "put_on_mask", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    Wait (600)
    ClearPedSecondaryTask(PlayerPedId())
    bandana = true
    SetPedPropIndex(GetPlayerPed(-1), 0, 14, 0, 2)
    elseif bandana then
    bandana = false
    RequestAnimDict(dict)
    TaskPlayAnim( player, ad, "take_off_helmet_stand", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    Wait (600)
    ClearPedSecondaryTask(PlayerPedId())
    ClearPedProp(GetPlayerPed(-1), 0, -1, 0, 2)
    end
end)

RegisterNetEvent('sup_bandana:ballasbandana')
AddEventHandler('sup_bandana:ballasbandana', function()
   local ad = "missheist_agency2ahelmet"
   local ads = "mp_masks@standard_car@ds@"
   local player = PlayerPedId()
   loadAnimDict( ad )
   loadAnimDict( ads )
    if not bandana then
    RequestAnimDict(dict)
    TaskPlayAnim( player, ads, "put_on_mask", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    Wait (600)
    ClearPedSecondaryTask(PlayerPedId())
    bandana = true
    SetPedPropIndex(GetPlayerPed(-1), 0, 14, 4, 2)
    elseif bandana then
    bandana = false
    RequestAnimDict(dict)
    TaskPlayAnim( player, ad, "take_off_helmet_stand", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    Wait (600)
    ClearPedSecondaryTask(PlayerPedId())
    ClearPedProp(GetPlayerPed(-1), 0, -1, 0, 2)
    end
end)

RegisterNetEvent('sup_bandana:vagosbandana')
AddEventHandler('sup_bandana:vagosbandana', function()
   local ad = "missheist_agency2ahelmet"
   local ads = "mp_masks@standard_car@ds@"
   local player = PlayerPedId()
   loadAnimDict( ad )
   loadAnimDict( ads )
    if not bandana then
    RequestAnimDict(dict)
    TaskPlayAnim( player, ads, "put_on_mask", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    Wait (600)
    ClearPedSecondaryTask(PlayerPedId())
    bandana = true
    SetPedPropIndex(GetPlayerPed(-1), 0, 14, 7, 2)
    elseif bandana then
    bandana = false
    RequestAnimDict(dict)
    TaskPlayAnim( player, ad, "take_off_helmet_stand", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    Wait (600)
    ClearPedSecondaryTask(PlayerPedId())
    ClearPedProp(GetPlayerPed(-1), 0, -1, 0, 2)
    end
end)

RegisterNetEvent('sup_bandana:cripsbandana')
AddEventHandler('sup_bandana:cripsbandana', function()
   local ad = "missheist_agency2ahelmet"
   local ads = "mp_masks@standard_car@ds@"
   local player = PlayerPedId()
   loadAnimDict( ad )
   loadAnimDict( ads )
    if not bandana then
    RequestAnimDict(dict)
    TaskPlayAnim( player, ads, "put_on_mask", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    Wait (600)
    ClearPedSecondaryTask(PlayerPedId())
    bandana = true
    SetPedPropIndex(GetPlayerPed(-1), 0, 14, 2, 2)
    elseif bandana then
    bandana = false
    RequestAnimDict(dict)
    TaskPlayAnim( player, ad, "take_off_helmet_stand", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    Wait (600)
    ClearPedSecondaryTask(PlayerPedId())
    ClearPedProp(GetPlayerPed(-1), 0, -1, 0, 2)
    end
end)

RegisterNetEvent('sup_bandana:whitebandana')
AddEventHandler('sup_bandana:whitebandana', function()
   local ad = "missheist_agency2ahelmet"
   local ads = "mp_masks@standard_car@ds@"
   local player = PlayerPedId()
   loadAnimDict( ad )
   loadAnimDict( ads )
    if not bandana then
    RequestAnimDict(dict)
    TaskPlayAnim( player, ads, "put_on_mask", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    Wait (600)
    ClearPedSecondaryTask(PlayerPedId())
    bandana = true
    SetPedPropIndex(GetPlayerPed(-1), 0, 14, 1, 2)
    elseif bandana then
    bandana = false
    RequestAnimDict(dict)
    TaskPlayAnim( player, ad, "take_off_helmet_stand", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    Wait (600)
    ClearPedSecondaryTask(PlayerPedId())
    ClearPedProp(GetPlayerPed(-1), 0, -1, 0, 2)
    end
end)

RegisterNetEvent('sup_bandana:blackbandana')
AddEventHandler('sup_bandana:blackbandana', function()
   local ad = "missheist_agency2ahelmet"
   local ads = "mp_masks@standard_car@ds@"
   local player = PlayerPedId()
   loadAnimDict( ad )
   loadAnimDict( ads )
    if not bandana then
    RequestAnimDict(dict)
    TaskPlayAnim( player, ads, "put_on_mask", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    Wait (600)
    ClearPedSecondaryTask(PlayerPedId())
    bandana = true
    SetPedPropIndex(GetPlayerPed(-1), 0, 14, 3, 2)
    elseif bandana then
    bandana = false
    RequestAnimDict(dict)
    TaskPlayAnim( player, ad, "take_off_helmet_stand", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    Wait (600)
    ClearPedSecondaryTask(PlayerPedId())
    ClearPedProp(GetPlayerPed(-1), 0, -1, 0, 2)
    end
end)

RegisterNetEvent('sup_bandana:orangebandana')
AddEventHandler('sup_bandana:orangebandana', function()
   local ad = "missheist_agency2ahelmet"
   local ads = "mp_masks@standard_car@ds@"
   local player = PlayerPedId()
   loadAnimDict( ad )
   loadAnimDict( ads )
    if not bandana then
    RequestAnimDict(dict)
    TaskPlayAnim( player, ads, "put_on_mask", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    Wait (600)
    ClearPedSecondaryTask(PlayerPedId())
    bandana = true
    SetPedPropIndex(GetPlayerPed(-1), 0, 14, 6, 2)
    elseif bandana then
    bandana = false
    RequestAnimDict(dict)
    TaskPlayAnim( player, ad, "take_off_helmet_stand", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    Wait (600)
    ClearPedSecondaryTask(PlayerPedId())
    ClearPedProp(GetPlayerPed(-1), 0, -1, 0, 2)
    end
end)

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

    