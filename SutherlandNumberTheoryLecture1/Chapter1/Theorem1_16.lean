import Mathlib.RingTheory.DiscreteValuationRing.TFAE
import Mathlib.RingTheory.Valuation.ValuationRing
import Mathlib.RingTheory.DedekindDomain.Basic
import Mathlib.LinearAlgebra.Dimension.Finrank

/-!
# Theorem 1.16: Equivalent Characterizations of DVRs

**Theorem 1.16.** For an integral domain A, the following are equivalent:
- A is a DVR.
- A is a noetherian valuation ring that is not a field.
- A is a local PID that is not a field.
- A is an integrally closed noetherian local ring of dimension one.
- A is a regular noetherian local ring of dimension one.
- A is a noetherian local ring whose maximal ideal is nonzero and principal.
- A is a Dedekind domain that is not a field.

Proof. See [1, §23] or [2, §9]. □

The proof uses Mathlib's `IsDiscreteValuationRing.TFAE` as a stepping stone: each
condition implies the preconditions `[IsNoetherianRing A] [IsLocalRing A] (¬IsField A)`,
at which point the Mathlib equivalences apply.

Condition 7 of the PDF ("A is a maximal noetherian ring of dimension one") is
formalized as `IsDedekindDomain A ∧ IsLocalRing A ∧ ¬IsField A`. In classical
commutative algebra, "maximal" refers to a maximal order (i.e., integrally closed),
and a noetherian integrally closed domain of dimension one is a Dedekind domain.
The locality constraint is needed for equivalence with DVR.

Condition 5 ("regular noetherian local ring of dimension one") is formalized using
the property that every nonzero ideal is a power of a maximal ideal, which for
local rings of dimension one is equivalent to regularity.
-/

open IsLocalRing

namespace SutherlandNumberTheoryLecture1.Chapter1

/-- Theorem 1.16: Equivalent characterizations of DVRs.

