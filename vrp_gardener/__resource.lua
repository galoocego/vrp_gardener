resource_manifest_version '44febabe-d386-4d18-escob-5e627f4af937'

description "vRP Gardener"

dependency "vrp"

client_scripts{ 
  "@vrp/lib/utils.lua",
  "@vrp/lib/Tunnel.lua",
  "@vrp/lib/Proxy.lua",
  "client.lua",
}

server_scripts{ 
  "@vrp/lib/utils.lua", 
  "@vrp/lib/Tunnel.lua",
  "@vrp/lib/Proxy.lua",
  "server.lua",
}

files{
  "cfg/config.lua",
  "lang/br.lua",
  "lang/en.lua"
}