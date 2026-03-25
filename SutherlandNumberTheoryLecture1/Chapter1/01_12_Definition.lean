import Mathlib.RingTheory.LocalRing.Defs

/-!
# Definition 1.12: Local Rings

**Definition 1.12.** A *local ring* is a commutative ring with a unique maximal ideal.

This is exactly `IsLocalRing` in Mathlib.
-/

namespace SutherlandNumberTheoryLecture1.Chapter1

/-- Definition 1.12: A local ring is a commutative ring with a unique maximal ideal.
This is captured by `IsLocalRing` in Mathlib. -/
def localRing_def (A : Type*) [CommRing A] :=
  IsLocalRing A

end SutherlandNumberTheoryLecture1.Chapter1
