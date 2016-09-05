from vector import Vector

class Ray:
    def __init__(self, a = Vector(), b = Vector()):
        self.a = a
        self.b = b

    @property
    def origin(self):
        return self.a

    @property
    def direction(self):
        return self.b

    def point_at_parameter(self, t):
        return self.a + (t * self.b)
