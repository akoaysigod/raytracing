import Foundation

final class Perlin {
  private let randomDoubles: [Double]
  private let xPerms: [Int]
  private let yPerms: [Int]
  private let zPerms: [Int]

  init() {
    randomDoubles = Perlin.generateRandomDoubles()
    xPerms = Perlin.generatePermutations()
    yPerms = Perlin.generatePermutations()
    zPerms = Perlin.generatePermutations()
  }

  func noise(vec: Vector) -> Double {
    let u = vec.x - floor(vec.x)
    let v = vec.y - floor(vec.y)
    let z = vec.z - floor(vec.z)
    let i = Int(4 * vec.x) & 255
    let j = Int(4 * vec.y) & 255
    let k = Int(4 * vec.z) & 255
    return randomDoubles[xPerms[i] ^ yPerms[j] ^ zPerms[k]]
  }

  private static func generateRandomDoubles() -> [Double] {
    return (0..<256).map { _ in drand48() }
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
