local ME_HOOK = 'https://discord.com/api/webhooks/1221981273611042876/YjnSR87qcc4aOSMXzI3M9uPiQJBs7V2yRmpOvCeznAvNR7PplehwaqF1EDkY3MmST_Dt' -- /me
local DO_HOOK = 'https://discord.com/api/webhooks/1221981273611042876/YjnSR87qcc4aOSMXzI3M9uPiQJBs7V2yRmpOvCeznAvNR7PplehwaqF1EDkY3MmST_Dt' -- /do
local TRY_HOOK = 'https://discord.com/api/webhooks/1221981273611042876/YjnSR87qcc4aOSMXzI3M9uPiQJBs7V2yRmpOvCeznAvNR7PplehwaqF1EDkY3MmST_Dt' -- /try
local DOC_HOOK = 'https://discord.com/api/webhooks/1221981273611042876/YjnSR87qcc4aOSMXzI3M9uPiQJBs7V2yRmpOvCeznAvNR7PplehwaqF1EDkY3MmST_Dt' -- /doc
local DOKTOR_HOOK = 'https://discord.com/api/webhooks/1221981273611042876/YjnSR87qcc4aOSMXzI3M9uPiQJBs7V2yRmpOvCeznAvNR7PplehwaqF1EDkY3MmST_Dt' -- /dr
local BM_HOOK = 'https://discord.com/api/webhooks/1221981273611042876/YjnSR87qcc4aOSMXzI3M9uPiQJBs7V2yRmpOvCeznAvNR7PplehwaqF1EDkY3MmST_Dt' -- /bm
local ANNOUNCE_HOOK = 'https://discord.com/api/webhooks/1221981273611042876/YjnSR87qcc4aOSMXzI3M9uPiQJBs7V2yRmpOvCeznAvNR7PplehwaqF1EDkY3MmST_Dt' -- /announce
local AD_HOOK = 'https://discord.com/api/webhooks/1221981273611042876/YjnSR87qcc4aOSMXzI3M9uPiQJBs7V2yRmpOvCeznAvNR7PplehwaqF1EDkY3MmST_Dt' -- /ad
local TWT_HOOK = 'https://discord.com/api/webhooks/1221981273611042876/YjnSR87qcc4aOSMXzI3M9uPiQJBs7V2yRmpOvCeznAvNR7PplehwaqF1EDkY3MmST_Dt' -- /twt
local SCHAT_HOOK = 'https://discord.com/api/webhooks/1221981273611042876/YjnSR87qcc4aOSMXzI3M9uPiQJBs7V2yRmpOvCeznAvNR7PplehwaqF1EDkY3MmST_Dt' -- /s
local TWITTER_HOOK = 'https://discord.com/api/webhooks/1221981273611042876/YjnSR87qcc4aOSMXzI3M9uPiQJBs7V2yRmpOvCeznAvNR7PplehwaqF1EDkY3MmST_Dt'
ESX = nil

ESX = exports["es_extended"]:getSharedObject()

-- GPS command
RegisterCommand('', function(source, args, raw)
 TriggerClientEvent('esx_rpchat:getCoords', source, source);
end)

RegisterServerEvent('esx_rpchat:showCoord')
AddEventHandler('esx_rpchat:showCoord', function(source, msg)
  TriggerClientEvent('chat:addMessage', source, {
     template = '<div style="font-family: Verdana, sans-serif; background-color: rgba(56, 56, 56, 0.8); border-radius: 5px; border: solid 1px rgba(0, 90, 90, 0.8); display: inline-block; padding: 0.3vw;">{1}</div>', 
        args = { msg }
    })
end)
AddEventHandler('chatMessage', function(source, name, message)
  if string.sub(message, 1, string.len('/')) ~= '/' then
    CancelEvent()
    --Kvůli steam jménu
    --if Config.EnableESXIdentity then name = GetCharacterName(source) end
    local xPlayer = ESX.GetPlayerFromId(source)
    tags = {}  
    if tags[identifier] ~= nil then
      TriggerClientEvent('esx_rpchat:sendLocalOOC', -1, source, name:gsub("%^", " "), message, tags[identifier])
    elseif group ~= 'user' then
      TriggerClientEvent('esx_rpchat:sendLocalOOC', -1, source, name:gsub("%^", " "), message, group)
    else
      TriggerClientEvent('esx_rpchat:sendLocalOOC', -1, source, name:gsub("%^", ""), message, 'player')
    end
  end
end)

