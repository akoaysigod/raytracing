final class Camera {
  private let lowerLeftCorner: Vector
  private let horizontal: Vector
  private let vertical: Vector
  private let origin: Vector

  init(lowerLeftCorner: Vector = Vector(-2, -1, -1),
       horizontal: Vector = Vector(4, 0, 0),
       vertical: Vector = Vector(0, 2, 0),
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
