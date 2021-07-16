local create = require("createUtils")

local x = -4333
local y = 76
local z = 262

-- Lua implementation of PHP scandir function
function scandir(directory)
  local i, t, popen = 0, {}, io.popen
  local pfile = popen('ls -a "'..directory..'"')
  for filename in pfile:lines() do
      i = i + 1
      t[i] = filename
  end
  pfile:close()
  return t
end

function split (inputstr)
  local t={}
  for str in string.gmatch(inputstr, "([^####]+)") do
    table.insert(t, str)
  end
  return t
end

local allFiles = scandir("/home/copy-AE-items")
local processed = 0

for k,v in pairs(allFiles) do
  if string.find(v, "items") then
    print(k, v)

    local f = io.open(v, "r")

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
      local numInserted = create.insertAll(id, amount, damage, nbt, x, y, z, 1)

      if numInserted == 0 then
        local fFailed = io.open("failedItems", "a")
        fFailed:write("id: \"" .. id .. ":" .. damage .. "\"" .. " amount: " .. amount)
        fFailed:close()
      end
    
      print("");
    
      os.sleep(0.1)
    end
    
    f:close()

    processed = processed + 1

  end
end

print("Processed " .. processed .. " item files. Done.")
