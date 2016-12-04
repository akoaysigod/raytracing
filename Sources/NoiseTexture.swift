#if os(macOS)
import simd
#endif

final class NoiseTexture: Texture {
  private let perlin = Perlin()

  func value(_ s: Double, _ t: Double, _ p: Vector) -> Vector {
    return perlin.noise(vec: p) * Vector(1, 1, 1)
  }
}
