import Mathlib.RingTheory.Valuation.ValuationRing
import Mathlib.RingTheory.Valuation.Integral
import Mathlib.RingTheory.IntegralClosure.IntegrallyClosed

/-!
# Proposition 1.25: Every Valuation Ring is Integrally Closed

**Proposition 1.25.** Every valuation ring is integrally closed.

*Proof.* Let A be a valuation ring with fraction field k and let α ∈ k be
integral over A. Then α^n + a_{n-1}α^{n-1} + ⋯ + a₀ = 0 for some aᵢ ∈ A.
Suppose α ∉ A. Then α⁻¹ ∈ A, since A is a valuation ring. Multiplying by
α^{-(n-1)} ∈ A and rearranging yields α ∈ A, a contradiction. □

In Mathlib, the relevant result is `ValuationRing.isIntegrallyClosed`
(or `Valuation.Integers.isIntegrallyClosed` for the valuation-based version).
-/

namespace SutherlandNumberTheoryLecture1.Chapter1

/-- Proposition 1.25: Every valuation ring is integrally closed.
If A is a valuation ring (for every x in Frac(A), either x ∈ A or x⁻¹ ∈ A),
then A is integrally closed in its fraction field. -/
theorem valuationRing_isIntegrallyClosed (A : Type*) [CommRing A] [IsDomain A]
    [ValuationRing A] : IsIntegrallyClosed A :=
  IsIntegrallyClosed.of_equiv (ValuationRing.equivInteger A (FractionRing A)).symm

end SutherlandNumberTheoryLecture1.Chapter1
