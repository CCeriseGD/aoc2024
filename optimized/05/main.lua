--assumes that every pair elements in each list has a rule (apparently true for all inputs)
local total1, total2 = 0, 0
local rules = {}
function iscorrect(t)
    local start = table.concat(t, ",")
    table.sort(t, function(x, y)
        return rules[x] and rules[x][y]
    end)
    return table.concat(t, ",") == start
end
for line in love.filesystem.lines("input") do
    if line:match("|") then
        local n1, n2 = line:match("(%d+)|(%d+)")
        rules[n1] = rules[n1] or {}
        rules[n1][n2] = true
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
print("part 1:", total1)
print("part 2:", total2)