local twt_limit = {}
--[[RegisterCommand('twt', function(source, args, rawCommand)
  local currTime = os.time(os.date("!*t"))
  local xPlayer = ESX.GetPlayerFromId(source)
  if twt_limit[xPlayer.identifier] == nil then
    twt_limit[xPlayer.identifier] = 0
  end
  if twt_limit[xPlayer.identifier] < currTime then
    local msg = rawCommand:sub(4)
    fal = GetRealCharacterName(source)
    twt_limit[xPlayer.identifier] = currTime + 3
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="font-family: Verdana, sans-serif; background-color: rgba(56, 56, 56, 0.8); border-radius: 5px; border: solid 1px rgba(0, 157, 255, 0.8); display: inline-block; padding: 0.3vw;"><div style="font-family: Verdana, sans-serif; background-color: rgba(0, 157, 255, 0.8); border-radius: 2px; display: inline-block; padding: 0.3vw; margin-right: 0.3vw;">TWT</div><div style="font-family: Verdana, sans-serif; font-weight: 800; display:inline-block;">{0}</div> {1}</div>', 
      args = {fal, msg}
    })
    local embed = {
      { 
        ["color"] = 0x0040ff,
        ["description"] = GetPlayerName(source)..' - '..GetRealCharacterName(source).." ["..source.."]".." `"..msg.."`",
        ["footer"] = {
          ["text"] = os.date('%H:%M:%S - %d. %m. %Y', os.time()),
        },
      }
    }
    PerformHttpRequest(TWITTER_HOOK, function(err, text, headers) end, 'POST', json.encode({username = 'Použití příkazu /twt', embeds = embed}), { ['Content-Type'] = 'application/json' })
  else
    TriggerClientEvent('ox_lib:notify', source, { type = 'inform', title = 'Chat', description =  'Do twitteru můžeš opět napsat znovu za '..(twt_limit[xPlayer.identifier] - currTime)..' sekund', duration = 5000 })
  end
end, false)]]
RegisterCommand('twt', function(source, args, rawCommand)
  local currTime = os.time(os.date("!*t"))
  local xPlayer = ESX.GetPlayerFromId(source)
  -- if twt_limit[xPlayer.identifier] == nil then
  --   twt_limit[xPlayer.identifier] = 0
  -- end
  -- if twt_limit[xPlayer.identifier] < currTime then
  --   local msg = rawCommand:sub(4)
  --   local username = GetRealCharacterName(source)
    

  --   local handle = '@'..string.lower(username:gsub('%s+', '.'))
  --   twt_limit[xPlayer.identifier] = currTime + 3
  --   TriggerClientEvent('chat:addMessage', -1, {
  --       template = '<div style="font-family: Verdana, sans-serif; background-color: rgba(56, 56, 56, 0.8); border-radius: 5px; border: solid 1px rgba(0, 157, 255, 0.8); display: inline-block; padding: 0.3vw;"><div style="font-family: Verdana, sans-serif; background-color: rgba(0, 157, 255, 0.8); border-radius: 2px; display: inline-block; padding: 0.3vw; margin-right: 0.3vw;">TWT</div><div style="font-family: Verdana, sans-serif; font-weight: 800; display:inline-block;">{0}</div> {1}</div>', 
  --       args = {handle, msg}
  --   })
  --   local embed = {
  --     { 
  --       ["color"] = 0x0040ff,
  --       ["description"] = GetPlayerName(source)..' - '..GetRealCharacterName(source).." ["..source.."]".." `"..msg.."`",
  --       ["footer"] = {
  --         ["text"] = os.date('%H:%M:%S - %d. %m. %Y', os.time()),
  --       },
  --     }
  --   }
  --   PerformHttpRequest(TWT_HOOK, function(err, text, headers) end, 'POST', json.encode({username = 'Použití příkazu /twt', embeds = embed}), { ['Content-Type'] = 'application/json' })
  -- else
  --   TriggerClientEvent('ox_lib:notify', source, { type = 'inform', title = 'Chat', description =  'Do twitteru můžeš opět napsat znovu za '..(twt_limit[xPlayer.identifier] - currTime)..' sekund', duration = 5000 })
  -- end

  xPlayer.triggerEvent('rrp:twtNotify')
end, false)

