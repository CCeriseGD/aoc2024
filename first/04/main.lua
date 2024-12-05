local grid = {}
for line in love.filesystem.lines("input") do
    local t = {}
    for c in line:gmatch(".") do
        table.insert(t, c)
    end
    table.insert(grid, t)
end

local total1 = 0
local word = {"X", "M", "A", "S"}
for y = 1, #grid do
    for x = 1, #grid[y] do
        if grid[y][x] == word[1] then
            for dx = -1, 1 do
                for dy = -1, 1 do
                    for i = 1, #word - 1 do
                        local nx, ny = x + dx * i, y + dy * i
                        if not (grid[ny] and grid[ny][nx] == word[i+1]) then
                            break
                        elseif i == #word - 1 then
                            total1 = total1 + 1
                        end
                    end
                end
            end
        end
    end
end

local total2 = 0
for y = 2, #grid - 1 do
    for x = 2, #grid[y] - 1 do
        if grid[y][x] == "A" then
            local c1, c2, c3, c4 = grid[y-1][x-1], grid[y+1][x+1], grid[y-1][x+1], grid[y+1][x-1]
            if  ((c1 == "M" and c2 == "S") or (c1 == "S" and c2 == "M"))
            and ((c3 == "M" and c4 == "S") or (c3 == "S" and c4 == "M")) then
                total2 = total2 + 1
            end
        end
    end
end

print("part 1:", total1)
print("part 2:", total2)