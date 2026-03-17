---
name: mathlib-delegation
description: Use when deciding whether a formalized proof should delegate to Mathlib, when refactoring standalone proofs into Mathlib wrappers, or when reviewing delegation refactors for correctness.
allowed-tools: Read, Edit, Bash, Glob, Grep
---

# Mathlib Delegation for FormalFrontier

This skill guides the decision and execution of refactoring formalized proofs from standalone implementations to thin Mathlib wrappers. Delegation produces shorter, more maintainable code — but requires care to avoid losing fidelity to the textbook.

## When to Delegate

Delegate to Mathlib when:

- **Mathlib has the exact result** (possibly under a different name or with more generality)
- **Your proof reimplements Mathlib internals** (e.g., building `AbsoluteValue` from scratch when `AbsoluteValue.trivial` exists)
- **The proof is a special case** of a Mathlib theorem (e.g., "Z_(p) is a DVR" follows from Mathlib's general Dedekind domain localization result)

Do NOT delegate when:

- **The textbook statement adds pedagogical value** beyond what Mathlib provides (keep the formalized statement, delegate only the proof)
- **Mathlib's version has different hypotheses** that change the mathematical meaning
- **The delegation would obscure the connection** to the textbook presentation

## Decision Checklist

Before starting a delegation refactor:

1. [ ] **Find the Mathlib declaration**: Use the `mathlib-api-lookup` skill
2. [ ] **Verify signature compatibility**: Check that Mathlib's hypotheses match or generalize yours
3. [ ] **Check generality direction**: Mathlib is often more general (works for any Dedekind domain, not just Z). This is fine — your item instantiates the general result
4. [ ] **Confirm the result is the same**: Not just "similar" — mathematically identical for the relevant case

## Delegation Patterns

### Pattern 1: Full Delegation (replace definition + proof)

When Mathlib has both the definition and the theorem, replace both.

**Example: Example 1.3 — trivial absolute value (PR #125)**

Before (custom 9-line definition):
```lean
noncomputable def trivialAbsoluteValue (k : Type*) [DecidableEq k] [Field k] :
    AbsoluteValue k ℝ where
  toFun x := if x = 0 then 0 else 1
  map_mul' x y := by
    by_cases hx : x = 0 <;> by_cases hy : y = 0 <;> simp [hx, hy, mul_comm]
  nonneg' x := by split <;> norm_num
  eq_zero' x := by constructor <;> intro h <;> simp_all [ite_eq_left_iff]
  add_le' x y := by
    by_cases hx : x = 0 <;> by_cases hy : y = 0 <;> simp [hx, hy]
    by_cases hxy : x + y = 0 <;> simp [hxy]
```

After (1-line Mathlib delegation):
```lean
noncomputable def trivialAbsoluteValue (k : Type*) [DecidableEq k] [Field k] :
    AbsoluteValue k ℝ :=
  AbsoluteValue.trivial
```

Key: Keep the project's definition name (`trivialAbsoluteValue`) as a thin wrapper so downstream code doesn't break.

### Pattern 2: Proof-Only Delegation (keep statement, delegate proof)

When the textbook statement is worth preserving but the proof can be a one-liner.

**Example: Example 1.14 — localization at prime is DVR (PR #127)**

Before (multi-step proof):
```lean
theorem localization_at_prime_is_dvr ... :
    IsDiscreteValuationRing (Localization.AtPrime I) := by
  have h1 : IsDedekindDomain ℤ := inferInstance
  have h2 : I.IsPrime := inferInstance
  exact ...long chain...
```

After (single `exact`):
```lean
theorem localization_at_prime_is_dvr ... :
    IsDiscreteValuationRing (Localization.AtPrime I) := by
  exact IsLocalization.AtPrime.isDiscreteValuationRing_of_dedekind_domain ℤ hI_ne_bot _
```

### Pattern 3: Partial Delegation (delegate part of proof)

When a proof has multiple steps and one step matches a Mathlib result.

**Example: Proposition 1.28 — minimal polynomial integrality (PR #130)**

Before (manual forward direction):
```lean
· intro hAα i
  -- 10 lines of manual coefficient manipulation
```

After (delegation to `minpoly.isIntegrallyClosed_eq_field_fractions'`):
```lean
· intro hAα i
  rw [minpoly.isIntegrallyClosed_eq_field_fractions' (K := K) hAα]
  simp [Polynomial.coeff_map]
```

## Refactoring Steps

1. **Find the Mathlib declaration** (see `mathlib-api-lookup` skill)
2. **Write the delegated version** alongside the original (don't delete yet)
3. **Verify it compiles**: `lake build` must pass with zero errors
4. **Update the docstring** to reference the Mathlib declaration:
   ```lean
   /-- Example 1.14: The localization ℤ_(p) is a DVR.
   This delegates to Mathlib's `IsLocalization.AtPrime.isDiscreteValuationRing_of_dedekind_domain`,
   which establishes the result for any Dedekind domain localized at a nonzero prime. -/
   ```
5. **Clean up imports**: Remove imports that were only needed by the old proof; add any new imports needed
6. **Remove the old code** once the new version compiles

## Documentation Pattern

Every delegated item should have:

1. **Module docstring** (`/-! ... -/`): High-level description of the textbook item
2. **Declaration docstring** (`/-- ... -/`): One line stating the result, one line naming the Mathlib declaration being used
3. **Inline comments** only where the delegation is non-obvious (e.g., explaining why `(K := K)` is needed for instance resolution)

Example:
```lean
/-!
# Example 1.14: Localization at a prime ideal

The localization ℤ_(p) for a prime p is a discrete valuation ring (DVR).
This delegates to Mathlib's general result for Dedekind domain localizations.
-/

/-- ℤ localized at a nonzero prime ideal is a DVR.
Delegates to `IsLocalization.AtPrime.isDiscreteValuationRing_of_dedekind_domain`. -/
theorem localization_at_prime_is_dvr ...
```

## Common Pitfalls

### 1. Name Mismatches
Mathlib declarations often have different names than you'd expect. Use `grep -r` on `.lake/packages/mathlib/` to find the exact name. Primed variants (`foo'`) are common and have slightly different hypotheses.

### 2. Generality Differences
Mathlib may require more general type parameters. Use named arguments (`(K := K)`) to help instance resolution when the general version doesn't infer your specific types.

### 3. Missing Instances
After delegation, the proof may fail because an instance that was manually constructed in the old proof is now needed by Mathlib's automation. Use `haveI` to provide it:
```lean
haveI : Fact (Nat.Prime p) := ⟨hprime⟩
```

### 4. Import Changes
Delegation often changes which Mathlib modules are needed. After refactoring:
- Remove imports that are no longer used
- Add imports for the delegated declaration
- Verify with `lake build` — import errors are immediate

### 5. Breaking Downstream Code
If other files reference lemmas or intermediate steps from the old proof, the delegation may break them. Check for dependents before deleting helper lemmas:
```bash
grep -r "old_helper_lemma" SutherlandNumberTheoryLecture1/ --include="*.lean"
```

## Review Checklist for Delegation PRs

When reviewing (or self-reviewing) a delegation refactor:

- [ ] **Mathlib declaration exists**: `#check @the_declaration` compiles
- [ ] **Result is mathematically identical**: Not just similar — same statement for the relevant case
- [ ] **Docstring references Mathlib**: Declaration name appears in the docstring
- [ ] **Unused imports removed**: No stale imports from the old proof
- [ ] **No unused helper lemmas**: Old helpers that are no longer needed are deleted
- [ ] **`lake build` passes**: Zero errors, zero warnings
- [ ] **`items.json` updated**: Status reflects the refactor (e.g., `proof_polished`)
