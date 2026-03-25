# References for Lecture1/01.19.Definition

## Mathlib Coverage

**Status:** fully_covered

### `integralClosure`

- **Match type:** exact_match
- **Notes:** Defined in Mathlib.RingTheory.IntegralClosure.Algebra.Basic; the subalgebra of B consisting of elements integral over R

### `IsIntegrallyClosed`

- **Match type:** exact_match
- **Notes:** In Mathlib.RingTheory.IntegralClosure.IntegrallyClosed; R is integrally closed if it contains all integral elements of Frac(R)

### `IsIntegrallyClosedIn`

- **Match type:** exact_match
- **Notes:** More general version: R is integrally closed in A

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

### `ext/fraction-field`

- **Description:** Fraction field (field of fractions) of an integral domain
- **Category:** undergraduate_prerequisite
- **Mathlib coverage:** fully_covered
  - `FractionRing` (exact_match): Mathlib.RingTheory.Localization.FractionRing; fraction field of an integral domain with IsFractionRing typeclass
