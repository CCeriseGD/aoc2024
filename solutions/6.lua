local guardx, guardy = 0, 0
local g = input.grid(function(x, y, c)
    if c == "^" then
        guardx = x
        guardy = y
        return "."
    end
end)

function calcroute(sx, sy, bx, by)
    local guardx, guardy = sx, sy
    local guarddir = 0
    local count = 1
    local found = grid(g.w, g.h)
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
        if not g:inside(nx, ny) then
            break
        end
        local c = g:get(nx, ny)
        if c == "#" or (nx == bx and ny == by) then
            guarddir = (guarddir + 1) % 4
        else
            guardx, guardy = nx, ny
            local f = found:get(nx, ny)
            --looking at this again i feel like some very specific edge cases might break this
            --probably not a problem in the inputs tho
            if not f then
                found:set(nx, ny, guarddir)
                count = count + 1
            elseif f == guarddir then
                return count, found, true
            end
        end
    end
    return count, found, false
end

local count, found = calcroute(guardx, guardy)
local loopcount = 0
for x, y, v in found:loop() do
    if v then
        local _, _, loop = calcroute(guardx, guardy, x, y)
        if loop then
            loopcount = loopcount + 1
        end
    end
end

output.part1(count)
output.part2(loopcount)



