# Gate 2 brief (one reader): the r1853 fold and CPmE.lean as committed

**This round compares text against something fixed, so it has one reader.** Verdict per item: CONFIRMED, PLAUSIBLE or REFUTED with corrections. **Analysis-only footing**: read and compare, computing only to check a value, the smallest computation that does it.

## Item 1: the fold against the findings it answers

Commit `9edacfe1` folds [REVIEW_r1853.md](REVIEW_r1853.md) into [2026-09-28d-I121-smallmass-direct.md](2026-09-28d-I121-smallmass-direct.md) and [INDEX.md](INDEX.md). Read r1853 in full, then `git show 9edacfe1`, and check: every correction (a) to (f) and the docstring extension is applied as r1853 states it, the recomputed margin sentence says what r1853 computed (fails at the matching threshold by 0.002, holds from $t^2\approx0.08$ at unit $W$), and nothing new entered under cover of the fold.

## Item 2: CPmE.lean as committed

`lean/HamiltonsCubic/Results/CPmE.lean` at HEAD. r1853 reviewed a scratchpad draft (its copy is at `/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d3790d3b-3383-4c5d-9548-46ea15965c86/scratchpad/r1853/CPmE_r1853.lean`). Check that the committed `cp_norm`, `cp_cube`, `cp_E_poly` and `cp_E` are the reviewed ones, that `cp_theta` states the equality of the two forms of $\theta$ that r1853 compiled, and that the docstring's typed and untyped lists are accurate. Run `#print axioms` on `cp_theta` and `cp_E` if you can (a `lake env lean` call from `lean/` on a copy outside `lean/HamiltonsCubic/`).

## Lean table

| item | declaration | covers |
|---|---|---|
| 2 | `cp_norm`, `cp_cube`, `cp_E_poly`, `cp_E`, `cp_theta` | compare against r1853's reviewed draft and the note |
| 1 | none: a fold of prose | compare |