-- print(string.format("[%s]", string.trim("  12345  ")))
-- Anontwt
--[[RegisterCommand('anontwt', function(source, args, rawCommand)
  local currTime = os.time(os.date("!*t"))
  local xPlayer = ESX.GetPlayerFromId(source)
  if twt_limit[xPlayer.identifier] == nil then
    twt_limit[xPlayer.identifier] = 0
  end
  if twt_limit[xPlayer.identifier] < currTime then
    twt_limit[xPlayer.identifier] = currTime + 3
    local msg = rawCommand:sub(8)
    fal = GetCharacterName(source)

    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="font-family: Verdana, sans-serif; background-color: rgba(56, 56, 56, 0.8); border-radius: 5px; border: solid 1px rgba(0, 157, 255, 0.8); display: inline-block; padding: 0.3vw;"><div style="font-family: Verdana, sans-serif; background-color: rgba(0, 157, 255, 0.8); border-radius: 2px; display: inline-block; padding: 0.3vw; margin-right: 0.3vw;">TWT</div><div style="font-family: Verdana, sans-serif; font-weight: 800; display:inline-block;">Anonynym:   </div> {1}</div>', 
        args = { fal, msg }
    })
    local embed = {
      {
        ["color"] = 0x0040ff,
        ["description"] = GetPlayerName(source)..' - '..GetRealCharacterName(source).." ["..source.."]".." `"..msg.."`",
        ["footer"] = {
        ["text"] = os.date('%H:%M:%S - %d. %m. %Y', os.time()),
        },
      }
    }
    PerformHttpRequest(TWT_HOOK, function(err, text, headers) end, 'POST', json.encode({username = 'Použití příkazu /anontwt', embeds = embed}), { ['Content-Type'] = 'application/json' }) 
  else
    TriggerClientEvent('ox_lib:notify', source, { type = 'inform', title = 'Chat', description =  'Do twitteru můžeš opět napsat znovu za '..(twt_limit[xPlayer.identifier] - currTime)..' sekund', duration = 5000 })
  end
end, false)]]

