# REVIEW r280, Gate 2, the support dichotomy and the $\Theta_5$ flag

Reviewer 280. Commits under review: `a826ede` (primary), `e1fc1e6`, `45ac2ac`.
Primary file: [findings/support-dichotomy.md](../findings/support-dichotomy.md). Supporting: [findings/nondegeneracy.md](../findings/nondegeneracy.md), [findings/second-order.md](../findings/second-order.md), [findings/fence-posts.md](../findings/fence-posts.md), [findings/sym3-blocks.md](../findings/sym3-blocks.md), [scripts/salvage_reviewer.py](../scripts/salvage_reviewer.py), [.claude/hooks/research_loop_stop.py](../.claude/hooks/research_loop_stop.py).
Scripts: [scripts/reviewers/r280/](../scripts/reviewers/r280/). Reviewer 279 runs the identical brief concurrently and independently.

Everything below is rebuilt from the definitions $Q(W)=W^2+W^\#$, $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, $P(W)=\langle W,Q(W)\rangle$ through [review_r30_core.py](../scripts/review_r30_core.py), with criticality re-certified at every point rather than assumed. The hook and the salvage script are **imported and executed**, not read: every case in claim 4 is a constructed tree that the real code was run against.

| # | Claim | Verdict |
|---|---|---|
| 1 | The theorem, every maximiser is $\circ$-indecomposable | **THE CONCLUSION IS TRUE AND THE PROOF IS TWO-THIRDS DECORATION, WITH ITS ONE REAL HYPOTHESIS NEVER STATED.** Step 1 is removable: a piece $A_i$ is *itself* a unit vector of $\mathrm{Weyl}_n$ and $P$ is odd, so $\lvert\theta_i\rvert\le M(n)$ outright, padding, monotonicity and $n_i$ never need to enter, which is why (c) a piece at $n_i=n$ costs nothing. Step 2 is removable too: $A_i\circ A_j=0$ makes $P$ **additive**, giving $P(W)=\sum a_i^3P(\hat A_i)\le M(n)\max_ia_i<M(n)$ in one line. **What is load-bearing and unstated is criticality of the pieces**, the file never defines $\circ$-decomposable, and on the bare reading ($W=\sum V_i$, $V_i\circ V_j=0$) the pieces need not be Frobenius-orthogonal and the bound **inverts**: $\alpha=\beta=1$, $\langle u_A,u_B\rangle=-\tfrac12$ satisfies $\lVert W\rVert=1$ and forces $\theta=2P(u_A)$. Also **$M(n)>0$ "because $\theta_0(n)$ is attained" is false at odd $n$** ([problem.md](../findings/problem.md) line 68); padded $W_{\mathbb{CP}^2}$ repairs it at every $n\ge4$ |
| 2 | What the theorem buys | **NOT NEW, [second-order.md](../findings/second-order.md) line 206 states it in words and lines 185–190 supply the proof.** *"Decomposable points are capped by their own pieces and can never set a new maximum"* has been on file since `bb4ebb7`, together with the implied-orthogonality lemma and the harmonic-square law it rests on. The commit's product is a **retraction** of the r277/r278-refuted induction, not a new theorem. And it does not advance Conjecture A: the residual it hands over is the $\circ$-indecomposable branch, which [fence-posts.md](../findings/fence-posts.md) posts 34/35 had already identified as where every conversion law on file fails |
| 3 | The $\Theta_5$ flag | **DECIDED: $\Theta_5=\sqrt{3/2}$ IS PROVED, AND DEGREE-3 ADEQUACY IS NOT OWED.** $P=3\operatorname{tr}(W^3)$ *identically* on $\mathrm{Weyl}_5$ (verified to $10\text{ digits}$ on random Weyl operators, exact at $n=4,5$ and false from $n=6$) so $F_5=\tfrac32\lVert W\rVert^6-9\operatorname{tr}(W^3)^2$ **is** $\tfrac32\lVert W\rVert^6-P(W)^2$ and $F_5\ge0$ is *verbatim* $\Theta_5\le\sqrt{3/2}$. SOS is a one-directional sufficient certificate, so a certificate in hand needs no adequacy theorem; adequacy is owed only by a claim that the *search must succeed*. [run_n5_verify.py](../scripts/runs/run_n5_verify.py) runs clean here. **The heading is stale, not the result** |
| 4 | The salvage fix and the hook | **THE FIX WORKS, BOTH HOOK FAILURE DIRECTIONS SURVIVE, AND `e1fc1e6`'s SALVAGE SCRIPT DESTROYED THE ONE REPORT IT EXISTS TO PROTECT, SINCE REPAIRED ON DISK.** Nine constructed cases, all run against the imported hook. A warm corpse still reads as in flight; a $46$-minute heartbeat gap still reads as dead; a trailing blank line after `DONE` still reads as running. **New: the $45$-minute window does not bound the damage**, because the Stop hook fires only at turn end and nothing creates a later Stop, so one silenced Stop halts the session until the user speaks. **New: as reviewed, the script tested `'PARTIAL' not in head` over the first $200$ bytes**, so a full report that files early and says so (exactly what the brief's *file as soon as you have your first verdict* produces), was **overwritten by the log dump**; reproduced with a `REFUTED` verdict destroyed. The working tree now anchors the marker instead, and holds under three fresh probes |
| 5 | The skill rule | **WELL-POSED AND IT WOULD HAVE FIRED, BUT IT ASKS THE WRONG AGENT AND DUPLICATES A RULE THE RECORD ALREADY CARRIES.** The escape hatch (*"where the record does not say, that is the finding"*) makes it total, and all three cited instances are caught if *quantity* is read to include a borrowed **claim**, which instance 2, a hypothesis substitution, requires. The weakness is structural: the route's author self-reports the domain, and the author who missed it is the one asked to name it. In all three instances **the record already said the domain**, [fence-posts.md](../findings/fence-posts.md) post F35 for the $1/\sqrt2$, [nondegeneracy.md](../findings/nondegeneracy.md) line 320 for $W_A\circ W_B=0$, [response.md](../response.md) Lemma L23 for $S_{\mathfrak{mmm}}$, so the failure was **not reading**, which [findings/INDEX.md](../findings/INDEX.md) step 3 already legislates. Cheaper and not self-reported: carry the domain as a **column of the record** beside each law, written once |
| 6 | The r259–r278 sweep | **FOUR ITEMS STILL UNAPPLIED**, two of them contradictions live in the tree right now: [second-order.md](../findings/second-order.md) line 206 still carries the clause r278 asked to strike; [findings/INDEX.md](../findings/INDEX.md) line 38 still reads *"the restricted rank open in $[1,14]$"* against the file's own proved $13$; [plan.md](../plan.md) line 65 and [findings/INDEX.md](../findings/INDEX.md) line 38 still call $\Theta_5$ proved while [sym3-blocks.md](../findings/sym3-blocks.md) heads its section *what the certificate **would** establish*; and the two hook directions r278 filed are unrepaired |

