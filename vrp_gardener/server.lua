local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

local cfg = model("config/config")

vRPclient = Tunnel.getInterface("vRP", "vrp_gardener") 
vRP = Proxy.getInterface("vRP")

local position = {}

--Verify if player has crump
RegisterServerEvent('inventorycrump')
AddEventHandler('inventorycrump', function(item) 
    if vRP.tryGetInventoryItem({user_id, "leaves", cfg.trashleaves, true}) then
        item(true)
    else
        item(false)
    end
end)

--Start mission, set prune location
RegisterServerEvent('startmission')
AddEventHandler('startmission', function(pos)
    local thePlayer = source
    local user_id = vRP.getUserId({thePlayer})
    local money =  vRP.getMoney({user_id})
      if user_id ~= nil then 
        --Verify if player has a crump
        item = false
        TriggerServerEvent('inventorycrump', function(i) 
            item = i
        end)

        if item then
            --position = v.positions[math.random(1, cfg.prunelocations)]
            position = math.random(1, cfg.prunelocations)

            --setando local para o farm
            vRPclient.setNamedMarker(user_id,{"vRP:mission",position,0.7,0.7,0.5,255,226,0,125,150})
            --return to client random position
            pos(position)

            --vRPclient.setNamedMarker(player,{"vRP:mission", x,y,z-1,0.7,0.7,0.5,255,226,0,125,150})
            --vRP.setArea(player,"vRP:mission",x,y,z,1,1.5,step.onenter,step.onleave)
        else
            vRPclient.notify(thePlayer,{cfg.lang.actions.noncrump})
        end
    end
end)

--Receive trash leaves when player is pruning
RegisterServerEvent('inventoryadd')
AddEventHandler('inventoryadd', function()
    local thePlayer = source
    local user_id = vRP.getUserId({thePlayer})
    if user_id ~= nil then 
       vRP.giveInventoryItem({user_id, "flour", 1, true}) 
    end
end) 

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