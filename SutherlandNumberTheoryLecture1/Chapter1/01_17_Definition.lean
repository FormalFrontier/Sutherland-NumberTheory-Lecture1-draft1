import Mathlib.RingTheory.IntegralClosure.Algebra.Basic

/-!
# Definition 1.17: Integral Elements

**Definition 1.17.** Given a ring extension A ⊆ B, an element b ∈ B is *integral
over A* if it is a root of a monic polynomial in A[x]. The ring B is *integral
over A* if all its elements are.

In Mathlib:
- `IsIntegral R x` says x is integral over R
- `Algebra.IsIntegral R A` says all elements of A are integral over R
-/

namespace SutherlandNumberTheoryLecture1.Chapter1

/-- Definition 1.17 (element-level): An element b ∈ B is integral over A if it is
a root of a monic polynomial in A[x]. This is `IsIntegral A b` in Mathlib. -/
example {A B : Type*} [CommRing A] [CommRing B] [Algebra A B] (b : B) :
    Prop := IsIntegral A b

/-- Definition 1.17 (ring-level): B is integral over A if every element of B is
integral over A. This is `Algebra.IsIntegral A B` in Mathlib. -/
example {A B : Type*} [CommRing A] [CommRing B] [Algebra A B] :
    Prop := Algebra.IsIntegral A B

end SutherlandNumberTheoryLecture1.Chapter1
