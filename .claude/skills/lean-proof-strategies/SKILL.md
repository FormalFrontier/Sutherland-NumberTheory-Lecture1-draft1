---
name: lean-proof-strategies
description: Use when filling sorry placeholders in Lean 4 proof files, when choosing between proof approaches for a FormalFrontier item, or when a proof attempt fails and you need an alternative strategy.
allowed-tools: Read, Edit, Bash, Glob, Grep
---

# Lean Proof Strategies for FormalFrontier

This skill captures proven proof strategies from the project's Stage 3.2 proof filling work. Use it to select the right approach before starting a proof, and to recover when an approach fails.

## Strategy Selection: Try in This Order

Before writing any proof, classify the item and try strategies in order of simplicity.

### 1. Instance Resolution (`inferInstance`)

**When to try**: Definitions and propositions that assert a type has a property already in Mathlib's typeclass hierarchy (e.g., "Z is integrally closed", "UFDs are integrally closed", "integral closure is integrally closed").

**Pattern**:
```lean
theorem foo : SomeProperty SomeType := inferInstance
```

**Real examples**:
- `IsIntegrallyClosed Z` — follows from UFD chain (Prop 1.22)
- `IsIntegrallyClosed (integralClosure A K)` — already an instance (Cor 1.21, 1.23)

**Check first**: Use `#check (inferInstance : SomeProperty SomeType)` in a scratch file to see if typeclass search finds it.

### 2. Direct Mathlib API Call (1-line proof)

**When to try**: The theorem is already in Mathlib, possibly under a different name. The .refs.md file in `blobs/` should identify the Mathlib declaration.

**Pattern**:
```lean
theorem foo := Mathlib.Exact.Declaration arg1 arg2
```

**Real examples**:
- Ostrowski's theorem: `Rat.AbsoluteValue.equiv_real_or_padic f hf` (Thm 1.8)
- DVR TFAE: `IsDiscreteValuationRing.TFAE A hA` (Thm 1.16)

**How to find**: Search Mathlib docs for the theorem name or key concepts. Use `exact?` tactic if you have the goal state.

### 3. Instance Transfer via Equivalence

**When to try**: The property holds for a related type, and there's an equivalence or isomorphism to the target type.

**Pattern**:
```lean
theorem foo : Property TargetType :=
  Property.of_equiv (SomeEquiv).symm
```

**Real example**:
- Valuation rings are integrally closed: `IsIntegrallyClosed.of_equiv (ValuationRing.equivInteger A (FractionRing A)).symm` (Prop 1.25)

### 4. Single-Tactic Application (2-5 lines)

**When to try**: The proof follows directly from one Mathlib lemma with some setup (introducing instances, setting variables).

**Pattern**:
```lean
theorem foo ... : Goal := by
  haveI : NeededInstance := ...  -- setup
  exact mathlib_lemma args
```

**Real examples**:
- Transitivity of integrality: `exact Algebra.IsIntegral.trans B` (Prop 1.20)
- Z_(p) is a DVR: `exact IsLocalization.AtPrime.isDiscreteValuationRing_of_dedekind_domain Z hI_ne_bot _` (Ex 1.14)

### 5. Case-Split Construction

**When to try**: Building a new mathematical object (absolute value, structure) where each field needs a separate proof, typically by case analysis on `x = 0` vs `x != 0`.

**Pattern**:
```lean
noncomputable def myThing : SomeStructure where
  toFun x := if x = 0 then ... else ...
  map_mul' := by by_cases hx : x = 0 <;> by_cases hy : y = 0 <;> simp [hx, hy]
  -- etc.
```

**Real example**: Trivial absolute value construction (Ex 1.3) — each axiom verified by case split on zero/nonzero.

### 6. Algebraic Identity + Order Argument (10-30 lines)

**When to try**: The proof uses a specific algebraic identity (Frobenius, power equations, multiplicative order) plus an ordering or finiteness argument.

**Pattern**:
```lean
theorem foo ... := by
  -- Step 1: Establish algebraic identity
  have h_identity : ... := by ...
  -- Step 2: Derive the consequence
  have h_consequence : ... := by ...
  -- Step 3: Conclude
  exact ...
```

