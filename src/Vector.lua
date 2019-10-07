local Vector = {}
Vector.__index = Vector

function Vector.__call(x, y, z)
    return Vector.new(x, y, z)
end

function Vector.new(x, y, z)
    local self = setmetatable({}, Vector)

    self.x = (x or 0)
    self.y = (y or 0)
    self.z = (z or 0)

    return self
end

function Vector.__add(lhs, rhs)
    return lhs:add(rhs)
end

function Vector.__sub(lhs, rhs)
    return lhs:sub(rhs)
end

function Vector.__mul(lhs, rhs)
    return lhs:mul(rhs)
end

function Vector:add(vec)
    return Vector(self.x + vec.x, self.y + vec.y, self.z + vec.z)
end

function Vector:sub(vec)
    return Vector(self.x - vec.x, self.y - vec.y, self.z - vec.z)
end

function Vector:mul(scal)
    return Vector(self.x * scal, self.y * scal, self.z*scal)
end

function Vector:magnitude()
    return math.sqrt(self.x*self.x + self.y*self.y + self.z*self.z)
end

function Vector:normalized()
    local mag = self:magnitude()
    if mag == 0 then return Vector() end
    return Vector(self.x/mag, self.y/mag, self.z/mag)
end

function Vector:dot(vec)
    return self.x*vec.x + self.y*vec.y + self.z*vec.z
end

function Vector:cross(vec)
    return Vector(self.y * vec.z - self.z * vec.y, self.z * vec.x - self.x * vec.z, self.x * vec.y - self.y * vec.x)
end