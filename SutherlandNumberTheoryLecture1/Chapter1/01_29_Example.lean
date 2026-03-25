import Mathlib.RingTheory.IntegralClosure.IsIntegral.Basic
import Mathlib.RingTheory.IntegralClosure.IntegrallyClosed
import Mathlib.RingTheory.Polynomial.RationalRoot
import Mathlib.Data.Real.Sqrt

/-!
# Example 1.29: (1 + √7)/2 is not integral over ℤ

**Example 1.29.** We saw in Example 1.24 that (1 + √5)/2 is integral over ℤ.
Now consider α = (1 + √7)/2. Its minimal polynomial x² - x - 3/2 ∉ ℤ[x],
so α is not integral over ℤ.

This illustrates that whether (1 + √d)/2 is integral over ℤ depends on d mod 4:
it is integral when d ≡ 1 (mod 4) (as with d = 5) but not when d ≡ 3 (mod 4)
(as with d = 7).
-/

namespace SutherlandNumberTheoryLecture1.Chapter1

/-- The element α = (1 + √7)/2 satisfies α² - α - 3/2 = 0. Since the minimal
polynomial has non-integer coefficients, α is not integral over ℤ. -/
theorem half_one_plus_sqrt7_minimal_poly :
    let α : ℝ := (1 + Real.sqrt 7) / 2
    α ^ 2 - α - 3 / 2 = 0 := by
  simp only
  nlinarith [Real.sq_sqrt (show (0 : ℝ) ≤ 7 by norm_num)]

/-- Example 1.29: (1 + √7)/2 is not integral over ℤ. Its minimal polynomial
x² - x - 3/2 does not have integer coefficients. -/
theorem half_one_plus_sqrt7_not_integral :
    ¬ IsIntegral ℤ ((1 + Real.sqrt 7) / 2 : ℝ) := by
  intro h_int
  -- (1-√7)/2 = 1 - (1+√7)/2 is also integral
  have h_conj : IsIntegral ℤ ((1 - Real.sqrt 7) / 2 : ℝ) := by
    have : (1 - Real.sqrt 7) / 2 = 1 - (1 + Real.sqrt 7) / 2 := by ring
    rw [this]; exact isIntegral_one.sub h_int
  -- Their product equals -3/2
  have h_prod_int : IsIntegral ℤ ((-3 / 2 : ℚ) : ℝ) := by
    have h := h_int.mul h_conj
    have h_prod_eq : ((1 + Real.sqrt 7) / 2) * ((1 - Real.sqrt 7) / 2 : ℝ) =
        ((-3 / 2 : ℚ) : ℝ) := by
      push_cast
      nlinarith [Real.sq_sqrt (show (0 : ℝ) ≤ 7 by norm_num)]
    rwa [h_prod_eq] at h
  -- Transfer: IsIntegral ℤ ((-3/2 : ℚ) : ℝ) → IsIntegral ℤ (-3/2 : ℚ)
  have h_rat : IsIntegral ℤ (-3 / 2 : ℚ) := by
    obtain ⟨p, hp_monic, hp_eval⟩ := h_prod_int
    exact ⟨p, hp_monic, by
      apply (algebraMap ℚ ℝ).injective
      rw [map_zero, Polynomial.hom_eval₂, ← IsScalarTower.algebraMap_eq ℤ ℚ ℝ]
      exact hp_eval⟩
  -- By ℤ integrally closed: -3/2 must be an integer
  obtain ⟨n, hn⟩ := IsIntegrallyClosed.isIntegral_iff.mp h_rat
  -- But -3/2 is not an integer
  have h_eq : (n : ℚ) = -3 / 2 := by simpa using hn
  have h_two_n : (2 : ℚ) * n = -3 := by linarith
  exact absurd (by exact_mod_cast h_two_n : (2 : ℤ) * n = -3) (by omega)

end SutherlandNumberTheoryLecture1.Chapter1
