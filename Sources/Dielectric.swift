import Foundation
import simd

final class Dielectric: Material {
  private let refractiveIndex: Double

  init(refractiveIndex: Double) {
    self.refractiveIndex = refractiveIndex
  }

  func scatter(ray: Ray, record: HitRecord) -> Scatter? {
    let (outwardNormal, nint, cosine) = { _ -> (Vector, Double, Double) in
      if ray.direction.dotp(record.normal) > 0 {
        let cosine = refractiveIndex * (ray.direction.dotp(record.normal) / ray.direction.lengthp)
        return (-1 * record.normal, refractiveIndex, cosine)
      }
      let cosine = -ray.direction.dotp(record.normal) / ray.direction.lengthp
      return (record.normal, 1.0 / refractiveIndex, cosine)
    }()

    let refracted = refract(v: ray.direction, n: outwardNormal, nint: nint)
    let probability = schlick(cosine: cosine, refIdx: refractiveIndex)
    let scattered: Ray = { _ -> Ray in
      if let refracted = refracted, drand48() > probability {
        return Ray(origin: record.p, direction: refracted)
      }
      let reflected = reflect(v: ray.direction, n: record.normal)
      return Ray(origin: record.p, direction: reflected)
    }()

    return Scatter(attenuation: Vector(1, 1, 1), scattered: scattered)
  }
}
