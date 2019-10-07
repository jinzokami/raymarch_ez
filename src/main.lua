require("Vector")

function love.load()
    --make a grid of points the size of the image
    --define another point for the camera, this point should be further back from the others
    --the grid is at depth 0, the camera at depth < 0
    --the rays to be tested are the rays coming from the camera to each of the points on the grid
    --no need for tans or arctans, much easier to understand and less prone to error.
    --still need trig for specific fovs, but we'll deal with that later
end

function love.update()

end

function love.draw()

end