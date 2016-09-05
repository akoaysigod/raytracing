protocol Hitable {
  func hit(ray: Ray, tMin: Double, tMax: Double) -> HitRecord?
}
