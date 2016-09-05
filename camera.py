from ray import Ray
from vector import Vector

class Camera:
    def __init__(self,
                 lowerLeftCorner = Vector(-2, -1, -1),
                 horizontal = Vector(4, 0, 0),
                 vertical = Vector(0, 2, 0),
                 origin = Vector(0, 0, 0)):
        self.lowerLeftCorner = lowerLeftCorner
        self.horizontal = horizontal
        self.vertical = vertical
        self.origin = origin

    def get_ray(self, u, v):
        return Ray(self.origin, self.lowerLeftCorner + (u * self.horizontal) + (v * self.vertical) - self.origin)
