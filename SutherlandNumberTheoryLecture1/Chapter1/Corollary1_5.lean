import Mathlib.Analysis.Normed.Field.Basic
import Mathlib.Algebra.CharP.Defs
import Mathlib.Algebra.CharP.Frobenius
import Mathlib.GroupTheory.OrderOfElement
import SutherlandNumberTheoryLecture1.Chapter1.Lemma1_4

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
  rw [nonarchimedean_iff_natCast_le_one]
  intro n
  have hprime := CharP.char_prime_of_ne_zero k hp
  haveI : Fact (Nat.Prime p) := ⟨hprime⟩
  -- Frobenius fixes natural number casts: (n : k)^p = (n : k)
  have hfrob : (n : k) ^ p = (n : k) := by
    have := map_natCast (frobenius k p) n
    rwa [frobenius_def] at this
  -- So f(n)^p = f(n)
  have h1 : f n ^ p = f n := by rw [← map_pow, hfrob]
  -- f(n) ≥ 0 and f(n)^p = f(n) with p ≥ 2 implies f(n) ≤ 1
  rcases eq_or_lt_of_le (f.nonneg (n : k)) with hfn | hfn
  · linarith
  · -- f(n) > 0, so f(n)^(p-1) = 1
    have h2 : f n ^ (p - 1) = 1 := by
      have h3 : f n ^ (p - 1) * f n = 1 * f n := by
        rw [← pow_succ, Nat.sub_one_add_one_eq_of_pos hprime.pos, h1, one_mul]
      exact mul_right_cancel₀ (ne_of_gt hfn) h3
    have hp2 : p - 1 ≠ 0 := Nat.sub_ne_zero_of_lt hprime.one_lt
    exact le_of_eq ((pow_eq_one_iff_of_nonneg (f.nonneg _) hp2).mp h2)

/-- Corollary 1.5 (part 2): The only absolute value on a finite field is the
trivial one (maps all nonzero elements to 1). -/
theorem finite_field_absval_trivial {k : Type*} [Field k] [Finite k]
    (f : AbsoluteValue k ℝ) (x : k) (hx : x ≠ 0) :
    f x = 1 := by
  -- In a finite field, x^n = 1 for some n > 0
  haveI : Finite kˣ := Finite.of_injective Units.val Units.val_injective
  set u : kˣ := Units.mk0 x hx
  have hfin : IsOfFinOrder u := isOfFinOrder_of_finite u
  have hord : 0 < orderOf u := hfin.orderOf_pos
  have hpow : u ^ orderOf u = 1 := pow_orderOf_eq_one u
  -- x^(orderOf u) = 1
  have hxpow : x ^ orderOf u = 1 := by
    have h : (u : k) ^ orderOf u = (1 : kˣ) := by exact_mod_cast hpow
    simpa using h
  -- f(x)^n = f(x^n) = f(1) = 1
  have h1 : f x ^ orderOf u = 1 := by rw [← map_pow, hxpow, map_one]
  -- f(x) ≥ 0 and f(x)^n = 1 implies f(x) = 1
  exact (pow_eq_one_iff_of_nonneg (f.nonneg _) hord.ne').mp h1

end SutherlandNumberTheoryLecture1.Chapter1
