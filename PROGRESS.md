# Project Progress

**Book:** 18.785 Number Theory I, Lecture #1: Absolute Values and Discrete Valuations
**Author:** Andrew V. Sutherland (MIT, Fall 2021)
**Source:** 9-page lecture notes (8 content pages + 1 backmatter license page)

---

## Phase 1: Source Preparation — Complete

All Phase 1 stages completed on 2026-03-16.

### Stage 1.1: Page Extraction
**Status:** Complete
**Date:** 2026-03-16
**Notes:** 9 raw PDF pages extracted via `pdfseparate`. No frontmatter; page 1 starts directly with lecture content. One backmatter page (MIT OCW license).

### Stage 1.2: Start Lean Build
**Status:** Complete
**Date:** 2026-03-16
**Notes:** Lean project initialized as `SutherlandNumberTheoryLecture1` with Mathlib dependency. `lake build` passes.

### Stage 1.3: Frontmatter Detection
**Status:** Complete
**Date:** 2026-03-16
**Notes:** 8 content pages mapped as `pdf/pages/1.pdf`–`8.pdf`. 1 backmatter page (`pdf/pages/backmatter-1.pdf`). Mapping recorded in `pdf/pages/mapping.json`.

### Stage 1.4: Page Transcription
**Status:** Complete
**Date:** 2026-03-16
**Notes:** All 9 pages transcribed to markdown with LaTeX math. Conventions documented in `pages/CONVENTIONS.md`. Transcription quality reviewed for all 9 pages (pages 2–7 in PR #35; pages 1, 8, backmatter-1 in PR #47). No errors found.

| PR | Title |
|----|-------|
| #15 | Transcribe page 1 |
| #16 | Transcribe page 2 |
| #20 | Transcribe page 5 |
| #21 | Transcribe page 3 |
| #22 | Transcribe page 4 |
| #23 | Transcribe page 6 |
| #24 | Transcribe page 7 |
| #28 | Transcribe page 8 |
| #29 | Transcribe backmatter-1 |

### Stage 1.5: Structure Analysis
**Status:** Complete
**Date:** 2026-03-16
**Notes:** `items.json` created with 38 content blobs covering every line of every page. Contiguity verified by `scripts/check_contiguity.py` — no gaps or overlaps.

| Type | Count |
|------|-------|
| Introduction | 1 |
| Definitions | 11 |
| Theorems | 4 |
| Propositions | 5 |
| Corollaries | 3 |
| Lemmas | 1 |
| Examples | 6 |
| Remarks | 2 |
| Discussion | 6 |
| Bibliography | 1 |
| Backmatter | 1 |
| **Total** | **38** |

Of these, 27 are formalizable (definitions, theorems, lemmas, propositions, corollaries, examples) and 11 are non-formalizable (introduction, remarks, discussion, bibliography, backmatter).

### Stage 1.6: Blob Extraction
**Status:** Complete
**Date:** 2026-03-16
**Notes:** 38 blob files extracted to `blobs/Lecture1/` using `scripts/extract_blobs.py`. Round-trip verified: concatenation reproduces original page content exactly.

### Stage 1.7: Indexing
**Status:** Skipped (optional)

---

## Phase 2: Dependency Mapping — Complete

All Phase 2 stages completed on 2026-03-16. This phase produced the dependency graph, Mathlib coverage research, readiness report, and per-item reference files.

### Stage 2.1: Internal Dependency Analysis
**Status:** Complete
**Date:** 2026-03-16
**Notes:** `dependencies/internal.json` created with 38 entries in a conservative linear chain. Each item depends only on its immediate predecessor. Will be refined to actual dependencies in Stage 3.3 after formalization.

### Stage 2.2: External Dependency Analysis
**Status:** Complete
**Date:** 2026-03-16
**Notes:** `dependencies/external.json` identifies 35 external dependencies. Categories: 26 undergraduate prerequisites, 3 external results, 5 folklore facts. All formalizable items have at least one external dependency listed.

### Stage 2.3: Blueprint Assembly
**Status:** Complete
**Date:** 2026-03-16
**Notes:** leanblueprint scaffolding in `blueprint/` with LaTeX source. 73 nodes in the dependency graph (38 items + 35 external deps). HTML dependency graph buildable via `plastex`. Scripts: `scripts/generate_blueprint.py`.

### Stage 2.4: Research — Mathlib Coverage
**Status:** Complete
**Date:** 2026-03-16
**Notes:** `research/mathlib-coverage.json` covers all 29 items; `research/external-coverage.json` covers all 35 external dependencies.

**Formalizable items (27 total, excluding 2 remarks tracked in coverage but not formalizable):**
- Fully covered by Mathlib: 20 (74%) — primarily wrappers around existing API
- Partially covered: 4 (15%) — core concepts exist, assembly or gap-filling needed
- Not covered: 3 (11%) — require original work

**Not-covered items (hardest):**
- Theorem 1.9: Product formula for absolute values on Q
- Example 1.24: Z[sqrt(5)] is not integrally closed
- Example 1.29: (1+sqrt(7))/2 is integral over Z

**External dependencies (35 total):**
- Fully covered: 30 (86%)
- Partially covered: 4 (11%)
- Not covered: 1 (3%) — discrete subgroups of R isomorphic to Z

### Stage 2.5: Research — External Sources
**Status:** Complete (partial)
**Date:** 2026-03-16
**Notes:** Issue #49 closed. `research/external-sources.json` was not delivered; however, `mathlib-coverage.json` and `external-coverage.json` provide the needed data for formalization. Low impact gap.

### Stage 2.6: Readiness Report
**Status:** Complete
**Date:** 2026-03-16
**Notes:** `READINESS.md` written. Categorizes 27 formalizable items by effort: 14 easy (Mathlib wrappers), 10 medium (assembly needed), 3 hard (from scratch). Identifies 5 parallel formalization batches and critical paths.

### Stage 2.7: Reference Attachment
**Status:** Complete
**Date:** 2026-03-16
**Notes:** 27 `.refs.md` files created under `blobs/Lecture1/`, one per formalizable item. Each contains relevant Mathlib declaration names, match types, and external dependency references. Manifest in `research/refs-manifest.json`. Script: `scripts/generate_refs.py`.

---

## Phase 3: Formalization — In Progress

### Stage 3.1: Lean Scaffolding
**Status:** Complete
**Date:** 2026-03-16
**Notes:** All 27 formalizable items scaffolded across 5 batches.

| PR | Batch | Items |
|----|-------|-------|
| #67 | Batch 1-2 | Defs 1.2, 1.6, 1.7, 1.17, 1.19; Ex 1.3; Lemma 1.4; Cor 1.5; Props 1.18, 1.28 |
| #69 | Batch 3 | Thm 1.8; Defs 1.10, 1.11; Prop 1.20; Cor 1.21 |
| #73 | Batch 4 | Defs 1.12, 1.13; Exs 1.14, 1.15; Thm 1.16; Props 1.22, 1.25; Cor 1.23 |
| #93 | Batch 5 | Def 1.26; Thm 1.9; Ex 1.24; Ex 1.29 |

### Stage 3.2: Proof Filling
**Status:** In progress — 26/27 sorry-free (96%)
**Date started:** 2026-03-16

**Proof filling PRs:**

| PR | Items | Strategy |
|----|-------|----------|
| #72 | Prop 1.18, Def 1.7, Ex 1.3 | Mathlib API wrappers |
| #76 | Prop 1.20, Cor 1.21 | DVR properties via Mathlib |
| #78 | Lemma 1.4, Cor 1.5 | Nonarchimedean tactic proofs |
| #79 | Prop 1.22, Cor 1.23, Prop 1.25 | Integral closure via Mathlib |
| #84 | Ex 1.14, Ex 1.15 | DVR examples — instance + computation |
| #87 | Thm 1.8, Thm 1.16, Prop 1.28 | Theorem wrappers around Mathlib |
| #95 | Def 1.26 | Number fields definition |
| #96 | Ex 1.29 | Non-integral element — nlinarith + algebraic |
| #100 | Ex 1.24 | Z[√5] not integrally closed — contradiction |

**Remaining:** Theorem 1.9 (Product Formula) — the hardest item, in progress (issue #91).

### Item Progress Summary

| Status | Count |
|--------|-------|
| `sorry_free` | 26 |
| `statement_formalized` | 1 |
| `not_applicable` | 11 |
| **Total** | **38** |

26 of 27 formalizable items are sorry-free. Only Theorem 1.9 remains.

### Stage 3.3: Dependency Trimming
**Status:** Blocked on Theorem 1.9 (issue #99)
**Notes:** Will replace the conservative linear chain in `dependencies/internal.json` with actual Lean import-derived dependencies once all proofs are complete.

---

## Merged PRs

### Phase 2 (since Phase 1 summary)

| PR | Title | Stage |
|----|-------|-------|
| #41 | Review: Verify structural foundation | QA |
| #46 | Stage 2.2: External Dependency Analysis | 2.2 |
| #47 | Review: Verify transcription quality | QA |
| #50 | Initialize progress/items.json | Infra |
| #52 | Stage 2.5 + Meditate: Phase 1 reflection and skills | 2.5 |
| #57 | Review: Verify PR #52 | QA |
| #60 | Stage 2.6: Readiness Report | 2.6 |
| #51 | Stage 2.3 Blueprint Assembly + Mathlib coverage | 2.3, 2.4 |
| #61 | Review: Fix and merge PR #51 | QA |
| #63 | Stage 2.7: Reference Attachment | 2.7 |

### Phase 3

| PR | Title | Stage |
|----|-------|-------|
| #67 | Stage 3.1a: Lean Scaffolding — Batch 1-2 | 3.1 |
| #69 | Stage 3.1b: Lean Scaffolding — Batch 3 | 3.1 |
| #72 | Stage 3.2a: Easy Mathlib API Proofs | 3.2 |
| #73 | Stage 3.1c: Lean Scaffolding — Batch 4 | 3.1 |
| #76 | Stage 3.2c: Prop 1.20, Cor 1.21 | 3.2 |
| #78 | Stage 3.2b: Nonarchimedean Proofs | 3.2 |
| #79 | Stage 3.2d: IC Proofs (Prop 1.22, Cor 1.23, Prop 1.25) | 3.2 |
| #83 | Fix items.json status for 6 definitions | Fix |
| #84 | Stage 3.2e: DVR Example Proofs (Ex 1.14, 1.15) | 3.2 |
| #87 | Stage 3.2f: Theorem Wrappers (Thm 1.8, 1.16, Prop 1.28) | 3.2 |
| #88 | Review: Fix items.json for Defs 1.12, 1.13 | QA |
| #93 | Stage 3.1d: Lean Scaffolding — Batch 5 | 3.1 |
| #94 | Meditate: 3 proof strategy skills | Skills |
| #95 | Stage 3.2g: Def 1.26 (Number Fields) | 3.2 |
| #96 | Stage 3.2i: Ex 1.29 (Non-Integral Element) | 3.2 |
| #98 | Review: Pre-Stage-3.3 compilation verification | QA |
| #100 | Stage 3.2h: Ex 1.24 (Z[√5] Not Integrally Closed) | 3.2 |

## Open Issues

| Issue | Title | Status |
|-------|-------|--------|
| #91 | Stage 3.2j: Theorem 1.9 (Product Formula) | Claimed — in progress |
| #99 | Stage 3.3: Dependency Trimming | Unclaimed — blocked on #91 |
| #101 | Review: Stage 3.2 Completion Gate | Unclaimed — blocked on #91 |

## Infrastructure and Skills

**Scripts** (in `scripts/`):
- `check_contiguity.py` — verifies blob coverage has no gaps or overlaps
- `extract_blobs.py` — splits page markdown into per-blob files
- `generate_blueprint.py` — generates leanblueprint LaTeX from items.json and dependency data
- `generate_refs.py` — generates .refs.md reference files from coverage data
- `init_items_progress.py` — initializes progress/items.json from items.json

**Skills** (in `.claude/skills/`):
- `agent-worker-flow` — standard claim/branch/verify/publish workflow
- `second-opinion` — get a second opinion from OpenAI Codex
- `acquiring-skills` — create or update Claude Code skills
- `ci-troubleshooting` — diagnostic steps for CI failures
- `parallel-agent-coordination` — best practices for avoiding merge conflicts
- `lean-proof-strategies` — strategies for filling sorry placeholders
- `mathlib-api-lookup` — searching for Mathlib declarations
- `aristotle-escalation` — automated theorem prover escalation

## Limitations and Gaps

- **Theorem 1.9 (Product Formula):** The sole remaining sorry — hardest theorem in the lecture, likely needs Aristotle escalation.
- **Dependencies still conservative:** The linear chain in `dependencies/internal.json` is a placeholder. Stage 3.3 (#99) will replace it with actual dependencies once all proofs are complete.
- **Blueprint HTML not in CI:** The leanblueprint HTML graph can be built locally but is not part of CI.
