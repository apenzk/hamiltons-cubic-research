# r1039: the repairs r1038 asked for, audited against the gates and the kernel

**Scope.** Commits `bc2ad176` and `25afcac1`, and the seven claims they carry. Every verdict below comes from invoking the hook with crafted stdin on a repository built for the probe, from replaying the gate's own regular expressions over this repository's real log, from rendering the PDF under the failure it claims to catch, or from the Lean kernel.

| # | claim | verdict |
|---|---|---|
| 1 | [lean_blocked_debt.py](../.claude/hooks/lean_blocked_debt.py) is no longer unclosable | **CONFIRMED**, and it opens a mirror defect: one void closes every debt whose reason merely mentions the voided token |
| 2 | the grep is word-anchored, so a docstring mention no longer pays a debt | **REFUTED**. `-w` anchors word boundaries and a prose mention is a whole word. The live case r1038 named still closes |
| 3 | [forcing_at_surviving_config](../lean/HamiltonsCubic/Results/I104GramSystem.lean) types the live forcing | **CONFIRMED**, arithmetic and placement both, with the typed deficit back-computed rather than quoted |
| 4 | [forcing_at_excluded_config](../lean/HamiltonsCubic/Results/I104GramSystem.lean) types and labels the excluded figure | **CONFIRMED**, including the rounding direction |
| 5 | the debt is reopened as `joint_system_holds` | **REFUTED as reopened**. The name and the obligation are right. The trailer landed mid-review and the gate reads it as VOID on arrival, killed by finding 1 |
| 6 | the deleters leave a sentinel, so a later hook still sees the declaration | **REFUTED**. Both deleters write it, neither of the hooks that run after them reads it, and the chain still exits 2 on a properly declared stop |
| 7 | [loop_pdf.py](../scripts/misc/loop_pdf.py) exits 1 when the mermaid did not render | **REFUTED**. The threshold is 6 and the failure produces 7 pages, so the guard is silent in every reachable configuration |

## 1. The escape is reachable now, and the closure has become too wide

Both halves of the claim hold on the code and under probe. `any(t in voided for t in cands)` runs before `if not named`, and the `unparseable` branch prints to stderr and falls through to `return 0`.

| probe, on a repository built for it | exit |
|---|---|
| `Lean: blocked -- widget_gram`, 20 commits back, nothing else | 2 |
| the same, after `Lean: void -- widget_gram, the obligation ceased` | 0 |
| `Lean: blocked -- forcing, the base layer cannot express it yet` | 0, with the NOTE on stderr |

**The mirror defect is real and I reproduced it.** `voided` is matched against `cands`, which is every token of four or more characters in the reason, rather than against `named`. So a void closes any debt whose reason CONTAINS the voided token, wherever it sits and whatever that debt names. Two debts, one void:

```
Lean: blocked -- alpha_one, the layer lacks it
Lean: blocked -- beta_two needs alpha_one first, absent
Lean: void    -- alpha_one, the name was wrong
```

Before the void the gate exits 2 and names both. After it the gate exits 0 and names neither. `beta_two` was never voided by anyone, it is still absent from the layer, and it is now invisible. The fix is one word: test `any(t in voided for t in named)`, or better, test only `named[0]`, which is the token the gate would have grepped for.

**Two residuals.** A void trailer that does not OPEN with the name closes nothing, because the void side takes the first `DECL_LIKE` token and breaks: `Lean: void -- the I104GramSystem file's widget_gram was wrong` leaves the debt at exit 2. The gate's own message tells the author to write `Lean: void -- <name> <why>`, so the escape is reachable, and the failure is silent when it is not followed. And r1038's second owed item, widening `DECL_LIKE`, was not done: the 505 names of 6047 it refuses are now warned about rather than blocked on, which trades an unclosable block for a gate that cannot fire on 8.4 per cent of the layer. That is the better of the two, and it is not the repair that was asked for.

## 2. `-w` anchors a word boundary, and a mention in prose is a whole word

This is the claim with no supporting mechanism. `git grep -lw sharedChannelGram -- lean/` prevents a match inside a longer identifier. It does nothing about a match that is already a standalone word, which is exactly what a docstring mention is. Run against this repository as it stands:

```
$ git grep -lnw sharedChannelGram -- lean/
lean/HamiltonsCubic/Results/I104GramSystem.lean
lean/INDEX.md
```

