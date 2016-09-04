from hitable import Hitable
from hitable import HitRecord
from vector import Vector

class Sphere(Hitable):
    def __init__(self, center = Vector(), radius = 0.0):
        self.center = center
        self.radius = float(radius)

    def hit(self, ray, tMin = 0.0, tMax = float("inf")):
        oc = ray.origin - self.center
        a = ray.direction.dot(ray.direction)
        b = oc.dot(ray.direction)
        c = oc.dot(oc) - (self.radius * self.radius)
        discrim = (b * b) - (a * c)

        if discrim > 0.0:
            temp = (-b - (b * b - a * c) ** 0.5) / a
            if tMin < temp < tMax:
                t = temp
                p = ray.point_at_parameter(t)
                normal = (p - self.center) / Vector(self.radius, self.radius, self.radius)
                return HitRecord(t, p, normal)

            temp = (-b + (b * b - a * c) ** 0.5) / a
            if tMin < temp < tMax:
                t = temp
                p = ray.point_at_parameter(t)
                normal = (p - self.center) / Vector(self.radius, self.radius, self.radius)
                return HitRecord(t, p, normal)
        return None
