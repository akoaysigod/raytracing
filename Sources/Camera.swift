final class Camera {
  let lowerLeftCorner: Vector
  let horizontal: Vector
  let vertical: Vector
  let origin: Vector

  init(lowerLeftCorner: Vector = Vector(x: -2, y: -1, z: -1),
       horizontal: Vector = Vector(x: 4, y: 0, z: 0),
       vertical: Vector = Vector(x: 0, y: 2, z: 0),
       origin: Vector = Vector()) {
    self.lowerLeftCorner = lowerLeftCorner
    self.horizontal = horizontal
    self.vertical = vertical
    self.origin = origin
  }

  func getRay(u: Double, v: Double) -> Ray {
    return Ray(a: origin, b: lowerLeftCorner + (u * horizontal) + (v * vertical) - origin)
  }
}
