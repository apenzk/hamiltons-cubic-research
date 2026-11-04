# REVIEW r279, Gate 2, the support dichotomy

Reviewer 279. Commits under review: `a826ede` (primary), `e1fc1e6`, `45ac2ac`.
Primary file: [findings/support-dichotomy.md](../findings/support-dichotomy.md). Supporting: [findings/nondegeneracy.md](../findings/nondegeneracy.md), [findings/second-order.md](../findings/second-order.md), [findings/sym3-blocks.md](../findings/sym3-blocks.md), [findings/fence-posts.md](../findings/fence-posts.md), [reviews/REVIEW_r277.md](REVIEW_r277.md), [reviews/REVIEW_r278.md](REVIEW_r278.md).
Scripts: [scripts/reviewers/r279/](../scripts/reviewers/r279/). Reviewer 280 runs the identical brief concurrently and independently.

Every number below comes from [review_r27_core.py](../scripts/review_r27_core.py), an independent from-the-definitions build that shares no code with the reviewed material: $\langle X,Y\rangle=\mathop{\mathrm{tr}}(XY)$ on symmetric operators on $\Lambda^2\mathbb R^n$, $Q(W)=W^2+W^\#$, $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, $P(W)=\langle W,Q(W)\rangle$. The salvage and hook cases run the **committed** files against constructed logs in a throwaway tree.

| # | Claim | Verdict |
|---|---|---|
| 1 | The theorem: every maximiser is $\circ$-indecomposable | **TRUE, AND OVER-EQUIPPED BY A FACTOR OF THREE.** Every step survives, including a piece at $n_i=n$, and steps 1 and 2 are both removable. One line does it: $A_i\circ A_j=0$ makes $P$ **additive**, so $P(W)=\sum a_i^3P(\hat A_i)\le M(n)\sum a_i^3\le M(n)\max_ia_i<M(n)$. That needs no padding, no monotonicity of $M$, no harmonic-square law, and **no criticality of the pieces**, so it also covers splittings the file's own undefined hypothesis excludes. One real defect: the file never defines $\circ$-decomposable, and its stated reason for $M(n)>0$ ("$\theta_0(n)$ is attained") is **false at odd $n$** by the record's own row |
| 2 | What the theorem buys | **NOT NEW, it is [nondegeneracy.md](../findings/nondegeneracy.md) line 366 verbatim, which states the STRONGER form.** The direct-sum saddle lemma ([ATTEMPTS.md](../ATTEMPTS.md) line 782) excludes decomposable **local** maxima, not merely the global one, and [second-order.md](../findings/second-order.md) line 190 already supplies the missing generality. Both re-derived here: $L_eH=H$ at the $\Lambda^\pm$ point, $\mathrm{Hess}=+3\theta\lVert H\rVert^2=2.598076211353$ exactly. The cycle's genuine product is the **retraction** of the r277/r278-refuted assembly, not the theorem |
| 3 | The $\Theta_5$ flag | **DECIDED: $\Theta_5=\sqrt{3/2}$ IS PROVED, and degree-3 adequacy is NOT owed.** $F_5\equiv\tfrac32\lVert W\rVert^6-P(W)^2$ **identically** on $\mathcal W_5$, verified to $10^{-16}$, and forced by Lovelock, which holds at $n=4,5$ ($2\times10^{-15}$) and fails at $n=6,7$ (relative $1.3$, $1.1$). So $F_5\ge0\iff\lvert P\rvert\le\sqrt{3/2}$ at unit norm, and only the **trivial** direction SOS $\Rightarrow$ nonneg is used. Adequacy governs the converse, which nothing here needs. Attainment independently confirmed: $\max P=1.22474487139159$ over 200 ascents, excess $1.1\times10^{-15}$, at spectrum $(2,-1,-1,0^7)/\sqrt6$. The *"what the certificate would establish"* section is stale text sitting below the section that establishes it |
| 4 | The salvage fix and the hook | **BOTH DIRECTIONS SURVIVE, AND THE FIX IS UNTESTED ON THE MODAL CORPSE.** Eight corpse cases and three live-reviewer cases run against the committed code. `_close_log` appends **without a leading newline**, so on a log whose last write lacked one the closing line concatenates onto the heartbeat, the script prints *"log closed"*, and the corpse silences the loop anyway, r278 reported this and `e1fc1e6` did not fix it. **New here:** the refuse-to-overwrite guard is a substring test on 200 characters, so a real report containing the word PARTIAL in its header is **overwritten by the log dump**, data loss, in the branch built to prevent it. If salvage is never run the loop is silenced for the full 45 min, indefinitely if anything keeps the log warm |
| 5 | The skill rule (45ac2ac) | **RIGHT DIAGNOSIS, ILL-POSED FOR ONE OF ITS OWN THREE INSTANCES, AND DOMINATED BY A CHEAPER CHECK.** A *hypothesis* ($W_A\circ W_B=0$) has no domain, so instance 2 is a category error under the rule's own wording. And the rule asks the route to **synthesise** a domain the record often does not state. *Quote each borrowed result's statement verbatim with `file:line` before grading* is mechanical, auditable against the file, catches all three (the qualifiers are **in** the quoted sentences) and catches the misquote class the domain rule misses, which is the class r277 and r278 actually found in S2 |
| 6 | Sweep r259–r278 | **SIX ITEMS STILL UNAPPLIED.** r278's newline defect (above); [second-order.md](../findings/second-order.md) line 206's *"What the cap needs is"* clause, which `a826ede` makes doubly dead; [findings/INDEX.md](../findings/INDEX.md) line 38 still calls the restricted rank *"open in $[1,14]$"* against the file's proved $13$; [plan.md](../plan.md) line 30 still states route S's decomposable half conditionally and line 65 still lists $\Theta_5$ under a claim [sym3-blocks.md](../findings/sym3-blocks.md) says nothing may cite; **reviewers 269–273 have no index row in [reviews/INDEX.md](INDEX.md) at all**, four of them salvaged PARTIALs and r273 a live report with claims 2, 4, 5 and 6 still marked *pending*; and the fence-post table is two counts behind |

