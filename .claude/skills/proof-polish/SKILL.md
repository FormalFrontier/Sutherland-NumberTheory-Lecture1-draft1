---
name: proof-polish
description: Use when running Stage 3.4 (Proof Polishing) to bring sorry-free proofs to Mathlib quality. Use when assessing whether a proof needs cleanup, when working through proof-polish GitHub issues, or when deciding which tactic to prefer for a given goal.
allowed-tools: Read, Edit, Bash, Glob, Grep
---

# Proof Polishing for FormalFrontier

This skill guides Stage 3.4: bringing all sorry-free proofs to Mathlib quality. Work through proofs systematically — triage first, automated cleanup second, manual polish per issue.

## Phase 1: Triage

For each sorry-free Lean file:
1. Run `lake build 2>&1 | tee /tmp/polish-build.log` and capture all linter warnings
2. Read each non-trivial proof and assess against the quality checklist below
3. Open one GitHub issue labelled `proof-polish` per proof that needs attention, describing specifically what needs fixing

**Trivial proofs** (single `rfl`, `trivial`, `inferInstance`, `decide`, one-line `exact`) don't need issues unless they have linter warnings.

## Phase 2: Automated Cleanup (run before manual polish)

Apply these bulk transformations first, verifying `lake build` after each batch:

- **Trailing semicolons**: Remove `;` at end of terminal tactic lines (`aesop;` → `aesop`)
- **Whitespace in brackets**: `( foo )` → `(foo)`, `[ foo ]` → `[foo]`
- **`refine'` → `refine`**: Replace all `refine'` with `refine`, then verify build (refine' is deprecated)
- **Non-Mathlib simp flags**: Remove `+decide`, `+contextual`, `+zetaDelta` from `simp` calls
- **Unused simp lemmas**: Remove simp arguments that Lean warns are unnecessary ("simp made no progress" / "unnecessary simp lemma")

Commit automated changes separately from manual changes.

## Phase 3: Manual Polish (per issue)

For each `proof-polish` issue:
1. Reproduce the problem locally
2. Apply fixes one at a time; verify `lake build` after each change
3. Commit and close the issue with `Fixes #N`; enable auto-merge on the PR

## Quality Checklist

### Linter
- [ ] `lake build` produces zero warnings for this file

### `simp` discipline
- [ ] **Non-terminal `simp`** (i.e., `simp` followed by more tactics): replace with `simp only [...]` using the minimal lemma set from `simp?`
- [ ] **Terminal `simp`** (i.e., `simp` closes the goal): keep as bare `simp` — listing every lemma is obfuscatory

### Dead code
- [ ] No unused `have`, `obtain`, or local `let`
- [ ] No commented-out tactic attempts

### Arithmetic and algebra
- [ ] **Linear arithmetic**: use `lia` (prefer over `omega` for arithmetic goals)
- [ ] **Commutative ring identities**: use `ring`
- [ ] **Nonlinear arithmetic**: use `nlinarith` or `polyrith`
- [ ] **Numeric computations**: use `norm_num`
- [ ] **Positivity goals** (`0 < f x`, `0 ≤ f x`): use `positivity`
- [ ] **Numeric coercions** (goals with `↑`, `Nat.cast`, `Int.cast`, etc.): use `norm_cast` or `push_cast` to normalize first

### Automation passes
- [ ] **`grind` pass**: try replacing a terminal chain of proof steps with `grind`. If bare `grind` fails, add the theorem names referenced in those steps as arguments: `grind [Theorem.foo, lemma_bar]`. If it still fails, try adding `@[simp]` or `@[ext]` annotations to relevant definitions/lemmas that would help `grind` or `ext; simp` go through.
- [ ] **`fun_prop`**: for goals asserting continuity, measurability, or differentiability of a function
- [ ] **`gcongr`**: for congruence goals (replacing parts of an expression)
- [ ] **`decide`**: for finite decidable goals

### Avoiding fragile tactics
- [ ] **No `erw`**: replace with `rw` plus appropriate coercions, `norm_cast`, or a restatement of the goal
- [ ] **No `convert` relying on non-trivial definitional equality**: prefer rewriting the proof to directly establish the goal. Use `convert` only when the goals differ by superficial syntactic differences, not when they require non-trivial unification.

### Style
- [ ] No `refine'` — use `refine` (or `exact`)
- [ ] Multi-step equalities/inequalities: consider `calc` blocks when intermediate steps clarify the argument
- [ ] Tactic chains that chain logically (each step sets up the next) should be on separate lines rather than joined with `;`, except for trivially short patterns like `intro x; exact ...`

## When to Delegate to Mathlib Instead of Polishing

Before polishing a proof, check whether Mathlib already has the result. If so, **delegate** rather than polish — see the `mathlib-delegation` skill. Signs a proof should be delegated:

- The proof reimplements something Mathlib provides (e.g., a custom `trivialAbsoluteValue` when `AbsoluteValue.trivial` exists)
- The proof is long but follows a well-known mathematical pattern that Mathlib likely covers
- The proof was written before the relevant Mathlib API was discovered

Delegation produces shorter, more maintainable code than any amount of polishing.

## Common Patterns

### Replacing a tactic chain with `grind`

Before:
```lean
  have h1 : a ∣ b := dvd_of_eq hab
  have h2 : b ∣ c := dvd_trans h1 hbc
  exact dvd_trans h1 h2
```
Try:
```lean
  grind [dvd_of_eq, dvd_trans]
```

### Replacing `mul_le_mul` boilerplate with `gcongr`

Before (from Lemma 1.4 polish, PR #117):
```lean
  apply mul_le_mul
  · exact pow_le_pow_left₀ (f.nonneg _) (le_max_left _ _) _
  · exact pow_le_pow_left₀ (f.nonneg _) (le_max_right _ _) _
  · exact pow_nonneg (f.nonneg _) _
  · exact pow_nonneg (le_max_of_le_left (f.nonneg _)) _
```
After:
```lean
  gcongr
  · exact le_max_left _ _
  · exact le_max_right _ _
```
`gcongr` automates monotonicity side conditions (nonneg, etc.) and focuses on the comparison subgoals.

### Inlining single-use hypotheses

Before (from Theorem 1.9 polish, PR #117):
```lean
  have hprod_ne : q.num.natAbs * q.den ≠ 0 :=
    mul_ne_zero (Int.natAbs_ne_zero.mpr (Rat.num_ne_zero.mpr hq)) (Rat.den_pos q).ne'
  have hndvd : ¬(p ∣ q.num.natAbs * q.den) := by
    intro h; exact hp_ndvd (Nat.mem_primeFactors.mpr ⟨hp, h, hprod_ne⟩)
```
After:
```lean
  have hndvd : ¬(p ∣ q.num.natAbs * q.den) := by
    intro h; exact hp_ndvd (Nat.mem_primeFactors.mpr ⟨hp, h,
      mul_ne_zero (Int.natAbs_ne_zero.mpr (Rat.num_ne_zero.mpr hq)) (Rat.den_pos q).ne'⟩)
```
If a `have` is used exactly once, inline it to tighten the proof.

### Collapsing linear auxiliary fact chains

Before (from Example 1.29 polish, PR #119):
```lean
  have h7 : (0 : ℝ) ≤ 7 := by norm_num
  have hsq : Real.sqrt 7 ^ 2 = 7 := Real.sq_sqrt h7
  nlinarith [hsq]
```
After:
```lean
  nlinarith [Real.sq_sqrt (show (0 : ℝ) ≤ 7 by norm_num)]
```
When auxiliary facts form a linear chain (h1 → h2 → final tactic), collapse into a single expression.

### Using `change` instead of `rw [show ... from rfl]`

Before (from Theorem 1.9 polish, PR #117):
```lean
  rw [show f x ⊔ f y = max (f x) (f y) from rfl]
```
After:
```lean
  change f (x + y) ≤ max (f x) (f y)
```
For definitional unfoldings, `change` is clearer about intent.

### Naming shadowed `this` bindings

Before (from Example 1.29 polish, PR #119):
```lean
  have : (n : ℚ) = -3 / 2 := by simpa using hn
  have : (2 : ℚ) * n = -3 := by linarith
```
After:
```lean
  have h_eq : (n : ℚ) = -3 / 2 := by simpa using hn
  have h_two_n : (2 : ℚ) * n = -3 := by linarith
```
Shadowed `this` bindings are confusing even in local scope.

### Non-terminal `simp only` conversion

Before:
```lean
  simp at h
  exact h.2
```
Run `simp?` to find the minimal set, then:
```lean
  simp only [Prod.fst, Prod.snd] at h
  exact h.2
```

### `norm_cast` for coercion goals

Before:
```lean
  have : (n : ℤ) = (m : ℤ) := by exact_mod_cast h
  exact_mod_cast this
```
After:
```lean
  exact_mod_cast h
```

### Replacing `erw` with `rw` + coercion

Before:
```lean
  erw [Nat.cast_mul]
```
Try:
```lean
  push_cast
  rw [Nat.cast_mul]
```
or just `norm_cast` if the whole goal is a coercion identity.

## Polish Priority Order

When polishing a proof, apply changes in this order (each step may eliminate the need for later ones):

1. **Check for Mathlib delegation** — can the whole proof be replaced?
2. **`gcongr` / `grind` pass** — can automation replace multi-line tactic chains?
3. **Inline single-use `have`s** — tighten proof structure
4. **Fix non-terminal `simp`** — replace with `simp only [...]`
5. **`change` over `rw [show ... from rfl]`** — clearer intent
6. **Name shadowed bindings** — readability
7. **Collapse linear chains** — compress sequential auxiliary facts

## Lint Audit Checklist

After individual polishing, run a full lint audit across all files (from PR #126):

1. Run `lake build 2>&1 | tee /tmp/lint-audit.log` and check for warnings
2. Audit each file for non-terminal `simp` (the most common issue)
3. For non-terminal `simp`, either:
   - Replace with `simp only [specific_lemmas]` (use `simp?` output)
   - Restructure to make it terminal (move it to be the last tactic in a branch)
   - Replace with `change` if the simp is just unfolding a definition
4. Remove unused imports discovered during audit
5. Verify full `lake build` passes with zero warnings after all fixes
6. Commit lint fixes separately from proof restructuring
