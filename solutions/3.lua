local total1, total2 = 0, 0
local enabled = true
for cmd, args in input.gmatch("([a-z']+)%(([0-9,]*)%)") do
    if cmd:match("do$") then
        enabled = true
    elseif cmd:match("don't$") then
        enabled = false
    elseif cmd:match("mul$") then
        local n1, n2 = args:match("^(%d+),(%d+)$")
        if n1 and n2 then
            local m = tonumber(n1) * tonumber(n2)
            total1 = total1 + m
            if enabled then
                total2 = total2 + m
            end
        end
    end
end
output.part1(total1)
output.part2(total2)