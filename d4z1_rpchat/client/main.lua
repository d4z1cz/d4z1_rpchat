local PlayerData              = {}
local nbrDisplaying = 1
ESX                           = nil

local cantUse = false
Citizen.CreateThread(
    function()
        while ESX == nil do
            TriggerEvent(
                "esx:getSharedObject",
                function(obj)
                    ESX = obj
                end
            )
            Citizen.Wait(1000)
        end

        while ESX.GetPlayerData().job == nil do
            Citizen.Wait(1000)
        end

        job = ESX.GetPlayerData().job.name
        grade = ESX.GetPlayerData().job.grade

        if job == 'police' or job == 'sheriff' then
          cantUse = true
		else
			cantUse = false
		end
    end
)

RegisterNetEvent("esx:setJob")
AddEventHandler(
    "esx:setJob",
    function(j)
        job = j.name
        grade = j.grade

        if job == 'police' or job == 'sheriff' then
          cantUse = true
		else
			cantUse = false
		end
    end
)



RegisterNetEvent('esx_rpchat:sendMe')
AddEventHandler('esx_rpchat:sendMe', function(playerId, title, message, color)
	local source = PlayerId()
	local target = GetPlayerFromServerId(playerId)

	if target ~= -1 then
	local sourcePed, targetPed = PlayerPedId(), GetPlayerPed(target)
	local sourceCoords, targetCoords = GetEntityCoords(sourcePed), GetEntityCoords(targetPed)

	if targetPed == source or #(sourceCoords - targetCoords) < 20 then
		TriggerEvent('chat:addMessage', {
      template = '<div style="font-family: Verdana, sans-serif; background-color: rgba(0, 0, 0, 0.8); border-radius: 5px; border: solid 1px rgba(0, 0, 0, 0.8); display: inline-block; padding: 0.3vw;"><div style="font-family: Verdana, sans-serif; background-color: rgba(93, 182, 229, 0.8); border-radius: 2px; display: inline-block; padding: 0.3vw; margin-right: 0.3vw;">ME</div><div style="font-family: Verdana, sans-serif; font-weight: 800; display:inline-block;">{0}</div> {1}</div>',
        args = {title, message}
    })
	end
  end
end)

RegisterNetEvent('esx_rpchat:sendDo')
AddEventHandler('esx_rpchat:sendDo', function(playerId, title, message, color)
	local source = PlayerId()
	local target = GetPlayerFromServerId(playerId)

	if target ~= -1 then
	local sourcePed, targetPed = PlayerPedId(), GetPlayerPed(target)
	local sourceCoords, targetCoords = GetEntityCoords(sourcePed), GetEntityCoords(targetPed)

	if targetPed == source or #(sourceCoords - targetCoords) < 20 then
		TriggerEvent('chat:addMessage', {
      template = '<div style="font-family: Verdana, sans-serif; background-color: rgba(0, 0, 0, 0.8); border-radius: 5px; border: solid 1px rgba(241, 116, 49, 0.8); display: inline-block; padding: 0.3vw;"><div style="font-family: Verdana, sans-serif; background-color: rgba(232, 142, 155, 1.0); border-radius: 2px; display: inline-block; padding: 0.3vw; margin-right: 0.3vw;">DO</div><div style="font-family: Verdana, sans-serif; font-weight: 800; display:inline-block;">{0}</div> {1}</div>',
        args = { title, message }
    })
	end
  end
end)

RegisterNetEvent('esx_rpchat:sendDoctor')
AddEventHandler('esx_rpchat:sendDoctor', function(playerId, title, message, color)
    local source = PlayerId()
    local target = GetPlayerFromServerId(playerId)

    if target ~= -1 then
    local sourcePed, targetPed = PlayerPedId(), GetPlayerPed(target)
    local sourceCoords, targetCoords = GetEntityCoords(sourcePed), GetEntityCoords(targetPed)

    if targetPed == source or #(sourceCoords - targetCoords) < 20 then
        TriggerEvent('chat:addMessage', {
      template = '<div style="font-family: Verdana, sans-serif; background-color: rgba(56, 56, 56, 0.8); border-radius: 5px; border: solid 1px rgba(7, 184, 160, 0.8); display: inline-block; padding: 0.3vw;"><div style="font-family: Verdana, sans-serif; background-color: rgba(7, 184, 160, 0.8); border-radius: 2px; display: inline-block; padding: 0.3vw; margin-right: 0.3vw;">DR</div><div style="font-family: Verdana, sans-serif; font-weight: 800; display:inline-block;">{0}</div> {1}</div>', 
        args = { title, message }
    })
    end
  end
end)