-- BLACKMARKET
local bm_limit = {}
local canUse = true
--[[RegisterCommand('bm', function(source, args, rawCommand)
  local currTime = os.time(os.date("!*t"))
  local xPlayer = ESX.GetPlayerFromId(source)
  if bm_limit[xPlayer.identifier] == nil then
    bm_limit[xPlayer.identifier] = 0
  end
  if bm_limit[xPlayer.identifier] < currTime then
    bm_limit[xPlayer.identifier] = currTime + 5
    local msg = rawCommand:sub(3)
    
    local players = ESX.GetPlayers()
    for i=1, #players do
      local xPlayer = ESX.GetPlayerFromId(players[i])
      if not (xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' or xPlayer.job.name == 'sahp' or xPlayer.job.name == 'marshal' or xPlayer.job.name == 'goverment' or xPlayer.job.name == 'ambulance') then
        TriggerClientEvent('chat:addMessage', xPlayer.source, {
          template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(202,40,40, 0.6); border-left: 5px solid rgba(244, 7, 7, 0.85); border-radius: 8px;"><i class="fas fa-skull"></i> Blackmarket zprava:</strong><br><p style="padding-top: .3vw">{0}</p></div>',
            args = {msg}
      })
      end
    end
    local embed = {
      {
        ["color"] = 16711680,
        ["description"] = GetPlayerName(source)..' - '..GetRealCharacterName(source).." ["..source.."]".." `"..msg.."`",
        ["footer"] = {
        ["text"] = os.date('%H:%M:%S - %d. %m. %Y', os.time()),
        },
      }
    }
    PerformHttpRequest(BM_HOOK, function(err, text, headers) end, 'POST', json.encode({username = 'Použití příkazu /bm', embeds = embed}), { ['Content-Type'] = 'application/json' }) 
  else
    TriggerClientEvent('ox_lib:notify', source, { type = 'inform', title = 'Chat', description =   'Do blackmarketu můžeš opět napsat znovu za '..(bm_limit[xPlayer.identifier] - currTime)..' sekund', duration = 5000 })
  end
end, false)

RegisterCommand('togglebm', function()
  canUse = not canUse

end, false)]]

-- BLACKMARKET
--[[RegisterCommand('bm', function(source, args, rawCommand)
  fal = GetCharacterName(source)
  local toSay = ''
       for i=1,#args do
    toSay = toSay .. args[i] .. ' ' 
  end

  TriggerClientEvent('chat:addMessage', -1, {
    template = '<div style="padding: 0.3vw 0.8vw; margin: 0.5vw 0.5vw 0.5vw 0; border-radius:10px; background-color: rgba(202,40,40, 0.6);"><strong style="font-size: 10pt;"><img src="" width="20" height="20" style="position: relative; left: -5px; top:3px;">Blackmarket zprava:</strong><br><p style="padding-top: .3vw">{0}</p></div>',
      args = {toSay}
  })
  local embed = {
    {
      ["color"] = 7829367,
      ["description"] = fal.." ["..source.."]".." `"..toSay.."`",
      ["footer"] = {
      ["text"] = os.date('%H:%M:%S - %d. %m. %Y', os.time()),
      },
    }
  }
  PerformHttpRequest(BM_HOOK, function(err, text, headers) end, 'POST', json.encode({username = 'Použití příkazu /bm', embeds = embed}), { ['Content-Type'] = 'application/json' }) 

end, false)]]
local runningDoc = false

local jobs = {}
jobs['job'] = 0
jobs['lsc'] = 0

local hasSend = false


RegisterCommand('ad', function(source, args, rawCommand)
  local currTime = os.time(os.date("!*t"))
  local xPlayer = ESX.GetPlayerFromId(source)
  fal = GetCharacterName(source)
  local toSay = table.concat(args, ' ')
 

  job = xPlayer.job.name
  if jobs[job] ~= nil then
    if jobs[job] < currTime then
      TriggerEvent("okokBilling:CreateCustomInvoice", source, 500, 'Poslání reklamy', 'Reklama', 'society_vlada', 'Vláda')
      jobs[job] = currTime + 600

      if string.find(toSay, 'http') then
        if xPlayer.job.name == 'lsc' then
          TriggerClientEvent('chat:addMessage', -1, {
            template = '<img src="{1}" style="width:465px; height:100%;"><br><small style="font-size: 0.75rem; color: #ccc; float:right;">© {0}</small>', 
             args = {xPlayer.job.label, toSay}
          })
        else
          TriggerClientEvent('chat:addMessage', -1, {
            template = '<img src="{1}" style ="width:465px;"><br><small style="font-size: 0.75rem; color: #ccc; float:right;">© {0}</small>', 
            args = {xPlayer.job.label, toSay}
          })
        end
      else
        TriggerClientEvent('chat:addMessage', -1, {
          template = '<div style="font-family: Verdana, sans-serif; background-color: rgba(56, 56, 56, 0.8); border-radius: 5px; border: solid 1px rgba(73, 80, 186, 0.8); display: inline-block; padding: 0.3vw;"><div style="font-family: Verdana, sans-serif; background-color: rgba(73, 80, 186, 0.8); border-radius: 2px; display: inline-block; padding: 0.3vw; margin-right: 0.3vw;">AD</div><div style="font-family: Verdana, sans-serif; font-weight: 800; display:inline-block;">{0}:</div> {1}</div>', 
            args = {xPlayer.job.label, toSay}
        })

      end
      
    else
      TriggerClientEvent('ox_lib:notify', source, { type = 'inform', title = 'Chat', description =  'Reklamu můžeš použít znovu za '..(jobs[job] - currTime)..' sekund', duration = 5000 })
    end
  else
    TriggerClientEvent('ox_lib:notify', source, { type = 'inform', title = 'Chat', description = 'Tvoje práce nemá přístup k reklamě - pokud chceš přístip k reklamě, tak si založ ticket.', duration = 5000 })
  end
  PerformHttpRequest(AD_HOOK, function(err, text, headers) end, 'POST', json.encode({username = 'chat-ad', content = xPlayer.identifier..';ad;0;'..toSay}), { ['Content-Type'] = 'application/json'}) 
end, false)

RegisterCommand('vlada', function(source, args, rawCommand)
  local xPlayer = ESX.GetPlayerFromId(source)
  local name = GetCharacterName(source)
  local toSay = table.concat(args, ' ')
  
  job = xPlayer.job.name
 
  if job == 'vlada' then 
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="font-family: Verdana, sans-serif; background-color: rgba(56, 56, 56, 0.8); border-radius: 5px; border: solid 1px rgba(255, 102, 0, 0.8); display: inline-block; padding: 0.3vw;"><div style="font-family: Verdana, sans-serif; background-color: rgba(255, 102, 0, 0.8); border-radius: 2px; display: inline-block; padding: 0.3vw; margin-right: 0.3vw;">GOV</div><div style="font-family: Verdana, sans-serif; font-weight: 800; display:inline-block;">Vláda: </div> {0}</div>', 
      args = {toSay}
    })
    PerformHttpRequest(ANNOUNCE_HOOK, function(err, text, headers) end, 'POST', json.encode({username = 'chat-vlada', content = xPlayer.identifier..';vlada;0;'..toSay}), { ['Content-Type'] = 'application/json'}) 
  else 
    TriggerClientEvent('chat:addMessage', source, {
      template = '<div style="padding: 0.45vw; margin: 0.05vw; background-color: rgba(205, 0, 0, 0.9); border-radius: 8px;"><i class="fas fa-exclamation"></i>  Musíš pracovat u Vlády pro možnost použít /goverment <i class="fas fa-exclamation"></i></div>',
      args = {}
    })
  end
end, false)

