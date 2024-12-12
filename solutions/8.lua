local total1 = 0
local total2 = 0
local antennae = {}
local x, y = 1, 1
local foundnodes = input.grid(function(x, y, c)
    if c ~= "." then
        antennae[c] = antennae[c] or {}
        table.insert(antennae[c], {x, y})
    end
    return false
end)
for k, v in pairs(antennae) do
    for i, pos1 in ipairs(v) do
        for j, pos2 in ipairs(v) do
            if i ~= j then
                local dx, dy = pos2[1] - pos1[1], pos2[2] - pos1[2]
                local i = 0
                local di = 1
                while true do
                    local nx, ny = pos2[1] + dx * i, pos2[2] + dy * i
                    if foundnodes:inside(nx, ny) then
                        if not foundnodes:get(nx, ny) then
                            foundnodes:set(nx, ny, true)
                            total2 = total2 + 1
                        end
                        if i == 1 and foundnodes:get(nx, ny) ~= "part1" then
                            foundnodes:set(nx, ny, "part1")
                            total1 = total1 + 1
                        end
                    else
                        if di == 1 then
                            i = 0
                            di = -1
                        else
                            break
                        end
                    end
                    i = i + di
                end
            end
        end
    end
end
output.part1(total1)
output.part2(total2)