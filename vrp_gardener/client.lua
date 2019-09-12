
vRP = Proxy.getInterface("vRP", "vrp_gardener") 
vRPclient = Tunnel.getInterface("vRP", "vrp_gardener") 

local position = {}
local aux = 0

cfg = module("vrp_gardener","config/config")

local pos = {}
local numberLocation = 0
--Receive position blip prune
RegisterNetEvent("vrp_gardener:returnposition")
AddEventHandler("vrp_gardener:returnposition", function(position)
  pos = position
  numberLocation = numberLocation + 1
end)


--Initialize gardener mission
Citizen.CreateThread(function()
  while true do 
    Citizen.Wait(0) 
    local player = GetPlayerPed(-1)
    local coord = GetEntityCoords(player)
    DrawMarker(22, cfg.startermission[1],cfg.startermission[2],cfg.startermission[3],0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 2.0, 2.0, 2.0, 0, 153, 250, 50, true, true, 2, nil, nil, true )

      if (GetDistanceBetweenCoords(coord.x, coord.y, coord.z, 2565.0576171875,4685.8911132813,34.08602142334 , true)) < 5.0 then  
        Draw3DText(cfg.startermission[1],cfg.startermission[2],cfg.startermission[3],cfg.lang.actions.start,0.1,0.1)      if(IsControlJustReleased(1, cfg.keypress))then
        TriggerServerEvent('vrp_gardener:startmission',function()
        end) 
      end 
    end
  end
end)


--When player in position to crump
Citizen.CreateThread(function()
  while true do 
    Citizen.Wait(0) 
    local player = GetPlayerPed(-1)
    local coord = GetEntityCoords(player)
    local item = false 

    if cfg.numberLocation >= numberLocation then
      --Verify if player has crump
      if (GetDistanceBetweenCoords(coord.x, coord.y, coord.z, pos[1],pos[2],pos[3], true)) < 5.0 then
        Draw3DText(pos[1],pos[2],pos[3],cfg.lang.actions.start,0.1,0.1)
        if (IsControlJustReleased(1, cfg.keypress)) then 
          TaskStartScenarioInPlace(player,"WORLD_HUMAN_GARDENER_PLANT", 0, true)   
          Citizen.Wait(10 * cfg.time) -- time for haverst  
          ClearPedTasksImmediately(player)
          print(player)
          TriggerServerEvent("vrp_gardener:receiveMoney",numberLocation)
        end
      end
    end
  end
end)

--[[
--Trash leaves location
Citizen.CreateThread(function()
  while true do 
    Citizen.Wait(0)
    local player = GetPlayerPed(-1)
    local coord = GetEntityCoords(player) 
    
    if (GetDistanceBetweenCoords(coord.x, coord.y, coord.z, cfg.trasheaveslocation, true)) < 5.0 then    
      Draw3DText(cfg.trasheaveslocation,cfg.lang.actions.trashleaves,0.1,0.1)
      DrawMarker(0, cfg.trasheaveslocation,0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 2.0, 2.0, 2.0, 255, 128, 0, 50,true, true, 2, nil, nil, true )
    
      if(IsControlJustReleased(1, cfg.keypress))then
        TriggerServerEvent('trashleaves')
      end
    end
  end
end)
--]]

function Draw3DText(x,y,z,textInput,scaleX,scaleY)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    
    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov   
    SetTextScale(scaleX*scale, scaleY*scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextColour(250, 250, 250, 255)
    SetTextDropshadow(1, 1, 1, 1, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
end



-----------------------------------------
--[[

--Esse tá zuado....
RegisterNetEvent('farm')
AddEventHandler('farm', function()
  local player = GetPlayerPed(-1)
  local coord = GetEntityCoords(player) 
  --In local to prune
  if (GetDistanceBetweenCoords(position, x, y, z-1.7, true)) < 40.0 then
    Draw3DText(position,cfg.lang.actions.start,0.1,0.1)
    DrawMarker(0, position,0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 2.0, 2.0, 2.0, 255, 128, 0, 50,true, true, 2, nil, nil, true )
    --Accept prune
    if(IsControlJustReleased(1, cfg.keypress))then
      TaskStartScenarioInPlace(player,"WORLD_HUMAN_GARDENER_PLANT", 0, true)   
      vRP.notify(cfg.lang.actions.haverst)

      Citizen.Wait(timplagradinarit * cfg.time) -- time for haverst  
      ClearPedTasksImmediately(player)
    end
  else 
    vRP.notify({"~r~You can plant this only in the field!"})
  end   
end)
 --]]