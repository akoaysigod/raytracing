import Darwin

final class Color {
  let world: HitableList
  let camera: Camera

  init(world: HitableList, camera: Camera) {
    self.world = world
    self.camera = camera
  }

  func randomInUnitSphere() -> Vector {

  }
}
