resource_manifest_version '44febabe-d386-4d18-escob-5e627f4af937'

description "vRP Gardener"

--dependency "vrp"

dependencies {
	'vrp'
}

client_scripts{ 
  "@vrp/lib/utils.lua",
  "lib/Proxy.lua",
  "lib/Tunnel.lua",
  "client.lua",
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "lib/Proxy.lua",
  "lib/Tunnel.lua",
  "server.lua",
}

files{
  "config/config.lua",
  "lang/br.lua",
  "lang/en.lua"
}