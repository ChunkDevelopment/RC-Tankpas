ESX = nil

if Config.UseESX then
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

	RegisterServerEvent('fuel:pay')
	AddEventHandler('fuel:pay', function(price)
		local xPlayer = ESX.GetPlayerFromId(source)
		local amount = ESX.Math.Round(price)
		local discord_webhook = {
			url = "",
			image = ""
		}

		
		if price > 0.1 then
			xPlayer.removeMoney(amount)
			TriggerClientEvent('esx:showNotification', source, '~w~Je hebt ~r~€' .. amount .. '~w~ betaald!')
			PerformHttpRequest(discord_webhook.url, 
				function(err, text, headers) end, 
				'POST',
				json.encode({username = DISCORD_NAME, content = "```CSS\n".. GetPlayerName(source) .. " heeft getankt voor [€" .. amount .. "]\n```", avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
		else
			TriggerClientEvent('esx:showNotification', source, '~w~Je hebt ~g~betaald ~w~met je tankpas!')
			PerformHttpRequest(discord_webhook.url, 
				function(err, text, headers) end, 
				'POST',
				json.encode({username = DISCORD_NAME, content = "```CSS\n".. GetPlayerName(source) .. " heeft getankt met een tankpas voor [€" .. amount .. "]\n```", avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
		end
	end)
end

