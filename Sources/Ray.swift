final class Ray {
  let a: Vector
  let b: Vector

  var origin: Vector {
    return a
  }

  var direction: Vector {
    return b
  }

  init(a: Vector = Vector(), b: Vector = Vector()) {
    self.a = a
    self.b = b
  }

  func pointAtParameter(_ t: Double) -> Vector {
    return a + (t * b)
  }
}
