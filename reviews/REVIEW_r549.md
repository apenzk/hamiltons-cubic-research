# Review r549, Lemma L34

**Target:** Lemma L34, "full support with two negative eigenvalues, at $m=6$ and $m=8$", in [findings/stratum-two-negative.md](../findings/stratum-two-negative.md), heading `#### Lemma L34` (line 361) down to the next heading.

**Reviewer:** r549, independent adversarial audit, cold. Analysis-only footing: no searches, sweeps, censuses or falsifier hunts; screening of a claim about to be recorded is permitted and is labelled as a screen.

## Phase plan

1. Fix conventions against the record's anchors.
2. Read L34 verbatim.
3. Derive the $m=6$ and $m=8$ witnesses independently; in particular the $m=8$ witness L33's repair leaned on today (two orthogonal padded copies of the 4-dimensional quaternionic point) against its four required properties.
4. Check the `Lemma` vs `Observation` label against the dimensions named.
5. Check the correction to item B0's descent, and that nothing downstream still uses the overreaching form.
6. Check consistency with L33's audited hypothesis and its 4-plane complex-structure exception.
7. Grep the six citations and classify each.
8. Sweep `findings/` for restatements and later passages in the same file that contradict the block.
9. Check the provenance line against the commit before the move.

VERDICT: **CONFIRMED**, statement and both witnesses verified independently; four record defects named below (false provenance with a live unlinked duplicate, a stale closing sentence, unmarked numerics inside a Lemma, and an unpropagated L33 repair).

## Findings

### F1, the $m=8$ witness reproduces exactly, by hand, and all four properties L33's repair needs hold

Derived cold, without the file. A self-dual $\mathrm{Weyl}_4$ element with $W^-=0$ and $\Lambda^+$ spectrum $(w_1,w_2,w_3)$, $\sum w_a=0$, is a Weyl tensor: $\mathrm{Alt}$ is the projection onto $\mathbb R\star$ inside $\Lambda^2\mathbb R^4$ ([conventions.md](../findings/conventions.md)) and $\langle W,\star\rangle=\mathop{\mathrm{tr}}W^+-\mathop{\mathrm{tr}}W^-=0$. Padding preserves both conditions and Ricci-flatness, and both are linear, so the sum of two padded copies is in $\mathrm{Weyl}_8$.

- **Spectrum.** Take each copy with $\Lambda^+$ spectrum $c(1,1,-2)$ (one negative eigenvalue each, as the construction requires). Orthogonal $4$-planes make $\Lambda^2V_1\perp\Lambda^2V_2$, so the spectra concatenate; $\sum\lambda^2=12c^2=1$ gives $c=1/(2\sqrt3)$ and spectrum $\{1/(2\sqrt3)\ (\times4),\ -1/\sqrt3\ (\times2)\}$. **Matches the block.**
- **$\theta$.** $[\mathfrak{so}(V_1),\mathfrak{so}(V_2)]=0$, so every mixed $c_{\alpha\beta\gamma}$ vanishes and $\langle W,W^\#\rangle$ is additive alongside $\mathop{\mathrm{tr}}W^3$; for a self-dual $\mathrm{Weyl}_4$ element $\mathop{\mathrm{tr}}W^3=3w_1w_2w_3$ and $\langle W,W^\#\rangle=6w_1w_2w_3$ (the only non-vanishing $T$ is $T_{123}=2$, the saturated pair cap of [Lemma L31](../findings/stratum-two-negative.md)), so $P=9w_1w_2w_3$ per copy and $\theta=2\cdot9\cdot(-2c^3)=-36c^3=-\sqrt3/2$. **Matches the block.**
- **$\dim U=8$.** A unit self-dual $2$-form on a $4$-plane is nondegenerate there, so $\mathrm{im}\,u_1=V_1$, $\mathrm{im}\,u_2=V_2$, and $U=V_1\oplus V_2=\mathbb R^8$ for any basis of the negative eigenspace.

**The four properties L33's repair leans on, one by one:** (i) *one distinct negative eigenvalue* (holds, both negatives equal $-1/\sqrt3$; (ii) *generically nondegenerate*), holds, $\alpha u_1+\beta u_2$ has rank $4+4=8$ whenever $\alpha\beta\ne0$; (iii) *no $4$-plane complex structure*, holds for those same generic elements, though note the eigenspace also **contains** two elements ($u_1$, $u_2$) that are exactly $4$-plane complex structures, so the witness works only because the refuting reading quantifies existentially over the eigenspace, which is how [Lemma L33](../findings/stratum-two-negative.md)'s own $\mathrm{Weyl}_4$ witness works too; (iv) *$W\ne0$*, holds. **L33's repair stands on this witness.**

