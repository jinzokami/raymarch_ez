if not EPSILON then
    EPSILON = 0.0001
end

function sphere_sdf(point, radius)
    return point:magnitude() - radius
end

function box_sdf(point, box)
    local dist = point:abs() - box
    return dist:max(0):magnitude() + math.min(math.max(dist.x, math.max(dist.y, dist.z)), 0) 
end

function rounded_box_sdf(point, box, radius)
    local dist = point:abs() - box
    return dist:max(0):magnitude() - r + math.min(math.max(dist.x, math.max(dist.y, dist.z)), 0)
end

function torus(point, torus)
    local pxz = Vector:new(point.x, point.z, 0);
    local q = Vector:new(pxz:magnitude() - torus.x, point.y, 0);
    return q:magnitude() - torus.y;
end

--sc is a vec2 leave z 0
function capped_torus(point, torus, radiusa, radiusb)
    local pxy = Vector:new(point.x, point.y, 0)
    local px = math.abs(point.x)
    local k = 0
        
    if torus.y*point.x > torus.x*point.y then
        k = pxy:dot(torus)
    else
        k = (pxy):magnitude()
    end

    return math.sqrt(point:dot(point) + radiusa*radiusa - 2.0*radiusa*k) - radiusb
end

local power = 8
function mandelbulb_sdf(position)
    local z = position:clone()
    local dr = 1
    local r = 0

    for i = 1, 16, 1 do
        r = z:magnitude()
        if r > 2 then
            break
        end

        local theta = math.acos(z.z / r) * power
        local phi = math.atan2(z.y, z.x) * power
        local zr = math.pow(r, power)
        dr = math.pow(r, power - 1) * power * dr + 1

        z = zr * Vector:new(math.sin(theta) * math.cos(phi), math.sin(phi)*sin(theta), math.cos(theta))
        z = z + position
    end
    return 0.5 * math.log(r) * r / dr
end