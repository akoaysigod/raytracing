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

func ==(lhs: Vector, rhs: Vector) -> Bool {
  return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
}

struct Vector {
  let x: Double
  let y: Double
  let z: Double

  var vec3: [Double] {
    return [x, y, z]
  }

  var length: Double {
    return sqrt(x * x + y * y + z * z)
  }

  var unit: Vector {
    let l = length
    return Vector(x / l, y / l, z / l)
  }

  var color: Color {
    return Color(r: Int(x), g: Int(y), b: Int(z))
  }

  init(_ x: Double = 0.0, _ y: Double = 0.0, _ z: Double = 0.0) {
    self.x = x
    self.y = y
    self.z = z
  }

  init(array: [Double]) {
    assert(array.count >= 3, "Requires an array of at least size 3")
    self.init(array[0], array[1], array[2])
  }

  func dot(_ vec: Vector) -> Double {
    return x * vec.x + y * y * vec.y + z * vec.z
  }

  func cross(_ vec: Vector) -> Vector {
    return Vector(
        self.y * vec.z - self.z * vec.y,
        -(self.x * vec.z - self.z * vec.x),
        self.x * vec.y - self.y * vec.x)
  }
}