---

## Claim 1, the theorem, step by step from the definitions

Evidence: [r280_claim1.py](../scripts/reviewers/r280/r280_claim1.py), [out_claim1.txt](../scripts/reviewers/r280/out_claim1.txt).

### (a) Padding is $\theta$-preserving, and step 1 is not needed

Padding is exactly what the file says it is. Embedding $\Lambda^2\mathbb R^{n_0}\subset\Lambda^2\mathbb R^n$ by index inclusion sends $\mathrm{Weyl}_{n_0}$ into $\mathrm{Weyl}_n$ (residual against the $\mathrm{Weyl}_n$ projector $\le1.7\times10^{-15}$ at $(n_0,n)=(4,6),(5,8),(6,12),(8,13)$), preserves the norm exactly and preserves $P$ to $2.8\times10^{-17}$. Criticality travels with it: $S^3\times S^3$ padded $6\to12$ keeps $\theta=1.054092553389$ at residual $1.7\times10^{-16}$; $S^2\times S^2$ padded $4\to12$ keeps $0.866025403784$. **So $M(n-1)\le M(n)$ is correct.**

**It is also unnecessary, and that is the interesting part.** A piece $A_i$ of a splitting of $W\in\mathrm{Weyl}_n$ is an element of $\mathrm{Weyl}_n$. Normalised it is a *unit* element of $\mathrm{Weyl}_n$, so $P(\hat A_i)\le M(n)$ by the definition of $M(n)$, and $-P(\hat A_i)=P(-\hat A_i)\le M(n)$ because $P$ is an odd cubic. Hence