### F2, the $m=6$ witness reproduces too, spectrum and $\theta$ to the printed digit

Derived by hand first, then screened. With $V_1=\langle e_1e_2e_3e_4\rangle$, $V_2=\langle e_3e_4e_5e_6\rangle$ and each copy carrying $\Lambda^+$ spectrum $\propto(-2,1,1)$: among the six self-dual generators only $f_1=(e_{12}+e_{34})/\sqrt2$ and $g_1=(e_{34}+e_{56})/\sqrt2$ are non-orthogonal, with $\langle f_1,g_1\rangle=\tfrac12$. On $\mathrm{span}(f_1,g_1)$ the operator $-2(f_1f_1^{\mathsf T}+g_1g_1^{\mathsf T})$ has trace $-4$ and determinant $3$, hence eigenvalues $-3,-1$; the four remaining generators stay orthonormal at $+1$. Spectrum $(-3,-1,1,1,1,1)/\sqrt{14}$. **Matches the block.**

**Screen** (constructed for this check, seconds, reported as a screen and not as evidence): building both witnesses as $4$-index tensors and evaluating $P=\mathop{\mathrm{tr}}W^3+\langle W,W^\#\rangle$ with structure constants of $\mathfrak{so}(m)$ under the record's half-trace pairing,

| | nonzero spectrum | $\theta$ | Bianchi resid | Ricci resid | $\mathop{\mathrm{tr}}W^\#$ | $\dim U$ |
| --- | --- | --- | --- | --- | --- | --- |
| $m=8$, orthogonal planes | $-0.57735027\ (\times2)$, $0.28867514\ (\times4)$ | $-0.866025404$ | $0$ | $0$ | $-1.0$ | $8$ |
| $m=6$, planes meeting in a $2$-plane | $-0.80178373$, $-0.26726124$, $0.26726124\ (\times4)$ | $-1.03086479$ | $0$ | $0$ | $-1.0$ | $6$ |

$-0.57735027=-1/\sqrt3$, $0.28867514=1/(2\sqrt3)$, $-0.866025=-\sqrt3/2$; $-0.80178373=-3/\sqrt{14}$, $-0.26726124=-1/\sqrt{14}$, and $-1.03086479$ against the block's $-1.030865$. The conventions were pinned first against $\mathrm{Id}^\#=(n-2)\mathrm{Id}$ and $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=2(n-2)$ at $n=4,6,8$, and both witnesses return the anchor $\mathop{\mathrm{tr}}W^\#=-1$. **Both witnesses in the block are correct as printed.**

### F3, the two witnesses differ in a way the block does not flag, and only one of them is the one L33 leans on

The $m=8$ witness has **one distinct** negative eigenvalue at multiplicity two; the $m=6$ witness has **two distinct** negative eigenvalues, $-3/\sqrt{14}$ and $-1/\sqrt{14}$. Only the $m=8$ one bears on the distinct-versus-multiplicity reading of [Lemma L33](../findings/stratum-two-negative.md), and L33's note is correct to cite L34 only for "*a second witness at $m=8$*". The block itself never says which of its two witnesses is degenerate on the negative side, so a reader arriving from L33 has to recompute it. Cosmetic, but it is the load-bearing distinction today.

### F4, the provenance line is false, and this is the fourth in this file

The block reads:

> *Moved here from [results.md](../results.md) on 2026-08-31, where the argument was the only copy.*

The move is `a9e4b8c0` ("refactor(results): the proofs move to findings"). At its parent `84cada75`, **[findings/isotropy-cap.md](../findings/isotropy-cap.md) already carried the entire block**, the equivalence-failure paragraph, the construction, both witnesses in a table, and the $\theta>0$ correction with both exact decimals:

> `#### REFUTED: the statement B0 was reduced to is not the rank-3 question, and it is false`
> […] Padding two copies of $W_4(q,r)$ onto 4-planes and adding gives a $\mathrm{Weyl}_m$ element with exactly two negative eigenvalues (one per summand) and support the union of the planes.
>
> | $m$ | planes | spectrum | $\dim U$ | $\theta$ |
> | $6$ | overlapping in a 2-plane | $(-3,-1,1,1,1,1)/\sqrt{14}$ | $6$ | $-1.030865$ |
> | $8$ | orthogonal | $\{-0.57735^{\times2},\,0.288675^{\times4}\}$ | $8$ | $-0.866025$ |
>
> […] **exact** witnesses at $\theta=+0.485408612$ ($m=6$) and $+0.115574271$ ($m=8$) […]

