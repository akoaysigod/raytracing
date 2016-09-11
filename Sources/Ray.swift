import simd

final class Ray {
  let origin: Vector
  let direction: Vector

  init(origin: Vector = Vector(), direction: Vector = Vector()) {
    self.origin = origin
    self.direction = direction 
  }

  func pointAtParameter(_ t: Double) -> Vector {
    return origin + (t * direction)
  }
}
