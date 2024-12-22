local bit = require "bit"
local total1 = 0
local difftotals = defaulttable(0)
for line in input.lines() do
    local secret = tonumber(line)
    local diffs = {}
    local prev = 0
    local found = {}
    for i = 1, 2000 do
        secret = bit.bxor(secret*64, secret) % 16777216
        secret = bit.bxor(math.floor(secret/32), secret) % 16777216
        secret = bit.bxor(secret*2048, secret) % 16777216
        local price = secret % 10
        table.insert(diffs, price-prev)
        prev = price
        if #diffs > 4 then
            local dstr = table.concat(diffs, ",", #diffs-3)
            if not found[dstr] then
                found[dstr] = true
                difftotals[dstr] = difftotals[dstr] + price
            end
        end
    end
    total1 = total1 + secret
end
output.part1(total1)
local max = 0
for k, v in pairs(difftotals) do
    max = math.max(max, v)
end
output.part2(max)