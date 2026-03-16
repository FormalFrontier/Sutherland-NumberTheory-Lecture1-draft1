import Mathlib.NumberTheory.Ostrowski

/-!
# Theorem 1.8: Ostrowski's Theorem

**Theorem 1.8** (Ostrowski's Theorem). Every nontrivial absolute value on ℚ is
equivalent to |·|_p for some p ≤ ∞.

In Mathlib, this is `Rat.AbsoluteValue.equiv_real_or_padic`.
-/

namespace SutherlandNumberTheoryLecture1.Chapter1

/-- Theorem 1.8 (Ostrowski's Theorem): Every nontrivial absolute value on ℚ
is equivalent to the real absolute value or to a p-adic absolute value for
some prime p. -/
theorem ostrowski (f : AbsoluteValue ℚ ℝ) (hf : f.IsNontrivial) :
    f ≈ Rat.AbsoluteValue.real ∨
    ∃! p, ∃ (_ : Fact p.Prime), f ≈ Rat.AbsoluteValue.padic p := by
  sorry

end SutherlandNumberTheoryLecture1.Chapter1
