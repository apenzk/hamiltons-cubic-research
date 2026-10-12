# r1038: the repairs r1037 asked for, audited against the gates that now run

**Scope.** The three repair commits `7750ef26`, `f31245f8`, `f38dac8b`, made by the author r1037 audited, and the eight claims they carry. Every finding below was reached by invoking the hook with crafted stdin against a repository built for the probe, or by replaying the hook's own logic over this repository's real log.

| # | claim | verdict |
|---|---|---|
| 1 | [both_loops_balance.py](../.claude/hooks/both_loops_balance.py) no longer false-positives | **REFUTED**: the false positive was traded for a total false negative. The gate could never fire |
| 2 | [lean_blocked_debt.py](../.claude/hooks/lean_blocked_debt.py)'s VOID side uses the debt side's extractor | **REFUTED as a fix**: parity is real, and the shared extractor refuses 505 of the layer's 6047 declaration names into an unclosable block |
| 3 | the Searched guard in [cycle_deliverable.py](../.claude/hooks/cycle_deliverable.py) skips only its own check | **CONFIRMED** |
| 4 | both new gates use [loop_flag.armed_for](../.claude/hooks/loop_flag.py) | **CONFIRMED** |
| 5 | the stop-declared race is closed by a sentinel | **REFUTED as closed**: [lean_loop_stop.py](../.claude/hooks/lean_loop_stop.py) never reads the sentinel and deterministically loses to the deleter |
| 6 | [forcing_at_recorded_deficit](../lean/HamiltonsCubic/Results/I104GramSystem.lean) types the note's constant | **CONFIRMED as arithmetic**, and the constant it types is the one the record withdrew |
| 7 | the sharedChannelGram debt is VOID rather than unpaid | **REFUTED**: the obligation is real, still open, and named by the record three lines from the theorem that is said to discharge it |
| 8 | [loop_pdf.py](../scripts/misc/loop_pdf.py) renders the loop READMEs | **PLAUSIBLE**: it reproduces exactly and fails silently |

## 1. The window is keyed to a file the flag reader rewrites on every read

The run-break half of the repair is right. Replaying the new [LEAN_SCOPE](../.claude/hooks/both_loops_balance.py) and [CONVENTIONAL](../.claude/hooks/both_loops_balance.py) over the last 138 heads of real history, the gate would fire at 30 rather than r1037's 40, and r1037's headline case, `HEAD=24` with `docs(review): skeleton for r1033` sitting at HEAD, is gone. The 30 that remain are runs of purely Lean-scoped commits, which is the imbalance the gate exists to name.

**The window half kills the gate outright.** [armed_for](../.claude/hooks/loop_flag.py) ends with `os.utime(path, None)`, a heartbeat added on 2026-09-04 in `89aa0285` so that a live cycle keeps its own flag from ageing past the TTL. So the flag's mtime is not when the session armed, it is when a hook last read the flag and found it armed, which in this gate is three lines earlier in the same function. `since` is therefore always the current second, `--since=@now` returns nothing, and `run` cannot reach 3.

Probed end to end on a repository holding three `feat(lean)` commits at HEAD and both flags armed to the calling session:

| run | exit |
|---|---|
| the hook as committed | **0**, the gate is silent |
| the same hook with `os.utime` suppressed and nothing else changed | **2**, the gate fires |

Claim 1 is true only in the sense that a gate which never runs never false-positives. There is no configuration of history that trips it, so the false-negative rate is total.

**Superseded during this review.** [both_loops_balance.py](../.claude/hooks/both_loops_balance.py) changed on disk mid-audit: the window now comes from `.claude/.both-loops-since`, a marker keyed by session id and written once, which no heartbeat touches. I probed that version too and it behaves:

| state | exit |
|---|---|
| fresh session, three Lean commits already in history | 0 |
| three Lean commits made during the session | 2 |
| a `docs(findings)` deliverable lands | 0 |
| three more Lean commits | 2 |
| a different session id | 0 |

Two residuals on the replacement, both small. The marker is written at the gate's first invocation rather than at arming, so Lean commits made between arming and the first Stop of the session fall outside the window, an exposure of one turn. And `int(since)` truncates to the second, so a commit made in the same second as the marker is inside the window: that is what produced a spurious `2` on the first row until the probe put a two-second gap before arming.