RegisterNetEvent('esx_rpchat:sendLocalOOC')
AddEventHandler('esx_rpchat:sendLocalOOC', function(playerId, title, message, tag)
	local source = PlayerId()
	local target = GetPlayerFromServerId(playerId)

	if target ~= -1 then
  	local sourcePed, targetPed = PlayerPedId(), GetPlayerPed(target)
  	local sourceCoords, targetCoords = GetEntityCoords(sourcePed), GetEntityCoords(targetPed)
    
  	if targetPed == source or #(sourceCoords - targetCoords) < 20 then
      if tag == 'vip1' then
    		TriggerEvent('chat:addMessage', {
          template = '<div style="font-family: Verdana, sans-serif; background-color: rgba(56, 56, 56, 0.8); border-radius: 5px; border: solid 1px rgba(57, 63, 75, 0.8); display: inline-block; padding: 0.3vw;"><div style="font-family: Verdana, sans-serif; background-color: rgba(57, 63, 75, 0.8); border-radius: 2px; display: inline-block; padding: 0.3vw; margin-right: 0.3vw;">LOOC</div><div style="font-family: Verdana, sans-serif; font-weight: 800; display:inline-block;"><span style="color:#CF7F32"> VIP </span> {0}</div> {1}</div>',
            args = { title, message }
        }) 
      elseif tag == 'vip2' then
        TriggerEvent('chat:addMessage', {
          template = '<div style="font-family: Verdana, sans-serif; background-color: rgba(56, 56, 56, 0.8); border-radius: 5px; border: solid 1px rgba(57, 63, 75, 0.8); display: inline-block; padding: 0.3vw;"><div style="font-family: Verdana, sans-serif; background-color: rgba(57, 63, 75, 0.8); border-radius: 2px; display: inline-block; padding: 0.3vw; margin-right: 0.3vw;">LOOC</div><div style="font-family: Verdana, sans-serif; font-weight: 800; display:inline-block;"><span style="color:#A8A9AD"> VIP </span> {0}</div> {1}</div>',
            args = { title, message }
        })   
      elseif tag == 'vip3' then
        TriggerEvent('chat:addMessage', {
          template = '<div style="font-family: Verdana, sans-serif; background-color: rgba(56, 56, 56, 0.8); border-radius: 5px; border: solid 1px rgba(57, 63, 75, 0.8); display: inline-block; padding: 0.3vw;"><div style="font-family: Verdana, sans-serif; background-color: rgba(57, 63, 75, 0.8); border-radius: 2px; display: inline-block; padding: 0.3vw; margin-right: 0.3vw;">LOOC</div><div style="font-family: Verdana, sans-serif; font-weight: 800; display:inline-block;"><span style="color:#FFD700"> VIP </span> {0}</div> {1}</div>',
            args = { title, message }
        })
      elseif tag == 'vip4' then
        TriggerEvent('chat:addMessage', {
          template = '<div style="font-family: Verdana, sans-serif; background-color: rgba(56, 56, 56, 0.8); border-radius: 5px; border: solid 1px rgba(57, 63, 75, 0.8); display: inline-block; padding: 0.3vw;"><div style="font-family: Verdana, sans-serif; background-color: rgba(57, 63, 75, 0.8); border-radius: 2px; display: inline-block; padding: 0.3vw; margin-right: 0.3vw;">LOOC</div><div style="font-family: Verdana, sans-serif; font-weight: 800; display:inline-block;"><span style="color:#00D6FF"> VIP </span> {0}</div> {1}</div>',
            args = { title, message }
        })
      else
        TriggerEvent('chat:addMessage', {
          template = '<div style="font-family: Verdana, sans-serif; background-color: rgba(0, 0, 0, 0.8); border-radius: 5px; border: solid 1px rgba(57, 63, 75, 0.8); display: inline-block; padding: 0.3vw;"><div style="font-family: Verdana, sans-serif; background-color: rgba(57, 63, 75, 0.8); border-radius: 2px; display: inline-block; padding: 0.3vw; margin-right: 0.3vw;">LOOC</div><div style="font-family: Verdana, sans-serif; font-weight: 800; display:inline-block;"> {0}</div> {1}</div>', 
            args = { title, message }
        })
      end
  	end
  end
end)

