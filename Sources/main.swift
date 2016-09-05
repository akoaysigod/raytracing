import Foundation

let path = "/Users/tony/tmp/RayTracingWeekend/test.ppm"

func color(ray: Ray, world: HitableList) -> Vector {
  if let record = world.hit(ray: ray) {
    return 0.5 * Vector(x: 1.0 + record.normal.x, y: 1.0 + record.normal.y, z: 1.0 + record.normal.z)
  }
  let t = 0.5 * (1.0 + ray.direction.unit.y)
  return (1.0 - t) * Vector(x: 1, y: 1, z: 1) + t * Vector(x: 0.5, y: 0.7, z: 1.0)
}

func colors(nx: Int, ny: Int, ns: Int) -> [(r: Int, g: Int, b: Int)] {
  let sphereOne = Sphere(center: Vector(x: 0, y: 0, z: -1), radius: 0.5)
  let sphereTwo = Sphere(center: Vector(x: 0, y: -100.5, z: -1), radius: 100)
  let world = HitableList(list: [sphereOne, sphereTwo])
  let camera = Camera()

  var ret: [(r: Int, g: Int, b: Int)] = []
  stride(from: ny, to: 0, by: -1).forEach { j in
    (0..<nx).forEach { i in
      var vector = (0..<ns).reduce(Vector()) { (vector, _) -> Vector in
        let u = (Double(i) + drand48()) / Double(nx)
        let v = (Double(j) + drand48()) / Double(ny)
        let ray = camera.getRay(u: u, v: v)
        return vector + color(ray: ray, world: world)
      }
      vector = vector / Double(ns)
      vector = 255.0 * vector

      ret += [(r: Int(vector.x), g: Int(vector.y), b: Int(vector.z))]
    }
  }
  return ret
}


func main(nx: Int, ny: Int, ns: Int) {
  var write = "P3\n\(nx) \(ny)\n255\n"
  colors(nx: nx, ny: ny, ns: ns).forEach { rgb in
    write += "\(rgb.r) \(rgb.g) \(rgb.b)\n"
  }
  try! write.write(toFile: path, atomically: true, encoding: .utf8)
}

main(nx: 200, ny: 100, ns: 100)
