final class Metal: Material {
  private let albedo: Vector
  init(albedo: Vector) {
    self.albedo = albedo
  }

  func scatter(ray: Ray, record: HitRecord) -> Scatter? {
    let reflected = reflect(v: ray.direction.unit, n: record.normal)
    let scattered = Ray(a: record.p, b: reflected)

    if scattered.direction.dot(record.normal) > 0.0 {
      return Scatter(attenuation: albedo, scattered: scattered)
    }
    return nil
  }
}
