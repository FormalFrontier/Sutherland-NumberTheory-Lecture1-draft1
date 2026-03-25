import Mathlib.RingTheory.IntegralClosure.IntegrallyClosed
import Mathlib.RingTheory.Polynomial.RationalRoot

/-!
# Proposition 1.22: ℤ is Integrally Closed

**Proposition 1.22.** The ring ℤ is integrally closed.

*Proof.* By the rational root test: if r/s ∈ ℚ is integral over ℤ with r, s
coprime, then r^n is a multiple of s, so s = ±1 and r/s ∈ ℤ. □

In Mathlib, this follows from `UniqueFactorizationMonoid.instIsIntegrallyClosed`,
since ℤ is a UFD (via `EuclideanDomain → PID → UFD`).
-/

namespace SutherlandNumberTheoryLecture1.Chapter1

/-- Proposition 1.22: ℤ is integrally closed in its fraction field ℚ.
This follows from the fact that ℤ is a UFD (hence integrally closed). -/
theorem int_isIntegrallyClosed : IsIntegrallyClosed ℤ := inferInstance

end SutherlandNumberTheoryLecture1.Chapter1
