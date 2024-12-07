local total1 = 0
local total2 = 0
for line in love.filesystem.lines("input") do
    local testvalue, values = line:match("(%d+): (.+)")
    testvalue = tonumber(testvalue)
    local totals = {}
    for m in values:gmatch("%d+") do
        local n = tonumber(m)
        local t = {}
        if #totals == 0 then
            table.insert(t, {n, ""})
        else
            for i = 1, #totals do
                local vadd = totals[i][1] + n
                local vmul = totals[i][1] * n
                local vconcat = tonumber(tostring(totals[i][1]) .. tostring(n))
                if vadd <= testvalue then
                    table.insert(t, {vadd, totals[i][2].."+"})
                end
                if vmul <= testvalue then
                    table.insert(t, {vmul, totals[i][2].."*"})
                end
                if vconcat <= testvalue then
                    table.insert(t, {vconcat, totals[i][2].."|"})
                end
            end
        end
        totals = t
    end
    for i = 1, #totals do
        if totals[i][1] == testvalue and not totals[i][2]:match("|") then
            total1 = total1 + testvalue
            break
        end
    end
    for i = 1, #totals do
        if totals[i][1] == testvalue then
            total2 = total2 + testvalue
            break
        end
    end
end
print("part 1:", string.format("%d", total1))
print("part 2:", string.format("%d", total2))



