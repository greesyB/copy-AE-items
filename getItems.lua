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

  local numInserted = 0
  local timesInserted = 0
  while not(numInserted == amount) do
    local toInsert = 64

    if amount - numInserted < 64 then
      toInsert = amount - numInserted
    end

    -- 9 slots in interface
    if timesInserted % 9 == 0 then
      os.sleep(0.1)
    end

    local wasInserted = create.insert(id, toInsert, damage, nbt, x, y, z)

    if not(wasInserted) then break end

    numInserted = numInserted + toInsert
    timesInserted = timesInserted + 1
  end
  print("Inserted:", numInserted, "of", id)
  print("")

  os.sleep(0.2)
end