---

## Claim 1, the theorem, step by step

Evidence: [r279_defs.py](../scripts/reviewers/r279/r279_defs.py), [out_defs.txt](../scripts/reviewers/r279/out_defs.txt).

**The definitional ground first.** [problem.md](../findings/problem.md) line 114 fixes it: $Q$ is the diagonal of a symmetric trilinear $T(X,Y,Z)=\langle X,Y\circ Z\rangle$, $P(W)=T(W,W,W)$, and Lagrange on $\{\lVert W\rVert=1\}$ gives $Q(W)=\lambda W$ with $\lambda=P(W)$. Full symmetry reproduces here at $n=5,6,7$, the spread over the four orderings of $T$ is $\le2.8\times10^{-17}$, and $P(X)-T(X,X,X)=0$ exactly. So at a unit critical point $\theta=P(W)$, and $M(n):=\max_{\lVert W\rVert=1}P$.

**(d) The maximiser exists.** $\mathcal W_n$ is a linear subspace of $\mathrm{Sym}(\Lambda^2\mathbb R^n)$ of finite dimension, so its unit sphere is closed and bounded, hence compact; $P$ is a cubic polynomial, hence continuous. The max is attained and $M(n)$ is a max, not a sup. **Confirmed, and the file is right to call it $M(n)$.**

**(a) Padding.** Zero-padding $\mathcal W_{n_0}\to\mathcal W_n$ lands in $\mathcal W_n$ (Weyl residual $\le2.7\times10^{-16}$ at $4\to6$, $5\to7$, $6\to8$), preserves the norm **exactly**, preserves $P$ to $1.4\times10^{-17}$, and commutes with $Q$ to $1.1\times10^{-16}$. So $M(n-1)\le M(n)$. **Confirmed.**

