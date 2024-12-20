local total1 = 0
local total2 = 0
local sx, sy
local goalx, goaly
local g = input.grid(function(x, y, c)
    if c == "S" then
        sx, sy = x, y
        return "."
    elseif c == "E" then
        goalx, goaly = x, y
        return "."
    end
end)
g:setdef(nil, "#")

function getadj(g, x, y)
    local t = {}
    for i, v in ipairs({{x, y-1}, {x, y+1}, {x-1, y}, {x+1, y}}) do
        if g:get(v[1], v[2]) == "." then
            table.insert(t, v)
        end
    end
    return t
end
function heuristic(g, x, y, ex, ey)
    return math.abs(ex - x) + math.abs(ey - y)
end

local fulllen, path = g:pathfind(sx, sy, goalx, goaly, getadj, heuristic, true)
for i, v in ipairs(path) do
    g:set(v[1], v[2], fulllen-i)
end
for si, v in ipairs(path) do
    local x, y = unpack(v)
    local pos1 = {}
    for nx, ny, v in g:loop(x - 2, y - 2, x + 2, y + 2) do
        if v ~= "#" and math.abs(x-nx) + math.abs(y-ny) <= 2 then
            table.insert(pos1, {nx, ny})
        end
    end
    local pos2 = {}
    for nx, ny, v in g:loop(x - 20, y - 20, x + 20, y + 20) do
        if v ~= "#" and math.abs(x-nx) + math.abs(y-ny) <= 20 then
            table.insert(pos2, {nx, ny})
        end
    end
    for i, v in ipairs(pos1) do
        local nx, ny = unpack(v)
        local saved = g:get(x, y) - g:get(nx, ny) - 2
        if saved >= 100 then total1 = total1 + 1 end
    end
    for i, v in ipairs(pos2) do
        local nx, ny = unpack(v)
        local saved = g:get(x, y) - g:get(nx, ny) - (math.abs(x-nx) + math.abs(y-ny))
        if saved >= 100 then total2 = total2 + 1 end
    end
end
output.part1(total1)
output.part2(total2)