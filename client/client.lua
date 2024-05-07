ESX = exports["es_extended"]:getSharedObject()
local jobInProgress = false
local buyerPed = nil

local ped = nil

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local scale = ((1 / GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)) * 2) * (1 / GetGameplayCamFov()) * 100

    if onScreen then
        SetTextScale(0.0 * scale, 0.55 * scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextDropshadow(0, 0, 0, 0, 215)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

Citizen.CreateThread(
    function()
        local model = GetHashKey(Config.Ped.model)
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(1)
        end

        SetEntityAsMissionEntity(ped, true, true)
        SetEntityInvincible(ped, true)
        FreezeEntityPosition(ped, true)
    end
)

RegisterNetEvent("jobSuccess")
AddEventHandler(
    "jobSuccess",
    function(buyerCoords, buyerHeading)
        SetNewWaypoint(buyerCoords.x, buyerCoords.y)
        exports['okokNotify']:Alert("HEROIN", Notifications["HEROIN"]["BUYER_MARKED"], 6666, 'hors')

        local model = GetHashKey(Config.BuyerModel)
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(1)
        end

        buyerPed = CreatePed(4, model, buyerCoords.x, buyerCoords.y, buyerCoords.z - 1, buyerHeading, false, true)
        SetEntityAsMissionEntity(buyerPed, true, true)
        SetEntityInvincible(buyerPed, true)
        FreezeEntityPosition(buyerPed, true)

        jobInProgress = true

        Citizen.CreateThread(
            function()
                while true do
                    Citizen.Wait(0)
                    local coords = GetEntityCoords(PlayerPedId())
                    local distance = GetDistanceBetweenCoords(coords, buyerCoords.x, buyerCoords.y, buyerCoords.z, true)

                    if distance < 1.0 then
                        DrawText3D(buyerCoords.x, buyerCoords.y, buyerCoords.z, Config.Texts.SellBaggie)
                        if IsControlJustReleased(0, 38) then
                            local dict = "mp_common"
                            local anim = "givetake1_a"
                            RequestAnimDict(dict)
                            while not HasAnimDictLoaded(dict) do
                                Citizen.Wait(0)
                            end
                            FreezeEntityPosition(buyerPed, false)
                            TaskTurnPedToFaceEntity(buyerPed, PlayerPedId(), 1500)
                            TaskTurnPedToFaceEntity(PlayerPedId(), buyerPed, 1500)
                            Citizen.Wait(1500)
                            TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
                            TaskPlayAnim(buyerPed, dict, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
							
                            Citizen.Wait(2000)
							
                            TriggerServerEvent("completeDelivery")
                            exports['okokNotify']:Alert("HEROIN", string.format(Notifications["HEROIN"]["SOLD_ITEM"], Config.Item, Config.Price), 6666, 'hors')
                            jobInProgress = false

                            SetEntityInvincible(buyerPed, false)

                            TaskWanderStandard(buyerPed, 10.0, 10)
                            buyerPed = nil

                            break
                        end
                    end
                end
            end
        )
    end
)

RegisterNetEvent("noItem")
AddEventHandler(
    "noItem",
    function()
        exports['okokNotify']:Alert("HEROIN", string.format(Notifications["HEROIN"]["NO_ITEM"], Config.Item), 6666, 'hors')
    end
)





Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if not DoesEntityExist(ped) then
                local model = GetHashKey(Config.Ped.model)
                RequestModel(model)
                while not HasModelLoaded(model) do
                    Wait(1)
                end

                ped =
                    CreatePed(
                    4,
                    model,
                    Config.Ped.coords.x,
                    Config.Ped.coords.y,
                    Config.Ped.coords.z - 1,
                    Config.Ped.coords.heading,
                    false,
                    true
                )
                SetEntityAsMissionEntity(ped, true, true)
                SetEntityInvincible(ped, true)
                FreezeEntityPosition(ped, true)
            end

            local coords = GetEntityCoords(PlayerPedId())
            local distance =
                GetDistanceBetweenCoords(coords, Config.Ped.coords.x, Config.Ped.coords.y, Config.Ped.coords.z, true)

            if distance < 2.0 and not jobInProgress then
				DrawText3D(Config.Ped.coords.x, Config.Ped.coords.y, Config.Ped.coords.z, Config.Texts.StartDelivery)
                if IsControlJustReleased(0, 38) then
                    local dict = "cellphone@"
                    local anim = "cellphone_call_listen_base"
                    RequestAnimDict(dict)
                    while not HasAnimDictLoaded(dict) do
                        Citizen.Wait(0)
                    end
                    TaskPlayAnim(ped, dict, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
                    Citizen.Wait(5000) -- Wait for 5 seconds
                    ClearPedTasks(ped) -- Stop the animation
                    Citizen.Wait(1000)
                    TriggerServerEvent("startJob")
                end
            end
        end
    end
)
