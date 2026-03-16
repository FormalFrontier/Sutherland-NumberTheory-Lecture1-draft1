import Mathlib.RingTheory.IntegralClosure.IntegrallyClosed

/-!
# Corollary 1.21: Integral Closure is Integrally Closed

**Corollary 1.21.** If B/A is a ring extension, then the integral closure of A
in B is integrally closed in B.

In Mathlib, the relevant result is `integralClosure.isIntegrallyClosedIn`.
-/

namespace SutherlandNumberTheoryLecture1.Chapter1

/-- Corollary 1.21: The integral closure of A in B is integrally closed in B.
This follows from the transitivity of integrality (Proposition 1.20). -/
theorem integralClosure_isIntegrallyClosedIn
    (A B : Type*) [CommRing A] [CommRing B] [Algebra A B] :
    IsIntegrallyClosedIn (integralClosure A B) B :=
  inferInstance

end SutherlandNumberTheoryLecture1.Chapter1
