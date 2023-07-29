-- speedometer.lua

local speedLimits = {
    ["sports"] = 180, -- Max speed limit for sports cars in km/h
    ["trucks"] = 120, -- Max speed limit for trucks in km/h
    -- Add more categories and their speed limits as needed
}

RegisterNetEvent("playerEnteredVehicle")
AddEventHandler("playerEnteredVehicle", function()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    local vehicleClass = GetVehicleClass(vehicle)

    local category = nil
    if vehicleClass == 0 or vehicleClass == 1 then
        category = "sports" -- You can add more checks to identify different categories.
    elseif vehicleClass == 8 or vehicleClass == 9 then
        category = "trucks"
    end

    if category and speedLimits[category] then
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(500) -- Adjust the time interval for checking speed (in milliseconds).
                local speed = GetEntitySpeed(vehicle) * 3.6 -- Convert speed from m/s to km/h.
                if speed > speedLimits[category] then
                    -- Perform actions here when the speed limit is exceeded.
                    -- For example, you can send a warning message or apply penalties.
                    TriggerEvent("chatMessage", "SYSTEM", {255, 0, 0}, "You are exceeding the speed limit!")
                end
            end
        end)
    end
end)
