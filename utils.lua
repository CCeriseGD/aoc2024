input = {}
function input.lines()
    return love.filesystem.lines(input.file)
end
function input.match(pattern)
    return love.filesystem.read(input.file):match(pattern)
end
function input.linematch(pattern)
    local linesf, s, var = love.filesystem.lines(input.file)
    return function(s, var)
        local line = linesf(s, var)
        if line == nil then return end
        return line:match(pattern)
    end, s, var
end
function input.gmatch(pattern)
    return love.filesystem.read(input.file):gmatch(pattern)
end
function input.grid(charcallback)
    local g = grid()
    local x, y = 0, 0
    for line in input.lines() do
        y = y + 1
        x = 0
        for c in line:gmatch(".") do
            x = x + 1
            if charcallback then
                local v = charcallback(x, y, c)
                if v ~= nil then
                    g:set(x, y, v)
                else
                    g:set(x, y, c)
                end
            else
                g:set(x, y, c)
            end
        end
    end
    g:setsize(x, y)
    return g
end

function gridfromstring(s, charcallback)
    local g = grid()
    local x, y = 0, 0
    for line in s:gmatch("[^\n]+") do
        y = y + 1
        x = 0
        for c in line:gmatch(".") do
            x = x + 1
            if charcallback then
                local v = charcallback(x, y, c)
                if v ~= nil then
                    g:set(x, y, v)
                else
                    g:set(x, y, c)
                end
            else
                g:set(x, y, c)
            end
        end
    end
    g:setsize(x, y)
    return g
end

output = {}
function output.part1(n)
    print("part 1:", string.format("%d", n))
end
function output.part2(n)
    print("part 2:", string.format("%d", n))
end
function output.part1s(n)
    print("part 1:", n)
end
function output.part2s(n)
    print("part 2:", n)
end

function defaulttable(def)
    local t = {}
    setmetatable(t, {
        __index = function(key)
            return def
        end
    })
    return t
end

function grid(w, h, indef, outdef)
    local g = {
        setsize = function(self, w, h)
            self.w, self.h = w or self.w, h or self.h
        end,
        setdef = function(self, indef, outdef)
            self.indef, self.outdef = indef, outdef
        end,
        set = function(self, x, y, v)
            self[x] = self[x] or {}
            self[x][y] = v
        end,
        inside = function(self, x, y, minx, miny, maxx, maxy)
            return x >= (minx or 1) and y >= (miny or 1) and x <= (maxx or self.w) and y <= (maxy or self.h)
        end,
        get = function(self, x, y)
            if self[x] and self[x][y] ~= nil then
                return self[x][y]
            end
            if not self:inside(x, y) then
                return self.outdef
            end
            return self.indef
        end,
        loop = function(self, minx, miny, maxx, maxy)
            local minx, miny = minx or 1, miny or 1
            local s = {x = minx - 1, y = miny or 1}
            return function(s, var)
                s.x = s.x + 1
                if not self:inside(s.x, s.y, minx, miny, maxx, maxy) then
                    s.x = minx
                    s.y = s.y + 1
                    if not self:inside(s.x, s.y, minx, miny, maxx, maxy) then
                        return
                    end
                end
                return s.x, s.y, self:get(s.x, s.y)
            end, s
        end,
        print = function(self, charfunc)
            for y = 1, self.h do
                local line = ""
                for x = 1, self.w do
                    local c = self:get(x, y)
                    if charfunc then
                        c = charfunc(x, y, c) or c
                    end
                    line = line..c
                end
                print(line)
            end
        end
    }
    g.w, g.h, g.indef, g.outdef = w, h, indef, outdef
    return g
end