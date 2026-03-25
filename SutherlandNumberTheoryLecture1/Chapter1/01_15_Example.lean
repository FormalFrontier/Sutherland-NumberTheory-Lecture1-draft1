import Mathlib.RingTheory.PowerSeries.Basic
import Mathlib.RingTheory.LaurentSeries
import Mathlib.RingTheory.DiscreteValuationRing.Basic
import Mathlib.RingTheory.HahnSeries.Valuation
import Mathlib.RingTheory.PowerSeries.Inverse

/-!
# Example 1.15: Power Series Ring as a DVR

**Example 1.15.** For any field k, the valuation v : k((t)) → ℤ ∪ {∞} on the
field of Laurent series over k defined by

  v(∑_{n ≥ n₀} aₙtⁿ) = n₀,

where a_{n₀} ≠ 0, has valuation ring k[[t]], the power series ring over k.
For f ∈ k((t))×, the valuation v(f) ∈ ℤ is the *order of vanishing* of f at zero.

In Mathlib, `PowerSeries k` is k[[t]] and `LaurentSeries k` is k((t)).
The additive valuation is related to `HahnSeries.addVal`.
-/

namespace SutherlandNumberTheoryLecture1.Chapter1

/-- Example 1.15: The power series ring k[[t]] is a DVR for any field k. -/
theorem powerSeries_is_dvr (k : Type*) [Field k] :
    IsDiscreteValuationRing (PowerSeries k) :=
  inferInstance

/-- The order-of-vanishing valuation on k((t)) has valuation ring k[[t]]. -/
theorem laurentSeries_valuation_ring (k : Type*) [Field k] :
    ValuationRing (PowerSeries k) :=
  inferInstance

end SutherlandNumberTheoryLecture1.Chapter1
