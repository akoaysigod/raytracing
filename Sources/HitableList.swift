final class HitableList: Hitable {
  private let list: [Hitable]

  init(list: [Hitable]) {
    self.list = list
  }

  func hit(ray: Ray, tMin: Double = 0.0, tMax: Double = Double.infinity) -> HitRecord? {
    var retRecord: HitRecord?
    var closest = tMax

    list.forEach { object in
      if let record = object.hit(ray: ray, tMin: tMin, tMax: closest) {
        closest = record.t
        retRecord = record
      }
    }
    return retRecord
  }
}
