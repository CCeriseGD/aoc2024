local total1 = 0
local total2 = 0
local trailheads = {}
local g = input.grid(function(x, y, c)
    if c == "0" then
        table.insert(trailheads, {x, y})
    end
    return tonumber(c)
end)

for i, v in ipairs(trailheads) do
    local possible = {{v[1], v[2]}}
    for i = 1, 9 do
        local t = {}
        for j, v in ipairs(possible) do
            local x, y = v[1], v[2]
            if g:get(x, y-1) == i then
                table.insert(t, {x, y-1})
            end
            if g:get(x, y+1) == i then
                table.insert(t, {x, y+1})
            end
            if g:get(x-1, y) == i then
                table.insert(t, {x-1, y})
            end
            if g:get(x+1, y) == i then
                table.insert(t, {x+1, y})
            end
        end
        possible = t
    end
    local found = {}
    for i, v in ipairs(possible) do
        local s = v[1]..","..v[2]
        if not found[s] then
            total1 = total1 + 1
            found[s] = true
        end
    end
    total2 = total2 + #possible
end

output.part1(total1)
output.part2(total2)