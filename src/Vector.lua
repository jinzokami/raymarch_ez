local Vector = {}
Vector.__index = Vector

function Vector:new(x, y, z)
    local self = setmetatable({}, Vector)

    self.x = (x or 0)
    self.y = (y or 0)
    self.z = (z or 0)

    return self
end

function Vector:clone()
    return Vector:new(self.x, self.y, self.z)
end

function Vector.__add(lhs, rhs)
    return lhs:add(rhs)
end

function Vector.__sub(lhs, rhs)
    return lhs:sub(rhs)
end

function Vector.__mul(lhs, rhs)
    if type(lhs) == "number" then
        return rhs:mul(lhs)
    elseif type(rhs) == "number" then
        return lhs:mul(rhs)
    end
    return nil --maybe at some point this'll have a definition (maybe geometric product), but for now, muling 2 vectors makes nil
end

function Vector:add(vec)
    return Vector:new(self.x + vec.x, self.y + vec.y, self.z + vec.z)
end

function Vector:sub(vec)
    return Vector:new(self.x - vec.x, self.y - vec.y, self.z - vec.z)
end

function Vector:mul(scal)
    return Vector:new(self.x * scal, self.y * scal, self.z*scal)
end

function Vector:magnitude()
    return math.sqrt(self.x*self.x + self.y*self.y + self.z*self.z)
end

function Vector:normalized()
    local mag = self:magnitude()
    if mag == 0 then return Vector:new() end
    return Vector:new(self.x/mag, self.y/mag, self.z/mag)
end

function Vector:dot(vec)
    return self.x*vec.x + self.y*vec.y + self.z*vec.z
end

function Vector:cross(vec)
    return Vector:new(self.y * vec.z - self.z * vec.y, self.z * vec.x - self.x * vec.z, self.x * vec.y - self.y * vec.x)
end

function Vector:abs()
    return Vector:new(math.abs(self.x), math.abs(self.y), math.abs(self.z))
end

function Vector:max(a)
    return Vector:new(math.max(self.x, a), math.max(self.y, a), math.max(self.z, a))
end

function Vector:min(a)
    return Vector:new(math.min(self.x, a), math.min(self.y, a), math.min(self.z, a))
end

return Vector