[Line 117 of I104GramSystem.lean](../lean/HamiltonsCubic/Results/I104GramSystem.lean) reads "*A `Lean: blocked` trailer once named this `sharedChannelGram` and was closed as void*", which is a sentence saying the declaration will never be written, and it satisfies the paid test. Reproduced from cold on a probe repository whose only occurrence of the name is a docstring reading `/-- this file will never define widget_gram, and says so -/`: the gate exits 0 and reports the debt paid.

**The same trap is now loaded under the new name.** `git grep -lw joint_system_holds -- lean/` already returns two files, because the reopening was written as prose. Any `Lean: blocked -- joint_system_holds` trailer written from here is marked PAID by the gate on the day it lands.

What would work is what the gate's own docstring says the convention is: grep for a DECLARATION, `git grep -lE "^(theorem|lemma|def|abbrev|structure|inductive|class|instance)[[:space:]]+<name>\b"`, so that only a declaration pays a debt.

## 3 and 4. The arithmetic is exact and the placement is right

`#print axioms` on all six declarations, through `lake env lean` on a scratch copy of the file at `lean/` top level:

```
'HamiltonsCubic.I104GramSystem.joint_system_substitute'     [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.I104GramSystem.alpha_to_x'                  [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.I104GramSystem.sum_sq_three'                [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.I104GramSystem.forcing'                     [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.I104GramSystem.forcing_at_surviving_config' [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.I104GramSystem.forcing_at_excluded_config'  [propext, Classical.choice, Quot.sound]
```

The three standard axioms, no `sorry`, and the file elaborates clean. Six arithmetic statements put to `norm_num` in the same run, all accepted:

| statement | why it matters |
|---|---|
| `5/6 * 142701/625000 = 47567/250000` | the surviving specialisation is `forcing` exactly, with no slack inserted |
| `142701/625000 = 0.2283216` | the docstring's decimal for the typed deficit |
| `47567/250000 = 0.190268` | the docstring's decimal for the conclusion, and the record's figure |
| `8753/62500 = 0.140048` | the excluded configuration's deficit |
| `8753/75000 < 0.116707` | the record's printed bound ROUNDS UP, which is what the new docstring says |
| `142701/625000 < 0.228322` | the typed deficit sits BELOW the record's, so the hypothesis is the weaker one |

**Placement, checked independently of the author's account.** [r983](REVIEW_r983.md) puts the Gram-admitted worst at $N_i=0.218$, $t=0.346$, and says in terms that the item's three quantitative statements sit at $t=0.196$ (or $0.166$), $t=0.346$ and $t=0.598$, with $t=0.598$ the one the Gram bound excludes. [LEDGER.md](../findings/LEDGER.md) records the same and gives the restated forcing as $S_2\ge0.190268$ over a $1.0\%$ window $[0.190268,0.192222]$, having corrected r983's own upper endpoint from $0.191406$ to $0.192222$. [The note](2026-09-14-I104-tau-positive.md) states $S_2\ge0.228322/1.2=0.190268$ at $t=0.346$ and the window at $1.0\%$. So $t=0.346$ is the surviving configuration, $0.190268$ is its forcing, and the window is consistent: $5t/9=0.1922\overline{2}$ at $t=0.346$, and $(0.192222-0.190268)/0.190268=1.03\%$.

**Two residuals, neither touching the verdict.**

- The typed hypothesis is `d = 142701/625000 = 0.2283216`, and the record's deficit is $0.228322$. The author back-computed `d` from the conclusion instead of quoting the record's figure. The direction is the safe one, since the smaller `d` is the weaker hypothesis and the conclusion $0.190268$ is below the record's $0.19026833$, and the docstring still presents $0.2283216$ as though the record printed it.
- The typed content is the window's LOWER endpoint alone. The upper endpoint $0.192222=5t/9$, which is what makes the window a pinning statement rather than a bound, is not typed and is not claimed to be.

**And r1038's third owed item on this line was skipped.** [axioms.json](../lean/axioms.json) was not touched by `bc2ad176`. It still carries `HamiltonsCubic.I104GramSystem.forcing_at_recorded_deficit`, a declaration this layer no longer holds, and carries neither of the two that replaced it. The ledger of what has been kernel-checked now names one thing that does not exist and omits two that do.

## 5. The name is right, the obligation is right, and the ledger still reads void