RegisterNetEvent('esx_rpchat:getCoords')
AddEventHandler('esx_rpchat:getCoords', function(player)
	local ped = PlayerPedId()
    local coords = GetEntityCoords(ped, false)
    local heading = GetEntityHeading(ped)

    local message = tostring("X: " .. coords.x .. " Y: " .. coords.y .. " Z: " .. coords.z .. " HEADING: " .. heading)
    TriggerServerEvent('esx_rpchat:showCoord', player, message)

end)

Citizen.CreateThread(function()
  TriggerEvent('chat:addSuggestion', '/tweet',  _U('twt_help'),  { { name = _U('generic_argument_name'), help = _U('generic_argument_help') } } )
  TriggerEvent('chat:addSuggestion', '/twt',  _U('twt_help'),  { { name = _U('generic_argument_name'), help = _U('generic_argument_help') } } )
  TriggerEvent('chat:addSuggestion', '/anontwt',  _U('anontwt_help'),  { { name = _U('generic_argument_name'), help = _U('generic_argument_help') } } )
  TriggerEvent('chat:addSuggestion', '/police', 'Oznámení pro policii!',   { { name = _U('generic_argument_name'), help = _U('generic_argument_help') } } )
  TriggerEvent('chat:addSuggestion', '/ems', 'Oznámení pro ems!',   { { name = _U('generic_argument_name'), help = _U('generic_argument_help') } } )
  TriggerEvent('chat:addSuggestion', '/sheriff', 'Oznámenie Sheriff - pro sheriffy!',   { { name = _U('generic_argument_name'), help = _U('generic_argument_help') } } )
  TriggerEvent('chat:addSuggestion', '/gps', 'Zobrazí vám vašu aktuálnu pozíciu (súradnice XYZ a smer pohľadu)')
  TriggerEvent('chat:addSuggestion', '/me',   _U('me_help'),   { { name = _U('generic_argument_name'), help = _U('generic_argument_help') } } )
  TriggerEvent('chat:addSuggestion', '/do',   _U('do_help'),   { { name = _U('generic_argument_name'), help = _U('generic_argument_help') } } )
  TriggerEvent('chat:addSuggestion', '/doktor', 'Slouží pro RPení pasivního EMS',   { } )
  TriggerEvent('chat:addSuggestion', '/dr', 'Slouží pro RPení pasivního EMS',   { } )
  TriggerEvent('chat:addSuggestion', '/stav', 'Zobrazí vaší stavovaou zprávu',   { { name = _U('generic_argument_name'), help = _U('generic_argument_help') } } )
  TriggerEvent('chat:addSuggestion', '/zde', 'Vytvoří na vašem místě cedulku',   { } )
  TriggerEvent('chat:addSuggestion', '/shirt', 'Sundat triko',   { } )
  TriggerEvent('chat:addSuggestion', '/bag', 'Sundat batoh',   { } )
  TriggerEvent('chat:addSuggestion', '/bracelet', 'Sundat náramek',   { } )
  TriggerEvent('chat:addSuggestion', '/ear', 'Sundat náušnice',   { } )
  TriggerEvent('chat:addSuggestion', '/glasses', 'Sundat brýle',   { } )
  TriggerEvent('chat:addSuggestion', '/gloves', 'Sundat rukavice',   { } )
  TriggerEvent('chat:addSuggestion', '/hair', 'Změnit účes',   { } )
  TriggerEvent('chat:addSuggestion', '/hat', 'Sundat čepici',   { } )
  TriggerEvent('chat:addSuggestion', '/mask', 'Sundat masku',   { } )
  TriggerEvent('chat:addSuggestion', '/neck', 'Sundat náhrdelník',   { } )
  TriggerEvent('chat:addSuggestion', '/shoes', 'Sundat boty',   { } )
  TriggerEvent('chat:addSuggestion', '/top', 'Sundat bundu',   { } )
  TriggerEvent('chat:addSuggestion', '/vest', 'Sundat vestu',   { } )
  TriggerEvent('chat:addSuggestion', '/visor', 'Prohození čepice',   { } )
  TriggerEvent('chat:addSuggestion', '/watch', 'Sundat hodinky',   { } )
  TriggerEvent('chat:addSuggestion', '/pants', 'Sundat kalhoty',   { } )
  TriggerEvent('chat:addSuggestion', '/revertclothing', 'Vrátit oblečení',   { } )
  TriggerEvent('chat:addSuggestion', '/reloadskin', 'Vrátit oblečení',   { } )
  TriggerEvent('chat:addSuggestion', '/bagoff', 'Sundat batoh',   { } )
  TriggerEvent('chat:addSuggestion', '/discord', 'Zobrazí ti náš discord',   { } )
  TriggerEvent('chat:addSuggestion', '/sheriff', 'Oznámení pro sheriffy!',   { { name = _U('generic_argument_name'), help = _U('generic_argument_help') } } )
	TriggerEvent('chat:addSuggestion', '/doc', 'Napíše za vás proces například /do 1/10 (max 60)', { { name = 'počet', help = 'počet opakování' } } )
end)

