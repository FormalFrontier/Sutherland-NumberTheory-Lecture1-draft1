import Mathlib.RingTheory.Valuation.ValuationRing

/-!
# Definition 1.11: Valuation Rings

**Definition 1.11.** A *valuation ring* is an integral domain A with fraction
field k with the property that for every x ∈ k, either x ∈ A or x⁻¹ ∈ A.

This is exactly `ValuationRing` in Mathlib.
-/

namespace SutherlandNumberTheoryLecture1.Chapter1

/-- Definition 1.11: A valuation ring is an integral domain A such that for every
element x of its fraction field, either x or x⁻¹ lies in A. This is captured by
`ValuationRing A` in Mathlib. -/
def valuationRing_def (A : Type*) [CommRing A] [IsDomain A] :=
  ValuationRing A

end SutherlandNumberTheoryLecture1.Chapter1
