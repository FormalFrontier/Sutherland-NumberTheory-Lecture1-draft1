# References for Lecture1/01.05.Corollary

## Mathlib Coverage

**Status:** partially_covered

### `IsNonarchimedean.natCast_le_one`

- **Match type:** related
- **Notes:** The forward direction (nonarchimedean => |n| <= 1) is available. The statement that positive characteristic implies nonarchimedean is not directly stated but follows from the characterization

## External Dependencies

### `ext/field`

- **Description:** Definition of a field and basic field theory (characteristic, prime fields, field extensions)
- **Category:** undergraduate_prerequisite
- **Mathlib coverage:** fully_covered
  - `Field` (exact_match): Class in Mathlib; fields, field extensions, characteristic, prime fields all extensively covered

### `ext/finite-fields`

- **Description:** Finite fields F_p and F_q, existence and uniqueness up to isomorphism
- **Category:** undergraduate_prerequisite
- **Mathlib coverage:** fully_covered
  - `ZMod` (exact_match): Z/pZ as ZMod p with Field instance when p is prime
  - `GaloisField` (exact_match): Finite fields F_q in Mathlib.FieldTheory.Finite.GaloisField
