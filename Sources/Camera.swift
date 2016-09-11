import Foundation
import simd

final class Camera {
  private let lowerLeftCorner: Vector
  private let horizontal: Vector
  private let vertical: Vector
  private let origin: Vector
  private let w: Vector
  private let u: Vector
  private let v: Vector
  private let lensRadius: Double

  init(origin: Vector,
       lookAt: Vector,
       vup: Vector,
       fov: Double,
       aspect: Double,
       aperture: Double,
       focusDistance: Double) {
    let theta = fov * (M_PI / 180.0)
    let halfHeight = tan(theta / 2.0)
    let halfWidth = aspect * halfHeight

    self.origin = origin 
    lensRadius = aperture / 2.0

    w = (origin - lookAt).unit
    u = vup.crossp(w).unit
    v = w.crossp(u)

    lowerLeftCorner = origin - halfWidth * focusDistance * u - halfHeight * focusDistance * v - focusDistance * w

    horizontal = 2 * halfWidth * focusDistance * u
    vertical = 2 * halfHeight * focusDistance * v
  }

  private func randomInUnitDisk() -> Vector {
    let vec = 2.0 * Vector(drand48(), drand48(), 0) - Vector(1, 1, 0)
    if vec.dotp(vec) >= 1.0 {
      return randomInUnitDisk()
    }
    return vec
  }

  func getRay(s: Double, t: Double) -> Ray {
    let rd = lensRadius * randomInUnitDisk()
    let offset = rd.x * u + rd.y * v
    return Ray(origin: origin + offset,
               direction: lowerLeftCorner + (s * horizontal) + (t * vertical) - origin - offset)
  }
}
