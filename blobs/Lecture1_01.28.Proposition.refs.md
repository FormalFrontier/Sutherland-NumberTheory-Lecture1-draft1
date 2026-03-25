# References for Lecture1/01.28.Proposition

## Mathlib Coverage

**Status:** fully_covered

### `minpoly.isIntegrallyClosed_eq_field_fractions`

- **Match type:** exact_match
- **Notes:** In Mathlib.FieldTheory.Minpoly.IsIntegrallyClosed; for integrally closed R, the minimal polynomial over R equals the minimal polynomial over Frac(R). This implies the minimal poly of an integral element has coefficients in A

### `IsIntegrallyClosed.Minpoly.unique`

- **Match type:** related
- **Notes:** Uniqueness characterization of minimal polynomials over integrally closed domains

## External Dependencies

### `ext/integral-domain`

- **Description:** Definition of an integral domain
- **Category:** undergraduate_prerequisite
- **Mathlib coverage:** fully_covered
  - `IsDomain` (exact_match): Class in Mathlib combining NoZeroDivisors and Nontrivial

### `ext/polynomial-ring`

- **Description:** Polynomial rings A[x], monic polynomials, irreducible polynomials, minimal polynomials
- **Category:** undergraduate_prerequisite
- **Mathlib coverage:** fully_covered
  - `Polynomial` (exact_match): Mathlib.Algebra.Polynomial; polynomial rings, monic polynomials (Polynomial.Monic), irreducible polynomials, minimal polynomials (minpoly) all fully covered

### `ext/fraction-field`

- **Description:** Fraction field (field of fractions) of an integral domain
- **Category:** undergraduate_prerequisite
- **Mathlib coverage:** fully_covered
  - `FractionRing` (exact_match): Mathlib.RingTheory.Localization.FractionRing; fraction field of an integral domain with IsFractionRing typeclass

### `ext/algebraic-closure`

- **Description:** Existence of algebraic closure of a field, field embeddings
- **Category:** undergraduate_prerequisite
- **Mathlib coverage:** fully_covered
  - `AlgebraicClosure` (exact_match): Mathlib.FieldTheory.IsAlgClosed.AlgebraicClosure; existence of algebraic closure, field embeddings
  - `IsAlgClosed` (exact_match): Typeclass for algebraically closed fields

### `ext/field-extensions`

- **Description:** Finite field extensions, algebraic extensions, degree of extension
- **Category:** undergraduate_prerequisite
- **Mathlib coverage:** fully_covered
  - `FiniteDimensional` (exact_match): Finite-dimensional algebras/modules; used for finite field extensions
  - `IntermediateField` (exact_match): Mathlib.FieldTheory.IntermediateField; intermediate fields in extensions
  - `Module.finrank` (exact_match): Degree of extension as finrank
