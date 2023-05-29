ESX = exports["es_extended"]:getSharedObject()

RegisterServerEvent('dpmn_claimItems')
AddEventHandler('dpmn_claimItems', function()
  local _source   = source
  local xPlayer   = ESX.GetPlayerFromId(_source)
    xPlayer.addInventoryItem('qpburger', 10)
    xPlayer.addInventoryItem('smoothie', 10)
    xPlayer.addInventoryItem('radio', 1)
    xPlayer.addInventoryItem('identity_card', 1)
    xPlayer.addInventoryItem('money', 5000)
end)

ESX.RegisterServerCallback('dpmn_checkNew', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	exports.oxmysql:scalar('SELECT is_new FROM users WHERE identifier = ?', {xPlayer.identifier}, function(isNew)
		cb(isNew)
	end)
end)

RegisterNetEvent('dpmn_setNew')
AddEventHandler('dpmn_setNew', function(isNew)
	local xPlayer = ESX.GetPlayerFromId(source)

	if type(isNew) == 'boolean' then
		exports.oxmysql:update('UPDATE users SET is_new = ? WHERE identifier = ?', {isNew, xPlayer.identifier})
	end
end)

RegisterNetEvent('dpmn:claimFreeCar')
AddEventHandler('dpmn:claimFreeCar', function()	
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('dpmn:spawnVehicle', source, source, 'blista')
end)

RegisterServerEvent('dpmn:setVehicle')
AddEventHandler('dpmn:setVehicle', function (vehicleProps, playerID, vehicleType)
	local _source = playerID
	local xPlayer = ESX.GetPlayerFromId(_source)

	exports.oxmysql:update('INSERT INTO owned_vehicles (owner, plate, vehicle, type, stored) VALUES (@owner, @plate, @vehicle, @type, @stored)',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = vehicleProps.plate,
		['@vehicle'] = json.encode(vehicleProps),
    ['type'] = vehicleType,
		['@stored']  = 1
		
	}, function ()
	end)
end)
