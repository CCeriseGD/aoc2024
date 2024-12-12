local list1, list2 = {}, {}
local list2count = defaulttable(0)
for id1, id2 in input.linematch("(%d+).-(%d+)") do
    local id1, id2 = tonumber(id1), tonumber(id2)
    table.insert(list1, id1)
    table.insert(list2, id2)
    list2count[id2] = list2count[id2] + 1
end
table.sort(list1)
table.sort(list2)
local totaldiff = 0
local similarity = 0
for i = 1, #list1 do
    local id1, id2 = list1[i], list2[i]
    totaldiff = totaldiff + math.abs(id1 - id2)
    similarity = similarity + list2count[id1] * id1
end
output.part1(totaldiff)
output.part2(similarity)