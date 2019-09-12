local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPclient = Tunnel.getInterface("vRP", "vrp_gardener") 
vRP = Proxy.getInterface("vRP")--"vRP")

vRPps = {}
Tunnel.bindInterface("vrp_gardener",vRPps)

--------------------------
local cfg = module("vrp_gardener","cfg/config")

local position = {}

--Start mission, set prune location
RegisterServerEvent('vrp_gardener:startmission')
AddEventHandler('vrp_gardener:startmission', function(pos)
    local thePlayer = source
    local user_id = vRP.getUserId({thePlayer})
    local money =  vRP.getMoney({user_id})

    if user_id ~= nil then 

        local teste = vRP.getInventoryMaxWeight(user_id)
        print("passou")
        
        --[[
        if ((vRP.getInventoryWeight(user_id)+vRP.getItemWeight("leaves")) <= vRP.getInventoryMaxWeight(user_id)) then
			vRP.giveInventoryItem(user_id,peixe,1,true)
		else
			 vRPclient.notify(vRP.getUserSource(user_id), "~r~Seu inventory esta cheio.")
		end
--]]
        --random positions
        id = math.random(1, #cfg.prunelocations)
        position = cfg.prunelocations[id]

        --add blip on mission
        vRPclient.setNamedMarker(user_id,{"vRP:mission",position[1],position[2],position[3],0.7,0.7,0.5,255,226,0,125,150})

        --set mission on gps
        vRPclient.setGPS(thePlayer,{position[1],position[2]})

        --return to client random position
        TriggerClientEvent("vrp_gardener:returnposition", user_id, position)
    end
end)

--Receive trash leaves when player is pruning
RegisterServerEvent('vrp_gardener:inventoryadd')
AddEventHandler('vrp_gardener:inventoryadd', function()
    local thePlayer = source
    local user_id = vRP.getUserId({thePlayer})
    if user_id ~= nil then 
       vRP.giveInventoryItem({user_id, "leaves", 80, true}) 
    end
end) 

--[[
--Recebendo o pagamento
RegisterServerEvent('trashleaves') 
AddEventHandler('trashleaves', function()
    local thePlayer = source
    local user_id = vRP.getUserId({thePlayer})
    local leaves = vRP.getInventoryItemAmount({user_id,"leaves"}) 
    local paycheck =  cfg.valupertrash * leaves
    if vRP.tryGetInventoryItem({user_id, "leaves", leaves, true}) then           
        vRP.giveMoney({user_id, paycheck})
        vRPclient.notify(thePlayer, {cfg.lang.actions.recmoney})  
    else 
        vRPclient.notify(thePlayer, {cfg.lang.actions.nontrash})  
    end
end) 


--[[
----------------------------------------



--If you have plants in your inventory
vRP.defInventoryItem({"plantseeds", "Seeds", "Some seeds, plant them in the near field", function(args) 
    local choices = {}
	
	choices["Use"] = {function(player,choice,mod)
		local user_id = vRP.getUserId({player})
        if user_id ~= nil then
            vRP.tryGetInventoryItem({user_id, "plantseeds", 1, true})
            TriggerClientEvent('farm', player)
            vRP.closeMenu({player})
        end
    end}
   
    return choices
end, 0.05})  

amount = 1000           -- the cost for 1 plant seed
 
plata = 3000     -- the cost for 1 sac of flour

--]]