**Real examples**:
- Positive char => nonarchimedean: Frobenius gives `f(n)^p = f(n)`, then `f(n)^(p-1) = 1` implies `f(n) <= 1` (Cor 1.5 part 1)
- Finite field trivial abs val: `x^(orderOf u) = 1` gives `f(x)^n = 1` implies `f(x) = 1` (Cor 1.5 part 2)

**Key Mathlib APIs for this pattern**:
- `frobenius k p`, `frobenius_def` — Frobenius endomorphism
- `isOfFinOrder_of_finite`, `pow_orderOf_eq_one` — multiplicative order
- `pow_eq_one_iff_of_nonneg` — extracting `f(x) = 1` from `f(x)^n = 1`

### 7. Calc Chain with Helper Lemma (30-80+ lines)

**When to try**: The proof requires a multi-step inequality chain, typically involving summation bounds, binomial expansion, or density arguments. This is the hardest pattern.

**Pattern**:
```lean
private lemma helper ... := by
  calc lhs ≤ step1 := by ...
    _ ≤ step2 := by ...
    _ = rhs := by ...

theorem main ... := by
  constructor
  · -- Easy direction: use existing Mathlib API
  · -- Hard direction: use helper + density/limit argument
    refine le_of_forall_gt_imp_ge_of_dense fun a ha => ?_
    obtain ⟨n, hn⟩ := some_existence_lemma ...
    exact le_of_pow_le_pow_left₀ ... (key.trans hn.le)
```

**Real example**: Nonarchimedean characterization (Lemma 1.4) — helper proves `f(x+y)^n <= (n+1)*max(f x, f y)^n` via binomial theorem, main theorem uses density of reals.

**Key Mathlib APIs**:
- `Commute.add_pow` — binomial expansion
- `AbsoluteValue.sum_le` — triangle inequality for sums
- `Finset.sum_le_sum` — componentwise summation bounds
- `le_of_forall_gt_imp_ge_of_dense` — density argument for reals
- `Real.exists_natCast_add_one_lt_pow_of_one_lt` — finding large enough n
- `le_of_pow_le_pow_left₀` — extracting base inequality from power inequality

### 8. Contradiction via Integrality Closure (30-65 lines)

**When to try**: The goal is to show an element is NOT integral, or that a ring is NOT integrally closed. The proof constructs a specific element and derives a contradiction from assuming integrality.

**Pattern**:
```lean
theorem foo : ¬ IsIntegrallyClosed R := by
  rw [not_isIntegrallyClosed_iff]
  refine ⟨specific_element, ?_, ?_⟩
  · -- Show it's integral (e.g., root of X^2 - X - 1)
    exact ⟨X^2 - X - 1, monic_proof, eval_proof⟩
  · -- Show it's NOT in R (contradiction via algebraic computation)
    intro ⟨r, hr⟩
    -- Derive contradiction: e.g., show r would need to be rational but isn't
    ...
```

**Real examples**:
- **Example 1.24 (Z[sqrt(5)] not IC)**: 139 lines. Shows (1+sqrt(5))/2 is integral over Z but not in Z[sqrt(5)]. Uses `Algebra.adjoin_induction` to characterize elements of Z[sqrt(5)], then derives contradiction via irrationality of sqrt(5).
- **Example 1.29 (Non-integral element)**: 64 lines. Shows (1+sqrt(7))/2 is not integral by assuming integrality, deriving its conjugate is also integral (closure under subtraction), computing their product = -3/2, and showing -3/2 cannot be in Z.

**Key Mathlib APIs**:
- `IsIntegrallyClosed`, `isIntegrallyClosed_iff`, `not_isIntegrallyClosed_iff`
- `IsIntegral`, `IsIntegral.mul`, `IsIntegral.sub` — integral closure properties
- `Algebra.adjoin_induction` — structural induction on adjoined elements
- `irrational_sqrt_natCast_iff` — irrationality of square roots
- `IsIntegrallyClosed.isIntegral_iff` — characterization via base ring membership

