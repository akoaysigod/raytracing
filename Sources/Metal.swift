#if !os(Linux)
import simd
#endif


final class Metal: Material {
  private let albedo: Vector
  private let fuzz: Double

  init(albedo: Vector, fuzz: Double = 1.0) {
    self.albedo = albedo
    self.fuzz = fuzz < 1.0 ? fuzz : 1.0
  }

  func scatter(ray: Ray, record: HitRecord) -> Scatter? {
    let reflected = reflect(v: ray.direction.unit, n: record.normal)
    let scattered = Ray(origin: record.p, direction: reflected + fuzz * randomInUnitSphere())

    if scattered.direction.dotp(record.normal) > 0.0 {
      return Scatter(attenuation: albedo, scattered: scattered)
    }
    return nil
  }
}
