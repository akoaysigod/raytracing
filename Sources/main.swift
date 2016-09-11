import Foundation
#if os(Linux)
import simd
#endif

let nx = 1200 //width
let ny = 800 //height
let ns = 10 //anti aliasing

func generateScene() -> HitableList {
  let staticSpheres = [
    Sphere(center: Vector(0, -1000, 0), radius: 1000, material: Lambertian(albedo: Vector(0.5, 0.5, 0.5))),
    Sphere(center: Vector(0, 1, 0), radius: 1, material: Dielectric(refractiveIndex: 1.5)),
    Sphere(center: Vector(-4, 1, 0), radius: 1, material: Lambertian(albedo: Vector(0.4, 0.2, 0.1))),
    Sphere(center: Vector(4, 1, 0), radius: 1, material: Metal(albedo: Vector(0.7, 0.6, 0.5), fuzz: 0.0))
  ]

  let spheres = (-11..<11).reduce(staticSpheres) { (spheres, a) -> [Sphere] in
    let randomSpheres = (-11..<11).map { b -> Sphere? in
      let chooseMat = drand48()
      let center = Vector(Double(a) + 0.9 * drand48(), 0.2, Double(b) + 0.9 * drand48())
      if (center - Vector(4, 0.2, 0)).lengthp > 0.9 {
        if chooseMat < 0.8 {
          return Sphere(center: center, radius: 0.2, material: Lambertian(albedo: Vector(drand48(), drand48(), drand48())))
        }
        else if chooseMat < 0.95 {
          return Sphere(center: center,
                        radius: 0.2,
                        material: Metal(albedo: Vector(0.5 * (1 + drand48()), 0.5 * (1 + drand48()), 0.5 * (1 + drand48())), fuzz: 0.5 * drand48()))
        }
        return Sphere(center: center, radius: 0.2, material: Dielectric(refractiveIndex: 1.5))
      }
      return nil
    }
    return spheres + randomSpheres.flatMap { $0 }
  }
  return HitableList(list: spheres)
}

func main() {
//  let sph1 = Sphere(center: Vector(0, 0, -1), radius: 0.5, material: Lambertian(albedo: Vector(0.8, 0.3, 0.3)))
//  let sph2 = Sphere(center: Vector(0, -100.5, -1), radius: 100, material: Lambertian(albedo: Vector(0.8, 0.8, 0.0)))
//  let sph3 = Sphere(center: Vector(1, 0, -1), radius: 0.5, material: Metal(albedo: Vector(0.8, 0.6, 0.2), fuzz: 0.3))
//  let sph4 = Sphere(center: Vector(-1, 0, -1), radius: 0.5, material: Dielectric(refractiveIndex: 1.5))
//  let sph5 = Sphere(center: Vector(-1, 0, -1), radius: -0.45, material: Dielectric(refractiveIndex: 1.5))
//  let world = HitableList(list: [sph1, sph2, sph3, sph4, sph5])
  let world = generateScene()

//  let r = cos(M_PI / 4.0)
//  let sph1 = Sphere(center: Vector(-r, 0, -1), radius: r, material: Lambertian(albedo: Vector(0, 0, 1)))
//  let sph2 = Sphere(center: Vector(r, 0, -1), radius: r, material: Lambertian(albedo: Vector(1, 0, 0)))
//  let world = HitableList(list: [sph1, sph2])

  let origin = Vector(13, 2, 3)
  let lookAt = Vector(0, 0, 0)
  let fov = 20.0
  let distToFocus = 10.0
  let aperture = 0.1

  let camera = Camera(origin: origin,
                      lookAt: lookAt,
                      vup: Vector(0, 1, 0),
                      fov: fov,
                      aspect: Double(nx) / Double(ny),
                      aperture: aperture,
                      focusDistance: distToFocus)

  let colorFunc = ColorDeterminer(world: world, camera: camera).materialColor
  let colors = ImageGenerator(nx: nx, ny: ny, ns: ns, world: world, camera: camera, colorFunc: colorFunc)

  let header = "P3\n\(nx) \(ny)\n255"
  //print(header)
  colors.forEach { (rgb) in
    //print("\(rgb.r) \(rgb.g) \(rgb.b)")
  }
//  let write = colors.reduce(header) { (ret, rgb) -> String in
//    ret + "\(rgb.r) \(rgb.g) \(rgb.b)\n"
//  }
}

main()