RegisterCommand('police', function(source, args, rawCommand)
      local xPlayer = ESX.GetPlayerFromId(source)
      local name = GetCharacterName(source)
      local toSay = table.concat(args, ' ')
     
  
      if xPlayer.job.name == 'police' then 
      TriggerClientEvent('chat:addMessage', -1, {--50 71 202
          template = '<div style="font-family: Verdana, sans-serif; background-color: rgba(56, 56, 56, 0.8); border-radius: 5px; border: solid 1px rgba(50, 71, 202, 0.8); display: inline-block; padding: 0.3vw;"><div style="font-family: Verdana, sans-serif; background-color: rgba(50, 71, 202, 0.8); border-radius: 2px; display: inline-block; padding: 0.3vw; margin-right: 0.3vw;">LSPD</div>{0}</div>', 
            args = {toSay}
        })
    PerformHttpRequest(ANNOUNCE_HOOK, function(err, text, headers) end, 'POST', json.encode({username = 'chat-police', content = xPlayer.identifier..';police;0;'..toSay}), { ['Content-Type'] = 'application/json'}) 
    else 
      TriggerClientEvent('ox_lib:notify', source, { type = 'error', title = 'Chat', description =  'Musíš pracovat u LSPD', duration = 5000 })

      --[[TriggerClientEvent('chat:addMessage', source, {
        template = '<div style="font-family: Verdana, sans-serif; background-color: rgba(56, 56, 56, 0.8); border-radius: 5px; border: solid 1px rgba(50, 71, 202, 0.8); display: inline-block; padding: 0.3vw;"><div style="font-family: Verdana, sans-serif; background-color: rgba(50, 71, 202, 0.8); border-radius: 2px; display: inline-block; padding: 0.3vw; margin-right: 0.3vw;">LSPD</div>{0}</div>', 
        args = {"Musíš pracovat u LSPD"}
      })]]
    end
end, false)

RegisterCommand('hasici', function(source, args, rawCommand)
  local xPlayer = ESX.GetPlayerFromId(source)
  local name = GetCharacterName(source)
  local toSay = table.concat(args, ' ')
  

  if xPlayer.job.name == 'fire' then 
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="font-family: Verdana, sans-serif; background-color: rgba(56, 56, 56, 0.8); border-radius: 5px; border: solid 1px rgba(255, 0, 0, 0.8); display: inline-block; padding: 0.3vw;"><div style="font-family: Verdana, sans-serif; background-color: rgba(255, 0, 0, 0.8); border-radius: 2px; display: inline-block; padding: 0.3vw; margin-right: 0.3vw;">LSFD</div>{0}</div>', 
          args = {toSay}
      })
    local embed = {
      {
        ["color"] = 7829367,
        ["description"] = name.." ["..source.."]".." `/hasici "..toSay.."`",
        ["footer"] = {
        ["text"] = os.date('%H:%M:%S - %d. %m. %Y', os.time()),
        },
      }
    }
    PerformHttpRequest(ANNOUNCE_HOOK, function(err, text, headers) end, 'POST', json.encode({username = 'chat-hasici', content = xPlayer.identifier..';hasici;0;'..toSay}), { ['Content-Type'] = 'application/json'}) 
  else 
    TriggerClientEvent('chat:addMessage', source, {
      template = '<div style="font-family: Verdana, sans-serif; background-color: rgba(56, 56, 56, 0.8); border-radius: 5px; border: solid 1px rgba(255, 0, 0, 0.8); display: inline-block; padding: 0.3vw;"><div style="font-family: Verdana, sans-serif; background-color: rgba(255, 0, 0, 0.8); border-radius: 2px; display: inline-block; padding: 0.3vw; margin-right: 0.3vw;">LSFD</div>{0}</div>', 
      args = {"Musíš pracovat jako hasič"}
    })
  end
end, false)

RegisterCommand('casino', function(source, args, rawCommand)
  local xPlayer = ESX.GetPlayerFromId(source)
  local name = GetCharacterName(source)
  local toSay = table.concat(args, ' ')

   
  if xPlayer.job.name == 'casino' then 
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="font-family: Verdana, sans-serif; background-color: rgba(56, 56, 56, 0.8); border-radius: 5px; border: solid 1px rgba(154, 197, 219, 0.8); display: inline-block; padding: 0.3vw;"><div style="font-family: Verdana, sans-serif; background-color: rgba(154, 197, 219, 0.8); border-radius: 2px; display: inline-block; padding: 0.3vw; margin-right: 0.3vw;">Diamond Casino & Resorts</div>{0}</div>', 
          args = {toSay}
      })
    local embed = {
      {
        ["color"] = 7829367,
        ["description"] = name.." ["..source.."]".." `/casino "..toSay.."`",
        ["footer"] = {
        ["text"] = os.date('%H:%M:%S - %d. %m. %Y', os.time()),
        },
      }
    }
    PerformHttpRequest(ANNOUNCE_HOOK, function(err, text, headers) end, 'POST', json.encode({username = 'chat-casino', content = xPlayer.identifier..';casino;0;'..toSay}), { ['Content-Type'] = 'application/json'}) 
  else 
    TriggerClientEvent('chat:addMessage', source, {
      template = '<div style="font-family: Verdana, sans-serif; background-color: rgba(56, 56, 56, 0.8); border-radius: 5px; border: solid 1px rgba(154, 197, 219, 0.8); display: inline-block; padding: 0.3vw;"><div style="font-family: Verdana, sans-serif; background-color: rgba(154, 197, 219, 0.8); border-radius: 2px; display: inline-block; padding: 0.3vw; margin-right: 0.3vw;">Diamond Casino & Resorts</div>{0}</div>', 
      args = {"Musíš pracovat v casinu"}
    })
  end
