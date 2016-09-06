import Darwin

final class ImageGenerator: Sequence {
  fileprivate let nx: Int
  fileprivate let ny: Int
  fileprivate let ns: Int
  fileprivate let world: HitableList
  fileprivate let camera: Camera
  fileprivate let colorFunc: ColorFunc

  init(nx: Int, ny: Int, ns: Int, world: HitableList, camera: Camera, colorFunc: ColorFunc) {
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

  init(imageGenerator: ImageGenerator) {
    self.imageGenerator = imageGenerator

    i = 0
    j = imageGenerator.ny
  }

  mutating func next() -> Color? {
    guard j > 0 else { return nil }

    if i >= imageGenerator.nx {
      i = 0
      j -= 1
    }

    let vector = (0..<imageGenerator.ns).reduce(Vector()) { (vector, _) -> Vector in
      let u = (Double(i) + drand48()) / Double(imageGenerator.nx)
      let v = (Double(j) + drand48()) / Double(imageGenerator.ny)
      let ray = imageGenerator.camera.getRay(u: u, v: v)
      return vector + imageGenerator.colorFunc(ray, imageGenerator.world, 0)
    }

    let avg = vector / Double(imageGenerator.ns)
    let gammaCorrection = Vector(array: avg.vec3.map { sqrt($0) })
    let color = 255.0 * gammaCorrection

    i += 1

    return color.color
  }
}