The naming judgement is sound, and I checked it against the record rather than against the author. Three files state the obligation in the same words: the file's own [What is NOT stated](../lean/HamiltonsCubic/Results/I104GramSystem.lean) heading ("That the system holds, which is the record's own derivation from the minimality of the `e`-part and needs the Gram matrix `G_e` and its inverse"), [lean/INDEX.md](../lean/INDEX.md), and [the note](2026-09-14-I104-tau-positive.md). `joint_system_holds` names that statement and nothing else, it is distinct from the forcing the file types, and it passes the gate's `DECL_LIKE`. The file's new closing section says what it needs, `G_e` and its inverse. On the question r1038 was wrong about once, the answer holds a second time: the debt is the system holding, not the forcing.

**What did not happen is the reopening.** `bc2ad176` carries no `Lean: blocked` trailer. Replaying the gate's own `VOID`, `TRAILER`, `IDENT` and `DECL_LIKE` over the last 500 commits of this repository, read-only:

```
VOIDED TOKENS: {'pairIncidenceRank', 'sharedChannelGram', 'second_order_face'}
7abac33  pos=401  named=['sharedChannelGram']  ->  VOIDED by ['sharedChannelGram']
```

No trailer anywhere names `joint_system_holds`. The obligation lives in three prose files, which is the state r1038 called out in terms: "the record keeps the obligation in prose, where it has already aged 385 commits unread". It has now aged 401. The one ledger a script reads still says the debt is void, and the commit that says otherwise says it in a bullet.

Two things are owed together, and the second makes the first work: write `Lean: blocked -- joint_system_holds, ...` on a commit, and change the paid test so the prose mention in the file does not close it on arrival, which under the current grep it does.

**Superseded during this review, and the supersession is the best evidence in this report.** `41e6e1c1` landed at 12:20 with the trailer:

> `Lean: blocked -- joint_system_holds, that the joint Gram system HOLDS at a configuration, needing G_e and its inverse, which the layer does not carry. This registers with the debt gate the obligation wrongly voided as sharedChannelGram.`

Replaying the gate over the log that now includes it:

```
41e6e1c pos=1 named=['joint_system_holds', 'HOLDS', 'sharedChannelGram'] -> VOIDED by ['sharedChannelGram']
```

**The debt is void the moment it is written.** The reason explains which void it reverses, that explanation contains the token `sharedChannelGram`, `sharedChannelGram` is in the voided set from `f31245f`, and the gate tests `any(t in voided for t in cands)` over every token of the reason. So the sentence naming the mistake is the sentence that reproduces it, and the trailer is invisible to the gate on the day it lands. This is finding 1 firing in the wild, one commit after I reproduced it on a probe.

Two independent kills, either sufficient. Had the reason omitted the word `sharedChannelGram`, `git grep -lw joint_system_holds -- lean/` returns [I104GramSystem.lean](../lean/HamiltonsCubic/Results/I104GramSystem.lean) and [lean/INDEX.md](../lean/INDEX.md), so the gate would have marked it PAID instead. The trailer's own body states the belief that repair 2 made the registration possible, "the act of documenting the absence had been creating the evidence of presence", and `-w` does not change that: both files mention the name as a whole word.

## 6. Both deleters write the sentinel, and the hook that needed it still only tests for the file

Verified by running the chain in [settings.json](../.claude/settings.json) order, four hooks, crafted stdin, both loops armed to the calling session, `.claude/stop-declared` present at the start:

| hook | exit | `stop-declared` after | sentinel after |
|---|---|---|---|
| [both_loops_balance.py](../.claude/hooks/both_loops_balance.py) | 0 | present | present |
| [lean_blocked_debt.py](../.claude/hooks/lean_blocked_debt.py) | 0 | present | present |
| [loop_stop.py](../.claude/hooks/loop_stop.py) | 0 | **gone** | present |
| [lean_loop_stop.py](../.claude/hooks/lean_loop_stop.py) | **2** | gone | present |

`lean loop: a round closed, which is not a stopping point.` The declared stop is blocked, with a fresh sentinel sitting on disk beside the hook that ignored it.

**The reason is structural, and reading the diff shows it.** `grep -rn "stop-declared-seen" .claude/hooks/` returns six lines. Four are in the two GATES, which both write and read it. Two are in the two DELETERS, which both write it and neither reads it. The only readers run FIRST in the chain, where the real file is still present and they write the sentinel themselves. The sentinel produced by a deleter is therefore consumed by nobody, and the deterministic block r1038 named is unchanged. r1038's owed item had two clauses, "write the sentinel in the deleters AND read the sentinel in [lean_loop_stop.py](../.claude/hooks/lean_loop_stop.py)". The first clause landed alone, and the first clause alone changes no outcome.