**(b) The harmonic-square law.** From the definitions, with $W=\sum a_iA_i$, the $A_i$ unit, pairwise $\circ$-orthogonal and each critical at $\theta_i$: additivity of $Q$ gives $\sum a_i^2\theta_iA_i=\theta\sum a_iA_i$; the $A_i$ are Frobenius-orthogonal because $\langle A\circ B,A\rangle=\langle Q(A),B\rangle=\theta_A\langle A,B\rangle$ and $A\circ B=0$ with $\theta_A\ne0$; so $a_i\theta_i=\theta$ and $\sum a_i^2=1$ give $1/\theta^2=\sum1/\theta_i^2$. **Both hypotheses the brief asks about are load-bearing**: criticality of each piece is what turns $Q(A_i)$ into a multiple of $A_i$, and unit norm is what makes $\sum a_i^2=1$ the sphere condition. **A piece with $\theta_i=0$ cannot occur**: $a_i^2\theta_i=\theta a_i$ with $\theta\ne0$ forces $a_i=0$, so that piece is absent and $k$ counts what is left. The law survives.

**(c) A piece with $n_i=n$.** The argument survives, and the reason is that **$n_i$ never needed to enter**. $A_i$ is already a unit-norm element of $\mathcal W_n$, so $\lvert\theta_i\rvert=\lvert P(A_i)\rvert\le\max_{\lVert X\rVert=1}\lvert P(X)\rvert$; $P$ is an odd cubic and $\mathcal W_n$ is a linear space, so $\min P=-\max P$ and that maximum **is** $M(n)$. Step 1 is therefore not used by step 3. Exhibited at $n_i=n=4$: $\mathcal W_4=\Lambda^+\oplus\Lambda^-$ splits every $W$ ($1.3\times10^{-16}$), the halves are $\circ$-orthogonal ($8.5\times10^{-18}$), and the two $\mathbb{CP}^2$-type pieces are each critical at $\theta=1.224744871392=\sqrt{3/2}$ with residual $1.7\times10^{-15}$, both supported on all four coordinates.

**(e) Positivity.** The argument needs only $M(n)>0$, which the file says holds "because $\theta_0(n)$ is attained". **That reason is false at odd $n$**, [problem.md](../findings/problem.md) line 68, on record: at odd $n$ the best sphere product gives $\frac{2(n-1)(n-3)}{(n-2)(n+1)}<\theta_0(n)^2$, so $\theta_0$ is *not* attained there. The conclusion survives on a weaker fact: padding any balanced product from below gives a point with $P>0$, so $M(n)\ge\theta_0(2\lfloor n/2\rfloor)>0$ at every $n\ge4$.

### The three lines are one line, and the one line is stronger

$A_i\circ A_j=0$ makes $P$ **additive**, not merely $Q$: $P(A+B)=P(A)+3\langle A\circ A,B\rangle+3\langle A\circ B,B\rangle+P(B)$, and $\langle A\circ A,B\rangle=\langle A\circ B,A\rangle=0$ by full symmetry. Verified on $\mathcal W_4$: $P(W)-P(W^+)-P(W^-)=0$ exactly. Hence for any $\circ$-orthogonal splitting $W=\sum a_i\hat A_i$ with $\hat A_i$ unit and $\sum a_i^2=1$,

$$P(W)=\sum_i a_i^3\,P(\hat A_i)\;\le\;M(n)\sum_i a_i^3\;\le\;M(n)\max_i a_i\;<\;M(n)\quad(k\ge2).$$

**No padding, no monotonicity, no harmonic-square law, and no criticality of the pieces.** It is also quantitative ($P(W)\le M(n)\max_ia_i$ caps the value by the concentration of the splitting) and it delivers the equality case for free: $P(W)=M(n)$ forces $\max_ia_i=1$, exactly one nonzero piece. Checked at the $\Lambda^\pm$ pair, where $P(aA+bB)=(a^3+b^3)\sqrt{3/2}$ at $(a,b)=(0.5,0.866)$, $(0.7071,0.7071)$ and $(0.8,0.6)$ to twelve digits, including the two that are **not** critical (residual $0.19$ and $0.12$), which the file's own route cannot reach.

