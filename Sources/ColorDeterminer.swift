import Darwin

typealias ColorFunc = (Ray, HitableList) -> Vector

final class ColorDeterminer {
  private let world: HitableList
  private let camera: Camera

  init(world: HitableList, camera: Camera) {
    self.world = world
    self.camera = camera
  }
}
//normal colors
extension ColorDeterminer {
  func normalColor(ray: Ray, world: HitableList) -> Vector {
    if let record = world.hit(ray: ray) {
      return 0.5 * Vector(x: 1.0 + record.normal.x, y: 1.0 + record.normal.y, z: 1.0 + record.normal.z)
    }
    let t = 0.5 * (1.0 + ray.direction.unit.y)
    return (1.0 - t) * Vector(x: 1, y: 1, z: 1) + t * Vector(x: 0.5, y: 0.7, z: 1.0)
  }
}

//diffuse chapter 7
extension ColorDeterminer {
  private func randomInUnitSphere() -> Vector {
    let vec = 2.0 * Vector(x: drand48(), y: drand48(), z: drand48()) - Vector(x: 1, y: 1, z: 1)
    if vec.dot(vec) >= 1.0 {
      return randomInUnitSphere()
    }
    return vec
  }

  func diffuseColor(ray: Ray, world: HitableList) -> Vector {
    if let record = world.hit(ray: ray) {
      let t = record.p + record.normal + randomInUnitSphere()
      return 0.5 * diffuseColor(ray: Ray(a: record.p, b: t - record.p), world: world)
    }
    let t = 0.5 * (1.0 + ray.direction.unit.y)
    return (1.0 - t) * Vector(x: 1, y: 1, z: 1) + t * Vector(x: 0.5, y: 0.7, z: 1.0)
  }
}
