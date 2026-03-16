import Mathlib.Algebra.Order.AbsoluteValue.Basic
import Mathlib.Analysis.Normed.Field.Basic

/-!
# Example 1.3: Trivial Absolute Value

**Example 1.3.** The map |·| : k → ℝ≥0 defined by |x| = 1 if x ≠ 0 and |0| = 0
is the *trivial absolute value* on k. It is nonarchimedean.
-/

namespace SutherlandNumberTheoryLecture1.Chapter1

/-- Example 1.3: The trivial absolute value exists on any field. -/
noncomputable def trivialAbsoluteValue (k : Type*) [DecidableEq k] [Field k] :
    AbsoluteValue k ℝ where
  toFun x := if x = 0 then 0 else 1
  map_mul' x y := by
    by_cases hx : x = 0 <;> by_cases hy : y = 0 <;> simp [hx, hy, mul_comm]
  nonneg' x := by split <;> norm_num
  eq_zero' x := by constructor <;> intro h <;> simp_all [ite_eq_left_iff]
  add_le' x y := by
    by_cases hx : x = 0 <;> by_cases hy : y = 0 <;> simp [hx, hy]
    by_cases hxy : x + y = 0 <;> simp [hxy]

/-- The trivial absolute value maps nonzero elements to 1. -/
theorem trivialAbsoluteValue_apply_ne_zero (k : Type*) [DecidableEq k] [Field k]
    (x : k) (hx : x ≠ 0) :
    trivialAbsoluteValue k x = 1 := by
  simp [trivialAbsoluteValue, hx]

/-- The trivial absolute value is nonarchimedean. -/
theorem trivialAbsoluteValue_isNonarchimedean (k : Type*) [DecidableEq k] [Field k] :
    IsNonarchimedean (trivialAbsoluteValue k) := by
  intro x y
  by_cases hx : x = 0 <;> by_cases hy : y = 0 <;> simp [trivialAbsoluteValue, hx, hy]
  by_cases hxy : x + y = 0 <;> simp [hxy]

end SutherlandNumberTheoryLecture1.Chapter1
