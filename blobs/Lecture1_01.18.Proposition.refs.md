# References for Lecture1/01.18.Proposition

## Mathlib Coverage

**Status:** fully_covered

### `IsIntegral.add`

- **Match type:** exact_match
- **Notes:** In Mathlib.RingTheory.IntegralClosure.Algebra.Basic; sum of integral elements is integral

### `IsIntegral.mul`

- **Match type:** exact_match
- **Notes:** In same file; product of integral elements is integral

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

### `ext/algebraic-closure`

- **Description:** Existence of algebraic closure of a field, field embeddings
- **Category:** undergraduate_prerequisite
- **Mathlib coverage:** fully_covered
  - `AlgebraicClosure` (exact_match): Mathlib.FieldTheory.IsAlgClosed.AlgebraicClosure; existence of algebraic closure, field embeddings
  - `IsAlgClosed` (exact_match): Typeclass for algebraically closed fields

### `ext/symmetric-polynomials`

- **Description:** Symmetric functions of roots: coefficients of a polynomial are symmetric functions of its roots
- **Category:** undergraduate_prerequisite
- **Mathlib coverage:** partially_covered
  - `MvPolynomial.IsSymmetric` (partial_match): Symmetric polynomials exist in Mathlib.RingTheory.MvPolynomial.Symmetric; fundamental theorem of symmetric polynomials is available. The specific fact about coefficients as symmetric functions of roots may need assembly
  - `Polynomial.roots` (related): Multiset of roots; Vieta's formulas connecting roots to coefficients
