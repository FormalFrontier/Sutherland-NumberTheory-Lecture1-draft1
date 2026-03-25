# References for Lecture1/01.04.Lemma

## Mathlib Coverage

**Status:** partially_covered

### `IsNonarchimedean.natCast_le_one`

- **Match type:** partial_match
- **Notes:** In Mathlib.Algebra.Order.Ring.IsNonarchimedean; proves f(n) <= 1 for nonarchimedean f. The converse direction (|n| <= 1 for all n implies nonarchimedean) would need to be proved

### `IsNonarchimedean.intCast_le_one`

- **Match type:** partial_match
- **Notes:** Extension to integer casts

## External Dependencies

### `ext/field`

- **Description:** Definition of a field and basic field theory (characteristic, prime fields, field extensions)
- **Category:** undergraduate_prerequisite
- **Mathlib coverage:** fully_covered
  - `Field` (exact_match): Class in Mathlib; fields, field extensions, characteristic, prime fields all extensively covered