$$\lvert\theta_i\rvert=\lvert P(\hat A_i)\rvert\le M(n)$$

with no padding, no monotonicity, and no reference to $n_i$ at all. The file's step 1 exists only to service the detour $\lvert\theta_i\rvert\le M(n_i)\le M(n)$.

### (b) The harmonic-square law, and which hypotheses it actually consumes

Re-derived here from the definitions. $\langle X\circ Y,Z\rangle$ is totally symmetric, measured spread $3.5\times10^{-18}$ over a random triple in $\mathrm{Weyl}_8$, so for **any** $\circ$-orthogonal pair, critical or not,

$$\langle Q(A),B\rangle=\langle A\circ A,B\rangle=\langle A\circ B,A\rangle=0 .$$

That is algebra and costs nothing. Criticality of the *pieces* is what converts it into Frobenius orthogonality: $Q(A)=\theta_AA$ turns the display into $\theta_A\langle A,B\rangle=0$, so $\theta_A\ne0$ forces $\langle A,B\rangle=0$. With the pieces orthogonal and unit, $\sum a_i^2=1$ and criticality of $W$ splits componentwise into $a_i\theta_i=\theta$, whence $1/\theta^2=\sum1/\theta_i^2$.

So the honest hypothesis list is: **pieces critical, pairwise $\circ$-orthogonal, each $\theta_i\ne0$.** Unit norm is a normalisation, not a hypothesis, it fixes the scale at which $\theta_i$ is read. Orthogonality is *implied*, not assumed. And $\theta_i\ne0$ is genuinely needed: the step $a_i=\theta/\theta_i$ is undefined at $\theta_i=0$.

**A piece with $\theta_i=0$ is not covered by the three lines, and the conclusion survives anyway.** If $Q(A_1)=0$ then criticality of $W$ reads $\sum_{i\ge2}a_i^2\theta_iA_i=\theta\sum_ia_iA_i$; the $A_1$ component gives $\theta a_1=0$, so either $a_1=0$ (no splitting) or $\theta=0$, which contradicts $\theta=M(n)>0$. One sentence, and the file owes it.

### The one-line proof the file was reaching for

$A_i\circ A_j=0$ makes $Q$ additive, and by the vanishing cross terms above it makes $P$ **additive**: for $W=\sum_ia_i\hat A_i$ with the $\hat A_i$ unit and pairwise orthogonal,

$$P(W)=\sum_ia_i^3P(\hat A_i)\;\le\;M(n)\sum_ia_i^3\;\le\;M(n)\max_i a_i\;<\;M(n)\qquad(k\ge2),$$

using $\sum a_i^2=1$ and $\max_ia_i<1$. **No harmonic-square law, no $\sqrt k$, no padding, no monotonicity of $M$, and no case split at $\theta_i=0$.** It is strictly shorter than the file's three steps and strictly stronger, since it never divides by anything.

### (c) A piece at $n_i=n$ costs nothing

r277 and r278 are right that $\circ$-decomposability does not force $n_i<n$, $(S^4)^3$ at $n=12$ splits with a piece of support dimension $12$. **The theorem does not care.** Its step 3 uses only $n_i\le n$, which is automatic for a piece of an operator on $\mathbb R^n$, and the route above does not use $n_i$ at all. *This is the one attack in the brief that the file survives cleanly.*

### (d) and (e) Existence and positivity