RegisterNetEvent('3ddo:triggerDisplay')
AddEventHandler('3ddo:triggerDisplay', function(text, source)
    local offsetdo = 2.1 + (nbrDisplaying*0.15)
    local target = GetPlayerFromServerId(source)
    if target ~= -1 then
    DisplayDo(GetPlayerFromServerId(source), text, offsetdo)
    end
end)

function DisplayDo(mePlayer, text, offsetdo)
    local displaying = true

    Citizen.CreateThread(function()
        Wait(5000)
        displaying = false
    end)
	
    Citizen.CreateThread(function()
        nbrDisplaying = nbrDisplaying + 1
        while displaying do
            Wait(0)
            local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
            local coords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist2(coordsMe, coords)
            if dist < 500 then
                 DrawText3Ddo(coordsMe['x'], coordsMe['y'], coordsMe['z']+offsetdo-1.250, text)
            end
        end
        nbrDisplaying = nbrDisplaying - 1
    end)
end

function DrawText3Ddo(x,y,z, text)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local p = GetGameplayCamCoords()
  local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
  local scale = (1 / distance) * 2
  local fov = (1 / GetGameplayCamFov()) * 100
  local scale = scale * fov
  if onScreen then
		SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
		local factor = (string.len(text)) / 370
		DrawRect(_x,_y+0.0125, 0.01+ factor, 0.03, 220, 173, 17, 68)
    end
end

-- 3D ME
RegisterNetEvent('3dme:triggerDisplay')
AddEventHandler('3dme:triggerDisplay', function(text, source)
    local offsetdoa = 2.1 + (nbrDisplaying*0.15)
    local target = GetPlayerFromServerId(source)
    if target ~= -1 then
    DisplayMe(GetPlayerFromServerId(source), text, offsetdoa)
    end
end)

function DisplayMe(mePlayer, text, offsetdo)
    local displaying = true

    Citizen.CreateThread(function()
        Wait(5000)
        displaying = false
    end)
	
    Citizen.CreateThread(function()
        nbrDisplaying = nbrDisplaying + 1
        while displaying do
            Wait(0)
            local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
            local coords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist2(coordsMe, coords)
            if dist < 500 then
                 DrawText3Dme(coordsMe['x'], coordsMe['y'], coordsMe['z']+offsetdo-1.250, text)
            end
        end
        nbrDisplaying = nbrDisplaying - 1
    end)
end


function DrawText3Dme(x,y,z, text)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local p = GetGameplayCamCoords()
  local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
  local scale = (1 / distance) * 2
  local fov = (1 / GetGameplayCamFov()) * 100
  local scale = scale * fov
  if onScreen then
		SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
		local factor = (string.len(text)) / 370
		DrawRect(_x,_y+0.0125, 0.01+ factor, 0.03, 153, 0, 153, 68)
    end
