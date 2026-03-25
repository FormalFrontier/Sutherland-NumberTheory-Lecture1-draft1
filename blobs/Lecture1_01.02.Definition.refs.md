# References for Lecture1/01.02.Definition

## Mathlib Coverage

**Status:** fully_covered

### `AbsoluteValue`

- **Match type:** exact_match
- **Notes:** Structure in Mathlib.Algebra.Order.AbsoluteValue.Basic; encodes map R -> S with multiplicativity, positivity, and triangle inequality

### `IsNonarchimedean`

- **Match type:** exact_match
- **Notes:** Defined in Mathlib.Algebra.Order.Ring.Basic as f(a+b) <= f(a) ⊔ f(b); used throughout Mathlib for the ultrametric property

## External Dependencies

### `ext/field`

- **Description:** Definition of a field and basic field theory (characteristic, prime fields, field extensions)
- **Category:** undergraduate_prerequisite
- **Mathlib coverage:** fully_covered
  - `Field` (exact_match): Class in Mathlib; fields, field extensions, characteristic, prime fields all extensively covered

### `ext/real-numbers`

- **Description:** The real numbers R, R_{>=0}, R_{>0}, and the standard ordering on R
- **Category:** undergraduate_prerequisite
- **Mathlib coverage:** fully_covered
  - `Real` (exact_match): Mathlib.Topology.Instances.Real and related; R, R_{>=0} (NNReal), R_{>0} all available with full ordering

### `ext/triangle-inequality`

- **Description:** The triangle inequality for real-valued functions
- **Category:** undergraduate_prerequisite
- **Mathlib coverage:** fully_covered
  - `AbsoluteValue.add_le` (exact_match): Built into the AbsoluteValue structure as an axiom
