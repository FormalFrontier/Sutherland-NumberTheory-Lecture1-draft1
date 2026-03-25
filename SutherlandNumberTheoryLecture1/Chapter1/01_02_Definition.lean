import Mathlib.Algebra.Order.AbsoluteValue.Basic
import Mathlib.Analysis.Normed.Field.Basic

/-!
# Definition 1.2: Absolute Values

**Definition 1.2.** An *absolute value* on a field k is a map |·| : k → ℝ≥0 such that
for all x, y ∈ k the following hold:
1. |x| = 0 if and only if x = 0;
2. |xy| = |x||y|;
3. |x + y| ≤ |x| + |y|.

If the stronger condition |x + y| ≤ max(|x|, |y|) also holds, then the absolute value is
*nonarchimedean*; otherwise it is *archimedean*.

Mathlib's `AbsoluteValue R S` captures this definition exactly. The nonarchimedean
property is captured by `IsNonarchimedean`.
-/

namespace SutherlandNumberTheoryLecture1.Chapter1

/-- Definition 1.2: An absolute value on a field k is captured by Mathlib's
`AbsoluteValue k ℝ`. The nonarchimedean property is `IsNonarchimedean f`. -/
def absoluteValue_def (k : Type*) [Field k] := AbsoluteValue k ℝ

/-- An absolute value is nonarchimedean if it satisfies the ultrametric inequality. -/
def isNonarchimedean_def {k : Type*} [Field k] (f : AbsoluteValue k ℝ) :=
  IsNonarchimedean f

end SutherlandNumberTheoryLecture1.Chapter1
