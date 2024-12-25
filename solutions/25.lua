local keys = {}
local locks = {}
local pins
local iskey
for line in input.lines() do
    if not pins then
        if line == "....." then
            pins = {0, 0, 0, 0, 0}
            iskey = true
        else
            pins = {-1, -1, -1, -1, -1}
            iskey = false
        end
    elseif #line > 0 then
        local i = 0
        for m in line:gmatch(".") do
            i = i + 1
            if m == "#" then
                pins[i] = pins[i] + 1
            end
        end
    else
        table.insert(iskey and keys or locks, pins)
        pins = nil
    end
end
if pins then
    table.insert(iskey and keys or locks, pins)
end

local total1 = 0
for _, key in ipairs(keys) do
    for _, lock in ipairs(locks) do
        local canfit = true
        for i = 1, 5 do
            if lock[i] + key[i] > 5 then
                canfit = false
                break
            end
        end
        if canfit then
            total1 = total1 + 1
        end
    end
end

output.part1(total1)