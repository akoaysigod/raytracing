import Foundation

func +(lhs: Vector, rhs: Vector) -> Vector {
  return Vector(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z)
}

func -(lhs: Vector, rhs: Vector) -> Vector {
  return Vector(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z)
}

func *(lhs: Vector, rhs: Vector) -> Vector {
  return Vector(lhs.x * rhs.x, lhs.y * rhs.y, lhs.z * rhs.z)
}

func *(lhs: Double, rhs: Vector) -> Vector {
  return Vector(lhs * rhs.x, lhs * rhs.y, lhs * rhs.z)
}

func /(lhs: Vector, rhs: Vector) -> Vector {
  return Vector(lhs.x / rhs.x, lhs.y / rhs.y, lhs.z / rhs.z)
}

func /(lhs: Vector, rhs: Double) -> Vector {
  return Vector(lhs.x / rhs, lhs.y / rhs, lhs.z / rhs)
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
    return Vector(x / length, y / length, z / length)
  }

  var color: Color {
    return Color(r: Int(x), g: Int(y), b: Int(z))
  }

  init(_ x: Double = 0.0, _ y: Double = 0.0, _ z: Double = 0.0) {
    self.x = x
    self.y = y
    self.z = z
  }

  convenience init(array: [Double]) {
    assert(array.count >= 3, "Requires an array of at least size 3")
    self.init(array[0], array[1], array[2])
  }

  func dot(_ vec: Vector) -> Double {
    return zip(vec3, vec.vec3).map { $0.0 * $0.1 }.reduce(0.0, +)
  }

  func cross(_ vec: Vector) -> Vector {
    return Vector(
        self.y * vec.z - self.z * vec.y,
        -(self.x * vec.z - self.z * vec.x),
        self.x * vec.y - self.y * vec.x)
  }
}
