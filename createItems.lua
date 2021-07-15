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

function create.insert(id, amount, damage, nbt, x, y, z, side) {
    side = side or 1

    --print("Attempting to insert item ", id, damage, "to location", x, y, z, "side:", side)
    
    local inserted = world.insertItem(id, amount, damage, nbt, x, y, z, side)

    print("First I:", inserted)
    return inserted
}

return create
