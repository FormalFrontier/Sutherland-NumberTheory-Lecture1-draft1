import Mathlib.RingTheory.IntegralClosure.Algebra.Basic
import Mathlib.RingTheory.IntegralClosure.IntegrallyClosed

/-!
# Definition 1.19: Integral Closure and Integrally Closed Domains

**Definition 1.19.** Given a ring extension B/A, the ring à = {b ∈ B : b is integral
over A} is the *integral closure* of A in B. When à = A we say that A is *integrally
closed in B*. For a domain A, its *integral closure* (or *normalization*) is its
integral closure in its fraction field, and A is *integrally closed* (or *normal*) if
it is integrally closed in its fraction field.

In Mathlib:
- `integralClosure R A` is the integral closure of R in A
- `IsIntegrallyClosed R` says R is integrally closed in its fraction field
-/

namespace SutherlandNumberTheoryLecture1.Chapter1

/-- Definition 1.19: The integral closure of R in A is the subalgebra of elements
integral over R. -/
example {R A : Type*} [CommRing R] [CommRing A] [Algebra R A] :
    Subalgebra R A := integralClosure R A

/-- A domain R is integrally closed if it contains all elements of its fraction field
that are integral over it. -/
example {R : Type*} [CommRing R] [IsDomain R] :
    Prop := IsIntegrallyClosed R

end SutherlandNumberTheoryLecture1.Chapter1
