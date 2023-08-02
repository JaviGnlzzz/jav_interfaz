ESX = exports["es_extended"]:getSharedObject()

local interfaz = {
    hud_status = false
} 

RegisterNetEvent('build:interfaz', function(state)

    interfaz.hud_status = state

    buildHud(state)
    buildVehicleHud(state)
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end

    buildHud(true)
    buildVehicleHud(true)
end)

exports('showNotification', appendNotification)

local function testNotifications()
    -- for k, v in pairs({ 'bank', 'default', 'success', 'error', 'admin', 'radio' }) do
    --     ESX.ShowNotification('Prueba notis a ao kdoako dkao dkaok doawk doakwo dako dkaowk doakoako kaoko kaw', v)
    -- end

    SetClockTime(12,12,20)
end

RegisterCommand('test', testNotifications)