and `ATTEMPTS.md:2098` carried the construction in prose as well ("*two 4-planes sharing a 2-plane, each contributing one negative eigenvalue … reproduces the SDP's spectrum and $\theta=-1.030865$ exactly. At $m=8$ the planes can simply be orthogonal, giving $\theta=-0.866025$*"). **results.md was not the only copy, and was not even the fuller one.** Repair: the same correction [Lemma L31](../findings/stratum-two-negative.md) and [Lemma L33](../findings/stratum-two-negative.md) already carry.

**Worse, the duplicate is still live and unmarked.** [findings/isotropy-cap.md](../findings/isotropy-cap.md) lines 265–302 still hold the whole argument today, with no pointer to L34 and no "canonical statement is in stratum-two-negative.md" note, even though [isotropy-cap.md:255](../findings/isotropy-cap.md) does exactly that for L33 four lines earlier. The numbers have not drifted yet (I checked $-0.57735$, $0.288675$, $(-3,-1,1,1,1,1)/\sqrt{14}$, $-1.030865$, $-0.866025$ against the block, and the file's own $\theta_{\rm sum}=\theta_A/\sqrt2$ against my screen: $-\sqrt{3/2}/\sqrt2=-0.866025$ ✓). **Two unlinked copies of one argument is how they drift.**

### F5, the block's closing sentence is stale, and three passages of the record now contradict it

L34 ends:

> **The consequence for B0 is that $\sup\theta\le\sqrt{3/2}$ on that stratum is now unproved rather than
> differently proved**, the descent was its proof.

Three places say otherwise, one of them 75 lines below it in the same file:

| where | what it says |
| --- | --- |
| [stratum-two-negative.md:435](../findings/stratum-two-negative.md), [Lemma L35](../findings/stratum-two-negative.md) | "*It generalises the one-positive lemma above to **any** number of positive eigenvalues and needs no descent, the descent having been refuted by the full-support witnesses recorded above*"; "*This closes the stratum directly instead.*" |
| [stratum-two-negative.md:515](../findings/stratum-two-negative.md) | "*B0's owed bound is proved, modulo one elementary inequality*", and the sections below it close that inequality in interval arithmetic at $200$ bits, "*no floating-point-only step anywhere*" |
| [report/sections/07-gradedness-split.tex:1034](../report/sections/07-gradedness-split.tex) | "*What the refutation cost was the **route**, not the statement: Lemma 35 proves the same bound directly, and the measured $\sup\theta=\sqrt{3/2}$ at $m=6,8,10,12$ is now a theorem rather than an observation.*" And: "*Nothing is owed here any more.*" |

The mathematics of L34 is untouched by this (the sentence is a status claim about a *different* result) but as written it is a present-tense assertion that the record elsewhere denies. The same stale sentence sits in the live duplicate at [isotropy-cap.md:280](../findings/isotropy-cap.md) ("*So B0's conclusion is now unproved rather than differently proved*"), which in turn contradicts [isotropy-cap.md:161](../findings/isotropy-cap.md) in its own file: "*At $\dim\mathfrak m\le2$ B0 closes it at $\sqrt{3/2}$.*" **Repair: recast L34's last sentence in the past tense and point it at L35**, which is what the report already does.

### F6, the label. `Lemma` is right for the Statement; three sentences inside the block are `Observation`-grade and one of them travels

[INDEX-results.md](../findings/INDEX-results.md) fixes the convention: "*Labels are literal. **Lemma** is proven, Gate 1 and Gate 2 passed. **Observation** is verified numerically at the dimensions stated.*"

- **The Statement is a Lemma.** It is existential at two named dimensions, its proof is a construction, and the construction is exact: linearity of the Bianchi and Ricci conditions gives Weyl membership, and both spectra are closed-form, I derived $(-3,-1)$ at $m=6$ from $\mathop{\mathrm{tr}}=-4$, $\det=3$ of $-2(f_1f_1^{\mathsf T}+g_1g_1^{\mathsf T})$ on $\mathrm{span}(f_1,g_1)$, and $\{1/(2\sqrt3)^{\times4},(-1/\sqrt3)^{\times2}\}$ at $m=8$ from $12c^2=1$. Nothing here rests on a computation. **The label is earned**; what is missing is only the Gate 2 verdict, which [INDEX-results.md:49](../findings/INDEX-results.md) flags itself ("**Gate 2: no verdict on the record**") and which this round supplies.
- **Three sentences in the block are not.** (i) "*reach $\theta=+0.485408612$ at $m=6$ and $+0.115574271$ at $m=8$*", nine-digit decimals from a numerical search (Reviewer 60, per the pre-move text), with no construction given; (ii) "*a structured convex screen finds every rank class infeasible*" at $m\ge10$; (iii) "*both reviewers measured $\sup\theta=\sqrt{3/2}$ exactly at $m=6,8,10,12$*". All three are Observation-grade and sit unmarked inside a Lemma block.
- **And (i) travels.** [results.md:154](../results.md) carries "*In general position they reach $\theta=+0.485$*", and the report puts it **inside the `\begin{Lem}{34}` environment** at [07-gradedness-split.tex:1032](../report/sections/07-gradedness-split.tex), a measured number stated as part of a lemma. **Screen** (constructed for this check, and reported as a screen): with both summands at $\Lambda^+$ spectrum $(-(q+r),q,r)$ I could not reproduce a positive $\theta$, five general-position draws at each of $m=6,8$ gave $\theta\in[-1.035,-0.654]$ and $[-0.954,-0.833]$, and widening to an orientation flip and $(q,r)\in\{(1,1),(1,2),(1,4)\}$ over twelve draws reached only $-0.0295$ at $m=6$ and $-0.355$ at $m=8$. The trend to zero as $r/q$ grows makes $\theta>0$ plausible and my screen is far too small to settle it, **but the two nine-digit figures are unreproduced here, and settling them would need the parameter search the standing rule forbids.** What that run would decide: whether "in general position they reach $\theta=+0.485$" belongs in a lemma statement or is withdrawn to an Observation with its configuration recorded.

### F7, the construction is more rigid than the block says, and [L33](../findings/stratum-two-negative.md) is what makes it so

The block's reason for silence at $m\ge10$ is "*two 4-planes span at most eight dimensions*", which only rules out this shape. **A stronger reason is available from L33 itself, one line.** A summand with exactly one negative eigenvalue has a one-dimensional negative eigenspace, so L33 applies: either the summand is $0$, or its negative eigenvector is a multiple of a complex structure on a $4$-plane, which puts the summand on that $4$-plane. **So *every* decomposition into two summands each carrying one negative eigenvalue is two padded $\mathrm{Weyl}_4$ elements**, the block's construction is the only one of its kind, and $\dim U\le8$ is forced, not merely what these planes happen to give. Worth adding; it turns a limitation of the construction into a fact about the family.

This also settles attack point 4 the other way round: **neither witness is an instance of L33's exception in disguise**, because neither is inside L33's hypothesis. Both have a *two*-dimensional negative eigenspace. What L33's exception governs is each **summand**, and there it is satisfied exactly, each summand's negative eigenvector *is* a $4$-plane complex structure, which is why the summands are nonzero at all. The two lemmas fit together with no tension.

### F8, the six citations, classified

| # | where | what it takes | sound? |
| --- | --- | --- | --- |
| 1 | [findings/INDEX-results.md:49](../findings/INDEX-results.md) | the general claim, as an index row; kind `Lemma`, "**Gate 2: no verdict on the record**" | yes, and the Gate 2 gap is what this round fills |
| 2 | [findings/stratum-two-negative.md:130](../findings/stratum-two-negative.md), [Lemma L33](../findings/stratum-two-negative.md)'s ambiguity box | the **named $m=8$ witness**, as the second counterexample to the distinct-value reading | yes, verified in F1, all four required properties hold |
| 3 | [findings/LEDGER.md:600](../findings/LEDGER.md) | the same named $m=8$ witness, in the L33 audit narrative | yes |
| 4 | [findings/stratum-two-negative.md:440](../findings/stratum-two-negative.md), [Lemma L35](../findings/stratum-two-negative.md)'s motivation | the **corrected form of B0's descent**, "*the descent that used to reduce the general case to dimension four is refuted by Lemma L34*" | yes, and this is the citation that repairs the overreach |
| 5 | [results.md:154](../results.md) and its pointer copy at [results.md:448](../results.md) | the general claim, plus "*In general position they reach $\theta=+0.485$*" | statement yes; the appended decimal is Observation-grade (F6) |
| 6 | [report/sections/07-gradedness-split.tex:1032](../report/sections/07-gradedness-split.tex) | the general claim, **inside a `\begin{Lem}{34}` environment**, with the $+0.485$ figure in the lemma body; the surrounding prose takes the corrected form of the descent | the corrected descent is stated exactly right ("*the refutation cost the route, not the statement*"); the figure should not be in a lemma (F6) |

Plus the tracking row at [plan-verification.md:46](../plan-verification.md), which places L34 in "Tier 2, cited 3 to 7". **No citation anywhere takes the overreaching form of B0's descent.** [plan.md](../plan.md) no longer mentions B0 at all, the report states the corrected form, and [Lemma L35](../findings/stratum-two-negative.md) is the replacement proof. Attack point 3 comes out clean on that half; what it does not come out clean on is F5, where L34's own closing sentence is the passage now out of step with the rest.

### F9, the repair L34's witness served has not reached the three places L33's own box warned it must

L33's box says: "*it is quoted in [results.md](../results.md) and in the report, where that convention does not travel*". The canonical block was repaired to "*a **one-dimensional** eigenspace on one side, exactly one eigenvalue counted with multiplicity*". The quoted copies were not:

- [results.md:152](../results.md), "*has exactly one eigenvalue of one sign*"
- [results.md:438](../results.md), "*Let $W\in\mathrm{Weyl}_m$ have exactly one eigenvalue of one sign.*"
- [report/sections/07-gradedness-split.tex:1023](../report/sections/07-gradedness-split.tex), "*If $W\in\Weyl_m$ has exactly one eigenvalue of one sign*"

All three carry the phrasing L33's own box calls "**FALSE under the other reading**", refuted by exactly the L34 $m=8$ witness this review verified in F1, sitting one page away in the report from L34's own statement, so a reader has both halves of the contradiction in front of them. Outside my target block, but it is the direct consequence of the witness being sound.

## Verdict

**VERDICT: CONFIRMED**

**The Statement and its proof are correct**, rebuilt cold from the definitions and independently reproduced. Both witnesses are exactly as printed, $\{-1/\sqrt3\,(\times2),\,1/(2\sqrt3)\,(\times4)\}$ with $\theta=-\sqrt3/2$ at $m=8$, and $(-3,-1,1,1,1,1)/\sqrt{14}$ with $\theta=-1.03086479$ at $m=6$, both with $\dim U=m$, exactly two negative eigenvalues, and Bianchi and Ricci residuals identically zero under the record's anchors ($\mathrm{Id}^\#=(n-2)\mathrm{Id}$, $\mathop{\mathrm{tr}}W^\#=-1$, $\lVert\varphi_{ab}\rVert^2=1$). The correction to B0's descent is right, and no citation anywhere still takes the overreaching form.

**The $m=8$ witness carries the weight L33's repair put on it.** All four properties hold: one distinct negative eigenvalue, generic nondegeneracy in the negative eigenspace, generic elements that are no $4$-plane complex structure, and $W\ne0$.

**Four defects, none in the mathematics.**

1. **F4, the provenance line is false.** [findings/isotropy-cap.md](../findings/isotropy-cap.md) carried the whole block, more fully than results.md did, at the commit before the move; `ATTEMPTS.md` carried the construction too. **And the duplicate is still live and unlinked at [isotropy-cap.md:265–302](../findings/isotropy-cap.md)**, the fourth block in this file whose "only copy" claim fails against git.
2. **F5, the closing sentence is stale.** "*$\sup\theta\le\sqrt{3/2}$ on that stratum is now unproved*" is contradicted by [Lemma L35](../findings/stratum-two-negative.md) 75 lines below it, by the chain section's interval-arithmetic closure, and by the report, which says the opposite in as many words.
3. **F6 (three Observation-grade sentences sit unmarked in a Lemma block**, and one of them), the $+0.485$ figure, is inside the report's `\begin{Lem}{34}`. My screen could not reproduce it; settling it needs a parameter search the standing rule forbids.
4. **F9, L33's repair, which this witness enabled, has not reached [results.md:152](../results.md), [results.md:438](../results.md) or [report/sections/07-gradedness-split.tex:1023](../report/sections/07-gradedness-split.tex)**, the three copies L33's own box named.

**One improvement (F7):** the block's reason for silence at $m\ge10$ is weaker than what is available. [Lemma L33](../findings/stratum-two-negative.md) forces every one-negative-eigenvalue summand onto a $4$-plane, so $\dim U\le8$ is a fact about the whole family and not a limitation of these particular planes.
