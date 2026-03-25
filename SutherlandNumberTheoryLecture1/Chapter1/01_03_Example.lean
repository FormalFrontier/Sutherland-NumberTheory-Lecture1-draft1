import Mathlib.Algebra.Order.AbsoluteValue.Basic
import Mathlib.Analysis.Normed.Field.Basic

/-!
# Example 1.3: Trivial Absolute Value

**Example 1.3.** The map |·| : k → ℝ≥0 defined by |x| = 1 if x ≠ 0 and |0| = 0
is the *trivial absolute value* on k. It is nonarchimedean.
-/

namespace SutherlandNumberTheoryLecture1.Chapter1

/-- Example 1.3: The trivial absolute value exists on any field.
This delegates to `AbsoluteValue.trivial` from Mathlib. -/
noncomputable def trivialAbsoluteValue (k : Type*) [DecidableEq k] [Field k] :
    AbsoluteValue k ℝ :=
  AbsoluteValue.trivial

/-- The trivial absolute value maps nonzero elements to 1. -/
theorem trivialAbsoluteValue_apply_ne_zero (k : Type*) [DecidableEq k] [Field k]
    (x : k) (hx : x ≠ 0) :
    trivialAbsoluteValue k x = 1 :=
  AbsoluteValue.trivial_apply hx

/-- The trivial absolute value is nonarchimedean. -/
theorem trivialAbsoluteValue_isNonarchimedean (k : Type*) [DecidableEq k] [Field k] :
    IsNonarchimedean (trivialAbsoluteValue k) := by
  intro x y
  change AbsoluteValue.trivial (x + y) ≤ max (AbsoluteValue.trivial x) (AbsoluteValue.trivial y)
  by_cases hx : x = 0
  · simp [AbsoluteValue.trivial, hx]
  · by_cases hy : y = 0
    · simp [AbsoluteValue.trivial, hy]
    · by_cases hxy : x + y = 0 <;> simp [AbsoluteValue.trivial, hx, hy, hxy]

end SutherlandNumberTheoryLecture1.Chapter1
