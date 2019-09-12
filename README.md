In construction


<h4>vrp_gardener</h4>
Gardener mission, buy your crunsh, prune plants and sell branches and leaves harvested
<br>
<br>

<h4>Requeriements</h4>
<ul>
    <li>vRP vesrsion 0.5</li>
</ul>

<br>
<br>

<h4>Config</h4>
add on vrp/market.lua crump item and costs.

```lua
cfg.market_types = {
  ["food_or_other"] = {
      ["crump"] = 250
  }
}
```
if you want, you can add in your shoopmarket too

<br>
add on vrp/items.lua the crump item and leaves

```lua
cfg.item {
    ["crump"] = {"Tesoura", "Tesoura para jardinagem.", nil, 0.3}
}
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