import Foundation
#if !os(Linux)
import simd
#endif

final class ImageGenerator: Sequence {
  fileprivate let nPartition: Int
  fileprivate let tPartition: Int
  fileprivate let nx: Int
  fileprivate let ny: Int
  fileprivate let ns: Int
  fileprivate let world: HitableList
  fileprivate let camera: Camera
  fileprivate let colorFunc: ColorFunc

  init(nPartition: Int, tPartition: Int, nx: Int, ny: Int, ns: Int, world: HitableList, camera: Camera, colorFunc: @escaping ColorFunc) {
    self.nPartition = nPartition
    self.tPartition = tPartition
    self.nx = nx
    self.ny = ny
    self.ns = ns
    self.world = world
    self.camera = camera
    self.colorFunc = colorFunc
  }

  func makeIterator() -> ColorIterator {
    return ColorIterator(imageGenerator: self)
  }
}

struct ColorIterator: IteratorProtocol {
  let imageGenerator: ImageGenerator

  private var i: Int
  private var j: Int
  private let end: Int

  init(imageGenerator: ImageGenerator) {
    self.imageGenerator = imageGenerator

    let start = imageGenerator.ny / imageGenerator.tPartition

    i = 0
    j = imageGenerator.ny - (start * (imageGenerator.nPartition - 1))
    end = imageGenerator.ny - (start * imageGenerator.nPartition)
  }

  mutating func next() -> Color? {
    guard j > end else { return nil }

    if i >= imageGenerator.nx {
      i = 0
      j -= 1
    }

    let vector = (0..<imageGenerator.ns).reduce(Vector()) { (vector, _) -> Vector in
      let u = (Double(i) + drand48()) / Double(imageGenerator.nx)
      let v = (Double(j) + drand48()) / Double(imageGenerator.ny)
      let ray = imageGenerator.camera.getRay(s: u, t: v)
      return vector + imageGenerator.colorFunc(ray, imageGenerator.world, 0)
    }

    let avg = vector / Double(imageGenerator.ns)
    let gammaCorrection = Vector(array: avg.vec3.map { sqrt($0) } )
    let color = 255.0 * gammaCorrection

    i += 1

    return color.color
  }
}