$\mathrm{Weyl}_n$ is a finite-dimensional linear subspace of $S^2(\Lambda^2\mathbb R^n)$, its unit sphere is compact, and $P$ is a polynomial, hence continuous. **So $M(n)$ is a maximum and it is attained**, and a maximiser is a constrained critical point with $Q(W)=\theta W$, $\theta=P(W)=M(n)$. Positivity of $\theta$ at a maximiser is therefore exactly $M(n)>0$, and it is used twice, to divide, and to make $M(n)/\sqrt2<M(n)$ strict.

**The file's reason for $M(n)>0$ is wrong at odd $n$.** *"$M(n)>0$, which holds because $\theta_0(n)$ is attained"* collides with [problem.md](../findings/problem.md) line 68: $\theta_0(n)$ is attained by $S^{n/2}\times S^{n/2}$ **only at even $n$**, and at odd $n$ the best sphere product falls strictly short. The conclusion is unharmed, padded $W_{\mathbb{CP}^2}$ is a unit critical point of $\mathrm{Weyl}_n$ at $P=1.224744871392$ for every $n\ge4$, reproduced here at $n=5,6,12$ with criticality residual $\le1.7\times10^{-15}$, so $M(n)\ge\sqrt{3/2}>0$ at **every** $n\ge4$, odd included. Below that $\dim\mathrm{Weyl}_3=0$ and there is nothing to maximise.

### The defect that matters: $\circ$-decomposable is never defined

[support-dichotomy.md](../findings/support-dichotomy.md) states a theorem about $\circ$-indecomposability and defines neither term. The proof silently uses the record's definition, [b_circ_indecomposable.py](../scripts/b_circ_indecomposable.py) and [second-order.md](../findings/second-order.md) line 190 both say *"the $A_i$ pairwise $\circ$-orthogonal **and critical**"*, and on that definition the theorem is true. **On the bare reading it is not proved, and the bound does not merely fail to apply, it inverts.**

Take $W=V_A+V_B$ with $V_A\circ V_B=0$ and neither piece critical. The cross terms still vanish, so $P(W)=P(V_A)+P(V_B)$ and, writing $\alpha=\lVert V_A\rVert$, $\beta=\lVert V_B\rVert$, $m=\langle V_A,V_B\rangle$, criticality of $W$ gives $P(V_A)=\theta(\alpha^2+m)$ and $P(V_B)=\theta(\beta^2+m)$ with $\alpha^2+\beta^2+2m=1$. Nothing forces $m=0$, that step is *exactly* where criticality of the pieces was spent. At $\alpha=\beta=1$, $m=-\tfrac12$ (an angle of $120°$, admissible under Cauchy–Schwarz since $\lvert m\rvert\le\alpha\beta$) the constraint $\lVert W\rVert=1$ holds and

$$\theta=2\,P(\hat V_A)=2\,P(\hat V_B),$$

so the maximiser sits at **twice** its pieces' values and $\lvert\theta_i\rvert\le M(n)$ buys nothing. I have not exhibited such a configuration in $\mathrm{Weyl}_n$ and do not claim one exists; what is established is that **the file's three lines do not exclude it**, and one clause (*pieces critical*), closes the gap. That clause belongs in the theorem statement, not in a script's docstring.

---

## Claim 2, what the theorem buys, and whether it is new

**It is not new.** [second-order.md](../findings/second-order.md) line 206 opens its summary paragraph with

> **Decomposable points are capped by their own pieces and can never set a new maximum**, so Reviewers 56/57's infinite direct-sum family costs route B nothing: the residual narrows to **$\circ$-indecomposable** non-diagonal $S=0$ points.

That sentence *is* the theorem. Four paragraphs above it, the same file supplies both halves of the proof (the implied-orthogonality lemma and the harmonic-square law, each in two lines) and adds the $E(1)$ decidability criterion the new file does not mention. All of it landed in `bb4ebb7`, and [b_circ_indecomposable.py](../scripts/b_circ_indecomposable.py)'s docstring carries the same three sentences.

