# References for Lecture1/01.17.Definition

## Mathlib Coverage

**Status:** fully_covered

### `IsIntegral`

- **Match type:** exact_match
- **Notes:** Defined in Mathlib.RingTheory.IntegralClosure; an element b is integral over A if it is a root of a monic polynomial in A[x]

### `Algebra.IsIntegral`

- **Match type:** exact_match
- **Notes:** Class in Mathlib.RingTheory.IntegralClosure.Algebra.Defs; B is integral over A if every element is integral

## External Dependencies

### `ext/ring`

- **Description:** Definition of a commutative ring with identity, ring homomorphisms, ring extensions
- **Category:** undergraduate_prerequisite
- **Mathlib coverage:** fully_covered
  - `CommRing` (exact_match): Class in Mathlib; commutative rings with identity, ring homomorphisms fully covered

### `ext/polynomial-ring`

- **Description:** Polynomial rings A[x], monic polynomials, irreducible polynomials, minimal polynomials
- **Category:** undergraduate_prerequisite
- **Mathlib coverage:** fully_covered
  - `Polynomial` (exact_match): Mathlib.Algebra.Polynomial; polynomial rings, monic polynomials (Polynomial.Monic), irreducible polynomials, minimal polynomials (minpoly) all fully covered
