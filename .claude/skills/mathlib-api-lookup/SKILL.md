---
name: mathlib-api-lookup
description: Use when searching for Mathlib declarations to fill a proof, when imports fail, when you need to find the right Mathlib module for a concept, or when exact? or apply? don't find what you need.
allowed-tools: Read, Bash, Glob, Grep
---

# Mathlib API Lookup for FormalFrontier

This skill captures strategies for finding the right Mathlib declarations when formalizing proofs.

## Step 1: Check the .refs.md File First

Every formalization item has a reference file at `blobs/<ItemID>.refs.md` that was created during Stage 2.7 (Reference Attachment). This file maps the item to specific Mathlib declarations.

```bash
cat blobs/Lecture1_Theorem1.8.refs.md
```

If the .refs.md file exists and names a Mathlib declaration, that's your starting point. Verify it exists:

```bash
cd lean && lake env lean -c "import Mathlib; #check @Rat.AbsoluteValue.equiv_real_or_padic"
```

## Step 2: Search by Concept Name

Mathlib follows naming conventions. Common patterns for this project:

| Math concept | Mathlib search terms |
|-------------|---------------------|
| Absolute value | `AbsoluteValue`, `IsAbsoluteValue` |
| p-adic valuation | `padicValRat`, `padicNorm`, `Padic` |
| Nonarchimedean | `IsNonarchimedean` |
| DVR | `IsDiscreteValuationRing`, `DiscreteValuationRing` |
| Valuation ring | `ValuationRing`, `Valuation.Integers` |
| Integrally closed | `IsIntegrallyClosed` |
| Integral element | `IsIntegral`, `Algebra.IsIntegral` |
| Integral closure | `integralClosure`, `IntegralClosure` |
| UFD | `UniqueFactorizationMonoid`, `UniqueFactorizationDomain` |
| PID | `IsPrincipalIdealRing` |
| Localization | `Localization`, `IsLocalization`, `Localization.AtPrime` |
| Number field | `NumberField`, `NumberField.RingOfIntegers` |
| Minimal polynomial | `minpoly` |
| Ostrowski | `Rat.AbsoluteValue.equiv_real_or_padic` |
| Frobenius | `frobenius`, `frobenius_def` |
| Fraction ring | `FractionRing`, `IsFractionRing` |

Search Mathlib source files:

```bash
# Search declaration names
grep -r "theorem.*IsIntegrallyClosed" .lake/packages/mathlib/Mathlib/ --include="*.lean" -l | head -10

# Search for a specific API
grep -r "isDiscreteValuationRing_of_dedekind" .lake/packages/mathlib/Mathlib/ --include="*.lean" | head -5
```

## Step 3: Use Lean's Search Tactics

In a scratch Lean file or within the proof:

```lean
-- Find exact matches for the current goal
example : IsIntegrallyClosed Z := by exact?

-- Find lemmas that could apply
example : IsIntegrallyClosed Z := by apply?

-- Search by name pattern (in #check)
#check IsIntegrallyClosed
#check @UniqueFactorizationMonoid.instIsIntegrallyClosed
```

**Important**: `exact?` and `apply?` can be slow (30+ seconds). Use them sparingly and only after checking .refs.md and grepping Mathlib source.

## Step 4: Navigate Import Chains

When you find the right declaration but the import is wrong:

```bash
# Find which file declares something
grep -r "^theorem IsLocalization.AtPrime.isDiscreteValuationRing" .lake/packages/mathlib/Mathlib/ --include="*.lean"

# The file path maps to the import:
# Mathlib/RingTheory/DedekindDomain/Dvr.lean => import Mathlib.RingTheory.DedekindDomain.Dvr
```

### Import Minimization

Don't import all of Mathlib. Import only what you need:

```lean
-- Bad: pulls in everything
import Mathlib

-- Good: specific imports
import Mathlib.RingTheory.IntegralClosure.IntegrallyClosed
import Mathlib.RingTheory.Polynomial.RationalRoot
```

Check existing project files for import patterns — they're already minimized.

## Step 5: Instance Chain Discovery

When `inferInstance` doesn't work, trace the instance chain:

```lean
-- See what instances exist
#check (inferInstance : IsIntegrallyClosed Z)  -- works if chain exists
#check (inferInstance : UniqueFactorizationMonoid Z)  -- check intermediate step
```

Common instance chains in this project:
- `EuclideanDomain => PID => UFD => IsIntegrallyClosed` (for Z, polynomial rings)
- `Field => IsDomain => ...` (basic algebra)
- `IsDiscreteValuationRing => IsLocalRing` (DVR properties)
- `ValuationRing => IsIntegrallyClosed` (via `ValuationRing.equivInteger`)

If the chain is broken, you may need `haveI` to introduce a missing instance:

```lean
haveI : Fact (Nat.Prime p) := ⟨hprime⟩
haveI : (Ideal.span {(p : Z)}).IsMaximal := ...
```

## Additional Search Terms from Final Sprint

| Math concept | Mathlib search terms |
|-------------|---------------------|
| Prime factorization | `Nat.primeFactors`, `Nat.factorization`, `Nat.factorization_prod_pow_eq_self` |
| p-adic valuation of rationals | `padicValRat.defn`, `padicValInt`, `padicNorm.eq_zpow_of_nonzero` |
| Coprimality (reduced rationals) | `Rat.reduced`, `Rat.num_div_den`, `Int.Coprime` |
| Adjoin (ring extension) | `Algebra.adjoin`, `Algebra.adjoin_induction`, `Algebra.subset_adjoin` |
| Irrationality | `irrational_sqrt_natCast_iff`, `Nat.Prime.irrational_sqrt` |
| Integral element operations | `IsIntegral.mul`, `IsIntegral.sub`, `IsIntegral.add` |
| Not integrally closed | `not_isIntegrallyClosed_iff` (may need to construct manually) |

## Common Gotchas

### 1. Name Collisions
Mathlib sometimes has multiple versions of theorems (primed variants, with different assumptions). Check the full signature:
```lean
#check @minpoly.isIntegrallyClosed_eq_field_fractions   -- one version
#check @minpoly.isIntegrallyClosed_eq_field_fractions'  -- primed variant
```

### 2. Universe Issues
If a declaration exists but won't unify, check universe levels. Some Mathlib theorems are universe-polymorphic and need explicit universe annotations.

### 3. Implicit vs Explicit Arguments
When `exact mathlib_lemma` fails, try providing arguments explicitly:
```lean
exact @mathlib_lemma A K _ _ _ _ _ arg1 arg2
```

### 4. algebraMap and Scalar Tower
Many results require `[Algebra A K]` and `[IsScalarTower A K L]`. If these aren't in scope, add them to the theorem signature or use `haveI`.

### 5. Residue Field Isomorphisms
For results like "residue field of Z_(p) is F_p", chain equivalences:
```lean
(IsLocalization.AtPrime.equivQuotMaximalIdeal ...).symm.trans (Int.quotientSpanNatEquivZMod p)
```