**Pattern for "not in subring" proofs**: Use `Algebra.adjoin_induction` to decompose elements into generators, show the target element can't have that form (typically via irrationality or parity arguments).

**Pattern for "not integral" proofs**: Assume integral, derive conjugate is integral too (closure), compute their product/sum to get a rational number, show it can't be in Z.

### 9. Product Decomposition over Primes (60-120 lines)

**When to try**: The proof involves a product or sum indexed over all primes (or prime factors), typically requiring decomposition by coprimality or factorization.

**Pattern**:
```lean
-- Helper: establish product over prime factors equals the original
private lemma fta_prod ... := by
  have h_factorization := Nat.factorization_prod_pow_eq_self hn
  ...

-- Main theorem: decompose product, apply helper to num/den separately
theorem product_formula ... := by
  obtain ⟨a, b, hab, hb_pos, hq⟩ := Rat.reduced_form hq_ne
  -- Split product over primes dividing a vs primes dividing b
  have h_disjoint : Disjoint a.natAbs.primeFactors b.natAbs.primeFactors := ...
  -- Combine using coprimality
  calc prod = prod_a * prod_b := by ...
    _ = ... := by rw [fta_prod ...]
```

**Real example**: Theorem 1.9 (Product Formula) — 113 lines. Proves `|q|_inf * prod_p |q|_p = 1` by decomposing the rational `q = a/b` into prime factors of numerator and denominator, using coprimality of the reduced form.

**Key Mathlib APIs**:
- `Nat.primeFactors`, `Nat.factorization_prod_pow_eq_self` — FTA infrastructure
- `padicNorm.eq_zpow_of_nonzero`, `padicValRat`, `padicValInt` — p-adic norm/valuation
- `Rat.reduced` — coprimality of reduced rational form
- `Finset.prod_congr`, `Finset.prod_inv_distrib` — product manipulation
- `zpow_neg`, `zpow_natCast` — integer power algebra

**Key difficulty**: Managing the interplay between `Nat.primeFactors` (which works with `Nat`) and `padicValRat` (which works with `Rat`). Use `padicValRat.defn` and `padicValInt` to bridge.

### 10. Polynomial Lifting (15-30 lines)

**When to try**: The proof involves showing a polynomial over K actually has coefficients in a subring A, or transferring polynomial properties across ring extensions.

**Pattern**:
```lean
theorem foo ... := by
  constructor
  · -- Forward: use minpoly equation
    rw [show minpoly K a = (minpoly A a).map (algebraMap A K) from ...]
    intro i; simp [Polynomial.coeff_map]
  · -- Reverse: lift the polynomial
    have hlifts : minpoly K a ∈ Polynomial.lifts (algebraMap A K) := by
      rw [Polynomial.lifts_iff_coeff_lifts]; exact ...
    obtain ⟨p, hp_map, _, hp_monic⟩ := Polynomial.lifts_and_degree_eq_and_monic hlifts ...
    ...
```

**Key Mathlib APIs**:
- `Polynomial.lifts`, `Polynomial.lifts_iff_coeff_lifts` — lifting polynomials
- `Polynomial.lifts_and_degree_eq_and_monic` — preserving degree and monicness
- `minpoly.isIntegrallyClosed_eq_field_fractions'` — minpoly over A vs K
- `Polynomial.aeval_map_algebraMap` — evaluation commutes with map

## Recovery When Stuck

### Tactic Suggestions by Goal Shape

| Goal shape | Try first | Then try |
|-----------|-----------|----------|
| `SomeClass SomeType` | `inferInstance` | `exact?` |
| `a = b` (algebraic) | `ring` | `simp`, `field_simp` |
| `a = b` (with casts) | `push_cast; ring` | `norm_cast` |
| `a ≤ b` (numeric) | `norm_num` | `omega`, `linarith` |
| `a ≤ b` (with powers) | `pow_le_pow_left₀` | `gcongr` |
| `∃ x, P x` | `exact ⟨witness, proof⟩` | `use witness` |
| `P ∧ Q` | `exact ⟨proof_P, proof_Q⟩` | `constructor` |
| `P → Q` | `intro h` | `exact fun h => ...` |
| `¬ P` | `intro h; exact absurd ...` | `by_contra h` |

