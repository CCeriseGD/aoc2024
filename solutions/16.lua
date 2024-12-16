local open = {}
local sx, sy
local goalx, goaly
local g = input.grid(function(x, y, c)
    if c == "." then
        return {}
    elseif c == "S" then
        table.insert(open, {x, y, 1, 0, 0})
        sx, sy = x, y
        return {}
    elseif c == "E" then
        goalx, goaly = x, y
        return {}
    end
end)
local path = grid(g.w, g.h)
while #open > 0 do
    local x, y, dx, dy, score = unpack(open[1])
    table.remove(open, 1)
    local points = {
        {x + dx, y + dy, dx, dy, score + 1},
        {x, y, dx == 0 and 1 or 0, dy == 0 and 1 or 0, score + 1000},
        {x, y, dx == 0 and -1 or 0, dy == 0 and -1 or 0, score + 1000}
    }
    for i, v in ipairs(points) do
        local px, py, pdx, pdy, ps = unpack(v)
        local p = g:get(px, py)
        if p ~= "#" then
            local idx = pdx*2 + pdy
            if not p[idx] or p[idx] > ps then
                p[idx] = ps
                table.insert(open, {px, py, pdx, pdy, ps})
                if not path:get(px, py) then
                    path:set(px, py, {})
                end
                path:get(px, py)[idx] = {}
            end
            if p[idx] == ps then
                table.insert(path:get(px, py)[idx], {x, y, dx*2+dy})
            end
        end
    end
end
local goal = g:get(goalx, goaly)
local min = math.min(goal[-2], goal[-1], goal[1], goal[2])
output.part1(min)
open = {}
for i, idx in ipairs({-2, -1, 1, 2}) do
    if goal[idx] == min then
        table.insert(open, {goalx, goaly, idx})
    end
end
local pg = grid(g.w, g.h)
pg:set(goalx, goaly, true)
local total2 = 1
while #open > 0 do
    local x, y, idx = unpack(open[1])
    print(x, y)
    table.remove(open, 1)
    for i, v in ipairs(path:get(x, y)[idx]) do
        local px, py, pidx = unpack(v)
        if not pg:get(px, py) then
            total2 = total2 + 1
            pg:set(px, py, true)
        end
        if not (px == sx and py == sy and idx == 2) then
            table.insert(open, {px, py, pidx})
        end
    end
end
output.part2(total2)