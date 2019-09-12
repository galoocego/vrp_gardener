In construction


<h4>vrp_gardener</h4>
Gardener mission, buy your shears and work with gardering. 
<br>
Use a shears for each gardening
<br>
<br>

<h4>Requeriements</h4>
<ul>
    <li>vRP vesrsion 0.5</li>
    <li>Superior versions not tested</li>
</ul>

<br>
<br>

<h4>Config</h4>
add on vrp/market.lua shears item and costs.

```lua
cfg.market_types = {
  ["food_or_other"] = {
      ["shears"] = 250
  }
}
```
if you want, you can add in your shoopmarket too

<br>
add on vrp/items.lua the shears item and leaves

```lua
cfg.item {
    ["shears"] = {"shears", "shears for gardener.", nil, 0.3}
}
```
<br>
add on vrp/cfg/blips_markes.lua blip for start mission (use config/config.lua, cfg.startmission coords)

```lua
    {2565.0576171875, 4685.8911132813, 34.08602142334,468,12,"Get a gardener locations"}
```
<br>
Set your language or create a new file for your language (lang/xx.lua)

<br>
<br>
Set gardener locations, set your language, price and more
<br>
cfg/config.lua

<br>
<br>
<br>
<br>
This script is based on vrp_farmer

#  vrp_farmer https://github.com/reymihai/vrp_farmer