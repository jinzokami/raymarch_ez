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