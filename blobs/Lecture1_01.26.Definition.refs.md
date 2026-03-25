# References for Lecture1/01.02.Definition6

## Mathlib Coverage

**Status:** fully_covered

### `NumberField`

- **Match type:** exact_match
- **Notes:** Class in Mathlib.NumberTheory.NumberField.Basic; a field K that is a finite extension of Q

### `NumberField.RingOfIntegers`

- **Match type:** exact_match
- **Notes:** Notation 𝓞 K; the integral closure of Z in K

## External Dependencies

### `ext/field`

- **Description:** Definition of a field and basic field theory (characteristic, prime fields, field extensions)
- **Category:** undergraduate_prerequisite
- **Mathlib coverage:** fully_covered
  - `Field` (exact_match): Class in Mathlib; fields, field extensions, characteristic, prime fields all extensively covered

### `ext/integers`

- **Description:** The integer ring Z and its basic properties
- **Category:** undergraduate_prerequisite
- **Mathlib coverage:** fully_covered
  - `Int` (exact_match): The integer ring Z is extensively developed in Mathlib with EuclideanDomain, CommRing, IsDomain instances

### `ext/rationals`

- **Description:** The field Q of rational numbers as fraction field of Z
- **Category:** undergraduate_prerequisite
- **Mathlib coverage:** fully_covered
  - `Rat` (exact_match): The rationals Q with Field instance; IsFractionRing Int Rat available

### `ext/field-extensions`

- **Description:** Finite field extensions, algebraic extensions, degree of extension
- **Category:** undergraduate_prerequisite
- **Mathlib coverage:** fully_covered
  - `FiniteDimensional` (exact_match): Finite-dimensional algebras/modules; used for finite field extensions
  - `IntermediateField` (exact_match): Mathlib.FieldTheory.IntermediateField; intermediate fields in extensions
  - `Module.finrank` (exact_match): Degree of extension as finrank