**What `a826ede` genuinely produces is a retraction.** The assembly r277 and r278 refuted (an induction on $n$ conditional on base cases $5\le n_i\le11$), is withdrawn and replaced by an argument that needs neither. That is worth having, and the file's own *"What this replaces"* section is the honest description of it. The header claim *"three lines, no induction"* oversells a paragraph that was already on file without an induction.

**It does not advance Conjecture A, and the file says so.** Its closing section hands over the $\circ$-indecomposable branch as *"the whole problem"*, which is where [fence-posts.md](../findings/fence-posts.md) posts 34 and 35 already put it: *"a conversion from a norm-type cap to $\theta$ valid on $\circ$-indecomposables, since every such law on file assumes a splitting."* The branch this closes was already known to be the harmless one.

**One consequence that should be recorded.** [second-order.md](../findings/second-order.md) line 206 continues *"What the cap needs is $\lvert\theta\rvert\le M(n)/\sqrt2\le\sqrt{3/2}$, i.e. an a priori bound $M(n)\le\sqrt3$"*. With the branch closed at the maximiser, no consumer of $M(n)\le\sqrt3$ remains, and fence posts 11 and 12 (which exist to fence that target), fence nothing. r278 asked for the clause to be struck; it is still there.

---

## Claim 3, the $\Theta_5$ flag, decided

Evidence: [r280_claim3.py](../scripts/reviewers/r280/r280_claim3.py), [r280_claim1.py](../scripts/reviewers/r280/r280_claim1.py) part E.

### The Lovelock collapse is real, and it makes $F_5$ a restatement of $\Theta_5$

Measured on random unit Weyl operators:

| $n$ | $P/\operatorname{tr}(W^3)$ | $\langle W,W^\#\rangle-2\operatorname{tr}(W^3)$ |
|---|---|---|
| $4$ | $3.0000000000$ at every sample | $2.8\times10^{-17}$ |
| $5$ | $3.0000000000$ at every sample | $1.1\times10^{-16}$ |
| $6$ | $2.743$, $2.976$, $-9.478$, $45.411$ | $2.9\times10^{-2}$ |
| $7$ | $3.193$, $2.613$, $1.614$, $-0.964$ |, |

So the cubic invariant space is one-dimensional at $n\le5$ and $P=3\operatorname{tr}(W^3)$ there, exactly as [sym3-blocks.md](../findings/sym3-blocks.md) says, and it breaks at $n=6$ where a second invariant appears. **Therefore**

$$F_5=\tfrac32\lVert W\rVert^6-9\operatorname{tr}(W^3)^2=\tfrac32\lVert W\rVert^6-P(W)^2\quad\text{on }\mathrm{Weyl}_5,$$

and $F_5\ge0$ on $\mathrm{Weyl}_5$ is not *related to* $\Theta_5\le\sqrt{3/2}$, it **is** that statement written out. The normalisation checks against the record's own catalogue: padded $W_{\mathbb{CP}^2}$ has $\lVert W\rVert=1$, $\operatorname{tr}(W^3)=0.408248290464=1/\sqrt6$, $P=1.224744871392=3/\sqrt6=\sqrt{3/2}$ and criticality residual $8.7\times10^{-16}$, identically at $n=5,6,12$. **So $F_5$ vanishes at $W_0$ and the bound, if it holds, is attained.**

### Degree-3 adequacy is not owed, and this is the whole of the flag

**A sum-of-squares certificate is a one-directional implication.** $F_5=\sum_aq_a^2$ with the $q_a$ cubics gives $F_5\ge0$ pointwise, full stop; no theorem about which nonnegative sextics *are* SOS is consulted anywhere in that inference. Hilbert's non-adequacy would matter to a claim of the form *"the search over degree-3 certificates must succeed"* (a completeness statement) and to nothing else. **The certificate is in hand, so the completeness statement is not needed.**