end

--3d doktor

RegisterNetEvent('3ddoctor:triggerDisplay')
AddEventHandler('3ddoctor:triggerDisplay', function(text, source)
    local offsetdoa = 2.1 + (nbrDisplaying*0.15)
    local target = GetPlayerFromServerId(source)
    if target ~= -1 then
    DisplayDoctor(GetPlayerFromServerId(source), text, offsetdoa)
    end
end)

function DisplayDoctor(mePlayer, text, offsetdo)
    local displaying = true

    Citizen.CreateThread(function()
        Wait(5000)
        displaying = false
    end)
    
    Citizen.CreateThread(function()
        nbrDisplaying = nbrDisplaying + 1
        while displaying do
            Wait(0)
            local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
            local coords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist2(coordsMe, coords)
            if dist < 500 then
                 DrawText3Ddoctor(coordsMe['x'], coordsMe['y'], coordsMe['z']+offsetdo-1.250, text)
            end
        end
        nbrDisplaying = nbrDisplaying - 1
    end)
end


function DrawText3Ddoctor(x,y,z, text)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local p = GetGameplayCamCoords()
  local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
  local scale = (1 / distance) * 2
  local fov = (1 / GetGameplayCamFov()) * 100
  local scale = scale * fov
  if onScreen then
        SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
        local factor = (string.len(text)) / 370
        DrawRect(_x,_y+0.0125, 0.01+ factor, 0.03, 0, 0, 255, 68)
    end
end

RegisterCommand('try', function(source, args, rawCommand)
  local number = math.random(1,2)
  if number == 1 then
    ExecuteCommand('rtjnfz Ano')
  elseif number == 2 then
    ExecuteCommand('rtjnfz Ne')
  end
end)
RegisterNetEvent('esx_rpchat:sendTry')
AddEventHandler('esx_rpchat:sendTry', function(playerId, title, message, color)
	local source = PlayerId()
	local target = GetPlayerFromServerId(playerId)

	if target ~= -1 then
	local sourcePed, targetPed = PlayerPedId(), GetPlayerPed(target)
	local sourceCoords, targetCoords = GetEntityCoords(sourcePed), GetEntityCoords(targetPed)

	if targetPed == source or #(sourceCoords - targetCoords) < 20 then
		TriggerEvent('chat:addMessage', {
      template = '<div style="font-family: Verdana, sans-serif; background-color: rgba(0, 0, 0, 0.8); border-radius: 5px; border: solid 1px rgba(243, 102, 33, 0.8); display: inline-block; padding: 0.3vw;"><div style="font-family: Verdana, sans-serif; background-color: rgba(243, 102, 33, 0.8); border-radius: 2px; display: inline-block; padding: 0.3vw; margin-right: 0.3vw;">TRY</div><div style="font-family: Verdana, sans-serif; font-weight: 800; display:inline-block;">{0}</div> {1}</div>', 
        args = { title, message }
    })
	end
  end
end)
-- KOSTKA
RegisterCommand('kostka', function(source, args, rawCommand)
  local number = math.random(1,6)
  ExecuteCommand('me Haze kostkou')
  Citizen.Wait(600)
  ExecuteCommand('do Spadlo ' ..number)
end)

function DrawText3DStav(x,y,z, text)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local p = GetGameplayCamCoords()
  local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
  local scale = (1 / distance) * 2
  local fov = (1 / GetGameplayCamFov()) * 100
  local scale = scale * fov
  if onScreen then
		SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
		local factor = (string.len(text)) / 370
		DrawRect(_x,_y+0.0125, 0.01+ factor, 0.03, 175, 118, 71, 100)
    end
end



RegisterNetEvent('rrp:twtNotify', function()


  lib.notify({
    title = 'Chat',
    description = 'Je nám líto, ale twitter je zpátky v telefonu.',
    position = 'top',
    style = {
        backgroundColor = '#141517',
        color = '#C1C2C5',
        ['.description'] = {
          color = '#909296'
        }
    },
    icon = 'fa-brands fa-twitter',
    iconColor = '#6897BB'
  })

end)