from hitable_list import HitableList
from ray import Ray
from sphere import Sphere
from vector import Vector

def gen_file(nx, ny):
    with open('test.ppm', 'w+') as f:
        f.write('P3\n%s %s\n255\n' % (nx, ny))

        for c in colors(nx, ny):
            f.write('%s %s %s\n' % (c[0], c[1], c[2]))

def hit_sphere(center, radius, ray):
    oc = ray.origin - center
    a = ray.direction.dot(ray.direction)
    b = 2.0 * oc.dot(ray.direction)
    c = oc.dot(oc) - radius * radius
    discrim = b * b - 4 * a * c

    if discrim < 0:
        return -1.0
    return (-b - discrim ** 0.5) / (2.0 * a)

def color_gradient(ray):
    t = hit_sphere(Vector(0, 0, -1), 0.5, ray)
    if t > 0.0:
        n = (ray.point_at_parameter(t) - Vector(0, 0, -1)).unit
        return 0.5 * Vector(1.0 + n.x, 1.0 + n.y, 1.0 + n.z)
    unit = ray.direction.unit
    t = 0.5 * (1.0 + unit.y)
    return (1.0 - t) * Vector(1.0, 1.0, 1.0) + t * Vector(0.5, 0.7, 1.0)

def color(ray, world):
    record = world.hit(ray)
    if record:
        return 0.5 * Vector(1.0 + record.normal.x, 1.0 + record.normal.y, 1.0 + record.normal.z)
    unit = ray.direction.unit
    t = 0.5 * (1.0 + unit.y)
    return (1.0 - t) * Vector(1, 1, 1) + t * Vector(0.5, 0.7, 1.0)

def colors(nx, ny):
    llc = Vector(-2.0, -1.0, -1.0)
    hor = Vector(4.0, 0.0, 0.0)
    ver = Vector(0.0, 2.0, 0.0)
    org = Vector()

    spheres = [Sphere(Vector(0, 0, -1), 0.5), Sphere(Vector(0, -100.5, -1), 100)]
    world = HitableList(spheres)

    for j in xrange(ny - 1, 0, -1):
        for i in xrange(nx):
            u = i / float(nx)
            v = j / float(ny)

            ray = Ray(org, llc + (u * hor) + (v * ver))

            vec = color(ray, world)
            ir = int(255 * vec.x)
            ig = int(255 * vec.y)
            ib = int(255 * vec.z)

            yield (ir, ig, ib)

if __name__ == '__main__':
    gen_file(200, 100)