**The one real defect is definitional.** [support-dichotomy.md](../findings/support-dichotomy.md) says *"a $\circ$-decomposition into $k$ pieces with $W_A\circ W_B=0$"* and never says the pieces must be critical of unit norm, yet step 2 is false without it. The definition lives in [second-order.md](../findings/second-order.md) line 190 (*"the $A_i$ pairwise $\circ$-orthogonal and critical"*) and the theorem file does not carry it. Under the one-line proof the question dissolves, since criticality is never used.

## Claim 2, what the theorem does and does not buy

**It is on file, in the stronger form, and it has been since before the assembly.** [nondegeneracy.md](../findings/nondegeneracy.md) line 366, verbatim:

> **What the decomposable case already gives unconditionally.** The direct-sum saddle lemma on record is correct ($\mathrm{Hess}=+3\theta\lVert H\rVert^2$, verified) so decomposable **maximizers** are already excluded with no hypothesis at all. The harmonic-square law's distinct contribution is over the whole decomposable *critical set*, not over maximizers.

And [ATTEMPTS.md](../ATTEMPTS.md) line 782, the lemma itself:

> *Theorem A (direct-sum saddle lemma).* Any critical point with $\theta>0$ that splits over disjoint coordinate blocks is a saddle: $H=\lVert W_2\rVert^2W_1-\lVert W_1\rVert^2W_2$ gives $\mathrm{Hess}=+3\theta\lVert H\rVert^2$ exactly. This kills the entire Fox plateau analytically, for every $k\ge2$ and every $n$.

with [second-order.md](../findings/second-order.md) line 206 stating the consequence: *"Decomposable points are capped by their own pieces and can never set a new maximum."*

**The saddle lemma is strictly stronger than `a826ede`'s theorem** on two axes, and the record already supplies the generality the lemma's own statement lacks. It excludes decomposable **local** maxima, where the new theorem speaks only about the global one. And its hypothesis needs weakening only in wording: [second-order.md](../findings/second-order.md) line 190 proves *"every $\circ$-summand lies in $E(1)$ of $L_e$"*, while line 11 gives the constrained Hessian as $6\theta(L_e-\tfrac12\mathrm{Id})$, so any $\circ$-summand direction is an ascent direction and coordinate-disjointness is never needed. Re-derived here at the $\Lambda^\pm$ pair, which is *not* coordinate-disjoint: $\theta=0.866025403784$, $\lVert L_eH-H\rVert=1.5\times10^{-15}$, and $\mathrm{Hess}=2.598076211353=3\theta\lVert H\rVert^2$ to twelve digits.

**So the theorem is a restatement.** It is a good one (three lines from one identity, where the saddle route needs the Peirce machinery) and it originates with r277, whose index row states it in full. What `a826ede` genuinely delivers is the **retraction**: the earlier assembly's induction and base cases, both refuted by r277 and r278, are gone from the file. That is worth the commit. Calling the theorem *"no induction, no base cases"* new, when the same claim sits four paragraphs into a file the commit cites, is the error [findings/INDEX.md](../findings/INDEX.md)'s own rule 3 exists to prevent.

**Consequence for the record, unstated in the commit.** With the branch closed unconditionally, the *a priori* bound $M(n)\le\sqrt3$ has no consumer. It was needed only to convert $\lvert\theta\rvert\le M(n)/\sqrt2$ into $\le\sqrt{3/2}$ on decomposables, and fence posts 11 and 12 exist to fence a target that no longer has to be hit.

## Claim 3, the $\Theta_5$ flag, decided

Evidence: [r279_theta5.py](../scripts/reviewers/r279/r279_theta5.py), [out_theta5.txt](../scripts/reviewers/r279/out_theta5.txt), [out_f5_min.txt](../scripts/reviewers/r279/out_f5_min.txt).

**$\Theta_5=\sqrt{3/2}$ is proved. The flag's stated reason for doubt is a non-reason.**

