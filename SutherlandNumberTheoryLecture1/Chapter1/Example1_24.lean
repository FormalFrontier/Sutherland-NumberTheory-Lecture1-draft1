import Mathlib.RingTheory.IntegralClosure.IntegrallyClosed
import Mathlib.RingTheory.Adjoin.Basic
import Mathlib.Data.Real.Sqrt
import Mathlib.RingTheory.IntegralClosure.IsIntegral.Basic
import Mathlib.NumberTheory.Real.Irrational

/-!
# Example 1.24: Z[√5] is not integrally closed

**Example 1.24.** The ring Z[√5] is not a UFD (nor a PID) because it is not
integrally closed: consider φ = (1 + √5)/2 ∈ Frac Z[√5], which is integral
over Z (and hence over Z[√5]), since φ² - φ - 1 = 0. But φ ∉ Z[√5], so Z[√5]
is not integrally closed.
-/

namespace SutherlandNumberTheoryLecture1.Chapter1

/-- The golden ratio φ = (1 + √5)/2 satisfies φ² - φ - 1 = 0,
hence is integral over ℤ. -/
theorem golden_ratio_integral :
    let φ : ℝ := (1 + Real.sqrt 5) / 2
    φ ^ 2 - φ - 1 = 0 := by
  simp only
  have h5 : Real.sqrt 5 ^ 2 = 5 := Real.sq_sqrt (by norm_num : (5 : ℝ) ≥ 0)
  nlinarith [h5]

/-- Every element of ℤ[√5] has the form a + b√5 for some a, b ∈ ℤ. -/
private theorem adjoin_sqrt5_form (x : ℝ)
    (hx : x ∈ (Algebra.adjoin ℤ {Real.sqrt 5} : Subalgebra ℤ ℝ)) :
    ∃ a b : ℤ, x = ↑a + ↑b * Real.sqrt 5 := by
  refine Algebra.adjoin_induction (R := ℤ) (s := {Real.sqrt 5})
    (p := fun x _ => ∃ a b : ℤ, x = ↑a + ↑b * Real.sqrt 5) ?_ ?_ ?_ ?_ hx
  · intro y hy
    rw [Set.mem_singleton_iff.mp hy]
    exact ⟨0, 1, by simp⟩
  · intro r
    exact ⟨r, 0, by simp⟩
  · intro x y _ _ ⟨a₁, b₁, h₁⟩ ⟨a₂, b₂, h₂⟩
    exact ⟨a₁ + a₂, b₁ + b₂, by rw [h₁, h₂]; push_cast; ring⟩
  · intro x y _ _ ⟨a₁, b₁, h₁⟩ ⟨a₂, b₂, h₂⟩
    refine ⟨a₁ * a₂ + 5 * b₁ * b₂, a₁ * b₂ + a₂ * b₁, ?_⟩
    rw [h₁, h₂]
    have h5 : Real.sqrt 5 * Real.sqrt 5 = 5 :=
      Real.mul_self_sqrt (by norm_num : (5 : ℝ) ≥ 0)
    push_cast; linear_combination (↑b₁ * ↑b₂ : ℝ) * h5

/-- The golden ratio φ = (1 + √5)/2 is not in ℤ[√5].
Elements of ℤ[√5] have the form a + b√5 for a, b ∈ ℤ,
but φ = 1/2 + (1/2)√5 has non-integer coefficients. -/
theorem golden_ratio_not_in_Z_adjoin_sqrt5 :
    (1 + Real.sqrt 5) / 2 ∉ (Algebra.adjoin ℤ {Real.sqrt 5} : Subalgebra ℤ ℝ) := by
  intro hmem
  obtain ⟨a, b, hab⟩ := adjoin_sqrt5_form _ hmem
  have hirr : Irrational (Real.sqrt 5) := by
    rw [show (5 : ℝ) = ((5 : ℕ) : ℝ) from by norm_num]
    exact irrational_sqrt_natCast_iff.mpr (fun ⟨n, hn⟩ => by
      have : n ≤ 2 := by nlinarith
      interval_cases n <;> omega)
  have hodd : (1 : ℤ) - 2 * b ≠ 0 := by omega
  have h_key : (1 - 2 * (↑b : ℝ)) * Real.sqrt 5 = 2 * (↑a : ℝ) - 1 := by
    linear_combination 2 * hab
  exact hirr ⟨((2 * a - 1 : ℤ) : ℚ) / ((1 - 2 * b : ℤ) : ℚ), by
    rw [Rat.cast_div, Rat.cast_intCast, Rat.cast_intCast, div_eq_iff
      (show ((1 - 2 * b : ℤ) : ℝ) ≠ 0 from Int.cast_ne_zero.mpr hodd)]
    push_cast; linarith [h_key]⟩

