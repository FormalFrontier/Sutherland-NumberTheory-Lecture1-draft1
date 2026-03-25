# References for Lecture1/01.14.Example

## Mathlib Coverage

**Status:** partially_covered

### `Localization.AtPrime`

- **Match type:** exact_match
- **Notes:** Localization at a prime ideal is available in Mathlib.RingTheory.Localization.AtPrime; Z_(p) as localization of Z at (p) is a standard construction

### `IsLocalization.AtPrime`

- **Match type:** related
- **Notes:** The typeclass for localization at a prime ideal

## External Dependencies

### `ext/ideal-theory`

- **Description:** Ideals (prime, maximal, principal), quotient rings, ideal generation
- **Category:** undergraduate_prerequisite
- **Mathlib coverage:** fully_covered
  - `Ideal` (exact_match): Mathlib.RingTheory.Ideal; prime ideals (Ideal.IsPrime), maximal ideals (Ideal.IsMaximal), principal ideals (Submodule.IsPrincipal), quotient rings (Ideal.Quotient) all fully covered

### `ext/integers`

- **Description:** The integer ring Z and its basic properties
- **Category:** undergraduate_prerequisite
- **Mathlib coverage:** fully_covered
  - `Int` (exact_match): The integer ring Z is extensively developed in Mathlib with EuclideanDomain, CommRing, IsDomain instances

### `ext/primes-and-divisibility`

- **Description:** Prime numbers, divisibility in Z, coprime integers
- **Category:** undergraduate_prerequisite
- **Mathlib coverage:** fully_covered
  - `Nat.Prime` (exact_match): Prime numbers, divisibility, coprimality (Nat.Coprime, Int.gcd) fully covered

### `ext/finite-fields`

- **Description:** Finite fields F_p and F_q, existence and uniqueness up to isomorphism
- **Category:** undergraduate_prerequisite
- **Mathlib coverage:** fully_covered
  - `ZMod` (exact_match): Z/pZ as ZMod p with Field instance when p is prime
  - `GaloisField` (exact_match): Finite fields F_q in Mathlib.FieldTheory.Finite.GaloisField

### `ext/localization`

- **Description:** Localization of a ring at a prime ideal
- **Category:** undergraduate_prerequisite
- **Mathlib coverage:** fully_covered
  - `Localization` (exact_match): Mathlib.RingTheory.Localization; localization at a multiplicative set, with Localization.AtPrime for localization at prime ideals
