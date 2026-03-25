import Mathlib.NumberTheory.NumberField.Basic

/-!
# Definition 1.26: Number Fields and Rings of Integers

**Definition 1.26.** A *number field* K is a finite extension of ℚ. The *ring of integers*
𝒪_K is the integral closure of ℤ in K.

In Mathlib:
- `NumberField` — a field K that is a finite extension of ℚ
- `NumberField.RingOfIntegers` (notation `𝓞 K`) — the integral closure of ℤ in K
-/

namespace SutherlandNumberTheoryLecture1.Chapter1

/-- Definition 1.26: A number field is a finite extension of ℚ.
Mathlib's `NumberField` class captures this exactly. -/
example (K : Type*) [Field K] [NumberField K] : FiniteDimensional ℚ K :=
  NumberField.to_finiteDimensional

/-- Definition 1.26: The ring of integers 𝒪_K is the integral closure of ℤ in K.
Mathlib's `𝓞 K` denotes `NumberField.RingOfIntegers K`. -/
example (K : Type*) [Field K] [NumberField K] : Type _ :=
  NumberField.RingOfIntegers K

end SutherlandNumberTheoryLecture1.Chapter1
