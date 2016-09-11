import Foundation

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
    //let a = ray.direction.dot(ray.direction)
    let aT = ray.direction.length
    let a = aT * aT
    let b = oc.dot(ray.direction)
    let cT = oc.direction.length
    let c = cT * cT - (radius * radius)
    let discrim = (b * b) - (a * c)

    if discrim > 0.0 {
      let tempOne = (-b - sqrt(b * b - a * c)) / a
      if tempOne < tMax && tempOne > tMin {
        return hitRecord(tempOne, ray: ray)
      }

      let tempTwo = (-b + sqrt(b * b - a * c)) / a
      if tempTwo < tMax && tempTwo > tMin {
        return hitRecord(tempTwo, ray: ray)
      }
    }
    return nil
  }
}
