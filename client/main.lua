local QBCore = exports['qb-core']:GetCoreObject()
isLoggedIn = false
inshop = false
local Seller = Config.Seller.coords
local PedModel = Config.PedModel
local PedHash = Config.PedHash

CreateThread(function()
    for k, garden in pairs(Config.Locations["garden"]) do
        local blip = AddBlipForCoord(garden.coords.x, garden.coords.y, garden.coords.z)
        SetBlipSprite(blip, 587)
        SetBlipAsShortRange(blip, true)
        SetBlipScale(blip, 0.6)
        SetBlipColour(blip, 8)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(garden.label)
        EndTextCommandSetBlipName(blip)
    end
end)

CreateThread(function()
    for k, floseller in pairs(Config.Locations["floseller"]) do
        local blip = AddBlipForCoord(floseller.coords.x, floseller.coords.y, floseller.coords.z)
        SetBlipSprite(blip, 642)
        SetBlipAsShortRange(blip, true)
        SetBlipScale(blip, 0.6)
        SetBlipColour(blip, 37)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(floseller.label)
        EndTextCommandSetBlipName(blip)
    end
end)

-------------------------flower-------------------------
RegisterNetEvent("qb-flowerjob:client:flowerpick")
AddEventHandler("qb-flowerjob:client:flowerpick", function ()
    QBCore.Functions.TriggerCallback('qb-flowerjob:server:get:bucket', function(hasItem)
        if hasItem then
            QBCore.Functions.Progressbar('search_flower', Config.ProcessName['pickflower'], Config.ProcessTime['pickflower'], false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = 'anim@gangops@facility@servers@',
                anim = 'hotwire',
                flags = 16,
            }, {}, {}, function() -- Play When Done
                TriggerServerEvent("qb-flowerjob:server:flowerpick")
                ClearPedTasks(playerPed)
            end, function ()
                QBCore.Functions.Notify(Config.Notify['cancel'], "error")
            end)
        elseif not hasItem then
            QBCore.Functions.Notify(Config.Notify['bucket'], 'error', 5000)
        end
    end)
end)

-----------------------flower--process--------------------------
RegisterNetEvent("qb-flowerjob:client:processflo")
AddEventHandler("qb-flowerjob:client:processflo", function ()
    QBCore.Functions.TriggerCallback('qb-flowerjob:server:get:processflo', function(hasItem)
        if hasItem then
            QBCore.Functions.Progressbar('process_flo', Config.ProcessName['proflowers'], Config.ProcessTime['proflowers'], false, true, { 
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = 'anim@gangops@facility@servers@',
                anim = 'hotwire',
                flags = 16,
            }, {}, {}, function() -- Play When Done
                TriggerServerEvent("qb-flowerjob:server:processflo")
            end, function ()
                QBCore.Functions.Notify(Config.Notify['cancel'], "error")
            end)
        elseif not hasItem then
            QBCore.Functions.Notify(Config.Notify['no_item'], 'error', 5000)
        end
    end)
end)

--------------------------flower-process-2-----------------------------------
RegisterNetEvent("qb-flowerjob:client:packingflo")
AddEventHandler("qb-flowerjob:client:packingflo", function ()
    QBCore.Functions.TriggerCallback('qb-flowerjob:server:get:packingflo', function (hasItem)
        if hasItem then
            QBCore.Functions.Progressbar('pack', Config.ProcessName['packflowers'], Config.ProcessTime['packflowers'], false, true, { -- Name | Label | Time | useWhileDead | canCancel
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = 'anim@gangops@facility@servers@',
                anim = 'hotwire',
                flags = 16,
            }, {}, {}, function() -- Play When Done
                TriggerServerEvent("qb-flowerjob:server:packingflo")
            end, function() -- Play When Cancel
                --Stuff goes here
                QBCore.Functions.Notify(Config.Notify['cancel'], "error")
            end)
        elseif not hasItem then    
            QBCore.Functions.Notify(Config.Notify['no_item'], 'error', 5000)
        end
    end)
end)

---------------------------ped-----------------------------
CreateThread(function()
    RequestModel( GetHashKey( PedModel ) )
    while (not HasModelLoaded( GetHashKey( PedModel))) do
        Wait(1)  
    end
    floseller = CreatePed(1, PedHash, Seller, false, true)
    SetEntityInvincible(floseller, true)
    SetBlockingOfNonTemporaryEvents(floseller, true)
    FreezeEntityPosition(floseller, true)
end)


-------------------------------selling--flowers------------------------------
RegisterNetEvent("qb-flowerjob:client:sellflower")
AddEventHandler("qb-flowerjob:client:sellflower", function ()
    QBCore.Functions.TriggerCallback('qb-flowerjob:server:get:sellflower', function (hasItem)
        if hasItem then
            TriggerEvent('animations:client:EmoteCommandStart', {"Clipboard"})
            QBCore.Functions.Progressbar('sell_flower', Config.ProcessName['sellflowers'], Config.ProcessTime['sellflowers'], false, true, { 
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },{}, {}, {}, function() -- Play When Done
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                TriggerServerEvent("qb-flowerjob:server:sellflower")
                ClearPedTasks(playerPed)
            end, function ()
                QBCore.Functions.Notify(Config.Notify['cancel'], "error")
            end)
        elseif not hasItem then
            QBCore.Functions.Notify(Config.Notify['no_sell_item'], 'error', 5000)
        end
    end)
end)    

--------------------shop-----------------------------------

