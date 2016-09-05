from hitable import Hitable

class HitableList(Hitable):
    def __init__(self, arr):
        self.arr = arr

    def hit(self, ray, tMin = 0.0, tMax = float("inf")):
        retRecord = None
        closest = tMax

        for item in self.arr:
            record = item.hit(ray, tMin, closest)
            if record:
                closest = record.t
                retRecord = record
        return retRecord
