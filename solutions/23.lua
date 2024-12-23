local conns = {}
local connsfrom = {}
for c1, c2 in input.linematch("(..)%-(..)") do
    conns[c1] = conns[c1] or {}
    conns[c1][c2] = true
    conns[c2] = conns[c2] or {}
    conns[c2][c1] = true
    connsfrom[c1] = connsfrom[c1] or {}
    table.insert(connsfrom[c1], c2)
    connsfrom[c2] = connsfrom[c2] or {}
    table.insert(connsfrom[c2], c1)
end

local sets = {}
for cn, c in pairs(connsfrom) do
    local pos = {}
    for i, v in ipairs(c) do
        for j, w in ipairs(c) do
            if i ~= j and conns[v][w] then
                table.insert(pos, {cn, v, w})
            end
        end
    end
    for i, v in ipairs(pos) do
        table.sort(v)
        local s = table.concat(v, ",")
        sets[s] = true
    end
end

local total1 = 0
for k, v in pairs(sets) do
    if k:match("t[a-z]") then
        total1 = total1 + 1
    end
end
output.part1(total1)

while true do
    local t = {}
    local foundany = false
    for set, _ in pairs(sets) do
        local first, others = set:match("(..),(.+)")
        for i, c in ipairs(connsfrom[first]) do
            local jointoset = true
            local sett = {first, c}
            for m in others:gmatch("[^,]+") do
                if not conns[m][c] then
                    jointoset = false
                    break
                end
                table.insert(sett, m)
            end
            if jointoset then
                table.sort(sett)
                local s = table.concat(sett, ",")
                t[s] = true
                foundany = true
            end
        end
    end
    if foundany then
        sets = t
    else
        for k, v in pairs(sets) do
            output.part2s(k)
        end
        break
    end
end