RegisterNetEvent("qb-flowerjob:client:openshop")
AddEventHandler("qb-flowerjob:client:openshop", function ()
    TriggerEvent('animations:client:EmoteCommandStart', {"ATM"})
    QBCore.Functions.Progressbar('open_shop', Config.ProcessName['openshop'], Config.ProcessTime['openshop'], false, true, { 
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    },{}, {}, {}, function() -- Play When Done
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerEvent('qb-flowerjob:shop')
        ClearPedTasks(playerPed)
        QBCore.Functions.Notify(Config.Notify['openshop'])
    end, function ()
        QBCore.Functions.Notify(Config.Notify['cancel'], "error")
    end)
end)

RegisterNetEvent("qb-flowerjob:shop")
AddEventHandler("qb-flowerjob:shop", function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "flowerjob", Config.Items)
end)


-------------------location--------------------------------
Citizen.CreateThread(function ()
    exports['qb-target']:AddBoxZone("flowertree1", vector3(1580.06, 2155.73, 79.48), 5, 2,{
        name = "flowertree1",
        heading = 260,
        debugPoly = false,
        minZ=75.88,
        maxZ=79.88
    }, {
        options = {
            {
                event = "qb-flowerjob:client:flowerpick",
                icon = "fas fa-circle",
                label = "Pick Flowers",
            },
        },
        distance = 2
    })
    exports['qb-target']:AddBoxZone("flowertree2", vector3(1585.75, 2160.9, 79.44), 5, 2,{
        name = "flowertree2",
        heading = 305,
        debugPoly = false,
        minZ=76.24,
        maxZ=80.24
    }, {
        options = {
            {
                event = "qb-flowerjob:client:flowerpick",
                icon = "fas fa-circle",
                label = "Pick Flowers",
            },
        },
        distance = 2
    })
    exports['qb-target']:AddBoxZone("flowertree3", vector3(1578.39, 2164.37, 79.31), 5, 2,{
        name = "flowertree3",
        heading = 240,
        debugPoly = false,
        minZ=75.91,
        maxZ=79.91
    }, {
        options = {
            {
                event = "qb-flowerjob:client:flowerpick",
                icon = "fas fa-circle",
                label = "Pick Flowers",
            },
        },
        distance = 2
    })
    exports['qb-target']:AddBoxZone("flowertree4", vector3(1581.14, 2168.03, 79.39), 5, 2, {
        name = "flowertree4",
        heading = 260,
        debugPoly = false,
        minZ=75.79,
        maxZ=79.79
    }, {
        options = {
            {
                event = "qb-flowerjob:client:flowerpick",
                icon = "fas fa-circle",
                label = "Pick Flowers",
            },
        },
        distance = 2
    })
    exports['qb-target']:AddBoxZone("flowertree5", vector3(1584.03, 2173.1, 79.23), 5, 2, {
        name = "flowertree5",
        heading = 260,
        debugPoly = false,
        minZ=75.63,
        maxZ=79.63
    }, {
        options = {
            {
                event = "qb-flowerjob:client:flowerpick",
                icon = "fas fa-circle",
                label = "Pick Flowers",
            },
        },
        distance = 2
    })
    exports['qb-target']:AddBoxZone("process1",vector3(1557.98, 2159.49, 78.74), 1, 1,{
        name = "process1",
        heading = 0,
        debugPoly = false,
        minZ=74.74,
        maxZ=78.74
    }, {
        options = {
            {
                event = "qb-flowerjob:client:processflo",
                icon = "fas fa-circle",
                label = "Process Flowers",
            },
            {
                event = "qb-flowerjob:client:packingflo",
                icon = "fas fa-circle",
                label = "Packing Flowers",
            },
        },
        distance = 2
    })
    exports['qb-target']:AddBoxZone("process2",vector3(1558.11, 2161.04, 78.77), 1, 1, {
        name = "process2",
        heading = 0,
        debugPoly = false,
        minZ=74.77,
        maxZ=78.77
    }, {
        options = {
            {
                event = "qb-flowerjob:client:processflo",
                icon = "fas fa-circle",
                label = "Process Flowers",
            },
            {
                event = "qb-flowerjob:client:packingflo",
                icon = "fas fa-circle",
                label = "Packing Flowers",
            },
        },
        distance = 2
    })
    exports['qb-target']:AddBoxZone("process3",vector3(1558.24, 2162.45, 78.75), 1, 1, {
        name = "process3",
        heading = 0,
        debugPoly = false,
        minZ=74.75,
        maxZ=78.75
    }, {
        options = {
            {
                event = "qb-flowerjob:client:processflo",
                icon = "fas fa-circle",
                label = "Process Flowers",
            },
            {
                event = "qb-flowerjob:client:packingflo",
                icon = "fas fa-circle",
                label = "Packing Flowers",
            },
        },
        distance = 2
    })
    exports['qb-target']:AddBoxZone("sell", vector3(1551.02, 2189.8, 78.85), 1, 1, {
        name = "sell",
        heading = 0,
        debugPoly = false,
        minZ=75.65,
        maxZ=79.65
    }, {
        options = {
            {
                event = "qb-flowerjob:client:sellflower",
                icon = "fas fa-circle",
                label = "Sell Flowers",
            },
        },
        distance = 2
    })
    exports['qb-target']:AddBoxZone("shop", vector3(1552.04, 2154.95, 78.89), 2, 1, {
        name = "shop",
        heading = 270,
        debugPoly = false,
        minZ=75.49,
        maxZ=79.49
    }, {
        options = {
            {
                event = "qb-flowerjob:client:openshop",
                icon = "fas fa-shop",
                label = "Open Shop",
            },
        },
        distance = 2
    })
end)