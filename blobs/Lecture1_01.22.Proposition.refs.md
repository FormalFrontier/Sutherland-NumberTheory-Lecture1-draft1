# References for Lecture1/01.22.Proposition

## Mathlib Coverage

**Status:** fully_covered

### `UniqueFactorizationMonoid.instIsIntegrallyClosed`

- **Match type:** exact_match
- **Notes:** In Mathlib.RingTheory.Polynomial.RationalRoot; every UFD is integrally closed. Since Z is a UFD (via EuclideanDomain), Z is integrally closed as a special case

### `Int.euclideanDomain`

- **Match type:** related
- **Notes:** Z is a Euclidean domain (hence PID, hence UFD, hence integrally closed)

## External Dependencies

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

### `ext/primes-and-divisibility`

- **Description:** Prime numbers, divisibility in Z, coprime integers
- **Category:** undergraduate_prerequisite
- **Mathlib coverage:** fully_covered
  - `Nat.Prime` (exact_match): Prime numbers, divisibility, coprimality (Nat.Coprime, Int.gcd) fully covered

### `ext/polynomial-ring`

- **Description:** Polynomial rings A[x], monic polynomials, irreducible polynomials, minimal polynomials
- **Category:** undergraduate_prerequisite
- **Mathlib coverage:** fully_covered
  - `Polynomial` (exact_match): Mathlib.Algebra.Polynomial; polynomial rings, monic polynomials (Polynomial.Monic), irreducible polynomials, minimal polynomials (minpoly) all fully covered

### `ext/rational-root-test`

- **Description:** If r/s in lowest terms is a root of a monic polynomial in Z[x], then s = +-1
- **Category:** external_result
- **Mathlib coverage:** fully_covered
  - `num_dvd_of_is_root` (exact_match): In Mathlib.RingTheory.Polynomial.RationalRoot; if x/y is a root, then y divides the leading coefficient and x divides the constant term
  - `den_dvd_of_is_root` (exact_match): Companion to num_dvd_of_is_root
  - `isInteger_of_is_root_of_monic` (exact_match): Integral root theorem: roots of monic polynomials over UFDs are integers
