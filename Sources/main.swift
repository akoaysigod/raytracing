import Foundation

let nx = 200 //width
let ny = 100 //height
let ns = 100 //anti aliasing

func main() {
  let sph1 = Sphere(center: Vector(0, 0, -1), radius: 0.5, material: Lambertian(albedo: Vector(0.8, 0.3, 0.3)))
  let sph2 = Sphere(center: Vector(0, -100.5, -1), radius: 100, material: Lambertian(albedo: Vector(0.8, 0.8, 0.0)))
  let sph3 = Sphere(center: Vector(1, 0, -1), radius: 0.5, material: Metal(albedo: Vector(0.8, 0.6, 0.2), fuzz: 0.3))
  let sph4 = Sphere(center: Vector(-1, 0, -1), radius: 0.5, material: Dielectric(refractiveIndex: 1.5))
  let sph5 = Sphere(center: Vector(-1, 0, -1), radius: -0.45, material: Dielectric(refractiveIndex: 1.5))
  let world = HitableList(list: [sph1, sph2, sph3, sph4, sph5])
  let camera = Camera()

  let colorFunc = ColorDeterminer(world: world, camera: camera).materialColor
  let colors = ImageGenerator(nx: nx, ny: ny, ns: ns, world: world, camera: camera, colorFunc: colorFunc)

  let header = "P3\n\(nx) \(ny)\n255\n"
  print(header)
  colors.forEach { (rgb) in
    print("\(rgb.r) \(rgb.g) \(rgb.b)\n")
  }
//  let write = colors.reduce(header) { (ret, rgb) -> String in
//    ret + "\(rgb.r) \(rgb.g) \(rgb.b)\n"
//  }
  print(write)
}

main()
