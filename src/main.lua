MIN_DEPTH = 0
MAX_DEPTH = 1000
EPSILON = 0.0001

Vector = require("Vector")
require("SDF")

function love.load()
    --make a grid of points the size of the image
    --define another point for the camera, this point should be further back from the others
    --the grid is at depth 0, the camera at depth < 0
    --the rays to be tested are the rays coming from the camera to each of the points on the grid
    --no need for tans or arctans, much easier to understand and less prone to error.
    --still need trig for specific fovs, but we'll deal with that later
    camera = Vector:new(0, 0, -256)
    rays = {}
    width = 256
    height = 256
    for y = 1, height, 1 do
        rays[y] = {}
        for x = 1, width, 1 do
            local point = Vector:new(x-width/2, y-height/2, 0)
            rays[y][x] = (point - camera):normalized()
        end
    end

    pixels = {}
    eye = camera:clone()
    for y = 1, 256, 1 do
        pixels[y] = {}
        for x = 1, 256, 1 do
            local depth = shortest_distance(eye, rays[y][x], MIN_DEPTH, MAX_DEPTH)
            if depth > MAX_DEPTH - EPSILON then
                pixels[y][x] = {0, 0, 255}
            else
                pixels[y][x] = {255, 0, 0}
            end
        end
    end

    canvas = love.graphics.newCanvas(width, height)
    canvas:renderTo(function() 
        for y = 1, #pixels, 1 do
            for x = 1, #pixels[1], 1 do
                love.graphics.setColor(pixels[y][x][1]/255, pixels[y][x][2]/255, pixels[y][x][3]/255)
                love.graphics.points(x, y)
            end
        end
    end)
end

function love.draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(canvas)
end

function shortest_distance(eye, direction, rstart, rend)
    local depth = rstart
    for i = 1, 256, 1 do

        dist = sdf_scene(eye + (depth*direction))

        if dist < EPSILON then
            return depth
        end

        depth = depth + dist

        if depth >= rend then
            return rend
        end
    end
    return rend
end

function sdf_scene(ray)
    return torus(ray, Vector:new(100, 10, 0))
end