**Step 1, the cubic invariant space is one-dimensional at $n=5$, so $P$ *is* $3\mathop{\mathrm{tr}}(W^3)$.** Tested directly rather than cited: $\langle W,W^\#\rangle-2\mathop{\mathrm{tr}}(W^3)$ has relative size $2.8\times10^{-15}$ at $n=4$ and $1.9\times10^{-15}$ at $n=5$, against $1.3$ and $1.1$ at $n=6$ and $n=7$. Since $Q(W)=W^2+W^\#$, $P=\mathop{\mathrm{tr}}(W^3)+\langle W,W^\#\rangle=3\mathop{\mathrm{tr}}(W^3)$ at $n\le5$ and nowhere above. This is the Lovelock syzygy the file names, and [sym3-blocks.md](../findings/sym3-blocks.md) independently recovers it by Weyl integration, degree $3$ giving $1$ in the sequence $1,1,4,5,14$, a method sharing nothing with the contraction identity.

**Step 2, $F_5$ *is* the statement.** Substituting,

$$F_5=\tfrac32\lVert W\rVert^6-9\mathop{\mathrm{tr}}(W^3)^2=\tfrac32\lVert W\rVert^6-P(W)^2 ,$$

**identically on $\mathcal W_5$**, at every scale. Confirmed at four random non-unit points, $\lVert W\rVert^2$ from $24.2$ to $41.2$: the two expressions agree to the last digit printed. So *"$F_5\ge0$ on $\mathcal W_5$"* and *"$\lvert P\rvert\le\sqrt{3/2}$ on the unit sphere of $\mathcal W_5$"* are the same sentence.

**Step 3, the SOS direction used is the trivial one.** A sum of squares is nonnegative. That is all the certificate is asked for. **Degree-3 adequacy is the converse** (whether a nonnegative sextic must be a sum of squares of cubics) and Hilbert's non-automaticity would matter only to an argument that inferred something from the *absence* of a certificate. A certificate is exhibited, with an exact rational Gram at denominator $10^5$, positive definiteness verified by two routes sharing no code, the identity pinned by $\mathrm{rank}(\mathrm{ev}\circ\mu)=13=\mathrm{rank}\,\mu$, and audits by r211 and r212. **Nothing about adequacy is owed.**

**Step 4, attainment, independently.** Two hundred projected ascents on $\mathcal W_5$ reach $\max P=1.22474487139159$ against $\sqrt{3/2}=1.22474487139159$, excess $1.1\times10^{-15}$, a genuine falsification attempt that failed at the sixteenth digit. The top point has criticality residual $6\times10^{-9}$ and $\Lambda^2$ spectrum $(2,-1,-1,0^7)/\sqrt6$, which is [target.md](../findings/target.md)'s $W_0$ exactly. So the bound is attained and $\Theta_5=\sqrt{3/2}$, whether $\Theta_5$ is read as $\max P$ or as the restricted non-diagonal $S=0$ supremum, since $W_0$ satisfies both and the larger set gives the same value.

**What is actually going on in [sym3-blocks.md](../findings/sym3-blocks.md).** The two passages are not in contention on the mathematics: the section at line 96 is headed *"$\Theta_5=\sqrt{3/2}$, an exact rational SOS certificate"* and the *"what the certificate **would** establish"* section at line 137 is **text left over from before that section existed**, its own next line, *"which the record does not have, only $n=4$ is proved"*, is a statement about a record that has since changed. r278 was right to refuse to decide it silently and right that the file contradicts itself; the resolution is editorial, and the residual dependency is the certificate's arithmetic, not adequacy.

## Claim 4, the salvage fix and the hook

Evidence: [r279_salvage_hook.py](../scripts/reviewers/r279/r279_salvage_hook.py), [out_salvage_hook.txt](../scripts/reviewers/r279/out_salvage_hook.txt). Every case runs the committed [salvage_reviewer.py](../scripts/salvage_reviewer.py) and the committed `_agents_running` from [research_loop_stop.py](../.claude/hooks/research_loop_stop.py). `in flight = True` means the hook exits 0 and **emits nothing**.

### A corpse can still silence the loop, four ways

| case | in flight | what it is |
|---|---|---|
| killed reviewer, salvage never run | **True** | the loop is silenced for the full 45 min window |
| killed reviewer, salvage run | False | the fix works, **on a log ending in a newline** |
| killed reviewer, **no trailing newline**, salvage run | **True** | the append concatenates; the script prints *"log closed"* |
| filed-then-killed, no trailing newline, salvage run | **True** | `e1fc1e6`'s own branch, same defect |
| `DONE` followed by a blank line | **True** | `lines[-1]` is `"\n"` |
| empty log | **True** | the agent died before its first write |
| corpse whose mtime a poller refreshes | **True** | indefinite; the window buys nothing |

