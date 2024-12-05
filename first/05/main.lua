local total1, total2 = 0, 0
local rules = {}
function iscorrect(t)
    local correct = true
    local foundlist = {}
    for i, v in ipairs(t) do
        local swap
        for j = 1, #foundlist do
            if rules[v] and rules[v][foundlist[j]] then
                correct = false
                swap = j
                break
            end
        end
        if swap then
            table.insert(foundlist, foundlist[swap])
            foundlist[swap] = v
        else
            table.insert(foundlist, v)
        end
    end
    return correct, foundlist
end
for line in love.filesystem.lines("input") do
    if line:match("|") then
        local n1, n2 = line:match("(%d+)|(%d+)")
        rules[n1] = rules[n1] or {}
        rules[n1][n2] = true
    elseif #line > 0 then
        local foundlist = {}
        local correct
        for m in line:gmatch("%d+") do
            table.insert(foundlist, m)
        end
        correct, foundlist = iscorrect(foundlist)
        if correct then
            local middle = (#foundlist + 1)/2
            total1 = total1 + foundlist[middle]
        else
            while not correct do
                correct, foundlist = iscorrect(foundlist)
            end
            local middle = (#foundlist + 1)/2
            total2 = total2 + foundlist[middle]
        end
    end
end

print("part 1:", total1)
print("part 2:", total2)