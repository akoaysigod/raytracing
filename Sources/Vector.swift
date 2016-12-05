#if !os(Linux)
import simd

typealias Vector = double3

extension Vector {
  var lengthp: Double {
    return length(self)
  }

  func dotp(_ v: Vector) -> Double {
    return dot(self, v)
 }

 func crossp(_ v: Vector) -> Vector {
   return cross(self, v)
 }
}
#endif

func ==(lhs: Vector, rhs: Vector) -> Bool {
  return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
}

extension Vector {
  init(array: [Double]) {
    assert(array.count == 3, "Requires an array of size 3")
    self.init(array[0], array[1], array[2])
  }

  var color: Color {
    return Color(r: Int(x), g: Int(y), b: Int(z))
  }

  var vec3: [Double] {
    return [x, y, z]
  }

  var unit: Vector {
    let l = lengthp
    return Vector(x / l, y / l, z / l)
  }
}

func /(lhs: Vector, rhs: Double) -> Vector {
  return Vector(lhs.x / rhs, lhs.y / rhs, lhs.z / rhs)
}

#if os(Linux)

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

struct Vector {
  let x: Double
  let y: Double
  let z: Double

  var lengthp: Double {
    return sqrt(x * x + y * y + z * z)
  }

  init(_ x: Double = 0.0, _ y: Double = 0.0, _ z: Double = 0.0) {
    self.x = x
    self.y = y
    self.z = z
  }

  func dotp(_ vec: Vector) -> Double {
    return x * vec.x + y * vec.y + z * vec.z
  }

  func crossp(_ vec: Vector) -> Vector {
    return Vector(
        self.y * vec.z - self.z * vec.y,
        -(self.x * vec.z - self.z * vec.x),
        self.x * vec.y - self.y * vec.x)
  }
}
#endif
