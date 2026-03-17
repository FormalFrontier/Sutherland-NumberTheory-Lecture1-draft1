import Mathlib.FieldTheory.Minpoly.IsIntegrallyClosed
import Mathlib.RingTheory.IntegralClosure.IntegrallyClosed
import Mathlib.Algebra.Polynomial.Lifts

/-!
# Proposition 1.28: Minimal Polynomial Criterion for Integrality

**Proposition 1.28.** Let A be an integrally closed domain with fraction field K.
Let α be an element of a finite extension L/K, and let f ∈ K[x] be its minimal
polynomial over K. Then α is integral over A if and only if f ∈ A[x].

In Mathlib, the key result is `minpoly.isIntegrallyClosed_eq_field_fractions`.
-/

namespace SutherlandNumberTheoryLecture1.Chapter1

/-- Proposition 1.28: For an integrally closed domain A with fraction field K,
an element α of a finite extension L/K is integral over A if and only if its
minimal polynomial over K has coefficients in A.

The forward direction: if α is integral over A, then minpoly K α ∈ A[x].
This follows because the minimal polynomial over K equals the minimal polynomial
over A (by `minpoly.isIntegrallyClosed_eq_field_fractions`). -/
theorem integral_iff_minpoly_over_base
    {A K : Type*} [CommRing A] [IsDomain A] [IsIntegrallyClosed A]
    [Field K] [Algebra A K] [IsFractionRing A K]
    {L : Type*} [Field L] [Algebra K L]
    [Algebra A L] [IsScalarTower A K L]
    {α : L} (hα : IsIntegral K α) :
    IsIntegral A α ↔
      ∀ i, (minpoly K α).coeff i ∈ (algebraMap A K).range := by
  constructor
  · intro hAα
    rw [show minpoly K α = (minpoly A α).map (algebraMap A K) from
      minpoly.isIntegrallyClosed_eq_field_fractions' (R := A) (S := L) (K := K) hAα]
    intro i
    simp only [Polynomial.coeff_map, RingHom.mem_range, exists_apply_eq_apply]
  · intro hcoeff
    have hlifts : minpoly K α ∈ Polynomial.lifts (algebraMap A K) := by
      rw [Polynomial.lifts_iff_coeff_lifts]
      intro n
      exact RingHom.mem_range.mp (hcoeff n)
    obtain ⟨p, hp_map, _, hp_monic⟩ :=
      Polynomial.lifts_and_degree_eq_and_monic hlifts (minpoly.monic hα)
    refine ⟨p, hp_monic, ?_⟩
    have h1 : Polynomial.aeval (R := A) α p = Polynomial.aeval (R := K) α (minpoly K α) := by
      rw [← Polynomial.aeval_map_algebraMap K α p, hp_map]
    rw [minpoly.aeval] at h1
    exact_mod_cast h1

end SutherlandNumberTheoryLecture1.Chapter1
