import Darwin

func +(lhs: Vector, rhs: Vector) -> Vector {
  return Vector(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
}

func -(lhs: Vector, rhs: Vector) -> Vector {
  return Vector(x: lhs.x - rhs.x, y: lhs.y - rhs.y, z: lhs.z - rhs.z)
}

func *(lhs: Vector, rhs: Vector) -> Vector {
  return Vector(x: lhs.x * rhs.x, y: lhs.y * rhs.y, z: lhs.z * rhs.z)
}

func *(lhs: Double, rhs: Vector) -> Vector {
  return Vector(x: lhs * rhs.x, y: lhs * rhs.y, z: lhs * rhs.z)
}

func /(lhs: Vector, rhs: Vector) -> Vector {
  return Vector(x: lhs.x / rhs.x, y: lhs.y / rhs.y, z: lhs.z / rhs.z)
}

func /(lhs: Vector, rhs: Double) -> Vector {
  return Vector(x: lhs.x / rhs, y: lhs.y / rhs, z: lhs.z / rhs)
}

final class Vector {
  let x: Double
  let y: Double
  let z: Double

  var vec3: [Double] {
    return [x, y, z]
  }

  var length: Double {
    let s = vec3.map { $0 * $0 }.reduce(0.0, +)
    return sqrt(s)
  }

  var unit: Vector {
    return Vector(
        x: x / length,
        y: y / length,
        z: z / length
             )
  }

  init(x: Double = 0.0, y: Double = 0.0, z: Double = 0.0) {
    self.x = x
    self.y = y
    self.z = z
  }

  func dot(_ vec: Vector) -> Double {
    return zip(vec3, vec.vec3).map { $0.0 * $0.1 }.reduce(0.0, +)
  }

  func cross(_ vec: Vector) -> Vector {
    return Vector(
        x: self.y * vec.z - self.z * vec.y,
        y: -(self.x * vec.z - self.z * vec.x),
        z: self.x * vec.y - self.y * vec.x
             )
  }
}
