--assumes that every pair of elements in each list has a rule (apparently true for all inputs)
local total1, total2 = 0, 0
local rules = {}
function iscorrect(t)
    local start = table.concat(t, ",")
    table.sort(t, function(x, y)
        return rules[x.."|"..y]
    end)
    return table.concat(t, ",") == start
end
for line in input.lines() do
    if line:match("|") then
        rules[line] = true
    elseif #line > 0 then
        local t = {}
        for m in line:gmatch("%d+") do
            table.insert(t, m)
        end
        local middle = (#t + 1)/2
        if iscorrect(t) then
            total1 = total1 + t[middle]
        else
            total2 = total2 + t[middle]
        end
    end
end
output.part1(total1)
output.part2(total2)