**The newline defect is r278's, reported and not fixed.** `_close_log` does `fh.write('FAILED closed by ...\n')` with no leading newline, so a log whose last write was `printf 'phase3 running'` becomes

```
[10:00] phase2 running the n=12 solveFAILED salvaged and closed by scripts/salvage_reviewer.py
```

which fails `re.match(r"\s*(DONE|FAILED)\b", tail)`. `e1fc1e6`'s commit message records verification *"against r277's own log"*, a log that ended in a newline, so the case the fix was supposed to cover was never exercised. **The one-character repair is `fh.write('\nFAILED …')`**, or `seek`-and-check.

### A live reviewer can be declared dead, three ways

| case | in flight | what it is |
|---|---|---|
| live, 46 min into one computation | **False** | 6.7 min of margin over the measured worst gap of 39.3 |
| salvage run on a live reviewer | **False** | there is no liveness test anywhere in the script |
| salvage on a live reviewer that already filed | **False** | its log is closed under it while it works |

The second is the sharper one, because the script's docstring instructs *"run it BEFORE TaskStop"* and nothing checks that the target is stopping. It writes a `PARTIAL` over the reviewer's own path and appends `FAILED` to a log still being written. It self-heals only if the reviewer logs again.

### New: the refuse-to-overwrite guard loses real reports

The guard is `if 'PARTIAL' not in open(out).read(200)`. A **real** report whose first 200 characters contain that word (an entirely ordinary verdict line, `**PARTIAL CONFIRMATION**`), falls through and is **overwritten by the log dump**. Reproduced: `overwritten = True`. The branch built to protect the best-behaved reviewer destroys its report if it used one word. **Test the reviewer's own marker line, not a substring of arbitrary prose** (the salvaged header begins `# Reviewer N), PARTIAL (salvaged from its log)`, which is exact and cheap to match.

### If salvage is never run

The loop is silenced for up to 45 minutes and then recovers on its own, since the log goes stale and `_agents_running` stops matching it, **unless something keeps the file warm**, in which case the silence is unbounded. The structural point stands: `_agents_running` infers liveness from a file, and a file is not a process. MEMORY.md's own standing rule for this repository (*wait-loops check PID liveness, never bare sentinels*), is the rule the hook does not follow. The docstring rejects PID checking because *"the logged PID is the shell that wrote the first line"*, which is a fact about the **logging convention**, not about PIDs; a reviewer that logged its own long-lived pid would make the check exact.

## Claim 5, the skill rule

**The diagnosis is right and worth the rule's cost.** Four route generations dying on one shape, none caught by the grade, is exactly the case for a check at the grading step rather than advice in prose. And the rule's escape clause (*"where the record does not say what the domain is, that is the finding"*), is the right instinct.

**It is ill-posed for one of the three instances it cites.** Instances 1 and 3 are quantities and the rule fits them cleanly: the $1/\sqrt k$ conversion is defined on decomposable critical points with $k\ge2$; $r$ and $S_{\mathfrak{mmm}}$ are defined on $W\propto\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$ ([response.md](../response.md) Lemma L23). Instance 2 is **not a quantity**. $W_A\circ W_B=0$ is a *hypothesis*, and a hypothesis has no domain; the error there was silently strengthening it to coordinate-disjointness mid-argument, which no amount of domain-naming detects. Under the rule's own wording that instance is a category error, and the commit claims all three would have been caught.

**A cheaper and more reliable check catches the same class, and one more.** *Before the grade, quote each borrowed result's statement verbatim, with `file:line`, into the route.* It beats domain-naming on four counts:

