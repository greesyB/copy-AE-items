local comp = require("component")
local controller = comp.me_controller
local itemList = controller.allItems()

local inc = 0
for e in itemList do
  local id = ""
  local amount = 1
  local damage = 0.0
  local nbt = "{"

  for k,v in pairs(e) do
    -- Skip non-NBT tags
    if (
      e["hasTag"] == true and (
      not(k == "size") and
      not(k == "maxSize") and
      not(k == "name") and
      not(k == "label") and
      not(k == "damage") and
      not(k == "maxDamage") and
      not(k == "isCraftable") and
      not(k == "transferLimit") and
      not(k == "hasTag"))
    ) then
      local itemVal = ""

      if type(v) == "string" then
        itemVal = "\"" .. v .. "\""
      else
        itemVal = tostring(v)
      end

      itemVal = itemVal .. ", "

      local itemString = k .. ": " .. itemVal
      nbt = nbt .. itemString

    end

    if k == "name" then
      id = v
    end

    if k == "damage" then
      damage = v
    end

    if k == "size" then
      amount = v
    end

  end

  nbt = nbt.gsub(nbt, "[\n\r]", "")
  nbt = nbt.gsub(nbt, ", $", "")
  nbt = nbt .. "}"
  print(nbt)

  local fileString = id .. "####" .. amount .. "####" .. damage .. "####" .. nbt .. "\n"
  local fnum = math.floor(inc / 500)
  if fnum < 1 then fnum = 1 end
  local f = io.open("items" .. fnum, "a")
  f:write(fileString)
  f:close()

  inc = inc + 1
  if inc % 20 == 0 then
    os.sleep(0.1)
  end
end
