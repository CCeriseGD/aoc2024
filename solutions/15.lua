local total1 = 0
local total2 = 0
local gstr, dirs = input.match("([#O%.@\n]+)([%^v<>\n]+)")
local botx, boty
local g = gridfromstring(gstr, function(x, y, c)
    if c == "@" then
        botx, boty = x, y
        return "."
    end
end)

for m in dirs:gmatch("[%^v<>]") do
    local mx, my = 0, 0
    if m == "^" then
        my = -1
    elseif m == "v" then
        my = 1
    elseif m == "<" then
        mx = -1
    elseif m == ">" then
        mx = 1
    end
    local c = g:get(botx + mx, boty + my)
    if c == "." then
        botx, boty = botx + mx, boty + my
    elseif c == "O" then
        for i = 2, math.max(g.w, g.h) do
            local c = g:get(botx + mx * i, boty + my * i)
            if c == "." then
                g:set(botx + mx, boty + my, ".")
                g:set(botx + mx * i, boty + my * i, "O")
                botx, boty = botx + mx, boty + my
                break
            elseif c == "#" then
                break
            end
        end
    end
end

for x, y, c in g:loop() do
    if c == "O" then
        total1 = total1 + x-1 + (y-1)*100
    end
end
output.part1(total1)

local beeg = {}
beeg["#"] = "##"
beeg["O"] = "[]"
beeg["."] = ".."
beeg["@"] = "@."
g = gridfromstring(gstr:gsub("[^\n]", beeg), function(x, y, c)
    if c == "@" then
        botx, boty = x, y
        return "."
    end
end)

for m in dirs:gmatch("[%^v<>]") do
    local mx, my = 0, 0
    if m == "^" then
        my = -1
    elseif m == "v" then
        my = 1
    elseif m == "<" then
        mx = -1
    elseif m == ">" then
        mx = 1
    end
    local c = g:get(botx + mx, boty + my)
    if c == "." then
        botx, boty = botx + mx, boty + my
    elseif c == "[" or c == "]" then
        local found = grid(g.w, g.h)
        found:set(botx + mx, boty+my, "O")
        local nextmove = {{botx + mx, boty + my}}
        local x2 = botx + mx
        if c == "]" then
            x2 = x2 - 1
        else
            x2 = x2 + 1
        end
        table.insert(nextmove, {x2, boty + my})
        found:set(x2, boty+my, "O")
        local canpush = true
        while #nextmove > 0 do
            local x, y = nextmove[1][1], nextmove[1][2]
            table.remove(nextmove, 1)
            local nx, ny = x + mx, y + my
            if found:get(nx, ny) ~= "O" then
                local c = g:get(nx, ny)
                if c == "#" then
                    canpush = false
                    break
                elseif c == "[" or c == "]" then
                    found:set(nx, ny, "O")
                    table.insert(nextmove, {nx, ny})
                    local x2 = nx - 1
                    if c == "[" then
                        x2 = nx + 1
                    end
                    if not found:get(x2, ny) then
                        found:set(x2, ny, "O")
                        table.insert(nextmove, {x2, ny})
                    end
                end
            end
        end
        if canpush then
            local sx, sy, ex, ey, dx, dy = 1, 1, g.w, g.h, 1, 1
            if mx == 1 then
                sx, ex, dx = ex, sx, -1
            elseif my == 1 then
                sy, ey, dy = ey, sy, -1
            end
            for x = sx, ex, dx do
                for y = sy, ey, dy do
                    if found:get(x, y) == "O" then
                        g:set(x + mx, y + my, g:get(x, y))
                        g:set(x, y, ".")
                    end
                end
            end
            botx, boty = botx + mx, boty + my
        end
    end
end

for x, y, c in g:loop() do
    if c == "[" then
        total2 = total2 + x-1 + (y-1)*100
    end
end
output.part2(total2)