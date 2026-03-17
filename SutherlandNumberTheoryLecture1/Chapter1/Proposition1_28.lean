import Mathlib.FieldTheory.Minpoly.IsIntegrallyClosed
import Mathlib.RingTheory.IntegralClosure.IntegrallyClosed
import Mathlib.Algebra.Polynomial.Lifts

/-!
# Proposition 1.28: Minimal Polynomial Criterion for Integrality

**Proposition 1.28.** Let A be an integrally closed domain with fraction field K.
Let α be an element of a finite extension L/K, and let f ∈ K[x] be its minimal
polynomial over K. Then α is integral over A if and only if f ∈ A[x].

This delegates to Mathlib's `minpoly.isIntegrallyClosed_eq_field_fractions'`
(in `Mathlib.FieldTheory.Minpoly.IsIntegrallyClosed`), which shows
`minpoly K α = (minpoly A α).map (algebraMap A K)` for integral elements.
-/

namespace SutherlandNumberTheoryLecture1.Chapter1

/-- Proposition 1.28: For an integrally closed domain A with fraction field K,
an element α of a finite extension L/K is integral over A if and only if its
minimal polynomial over K has coefficients in A.

The forward direction delegates to `minpoly.isIntegrallyClosed_eq_field_fractions'`:
the minimal polynomial over K equals the image of the minimal polynomial over A,
so all coefficients are in the range of `algebraMap A K`.

The reverse direction lifts the polynomial back to A[x] and verifies integrality. -/
theorem integral_iff_minpoly_over_base
    {A K : Type*} [CommRing A] [IsDomain A] [IsIntegrallyClosed A]
    [Field K] [Algebra A K] [IsFractionRing A K]
    {L : Type*} [Field L] [Algebra K L]
    [Algebra A L] [IsScalarTower A K L]
    {α : L} (hα : IsIntegral K α) :
    IsIntegral A α ↔
      ∀ i, (minpoly K α).coeff i ∈ (algebraMap A K).range := by
  constructor
  · intro hAα i
    rw [minpoly.isIntegrallyClosed_eq_field_fractions' (K := K) hAα]
    simp [Polynomial.coeff_map]
  · intro hcoeff
    have hlifts : minpoly K α ∈ Polynomial.lifts (algebraMap A K) := by
      rw [Polynomial.lifts_iff_coeff_lifts]
      exact fun n => RingHom.mem_range.mp (hcoeff n)
    obtain ⟨p, hp_map, -, hp_monic⟩ :=
      Polynomial.lifts_and_degree_eq_and_monic hlifts (minpoly.monic hα)
    refine ⟨p, hp_monic, ?_⟩
    have h1 : Polynomial.aeval (R := A) α p = Polynomial.aeval (R := K) α (minpoly K α) := by
      rw [← Polynomial.aeval_map_algebraMap K α p, hp_map]
    rw [minpoly.aeval] at h1
    exact_mod_cast h1

end SutherlandNumberTheoryLecture1.Chapter1
