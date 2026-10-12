# Review r1088, the L74 bridge, the scale lemma, the status gate and the two corrected rows

*COLD Gate 2 review, sole reviewer, of `f5a7efc4`, `e255279c` and `ccd6c752`. Log: [r1088-bridge.log](../agent_logs/r1088-bridge.log). Rows are written the moment each claim settles.*

| # | claim | verdict |
|---|---|---|
| D1 | `l74Bridge_holds` proves `L74Bridge` as written, with no weakening | **CONFIRMED on the mathematics**, and the file's prose still calls the bridge open at four sites |
| D2 | `scale_unique_of_normSq_one` is right and its hypotheses are the ones it needs | **CONFIRMED**, and the degenerate weight is a vacuous branch it proves rather than an assumption it makes |
| D3 | the hook's early exit is repaired, the status block reachable on a `STATUS.md`-only commit | **CONFIRMED**, by running the hook, with two narrower early exits left above it |
| D4 | all three position evasions are closed and the well-formed file still passes | **CONFIRMED in the script, REFUTED in the hook**: two of the three print no reason, and a fourth evasion exits 0 |
| D5 | F74's corrected text is right and no site still asserts the old version | **CONFIRMED**, with r1087's smaller point on the post's own heading still untaken |
| D6 | the corrected `weylModule` row is now right about the space | **CONFIRMED on the space, REFUTED on the dimension**: $170$ against $10$ is a docstring's claim, not a theorem |

## D1, the bridge: CONFIRMED on the mathematics, with the file's own prose left asserting the opposite

**The theorem's type IS the `Prop`, not a variant of it.** `#check` returns `@l74Bridge_holds : ∀ {ι} [Fintype ι] [DecidableEq ι], L74Bridge`, and `L74Bridge`'s definition has not changed since it was introduced at `a37a1880` (`git log -L 485,489` returns that commit alone). *So no weakening is possible at the statement level: the same `Γ`, `A`, `t`, the same `Realises`, the same `0 < t`, the same normalisation, and criticality of `diagOp (t • graphWeight A Γ.k)` itself.* **The rewrites `rw [hgw, ← hst]` act on the GOAL**, so what the kernel accepted is the operator the `Prop` names and not a cousin of it.

**Axioms: `propext`, `Classical.choice`, `Quot.sound`.** *No `sorryAx`, so the bridge does not lean on the file's `primitive_thetaSq_lt_quarter`.* `primitive_critical_not_in_band` still returns `sorryAx` as before, through that bound alone.

**The scale step is sound at the boundary, and it is `SRG.hklt` rather than `positivity` that makes it so.** `hspos` needs `0 < 2(v-1-k)/(vk(v-1))`, and `hw : 0 < (card ι) - 1 - Γ.k` sits in the context, put there by `realises_w_pos`, which reads `Γ.hklt : k < v - 1` through `Realises.1`. *The structure excludes `v - 1 - k = 0` outright, so the case the brief asks after is unreachable rather than unhandled.*

**The debt table really does lose the row, and the generator agrees.** Regenerating [plan-lean.md](../plan-lean.md) with [lean_debts.py](../scripts/misc/lean_debts.py) reproduces the committed file byte for byte: `l74Bridge_holds`'s signature carries no bracketed binder, which is what `hypothesis_debts` reads as a discharge.

**WHAT IS WRONG IS THE PROSE, AT FOUR SITES IN THE FILE THE THEOREM WAS ADDED TO.** *The commit added 40 lines and updated no sentence around them, so [L144Statement.lean](../lean/HamiltonsCubic/Results/L144Statement.lean) now says in four places that the bridge is an open hypothesis:*

- **line 94–110**, the file header's bullet: *"**So this binder is now DISCHARGEABLE and is owed a discharge**, and it remains a hypothesis only because nothing here has yet applied that theorem. **WHAT BLOCKS THE DISCHARGE IS A NAME COLLISION, NOT A MISSING PROOF**"*. Both sentences are now false, and the second names a blocker that line 496 crosses.
- **line 121–127**, under `## What is NOT typed here`: *"that it is critical, and at that multiplier, is Lemma L74's and is carried as the named hypothesis `L74Bridge`"*. **It is typed here, and proved here**, which is the one thing a section titled "what is NOT typed" must not get wrong.
- **line 466–484**, the `L74Bridge` docstring: *"**WHAT REMAINS FOR THIS BRIDGE IS THE WEIGHT IDENTIFICATION** … That is the next round"*. Nothing remains.
- **line 433**, in passing: *"`L74Bridge` is a translation rather than a missing proof"*, which survives as true.

**This is the failure [r1028](REVIEW_r1028.md) recorded against this same file**, one commit leaving it saying several different things about `L74Bridge`. *The rows in [lean/INDEX.md](../lean/INDEX.md) repeat it at 303, 304 and 305, each ending "is the next round", and 315 still reads "`L74Bridge` assumes what L74 already PROVES … so the weaker assumption is made where the stronger theorem exists".* **Row 306 is right and does not reach a reader who stops at 305.**

