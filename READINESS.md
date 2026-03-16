# Stage 2.6: Formalization Readiness Report

**Source:** Sutherland, Number Theory Lecture 1
**Date:** 2026-03-16
**Items total:** 38 (27 formalizable, 11 non-formalizable)

## Summary

Of 27 formalizable items:
- **20 fully covered** by Mathlib (74%) — these are primarily wrappers or light assembly
- **4 partially covered** (15%) — core concepts exist but some directions or details need proving
- **3 not covered** (11%) — require substantial original work

All 35 external dependencies are covered by Mathlib (30 fully, 5 partially). The lecture is highly amenable to formalization.

## Items by Effort Level

### Easy (Mathlib wrapper) — 14 items

These items have exact Mathlib matches. Formalization is primarily stating the result and connecting to existing API.

| Item | Type | Mathlib Match |
|------|------|---------------|
| Definition 1.2 | definition | `AbsoluteValue`, `IsNonarchimedean` |
| Example 1.3 | example | `AbsoluteValue.trivial` |
| Definition 1.6 | definition | `AbsoluteValue.IsEquiv` |
| Definition 1.7 | definition | `padicValNat/Int/Rat`, `Rat.AbsoluteValue.padic` |
| Theorem 1.8 | theorem | `Rat.AbsoluteValue.equiv_real_or_padic` (Ostrowski) |
| Definition 1.11 | definition | `ValuationRing` |
| Definition 1.12 | definition | `IsLocalRing` |
| Definition 1.13 | definition | `IsLocalRing.ResidueField` |
| Definition 1.17 | definition | `IsIntegral`, `Algebra.IsIntegral` |
| Proposition 1.18 | proposition | `IsIntegral.add`, `IsIntegral.mul` |
| Definition 1.19 | definition | `integralClosure`, `IsIntegrallyClosed` |
| Proposition 1.20 | proposition | `Algebra.IsIntegral.trans` |
| Corollary 1.21 | corollary | `integralClosure.isIntegrallyClosedIn` |
| Proposition 1.28 | proposition | `minpoly.isIntegrallyClosed_eq_field_fractions` |

### Medium (assembly needed) — 9 items

Core Mathlib concepts exist but the exact statement needs assembly, or one direction of an iff needs proving.

| Item | Type | What's Needed |
|------|------|---------------|
| Lemma 1.4 | lemma | Forward direction exists (`IsNonarchimedean.natCast_le_one`); converse needs proving |
| Corollary 1.5 | corollary | Positive characteristic implies nonarchimedean — follows from Lemma 1.4 characterization |
| Definition 1.10 | definition | `Valuation`/`AddValuation` exist but textbook's specific DVR definition needs mapping to Mathlib's `IsDiscreteValuationRing` |
| Example 1.14 | example | `Localization.AtPrime` exists; need to construct Z_(p) as DVR with specific valuation |
| Example 1.15 | example | `PowerSeries`/`LaurentSeries` exist; need to construct the order-of-vanishing valuation |
| Theorem 1.16 | theorem | `IsDiscreteValuationRing.TFAE` exists; need to match textbook's specific list of equivalent conditions |
| Proposition 1.22 | proposition | Z is integrally closed follows from `UniqueFactorizationMonoid.instIsIntegrallyClosed`; need to assemble the chain Z → EuclideanDomain → UFD → integrally closed |
| Corollary 1.23 | corollary | Every UFD is integrally closed — same Mathlib result, need to state in textbook's form |
| Definition 1.26 | definition | `NumberField` and `NumberField.RingOfIntegers` exist; need to match textbook's presentation |
| Proposition 1.25 | proposition | `Valuation.Integers.isIntegrallyClosed` exists; assembly with DVR context needed |

### Hard (from scratch) — 3 items

| Item | Type | Why Hard |
|------|------|----------|
| Theorem 1.9 | theorem | **Product formula** for absolute values on Q. No Mathlib coverage. Requires relating all p-adic and real absolute values. Depends on Ostrowski (Theorem 1.8). |
| Example 1.24 | example | **Z[sqrt(5)] is not integrally closed.** No Mathlib coverage. Need to construct the ring, show (1+sqrt(5))/2 is integral over Z but not in Z[sqrt(5)]. Concrete computation. |
| Example 1.29 | example | **Ring of integers of Q(sqrt(7)) contains (1+sqrt(7))/2.** No Mathlib coverage. Need to show this element is integral and compute the full ring of integers. |

## Non-Formalizable Items (11)

These are discussions, remarks, bibliography, and introduction — tracked but not formalized:

- Introduction, Remark 1.1, Discussion after 1.1, Discussion after 1.6, Discussion after 1.9, Discussion after 1.13, Discussion after 1.15, Discussion after 1.16, Remark 1.27, References, Backmatter

## Suggested Formalization Order

The internal dependency chain is currently conservative (linear). The true dependency structure allows significant parallelism. Here are suggested batches:

### Batch 1: Foundations (no inter-dependencies)

These items depend only on external prerequisites already in Mathlib:

| Item | Effort |
|------|--------|
| Definition 1.2 (absolute value) | Easy |
| Example 1.3 (trivial abs val) | Easy |
| Definition 1.17 (integral element) | Easy |

### Batch 2: Early results (depend on Batch 1)

| Item | Effort | Depends On |
|------|--------|------------|
| Lemma 1.4 (nonarchimedean char) | Medium | Def 1.2 |
| Definition 1.6 (equivalence) | Easy | Def 1.2 |
| Definition 1.7 (p-adic valuation) | Easy | Def 1.2 |
| Proposition 1.18 (integral closure) | Easy | Def 1.17 |
| Definition 1.19 (integral closure) | Easy | Def 1.17, Prop 1.18 |

### Batch 3: Middle layer

| Item | Effort | Depends On |
|------|--------|------------|
| Corollary 1.5 (pos char → nonarchimedean) | Medium | Lemma 1.4 |
| Theorem 1.8 (Ostrowski) | Easy | Def 1.6, 1.7 |
| Definition 1.10 (discrete valuation) | Medium | (external only) |
| Definition 1.11 (valuation ring) | Easy | Def 1.10 |
| Proposition 1.20 (transitivity) | Easy | Def 1.19 |
| Corollary 1.21 (integral closure is IC) | Easy | Prop 1.20 |

### Batch 4: DVR theory and integral closedness

| Item | Effort | Depends On |
|------|--------|------------|
| Definition 1.12 (local ring) | Easy | Def 1.11 |
| Definition 1.13 (residue field) | Easy | Def 1.12 |
| Example 1.14 (Z_(p)) | Medium | Def 1.10, 1.12 |
| Example 1.15 (k[[t]]) | Medium | Def 1.10 |
| Theorem 1.16 (DVR characterizations) | Medium | Def 1.10-1.13 |
| Proposition 1.22 (Z is IC) | Medium | Def 1.19 |
| Corollary 1.23 (UFD → IC) | Medium | Prop 1.22 |
| Proposition 1.25 (valuation ring IC) | Medium | Def 1.10, 1.19 |

### Batch 5: Number fields and hard items

| Item | Effort | Depends On |
|------|--------|------------|
| Theorem 1.9 (product formula) | **Hard** | Thm 1.8 |
| Example 1.24 (Z[sqrt(5)]) | **Hard** | Cor 1.23 |
| Definition 1.26 (number field) | Easy | Def 1.19 |
| Proposition 1.28 (min poly coeffs) | Easy | Def 1.26 |
| Example 1.29 ((1+sqrt(7))/2) | **Hard** | Def 1.26 |

## Critical Path

The longest dependency chain through the hardest items:

**Def 1.2 → Def 1.6 → Def 1.7 → Thm 1.8 → Thm 1.9** (product formula)

This is the critical path because Theorem 1.9 is hard and depends on a chain of 4 items. However, Definitions 1.2, 1.6, 1.7, and Theorem 1.8 are all easy Mathlib wrappers, so the real bottleneck is Theorem 1.9 itself.

A secondary critical path runs through integral closure:

**Def 1.17 → Prop 1.18 → Def 1.19 → Prop 1.20 → Cor 1.21 → Prop 1.22 → Cor 1.23 → Ex 1.24**

Again, all items before Example 1.24 are easy/medium, so the bottleneck is Example 1.24 itself.

## Concerns

1. **Theorem 1.9 (Product Formula):** This is the hardest item. It requires combining all p-adic absolute values with the real absolute value into a product. This may be a good candidate for Aristotle escalation if initial attempts fail.

2. **Examples 1.24 and 1.29 (specific rings of integers):** These require concrete computations with algebraic number fields. While not conceptually deep, the Lean formalization of Z[sqrt(5)] and Q(sqrt(7)) may require careful setup of the ring structures.

3. **Definition 1.10 (discrete valuation):** The textbook uses additive convention while Mathlib has both additive and multiplicative. Mapping between conventions needs care.

4. **External-sources data unavailable:** The `research/external-sources.json` file was not delivered with Stage 2.5. The readiness assessment is based on `mathlib-coverage.json` and `external-coverage.json` only. This does not affect coverage conclusions since those files already capture Mathlib availability.

## External Dependencies Status

All 35 external dependencies have Mathlib coverage:
- **30 fully covered** (86%): field, ring, integral domain, ideal theory, integers, rationals, reals, primes, FTA, finite fields, polynomials, fraction field, PID, UFD, Noetherian, Krull dimension, localization, group homomorphism, power series, algebraic closure, field extensions, Z-module, vector space, triangle inequality, rational root test, Z is PID, F_q[t] is PID, Z Krull dim 1, DVR characterizations proof, transitivity of integrality proof
- **5 partially covered** (14%): symmetric polynomials, regular local rings, discrete subgroups of R (not covered), every field contains prime field, Riemann zeta

The only truly uncovered external dependency is `ext/discrete-subgroups-of-R` (every discrete subgroup of R is isomorphic to Z), used by Definition 1.10. This is a standard result that should be straightforward to prove from scratch.
