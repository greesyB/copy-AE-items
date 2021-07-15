local comp = require("component")
local controller = comp.me_controller
local itemList = controller.allItems()
local create = require("createItems")

local x = -4333
local y = 76
local z = 262

for e in itemList do
  local id = ""
  local amount = 1
  local damage = 0.0
  local nbt = "{"

  for k,v in pairs(e) do
    if (k not "transferLimit" and k not "size" and k not "maxSize") then
      local itemVal = ""

      if type(v) == "string" then
        itemVal = "\"" .. v .. "\""
      else
        itemVal = tostring(v)
      end

      itemVal = itemVal .. ","

      local itemString = k .. ": " .. itemVal
      nbt = nbt .. itemString

      if k == "name" then
        id = v
      end

      if k == "damage" then
        damage = v
      end

    end

    if k == "size" then
      amount = v
    end

  end

  nbt = nbt.gsub(nbt, ", $", "")
  nbt = nbt .. "}"
  print(nbt)

  local inserted = create.insert(id, amount, damage, nbt, x, y, z)
  print("Inserted:", inserted)

  print("")
end