**A path defect underneath it.** [lean_loop_stop.py](../.claude/hooks/lean_loop_stop.py) and [loop_stop.py](../.claude/hooks/loop_stop.py) resolve the declaration against the payload's `cwd`, while [lean_blocked_debt.py](../.claude/hooks/lean_blocked_debt.py) and [both_loops_balance.py](../.claude/hooks/both_loops_balance.py) resolve the sentinel against `CLAUDE_PROJECT_DIR`. Probed with a `cwd` below the project root, the sentinel lands in `cwd/.claude` and the gates look in `CLAUDE_PROJECT_DIR/.claude`, where nothing appears. The two sides of the mechanism disagree about which directory it lives in, so the repair would still be a half-repair once the read is added.

## 7. The threshold is 6 and the failure renders 7 pages

The guard is `pages < fences`, and `fences` is counted over the DISCOVERED documents. Counting exactly as the script counts:

| invocation | mermaid fences | pages | guard |
|---|---|---|---|
| default, network reachable | 6 | 13 | silent, correctly |
| default, mermaid host unreachable | 6 | **7** | **silent**, exit 0, ordinary success line |
| `--all`, network reachable | 9 | 21 | silent, correctly |
| `--all`, mermaid host unreachable | 9 | **12** | **silent**, exit 0, ordinary success line |

Rendered on this machine with the cdnjs URL pointed at an unreachable host and nothing else changed:

```
$ python3 loop_pdf_nonet.py nonet.pdf
.../nonet.pdf  208 KB, 7 pages, from research-loop, lean-loop, both-loops
exit=0
```

Which is byte for byte the shape of the line r1038 got before the repair. **The commit message states the numbers that refute it**: "7 pages instead of 13". Seven is not fewer than six. The three loop READMEs carry two mermaid fences each, not the seven r1038 quoted, so the threshold the author derived from that figure sits one below the page count of the failure. There is no configuration of network state or flags in which this guard fires, which makes it the same defect r1038 found in [both_loops_balance.py](../.claude/hooks/both_loops_balance.py): a gate that cannot trip has traded a silent failure for a silent failure plus five lines.

The quantity that separates the two states cleanly is the one the script never looks at, the number of `<svg` elements mermaid leaves behind, or failing that the rendered byte count, 309 KB against 208 KB. A page threshold that works is `pages < 2 * fences` on these documents, and it is a coincidence of layout rather than a measurement of the thing that failed.

## What is owed

| # | repair |
|---|---|
| 1 | match `voided` against `named` rather than against every token of the reason, so a void closes the debt it names |
| 2 | pay a debt only on a DECLARATION of the name, not on any occurrence: anchor the grep to `^(theorem\|lemma\|def\|abbrev\|structure\|inductive\|class\|instance)\s+<name>\b` |
| 3 | refresh [axioms.json](../lean/axioms.json): drop `forcing_at_recorded_deficit`, add the two declarations that replaced it |
| 5 | the trailer is written, and repairs 1 and 2 must land before it means anything: as the log stands the debt is voided by its own explanatory sentence, and would be marked paid by the prose if it were not |
| 6 | read `.stop-declared-seen` in [lean_loop_stop.py](../.claude/hooks/lean_loop_stop.py), and resolve the sentinel against one directory across all four hooks |
| 7 | detect the failure on the rendered SVGs rather than on the page count, since the page count does not separate the two states |

## How the analysis-only rule was honoured

No sweep, no census, no optimisation. Every run was seconds on objects in hand. The hook probes each built a small repository for that probe and invoked the hook with crafted stdin, which is the screening allowance exactly. The debt replay is this repository's own log read once through the gate's own regular expressions, read-only, with no flag written into the working tree. The PDF was rendered four times, seconds each, on the five documents the script itself discovers. The replay was run twice, before and after `41e6e1c1` landed. The one Lean process was `lake env lean` on a scratch copy of the single file under audit at `lean/` top level, which elaborated in under two minutes, and the file was removed afterwards. No numerical result is offered as evidence for a positive mathematical claim: sections 3 and 4 are exact rational arithmetic in the kernel and a reading of the record, and section 5 is a reading of the record alone.
