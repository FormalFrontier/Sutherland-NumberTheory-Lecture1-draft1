# References for Lecture1/01.07.Definition

## Mathlib Coverage

**Status:** fully_covered

### `padicValNat`

- **Match type:** exact_match
- **Notes:** Defined in Mathlib.NumberTheory.Padics.PadicVal.Defs; the p-adic valuation on natural numbers

### `padicValInt`

- **Match type:** exact_match
- **Notes:** Extension to integers

### `padicValRat`

- **Match type:** exact_match
- **Notes:** Extension to rationals

### `Rat.AbsoluteValue.padic`

- **Match type:** exact_match
- **Notes:** The p-adic absolute value on Q, defined in Mathlib.NumberTheory.Ostrowski

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

### `ext/fundamental-theorem-of-arithmetic`

- **Description:** Every nonzero integer has a unique prime factorization (up to units)
- **Category:** undergraduate_prerequisite
- **Mathlib coverage:** fully_covered
  - `Nat.instUniqueFactorizationMonoid` (exact_match): Nat is a UniqueFactorizationMonoid; unique factorization fully formalized