### Common Pitfalls

1. **Don't `rw` on dependent types**: If you get "motive is not type correct", use `convert` with `?_` placeholders instead of `rw`. See the global CLAUDE.md section on dependent type rewriting.

2. **Cast mismatches**: When `Nat` vs `Int` vs `Real` casts don't align, use `push_cast` before `ring` or `simp`. The pattern `by push_cast; ring` solves most cast arithmetic.

3. **Missing instances**: If `inferInstance` fails, check whether you need `haveI` to introduce an instance from a hypothesis. Example: `haveI : Fact (Nat.Prime p) := ⟨hprime⟩`.

4. **Finset sum manipulation**: For sums over `Finset.range`, the key lemmas are `Finset.sum_le_sum` (pointwise), `Finset.sum_const` + `Finset.card_range` (constant sums), and `nsmul_eq_mul` (converting nsmul to multiplication).

5. **Power arithmetic**: When you need `i + (n - i) = n`, use `omega` after `Finset.mem_range`. For `pow_add` rewriting, use `← pow_add` then `congr 1; omega`.

6. **FractionRing equalities via denominator clearing**: To prove `f(a/b) = 0` in a FractionRing, don't use `field_simp` or hunt for `div_sub_div` lemmas. Instead:
   - Get `a/b * b = a` via `div_mul_cancel₀`
   - Derive needed products (e.g., `(a/b)^2 * b^2 = a^2`) using `calc ... = (a/b * b)^2 := by ring; _ = a^2 := by rw [hφb]`
   - Combine with `linear_combination` to show `goal * b^n = 0`
   - Conclude with `(mul_eq_zero.mp key).resolve_right (pow_ne_zero n hb_ne)`

7. **`Polynomial.degree` vs `natDegree`**: These are different types (`WithBot ℕ` vs `ℕ`). Key API distinction:
   - `Monic.sub_of_left` uses `degree` (not `natDegree`)
   - Use `Polynomial.degree_X`, `Polynomial.degree_one` for `degree` goals
   - Use `Polynomial.natDegree_X`, `Polynomial.natDegree_one` for `natDegree` goals
   - Don't mix them — `linarith`/`omega` can't bridge the type gap

8. **`R[X]` notation with subtypes**: `(↥S)[X]` can cause parsing issues where `X` is treated as an identifier. Use `Polynomial ↥S` explicitly instead.

9. **`Algebra.adjoin_induction` requires careful setup**: When proving properties of elements in `Algebra.adjoin R S`, the induction gives cases for generators, `algebraMap` elements, addition, and multiplication. You often need to carry an invariant through all four cases. Use `Algebra.adjoin_induction` with an explicit motive that captures the property you need.

10. **Counterexample proofs need explicit witnesses**: When proving `¬ P`, you typically need `intro h` followed by deriving `False`. For "not integrally closed" proofs, the witness is a specific element — construct it explicitly rather than using `use` with complicated terms. Example: for Z[sqrt(5)], the witness is `(1 + sqrt 5) / 2` — compute this as a concrete `FractionRing` element.

11. **`linear_combination` for algebraic contradictions**: When a counterexample proof reduces to showing two algebraic expressions are equal (or that an equation has no solution), `linear_combination` is often cleaner than `ring` + `linarith`. It handles the algebraic manipulation in one step. Example from Ex 1.29: showing the product of conjugates equals -3/2.

12. **`Nat.primeFactors` and `Finset.prod` interaction**: When working with products over prime factors, the key bridge lemmas are:
    - `Nat.factorization_prod_pow_eq_self` — reconstructs n from its factorization
    - `Finsupp.prod` vs `Finset.prod` — the factorization is a `Finsupp`, convert via `Finsupp.prod_of_support_subset`
    - `Nat.primeFactors` = `n.factorization.support` — they're definitionally equal
