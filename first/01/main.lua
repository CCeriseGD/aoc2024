local list1, list2 = {}, {}
local list2count = {}
for line in love.filesystem.lines("input") do
    local id1, id2 = line:match("(%d+).-(%d+)")
    local id1, id2 = tonumber(id1), tonumber(id2)
    table.insert(list1, id1)
    table.insert(list2, id2)
    list2count[id2] = (list2count[id2] or 0) + 1
end
table.sort(list1)
table.sort(list2)
local totaldiff = 0
local similarity = 0
for i = 1, #list1 do
    local id1, id2 = list1[i], list2[i]
    totaldiff = totaldiff + math.abs(id1 - id2)
    similarity = similarity + (list2count[id1] or 0) * id1
end
print("part 1:", totaldiff)
print("part 2:", similarity)
