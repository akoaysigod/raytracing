import Foundation

final class CheckerTexture: Texture {
  private let even: Texture
  private let odd: Texture

  init(even: Texture, odd: Texture) {
    self.even = even
    self.odd = odd
  }

  func value(_ s: Double, _ t: Double, _ p: Vector) -> Vector {
    if sin(10 * p.x) * sin(10 * p.y) * sin(10 * p.z) < 0 {
      return odd.value(s, t, p)
    }
    return even.value(s, t, p)
  }
}
