import Mathlib.RingTheory.LocalRing.ResidueField.Defs

/-!
# Definition 1.13: Residue Field

**Definition 1.13.** The *residue field* of a local ring A with maximal ideal 𝔪
is the field A/𝔪.

This is `IsLocalRing.ResidueField` in Mathlib.
-/

namespace SutherlandNumberTheoryLecture1.Chapter1

/-- Definition 1.13: The residue field of a local ring A with maximal ideal 𝔪
is the quotient field A/𝔪. This is `IsLocalRing.ResidueField A` in Mathlib. -/
def residueField_def (A : Type*) [CommRing A] [IsLocalRing A] :=
  IsLocalRing.ResidueField A

end SutherlandNumberTheoryLecture1.Chapter1
