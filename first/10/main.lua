local total1 = 0
local total2 = 0
local grid = {}
local trailheads = {}
for line in love.filesystem.lines("input") do
    local t = {}
    for m in line:gmatch(".") do
        table.insert(t, tonumber(m))
        if m == "0" then
            table.insert(trailheads, {#t, #grid+1})
        end
    end
    table.insert(grid, t)
end

for i, v in ipairs(trailheads) do
    local possible = {{v[1], v[2]}}
    for i = 1, 9 do
        local t = {}
        for j, v in ipairs(possible) do
            local x, y = v[1], v[2]
            if grid[y-1] and grid[y-1][x] == i then
                table.insert(t, {x, y-1})
            end
            if grid[y+1] and grid[y+1][x] == i then
                table.insert(t, {x, y+1})
            end
            if grid[y] and grid[y][x-1] == i then
                table.insert(t, {x-1, y})
            end
            if grid[y] and grid[y][x+1] == i then
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

print("part 1:", string.format("%d", total1))
print("part 2:", string.format("%d", total2))