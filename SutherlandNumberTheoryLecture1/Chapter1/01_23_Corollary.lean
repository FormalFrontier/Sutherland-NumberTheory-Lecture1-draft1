import Mathlib.RingTheory.Polynomial.RationalRoot

/-!
# Corollary 1.23: Every UFD is Integrally Closed

**Corollary 1.23.** Every unique factorization domain is integrally closed.
In particular, every PID is integrally closed.

*Proof.* The proof of Proposition 1.22 works for any UFD. □

In Mathlib, this is `UniqueFactorizationMonoid.instIsIntegrallyClosed`.
-/

namespace SutherlandNumberTheoryLecture1.Chapter1

/-- Corollary 1.23: Every UFD is integrally closed. In particular, every PID
is integrally closed. This is `UniqueFactorizationMonoid.instIsIntegrallyClosed`
in Mathlib. -/
theorem ufd_isIntegrallyClosed (A : Type*) [CommRing A] [IsDomain A]
    [UniqueFactorizationMonoid A] : IsIntegrallyClosed A := inferInstance

end SutherlandNumberTheoryLecture1.Chapter1
