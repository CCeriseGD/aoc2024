require "utils"
function runday(n)
    input.file = "inputs/"..n
    local t1 = love.timer.getTime()
    require("solutions/"..n)
    local t2 = love.timer.getTime()
    local time = t2-t1
    local timestr = math.floor(time * 100) / 100 .. " s"
    if time < 1 then
        timestr = math.floor(time * 100000) / 100 .." ms"
    end
    print(string.format("finished in %s", timestr))
end
function love.load(args)
    runday(args[1])
end
love.event.quit()