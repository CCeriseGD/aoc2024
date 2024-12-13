local total1 = 0
local total2 = 0
function getcost(ax, ay, bx, by, px, py)
    local b = (ay*px - ax*py) / (ay*bx - ax*by)
    local a = (px - bx*b) / ax
    if b % 1 == 0 and a % 1 == 0 then
        return a * 3 + b
    end
    return 0
end
for ax, ay, bx, by, px, py in input.gmatch("Button A: X%+(%d+), Y%+(%d+)\nButton B: X%+(%d+), Y%+(%d+)\nPrize: X=(%d+), Y=(%d+)") do
    local ax, ay, bx, by, px, py = tonumber(ax), tonumber(ay), tonumber(bx), tonumber(by), tonumber(px), tonumber(py)
    total1 = total1 + getcost(ax, ay, bx, by, px, py)
    total2 = total2 + getcost(ax, ay, bx, by, px + 10000000000000, py + 10000000000000)
end

output.part1(total1)
output.part2(total2)