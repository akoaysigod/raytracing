import Darwin

final class Dielectric: Material {
  private let refractiveIndex: Double

  init(refractiveIndex: Double) {
    self.refractiveIndex = refractiveIndex
  }

  func scatter(ray: Ray, record: HitRecord) -> Scatter? {
    let reflected = reflect(v: ray.direction, n: record.normal)
    let attenuation = Vector(1, 1, 1)

    let (outwardNormal, nint, cosine) = { _ -> (Vector, Double, Double) in
      if ray.direction.dot(record.normal) > 0 {
        let cosine = refractiveIndex * ray.direction.dot(record.normal) / ray.direction.length
        return (-1 * record.normal, refractiveIndex, cosine)
      }
      let cosine = -ray.direction.dot(record.normal) / ray.direction.length
      return (record.normal, 1.0 / refractiveIndex, cosine)
    }()

    let refracted = refract(v: ray.direction, n: outwardNormal, nint: nint)

    let probability = { _ -> Double in
      if refracted != nil {
        return schlick(cosine: cosine, refIdx: refractiveIndex)
      }
      return 1.0
    }()

    let scattered: Ray = { _ -> Ray in
      if let refracted = refracted, drand48() > probability {
        return Ray(a: record.p, b: refracted)
      }
      return Ray(a: record.p, b: reflected)
    }()

    return Scatter(attenuation: attenuation, scattered: scattered)
  }
}
