---
name: project-retrospective
description: Transferable lessons from the first complete FormalFrontier book formalization (Sutherland Number Theory Lecture 1). Use when planning or executing future book formalizations.
allowed-tools: Read, Bash, Glob, Grep
---

# Project Retrospective: Sutherland Number Theory Lecture 1

First complete FormalFrontier formalization. 27/27 formalizable items sorry-free in ~5.3 hours of parallel agent execution on 2026-03-16. 46 merged PRs, 59 issues created.

## What Went Well

### 1. Pre-Formalization Research Was the Highest-ROI Investment

Stage 2.4 (Mathlib Coverage) and Stage 2.7 (Reference Attachment) together took ~1 hour but saved ~3 hours during proof filling:

- **Mathlib coverage analysis** (PR #51) found 20/27 items (74%) already in Mathlib. This meant 74% of proofs were 1-line API calls or `inferInstance` — no creativity needed.
- **`.refs.md` files** (PR #63) pre-curated exact Mathlib declaration names per item. Agents could copy-paste API names instead of searching.

**Transferable rule:** Always complete Stages 2.4 and 2.7 before any scaffolding. The coverage percentages predict formalization velocity: >70% Mathlib coverage = fast project; <50% = expect significant proof work.

### 2. Batched Scaffolding Before Any Proof Filling

Stage 3.1 scaffolded ALL 27 items with `sorry` placeholders across 5 batches (PRs #67, #69, #73, #93) before ANY proof was filled. Benefits:

- Detected statement formalization errors early (3 items needed corrections)
- Agents could work on any proof in any order — no sequential blocking
- `items.json` status tracking worked cleanly from day one

**Transferable rule:** Complete all scaffolding (Stage 3.1) before starting any proof filling (Stage 3.2). Never interleave.

### 3. One PR Per Logical Unit, Auto-Merge Enabled

Every PR targeted a specific deliverable (1-3 related items). Auto-merge via `gh pr merge --auto --squash` meant agents never waited for human review. Average cycle: PR created → merged in 10-15 minutes (CI time).

**Transferable rule:** Keep PRs small (1-3 items). Enable auto-merge immediately. Don't batch unrelated items.

### 4. Parallel Agents on Independent Items

Two primary agents (1d7941eb, 15903d7e) worked simultaneously on different proof items without merge conflicts. The key enabler: items in separate Lean files with no shared state.

**Transferable rule:** One Lean file per item during scaffolding. This enables embarrassingly parallel proof filling.

### 5. Proof Strategy Documentation Mid-Project

After completing ~50% of proofs, agents documented 8 proof patterns in `lean-proof-strategies` skill (PR #94). The remaining 50% of proofs went faster because agents could match new items to known patterns.

**Transferable rule:** After 40-60% of proofs are done, pause to document proof patterns. The skill pays for itself on the remaining items.

## What Was Harder Than Expected

### 1. Three "Hard" Items Required 60-140 Line Proofs

**Theorem 1.9 (Product Formula)** — 113 lines. Required decomposing a product over all primes into numerator/denominator factors using coprimality of reduced rational form. Heavy `padicNorm` and FTA API usage.

**Example 1.24 (Z[sqrt(5)] not integrally closed)** — 139 lines. Required `Algebra.adjoin_induction`, irrationality of sqrt(5), and a contradiction via fraction ring lifting. Most complex proof in the project.

**Example 1.29 (Non-integral element)** — 64 lines. Required showing minimal polynomial has non-integer coefficients via conjugate integrality and algebraic computation.

**Key lesson:** Counterexample proofs (Examples 1.24, 1.29) were harder than forward proofs. They require constructing specific algebraic objects and deriving contradictions — no standard Mathlib API for this.

### 2. Dependent Type Rewriting in Lean

Several proofs hit "motive is not type correct" errors when using `rw` on terms appearing in dependent types. The solution (documented in lean-proof-strategies) is to generalize first with `suffices`, then instantiate with `convert`.

**Transferable rule:** When planning proof difficulty, add +1 difficulty level for any proof involving rewriting inside dependent types (common with integral closures, subtype coercions, and scalar towers).

### 3. Status Tracking Drift

`items.json` drifted from reality during rapid parallel work (PRs #83, #88 were just status corrections). Two agents updating the same JSON file led to stale reads.

**Transferable rule:** Status corrections should be a dedicated review task after each batch, not expected to stay accurate during parallel work.

## Proof Strategy Distribution (Actual vs. Predicted)

| Strategy | Predicted (Stage 2.6) | Actual | Items |
|----------|----------------------|--------|-------|
| inferInstance | 5 | 6 | Props 1.22, 1.25; Cors 1.21, 1.23; Defs 1.12, 1.13 |
| Direct Mathlib API (1-line) | 9 | 8 | Thms 1.8, 1.16; Props 1.18, 1.20, 1.28; Def 1.7; Cor 1.5.2; Def 1.26 |
| Instance transfer | 2 | 2 | Prop 1.25 (alt), Def 1.17 |
| Short tactic proof (2-10 lines) | 5 | 5 | Ex 1.14, 1.15; Cor 1.5; Def 1.6; Def 1.10 |
| Case-split construction | 1 | 1 | Ex 1.3 |
| Algebraic identity + order | 1 | 1 | Cor 1.5.1 |
| Calc chain / helper lemma | 2 | 2 | Lemma 1.4, Thm 1.9 |
| Contradiction / counterexample | 2 | 2 | Ex 1.24, Ex 1.29 |

**Accuracy of Stage 2.6 predictions:** 96% (1 item shifted from "API call" to "short tactic"). The readiness report is reliable.

## Pipeline Optimization for Future Books

### Phase 1 (Source Preparation): Well-Optimized

- Page extraction and transcription are mechanical — no changes needed
- Structure analysis (Stage 1.5) is critical: every byte must belong to exactly one blob
- Time: ~2 hours for a 9-page lecture; scales linearly with page count

### Phase 2 (Dependency Mapping): Key Bottleneck is Coverage Research

- Internal dependencies (Stage 2.1) are trivial with conservative linear chain
- **Mathlib coverage** (Stage 2.4) is the most valuable stage in the entire pipeline
- Reference attachment (Stage 2.7) should be done by the same agent that did coverage research (context continuity)
- Time: ~1 hour; mostly limited by Mathlib grep speed

### Phase 3 (Formalization): Parallelism Matters Most

- Scaffolding (Stage 3.1): 5 batches took ~1 hour. Could be 2 batches with more agents.
- Proof filling (Stage 3.2): ~2 hours with 2 agents. Hard items are the long pole — start them first.
- **Start hard proofs immediately.** Don't wait for easy proofs to finish. Hard proofs (Theorem 1.9, Example 1.24) took 3-5x longer than medium proofs.

### Recommended Batch Ordering for Future Books

1. **Batch 0:** Scaffolding for hard items (enables early proof attempts)
2. **Batch 1:** All easy proofs (inferInstance, API wrappers) — one agent can do 10+ per PR
3. **Batch 2:** Medium proofs — 2-3 per PR
4. **Batch 3:** Hard proofs — 1 per PR, with potential Aristotle escalation

## When to Escalate to Aristotle

This project completed 27/27 items without Aristotle. In retrospect:

- **Theorem 1.9** came closest to needing escalation (required understanding of padicNorm internals)
- **Example 1.24** would have been a good Aristotle candidate if the agent had struggled longer

**Heuristic for future books:** Escalate after 2 genuinely different approaches fail AND the proof requires >80 lines of Lean. Short proofs that fail are usually a sign of wrong statement formalization, not proof difficulty.

## Key Mathlib Coverage Patterns

For number theory lectures at this level (introductory algebraic number theory):

- **Definitions:** 90%+ already in Mathlib (just need `abbrev` or type alias)
- **Named theorems** (Ostrowski, DVR TFAE): Usually in Mathlib; check first
- **"Follows from" propositions** (e.g., "Z is integrally closed"): Instance resolution
- **Counterexamples** ("Z[sqrt(5)] is not IC"): Never in Mathlib — always need original proofs
- **Product formulas / summation identities:** Partially in Mathlib; expect 50-100 line proofs