What the flag is entitled to ask is whether the certificate is real, and that is a different question with an answer. [run_n5_verify.py](../scripts/runs/run_n5_verify.py) was run here from the file alone and returns positive definiteness of all $16$ blocks by characteristic polynomials with alternating coefficients over $\mathbb Q$, in both the as-packed and off-diagonals-halved normalisations, with no floating point. The identity half rests on r213's argument, which is sound and needs nothing about $\mu$: every row entry and $F_5$ alike lie in $(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$, of dimension $14$; $120$ explicit invariant sextics evaluated at the $40$ points have rank $14$ against a cap of $14$; so evaluation is injective on that space and agreement at $40$ points is identity. **Both halves stand.**

### The falsification attempt

$200$ projected gradient ascents of $P$ on the unit sphere of $\mathrm{Weyl}_n$, $4000$ steps each, from independent random starts:

| $n$ | best $P$ reached | $\sqrt{3/2}$ | excess |
|---|---|---|---|
| $4$ | $1.224466916269$ | $1.224744871392$ | $-2.8\times10^{-4}$ |
| $5$ | $1.223905369247$ | $1.224744871392$ | $-8.4\times10^{-4}$ |

Both approach the threshold from **below** and neither crosses it. **No refutation.**

### Verdict on the flag

**$\Theta_5=\sqrt{3/2}$ is proved.** [findings/INDEX.md](../findings/INDEX.md) and [plan.md](../plan.md) are right and [sym3-blocks.md](../findings/sym3-blocks.md)'s section heading is stale, it was written while the certificate was still a target and never retitled when the certificate landed. The two sentences the file owes: the heading becomes *what the certificate establishes*, and the *"degree-3 adequacy, which Hilbert makes non-automatic"* line is struck as a category error rather than carried as an open obligation.

---

## Claim 4, the salvage fix and the hook

Evidence: [r280_claim4.py](../scripts/reviewers/r280/r280_claim4.py), [out_claim4.txt](../scripts/reviewers/r280/out_claim4.txt). The hook module is imported and `_agents_running` is called on constructed trees; the salvage script is executed as a subprocess against a copied tree. Nothing is re-implemented.

### The fix in `e1fc1e6` does what it claims

The refuse-to-overwrite branch now closes the log. Constructed: reviewer $910$ with a warm heartbeat log and a full `REVIEW_r910.md` on disk. Salvage returns *"exists and is a full report, not overwritten, log closed"*, the log's last line becomes `FAILED closed by scripts/salvage_reviewer.py`, and `_agents_running` flips from true to **false**. **Confirmed.**

### Both failure directions survive

| constructed case | reads as in flight | should |
|---|---|---|
| corpse, warm log, no closing line | **true** | false |
| closed reviewer, trailing blank line after `DONE` | **true** | false |
| closed reviewer, clean | false | false |
| corpse gone cold ($45\,\mathrm{min}+1\,\mathrm{s}$) | false | false |
| cold corpse beside a warm job log `r905_hunt.log` | false | false |
| **live** reviewer, $46$-minute heartbeat gap | **false** | true |
| `gate2_907.log`, warm | true | true |
| **live** reviewer logging to `r908_claim3.log` | **false** | true |

A corpse silences the hook, and a live reviewer on a long computation is declared dead on $5.7$ minutes of margin over the worst gap the hook's own docstring records. The naming regex `r\d+\.log` is doing real work (it correctly rejects the job log) and the same narrowness makes any reviewer that splits its log by phase invisible.

### New: the $45$-minute window does not bound the damage

The docstring reasons about window length as though a too-long window costs *time*: *"a window too long makes a corpse silence the loop, which produces no message at all"*. **The cost is not bounded by the window.** This is a `Stop` hook; it fires when the turn would end. If it exits $0$ because a corpse's log is warm, the turn **ends**, and the next `Stop` event only arrives after a next turn, which only a user message starts. There is no timer, no re-entry, and nothing in the hook that creates a later `Stop` for the cold log to be caught at. **One silenced `Stop` halts the session until the user speaks**, whether the window is $45$ minutes or $45$ seconds.

