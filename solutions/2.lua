function reportissafe(str)
    local prev, others = str:match("(%d+)%s(.+)")
    prev = tonumber(prev)
    local safe = true
    local prevdiff
    for m in others:gmatch("(%d+)") do
        local n = tonumber(m)
        local diff = n - prev
        if diff == 0 or math.abs(diff) > 3 then
            safe = false
        end
        local diffsign = 1
        if diff < 0 then
            diffsign = -1
        end
        if prevdiff and prevdiff ~= diffsign then
            safe = false
        end
        prev, prevdiff = n, diffsign
    end
    return safe
end

local total1 = 0
local total2 = 0
for line in input.lines() do
    if reportissafe(line) then
        total1 = total1 + 1
    end
    local possiblereports = {}
    table.insert(possiblereports, line)
    local numbers = {}
    for m in line:gmatch("(%d+)") do
        table.insert(numbers, m)
    end
    for i = 1, #numbers do
        local t = {}
        for j = 1, #numbers do
            if i ~= j then
                table.insert(t, numbers[j])
            end
        end
        table.insert(possiblereports, table.concat(t, " "))
    end
    for i = 1, #possiblereports do
        if reportissafe(possiblereports[i]) then
            total2 = total2 + 1
            break
        end
    end
end
output.part1(total1)
output.part2(total2)