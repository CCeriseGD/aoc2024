local total1
local total2
local stones = {}
for m in love.filesystem.read("input"):gmatch("%d+") do
    local n = tonumber(m)
    stones[n] = (stones[n] or 0) + 1
end

function blink(stones)
    local t = {}
    local total = 0
    for n, amt in pairs(stones) do
        total = total + amt
        local s = tostring(n)
        if n == 0 then
            t[1] = (t[1] or 0) + amt
        elseif #s % 2 == 0 then
            local p1 = tonumber(s:sub(1, #s/2))
            local p2 = tonumber(s:sub(#s/2+1, -1))
            t[p1] = (t[p1] or 0) + amt
            t[p2] = (t[p2] or 0) + amt
            total = total + amt
        else
            local new = n*2024
            t[new] = (t[new] or 0) + amt
        end
    end
    return t, total
end

for i = 1, 25 do
    stones, total1 = blink(stones)
end
for i = 1, 50 do
    stones, total2 = blink(stones)
end
print("part 1:", string.format("%d", total1))
print("part 2:", string.format("%d", total2))