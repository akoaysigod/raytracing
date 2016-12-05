#if os(macOS)
import simd
#endif

final class NoiseTexture: Texture {
  private let perlin = Perlin()
  private let scale: Double

  init(scale: Double = 0.1) {
    self.scale = scale
  }

  func value(_ s: Double, _ t: Double, _ p: Vector) -> Vector {
    return perlin.noise(vec: scale * p) * Vector(1, 1, 1)
  }
}
