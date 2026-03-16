---
name: aristotle-escalation
description: Use when a Lean proof has failed 2-3 attempts and needs to be sent to Aristotle for automated proving, or when checking the status of a previously submitted Aristotle job.
allowed-tools: Read, Edit, Bash, Glob, Grep
---

# Aristotle Escalation for Hard Proofs

Aristotle is an automated theorem prover. Use it when Claude can't prove a theorem after 2-3 serious attempts. The CLAUDE.md documents the protocol; this skill provides the concrete steps.

## When to Escalate

Escalate when:
- You've made 2-3 genuine attempts with different strategies (not just retrying the same approach)
- The proof requires non-trivial mathematical reasoning beyond tactic application
- The formalized statement is believed to be correct (don't submit wrong statements)

Do NOT escalate:
- Definitions or non-theorem items
- Statements you suspect are wrong — fix the statement first
- Items that failed due to missing imports or type errors (fix those first)

## Preparation Steps

### 1. Verify the Statement Compiles

The file must compile with `sorry` in place of the proof:

```bash
lake env lean SutherlandNumberTheoryLecture1/Chapter1/TheoremX_Y.lean
```

If there are errors other than the sorry warning, fix them first.

### 2. Create a Temporary Submission File

Copy the item's Lean file. Replace ALL sorries EXCEPT the target proof with `admit`:

```bash
cp SutherlandNumberTheoryLecture1/Chapter1/TheoremX_Y.lean /tmp/TheoremX_Y_pending.lean
```

Edit `/tmp/TheoremX_Y_pending.lean`:
- Keep exactly ONE `sorry` — the proof you want Aristotle to fill
- Change all other `sorry` to `admit` (so Aristotle knows they're not targets)
- Keep all imports, namespaces, and notation intact

### 3. Gather Context Files

Find sorry-free local Lean files that the target imports:

```bash
# List imports from the file
grep "^import SutherlandNumberTheoryLecture1" SutherlandNumberTheoryLecture1/Chapter1/TheoremX_Y.lean

# For each import, check if it's sorry-free
grep -c sorry SutherlandNumberTheoryLecture1/Chapter1/ImportedFile.lean
```

Only include files with 0 sorries as context. If no local files are sorry-free, submit with no context files.

### 4. Check for Duplicate Submissions

```bash
# Check items.json for existing Aristotle submission
grep "TheoremX_Y" progress/items.json
```

If the item already has status `sent_to_aristotle`, do NOT resubmit.

## Submission

```bash
aristotle prove-from-file /tmp/TheoremX_Y_pending.lean \
  --no-wait \
  --no-auto-add-imports \
  --context-files SutherlandNumberTheoryLecture1/Chapter1/SorryFreeFile1.lean SutherlandNumberTheoryLecture1/Chapter1/SorryFreeFile2.lean
```

Record the project ID from the output.

### Update Tracking

Update `progress/items.json` — set the item's status to `sent_to_aristotle` and record the project ID:

```json
{
  "id": "Lecture1/Theorem1.9",
  "status": "sent_to_aristotle",
  "aristotle_project_id": "<project-id-from-output>"
}
```

### Clean Up

Delete the temporary file — never commit files containing `admit`:

```bash
rm /tmp/TheoremX_Y_pending.lean
```

## Checking Results

```bash
aristotle status <project-id>
```

### On Success

1. Copy the proof from Aristotle's output into the item's Lean file
2. Verify it compiles: `lake env lean SutherlandNumberTheoryLecture1/Chapter1/TheoremX_Y.lean`
3. Update `progress/items.json` to `sorry_free` (if all sorries resolved) or `proof_formalized`

### On Failure

| Result | Action |
|--------|--------|
| **False statement** | Set status to `attention_needed`, create GitHub issue with the counterexample |
| **Timeout** | Set status to `attention_needed`, note in progress file, move on |
| **Version mismatch** | Set status to `attention_needed`, may need toolchain update |
| **Proof found but doesn't compile** | Try adapting the proof manually, otherwise mark `attention_needed` |

## Hard Items Likely Needing Aristotle

Based on the Stage 2.6 readiness report, these items are rated "Hard" with no direct Mathlib coverage:

- **Theorem 1.9 (Product Formula)**: `|x|_inf * prod_p |x|_p = 1` for x in Q*. Hardest theorem in the lecture. The formalization challenge is expressing "product over all places of Q."
- **Example 1.24 (Z[sqrt(5)] not integrally closed)**: Counterexample proof — show (1+sqrt(5))/2 is integral over Z but not in Z[sqrt(5)].
- **Example 1.29 (Non-integral element)**: Show (1+sqrt(7))/2 is not integral over Z by computing its minimal polynomial has non-integer coefficients.

For these items, try 2 manual approaches first (see `lean-proof-strategies` skill), then escalate to Aristotle.
