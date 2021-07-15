local create = require("createUtils")

local f = io.open("items", "r")

local x = -4333
local y = 76
local z = 262

function split (inputstr)
  local t={}
  for str in string.gmatch(inputstr, "([^####]+)") do
    table.insert(t, str)
  end
  return t
end

for line in f:lines() do
  local splitLine = split(line)

  local id = ""
  local amount = 1
  local damage = 0.0
  local nbt = ""

  local increment = 0
  for k,v in pairs(splitLine) do
    if increment == 0 then id = v end
    if increment == 1 then amount = tonumber(v) end
    if increment == 2 then damage = tonumber(v) end
    if increment >  2 then nbt = nbt .. v end

    increment = increment + 1
  end

  print("Attempting to insert " .. amount .. " of " .. id)
  -- print("id", id)
  -- print("amount", amount)
  -- print("damage", damage)
  -- print("nbt", nbt)

  create.insertAll(id, amount, damage, nbt, x, y, z, 1)

  print("");

  os.sleep(0.2)
end

f:close()
