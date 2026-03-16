import Mathlib.RingTheory.IntegralClosure.IsIntegralClosure.Basic

/-!
# Proposition 1.20: Transitivity of Integrality

**Proposition 1.20.** If C/B/A is a tower of ring extensions in which B is integral
over A and C is integral over B then C is integral over A.

In Mathlib, this is `Algebra.IsIntegral.trans` (typeclass version) and
`isIntegral_trans` (element-level version).
-/

namespace SutherlandNumberTheoryLecture1.Chapter1

/-- Proposition 1.20: If B is integral over A and C is integral over B, then
C is integral over A. -/
theorem integrality_trans {A B C : Type*}
    [CommRing A] [CommRing B] [CommRing C]
    [Algebra A B] [Algebra B C] [Algebra A C] [IsScalarTower A B C]
    (hAB : Algebra.IsIntegral A B) (hBC : Algebra.IsIntegral B C) :
    Algebra.IsIntegral A C := by
  sorry

end SutherlandNumberTheoryLecture1.Chapter1
