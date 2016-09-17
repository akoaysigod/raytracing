#if !os(Linux)
import simd
#endif

final class Lambertian: Material {
  private let albedo: Texture

  init(albedo: Texture) {
    self.albedo = albedo
  }

  func scatter(ray: Ray, record: HitRecord) -> Scatter? {
    let target = record.p + record.normal + randomInUnitSphere()
    let scattered = Ray(origin: record.p, direction: target - record.p)
    let attenuation = alebdo.value(0, 0, record.p)
    return Scatter(attenuation: attenuation, scattered: scattered)
  }
}