/-- Example 1.24: ℤ[√5] is not integrally closed. The golden ratio φ = (1 + √5)/2
is integral over ℤ (satisfying φ² - φ - 1 = 0) but does not lie in ℤ[√5]. -/
theorem Z_adjoin_sqrt5_not_integrally_closed :
    ¬ IsIntegrallyClosed (Algebra.adjoin ℤ {Real.sqrt 5} : Subalgebra ℤ ℝ) := by
  set S := (Algebra.adjoin ℤ {Real.sqrt 5} : Subalgebra ℤ ℝ)
  intro hIC
  -- Elements of S
  have h1s5_mem : (1 + Real.sqrt 5) ∈ S :=
    S.add_mem S.one_mem (Algebra.subset_adjoin rfl)
  set a : ↥S := ⟨1 + Real.sqrt 5, h1s5_mem⟩
  set b : ↥S := ⟨(2 : ℝ), S.algebraMap_mem 2⟩
  have hb_ne : b ≠ 0 := by intro h; apply_fun (↑· : ↥S → ℝ) at h; simp [b] at h
  -- φ = (1+√5)/2 in FractionRing S
  set aF := algebraMap ↥S (FractionRing ↥S) a
  set bF := algebraMap ↥S (FractionRing ↥S) b
  have hbF_ne : bF ≠ 0 :=
    (map_ne_zero_iff _ (IsFractionRing.injective ↥S (FractionRing ↥S))).mpr hb_ne
  set φ : FractionRing ↥S := aF / bF
  -- Lift S ↪ ℝ to FractionRing S →+* ℝ
  have h_inj : Function.Injective (S.subtype : ↥S →+* ℝ) := Subtype.val_injective
  set ι : FractionRing ↥S →+* ℝ :=
    IsFractionRing.lift (A := ↥S) (K := FractionRing ↥S) (g := S.subtype) h_inj with hι_def
  -- ι maps algebraMap r to r.val
  have hι_alg : ∀ r : ↥S, ι (algebraMap ↥S (FractionRing ↥S) r) = (r : ℝ) :=
    fun r => IsFractionRing.lift_algebraMap h_inj r
  -- ι φ = (1+√5)/2 in ℝ
  have hι_φ : ι φ = (1 + Real.sqrt 5) / 2 := by
    simp only [φ, map_div₀, aF, bF, hι_alg, a, b]
  -- φ² - φ - 1 = 0 in FractionRing S
  have hφ_eq : φ ^ 2 - φ - 1 = 0 := by
    have ha2 : a ^ 2 - a * b - b ^ 2 = (0 : ↥S) := by
      ext; simp [a, b]
      have h5 : Real.sqrt 5 * Real.sqrt 5 = 5 := Real.mul_self_sqrt (by norm_num)
      nlinarith [h5]
    have h := congr_arg (algebraMap ↥S (FractionRing ↥S)) ha2
    simp only [map_pow, map_mul, map_sub, map_zero] at h
    have hφb : φ * bF = aF := div_mul_cancel₀ aF hbF_ne
    have h1 : φ ^ 2 * bF ^ 2 = aF ^ 2 := by
      calc φ ^ 2 * bF ^ 2 = (φ * bF) ^ 2 := by ring
        _ = aF ^ 2 := by rw [hφb]
    have h2 : φ * bF ^ 2 = aF * bF := by
      calc φ * bF ^ 2 = (φ * bF) * bF := by ring
        _ = aF * bF := by rw [hφb]
    have key : (φ ^ 2 - φ - 1) * bF ^ 2 = 0 := by linear_combination h1 - h2 + h
    exact (mul_eq_zero.mp key).resolve_right (pow_ne_zero 2 hbF_ne)
  -- φ is integral over ℤ, hence over S
  have hφ_int : IsIntegral ↥S φ := by
    refine ⟨Polynomial.X ^ 2 - Polynomial.X - 1, ?_, ?_⟩
    · -- Monic: X^2 - (X + 1) has leading term from X^2
      have : Polynomial.X ^ 2 - Polynomial.X - (1 : Polynomial ↥S) =
             Polynomial.X ^ 2 - (Polynomial.X + 1 : Polynomial ↥S) := sub_sub _ _ _
      rw [this]
      exact (Polynomial.monic_X_pow 2).sub_of_left (by
        calc (Polynomial.X + 1 : Polynomial ↥S).degree
            ≤ max (Polynomial.X : Polynomial ↥S).degree (1 : Polynomial ↥S).degree :=
              Polynomial.degree_add_le _ _
          _ < (Polynomial.X ^ 2 : Polynomial ↥S).degree := by
              simp [Polynomial.degree_X, Polynomial.degree_one])
    · simp only [Polynomial.eval₂_sub, Polynomial.eval₂_pow,
          Polynomial.eval₂_X, Polynomial.eval₂_one]
      exact hφ_eq
  -- By IsIntegrallyClosed: φ in image of algebraMap
  obtain ⟨y, hy⟩ := (isIntegrallyClosed_iff (K := FractionRing ↥S)).mp hIC hφ_int
  -- Apply ι: y.val = (1+√5)/2 in ℝ
  have : (y : ℝ) = (1 + Real.sqrt 5) / 2 := by
    have h := congr_arg ι hy
    rw [hι_alg, hι_φ] at h
    exact h
  -- Contradiction: y ∈ S but (1+√5)/2 ∉ S
  exact golden_ratio_not_in_Z_adjoin_sqrt5 (this ▸ y.2)

end SutherlandNumberTheoryLecture1.Chapter1
