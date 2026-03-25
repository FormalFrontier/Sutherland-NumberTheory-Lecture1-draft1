import Mathlib.RingTheory.Valuation.Basic
import Mathlib.RingTheory.DiscreteValuationRing.Basic
import Mathlib.RingTheory.Valuation.ValuationRing

/-!
# Definition 1.10: Valuations and Discrete Valuation Rings

**Definition 1.10.** A *valuation* on a field k is a group homomorphism v : k× → ℝ
such that v(x + y) ≥ min(v(x), v(y)). We extend v to k → ℝ ∪ {∞} by defining
v(0) := ∞. The image of v in ℝ is the *value group*. A *discrete valuation* has
value group equal to ℤ. The *valuation ring* A = {x ∈ k : v(x) ≥ 0} of a discrete
valuation is a *discrete valuation ring* (DVR).

Mathlib's `Valuation` uses a multiplicative convention; `AddValuation` uses the
additive convention closer to the textbook. `IsDiscreteValuationRing` is defined
as a local PID that is not a field.
-/

namespace SutherlandNumberTheoryLecture1.Chapter1

/-- Definition 1.10: A valuation on a field k in the additive convention is
captured by Mathlib's `AddValuation`. -/
def valuation_def (k : Type*) [Field k] (Γ : Type*) [LinearOrderedAddCommGroupWithTop Γ] :=
  AddValuation k Γ

/-- A discrete valuation ring is a local PID that is not a field.
This is `IsDiscreteValuationRing` in Mathlib. -/
def dvr_def (A : Type*) [CommRing A] [IsDomain A] :=
  IsDiscreteValuationRing A

/-- The valuation ring of a valued field: {x ∈ k : v(x) ≥ 0}. The typeclass
`ValuationRing` in Mathlib captures the abstract property that for every x in
Frac(A), either x ∈ A or x⁻¹ ∈ A. -/
def valuationRing_of_field (A : Type*) [CommRing A] [IsDomain A] :=
  ValuationRing A

end SutherlandNumberTheoryLecture1.Chapter1
