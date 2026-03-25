# References for Lecture1/01.10.Definition

## Mathlib Coverage

**Status:** partially_covered

### `Valuation`

- **Match type:** partial_match
- **Notes:** Structure in Mathlib.RingTheory.Valuation.Basic; defined as a monoid hom to a linearly ordered commutative monoid with zero, satisfying v(x+y) >= min(v(x),v(y)). Uses multiplicative convention rather than additive

### `AddValuation`

- **Match type:** partial_match
- **Notes:** Additive version available in same file; closer to the textbook's additive convention

### `IsDiscreteValuationRing`

- **Match type:** partial_match
- **Notes:** Defined in Mathlib.RingTheory.DiscreteValuationRing.Basic as local PID that is not a field

### `ValuationRing`

- **Match type:** related
- **Notes:** Class in Mathlib.RingTheory.Valuation.ValuationRing; integral domain where for every x in Frac(A), either x or x^{-1} is in A

## External Dependencies

### `ext/field`

- **Description:** Definition of a field and basic field theory (characteristic, prime fields, field extensions)
- **Category:** undergraduate_prerequisite
- **Mathlib coverage:** fully_covered
  - `Field` (exact_match): Class in Mathlib; fields, field extensions, characteristic, prime fields all extensively covered

### `ext/ring`

- **Description:** Definition of a commutative ring with identity, ring homomorphisms, ring extensions
- **Category:** undergraduate_prerequisite
- **Mathlib coverage:** fully_covered
  - `CommRing` (exact_match): Class in Mathlib; commutative rings with identity, ring homomorphisms fully covered

### `ext/integral-domain`

- **Description:** Definition of an integral domain
- **Category:** undergraduate_prerequisite
- **Mathlib coverage:** fully_covered
  - `IsDomain` (exact_match): Class in Mathlib combining NoZeroDivisors and Nontrivial

### `ext/ideal-theory`

- **Description:** Ideals (prime, maximal, principal), quotient rings, ideal generation
- **Category:** undergraduate_prerequisite
- **Mathlib coverage:** fully_covered
  - `Ideal` (exact_match): Mathlib.RingTheory.Ideal; prime ideals (Ideal.IsPrime), maximal ideals (Ideal.IsMaximal), principal ideals (Submodule.IsPrincipal), quotient rings (Ideal.Quotient) all fully covered

### `ext/real-numbers`

- **Description:** The real numbers R, R_{>=0}, R_{>0}, and the standard ordering on R
- **Category:** undergraduate_prerequisite
- **Mathlib coverage:** fully_covered
  - `Real` (exact_match): Mathlib.Topology.Instances.Real and related; R, R_{>=0} (NNReal), R_{>0} all available with full ordering

### `ext/fraction-field`

- **Description:** Fraction field (field of fractions) of an integral domain
- **Category:** undergraduate_prerequisite
- **Mathlib coverage:** fully_covered
  - `FractionRing` (exact_match): Mathlib.RingTheory.Localization.FractionRing; fraction field of an integral domain with IsFractionRing typeclass

### `ext/group-homomorphism`

- **Description:** Group homomorphisms (used for valuations as homomorphisms k* -> R)
- **Category:** undergraduate_prerequisite
- **Mathlib coverage:** fully_covered
  - `MonoidHom` (exact_match): Group/monoid homomorphisms fully covered in Mathlib

### `ext/discrete-subgroups-of-R`

- **Description:** Every discrete subgroup of R is isomorphic to Z
- **Category:** folklore
- **Mathlib coverage:** not_covered
