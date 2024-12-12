local total1 = 0
local total2 = 0
local g = input.grid()
local found = grid(g.w, g.h)
for x, y, v in g:loop() do
    if not found:get(x, y) then
        local plant = g:get(x, y)
        local possible = {{x, y}}
        found:set(x, y, plant)
        local area, perimeter, sides = 1, 0, 0
        local perims = grid(g.w, g.h,
            {top = false, bottom = false, left = false, right = false},
            {top = false, bottom = false, left = false, right = false})
        while #possible > 0 do
            local t = {}
            for j, v in ipairs(possible) do
                local nx, ny = v[1], v[2]
                perims:set(nx, ny, {top = false, bottom = false, left = false, right = false})
                if g:get(nx, ny-1) == plant then
                    if not found:get(nx, ny-1) then
                        table.insert(t, {nx, ny-1})
                        found:set(nx, ny-1, plant)
                        area = area + 1
                    end
                else
                    perimeter = perimeter + 1
                    perims:get(nx, ny).top = true
                end
                if g:get(nx, ny+1) == plant then
                    if not found:get(nx, ny+1) then
                        table.insert(t, {nx, ny+1})
                        found:set(nx, ny+1, plant)
                        area = area + 1
                    end
                else
                    perimeter = perimeter + 1
                    perims:get(nx, ny).bottom = true
                end
                if g:get(nx-1, ny) == plant then
                    if not found:get(nx-1, ny) then
                        table.insert(t, {nx-1, ny})
                        found:set(nx-1, ny, plant)
                        area = area + 1
                    end
                else
                    perimeter = perimeter + 1
                    perims:get(nx, ny).left = true
                end
                if g:get(nx+1, ny) == plant then
                    if not found:get(nx+1, ny) then
                        table.insert(t, {nx+1, ny})
                        found:set(nx+1, ny, plant)
                        area = area + 1
                    end
                else
                    perimeter = perimeter + 1
                    perims:get(nx, ny).right = true
                end
            end
            possible = t
        end
        for x, y, v in perims:loop() do
            local rightv = perims:get(x+1, y)
            local downv = perims:get(x, y+1)
            if v.top and not rightv.top then
                sides = sides + 1
            end
            if v.bottom and not rightv.bottom then
                sides = sides + 1
            end
            if v.left and not downv.left then
                sides = sides + 1
            end
            if v.right and not downv.right then
                sides = sides + 1
            end
        end
        total1 = total1 + area*perimeter
        total2 = total2 + area*sides
    end
end
output.part1(total1)
output.part2(total2)