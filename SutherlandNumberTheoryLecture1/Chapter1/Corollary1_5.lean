import Mathlib.Analysis.Normed.Field.Basic
import Mathlib.Algebra.CharP.Defs

/-!
# Corollary 1.5: Positive Characteristic Implies Nonarchimedean

**Corollary 1.5.** In a field of positive characteristic every absolute value is
nonarchimedean, and the only absolute value on a finite field is the trivial one.
-/

namespace SutherlandNumberTheoryLecture1.Chapter1

/-- Corollary 1.5 (part 1): In a field of positive characteristic, every absolute
value is nonarchimedean. -/
theorem posChar_isNonarchimedean {k : Type*} [Field k] {p : ℕ} [CharP k p]
    (hp : p ≠ 0) (f : AbsoluteValue k ℝ) :
    IsNonarchimedean f := by
  sorry

/-- Corollary 1.5 (part 2): The only absolute value on a finite field is the
trivial one (maps all nonzero elements to 1). -/
theorem finite_field_absval_trivial {k : Type*} [Field k] [Finite k]
    (f : AbsoluteValue k ℝ) (x : k) (hx : x ≠ 0) :
    f x = 1 := by
  sorry

end SutherlandNumberTheoryLecture1.Chapter1
