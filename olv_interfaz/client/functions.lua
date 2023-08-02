local hud_stats = {}
local radio = false
local seatbelt = false

function buildHud(state)
    if(state) then

        CreateThread(function()
            while (true) do

                plyState = LocalPlayer.state;

                if(not IsPauseMenuActive()) then

                    hud_stats = {
                        health = math.ceil(GetEntityHealth(PlayerPedId()) / 2),
                        shield = math.ceil(GetPedArmour(PlayerPedId())),
                        stamina = math.ceil(GetPlayerSprintStaminaRemaining(PlayerId())),
                        hunger = 0,
                        thirst = 0,
                        stress = 0,
                        radar = IsRadarHidden(),
                        voice_mode = plyState.proximity.mode,
                        voice_active = (NetworkIsPlayerTalking(PlayerId()) == 1),
                        radio_active = radio,
                        radio_channel = plyState.radioChannel
                    }
    
                    TriggerEvent('esx_status:getStatus', 'hunger', function(status)
                        hud_stats.hunger = math.ceil(status.val / 10000)
                    end)
            
                    TriggerEvent('esx_status:getStatus', 'thirst', function(status)
                        hud_stats.thirst = math.ceil(status.val / 10000)
                    end)

                    SendNUIMessage({
                        action = state,
                        type = 'show:interfaz:hud',
                        data_hud = hud_stats
                    })

                else
                    SendNUIMessage({
                        action = false
                    })
                end

                Wait(350)

            end
        end)
    else
        SendNUIMessage({
            action = false
        })
    end
end

RegisterNetEvent('pma-voice:radioActive')
AddEventHandler("pma-voice:radioActive", function(radioTalking)
    radio = radioTalking
end)

function buildVehicleHud(state)
    CreateThread(function()
        while (true) do
        
            if(not IsPauseMenuActive()) then
                local playerPed = PlayerPedId()
                local vehicle = GetVehiclePedIsIn(playerPed)
    
                local vehicle_stats = {
                    speed = IsPedInAnyVehicle(PlayerPedId()) and math.ceil(GetEntitySpeed(vehicle) * 3.6) or 0,
                    gas = IsPedInAnyVehicle(PlayerPedId()) and math.ceil(GetVehicleFuelLevel(vehicle)) or 0,
                    status = IsPedInAnyVehicle(PlayerPedId()) and math.ceil((GetVehicleEngineHealth(GetVehiclePedIsIn(PlayerPedId())) / 10)) or 0,
                    rpm = IsPedInAnyVehicle(PlayerPedId()) and math.ceil((GetVehicleCurrentRpm(vehicle)) * 100) or 0,
                    gear = IsPedInAnyVehicle(PlayerPedId()) and GetVehicleCurrentGear(vehicle) or 0,
                    police =  IsVehicleSirenOn(vehicle),
                    seatbelt_status = seatbelt
                }
            
                if IsPedInAnyVehicle(PlayerPedId()) then
                    if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then 
                        SendNUIMessage({
                            action = state,
                            type = 'show:interfaz:carhud',
                            data_carhud = vehicle_stats
                        })
                    end
                else
                    SendNUIMessage({
                        action = state,
                        type = 'hide:interfaz:carhud',
                    })
                end

                if not IsPedInAnyVehicle(PlayerPedId()) then
                    seatbelt = false
                end
    
            else
                SendNUIMessage({
                    action = false
                })
            end
        
            Wait(IsPedInAnyVehicle(PlayerPedId()) and 170 or 1000)
        end
    end)
end

function appendNotification(text, type)
    if(text ~= '') then
        SendNUIMessage({
            action = 'true',
            type = 'show:interfaz:notification',
            data_notification = {
                text = ConvertLuaTextIntoHtml(text),
                type = type
            }
        })
    end
end

function ConvertLuaTextIntoHtml(text)
    text = text:gsub("~r~", "<span style=Color:red;>") 
    text = text:gsub("~b~", "<span style='Color:rgb(0, 213, 255);'>")
    text = text:gsub("~f~", "<span style='Color:rgb(4, 69, 155);'>")
    text = text:gsub("~g~", "<span style='Color:rgb(0, 255, 68);'>")
    text = text:gsub("~y~", "<span style=Color:yellow;>")
    text = text:gsub("~p~", "<span style='Color:rgb(220, 0, 255);'>")
    text = text:gsub("~c~", "<span style=Color:grey;>")
    text = text:gsub("~m~", "<span style=Color:darkgrey;>")
    text = text:gsub("~u~", "<span style=Color:black;>")
    text = text:gsub("~o~", "<span style=Color:gold;>")
    text = text:gsub("~s~", "</span>")
    text = text:gsub("~w~", "</span>")
    text = text:gsub("~b~", "<b>")
    text = text:gsub("~n~", "<br>")
    text = text

    return text
end

RegisterCommand('cinturon', function()
    if IsPedInAnyVehicle(PlayerPedId()) then
        seatbelt = not seatbelt

        if(seatbelt) then
            appendNotification('Cinturon ~g~ puesto', 'car')
        else
            appendNotification('Cinturon ~r~ quitado', 'car')
        end

        CreateThread(function()
            while (seatbelt) do
                DisableControlAction(0, 75, true)
                DisableControlAction(27, 75, true)
                Wait(0)
            end
        end)
    end
end)

RegisterKeyMapping('cinturon', 'Boton cinturon', 'KEYBOARD', 'B')