## 2. The extractor refuses 8.4 per cent of the layer, and refusal cannot be closed

Parity is real. Both sides now run [IDENT](../.claude/hooks/lean_blocked_debt.py) then [DECL_LIKE](../.claude/hooks/lean_blocked_debt.py) and take the first survivor, the debt side through a list comprehension and the void side through a `break`, which agree on every input.

**`Foo` is refused for the right reason and the wrong rule.** `DECL_LIKE` demands an underscore or a capital that is not the first character. Extracted from every `theorem`, `lemma`, `def`, `abbrev`, `structure`, `inductive`, `class` and `instance` in `lean/`, that refuses **505 of 6047 real declaration names**:

| shape | count | examples |
|---|---|---|
| lowercase, no underscore | 351 | [forcing](../lean/HamiltonsCubic/Results/I104GramSystem.lean), `balance`, `bridge`, `budget`, `bound` |
| shorter than four characters | 193 | `A`, `B_u`, `E_6`, `J4` |
| capitalised single word | 69 | `Bivector`, `Admissible`, `Eigenframe`, `Diagonalizable`, `Feasible` |

**And a refused name is an unclosable block.** The `unparseable` branch runs before the grep and before the `voided` set is consulted, so neither paying the debt nor voiding it clears the trailer. Probed on a repository carrying `Lean: blocked -- forcing, the base layer cannot express it yet` followed by `Lean: void -- forcing, the obligation ceased to exist`, the gate exits 2 and prints advice that does not work:

```
A `Lean: blocked` TRAILER NAMES NO DECLARATION THAT CAN BE READ.
  10123c7  forcing, the base layer cannot express it yet
  ... or close it with `Lean: void -- <name> <why>`.
```

`forcing` is a declaration this repository holds, in the file this session wrote. A trailer naming it blocks every stop of every armed session for 500 commits, and the only escape is `.claude/stop-declared`. That failure mode did not exist before the repair, because the old extractor always found some token.

**One residual from r1037 survives untouched.** The grep is still `git grep -l <name> -- lean/` with no `-w` and no restriction to declaration syntax, so a name mentioned in prose marks the debt paid. This is live now: `sharedChannelGram` appears in `lean/` exactly once, [at line 89 of I104GramSystem.lean](../lean/HamiltonsCubic/Results/I104GramSystem.lean), inside a docstring saying the declaration will never be written. Absent the void trailer, that mention alone would close the debt.

## 3. The Searched guard: CONFIRMED

`_cited` now zeroes `srun` and nothing else, and the slug must be a directory under `references/`. Probed against a repository with two consecutive `none` cycles in history:

| the commit in hand | exit |
|---|---|
| `Deliverable: none`, `Searched: none -- x` | 2, the run cap |
| `Deliverable: none`, cites `references/no-such-slug/` | 2, the run cap |
| `Deliverable: none`, cites `references/real-slug/`, which exists | 2, the run cap |

The third row is the leak r1037 found, and it is shut. One residual: `os.path.isdir` reads the working tree, so an empty untracked directory satisfies the citation. The guard now costs one `mkdir` to trip rather than nothing.

## 4. The shared flag reader: CONFIRMED

Probed on both gates with the flag aged either side of the 12-hour TTL, and with a session id that does not own the flag:

| flag state | [lean_blocked_debt.py](../.claude/hooks/lean_blocked_debt.py) | [both_loops_balance.py](../.claude/hooks/both_loops_balance.py) |
|---|---|---|
| fresh, owned by the caller | 2 | 0, for the reason in section 1 |
| 13 hours old | 0 | 0 |
| fresh, owned by another session | 0 | 0 |

The TTL and the session binding both reach both gates.

## 5. The sentinel helps the two gates that write it, and the loser of the race is a third hook

The sentinel itself is sound as state. It carries a timestamp in its **content** rather than relying on its mtime, so a file left behind expires by arithmetic and a stale one cannot silence anything beyond 90 seconds of its own writing. It is gitignored, committed in `f31245f8`, and that matters only for tidiness: a committed sentinel would arrive in a clone already expired.