end, false)

RegisterCommand('sheriff', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local name = GetCharacterName(source)
    local toSay = table.concat(args, ' ')
   

    if xPlayer.job.name == 'sheriff' then 
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="font-family: Verdana, sans-serif; background-color: rgba(56, 56, 56, 0.8); border-radius: 5px; border: solid 1px rgba(180, 61, 34, 0.8); display: inline-block; padding: 0.3vw;"><div style="font-family: Verdana, sans-serif; background-color: rgba(180, 61, 34, 0.8); border-radius: 2px; display: inline-block; padding: 0.3vw; margin-right: 0.3vw;">LSSD</div>{0}</div>', 
          args = {toSay}
      })
    local embed = {
    {
      ["color"] = 14909218,
      ["description"] = name.." ["..source.."]".." `/sheriff "..toSay.."`",
      ["footer"] = {
      ["text"] = os.date('%H:%M:%S - %d. %m. %Y', os.time()),
      },
    }
  }
  PerformHttpRequest(ANNOUNCE_HOOK, function(err, text, headers) end, 'POST', json.encode({username = 'chat-sheriff', content = xPlayer.identifier..';sheriff;0;'..toSay}), { ['Content-Type'] = 'application/json'}) 
  else 
    TriggerClientEvent('chat:addMessage', source, {
      template = '<div style="font-family: Verdana, sans-serif; background-color: rgba(56, 56, 56, 0.8); border-radius: 5px; border: solid 1px rgba(154, 197, 219, 0.8); display: inline-block; padding: 0.3vw;"><div style="font-family: Verdana, sans-serif; background-color: rgba(154, 197, 219, 0.8); border-radius: 2px; display: inline-block; padding: 0.3vw; margin-right: 0.3vw;">LSPD</div>{0}</div>', 
      args = {"Musíš pracovat u sheriffů"}
    })
  end
end, false)

RegisterCommand('ems', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local name = GetCharacterName(source)
    local toSay = table.concat(args, ' ')

   

    if xPlayer.job.name == 'ems' then 
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="font-family: Verdana, sans-serif; background-color: rgba(56, 56, 56, 0.8); border-radius: 5px; border: solid 1px rgba(255, 0, 0, 0.8); display: inline-block; padding: 0.3vw;"><div style="font-family: Verdana, sans-serif; background-color: rgba(255, 0, 0, 0.8); border-radius: 2px; display: inline-block; padding: 0.3vw; margin-right: 0.3vw;">EMS</div>{0}</div>', 
          args = {toSay}
      })
    local embed = {
    {
      ["color"] = 9833231,
      ["description"] = name.." ["..source.."]".." `/ems "..toSay.."`",
      ["footer"] = {
      ["text"] = os.date('%H:%M:%S - %d. %m. %Y', os.time()),
      },
    }
  }
  PerformHttpRequest(ANNOUNCE_HOOK, function(err, text, headers) end, 'POST', json.encode({username = 'chat-ambulance', content = xPlayer.identifier..';ambulance;0;'..toSay}), { ['Content-Type'] = 'application/json'})   
  else 
    TriggerClientEvent('chat:addMessage', source, {
      template = '<div style="font-family: Verdana, sans-serif; background-color: rgba(56, 56, 56, 0.8); border-radius: 5px; border: solid 1px rgba(255, 0, 0, 0.8); display: inline-block; padding: 0.3vw;"><div style="font-family: Verdana, sans-serif; background-color: rgba(255, 0, 0, 0.8); border-radius: 2px; display: inline-block; padding: 0.3vw; margin-right: 0.3vw;">LSPD</div>{0}</div>', 
      args = {"Musíš pracovat u EMS"}
    })
  end
end, false)


