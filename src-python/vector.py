class Vector:
    def __init__(self, x = 0.0, y = 0.0, z = 0.0):
        self.x = float(x)
        self.y = float(y)
        self.z = float(z)

    @property
    def vec3(self):
        return [self.x, self.y, self.z]

    @property
    def unit(self):
        l = self.lengthp()
        return Vector(
            x = self.x / l,
            y = self.y / l,
            z = self.z / l
        )

    def __add__(self, vec):
        return Vector(self.x + vec.x, self.y + vec.y, self.z + vec.z)

    def __sub__(self, vec):
        return Vector(self.x - vec.x, self.y - vec.y, self.z - vec.z)

    def __mul__(self, vec):
        return Vector(self.x * vec.x, self.y * vec.y, self.z * vec.z)

    def __rmul__(self, s):
        vec = [s * x for x in self.vec3]
        return Vector(vec[0], vec[1], vec[2])

    def __div__(self, vec):
        return self.__truediv__(vec)

    def __truediv__(self, vec):
        return Vector(self.x / vec.x, self.y / vec.y, self.z / vec.z)

    def dotp(self, vec):
        z = zip(self.vec3, vec.vec3)
        r = (x * y for x, y in z)
        return sum(r)

    def crossp(self, vec):
        return Vector(
            x = self.y * vec.z - self.z * vec.y,
            y = -(self.x * vec.z - self.z * vec.x),
            z = self.x * vec.y - self.y * vec.x
        )

    def lengthp(self):
        return sum(x ** 2 for x in self.vec3) ** 0.5
