import Mathlib.RingTheory.DiscreteValuationRing.Basic
import Mathlib.RingTheory.LocalRing.ResidueField.Defs
import Mathlib.RingTheory.DedekindDomain.Dvr
import Mathlib.RingTheory.Int.Basic
import Mathlib.Data.ZMod.QuotientRing

/-!
# Example 1.14: Z_(p) as a DVR

**Example 1.14.** For the p-adic valuation v_p : ℚ → ℤ ∪ {∞} we have the valuation ring

  ℤ_(p) := {a/b : a, b ∈ ℤ, p ∤ b},

with maximal ideal 𝔪 = (p); this is the *localization* of the ring ℤ at the prime
ideal (p). The residue field is ℤ_(p)/pℤ_(p) ≅ ℤ/pℤ ≅ 𝔽_p.

In Mathlib, `Localization.AtPrime (Ideal.span {(p : ℤ)})` gives ℤ_(p).
The result follows directly from `IsLocalization.AtPrime.isDiscreteValuationRing_of_dedekind_domain`
since ℤ is a Dedekind domain.
-/

namespace SutherlandNumberTheoryLecture1.Chapter1

/-- Example 1.14: The localization ℤ_(p) is a DVR.
For a prime p, the localization of ℤ at the prime ideal (p) is a discrete
valuation ring with maximal ideal (p) and residue field 𝔽_p.

This delegates to Mathlib's `IsLocalization.AtPrime.isDiscreteValuationRing_of_dedekind_domain`,
which establishes the result for any Dedekind domain localized at a nonzero prime. -/
theorem localization_at_prime_is_dvr (p : ℕ) [hp : Fact (Nat.Prime p)]
    (I : Ideal ℤ) [I.IsPrime] (hI : I = Ideal.span {(p : ℤ)}) :
    IsDiscreteValuationRing (Localization.AtPrime I) := by
  have hI_ne_bot : I ≠ ⊥ := by
    rw [hI, ne_eq, Ideal.span_singleton_eq_bot]
    exact mod_cast hp.out.ne_zero
  exact IsLocalization.AtPrime.isDiscreteValuationRing_of_dedekind_domain ℤ hI_ne_bot _

/-- The residue field of ℤ_(p) is isomorphic to ℤ/pℤ. -/
theorem localization_at_prime_residue_field (p : ℕ) [hp : Fact (Nat.Prime p)]
    (I : Ideal ℤ) [I.IsPrime] (hI : I = Ideal.span {(p : ℤ)}) :
    Nonempty (IsLocalRing.ResidueField (Localization.AtPrime I) ≃+* ZMod p) := by
  subst hI
  haveI : (Ideal.span {(p : ℤ)}).IsMaximal :=
    Ideal.IsPrime.isMaximal inferInstance (by
      rw [ne_eq, Ideal.span_singleton_eq_bot]
      exact mod_cast hp.out.ne_zero)
  exact ⟨(IsLocalization.AtPrime.equivQuotMaximalIdeal
    (Ideal.span {(p : ℤ)}) (Localization.AtPrime _)).symm.trans
    (Int.quotientSpanNatEquivZMod p)⟩

end SutherlandNumberTheoryLecture1.Chapter1
