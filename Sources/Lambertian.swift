import simd

final class Lambertian: Material {
  private let albedo: Vector

  init(albedo: Vector) {
    self.albedo = albedo
  }

  func scatter(ray: Ray, record: HitRecord) -> Scatter? {
    let target = record.p + record.normal + randomInUnitSphere()
    let scattered = Ray(origin: record.p, direction: target - record.p)
    return Scatter(attenuation: albedo, scattered: scattered)
  }
}