That is also the answer to *what happens if salvage is never run*: nothing recovers. Salvage has to run **before** the corpse's `Stop`, and the only evidence the loop has that a reviewer died is the same log the hook is misreading.

### The sharpest thing here: as reviewed, salvage destroyed the report it exists to protect

At `e1fc1e6` the overwrite guard read

```python
head = open(out, encoding='utf-8').read(200)
if 'PARTIAL' not in head:
```

so the *word* `PARTIAL` anywhere in the first $200$ bytes marked a real report as salvage-able. **Two hundred bytes is the title line plus most of the byline**, precisely where a reviewer that obeys the brief's *file as soon as you have your first verdict* writes that its report is partial.

Constructed and run against that version: `REVIEW_r912.md` headed *"Filed early per the brief; PARTIAL, claims 4-6 still running"* and carrying a filled verdict table with `**REFUTED**` in it. Salvage reported *"salvaged 3 log lines"*, the file's first line became `# Reviewer 912, PARTIAL (salvaged from its log)`, and the string `REFUTED` was **gone**. No backup, unconditional write.

**The failure was exactly aligned with the protocol**: the reviewer that files early is the one the brief wants and the one whose work salvage silently deleted.

**The working tree already carries the repair**, anchoring the marker the script itself writes, `re.search(r'^# Reviewer \d+, PARTIAL', head, re.M)` over $400$ bytes, and moving the log closer onto one shared path with a leading newline. Re-probed here, all three hold:

| probe | result |
|---|---|
| full report saying `PARTIAL` in its header | **preserved**, `REFUTED` survives, log closed |
| an earlier salvaged `PARTIAL` re-salvaged | overwritten, as intended |
| log whose last write carries **no** trailing newline | closing line lands on its own line; hook reads not-in-flight |

*The leading-newline case is the one the earlier fix would have missed: without it the marker concatenates into the final heartbeat, and the corpse keeps silencing the loop while the script prints "log closed".*

### One smaller one

- **The not-found message names a path that was never checked.** The lookup tries `r{n}.log`, `reviewer{n}.log` and `gate2_{n}.log`, and the failure message hardcodes *"no log at agent_logs/reviewer{n}.log"*, still present. That is the line a user acts on when salvage reports nothing, and it points at one of three candidates.
- **A salvaged partial discharges the Gate 2 debt.** `_unreviewed_commits` counts feat/fix commits since the newest `reviews/REVIEW_r*.md` was **added**, with no filter on content. Committing a salvaged log dump (a file that says of itself *"none of it should be cited as a verdict"*), resets the counter to zero and the hook stops asking for reviewers.

---

## Claim 5, the skill rule in `45ac2ac`

### It is well-posed

*"For every quantity the route names: where is it defined, what was assumed to prove it, and does the route's mechanism stay inside that?"* is answerable on a record like this one, and the rule supplies its own totality clause: *"Where the answer is 'the record does not say', that is itself the finding."* So there is no state in which the rule cannot be discharged. **Well-posed, and the escape hatch is the right one**, it converts an unanswerable question into a plan item rather than into a stall.

### It would have caught all three, on a reading the rule should state

- **The $1/\sqrt2$ conversion.** Domain: $\circ$-decomposables, $k\ge2$ pieces. Mechanism: a residual defined by $k=1$. One line, immediate refusal. **Caught.**
- **$r$ and $S_{\mathfrak{mmm}}$.** Domain: the two-eigenvalue subalgebra family, per [response.md](../response.md) Lemma L23. Mechanism: unbalanced sphere products, which leave it. **Caught.**
- **$W_A\circ W_B=0$ used as coordinate-disjointness.** This one is **not a quantity**. What was borrowed is the *claim* $n_i<n$, whose domain is disjoint index blocks. The rule catches it only if *quantity* is read to include a borrowed statement, which the commit message's own phrasing (*"a hypothesis chosen for its generality"*) concedes. **Caught on that reading; the rule should say so**, since the instance that fits worst is the one that cost the last cycle.

### The structural weakness, and a cheaper check

