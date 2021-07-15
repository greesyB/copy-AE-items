local comp = require("component")
local controller = comp.me_controller
local itemList = controller.allItems()

for e in itemList do
  local itemData = {}
  local nbt = "{"
  for k,v in pairs(e) do
    local itemVal = ""

    if type(v) == "string" then
      itemVal = "\\\"" .. v .. "\\\""
    else
      itemVal = tostring(v)
    end
    itemVal = itemVal .. ","

    local itemString = k .. ": " .. itemVal
    nbt = nbt .. itemString
  end

  nbt = nbt .. "}"
  print(nbt)
  print("")
end
