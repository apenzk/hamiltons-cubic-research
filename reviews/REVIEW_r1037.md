# r1037: the three gates added 2026-09-21, and the `Searched:` guard

**Scope.** [both_loops_balance.py](../.claude/hooks/both_loops_balance.py), [lean_blocked_debt.py](../.claude/hooks/lean_blocked_debt.py), [lean_orphans.py](../scripts/misc/lean_orphans.py) with its [pre-commit](../.githooks/pre-commit) wiring, and the `references/` guard in [cycle_deliverable.py](../.claude/hooks/cycle_deliverable.py).

| gate | fires when it should | false positive | false negative | verdict |
|---|---|---|---|---|
| [both_loops_balance.py](../.claude/hooks/both_loops_balance.py) | yes | **severe**, 40 of 138 historical HEADs | none found | **CONFIRMED defective** |
| [lean_blocked_debt.py](../.claude/hooks/lean_blocked_debt.py) | yes, and it is firing now | **severe**, greps English words | **live**, one of two real trailers | **CONFIRMED defective** |
| [lean_orphans.py](../scripts/misc/lean_orphans.py) | yes | real but narrower than reported | ignores untracked, by design | **CONFIRMED, with the blast radius overstated elsewhere** |
| [cycle_deliverable.py](../.claude/hooks/cycle_deliverable.py) guard | n/a | none | **trip on demand, and it leaks** | **CONFIRMED defective** |
| Stop chain deadlock | | | | **REFUTED as absolute, PLAUSIBLE as a race** |

## 1. both_loops_balance.py: a `docs(` research deliverable does not reset the counter

The counter reads only subjects matching `^(feat|fix)\(` and `continue`s past everything else, so a research cycle that closes on `docs(findings)`, `docs(gate2)` or `docs(review)` is invisible to it. Every other commit type is equally invisible, `chore(lean)` included.

Replaying the logic against the real log at each of the last 138 commits as HEAD, **it would have fired at 40 of them, 29 per cent**. Two shapes from that replay:

- `HEAD=24` is `docs(review): skeleton for r1033`, a research-loop deliverable sitting at HEAD, and the gate fires anyway on three Lean commits beneath it.
- `HEAD=36..38` sits under a run of `docs(lean)` and `docs(lean-debt)` commits with the same result.

Two further false positives, both probed directly:

- **History is not session-scoped.** Three Lean commits left by yesterday's session make the gate fire at the FIRST stop of a fresh session, before that session has done anything at all. This is the common case, because the Lean loop commits `feat(lean)` every round.
- **The escape is narrow.** Only a non-Lean `feat(` or `fix(` clears it. A session told to "take plan.md's top live item now" that does so and commits the result as `docs(findings)` is blocked again on the next turn, and on every turn after, short of `.claude/stop-declared`.

The docstring's claim, "no other work commit between them", is true only if "work commit" excludes every `docs(` deliverable the research loop actually writes.

**Fix.** Reset the run on any commit whose scope is not Lean, whatever its type, rather than only on `feat(`/`fix(`. Bound the window to commits made since the session armed, by comparing against the flag file's mtime, so a previous session's Lean run cannot fire it. `run = 0` on line 97 is dead, the `break` follows it unconditionally.

## 2. lean_blocked_debt.py: the extractor takes the first English word of four letters

`IDENT` is `[A-Za-z_][A-Za-z0-9_.'!?₀-₉]{3,}`, which matches any word of four or more characters, and only the first match is taken. The grep that follows is `git grep` with no `-w` over all of `lean/`, so it matches substrings and it searches `lean/INDEX.md` and `lean/plan-lean.md` as well as the source.

**Both failure modes are already present in the live corpus of two real trailers.**

