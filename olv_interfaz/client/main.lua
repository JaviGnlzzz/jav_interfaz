ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('build:interfaz', function(state)
    buildHud(state)
    buildVehicleHud(state)
end)

RegisterNetEvent('esx:playerLoaded', function()
    buildHud(true)
    buildVehicleHud(true)
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end

    buildHud(true)
    buildVehicleHud(true)
end)

exports('showNotification', appendNotification)
