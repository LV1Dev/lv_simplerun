ESX = exports["es_extended"]:getSharedObject()

RegisterServerEvent("startJob")
AddEventHandler(
    "startJob",
    function()
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        local bread = xPlayer.getInventoryItem(Config.Item).count

        if bread > 0 then
            local buyer = Config.Buyers[math.random(#Config.Buyers)]
            TriggerClientEvent("jobSuccess", _source, buyer)
        else
            TriggerClientEvent("noItem", _source)
        end
    end
)

RegisterServerEvent("completeDelivery")
AddEventHandler(
    "completeDelivery",
    function()
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        xPlayer.removeInventoryItem(Config.Item, 1)
        xPlayer.addMoney(Config.Price)
    end
)
