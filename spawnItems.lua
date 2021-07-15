local create = require("createUtils")

local f = io.open("items", "r")

local line = 1
while true do
  local text = f:read("*" .. line)

  print(text)

  line = line + 1
end

f:close()
