local comp = require("component")
local controller = comp.me_controller
local itemList = controller.allItems()

local x = -4333
local y = 76
local z = 262

-- delete items file contents if there already are any
local f = io.open("items", "w")
f:close()

for e in itemList do
  local id = ""
  local amount = 1
  local damage = 0.0
  local nbt = "{"

  for k,v in pairs(e) do
    if (not(k == "transferLimit") and not(k == "size") and not(k == "maxSize") and not(k == "isCraftable")) then
      local itemVal = ""

      if type(v) == "string" then
        itemVal = "\"" .. v .. "\""
      else
        itemVal = tostring(v)
      end

      itemVal = itemVal .. ", "

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

  local fileString = id .. "," .. amount .. "," .. damage .. "," .. nbt .. "\n"

  local f = io.open("items", "a")
  f:write(fileString)
  f:close()

  print("")

  os.sleep(0.2)
end
