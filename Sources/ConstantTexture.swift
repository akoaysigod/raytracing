final class ConstantTexture: Texture {
  private let color: Vector 

  init(color: Vector) {
    self.color = color
  }

  func value(_ s: Double, _ t: Double, _ p: Vector) -> Vector {
    return color
  }
}