**One consequence worth taking.** `primitive_critical_not_in_band (h74 : L74Bridge …)` now carries a binder that `l74Bridge_holds` discharges in one token. *Leaving it is defensible. Leaving it AND the four sentences is what made it read as still open.*

## D3, the early exit: CONFIRMED, by running the hook

**Reproduced in a detached worktree at `0045c7ad`, with a collapsed [STATUS.md](../STATUS.md) as the only staged path.** The hook reaches the status block and refuses:

```
pre-commit: STATUS.md is not current for a commit that moves the position.
STALE STAMP: 'The position, from the goal to the current item' changed but its stamp did not move
POSITION RUN TOGETHER: a node bullet carries 5 arrows. One node per line means one arrow per line.
POSITION COLLAPSED: the chain has 1 node lines. …
EXIT=1
```

*Under the line the commit replaced, the same run exits 0 in silence.* **So the repair is real and the gate is reachable for the first time.**

**Two residual early exits remain above it**, `[ -d lean ] || exit 0` and the two `command -v lake … || exit 0` lines: a checkout with no toolchain still skips the position gate entirely, though it has nothing Lean to check. *Narrow, and worth a line in the comment that already explains the other one.*

**A cosmetic falsehood on the reachable path.** With no `lean/*.lean` staged, the hook still prints `pre-commit: elaborating staged lean/ files...` and then `pre-commit: staged files elaborate OK`. *`REL` is empty and the two loops have no iterations, so nothing was elaborated and the second line asserts a check that did not run.*

## D4, the three evasions: CONFIRMED in the script, REFUTED in the hook, and there is a fourth

**Each of the three fires, run rather than reasoned**, from a clean `HEAD` copy of [STATUS.md](../STATUS.md) in the worktree:

| evasion | what was done | what [status_report.py](../scripts/misc/status_report.py) printed |
|---|---|---|
| 1 | the chain on one bullet, padded with two single-arrow decoys so the count reaches three | `POSITION RUN TOGETHER: a node bullet carries 5 arrows` |
| 2 | the heading renamed to "Where things stand", chain left intact | `POSITION MISSING: no section heading starts 'The position, from the goal'` |
| 3 | the `` `[budget: N words]` `` marker dropped from the heading | `POSITION UNMARKED: the position heading carries no …` |

**And the well-formed file still passes**: the committed [STATUS.md](../STATUS.md) exits 0 and the script leaves the file byte-identical.

**BUT TWO OF THE THREE ARE INVISIBLE TO THE COMMITTER, AND THE DEFECT IS THE ONE r1087 REPAIRED ONE COMMIT EARLIER.** [.githooks/pre-commit:91](../.githooks/pre-commit) greps `OVER BUDGET|STALE STAMP|NO STAMP|POSITION COLLAPSED|POSITION RUN TOGETHER`. *`POSITION MISSING` and `POSITION UNMARKED` were added in the same commit and not added to that list.* **Run under evasion 2, the hook printed exactly one line:**

```
pre-commit: STATUS.md is not current for a commit that moves the position.
EXIT=1
```

*No reason, and not even the two advice lines below the grep: `set -e` is in force and a `grep` that matches nothing returns 1, so the script dies at line 91 and lines 92–93 never run.* **This is verbatim the failure r1087 found against the previous message set**, a gate that blocks while naming nothing, re-created by the commit that closed the evasions. **The repair is one line**: grep `POSITION` alone, or append `| grep -E … || true`.

**THE FOURTH EVASION, IN TWO FORMS, BOTH EXITING 0.** *The run-together test counts the character `←` and nothing else, and the collapse test counts bullets that START `- ←` without looking at what follows.* So, with the stamp moved, which a writer editing the section does anyway:

- **the whole chain on one bullet written with `→`**: `- ← **P** → **R25** → **I104** → **I110** → **THIS ITEM, I73**` plus two `- ← decoy` bullets. `rc=0`. *Any separator that is not `←` does this: `->`, `then`, a comma.*
- **three EMPTY arrow bullets**, `- ←` three times with the chain deleted outright. `rc=0`. **The position can be erased and the gate passes.**

**So the three named evasions are closed and the shape check is not.** *The repair that closes the family rather than the instances is to count NODES: require text after the arrow on each `- ←` bullet, and count any arrow glyph within a bullet rather than `←` alone.*

## D2, the scale lemma: CONFIRMED, and the degenerate weight is VACUOUS rather than assumed away

**It needs no `normSq (diagOp w) ≠ 0`, and the reason is that its own hypotheses rule the case out.** *The proof splits on it: at `normSq (diagOp w) = 0`, `hsn` becomes `s ^ 2 * 0 = 1` and `norm_num` closes the branch.* **So the lemma is not silently assuming a nonzero norm, it is deriving the contradiction**, and at the degenerate weight the statement is vacuously true because no scale normalises a null operator. *The bridge never meets that branch, `srgWeight` at a realising `A` having nonzero cross entries.*

