local robots = {}
local w, h = 101, 103
for x, y, vx, vy in input.linematch("p=(%d+),(%d+) v=(%-?%d+),(%-?%d+)") do
    table.insert(robots, {x=tonumber(x), y=tonumber(y), vx=tonumber(vx), vy=tonumber(vy)})
end
function step(robots)
    local densityx, densityy = defaulttable(0), defaulttable(0)
    for i, bot in ipairs(robots) do
        bot.x, bot.y = (bot.x + bot.vx) % w, (bot.y + bot.vy) % h
        densityx[bot.x] = densityx[bot.x] + 1
        densityy[bot.y] = densityy[bot.y] + 1
    end
    local maxx, maxy = 1, 1
    for i = 1, math.max(w, h) do
        maxx, maxy = math.max(maxx, densityx[i]), math.max(maxy, densityy[i])
    end
    return maxx, maxy
end
function view(robots, f)
    local data = love.image.newImageData(w, h)
    for i, bot in ipairs(robots) do
        data:setPixel(bot.x, bot.y, 1, 1, 1)
    end
    love.filesystem.write(f, data:encode("png"):getString())
end
local axt, axd, ayt, ayd = 0, 0, 0, 0
for i = 1, 100 do
    local maxx, maxy = step(robots)
    if maxx > axd then
        axt, axd = i, maxx
    end
    if maxy > ayd then
        ayt, ayd = i, maxy
    end
end
local mx, my = (w-1)/2, (h-1)/2
local quadrants = {0, 0, 0, 0}
for i, bot in ipairs(robots) do
    local q = 1
    if bot.x ~= mx and bot.y ~= my then
        if bot.x > mx then
            q = q + 1
        end
        if bot.y > my then
            q = q + 2
        end
        quadrants[q] = quadrants[q] + 1
    end
end
output.part1(quadrants[1] * quadrants[2] * quadrants[3] * quadrants[4])
for i = 101, math.max(w, h) do
    local maxx, maxy = step(robots)
    if maxx > axd then
        axt, axd = i, maxx
    end
    if maxy > ayd then
        ayt, ayd = i, maxy
    end
end
for i = 1, w*h do
    if (i - axt) % w == 0 and (i - ayt) % h == 0 then
        output.part2(i)
        break
    end
end