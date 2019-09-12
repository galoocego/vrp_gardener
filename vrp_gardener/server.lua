local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPclient = Tunnel.getInterface("vRP", "vrp_gardener") 
vRP = Proxy.getInterface("vRP")--"vRP")

vRPps = {}
Tunnel.bindInterface("vrp_gardener",vRPps)

--------------------------
local cfg = module("vrp_gardener","config/config")

local position = {}

--Start mission, set prune location
RegisterServerEvent('vrp_gardener:startmission')
AddEventHandler('vrp_gardener:startmission', function()
    local thePlayer = source
    local user_id = vRP.getUserId({thePlayer})
    if user_id ~= nil then 
        newPruneLocation(thePlayer)
    end
end)

--create and set on GPS prune location
function newPruneLocation(thePlayer)
    local user_id = vRP.getUserId({thePlayer})

    --random positions
    local pos = ""
    id = math.random(1, #cfg.prunelocations)
    pos = cfg.prunelocations[id]

    --add blip on mission
    vRPclient.setNamedMarker(user_id,{"vRP:mission",pos[1],pos[2],pos[3],0.7,0.7,0.5,255,226,0,125,150})

    --set mission on gps
    vRPclient.setGPS(thePlayer,{pos[1],pos[2]})

    --return to client random position
    TriggerClientEvent("vrp_gardener:returnposition", user_id, pos)
end

--Receive trash leaves when player is pruning
RegisterServerEvent('vrp_gardener:receiveMoney')
AddEventHandler('vrp_gardener:receiveMoney', function(numberLocation)
    local thePlayer = source
    local user_id = vRP.getUserId({thePlayer})
    if user_id ~= nil then 
       vRP.giveMoney({user_id, cfg.amount})
       vRPclient.notify(thePlayer, {cfg.lang.actions.recmoney})

       --If has locations for prune
       if numberLocation < cfg.numberLocations then
        --generate new location and return to player
        newPruneLocation(user_id)
       end
    end
end) 