**The four hypotheses are each load-bearing and there is no fifth.** `hw` and `hh` are exactly what [Families.lean](../lean/HamiltonsCubic/Base/Families.lean)'s `diagOp_normSq_smul` asks for, and they are properties of the weight rather than of either scale, as the commit says. *`hs` and `ht` are what separate `s = t` from `s = ±t`: drop either and `s = -t` is a counterexample.* **Axioms: the standard three.**

## D5, F74: CONFIRMED, and the three sites now agree

**The corrected text is right on every figure.** *The shortfall is $(\Theta_{11}-\sup)/\Theta_{11}=(1.21716124-1.21558587)/1.21716124=0.12943\%$, reproduced here, which is the post's own $0.1294\%$.* The floor `\max(f_Gram, f_d)`, the reach $n\le10$, the left-endpoint pinch and the spent verdict all match [fence-posts.md](../findings/fence-posts.md) and [INDEX-traps.md](../findings/INDEX-traps.md).

**No site still asserts the refuted version.** *Greps over every `.md` outside [reviews/](.) for `n\le8`, for `inflat`, for the Gram-only shares `58.1/41.4/10.3` and for `0.13\%` return the corrected text everywhere, plus two occurrences inside [fence-posts.md](../findings/fence-posts.md) that quote the refuted sentences AS refuted, with their dates and the reviews that killed them.* **And nothing in [plan.md](../plan.md), [routes.md](../routes.md), [STATUS.md](../STATUS.md) or [results.md](../results.md) carries the $\mathcal D_n$ ceiling as a live route.** *The one other mention, an outside report archive (unpublished, held in the private record):254, is about the unqualified "$n\ge12$" wording and is a different open point.*

**The residue is the one [r1087](REVIEW_r1087.md) already named and the commit did not take.** [fence-posts.md:634](../findings/fence-posts.md) still heads the post *"reaches $n\le10$ and MISSES $n=11$ by $0.13\%$, the only case left open"*, with no marker that the family is spent, and the verdict sits twenty lines below. *A reader who reads the heading and the first paragraph meets the route as live.*

## D6, the `weylModule` row: CONFIRMED on the space and the inner product, REFUTED on the dimension

**Tested against the declarations, not the names.**

| the row says | the object |
|---|---|
| `weylModule` has a nonzero radical and is not the record's $\mathcal W_n$ | **PROVED**: `symOp_mem`, `symOp_normSq = 0` and `symOp_ne_zero` at `Nonempty ι`, with `mem_weylModule_of_kills_skew` giving the whole radical |
| `innerOp` is only a semi-inner product there | **PROVED**, by those three together |
| the projection onto `weylModule` is ILL-POSED rather than unbuilt | **RIGHT**: a nonzero null vector inside the subspace makes the orthogonality condition determine the projection only up to the radical |
| **it proves its dimension is $170$ against $10$ at $n=4$** | **NOT PROVED.** `finrank` and `Module.rank` appear nowhere in the file. The formula $\dim = \dim\mathcal W_n + n^2\cdot n(n+1)/2$ and both numbers live in a DOCSTRING citing [r1004](REVIEW_r1004.md) |
| `curvOpCore` supplies the inner product the row called missing | **PRESENT**, `curvOpCore : InnerProductSpace.Core ℝ (CurvOp2 ι)`, definiteness discharged by `normSq2_eq_zero`. Both files are `sorry`-free |

**So the corrected row commits the session's own error a third way.** *The first read a name's absence as a concept's absence, the second read a name's presence as an object's presence, and this one reads a DOCSTRING's claim as a theorem of the file it sits in.* **The arithmetic is right** ($10+16\cdot10=170$, and $\dim\mathcal W_4=10$) **and the layer does not hold it**, which is the distinction the column exists to draw. *The repair is to say the file proves the radical is nonzero and that the dimension gap is r1004's count.*

**One precision on the sibling type.** [CurvOpInner.lean](../lean/HamiltonsCubic/Results/CurvOpInner.lean) builds a `Core` and its own docstring says it does NOT register an instance. *No `InnerProductSpace` instance on `CurvOp2` exists in the layer and `orthogonalProjection` appears nowhere in it*, so the row's point stands as stated, that the inner-product structure is not what is missing, while the projection is no nearer being buildable on `CurvOp2` than on `CurvLin`.

## Addendum: D4's hook half was repaired while this round ran

**`d87bacfa` replaced the enumerated message list with the shape `^[A-Z][A-Z0-9 ]+:`**, so a check added to [status_report.py](../scripts/misc/status_report.py) now reports itself without a second edit. *Checked here against all seven message kinds the script emits: the new pattern matches every one, so `POSITION MISSING` and `POSITION UNMARKED` now reach the committer.* **The fourth evasion is untouched by that commit and stands**: a chain run together with `→`, and three empty `- ←` bullets, both still exit 0.

**One line left in that repair.** `set -e` is still in force at [.githooks/pre-commit:96](../.githooks/pre-commit), so a `status_report.py` failure whose output matches nothing, a Python traceback for instance, kills the hook before the two advice lines below the grep. *`|| true` on the grep makes them unconditional.*