| commit | reason text, start | extracted | files hit in `lean/` | effect |
|---|---|---|---|---|
| [7abac33](https://github.com/apenzk/hamiltons-cubic/commit/7abac33) | "the joint Gram system needs..." | `joint` | 86 | **debt silently marked paid** |
| [3b8232b](https://github.com/apenzk/hamiltons-cubic/commit/3b8232b) | "second_order_face, absent..." | `second_order_face` | 0 | blocks, correctly |

So the gate is right once in two. **`second_order_face` is 24 commits back, above AGE, absent from the whole tree, and carries no void trailer, so this gate blocks the stop of every armed session right now.** That is a true positive and the gate doing its job.

Probed extractions, all confirmed end to end against a constructed repo:

| reason | extracted | outcome |
|---|---|---|
| "`Foo` is not expressible in the base layer" | `expressible` | blocks forever, naming a word that is not a declaration |
| "the object is absent\n  Missing_decl_here is the name" | `object` | blocks on line 1, never sees the real name on line 2 |
| "toolchain is held by a Gate, so nothing can be typed" | `toolchain` | greps a prose noun |
| "`AltFace.comm` cannot be stated yet" | `AltFace.comm` | correct |

A backticked name of three characters is skipped entirely, because `{3,}` after the first character sets a four-character floor.

**The `Lean: void` escape is abusable in three ways, all probed.**

- A void trailer written **before** the blocked commit still closes it. The voided set is built globally with no ordering.
- A commit body that merely **quotes** the line at column zero closes it. A review commit whose body reproduces this gate's own instruction, `Lean: void -- <name> <why>`, voids every debt whose extracted token is `name`, which the multi-line case above produces.
- Nothing verifies a void. Any commit closes any debt by naming it, which is the intended hatch, but combined with the extractor above the wrong debt is closed routinely.

**Fix, and it is already written 240 lines away.** [cycle_deliverable.py](../.claude/hooks/cycle_deliverable.py) carries `DECL_NAME`, which requires an internal capital, digit, underscore or dot, and `_declared_in_layer`, which greps `-w` and scopes to `lean/HamiltonsCubic`. Against the four bad reasons above `DECL_NAME` returns the empty list every time, and returns `second_order_face` for the good one. Import both. Take **all** names rather than the first, treat an empty list as "this trailer named nothing checkable" rather than as a name to grep, and require the void to be newer than the debt it closes.

## 3. lean_orphans.py: keys on the directory walk, and the wedge is real but narrower than recorded

`os.walk` over `lean/HamiltonsCubic/` counts every `.lean` file on disk, tracked, untracked or gitignored. Probed: an untracked `probe_scratch.lean` and a would-be-ignored `AxiomAudit.lean` each produce exit 1.

**The blast radius claimed in [REVIEW_r1036.md](REVIEW_r1036.md) and in [axiom_audit.py](../scripts/misc/axiom_audit.py), "refuses every commit in every session", is REFUTED.** [pre-commit](../.githooks/pre-commit) computes the staged Lean files first and exits 0 when there are none, and exits 0 again when `lake` is absent. The orphan check runs only on a commit that stages a `lean/**.lean` file. Confirmed by probe: with only `README.md` staged the check is never reached. The correction matters, because the recorded claim is what would drive an over-large fix.

What is still true is that the Lean loop stages a Lean file every round, so a stray `.lean` under the package wedges precisely the loop that needs to commit, and `--no-verify` is the only bypass.

**The cheap narrowing works and keeps the whole protection.** Replace the walk with `git ls-files -- 'lean/HamiltonsCubic/*.lean'`. Probed: the index omits an untracked scratch file, and it lists a newly added module the moment it is staged, which is exactly when the orphan check needs to see it. Nothing being committed escapes, and nothing that is not being committed can wedge the commit.

One brittleness found: the import regex is `^import (HamiltonsCubic[\w.]*)`, so `import  HamiltonsCubic.Base.A` with two spaces makes every module an orphan at once.

## 4. The `Searched: ... references/` guard: a guard any commit can trip, and it clears more than it was meant to

Probed against a constructed repo with 30 searchless commits behind it:

| commit message | result |
|---|---|
| `Searched: none -- the record first, nothing outside` | refused, correctly |
| `Searched: sphere packing -> references/real-slug/` | passes |
| `Searched: anything at all -> references/totally-made-up-xyz/` | **passes, and the slug does not exist** |
| a bullet reading "filed under references/foo/" with `Searched: none` | refused, correctly |

So the anchored regex does keep a prose mention from tripping it, which is the one thing the guard gets right. **It does not check that the cited path exists**, so the searchless-run cap is cleared by typing any slug at all.

**The larger defect is that the guard returns from `main` rather than skipping one check.** Probed: a commit that would be the **sixth** consecutive `Deliverable: none`, against a limit of three, is refused when its `Searched:` is `none` and **passes** when its `Searched:` names a references path. The guard was written to clear the searchless run and it silently clears the measuring-cycle cap as well, which is an unrelated gate with its own reason for existing.

**Fix.** Guard the `srun` check alone rather than returning, and require `os.path.isdir` on the cited slug under [references/](../references/) before the guard applies.

## 5. Interaction: no absolute deadlock, one race on the single escape

**No state was found in which no commit and no stop is possible.** Three findings support that.

- **The two new Stop gates demand opposite commit scopes, and sequencing escapes.** [lean_blocked_debt.py](../.claude/hooks/lean_blocked_debt.py) asks for the declaration typed now, which is a `feat(lean)` commit, and that commit lengthens the run [both_loops_balance.py](../.claude/hooks/both_loops_balance.py) is counting. Doing the research item first and the Lean commit second clears both in one turn.
- **[cycle_deliverable.py](../.claude/hooks/cycle_deliverable.py) cannot close the last door.** With three `none` spent, three `refutation` spent and three `Lean: blocked` spent, `Deliverable: dead-end` carries no run cap and remains available. Separately, the subject scope is what `both_loops_balance` reads, so `feat(findings)` with a staged Lean file satisfies both gates at once.
- **`.claude/stop-declared` is honoured by all four Stop hooks**, confirmed by probe on the two new ones.

**Two real interaction defects, neither fatal.**

**The TTL drift, CONFIRMED by probe.** [loop_flag.armed_for](../.claude/hooks/loop_flag.py) requires a `session:` line and expires the flag after 12 hours. The two new gates instead read `readline().endswith(sid)` with no TTL and no format requirement. With the flags aged 13 hours: `armed_for` returns False for both loops, [loop_stop.py](../.claude/hooks/loop_stop.py) and [cycle_deliverable.py](../.claude/hooks/cycle_deliverable.py) go inert, and both new gates still exit 2. The session then has no loop giving it a task, ungated commits, and a stop it cannot take. Both new gates should call `armed_for`.

**The race on the escape file, PLAUSIBLE.** [loop_stop.py:626](../.claude/hooks/loop_stop.py#L626) **deletes** `stop-declared` when it consumes it. The two new gates only test that it exists. Hooks in one matcher group run concurrently, so `loop_stop` can unlink the file between the other two reading and acting, which blocks the stop and destroys the escape in the same event. The window is small and the retry is unbounded. Consuming it by rename, or having the new gates honour a consumed-marker, removes the race.

## How the analysis-only rule was honoured

Every run here was seconds of compute on objects constructed for the probe: small throwaway git repositories under the session scratchpad, the four hooks invoked directly with crafted stdin, and one replay of the existing `git log` through the counter's own logic. No sweep, no census, no optimisation of unknown cost, no unbounded hunt, and no `lake build`. No file was written under `lean/HamiltonsCubic/` in this repository, and the one orphan probe ran against a copy of the script in a scratch tree of its own.

## Addendum: the author's repair of lean_blocked_debt.py, checked

[lean_blocked_debt.py](../.claude/hooks/lean_blocked_debt.py) was amended during this review, citing r1037. The repair adds `DECL_LIKE`, requiring an internal capital or an underscore, takes all `IDENT` matches and filters, reports an unreadable trailer as UNPARSEABLE rather than passing it, and raises `LOOK` from 200 to 500. **The extraction defect is fixed.** Re-run against live history: [7abac33](https://github.com/apenzk/hamiltons-cubic/commit/7abac33) now resolves to `sharedChannelGram` rather than `joint`, and [3b8232b](https://github.com/apenzk/hamiltons-cubic/commit/3b8232b) is closed by the void trailer now in the log.

**Three residuals survive it.**

- **The void side was not repaired.** `voided` is still built with `IDENT.search`, the first long token, while the debt side is now `DECL_LIKE`-filtered. Probed: `Lean: void -- the name sharedChannelGram was wrong` voids `name` and closes nothing, and `Lean: void -- the claim it served was refuted, so sharedChannelGram is void` voids `claim`. The escape hatch fails silently on any void whose reason opens in prose, which is the shape the gate's own message invites. Apply the same filter on both sides.
- **The grep is still loose.** `git grep` without `-w` over all of `lean/` covers [lean/INDEX.md](../lean/INDEX.md) and [lean/plan-lean.md](../lean/plan-lean.md), so writing the name into the index discharges the debt without any declaration existing, and a substring of a longer identifier discharges it too. `_declared_in_layer` in [cycle_deliverable.py](../.claude/hooks/cycle_deliverable.py) already greps `-w` and scopes to `lean/HamiltonsCubic`.
- **Raising `LOOK` to 500 turned a dormant trailer into a live block.** `sharedChannelGram` is 383 commits back and absent from the tree, so every armed session is now blocked on it until the declaration is typed or a void trailer lands. That is the gate working as designed, and it is worth recording that the window change, rather than any new commit, is what made it bite.

Void ordering remains unchecked: a void written before the debt still closes it.
