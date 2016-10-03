import Foundation
#if !os(Linux)
import simd
#endif

final class Sphere: Hitable {
  private let center: Vector
  private let radius: Double
  private let material: Material

  init(center: Vector = Vector(), radius: Double = 0.0, material: Material) {
    self.center = center
    self.radius = radius
    self.material = material
  }

  private func hitRecord(_ t: Double, ray: Ray) -> HitRecord {
    let p = ray.pointAtParameter(t)
    let normal = (p - center) / radius
    return HitRecord(t: t, p: p, normal: normal, material: material)
  }

  func hit(ray: Ray, tMin: Double = 0.0, tMax: Double = Double.infinity) -> HitRecord? {
    let oc = ray.origin - center
    let a = ray.direction.dotp(ray.direction)
    let b = oc.dotp(ray.direction)
    let c = oc.dotp(oc) - (radius * radius)
    let discrim = (b * b) - (a * c)

    if discrim > 0.0 {
      let sqr = sqrt(discrim)
      let tmpOne = (-b - sqr) / a
      if tmpOne < tMax && tmpOne > tMin {
        return hitRecord(tmpOne, ray: ray)
      }

      let tmpTwo = (-b + sqr) / a
      if tmpTwo < tMax && tmpTwo > tMin {
        return hitRecord(tmpTwo, ray: ray)
      }
    }
    return nil
  }
}
