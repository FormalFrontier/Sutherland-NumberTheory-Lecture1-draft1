import Mathlib.Algebra.Order.AbsoluteValue.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real

/-!
# Definition 1.6: Equivalence of Absolute Values

**Definition 1.6.** Two absolute values |·| and |·|' on the same field k are
*equivalent* if there exists an α ∈ ℝ>0 for which |x|' = |x|^α for all x ∈ k.
-/

namespace SutherlandNumberTheoryLecture1.Chapter1

/-- Definition 1.6: Two absolute values on k are equivalent if one is a positive
real power of the other. -/
def AbsoluteValue.AreEquivalent {k : Type*} [Field k]
    (f g : AbsoluteValue k ℝ) : Prop :=
  ∃ α : ℝ, 0 < α ∧ ∀ x : k, g x = (f x) ^ α

end SutherlandNumberTheoryLecture1.Chapter1