RegisterCommand('me', function(source, args, raw)
  if source == 0 then
    print('esx_rpchat: you can\'t use this command from rcon!')
    return
  end
  local xPlayer = ESX.GetPlayerFromId(source)
  coords = xPlayer.getCoords();
  local vec3_coords = vector3(coords.x, coords.y, coords.z)
  args = table.concat(args, ' ')
  local name = GetPlayerName(source)
  if Config.EnableESXIdentity then name = GetCharacterName(source) end

  TriggerClientEvent('esx_rpchat:sendMe', -1, source, name, args, {234, 142, 80})
  TriggerClientEvent('3dme:triggerDisplay', -1, args, source)
 -- PerformHttpRequest(ME_HOOK, function(err, text, headers) end, 'POST', json.encode({username = 'chat-me', content = xPlayer.identifier..';'..'me;'..postal.code..';'..args}), { ['Content-Type'] = 'application/json'}) 
end)

RegisterCommand('do', function(source, args, raw)
  if source == 0 then
    print('esx_rpchat: you can\'t use this command from rcon!')
    return
  end
  local xPlayer = ESX.GetPlayerFromId(source)
  coords = xPlayer.getCoords();
  local vec3_coords = vector3(coords.x, coords.y, coords.z)
  args = table.concat(args, ' ')
  local name = GetPlayerName(source)
  if Config.EnableESXIdentity then name = GetCharacterName(source) end

  TriggerClientEvent('esx_rpchat:sendDo', -1, source, name, args, { 255, 198, 0 })
  TriggerClientEvent('3ddo:triggerDisplay', -1, args, source)
  --PerformHttpRequest(DO_HOOK, function(err, text, headers) end, 'POST', json.encode({username = 'chat-do', content = xPlayer.identifier..';'..'do;'..postal.code..';'..args}), { ['Content-Type'] = 'application/json'}) 
end)

RegisterCommand('rtjnfz', function(source, args, raw)
  if source == 0 then
    print('esx_rpchat: you can\'t use this command from rcon!')
    return
  end
  local xPlayer = ESX.GetPlayerFromId(source)
  local coords = xPlayer.getCoords();
  local vec3_coords = vector3(coords.x, coords.y, coords.z)
  --local postal = exports['rPostal']:getPostalServer(vec3_coords)
  args = table.concat(args, ' ')
  local name = GetPlayerName(source)
  if Config.EnableESXIdentity then name = GetCharacterName(source) end

  TriggerClientEvent('esx_rpchat:sendTry', -1, source, name, args)
  TriggerClientEvent('3ddo:triggerDisplay', -1, args, source)
 -- PerformHttpRequest(TRY_HOOK, function(err, text, headers) end, 'POST', json.encode({username = 'chat-try', content = xPlayer.identifier..';'..'try;'..postal.code..';'..args}), { ['Content-Type'] = 'application/json'}) 
end)
RegisterCommand('doc', function(source, args, raw)
  if source == 0 then
    print('esx_rpchat: you can\'t use this command from rcon!')
    return
  end
  local xPlayer = ESX.GetPlayerFromId(source)
  local coords = xPlayer.getCoords();
  local vec3_coords = vector3(coords.x, coords.y, coords.z)
  args = table.concat(args, ' ')
  local name = GetPlayerName(source)
  if Config.EnableESXIdentity then name = GetCharacterName(source) end
  local counter_doc = 0
  local pocetOpakovani = tonumber(args)
  if pocetOpakovani < 61 and not runningDoc then
   -- PerformHttpRequest(DOC_HOOK, function(err, text, headers) end, 'POST', json.encode({username = 'chat-doc', content = xPlayer.identifier..';'..'doc;'..postal.code..';'..args}), { ['Content-Type'] = 'application/json'}) 
    while counter_doc < pocetOpakovani do
    runningDoc = true
        counter_doc = counter_doc + 1 
        TriggerClientEvent('esx_rpchat:sendDo', -1, source, name, counter_doc .. "/" .. pocetOpakovani , { 255, 198, 0 })
        Citizen.Wait(1500)
    end
    runningDoc = false
  end

end)

RegisterCommand('doktor', function(source, args, raw)
  if source == 0 then
    print('esx_rpchat: you can\'t use this command from rcon!')
    return
  end
  local xPlayer = ESX.GetPlayerFromId(source)
  local coords = xPlayer.getCoords();
  local vec3_coords = vector3(coords.x, coords.y, coords.z)
  args = table.concat(args, ' ')
  local name = GetPlayerName(source)
  if Config.EnableESXIdentity then name = GetCharacterName(source) end
  TriggerClientEvent('esx_rpchat:sendDoctor', -1, source, name, args, { 0, 0, 255 })
  TriggerClientEvent('3ddoctor:triggerDisplay', -1, args, source)
  --PerformHttpRequest(DOKTOR_HOOK, function(err, text, headers) end, 'POST', json.encode({username = 'chat-dr', content = xPlayer.identifier..';'..'dr;'..postal.code..';'..args}), { ['Content-Type'] = 'application/json'})
end)

