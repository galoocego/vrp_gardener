local language = "lang/en"

--set on model your language, change br for en.....
local lang = module("vrp_gardener","lang/br")


cfg = {}

--set your language
cfg.lang = lang

--set key for action E (if u change this, u need change actions on your lang)
cfg.keypress = 51

--set harvest time
cfg.time = 1000

--set amount receive for prune
cfg.amount = 600

--set starter mission location
cfg.startermission = {  2565.0576171875, 4685.8911132813, 34.08602142334  }

--set number locations player can prune when start mission
cfg.numberLocations = 4

--set locations for prune, random locations
cfg.prunelocations = {
    --{879.5114746094,4489.646484375,48.19352722168},
    {2541.66015625,4688.4423828125,33.651695251464},
    {2548.0476074219,4700.572265625,33.679573059082}
}

return cfg