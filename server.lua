-- Load the config settings
require('config')

-- Function to send a Discord message using a webhook URL
function SendDiscordMessage(webhook, message)
    PerformHttpRequest(webhook, function(statusCode, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
end

-- Listen for gang capture events
RegisterServerEvent('gangCapture')
AddEventHandler('gangCapture', function(coords, name, attacker)
    -- Check if gang capture logging is enabled
    if Config.LogGangCapture then
        -- Construct the message to send to Discord
        local message = string.format('%s captured by %s at %s (Attacker: %s)', name, GetPlayerName(source), coords, attacker)
        -- Send the message using the specified webhook URL
        SendDiscordMessage(Config.GangCaptureWebhook, message)
    end
end)

-- Listen for turf war completion events
RegisterServerEvent('turfWarEnd')
AddEventHandler('turfWarEnd', function(coords, winner)
    -- Check if turf war completion logging is enabled
    if Config.LogTurfWarEnd then
        -- Construct the message to send to Discord
        local message = string.format('Turf War at %s completed! Winner: %s', coords, winner)
        -- Send the message using the specified webhook URL
        SendDiscordMessage(Config.TurfWarEndWebhook, message)
    end
end)

-- Listen for admin kick events
AddEventHandler('playerKicked', function(reason, kickSource)
    -- Check if admin kick logging is enabled
    if Config.LogAdminKick then
        -- Construct the message to send to Discord
        local message = string.format('%s was kicked by %s (Reason: %s)', GetPlayerName(source), GetPlayerName(kickSource), reason)
        -- Send the message using the specified webhook URL
        SendDiscordMessage(Config.AdminKickWebhook, message)
    end
end)

-- Listen for player screenshot events
AddEventHandler('esx_screenshot:save', function(target, savePath, steamid)
    -- Check if player screenshot logging is enabled
    if Config.LogPlayerScreenshot then
        -- Construct the message to send to Discord
        local message = string.format('%s took a screenshot at %s', GetPlayerName(target), savePath)
        -- Send the message using the specified webhook URL
        SendDiscordMessage(Config.PlayerScreenshotWebhook, message)
    end
end)

-- Listen for player revive events
AddEventHandler('esx_ambulancejob:revive', function(target)
    -- Check if player revive logging is enabled
    if Config.LogPlayerRevive then
        -- Construct the message to send to Discord
        local message = string.format('%s was revived by %s', GetPlayerName(target), GetPlayerName(source))
        -- Send the message using the specified webhook URL
        SendDiscordMessage(Config.PlayerReviveWebhook, message)
    end
end)

-- Listen for player money transfer events
AddEventHandler('esx:playerMoneyTransfer', function(sender, recipient, amount)
    -- Check if player money transfer logging is enabled
    if Config.LogPlayerMoneyTransfer then
        -- Construct the message to send to Discord
        local message = string.format('%s transferred $%s to %s', GetPlayerName(sender), amount, GetPlayerName(recipient))
        -- Send the message using the specified webhook URL
        SendDiscord
