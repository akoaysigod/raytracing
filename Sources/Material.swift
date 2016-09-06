import Darwin

struct Scatter {
  let attenuation: Vector
  let scattered: Ray
}

protocol Material {
  func scatter(ray: Ray, record: HitRecord) -> Scatter?
}

extension Material {
  func randomInUnitSphere() -> Vector {
    let vec = 2.0 * Vector(drand48(), drand48(), drand48()) - Vector(1, 1, 1)
    if vec.dot(vec) >= 1.0 {
      return randomInUnitSphere()
    }
    return vec
  }

  func reflect(v: Vector, n: Vector) -> Vector {
    return v - 2 * v.dot(n) * n
  }

  func refract(v: Vector, n: Vector, nint: Double) -> Vector? {
    let dt = v.unit.dot(n)
    let discrim = 1.0 - nint * nint * (1.0 - dt * dt)
    if discrim > 0.0 {
      return nint * (v - dt * n) - (sqrt(discrim) * n)
    }
    return nil
  }

  func schlick(cosine: Double, refIdx: Double) -> Double {
    let r0 = (1 - refIdx) / (1 + refIdx)
    let r02 = r0 * r0
    return r02 + (1 - r02) * pow(1 - cosine, 5)
  }
}
