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
- A is a maximal noetherian ring of dimension one.

Proof. See [1, §23] or [2, §9]. □

In Mathlib, this is `IsDiscreteValuationRing.TFAE` (for Noetherian local domains
that are not fields) and `tfae_of_isNoetherianRing_of_isLocalRing_of_isDomain`.
-/

open Module

namespace SutherlandNumberTheoryLecture1.Chapter1

/-- Theorem 1.16: Equivalent characterizations of DVRs.
A Noetherian local domain that is not a field is a DVR if and only if it
satisfies any of the equivalent conditions in `IsDiscreteValuationRing.TFAE`.

The TFAE list matches Mathlib's `IsDiscreteValuationRing.TFAE`:
0. `A` is a DVR
1. `A` is a valuation ring
2. `A` is a Dedekind domain
3. `A` is integrally closed with a unique nonzero prime ideal
4. The maximal ideal is principal
5. `dimₖ m/m² = 1`
6. Every nonzero ideal is a power of the maximal ideal -/
theorem dvr_tfae (A : Type*) [CommRing A] [IsDomain A]
    [IsNoetherianRing A] [IsLocalRing A] (hA : ¬IsField A) :
    List.TFAE [
      IsDiscreteValuationRing A,
      ValuationRing A,
      IsDedekindDomain A,
      IsIntegrallyClosed A ∧ ∃! P : Ideal A, P ≠ ⊥ ∧ P.IsPrime,
      (IsLocalRing.maximalIdeal A).IsPrincipal,
      finrank (IsLocalRing.ResidueField A) (IsLocalRing.CotangentSpace A) = 1,
      ∀ (I : Ideal A), I ≠ ⊥ → ∃ n : ℕ, I = IsLocalRing.maximalIdeal A ^ n
    ] :=
  IsDiscreteValuationRing.TFAE A hA

end SutherlandNumberTheoryLecture1.Chapter1
