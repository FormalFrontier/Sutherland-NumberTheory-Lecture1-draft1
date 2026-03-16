import Mathlib.NumberTheory.Padics.PadicVal.Basic
import Mathlib.NumberTheory.Padics.PadicNorm

/-!
# Definition 1.7: p-adic Valuation and Absolute Value

**Definition 1.7.** For a prime p the *p-adic valuation* v_p : ℚ → ℤ is defined by
v_p(± ∏_q q^{e_q}) := e_p, and v_p(0) := ∞. The *p-adic absolute value* on ℚ is
|x|_p := p^{-v_p(x)}.

In Mathlib:
- `padicValNat` / `padicValInt` / `padicValRat` for the valuation
- The p-adic norm on ℚ is available via `padicNorm`
-/

namespace SutherlandNumberTheoryLecture1.Chapter1

/-- Definition 1.7: The p-adic valuation on ℚ, capturing v_p as defined in the text.
Mathlib's `padicValRat p q` computes the p-adic valuation of a rational number q. -/
example (p : ℕ) [Fact (Nat.Prime p)] : ℚ → ℤ := padicValRat p

/-- The p-adic absolute value |x|_p = p^{-v_p(x)}.
Mathlib's `padicNorm p q` computes this. -/
example (p : ℕ) [Fact (Nat.Prime p)] : ℚ → ℚ := padicNorm p

/-- The p-adic norm satisfies |x|_p = 0 iff x = 0. -/
theorem padicNorm_eq_zero_iff (p : ℕ) [Fact (Nat.Prime p)] (q : ℚ) :
    padicNorm p q = 0 ↔ q = 0 := by
  sorry

/-- The p-adic norm is nonarchimedean: |x + y|_p ≤ max(|x|_p, |y|_p). -/
theorem padicNorm_nonarchimedean (p : ℕ) [Fact (Nat.Prime p)] (q r : ℚ) :
    padicNorm p (q + r) ≤ max (padicNorm p q) (padicNorm p r) := by
  sorry

end SutherlandNumberTheoryLecture1.Chapter1
