local total1 = 0
local total2 = 0
local filesystem1, filesystem2 = {}, {}
local lens = {}
local id = 0
local isfile = true
for len in input.gmatch("[^\n]") do
    local len = tonumber(len)
    local v
    if isfile then
        v = id
        lens[id] = len
        id = id + 1
    else
        v = false
    end
    for i = 1, len do
        table.insert(filesystem1, v)
        table.insert(filesystem2, v)
    end
    isfile = not isfile
end
local i = 0
while i < #filesystem1 do
    i = i + 1
    if not filesystem1[i] then
        while not filesystem1[#filesystem1] do
            filesystem1[#filesystem1] = nil
        end
        filesystem1[i] = filesystem1[#filesystem1]
        filesystem1[#filesystem1] = nil
    end
    total1 = total1 + (i-1) * filesystem1[i]
end
for i = #lens, 0, -1 do
    local len = lens[i]
    local emptylen = 0
    local emptypos
    for j = 1, #filesystem2 do
        if filesystem2[j] == i then
            emptypos = #filesystem2
            emptylen = 0
            break
        end
        if not filesystem2[j] then
            if emptylen == 0 then
                emptypos = j
            end
            emptylen = emptylen + 1
        else
            emptylen = 0
        end
        if emptylen >= len then
            break
        end
    end
    for j = emptypos + emptylen, #filesystem2 do
        if filesystem2[j] == i then
            filesystem2[j] = false
        end
    end
    for j = 1, emptylen do
        filesystem2[emptypos + j - 1] = i
    end
end
for i = 1, #filesystem2 do
    total2 = total2 + (i-1) * (filesystem2[i] or 0)
end
output.part1(total1)
output.part2(total2)