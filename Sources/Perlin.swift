import Foundation

final class Perlin {
  private let randomVectors: [Vector]
  private let xPerms: [Int]
  private let yPerms: [Int]
  private let zPerms: [Int]

  init() {
    randomVectors = Perlin.generateRandomVectors()
    xPerms = Perlin.generatePermutations()
    yPerms = Perlin.generatePermutations()
    zPerms = Perlin.generatePermutations()
  }

  func trilinearInterpolation(randVectors: [[[Vector]]], u: Double, v: Double, w: Double) -> Double {
    func hermiteCubic(_ x: Double) -> Double {
      return x * x * (3.0 - 2.0 * x)
    }

    let uu = hermiteCubic(u)
    let vv = hermiteCubic(v)
    let ww = hermiteCubic(w)

    return (0..<2).reduce(0.0) { (ret, i) in
      return (0..<2).reduce(ret) { (ret1, j) in
        return (0..<2).reduce(ret1) { (ret2, k) in
          let weight = Vector(u - Double(i), v - Double(j), w - Double(k))
          let a = Double(i) * uu + Double(1 - i) * (1.0 - uu)
          let b = Double(j) * vv + Double(1 - j) * (1.0 - vv)
          let c = Double(k) * ww + Double(1 - k) * (1.0 - ww)
          return ret2 + a * b * c * randVectors[i][j][k].dotp(weight)
        }
      }
    }
  }

  func noise(vec: Vector) -> Double {
    let i = Int(vec.x)
    let j = Int(vec.y)
    let k = Int(vec.z)

    let randVectors = (0..<2).map { (di) -> [[Vector]] in
      return (0..<2).map { dj in
        return (0..<2).map { dk in
          let x = xPerms[(i + di) & 255]
          let y = yPerms[(j + dj) & 255]
          let z = zPerms[(k + dk) & 255]
          return randomVectors[x ^ y ^ z]
        }
      }
    }

    let u = vec.x - floor(vec.x)
    let v = vec.y - floor(vec.y)
    let w = vec.z - floor(vec.z)
    return trilinearInterpolation(randVectors: randVectors, u: u, v: v, w: w)
  }

  private static func generateRandomVectors() -> [Vector] {
    return (0..<256).map { _ in
      let arr = (0..<3).map { _ in -1.0 + 2.0 * drand48() }
      return Vector(array: arr).unit
    }
  }

  private static func generatePermutations() -> [Int] {
    var table = (0..<256).map { $0 }
    for i in stride(from: table.count - 1, through: 0, by: -1) {
      let target = Int(drand48() * Double(i + 1))
      let tmp = table[i]
      table[i] = table[target]
      table[target] = tmp
    }
    return table
  }
}
