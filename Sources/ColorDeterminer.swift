import Foundation
#if !os(Linux)
import simd
#endif

typealias ColorFunc = (Ray, HitableList, Int) -> Vector

final class ColorDeterminer {
  private let world: HitableList
  private let camera: Camera

  init(world: HitableList, camera: Camera) {
    self.world = world
    self.camera = camera
  }

  fileprivate func background(direction: Double) -> Vector {
    let t = 0.5 * (1.0 + direction)
    return (1.0 - t) * Vector(1, 1, 1) + t * Vector(0.5, 0.7, 1.0)
  }
}

//normal colors
extension ColorDeterminer {
  func normalColor(ray: Ray, world: HitableList, depth: Int = 0) -> Vector {
    if let record = world.hit(ray: ray) {
      return 0.5 * Vector(1.0 + record.normal.x, 1.0 + record.normal.y, 1.0 + record.normal.z)
    }
    return background(direction: ray.direction.unit.y)
  }
}

//diffuse chapter 7
extension ColorDeterminer {
  func diffuseColor(ray: Ray, world: HitableList, depth: Int = 0) -> Vector {
    if let record = world.hit(ray: ray) {
      let t = record.p + record.normal + record.material.randomInUnitSphere()
      return 0.5 * diffuseColor(ray: Ray(origin: record.p, direction: t - record.p), world: world)
    }
    return background(direction: ray.direction.unit.y)
  }
}

//materials
extension ColorDeterminer {
  func materialColor(ray: Ray, world: HitableList, depth: Int) -> Vector {
    if let record = world.hit(ray: ray) {
      if let scatter = record.material.scatter(ray: ray, record: record), depth < 50 {
        return scatter.attenuation * materialColor(ray: scatter.scattered, world: world, depth: depth + 1)
      }
      return Vector()
    }
//    if let record = world.hit(ray: ray),
//       let scatter = record.material.scatter(ray: ray, record: record),
//       depth < 50 {
//      return scatter.attenuation * materialColor(ray: scatter.scattered, world: world, depth: depth + 1)
//    }
    return self.background(direction: ray.direction.unit.y)
  }
}
