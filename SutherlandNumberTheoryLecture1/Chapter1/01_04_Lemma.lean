import Mathlib.Analysis.Normed.Field.Basic
import Mathlib.Algebra.Order.Ring.IsNonarchimedean
import Mathlib.Data.Nat.Choose.Sum

/-!
# Lemma 1.4: Nonarchimedean Characterization

**Lemma 1.4.** An absolute value |·| on a field k is nonarchimedean if and only if
|1 + ⋯ + 1 (n times)| ≤ 1 for all n ≥ 1.

The forward direction is `IsNonarchimedean.apply_natCast_le_one_of_isNonarchimedean` in Mathlib.
The reverse direction is proved using the binomial theorem argument.
-/

namespace SutherlandNumberTheoryLecture1.Chapter1

/-- Key bound: using the binomial theorem and the hypothesis that f sends all naturals to ≤ 1,
we get f(x+y)^n ≤ (n+1) * max(f x, f y)^n for any absolute value f. -/
private lemma absval_add_pow_le {k : Type*} [Field k]
    (f : AbsoluteValue k ℝ) (hnat : ∀ n : ℕ, f n ≤ 1)
    (x y : k) (n : ℕ) :
    f (x + y) ^ n ≤ (↑(n + 1) : ℝ) * max (f x) (f y) ^ n := by
  rw [← map_pow, Commute.add_pow (Commute.all x y)]
  calc f (∑ i ∈ Finset.range (n + 1), x ^ i * y ^ (n - i) * ↑(n.choose i))
      ≤ ∑ i ∈ Finset.range (n + 1),
          f (x ^ i * y ^ (n - i) * ↑(n.choose i)) := f.sum_le _ _
    _ = ∑ i ∈ Finset.range (n + 1),
          f x ^ i * f y ^ (n - i) * f ↑(n.choose i) := by
        congr 1; ext i; simp only [map_mul, map_pow]
    _ ≤ ∑ i ∈ Finset.range (n + 1), f x ^ i * f y ^ (n - i) := by
        apply Finset.sum_le_sum; intro i _
        exact mul_le_of_le_one_right
          (mul_nonneg (pow_nonneg (f.nonneg _) _) (pow_nonneg (f.nonneg _) _))
          (hnat _)
    _ ≤ ∑ _i ∈ Finset.range (n + 1), max (f x) (f y) ^ n := by
        apply Finset.sum_le_sum; intro i hi
        rw [Finset.mem_range] at hi
        calc f x ^ i * f y ^ (n - i)
            ≤ max (f x) (f y) ^ i * max (f x) (f y) ^ (n - i) := by
              gcongr
              · exact le_max_left _ _
              · exact le_max_right _ _
          _ = max (f x) (f y) ^ n := by
              rw [← pow_add]; congr 1; omega
    _ = (↑(n + 1) : ℝ) * max (f x) (f y) ^ n := by
        simp [Finset.sum_const, Finset.card_range, nsmul_eq_mul]

/-- Lemma 1.4: An absolute value on a field is nonarchimedean if and only if
|n| ≤ 1 for all positive integers n. -/
theorem nonarchimedean_iff_natCast_le_one {k : Type*} [Field k]
    (f : AbsoluteValue k ℝ) :
    IsNonarchimedean f ↔ ∀ n : ℕ, f n ≤ 1 := by
  constructor
  · intro hna _
    exact IsNonarchimedean.apply_natCast_le_one_of_isNonarchimedean hna
  · intro hnat x y
    change f (x + y) ≤ max (f x) (f y)
    set M := max (f x) (f y) with hM_def
    have hM : 0 ≤ M := le_max_of_le_left (f.nonneg x)
    refine le_of_forall_gt_imp_ge_of_dense fun a ha => ?_
    have ha0 : 0 < a := lt_of_le_of_lt hM ha
    rcases eq_or_lt_of_le hM with hM0 | hM0
    · -- M = 0 means f x = 0 and f y = 0, hence x = 0 and y = 0
      have hfx : f x = 0 := le_antisymm (hM0.symm ▸ le_max_left _ _) (f.nonneg _)
      have hfy : f y = 0 := le_antisymm (hM0.symm ▸ le_max_right _ _) (f.nonneg _)
      rw [map_eq_zero] at hfx hfy
      simp [hfx, hfy, ha0.le]
    · -- M > 0: choose n with (n+1) < (a/M)^n
      have ham : 1 < a / M := by rwa [one_lt_div hM0]
      obtain ⟨n, hn⟩ := Real.exists_natCast_add_one_lt_pow_of_one_lt ham
      have hMn : 0 < M ^ n := pow_pos hM0 n
      rw [div_pow, lt_div_iff₀ hMn] at hn
      -- hn : (↑n + 1) * M ^ n < a ^ n
      have key := absval_add_pow_le f hnat x y n
      -- key : f (x + y) ^ n ≤ ↑(n + 1) * max (f x) (f y) ^ n
      push_cast at key
      rw [← hM_def] at key
      have hn0 : n ≠ 0 := by rintro rfl; simp at hn
      exact le_of_pow_le_pow_left₀ hn0 ha0.le (key.trans hn.le)

end SutherlandNumberTheoryLecture1.Chapter1
