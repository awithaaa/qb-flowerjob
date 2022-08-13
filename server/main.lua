local QBCore = exports['qb-core']:GetCoreObject()

-------------------------flower-------------------------
QBCore.Functions.CreateCallback('qb-flowerjob:server:get:bucket', function (source,cb)
    local src = source
    local ply = QBCore.Functions.GetPlayer(src)
    local bucket = ply.Functions.GetItemByName("emp_bucket")
    if bucket ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent("qb-flowerjob:server:flowerpick")
AddEventHandler("qb-flowerjob:server:flowerpick", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
        Player.Functions.AddItem("flower", 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["flower"], "add")
        TriggerClientEvent('QBCore:Notify', src, 'Picked your flowers.', "success")
end)

-----------------------flower--process--------------------------

QBCore.Functions.CreateCallback('qb-flowerjob:server:get:processflo', function(source, cb)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local flower = Ply.Functions.GetItemByName("flower")
    local paper = Ply.Functions.GetItemByName("flower_paper")
    if flower ~= nil and paper ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent('qb-flowerjob:server:processflo', function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local flower = 1
    Player.Functions.RemoveItem('flower', 2)
    Player.Functions.RemoveItem('flower_paper', 1)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['flower'], "remove")
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['flower_paper'], "remove")
    Wait(1000)
    Player.Functions.AddItem('flower_bulck', flower)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['flower_bulck'], "add")
    TriggerClientEvent('QBCore:Notify', source, "Successfully ", "success")
end)

---------------------packing flower-------------------

QBCore.Functions.CreateCallback('qb-flowerjob:server:get:packingflo', function(source, cb)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local bulck = Ply.Functions.GetItemByName("flower_bulck")
    local box = Ply.Functions.GetItemByName("emp_flower_box")
    if bulck ~= nil and box ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent('qb-flowerjob:server:packingflo', function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local amount = 1
    Player.Functions.RemoveItem('flower_bulck', 1)
    Player.Functions.RemoveItem('emp_flower_box', 1)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['flower_bulck'], "remove")
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['emp_flower_box'], "remove")
    Wait(1000)
    Player.Functions.AddItem('flower_box', amount)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['flower_box'], "add")
    TriggerClientEvent('QBCore:Notify', source, "Successfully ", "success")
end)

-------------------------seller-------------------------------
QBCore.Functions.CreateCallback('qb-flowerjob:server:get:sellflower', function(source, cb)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local rose = Ply.Functions.GetItemByName("flower_box")
    if rose ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent('qb-flowerjob:server:sellflower')
AddEventHandler('qb-flowerjob:server:sellflower', function()

    local xPlayer = QBCore.Functions.GetPlayer(source)
	local Item = xPlayer.Functions.GetItemByName('flower_box')
   
	
	if Item == nil then
       TriggerClientEvent('QBCore:Notify', source, 'You dont have Flower Boxes', "error")  
	else
	 for k, v in pairs(Config.Prices) do
        
		
		if Item.amount > 0 then
            local reward = math.random(400, 450)
            -- for i = 1, Item.amount do
            --     --reward = reward + math.random(v[1], v[2])
            --     reward = reward + math.random(1, 2)
            -- end
			xPlayer.Functions.RemoveItem('flower_box', 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['flower_box'], "remove")
			xPlayer.Functions.AddMoney("cash", reward, "sold-pawn-items")
			TriggerClientEvent('QBCore:Notify', source, 'Successfully Selling.', "success")  
			--end
        end
     end
	end
end)