import Mathlib.RingTheory.IntegralClosure.Algebra.Basic

/-!
# Proposition 1.18: Integral Elements are Closed under Addition and Multiplication

**Proposition 1.18.** Let α, β ∈ B be integral over A ⊆ B. Then α + β and αβ
are integral over A.

In Mathlib, these are `IsIntegral.add` and `IsIntegral.mul`.
-/

namespace SutherlandNumberTheoryLecture1.Chapter1

/-- Proposition 1.18 (sum): The sum of integral elements is integral. -/
theorem integral_add {A B : Type*} [CommRing A] [CommRing B] [Algebra A B]
    {α β : B} (hα : IsIntegral A α) (hβ : IsIntegral A β) :
    IsIntegral A (α + β) :=
  hα.add hβ

/-- Proposition 1.18 (product): The product of integral elements is integral. -/
theorem integral_mul {A B : Type*} [CommRing A] [CommRing B] [Algebra A B]
    {α β : B} (hα : IsIntegral A α) (hβ : IsIntegral A β) :
    IsIntegral A (α * β) :=
  hα.mul hβ

end SutherlandNumberTheoryLecture1.Chapter1
