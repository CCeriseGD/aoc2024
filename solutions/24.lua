local wires = {}
local waiting = {}
local allgates = {}
local wiretypes = {}
for line in input.lines() do
    local wire, init = line:match("(...): ([01])")
    if wire then
        wires[wire] = init == "1"
    elseif #line > 0 then
        local w1, gate, w2, out = line:match("(...) ([A-Z]+) (...) %-> (...)")
        table.insert(waiting, {w1, gate, w2, out})
        table.insert(allgates, {w1, gate, w2, out})
    end
end

local gates = {
    AND = function(x, y)
        return x and y
    end,
    OR = function(x, y)
        return x or y
    end,
    XOR = function(x, y)
        return (x or y) and not (x and y)
    end
}

local total1 = 0
while #waiting > 0 do
    local t = {}
    for i, v in ipairs(waiting) do
        local w1, gate, w2, out = unpack(v)
        if wires[w1] ~= nil and wires[w2] ~= nil then
            wires[out] = gates[gate](wires[w1], wires[w2])
            local num = out:match("^z(%d%d)$")
            if num and wires[out] then
                total1 = total1 + 2^tonumber(num)
            end

            if not w1:match("^[xy](%d%d)$") then
                if gate == "XOR" or gate == "AND" then
                    wiretypes[w1] = "tmpsum/carry"
                    wiretypes[w2] = "tmpsum/carry"
                else
                    wiretypes[w1] = "tmpcarry"
                    wiretypes[w2] = "tmpcarry"
                end
            end
        else
            table.insert(t, {w1, gate, w2, out})
        end
    end
    waiting = t
end
output.part1(total1)

local wrong = {}
for i, v in ipairs(allgates) do
    local w1, gate, w2, out = unpack(v)
    if w1 == "x00" or w1 == "y00" then
        if (gate == "XOR" and wiretypes[out])
        or (gate == "AND" and wiretypes[out] ~= "tmpsum/carry") then
            table.insert(wrong, out)
        end
    else
        if (not wiretypes[w1] and gate == "XOR" and wiretypes[out] ~= "tmpsum/carry")
        or (not wiretypes[w1] and gate == "AND" and wiretypes[out] ~= "tmpcarry")
        or (wiretypes[w1] == "tmpsum/carry" and gate == "XOR" and wiretypes[out])
        or (wiretypes[w1] == "tmpsum/carry" and gate == "AND" and wiretypes[out] ~= "tmpcarry")
        or (wiretypes[w1] == "tmpcarry" and gate == "OR" and wiretypes[out] ~= "tmpsum/carry" and out ~= "z45") then
            table.insert(wrong, out)
        end
    end
end
assert(#wrong == 8, "oops")
table.sort(wrong)
output.part2s(table.concat(wrong, ","))