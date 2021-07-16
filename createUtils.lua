local debug = require("component").debug

--local x = -4333
--local y = 76
--local z = 262

--[[
  Must pass:
  id (String <mod:item>)
  damage (Num <damage>)
  nbt (String <stringified json>)
  amount (Num <amount>)
--]]

-- Assumes overworld
local world = debug.getWorld(0)

local create = {}

-- Inserts at most one stack of the given item
function create.insert(id, amount, damage, nbt, x, y, z, side)
  side = side or 1

  --print("Attempting to insert item ", id, damage, "to location", x, y, z, "side:", side)
  
  local inserted = world.insertItem(id, amount, damage, nbt, x, y, z, side)

  return inserted
end

-- Loops to insert the `amount` of a given item in its entirety
function create.insertAll(id, amount, damage, nbt, x, y, z, side)
  local numInserted = 0
  local timesInserted = 0

  while not(numInserted == amount) do
    local toInsert = 64

    if amount - numInserted < 64 then
      toInsert = amount - numInserted
    end

    -- 32 stacks per tick with UEV conveyor, must output to 4 interfaces
    if timesInserted % 32 == 0 then
      os.sleep(0.1)
    end

    local wasInserted = create.insert(id, toInsert, damage, nbt, x, y, z)

    if not(wasInserted) then break end

    numInserted = numInserted + toInsert
    timesInserted = timesInserted + 1
  end

  print("Inserted " .. numInserted .. " of " .. id .. ":" .. damage)

end

return create
