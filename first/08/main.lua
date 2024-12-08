local total1 = 0
local total2 = 0
local antennae = {}
local x, y = 1, 1
for line in love.filesystem.lines("input") do
    x = 1
    for m in line:gmatch(".") do
        if m ~= "." then
            antennae[m] = antennae[m] or {}
            table.insert(antennae[m], {x, y})
        end
        x = x + 1
    end
    y = y + 1
end
local mx, my = x - 1, y - 1
local foundnodes = {}
for k, v in pairs(antennae) do
    for i, pos1 in ipairs(v) do
        for j, pos2 in ipairs(v) do
            if i ~= j then
                local dx, dy = pos2[1] - pos1[1], pos2[2] - pos1[2]
                local i = 0
                local di = 1
                while true do
                    local nx, ny = pos2[1] + dx * i, pos2[2] + dy * i
                    if nx >= 1 and ny >= 1 and nx <= mx and ny <= my then
                        if not (foundnodes[nx] and foundnodes[nx][ny]) then
                            foundnodes[nx] = foundnodes[nx] or {}
                            foundnodes[nx][ny] = true
                            total2 = total2 + 1
                        end
                        if i == 1 and not (foundnodes[nx] and foundnodes[nx][ny] == "part1") then
                            foundnodes[nx] = foundnodes[nx] or {}
                            foundnodes[nx][ny] = "part1"
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
print("part 1:", string.format("%d", total1))
print("part 2:", string.format("%d", total2))



