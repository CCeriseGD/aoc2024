local grid = {}
local guardx, guardy = 0, 0
for line in love.filesystem.lines("input") do
    local t = {}
    for c in line:gmatch(".") do
        if c == "^" then
            table.insert(t, ".")
            guardx = #t
            guardy = #grid + 1
        else
            table.insert(t, c)
        end
    end
    table.insert(grid, t)
end

function calcroute(sx, sy, bx, by)
    local guardx, guardy = sx, sy
    local guarddir = 0
    local count = 1
    local found = {}
    while true do
        local nx, ny = guardx, guardy
        if guarddir == 0 then
            ny = ny - 1
        elseif guarddir == 1 then
            nx = nx + 1
        elseif guarddir == 2 then
            ny = ny + 1
        elseif guarddir == 3 then
            nx = nx - 1
        end
        if not (grid[ny] and grid[ny][nx]) then
            break
        end
        local c = grid[ny][nx]
        if c == "#" or (nx == bx and ny == by) then
            guarddir = (guarddir + 1) % 4
        else
            guardx, guardy = nx, ny
            if not (found[ny] and found[ny][nx]) then
                found[ny] = found[ny] or {}
                found[ny][nx] = guarddir
                count = count + 1
            elseif found[ny][nx] == guarddir then
                return count, found, true
            end
        end
    end
    return count, found, false
end

local count, found = calcroute(guardx, guardy)
local loopcount = 0
for y, v in pairs(found) do
    for x, _ in pairs(v) do
        local _, _, loop = calcroute(guardx, guardy, x, y)
        if loop then
            loopcount = loopcount + 1
        end
    end
end

print("part 1:", count)
print("part 2:", loopcount)



