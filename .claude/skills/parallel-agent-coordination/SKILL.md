---
name: parallel-agent-coordination
description: Use when multiple agents work in parallel, when PRs have merge conflicts from concurrent work, or when planning work that may overlap with other agents' in-flight PRs.
allowed-tools: Bash, Read, Grep, Glob
---

# Parallel Agent Coordination

## The Problem

Multiple pod agents run concurrently in separate worktrees. When two agents
modify the same files (especially `progress/items.json`, `progress/` entries,
or `dependencies/`), their PRs will conflict. The first to merge wins; the
second gets merge conflicts.

## Conflict-Prone Files

These files are modified by many different tasks and are the most common
source of merge conflicts between concurrent PRs:

| File | Why it conflicts | Mitigation |
|------|-----------------|------------|
| `progress/items.json` | Multiple agents update item statuses | Use atomic field updates, not full rewrites |
| `progress/*.md` | Timestamp collisions (rare) | Include session UUID prefix in filename |
| `dependencies/internal.json` | Dependency graph changes | Coordinate via issue dependencies |
| `PROGRESS.md` | Summary updates | Only summarize agents should touch this |

## Best Practices for Agents

### 1. Minimize shared file modifications

- Only update the specific fields you changed in `items.json`
- Use your session UUID in progress filenames: `progress/<timestamp>_<UUID-prefix>.md`
- Don't reformat or reorganize files you didn't need to change

### 2. Check for in-flight work before starting

```bash
coordination orient
```

Look at "Issues with open PRs" — if another agent has an open PR touching
the same files you plan to modify, consider:
- Waiting for that PR to merge first
- Working on a different item
- Making your changes compatible (additive only)

### 3. Rebase before creating PR

```bash
git fetch origin main
git rebase origin/main
```

This catches conflicts early. If conflicts exist, resolve them before
creating the PR — a PR with conflicts will never auto-merge.

### 4. When your PR has conflicts after creation

If `coordination orient` shows your PR has `[CONFLICTS]`:

1. Fetch the latest main: `git fetch origin main`
2. Rebase: `git rebase origin/main`
3. Resolve conflicts (prefer the version on main for shared files like
   `items.json` — then re-apply your specific changes on top)
4. Force push with lease: `git push --force-with-lease`

### 5. Planners: avoid creating overlapping work

When creating issues, check what's already claimed or has open PRs.
Don't create issues that would require modifying the same core files
as in-flight work unless the issues have explicit dependencies.

## Progress File Convention

The `_<UUID-prefix>` suffix on progress files was introduced specifically
to prevent merge conflicts. Always use it:

```
progress/2026-03-16T08-15-00Z_1d7941eb.md  # good — unique per agent
progress/2026-03-16T08-15-00Z.md            # bad — may collide
```

Early progress files without UUID suffixes predate this convention.
