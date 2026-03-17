import Mathlib.NumberTheory.Padics.PadicNorm
import Mathlib.Data.Nat.Factorization.Basic
import Mathlib.Algebra.BigOperators.Finprod

/-!
# Theorem 1.9: Product Formula

**Theorem 1.9** (Product Formula). For every x ∈ ℚ× we have
  ∏_{p ≤ ∞} |x|_p = 1.

The product is over all places of ℚ: the real absolute value and the p-adic
absolute values for each prime p. For any nonzero rational, only finitely many
p-adic absolute values differ from 1, so the product is well-defined.
-/

namespace SutherlandNumberTheoryLecture1.Chapter1

/-- For a nonzero rational, padicNorm p q = 1 for all primes p not dividing
the numerator or denominator. -/
theorem padicNorm_eq_one_of_not_dvd (q : ℚ) (hq : q ≠ 0) (p : ℕ)
    (hp : Nat.Prime p) (hp_ndvd : p ∉ (q.num.natAbs * q.den).primeFactors) :
    padicNorm p q = 1 := by
  haveI : Fact (Nat.Prime p) := ⟨hp⟩
  have hndvd : ¬(p ∣ q.num.natAbs * q.den) := by
    intro h; exact hp_ndvd (Nat.mem_primeFactors.mpr ⟨hp, h,
      mul_ne_zero (Int.natAbs_ne_zero.mpr (Rat.num_ne_zero.mpr hq)) (Rat.den_pos q).ne'⟩)
  have hndvd_num : ¬(p ∣ q.num.natAbs) := fun h => hndvd (dvd_mul_of_dvd_left h _)
  have hndvd_den : ¬(p ∣ q.den) := fun h => hndvd (dvd_mul_of_dvd_right h _)
  rw [padicNorm.eq_zpow_of_nonzero hq]
  suffices padicValRat p q = 0 by rw [this]; simp
  change (padicValInt p q.num : ℤ) - (padicValNat p q.den : ℤ) = 0
  simp [padicValInt, padicValNat.eq_zero_of_not_dvd hndvd_num,
        padicValNat.eq_zero_of_not_dvd hndvd_den]

/-- The FTA product: for n ≠ 0, ∏ p ∈ n.primeFactors, p ^ padicValNat p n = n. -/
private lemma fta_prod_nat (n : ℕ) (hn : n ≠ 0) :
    ∏ p ∈ n.primeFactors, p ^ padicValNat p n = n := by
  have h_eq : ∀ p ∈ n.primeFactors, p ^ padicValNat p n = p ^ n.factorization p :=
    fun p hp => by rw [Nat.factorization_def n (Nat.prime_of_mem_primeFactors hp)]
  rw [Finset.prod_congr rfl h_eq]
  exact Nat.factorization_prod_pow_eq_self hn

/-- Cast version: ∏ p ∈ n.primeFactors, (p : ℚ) ^ padicValNat p n = (n : ℚ). -/
private lemma fta_prod_rat (n : ℕ) (hn : n ≠ 0) :
    ∏ p ∈ n.primeFactors, (p : ℚ) ^ padicValNat p n = (n : ℚ) := by
  have h : ∀ p ∈ n.primeFactors, (p : ℚ) ^ padicValNat p n = ((p ^ padicValNat p n : ℕ) : ℚ) :=
    fun p _ => (Nat.cast_pow p (padicValNat p n)).symm
  rw [Finset.prod_congr rfl h, ← Nat.cast_prod, Nat.cast_inj]
  exact fta_prod_nat n hn

/-- Theorem 1.9 (Product Formula): For any nonzero rational q, the product of the
real absolute value and all p-adic absolute values equals 1:
  |q| * ∏_{p | num(q) * den(q)} |q|_p = 1
where |q| is the usual (archimedean) absolute value and the product ranges over
primes dividing the numerator or denominator. -/
theorem product_formula (q : ℚ) (hq : q ≠ 0) :
    |q| * ∏ p ∈ (q.num.natAbs * q.den).primeFactors, padicNorm p q = 1 := by
  set a := q.num.natAbs with ha_def
  set b := q.den with hb_def
  have ha : a ≠ 0 := Int.natAbs_ne_zero.mpr (Rat.num_ne_zero.mpr hq)
  have hb : (b : ℕ) ≠ 0 := (Rat.den_pos q).ne'
  have ha' : (a : ℚ) ≠ 0 := Nat.cast_ne_zero.mpr ha
  have hb' : (b : ℚ) ≠ 0 := Nat.cast_ne_zero.mpr hb
  have hcop : Nat.Coprime a b := q.reduced
  -- Step 1: |q| = a / b
  have habs : (|q| : ℚ) = (a : ℚ) / (b : ℚ) := by
    rw [Rat.abs_def, Rat.divInt_eq_div, Int.cast_natCast, Int.cast_natCast]
  -- Step 2: Split primeFactors(a * b) = primeFactors(a) ∪ primeFactors(b)
  have hS : (a * b).primeFactors = a.primeFactors ∪ b.primeFactors :=
    Nat.primeFactors_mul ha hb
  have hdisj : Disjoint a.primeFactors b.primeFactors :=
    hcop.disjoint_primeFactors
  rw [hS, Finset.prod_union hdisj]
  -- Step 3: Product over primes dividing a
  have hprod_a : ∏ p ∈ a.primeFactors, padicNorm p q = (a : ℚ)⁻¹ := by
    -- For p ∈ a.primeFactors: p ∤ b, so padicValRat p q = padicValNat p a
    have h_val : ∀ p ∈ a.primeFactors, padicNorm p q = (p : ℚ) ^ (-(padicValNat p a : ℤ)) := by
      intro p hp
      have hp_prime := Nat.prime_of_mem_primeFactors hp
      haveI : Fact (Nat.Prime p) := ⟨hp_prime⟩
      have hp_ndvd_b : ¬(p ∣ b) :=
        fun h => Finset.disjoint_left.mp hdisj hp (Nat.mem_primeFactors.mpr ⟨hp_prime, h, hb⟩)
      rw [padicNorm.eq_zpow_of_nonzero hq]
      congr 1
      change -((padicValInt p q.num : ℤ) - (padicValNat p b : ℤ)) = -(padicValNat p a : ℤ)
      simp [padicValInt, ha_def, padicValNat.eq_zero_of_not_dvd hp_ndvd_b]
    rw [Finset.prod_congr rfl h_val]
    simp_rw [zpow_neg, Finset.prod_inv_distrib, zpow_natCast]
    rw [fta_prod_rat a ha]
  -- Step 4: Product over primes dividing b
  have hprod_b : ∏ p ∈ b.primeFactors, padicNorm p q = (b : ℚ) := by
    have h_val : ∀ p ∈ b.primeFactors, padicNorm p q = (p : ℚ) ^ (padicValNat p b : ℤ) := by
      intro p hp
      have hp_prime := Nat.prime_of_mem_primeFactors hp
      haveI : Fact (Nat.Prime p) := ⟨hp_prime⟩
      have hp_ndvd_a : ¬(p ∣ a) :=
        fun h => Finset.disjoint_right.mp hdisj hp (Nat.mem_primeFactors.mpr ⟨hp_prime, h, ha⟩)
      rw [padicNorm.eq_zpow_of_nonzero hq]
      congr 1
      change -((padicValInt p q.num : ℤ) - (padicValNat p b : ℤ)) = (padicValNat p b : ℤ)
      have h0 : (padicValInt p q.num : ℤ) = 0 := by
        simp only [padicValInt]; exact_mod_cast padicValNat.eq_zero_of_not_dvd hp_ndvd_a
      omega
    rw [Finset.prod_congr rfl h_val]
    simp_rw [zpow_natCast]
    exact fta_prod_rat b hb
  -- Step 5: Combine
  rw [habs, hprod_a, hprod_b, mul_comm (a : ℚ)⁻¹ (b : ℚ), ← mul_assoc,
      div_mul_cancel₀ _ hb', mul_inv_cancel₀ ha']

/-- Theorem 1.9 (Product Formula, all-primes form): For any nonzero rational q,
  |q| · ∏ᶠ p ∈ {p : ℕ | p.Prime}, |q|_p = 1.
The finprod ranges over all primes; since |q|_p = 1 for all but finitely many p,
the product is well-defined. -/
theorem product_formula_all_primes (q : ℚ) (hq : q ≠ 0) :
    |q| * ∏ᶠ (p : ℕ) (_ : p.Prime), padicNorm p q = 1 := by
  -- The finprod over primes equals the finite product over primeFactors
  have h_eq : ∏ᶠ (p : ℕ) (_ : p.Prime), padicNorm p q =
      ∏ p ∈ (q.num.natAbs * q.den).primeFactors, padicNorm p q := by
    apply finprod_mem_eq_prod_of_subset
    · -- {p | Prime p} ∩ mulSupport (padicNorm · q) ⊆ ↑primeFactors
      intro p hp
      simp only [Set.mem_inter_iff, Function.mem_mulSupport] at hp
      by_contra h_not_mem
      exact hp.2 (padicNorm_eq_one_of_not_dvd q hq p hp.1 h_not_mem)
    · -- ↑primeFactors ⊆ {p | Prime p}
      intro p hp
      exact Nat.prime_of_mem_primeFactors (Finset.mem_coe.mp hp)
  rw [h_eq]
  exact product_formula q hq

end SutherlandNumberTheoryLecture1.Chapter1
