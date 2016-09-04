class HitRecord:
    def __init__(self, t, p, normal):
        self.t = t
        self.p = p
        self.normal = normal

class Hitable:
    def hit(self, ray, tMin, tMax):
        pass
