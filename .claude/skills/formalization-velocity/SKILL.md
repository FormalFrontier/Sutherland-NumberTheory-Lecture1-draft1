---
name: formalization-velocity
description: Quantitative insights on formalization speed by item type and proof strategy. Use when estimating difficulty from textbook statements, planning batches, or predicting project timelines.
allowed-tools: Read, Bash, Glob, Grep
---

# Formalization Velocity Model

Data from the first complete FormalFrontier formalization: Sutherland Number Theory Lecture 1 (27 items, 46 PRs, ~5.3 hours total with 2 parallel agents).

## Item Type Velocity

Measured from Sutherland Lecture 1. Times include scaffolding + proof filling per item.

| Item Type | Count | Avg Lines | Avg Time | Mathlib Wrapper % | Notes |
|-----------|-------|-----------|----------|-------------------|-------|
| Definition | 9 | 25 | 5 min | 100% | Always Mathlib wrappers or `abbrev` |
| Proposition | 5 | 28 | 10 min | 80% | Usually `inferInstance` or 1-line API |
| Corollary | 3 | 30 | 8 min | 100% | Always follow from parent theorem |
| Theorem | 3 | 63 | 30 min | 67% | Named theorems often in Mathlib; product formula was outlier |
| Lemma | 1 | 85 | 45 min | 0% | Required original calc chain proof |
| Example | 4 | 69 | 35 min | 25% | Counterexamples never in Mathlib |

**Key insight:** Definitions and corollaries are always fast. Lemmas and examples (especially counterexamples) are the slowest.

## Proof Strategy Speed Ranking

| Strategy | Items | Avg Lines | Avg Time | When to Expect |
|----------|-------|-----------|----------|----------------|
| `inferInstance` | 6 | 23 | 3 min | Typeclass properties (IC, UFD, field) |
| Direct API call | 8 | 28 | 5 min | Named theorems, standard results |
| Instance transfer | 2 | 30 | 8 min | Properties via equivalence/isomorphism |
| Short tactic (2-10 lines) | 5 | 35 | 15 min | Setup + exact, localization results |
| Case-split construction | 1 | 39 | 20 min | Building new structures field-by-field |
| Algebraic identity + order | 1 | 63 | 25 min | Char p results, finite field proofs |
| Calc chain / helper | 2 | 99 | 45 min | Inequality chains, density arguments |
| Contradiction / counterexample | 2 | 102 | 60 min | "Not X" proofs, specific ring examples |

## Difficulty Prediction from Textbook Statement

### Fast Signals (expect <10 min)

- Statement says "X is a Y" where both X and Y are standard Mathlib types
- Statement says "follows from" or "by [named theorem]"
- Statement is a corollary of the previous item
- Definition matches a Mathlib typeclass exactly

### Medium Signals (expect 15-30 min)

- Statement requires a short proof using a specific Mathlib lemma with setup
- Statement involves localization, completion, or quotient constructions
- The .refs.md file lists a Mathlib declaration but with caveats
- Statement involves instance transfer across an equivalence

### Hard Signals (expect 45-90 min)

- **Counterexample proofs** ("X is NOT Y"): Always hard — requires constructing specific objects
- **Product/sum formulas**: Require decomposition + recombination over finite sets
- **Characterization lemmas** ("X iff for all n, P(n)"): Often need density/limit arguments
- **Algebraic identities in non-commutative or graded settings**: Cast mismatches, dependent types
- The .refs.md file says "no direct Mathlib coverage" or "partial coverage"

### Red Flags (consider Aristotle escalation)

- Statement involves a product over all primes (infinite product reasoning)
- Statement requires irrationality proofs of algebraic numbers
- Proof sketch in the textbook uses "by a standard argument" without details
- Multiple ring extensions with scalar tower interactions

## Mathlib Coverage Heuristics

For introductory algebraic number theory (undergraduate/early graduate level):

| Content Type | Expected Mathlib Coverage |
|-------------|--------------------------|
| Standard definitions (DVR, PID, UFD, integral closure) | 95%+ |
| Named theorems (Ostrowski, Dedekind, Minkowski) | 80%+ |
| "Follows from" propositions | 70%+ |
| Worked examples (specific rings like Z_p, k[[t]]) | 50% |
| Counterexamples (Z[sqrt(5)] not IC) | 0% |
| Product/summation formulas | 30% |

**Rule of thumb:** `coverage% * 0.7 + 30 = expected % of items provable in <10 min`

For this project: 74% * 0.7 + 30 = 82%. Actual: 22/27 = 81%.

## Batch Sizing Guidelines

Based on observed throughput with auto-merge PRs:

| Batch Type | Items per PR | Agent Time | Rationale |
|-----------|-------------|------------|-----------|
| Scaffolding (Stage 3.1) | 5-8 | 30 min | Parallel-safe; no proof work |
| Easy proofs (inferInstance, API) | 3-5 | 20 min | All trivial; group by topic |
| Medium proofs | 2-3 | 30 min | Related items share imports |
| Hard proofs | 1 | 45-90 min | Need full agent attention |

**Total throughput:** 2 agents can do ~12-15 items/hour on easy, ~4-6/hour on medium, ~1-2/hour on hard.

## Project Duration Estimation

Given a textbook section with N formalizable items and C% Mathlib coverage:

```
Phase 1 (source prep): 1 + 0.15 * pages hours
Phase 2 (dep mapping): 1 + 0.05 * N hours
Phase 3 (formalization):
  Easy items:  N * C% * 0.15 hours
  Medium items: N * (1-C%) * 0.6 * 0.4 hours
  Hard items:   N * (1-C%) * 0.4 * 1.2 hours

Total with 2 agents: (Phase 1 + Phase 2 + Phase 3) / 1.6
```

For Sutherland Lecture 1 (9 pages, 27 items, 74% coverage):
- Phase 1: 1 + 0.15*9 = 2.35h
- Phase 2: 1 + 0.05*27 = 2.35h
- Phase 3: 27*0.74*0.15 + 27*0.26*0.6*0.4 + 27*0.26*0.4*1.2 = 3.0 + 1.7 + 3.4 = 8.1h raw
- With 2 agents: (2.35 + 2.35 + 8.1) / 1.6 = 8.0h

Actual: ~5.3h (faster due to high parallelism in Phase 3 and aggressive batching).

## Lines of Lean Per Item Type

Useful for estimating file sizes and review effort:

| Difficulty | Lean Lines (with imports) | Proof Lines Only |
|-----------|--------------------------|-----------------|
| Trivial (inferInstance) | 20-25 | 1 |
| Easy (API call) | 25-35 | 1-5 |
| Medium (short tactic) | 30-50 | 5-15 |
| Hard (calc chain) | 60-100 | 30-70 |
| Very Hard (counterexample) | 80-140 | 40-100 |

Total project: ~1,200 lines of Lean across 27 files.
