
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
    --Mark mission start
    DrawMarker(22, cfg.startermission[1],cfg.startermission[2],cfg.startermission[3],0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 2.0, 2.0, 2.0, 0, 153, 250, 50, true, true, 2, nil, nil, true )

      --Player near mark
      if (GetDistanceBetweenCoords(coord.x, coord.y, coord.z, 2565.0576171875,4685.8911132813,34.08602142334 , true)) < 5.0 then  
        --Show text
        Draw3DText(cfg.startermission[1],cfg.startermission[2],cfg.startermission[3],cfg.lang.actions.missionstart,0.1,0.1)      if(IsControlJustReleased(1, cfg.keypress))then
        --Execute proccess on server
        TriggerServerEvent('vrp_gardener:startmission',function()
        end) 
      end 
    end
  end
end)


--When player in position to gardening
Citizen.CreateThread(function()
  while true do 
    Citizen.Wait(0) 
    local player = GetPlayerPed(-1)
    local coord = GetEntityCoords(player)
    local item = false 

    if cfg.numberLocation >= numberLocation then
      --Verify if player near gardening  location
      if (GetDistanceBetweenCoords(coord.x, coord.y, coord.z, pos[1],pos[2],pos[3], true)) < 5.0 then
        --Draw text to gardening  
        Draw3DText(pos[1],pos[2],pos[3],cfg.lang.actions.start,0.1,0.1)
        --Key press start gardening
        if (IsControlJustReleased(1, cfg.keypress)) then 
          TaskStartScenarioInPlace(player,"WORLD_HUMAN_GARDENER_PLANT", 0, true)   
          Citizen.Wait(10 * cfg.time) -- time for haverst  
          ClearPedTasksImmediately(player)
          --Finalize gardening
          TriggerServerEvent("vrp_gardener:receiveMoney",numberLocation)
        end
      end
    end
  end
end)

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