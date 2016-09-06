import Foundation

let path = "/Users/tony/tmp/RayTracingWeekend/test.ppm"

let nx = 200 //width
let ny = 100 //height
let ns = 100 //anti aliasing

func main() {
  let sphereOne = Sphere(center: Vector(x: 0, y: 0, z: -1), radius: 0.5)
  let sphereTwo = Sphere(center: Vector(x: 0, y: -100.5, z: -1), radius: 100)
  let world = HitableList(list: [sphereOne, sphereTwo])
  let camera = Camera()

  let colorFunc = ColorDeterminer(world: world, camera: camera).diffuseColor
  let colors = ImageGenerator(nx: nx, ny: ny, ns: ns, world: world, camera: camera, colorFunc: colorFunc)

  let header = "P3\n\(nx) \(ny)\n255\n"
  let write = colors.reduce(header) { (ret, rgb) -> String in
    ret + "\(rgb.r) \(rgb.g) \(rgb.b)\n"
  }
  try! write.write(toFile: path, atomically: true, encoding: .utf8)
}

main()