For an integral domain A, the following are equivalent:
0. A is a DVR
1. A is a noetherian valuation ring that is not a field
2. A is a local PID that is not a field
3. A is an integrally closed noetherian local ring of dimension one
4. A is a regular noetherian local ring of dimension one
5. A is a noetherian local ring whose maximal ideal is nonzero and principal
6. A is a Dedekind domain that is not a field -/
theorem dvr_tfae (A : Type*) [CommRing A] [IsDomain A] :
    List.TFAE [
      IsDiscreteValuationRing A,
      IsNoetherianRing A ∧ ValuationRing A ∧ ¬IsField A,
      IsLocalRing A ∧ IsPrincipalIdealRing A ∧ ¬IsField A,
      IsIntegrallyClosed A ∧ IsNoetherianRing A ∧ IsLocalRing A ∧
        ∃! P : Ideal A, P ≠ ⊥ ∧ P.IsPrime,
      IsNoetherianRing A ∧ IsLocalRing A ∧ ¬IsField A ∧
        ∀ I : Ideal A, I ≠ ⊥ → ∃ (m : Ideal A) (n : ℕ), m.IsMaximal ∧ I = m ^ n,
      IsNoetherianRing A ∧ IsLocalRing A ∧
        ∃ m : Ideal A, m.IsMaximal ∧ m ≠ ⊥ ∧ m.IsPrincipal,
      IsDedekindDomain A ∧ IsLocalRing A ∧ ¬IsField A
    ] := by
  -- 1 → 2
  tfae_have 1 → 2
  | h => ⟨inferInstance, inferInstance, h.not_isField⟩
  -- 2 → 1
  tfae_have 2 → 1
  | ⟨hN, hV, hF⟩ => by
    haveI := hN; haveI := hV
    haveI : IsLocalRing A := inferInstance
    have hF' : ¬IsField A := hF
    exact ((IsDiscreteValuationRing.TFAE A hF').out 1 0).mp hV
  -- 1 → 3
  tfae_have 1 → 3
  | h => ⟨inferInstance, inferInstance, h.not_isField⟩
  -- 3 → 1
  tfae_have 3 → 1
  | ⟨hL, hP, hF⟩ => by
    haveI := hL; haveI := hP
    exact { not_a_field' := isField_iff_maximalIdeal_eq.not.mp hF }
  -- 1 → 4
  tfae_have 1 → 4
  | h => by
    haveI := h
    refine ⟨inferInstance, inferInstance, inferInstance, ?_⟩
    have hF := h.not_isField
    have h_tfae := IsDiscreteValuationRing.TFAE A hF
    have h03 : IsIntegrallyClosed A ∧ ∃! P : Ideal A, P ≠ ⊥ ∧ P.IsPrime :=
      (h_tfae.out 0 3).mp h
    exact h03.2
  -- 4 → 1
  tfae_have 4 → 1
  | ⟨hIC, hN, hL, huniq⟩ => by
    haveI := hIC; haveI := hN; haveI := hL
    have ⟨P, ⟨hPbot, hPprime⟩, _⟩ := huniq
    have hF : ¬IsField A := fun hF =>
      hPbot (le_bot_iff.mp ((le_maximalIdeal hPprime.ne_top).trans
        (isField_iff_maximalIdeal_eq.mp hF).le))
    exact ((IsDiscreteValuationRing.TFAE A hF).out 3 0).mp
      (show IsIntegrallyClosed A ∧ ∃! P : Ideal A, P ≠ ⊥ ∧ P.IsPrime from ⟨hIC, huniq⟩)
  -- 1 → 5
  tfae_have 1 → 5
  | h => by
    haveI := h
    have hF := h.not_isField
    refine ⟨inferInstance, inferInstance, hF, ?_⟩
    have h6 := ((IsDiscreteValuationRing.TFAE A hF).out 0 6).mp h
    intro I hI
    obtain ⟨n, hn⟩ := h6 I hI
    exact ⟨maximalIdeal A, n, maximalIdeal.isMaximal A, hn⟩
  -- 5 → 1
  tfae_have 5 → 1
  | ⟨hN, hL, hF, hall⟩ => by
    haveI := hN; haveI := hL
    have h6 : ∀ I : Ideal A, I ≠ ⊥ → ∃ n : ℕ, I = maximalIdeal A ^ n := by
      intro I hI
      obtain ⟨m, n, hm, hIn⟩ := hall I hI
      rw [eq_maximalIdeal hm] at hIn
      exact ⟨n, hIn⟩
    exact ((IsDiscreteValuationRing.TFAE A hF).out 6 0).mp h6
  -- 1 → 6
  tfae_have 1 → 6
  | h => by
    haveI := h
    have hF := h.not_isField
    refine ⟨inferInstance, inferInstance, maximalIdeal A, maximalIdeal.isMaximal A,
      IsDiscreteValuationRing.not_a_field A, ?_⟩
    exact ((IsDiscreteValuationRing.TFAE A hF).out 0 4).mp h
  -- 6 → 1
  tfae_have 6 → 1
  | ⟨hN, hL, m, hmax, hne, hprinc⟩ => by
    haveI := hN; haveI := hL
    have hm_eq : m = maximalIdeal A := eq_maximalIdeal hmax
    subst hm_eq
    have hF : ¬IsField A := isField_iff_maximalIdeal_eq.not.mpr hne
    exact ((IsDiscreteValuationRing.TFAE A hF).out 4 0).mp hprinc
  -- 1 → 7
  tfae_have 1 → 7
  | h => by
    haveI := h
    exact ⟨inferInstance, inferInstance, h.not_isField⟩
  -- 7 → 1
  tfae_have 7 → 1
  | ⟨hD, hL, hF⟩ => by
    haveI := hD; haveI := hL
    exact { not_a_field' := isField_iff_maximalIdeal_eq.not.mp hF }
  tfae_finish

end SutherlandNumberTheoryLecture1.Chapter1
