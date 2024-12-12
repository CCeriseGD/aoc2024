local total1 = 0
local total2 = 0
local grid = {}
for line in love.filesystem.lines("input") do
    local t = {}
    for c in line:gmatch(".") do
        table.insert(t, c)
    end
    table.insert(grid, t)
end
local found = {}
for y = 1, #grid do
    for x = 1, #grid[1] do
        if not (found[y] and found[y][x]) then
            local plant = grid[y][x]
            local possible = {{x, y}}
            found[y] = found[y] or {}
            found[y][x] = plant
            local area, perimeter, sides = 1, 0, 0
            local perimtop, perimbottom, perimleft, perimright = {}, {}, {}, {}
            while #possible > 0 do
                local t = {}
                for j, v in ipairs(possible) do
                    local nx, ny = v[1], v[2]
                    perimtop[ny] = perimtop[ny] or {}
                    perimbottom[ny] = perimbottom[ny] or {}
                    perimleft[ny] = perimleft[ny] or {}
                    perimright[ny] = perimright[ny] or {}
                    if grid[ny-1] and grid[ny-1][nx] == plant then
                        if not (found[ny-1] and found[ny-1][nx]) then
                            table.insert(t, {nx, ny-1})
                            found[ny-1] = found[ny-1] or {}
                            found[ny-1][nx] = plant
                            area = area + 1
                        end
                    else
                        perimeter = perimeter + 1
                        perimtop[ny][nx] = true
                    end
                    if grid[ny+1] and grid[ny+1][nx] == plant then
                        if not (found[ny+1] and found[ny+1][nx]) then
                            table.insert(t, {nx, ny+1})
                            found[ny+1] = found[ny+1] or {}
                            found[ny+1][nx] = plant
                            area = area + 1
                        end
                    else
                        perimeter = perimeter + 1
                        perimbottom[ny][nx] = true
                    end
                    if grid[ny] and grid[ny][nx-1] == plant then
                        if not (found[ny] and found[ny][nx-1]) then
                            table.insert(t, {nx-1, ny})
                            found[ny] = found[ny] or {}
                            found[ny][nx-1] = plant
                            area = area + 1
                        end
                    else
                        perimeter = perimeter + 1
                        perimleft[ny][nx] = true
                    end
                    if grid[ny] and grid[ny][nx+1] == plant then
                        if not (found[ny] and found[ny][nx+1]) then
                            table.insert(t, {nx+1, ny})
                            found[ny] = found[ny] or {}
                            found[ny][nx+1] = plant
                            area = area + 1
                        end
                    else
                        perimeter = perimeter + 1
                        perimright[ny][nx] = true
                    end
                end
                possible = t
            end
            for y, v in pairs(perimtop) do
                for x, _ in pairs(v) do
                    if not v[x+1] then
                        sides = sides + 1
                    end
                end
            end
            for y, v in pairs(perimbottom) do
                for x, _ in pairs(v) do
                    if not v[x+1] then
                        sides = sides + 1
                    end
                end
            end
            for y, v in pairs(perimright) do
                for x, _ in pairs(v) do
                    if not (perimright[y-1] or {})[x] then
                        sides = sides + 1
                    end
                end
            end
            for y, v in pairs(perimleft) do
                for x, _ in pairs(v) do
                    if not (perimleft[y-1] or {})[x] then
                        sides = sides + 1
                    end
                end
            end
            total1 = total1 + area*perimeter
            total2 = total2 + area*sides
        end
    end
end
print("part 1:", string.format("%d", total1))
print("part 2:", string.format("%d", total2))