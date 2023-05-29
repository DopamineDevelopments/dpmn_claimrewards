ESX = exports["es_extended"]:getSharedObject()

--Claim Freebies
CreateThread(function()
    while true do
        local sleep = 500
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        if #(coords - Config.ClaimFreebies) <= 5.0 then
            sleep = 0
            ESX.Game.Utils.DrawText3D({x = Config.ClaimFreebies.x, y = Config.ClaimFreebies.y, z = Config.ClaimFreebies.z}, '[~g~E~w~] to claim your freebies', 0.7)
            if IsControlJustReleased(0, 46) then 
                ESX.TriggerServerCallback('dpmn_checkNew', function(isNew)
                    if isNew == 0 then
                    TriggerServerEvent('dpmn_claimItems')                 
                    TriggerServerEvent('dpmn:claimFreeCar')
                    exports["k5_notify"]:notify('Notification', 'You have received your freebies!', 'success', 3000)
                    else
                    exports["k5_notify"]:notify('Notification', 'You already claimed your freebies!', 'error', 3000)
                    end   
                    TriggerServerEvent('dpmn_setNew', true)
                end)
            end
        end
        Wait(sleep)
    end
  end)

RegisterNetEvent('dpmn:spawnVehicle')
AddEventHandler('dpmn:spawnVehicle', function(playerID, model)
  print(playerID)
  print(model)
  local playerPed = PlayerPedId()
  local spawnpoint = Config.ClaimFreebies
  local carExist  = false
  ESX.Game.SpawnVehicle(model, spawnpoint, 0.0, function(vehicle) --get vehicle info
      if DoesEntityExist(vehicle) then
          carExist = true
          SetEntityVisible(vehicle, false, false)
          SetEntityCollision(vehicle, false)
          
          local newPlate     = exports.esx_vehicleshop:GeneratePlate()
          local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
          print(vehicleProps)
          print(newPlate)
          vehicleProps.plate = newPlate
          TriggerServerEvent('dpmn:setVehicle', vehicleProps, playerID, 'car')        
          ESX.Game.DeleteVehicle(vehicle)
      end        
  end)
end)
