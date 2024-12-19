local total1 = 0
local total2 = 0
local towels, maxlen
for line in input.lines() do
    if not towels then
        towels = {}
        for m in line:gmatch("[wubrg]+") do
            towels[#m] = towels[#m] or {}
            table.insert(towels[#m], m)
        end
        maxlen = table.maxn(towels)
    elseif #line > 0 then
        local options = {}
        for i = 1, #line do
            options[i] = {}
            local sub = line:sub(i, -1)
            for j = 1, maxlen do
                if towels[j] then
                    for _, v in ipairs(towels[j]) do
                        if sub:match("^"..v) then
                            options[i][j] = v
                            break
                        end
                    end
                end
            end
        end
        local pos = defaulttable(0)
        pos[1] = 1
        for i = 1, #line do
            for j = math.max(1, i - maxlen + 1), i do
                local len = i - j + 1
                if options[j][len] then
                    pos[i+1] = pos[i+1] + pos[j]
                end
            end
        end
        if pos[#line+1] > 0 then
            total1 = total1 + 1
            total2 = total2 + pos[#line+1]
        end
    end
end
output.part1(total1)
output.part2(total2)