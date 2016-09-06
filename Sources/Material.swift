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
}