RegisterCommand('dr', function(source, args, raw)
if source == 0 then
    print('esx_rpchat: you can\'t use this command from rcon!')
    return
  end
  local xPlayer = ESX.GetPlayerFromId(source)
  local coords = xPlayer.getCoords();
  local vec3_coords = vector3(coords.x, coords.y, coords.z)
  args = table.concat(args, ' ')
  local name = GetPlayerName(source)
  if Config.EnableESXIdentity then name = GetCharacterName(source) end
  TriggerClientEvent('esx_rpchat:sendDoctor', -1, source, name, args, { 0, 0, 255 })
  TriggerClientEvent('3ddoctor:triggerDisplay', -1, args, source)
  PerformHttpRequest(DOKTOR_HOOK, function(err, text, headers) end, 'POST', json.encode({username = 'chat-dr', content = xPlayer.identifier..';'..'dr;'..postal.code..';'..args}), { ['Content-Type'] = 'application/json'})
end)


RegisterCommand('s', function(playerId, args, rawCommand)
	if playerId == 0 then
		print('esx_rpchat: you can\'t use this command from console!')
	else
		local xPlayer = ESX.GetPlayerFromId(playerId)
    local coords = xPlayer.getCoords();
    local vec3_coords = vector3(coords.x, coords.y, coords.z)
		args = table.concat(args, ' ')
		if ADMIN_GROUPS[xPlayer.getGroup()] then
			local playerName = GetPlayerName(playerId)
			local players = ESX.GetPlayers()

			for i=1, #players do
        Citizen.Wait(0)

				local xTarget = ESX.GetPlayerFromId(players[i])
        if xTarget ~= nil then
  				if ADMIN_GROUPS[xTarget.getGroup()] then
  					if xPlayer.source ~= xTarget.source then
  						TriggerClientEvent('chat:addMessage', xTarget.source, {
                template = '<div style="font-family: Verdana, sans-serif; background-color: rgba(56, 56, 56, 0.8); border-radius: 5px; border: solid 1px rgba(255, 215, 0, 0.8); display: inline-block; padding: 0.3vw;"><div style="font-family: Verdana, sans-serif; background-color: rgba(255, 215, 0, 0.8); border-radius: 2px; display: inline-block; padding: 0.3vw; margin-right: 0.3vw;">S-chat</div><div style="font-family: Verdana, sans-serif; font-weight: 800; display:inline-block;">{0}[{1}]</div> {2}</div>',
  							args = {playerName, playerId, args}
  						})
  					end
          end
				end
			end
      PerformHttpRequest(SCHAT_HOOK, function(err, text, headers) end, 'POST', json.encode({username = 'chat-s', content = xPlayer.identifier..';'..'s;'..postal.code..';'..args}), { ['Content-Type'] = 'application/json'})
			TriggerClientEvent('chat:addMessage', playerId, {
				template = '<div style="font-family: Verdana, sans-serif; background-color: rgba(56, 56, 56, 0.8); border-radius: 5px; border: solid 1px rgba(255, 215, 0, 0.8); display: inline-block; padding: 0.3vw;"><div style="font-family: Verdana, sans-serif; background-color: rgba(255, 215, 0, 0.8); border-radius: 2px; display: inline-block; padding: 0.3vw; margin-right: 0.3vw;">S-chat</div><div style="font-family: Verdana, sans-serif; font-weight: 800; display:inline-block;">{0}[{1}]</div> {2}</div>', 
				args = {playerName, playerId, args}
			})
				else
			TriggerClientEvent('chat:addMessage', playerId, {
        template = '<div style="font-family: Verdana, sans-serif; background-color: rgba(56, 56, 56, 0.8); border-radius: 5px; border: solid 1px rgba(210, 33, 73, 0.8); display: inline-block; padding: 0.3vw;"><div style="font-family: Verdana, sans-serif; background-color: rgba(210, 33, 73, 0.8); border-radius: 2px; display: inline-block; padding: 0.3vw; margin-right: 0.3vw;">Chyba</div>{0}</div>', 
        args = {'Na tento příkaz nemáš oprávnění!'}
			})
		end
	end
end)

--RegisterCommand('discord', function(source, args, rawCommand)
	--local _src = source
	--TriggerClientEvent('chat:addMessage', _src, {
	--	template = '<div style="font-family: Verdana, sans-serif; background-color: rgba(56, 56, 56, 0.8); border-radius: 5px; border: solid 1px rgba(0, 90, 90, 0.8); display: inline-block; padding: 0.3vw;"><div style="font-family: Verdana, sans-serif; background-color: rgba(0, 90, 90, 0.8); border-radius: 2px; display: inline-block; padding: 0.3vw; margin-right: 0.3vw;">Discord</div>{0}</div>', 
    --args = {'Náš discord je: https://discord.gg/VGQfjXaa' }
	--})
--end, false)