- **It is copying, not synthesis.** Domain-naming asks the route to produce a fact the record often does not contain; quoting asks it to paste one the record does contain.
- **It is auditable.** A reviewer checks a quote against the file mechanically. A claimed domain has to be re-derived to be checked.
- **The qualifiers are inside the sentences.** *"for $k\ge2$ nonzero pieces"*, *"over disjoint coordinate blocks"*, *"for $W\propto\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$"*, all three failures are visible in one line of quoted text, instance 2 included, because the quote carries the hypothesis the route replaced.
- **It catches the misquote class, which the domain rule misses entirely.** Route S2's actual error, found independently by r277 and r278, was reading Lemma L23's $S_{\mathfrak{mmm}}\ge0$ as the *domain* when the lemma states it as the **cap** and $S_{\mathfrak{mmm}}=0$ as the **equality case**. A route that had quoted the lemma could not have made it.

**Keep the rule, narrow its wording to "each borrowed result" rather than "quantity", and make the verbatim quote the deliverable**, the domain then falls out of the quote in the cases where the record states it, and the escape clause fires honestly in the cases where it does not.

## Claim 6, the sweep, r259–r278

Six items are unapplied to the current tree.

- **r278's newline defect in [salvage_reviewer.py](../scripts/salvage_reviewer.py)**, reported, `e1fc1e6` fixed the adjacent branch, the concatenation survives. Reproduced above.
- **[second-order.md](../findings/second-order.md) line 206** still ends *"What the cap needs is $\lvert\theta\rvert\le M(n)/\sqrt2\le\sqrt{3/2}$, i.e. an a priori bound $M(n)\le\sqrt3$."* r278 said the clause must be struck; `a826ede` makes it doubly dead, since the branch it serves is now closed with no cap at all. Fence posts 11 and 12 fence that dead target.
- **[findings/INDEX.md](../findings/INDEX.md) line 38** still describes $n=5$ as *"$\mathrm{rank}=14$ as a theorem on the full space with the restricted rank open in $[1,14]$"*, against [sym3-blocks.md](../findings/sym3-blocks.md)'s *"THE RESTRICTED RANK IS $13$"*, stale on the value and on the interval.
- **[plan.md](../plan.md)** line 30 still states route S's decomposable half as *"$\lvert\theta\rvert\le\max_iM(n_i)/\sqrt2<1<\theta_0(n)$ is already on file"* and item S1 as open work, both superseded by `a826ede`; line 65 still lists $\Theta_5$ under *"Proved and audited"* while [sym3-blocks.md](../findings/sym3-blocks.md) says *"nothing should cite $\Theta_5$ as proved until this is decided"*. Claim 3 decides it in plan.md's favour, but the two files were left disagreeing.
- **Reviewers 269–273 have no index row in [reviews/INDEX.md](INDEX.md).** The table jumps from **268** to **274**. Four of the five ([r269](REVIEW_r269.md), [r270](REVIEW_r270.md), [r271](REVIEW_r271.md), [r272](REVIEW_r272.md)) are salvaged PARTIALs of 2–6 log lines, and [r273](REVIEW_r273.md) is a **live report with claims 2, 4, 5 and 6 still marked *pending***. r271's verdict is nonetheless cited in [plan.md](../plan.md)'s validation ledger as VALIDATED, so the index is load-bearing and incomplete. *This is the [reviews/INDEX.md](INDEX.md) head's own 205/206 note recurring one cycle later.*
- **The fence-post bookkeeping is two counts behind.** [findings/fence-posts.md](../findings/fence-posts.md) carries posts through **35**; [findings/INDEX.md](../findings/INDEX.md) line 95 is headed *"The fence posts (31 listed)"* and its table omits 30–33 while carrying 34 and 35; [plan.md](../plan.md) line 67 says *"posts 1–33"* two lines after line 31 cites post F35.

**Applied and confirmed applied:** r259/r260's *"drop the slack column and the word binding"*, [brauer-pairing.md](../findings/brauer-pairing.md) line 62 now reads *"ranking them by 'slack' was a category error"*; r277/r278's refutation of the induction and the base cases, gone from [support-dichotomy.md](../findings/support-dichotomy.md); r278's Θ₅ flag, present in [sym3-blocks.md](../findings/sym3-blocks.md), which is what made Claim 3 answerable.