**The race is not closed, because the hook that loses it was not changed.** The Stop chain in [settings.json](../.claude/settings.json) is [both_loops_balance.py](../.claude/hooks/both_loops_balance.py), [lean_blocked_debt.py](../.claude/hooks/lean_blocked_debt.py), [loop_stop.py](../.claude/hooks/loop_stop.py), [lean_loop_stop.py](../.claude/hooks/lean_loop_stop.py). Two of those delete `.claude/stop-declared` when they honour it, and **neither writes the sentinel**. Only the two gates write it, and they write it in the one case where they were already going to return 0.

[lean_loop_stop.py](../.claude/hooks/lean_loop_stop.py) still tests for the file alone. Probed with a sentinel written 0 seconds earlier and the declaration already consumed, which is the state [loop_stop.py](../.claude/hooks/loop_stop.py) leaves behind:

```
lean_loop_stop.py EXIT 2 | lean loop: a round closed, which is not a stopping point.
```

In a both-loops session both of those hooks are armed, `loop_stop` is listed before `lean_loop_stop`, and `loop_stop` deletes the file. So in the ordering the settings file declares this is deterministic rather than a race: a declared stop is consumed by the research loop's hook and the Lean loop's hook then blocks the turn anyway. **The repair should be in the deleter.** Whichever hook removes `.claude/stop-declared` should write `.stop-declared-seen` in the same breath, and every hook that tests for a declaration should read both.

90 seconds is generous for a hook chain that completes in well under a second, and the generosity costs little, since the gates are inert outside an armed session in any case.

## 6. The arithmetic is exact, the constant is the one the record withdrew

Checked in exact rationals and then in the kernel.

| claim | result |
|---|---|
| `8753/62500` is exactly `0.140048` | true, and `norm_num` accepts it |
| `5/6 * 8753/62500 = 8753/75000` | true, and `norm_num` accepts it |
| `8753/75000` | `0.11670666…` |
| the hypothesis direction | matches the note: `d` bounds the x-dependent part from **below**, and [forcing](../lean/HamiltonsCubic/Results/I104GramSystem.lean) concludes a lower bound on the sum of squares. No inequality is flipped |

`#print axioms`, run through `lake env lean` on the built module:

```
'HamiltonsCubic.I104GramSystem.forcing_at_recorded_deficit' depends on axioms: [propext, Classical.choice, Quot.sound]
```

The other four declarations report the same three. No `sorry`.

**Two defects sit on top of correct arithmetic.**

- **The docstring's reassurance is backwards.** It says the note's decimal is this rational "rounded DOWN, which is the safe direction for a lower bound". The note prints `0.116707`, and `0.116707 > 0.11670666…`, so it is rounded **up**: the note's printed bound is very slightly stronger than the theorem gives, by `3.3e-9`. The safe direction is the one the docstring names, and the note goes the other way.
- **The configuration was excluded a day before the theorem was written.** [LEDGER.md](../findings/LEDGER.md) records that the forcing at `0.1167` "is computed at $t=0.598$, a configuration the Gram bound EXCLUDES", and [the note](2026-09-14-I104-tau-positive.md) restates the live figure at the surviving `t=0.346`: the x-free part is violated by `0.228322` and `S_2 \ge 0.190268`. The new theorem calls `0.140048` "**THE RECORDED CONSTANT ITSELF, at the failing configuration's deficit**" without a word about that. The specialisation the record would actually use is `forcing` at `d = 114161/500000`, giving `114161/600000 = 0.19026833…`.

Separately, [axioms.json](../lean/axioms.json) still lists only the four older declarations and was not refreshed when `forcing_at_recorded_deficit` landed.

## 7. Voiding the debt discards a real obligation, and the record says what it is

This is the finding.

The trailer on `7abac33` read: "the joint Gram system needs an inner-product space with a distinguished shared channel, and no declaration named sharedChannelGram or its equivalent exists in the base layer, which carries matrices and no such decomposition."

The void trailer answers a different question from the one the debt asked. It is right that **the forcing** needs no such object: `Σ u_a² - t ≤ 9/10 S_1² - 3/2 S_2` chained with Cauchy-Schwarz is four inequalities between reals, and [forcing](../lean/HamiltonsCubic/Results/I104GramSystem.lean) types exactly that. But the debt named **the joint system**, which is the hypothesis the forcing consumes, and the system is the thing that needs the decomposition `q_a = α_a e_a + β_a f_a`, the shared channel `e_a`, and the Gram matrix `G_e`.

**The file that is said to discharge the debt says so itself**, under its own heading:

> ## What is NOT stated
> That the system holds, which is the record's own derivation from the minimality of the `e`-part and needs the Gram matrix `G_e` and its inverse.

[lean/INDEX.md](../lean/INDEX.md) repeats it verbatim, and so does [the note](2026-09-14-I104-tau-positive.md): "**NOT typed**: that the system HOLDS, which is this file's own derivation from minimality of the $e$-part and needs $G_e$ and its inverse."

So the obligation is not void, it is open and unmoved. Three files name it, in the same words, in the same session that closed it as void. What the void trailer actually establishes is that the debt was **misnamed**: `sharedChannelGram` is a poor name for "the joint system holds", and the base-layer excuse was false, since `G_e` is a `3 x 3` rational matrix that Mathlib expresses without difficulty. Those are grounds for **restating** the debt, not for voiding it.

The cost of voiding is precise. The record keeps the obligation in prose, where it has already aged 385 commits unread, which is the exact failure [lean_blocked_debt.py](../.claude/hooks/lean_blocked_debt.py) was built to end. Voiding removes it from the only ledger a script reads. **The debt should be reopened under a name that says what it is**, and `joint_system_holds` or `gram_system_of_e_part` are both readable by the extractor.

## 8. loop_pdf.py: it works, and it is quiet about the one way it breaks

Reproduced exactly, on this machine, from a clean invocation:

| invocation | result |
|---|---|
| `loop_pdf.py out.pdf` | 309 KB, **13 pages**, from research-loop, lean-loop, both-loops |
| `loop_pdf.py out.pdf --all` | 429 KB, **21 pages**, adding structure-check and verification-loop |

Discovery works as described, and `--all` is stripped from the positional arguments before the output path is read, so the flag is order-free.

**The no-network failure is silent, and the script holds the number that would catch it.** Rendered with the mermaid URL pointed at an unreachable host, everything else unchanged:

```
.../loops_nonet.pdf  208 KB, 7 pages, from research-loop, lean-loop, both-loops
```

Exit 0, a success line indistinguishable in shape from the good one, and **six of thirteen pages missing**. The docstring's warning is accurate and it is in the wrong place: it is read by whoever edits the script, and the person who needs it is whoever runs it on a train. The script already counts pages and already knows how many mermaid fences it stashed, so one comparison would turn a silent halving into a named failure.

One smaller inconsistency: `verification-loop` carries a `ROLES` entry, "checks the record with readers", and is excluded from the default three, so the PDF titled "The Three Loops" omits a loop and includes [both-loops](../.claude/skills/both-loops/README.md), which is a session arrangement rather than a loop.

## What is owed

| # | repair |
|---|---|
| 1 | landed during this review, as `.claude/.both-loops-since`. Audited above and it behaves |
| 2 | let the `unparseable` branch consult `voided` and the grep first, so a debt can always be closed, and widen `DECL_LIKE` or fall back to the layer's own declaration names when nothing matches |
| 5 | write `.stop-declared-seen` in [loop_stop.py](../.claude/hooks/loop_stop.py) and [lean_loop_stop.py](../.claude/hooks/lean_loop_stop.py) where they delete the declaration, and read the sentinel in [lean_loop_stop.py](../.claude/hooks/lean_loop_stop.py) |
| 6 | correct "rounded DOWN" to up, add the specialisation at the surviving `d = 114161/500000`, and refresh [axioms.json](../lean/axioms.json) |
| 7 | reopen the debt under a readable name for "the joint system holds" |
| 8 | assert the rendered diagram count against the fence count, and decide whether `verification-loop` belongs in `PREFERRED` |

## How the analysis-only rule was honoured

No sweep, no census, no optimisation. Every run was seconds on objects in hand, except `lake env lean` on the already-built module, which is the single file the claim names and took under two minutes. The replay of [both_loops_balance.py](../.claude/hooks/both_loops_balance.py) over 138 heads is this repository's own log read once through the hook's own regular expressions, and the declaration-name count is one pass over the files `git ls-files lean/` already lists. Each hook probe built a small repository for that probe and invoked the hook with crafted stdin, which is the screening allowance exactly. No numerical result is offered as evidence for a positive mathematical claim: section 6's arithmetic is exact rational arithmetic and then the Lean kernel, and section 7 is a reading of the record.
