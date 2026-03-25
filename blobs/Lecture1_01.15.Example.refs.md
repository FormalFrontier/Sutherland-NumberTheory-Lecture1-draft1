# References for Lecture1/01.15.Example

## Mathlib Coverage

**Status:** partially_covered

### `PowerSeries`

- **Match type:** partial_match
- **Notes:** Defined in Mathlib.RingTheory.PowerSeries.Basic; the power series ring k[[t]]

### `LaurentSeries`

- **Match type:** partial_match
- **Notes:** Defined as HahnSeries (abbreviation) in Mathlib.RingTheory.LaurentSeries; the Laurent series field k((t))

### `HahnSeries.addVal`

- **Match type:** related
- **Notes:** Additive valuation on Hahn series; related to the order-of-vanishing valuation

## External Dependencies

### `ext/field`

- **Description:** Definition of a field and basic field theory (characteristic, prime fields, field extensions)
- **Category:** undergraduate_prerequisite
- **Mathlib coverage:** fully_covered
  - `Field` (exact_match): Class in Mathlib; fields, field extensions, characteristic, prime fields all extensively covered

### `ext/power-series-and-laurent-series`

- **Description:** Power series ring k[[t]] and Laurent series field k((t))
- **Category:** undergraduate_prerequisite
- **Mathlib coverage:** fully_covered
  - `PowerSeries` (exact_match): Mathlib.RingTheory.PowerSeries; formal power series ring k[[t]]
  - `LaurentSeries` (exact_match): Defined via HahnSeries in Mathlib.RingTheory.LaurentSeries; Laurent series field k((t))
