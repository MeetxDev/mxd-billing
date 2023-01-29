local QBCore = exports['qb-core']:GetCoreObject()
local TargetArray = {}

QBCore.Functions.CreateCallback('mxd-billing:server:BillCheck', function(source, cb)
    cb(TargetArray)
end)

QBCore.Functions.CreateCallback('mxd-billing:server:HasBillmoney', function(source, cb, data, shop)
    local retval = false
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local recieversrc = TargetArray[Player.PlayerData.citizenid]["shops"][shop]['keepersrc']
    local Reciever = QBCore.Functions.GetPlayer(recieversrc)
    
	if Player.Functions.RemoveMoney("cash", data.amount, "Bill") then
        TriggerClientEvent('QBCore:Notify', src, "You paid $" ..data.amount.. " for bill", 'success')
        Reciever.Functions.AddMoney("cash", data.amount, "Bill")
        TriggerClientEvent('QBCore:Notify', recieversrc, "You received $" ..data.amount, 'success')
        TriggerEvent('mxd-billing:server:orderdone',data, shop)
        retval = true
    elseif Player.Functions.RemoveMoney("bank", data.amount, "Bill") then
        TriggerClientEvent('QBCore:Notify', src, "You paid $" ..data.amount.. " for bill", 'success')
        Reciever.Functions.AddMoney("bank", data.amount, "Bill")
        TriggerClientEvent('QBCore:Notify', recieversrc, "You received $" ..data.amount, 'success')
        TriggerEvent('mxd-billing:server:orderdone',data, shop)
        retval = true
    else
        TriggerClientEvent('QBCore:Notify', src, "You need $" ..data.amount.. " to pay for bill", 'error')
        retval = false
    end
    cb(retval)
end)

RegisterServerEvent('mxd-billing:server:billplayerfood', function(targetid, amount, shopname)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Target = QBCore.Functions.GetPlayer(tonumber(targetid))

    if Target then
        
        local Targetcid = Target.PlayerData.citizenid

        if TargetArray[Targetcid] == nil then
            TargetArray[Targetcid] = {}
            TargetArray[Targetcid]["shops"] = {}
        end

        values = {targetid = Targetcid, cantarget = true, amount = amount, targetsrc = tonumber(targetid), keepersrc = src, shopname= shopname}

        if TargetArray[Targetcid]["shops"][shopname] == nil then
            TargetArray[Targetcid]["shops"][shopname] = values
        else
            for k, v in pairs(values) do
                TargetArray[Targetcid]["shops"][shopname][k] = v
            end
        end


        TriggerClientEvent('mxd-billing:client:openbillstash', src, Targetcid, shopname)


    else
        TriggerClientEvent('QBCore:Notify', src, "Person Not Found", 'error')
    end
end)

RegisterServerEvent('mxd-billing:server:billplayerfoodtakeorder', function(targetid, amount, shopname)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Target = QBCore.Functions.GetPlayer(tonumber(targetid))
    local datatake = {tarid = targetid}

    if Target then
        local Targetcid = Target.PlayerData.citizenid
        TriggerClientEvent('mxd-billing:client:openbillstash', src, Targetcid, shopname)
        TargetArray[Targetcid]["shops"][shopname]['targetid'] = nil
        TargetArray[Targetcid]["shops"][shopname]['cantarget'] = false
        TargetArray[Targetcid]["shops"][shopname]['amount'] = 0
        TargetArray[Targetcid]["shops"][shopname]['targetsrc'] = 0
        TargetArray[Targetcid]["shops"][shopname]['keepersrc'] = 0
        TargetArray[Targetcid]["shops"][shopname]['shopname'] = nil
    else
        TriggerClientEvent('QBCore:Notify', src, "Person Not Found", 'error')

    end
end)

RegisterServerEvent('mxd-billing:server:cancelorder', function(data)

    TriggerClientEvent('QBCore:Notify',TargetArray[data.tarid]["shops"][data.shopname]['keepersrc'], "Order of id "..TargetArray[data.tarid]["shops"][data.shopname]['targetsrc'].." is cancelled. Please take your items from that Tray", 'error')
    TriggerEvent('mxd-billing:server:orderdone', data, data.shopname)

end)


RegisterServerEvent('mxd-billing:server:orderdone', function(data, shopname)

    TargetArray[data.tarid]["shops"][shopname]['targetid'] = nil
    TargetArray[data.tarid]["shops"][shopname]['cantarget'] = false
    TargetArray[data.tarid]["shops"][shopname]['amount'] = 0
    TargetArray[data.tarid]["shops"][shopname]['targetsrc'] = 0
    TargetArray[data.tarid]["shops"][shopname]['keepersrc'] = 0
    TargetArray[data.tarid]["shops"][shopname]['shopname'] = nil

end)

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        CreateThread(function()
            MySQL.query("DELETE FROM stashitems WHERE stash LIKE 'MxD Billing %'")
        end)
    end
end)