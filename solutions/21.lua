local total1 = 0
local total2 = 0
local numkp = gridfromstring([[
789
456
123
 0A]])
local dirkp = gridfromstring([[
 ^A
<v>]])

pathfindkp = memoize(function(kp, s, e)
    local sx, sy, ex, ey = 0, 0, 0, 0
    if s == e then
        return "A"
    end
    for x, y, c in kp:loop() do
        if c == s then
            sx, sy = x, y
        end
        if c == e then
            ex, ey = x, y
        end
    end
    local dx, dy = ex-sx, ey-sy
    local xc = ">"
    if dx < 0 then
        xc = "<"
    end
    local yc = "v"
    if dy < 0 then
        yc = "^"
    end
    local xstr, ystr = xc:rep(math.abs(dx)), yc:rep(math.abs(dy))

    local xfirst = xstr..ystr.."A"
    local yfirst = ystr..xstr.."A"
    if kp:get(sx, ey) == " " then
        return xfirst
    elseif kp:get(ex, sy) == " " then
        return yfirst
    elseif dx < 0 then
        return xfirst
    else
        return yfirst
    end
end)
getlength = memoize(function(kp, str, num)
    if num == -1 then
        return #str
    end
    local sum = 0
    local prev = "A"
    for m in str:gmatch(".") do
        sum = sum + getlength(dirkp, pathfindkp(kp, prev, m), num-1)
        prev = m
    end
    return sum
end)
for line in input.lines() do
    total1 = total1 + getlength(numkp, line, 2) * tonumber(line:match("(%d+)"))
    total2 = total2 + getlength(numkp, line, 25) * tonumber(line:match("(%d+)"))
end
output.part1(total1)
output.part2(total2)