**The rule asks the route's author to audit the route's author.** The agent that built a mechanism on a borrowed quantity did so because it did not notice the domain; the same agent, at the grading step one paragraph later, is asked to notice. Every instance the commit cites was caught by a **reviewer**, not by the builder, and the rule places the check back on the builder.

**And in all three instances the record already carried the domain.** [fence-posts.md](../findings/fence-posts.md) post F35 states the $1/\sqrt2$ law's restriction to decomposables in the sentence that names it; [nondegeneracy.md](../findings/nondegeneracy.md) line 320 states that $\circ$-orthogonality is *"sufficient but not necessary"* against coordinate-disjointness, with the $\Lambda^+/\Lambda^-$ witness attached; [response.md](../response.md) Lemma L23 states its family. **The failure was not reading, and [findings/INDEX.md](../findings/INDEX.md)'s step 3 already legislates reading**, *"Before claiming anything is new, check the value table below"*, added after three refutations from points already in the file. A second instruction to the same reader is a weaker fix than making the domain unmissable.

**Cheaper and not self-reported: put the domain in the record beside the law.** [findings/INDEX.md](../findings/INDEX.md)'s value table already carries an $n$ column; the finding files state each law in bold with no domain field. A one-off pass that gives every named law a *holds on* clause is written once and read by every future route, where the rule is re-executed by every future route and can be skipped by each of them. The two compose (the rule is the reader's obligation, the field is what makes it cheap) but the field is the half that survives an agent that is not paying attention.

---

## Claim 6, the r259–r278 sweep

Four items from the window are still unapplied to the working tree, checked against the files as they stand:

1. **r278 Claim 3, the struck clause.** [second-order.md](../findings/second-order.md) line 206 still reads *"What the cap needs is $\lvert\theta\rvert\le M(n)/\sqrt2\le\sqrt{3/2}$, i.e. an a priori bound $M(n)\le\sqrt3$"*, unannotated, four paragraphs after the passage `a826ede` supersedes. r278 asked for it to be struck; it is present. **With claim 2's verdict this is now two contradictions in one paragraph**, the sentence before it is the theorem `a826ede` claims as new.
2. **[findings/INDEX.md](../findings/INDEX.md) line 38 is stale on the restricted rank.** It records *"$\mathrm{rank}=14$ as a theorem on the full space with the restricted rank open in $[1,14]$"*, while [sym3-blocks.md](../findings/sym3-blocks.md) proves the restricted rank is $13$ (attained cap at two primes, r209 reproducing independently) and $\dim\mathrm{ANN}=1$. The index is a cycle behind its own file.
3. **The $\Theta_5$ heading contradiction is live in three files.** [plan.md](../plan.md) line 65 lists $\Theta_5=\sqrt{3/2}$ under *Proved and audited*; [findings/INDEX.md](../findings/INDEX.md) line 38 says *proved by an exact rational SOS certificate*; [sym3-blocks.md](../findings/sym3-blocks.md) heads the section *what the certificate **would** establish* and its own flag block says nothing should cite $\Theta_5$ as proved until decided. **Claim 3 above decides it in favour of the first two.**
4. **The two hook directions r278 filed are unrepaired**, as claim 4 reproduces: a warm corpse reads as in flight, a trailing blank line after `DONE` reads as running, and a live reviewer at a $46$-minute gap reads as dead. `d8a34c2` and `e1fc1e6` fixed the salvage side, not the detector.

*Checked and found applied:* r277/r278's refutation of the $n_i<n$ descent (the induction is withdrawn and [support-dichotomy.md](../findings/support-dichotomy.md)'s *"What this replaces"* section names the $(S^4)^3$ witness at $n_1=12$); r278 Claim 5's attribution split on the diagonal grant, carried in [plan.md](../plan.md) line 65 as *"Jäger's published Theorem A covers even $n\ge16$ and Lemma L1 closes $n=12,14$"* with odd $n$ explicitly open; r275/r276's route-M refutation, carried as [fence-posts.md](../findings/fence-posts.md) posts 34 and 35 with both witness constructions.
