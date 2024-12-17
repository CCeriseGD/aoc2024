local bit = require "bit"
local program = {}
local rega, regb, regc, code = input.match("Register A: (%d+)\nRegister B: (%d+)\nRegister C: (%d+)\n\nProgram: ([0-7,]+)")
for n in code:gmatch("%d+") do
    table.insert(program, tonumber(n))
end
function run(program, rega, regb, regc)
    local out = {}
    local pointer = 0
    local rega, regb, regc = rega or 0, regb or 0, regc or 0
    function combo(op)
        if op <= 3 then return op
        elseif op == 4 then return rega
        elseif op == 5 then return regb
        elseif op == 6 then return regc
        else error() end
    end
    while true do
        local opcode = program[pointer+1]
        if not opcode then
            break
        end
        local arg = program[pointer+2]
        pointer = pointer + 2

        if opcode == 0 then --adv
            rega = math.floor(rega / 2^combo(arg))
        elseif opcode == 6 then --bdv
            regb = math.floor(rega / 2^combo(arg))
        elseif opcode == 7 then --cdv
            regc = math.floor(rega / 2^combo(arg))
        elseif opcode == 1 then --bxl
            regb = bit.bxor(regb, arg)
        elseif opcode == 4 then --bxc
            regb = bit.bxor(regb, regc)
        elseif opcode == 2 then --bst
            regb = combo(arg) % 8
        elseif opcode == 3 then --jnz
            pointer = rega == 0 and pointer or arg
        elseif opcode == 5 then --out
            table.insert(out, combo(arg) % 8)
        end
    end
    return out
end
output.part1s(table.concat(run(program, rega, regb, regc), ","))

local pos = {}
for i = 0, 8^3-1 do
    local res = run(program, i)
    if res[1] == program[1] then
        table.insert(pos, i)
    end
end
for p = 2, #program do
    local t = {}
    for i, v in ipairs(pos) do
        for j = 0, 7 do
            local rega = v + j * 8^(p+1)
            local res = run(program, rega)
            if res[p] == program[p] then
                table.insert(t, rega)
                if table.concat(res, ",") == code then
                    output.part2(rega)
                    return
                end
            end
        end
    end
    pos = t
end