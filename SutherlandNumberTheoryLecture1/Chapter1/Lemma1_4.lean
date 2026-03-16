import Mathlib.Analysis.Normed.Field.Basic

/-!
# Lemma 1.4: Nonarchimedean Characterization

**Lemma 1.4.** An absolute value |·| on a field k is nonarchimedean if and only if
|1 + ⋯ + 1 (n times)| ≤ 1 for all n ≥ 1.

The forward direction is `IsNonarchimedean.natCast_le_one` in Mathlib.
The reverse direction needs to be proved.
-/

namespace SutherlandNumberTheoryLecture1.Chapter1

/-- Lemma 1.4: An absolute value on a field is nonarchimedean if and only if
|n| ≤ 1 for all positive integers n. -/
theorem nonarchimedean_iff_natCast_le_one {k : Type*} [Field k]
    (f : AbsoluteValue k ℝ) :
    IsNonarchimedean f ↔ ∀ n : ℕ, f n ≤ 1 := by
  sorry

end SutherlandNumberTheoryLecture1.Chapter1
