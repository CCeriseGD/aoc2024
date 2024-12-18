local s = 70
local g = grid(s+1, s+1, nil, "#")
local count = 0
function getadj(g, x, y)
    local t = {}
    for i, v in ipairs({{x, y-1}, {x, y+1}, {x-1, y}, {x+1, y}}) do
        if not g:get(v[1], v[2]) then
            table.insert(t, v)
        end
    end
    return t
end
function heuristic(g, x, y, ex, ey)
    return math.abs(ex - x) + math.abs(ey - y)
end
local pathgrid = grid(g.w, g.h)
for x, y in input.linematch("(%d+),(%d+)") do
    g:set(tonumber(x)+1, tonumber(y)+1, "#")
    count = count + 1
    if count == 1024 then
        local d, path = g:pathfind(1, 1, s+1, s+1, getadj, heuristic, true)
        output.part1(d)
        for i, v in ipairs(path) do
            pathgrid:set(v[1], v[2], true)
        end
    elseif count > 1024 then
        if pathgrid:get(tonumber(x)+1, tonumber(y)+1) then
            d, path = g:pathfind(1, 1, s+1, s+1, getadj, heuristic, true)
            if not d then
                output.part2s(x..","..y)
                break
            else
                pathgrid = grid(g.w, g.h)
                for i, v in ipairs(path) do
                    pathgrid:set(v[1], v[2], true)
                end
            end
        end
    end
end