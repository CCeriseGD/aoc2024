local g = input.grid()

local total1 = 0
local word = {"X", "M", "A", "S"}
for x, y, v in g:loop() do
    if v == word[1] then
        for dx = -1, 1 do
            for dy = -1, 1 do
                for i = 1, #word - 1 do
                    local nx, ny = x + dx * i, y + dy * i
                    if g:get(nx, ny) ~= word[i+1] then
                        break
                    elseif i == #word - 1 then
                        total1 = total1 + 1
                    end
                end
            end
        end
    end
end

local total2 = 0
for x, y, v in g:loop(1, 1, g.w-1, g.h-1) do
    if g:get(x, y) == "A" then
        local c1, c2, c3, c4 = g:get(x-1, y-1), g:get(x+1, y+1), g:get(x+1, y-1), g:get(x-1, y+1)
        if  ((c1 == "M" and c2 == "S") or (c1 == "S" and c2 == "M"))
        and ((c3 == "M" and c4 == "S") or (c3 == "S" and c4 == "M")) then
            total2 = total2 + 1
        end
    end
end

output.part1(total1)
output.part2(total2)