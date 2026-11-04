# REVIEW r543, Lemma L31, "the bracket cap, characterised"

**Target**: [findings/stratum-two-negative.md](../findings/stratum-two-negative.md), `#### Lemma L31` at line 393, to the next heading at line 416.
**Reviewer**: r543, cold audit, analysis-only footing. Compute used: one screen of my own witnesses, seconds, reported as a screen and never as evidence for a positive claim.

## VERDICT: CONFIRMED

**The statement is true, both directions are proved, and the direction [Lemma L29](../findings/stratum-two-negative.md)'s converse clause consumes (the "only if"), is the sound one.** The cap $\lVert[X,Y]\rVert^2\le2$ is **proved in the block**, not assumed. Six defects, all repairable in place, none touching the mathematics: two dead anchors, a false provenance line, an unstated symmetry step, an index slip in the consuming sentence, and a citation that under-uses the lemma.

## The conventions, fixed first

[findings/conventions.md](../findings/conventions.md) fixes $\langle A,B\rangle=\tfrac12\mathop{\mathrm{tr}}(A^{\mathsf T}B)$ at the $\Lambda^2$ level, and with it *"singular values in pairs $s_1,s_1,s_2,s_2,\dots$ with $\sum_is_i^2=1$"* and $\lVert\varphi_{ab}\rVert^2=1$, making $\{\varphi_{ab}\}_{a<b}$ orthonormal. **L31's hypothesis $\sum_is_i^2=1$ is that pairing verbatim, and every constant in the block is consistent with it.** This was the collision to look for and it is not present:

| quantity | value at the cap | consistent? |
| --- | --- | --- |
| $\lVert X\rVert^2=\lVert Y\rVert^2$ | $1$ (half-trace) | yes, matches $\sum s_i^2=1$ |
| $\lVert Y\rVert_F$ | $\sqrt2$ | yes |
| $\lVert X\rVert_{\rm op}$ | $1/\sqrt2$ | yes, from $s_1=s_2=1/\sqrt2$ |
| $\lVert[X,Y]\rVert_F$ | $2$, since $\lVert[X,Y]\rVert^2=2$ | yes |
| the block's bound $2\lVert X\rVert_{\rm op}\lVert Y\rVert_F$ | $2$ | **equality throughout, the chain is forced, as the proof needs** |

The eigenvectors L29 feeds in are orthonormal in exactly this pairing ($\sum_\alpha\lambda_\alpha^2=\mathop{\mathrm{tr}}W^2=1$ against an orthonormal $\Lambda^2$ basis), so the hypothesis transfers cleanly. Had the record run at Frobenius unit norm instead, the cap would read $\lVert[X,Y]\rVert_F^2\le1$ and every consumer would be off by a factor $2$; it does not.

## Q1, the cap is proved here, not assumed

**Proved, in the block's first two sentences, and I re-derive it cold.** $\mathop{\mathrm{ad}}_X$ is skew for the ad-invariant half-trace form, so its operator norm is the largest modulus of an eigenvalue of its complexification, and the roots of $\mathfrak{so}(n)$ give those as $i(\pm s_i\pm s_j)$ (and $i(\pm s_i)$ at odd $n$). Hence

$$\max_{\lVert Y\rVert=1}\lVert[X,Y]\rVert^2=(s_1+s_2)^2,\qquad (s_1+s_2)^2\le2(s_1^2+s_2^2)\le2\sum_is_i^2=2 .$$

So the inequality and the equality case come from **one** computation, and the "characterised" in the heading understates what the block does. The record's other consumers of the bare cap ([conventions.md](../findings/conventions.md) line 74, [bounds.md](../findings/bounds.md) line 31, [fence-posts.md](../findings/fence-posts.md) line 175, [bounds-relaxations.md](../findings/bounds-relaxations.md)) all trace back to this same fact, [bounds-relaxations.md](../findings/bounds-relaxations.md) line 269 names it outright as *"proven through $\|\mathrm{ad}_X\|_{\mathrm{op}}\le\sqrt2$"*, which is L31's step one. **No consumer inherits an unproved hypothesis.**

The withdrawn $\lVert[X,Y]\rVert^2\le4s_1^2$ argument, and the block's own note retracting it, are both correct: $s^2=(0.5,0.3,0.2)$ has $s_1^2\ge\tfrac12$ at rank $6$, so that route could not have forced rank $4$. The replacement does.

## Q3, the "only if", checked hardest

This is the direction L29's closure consumes, so I re-derived every step rather than reading it.

1. $2=\lVert[X,Y]\rVert^2\le(s_1+s_2)^2\le2$ forces $s_1=s_2=1/\sqrt2$ and the rest zero: **rank exactly $4$, all singular values $1/\sqrt2$**. Sound.
2. The same argument with the roles swapped ($\lVert[Y,X]\rVert=\lVert[X,Y]\rVert$ against $Y$'s own angles), gives the same for $Y$. Sound, **but the block does not say it** (see defect 4).
3. Equality throughout $\lVert[X,Y]\rVert_F\le\lVert XY\rVert_F+\lVert YX\rVert_F\le2\lVert X\rVert_{\rm op}\lVert Y\rVert_F$ is forced, because with step 1 the right end is exactly $2$ and the left end is exactly $2$. Sound.
4. Equality in $\lVert XY\rVert_F\le\lVert X\rVert_{\rm op}\lVert Y\rVert_F$ means every column $y$ of $Y$ satisfies $\lVert Xy\rVert=\lVert X\rVert_{\rm op}\lVert y\rVert$, i.e. lies in the top right-singular subspace of $X$. Since all four nonzero singular values coincide, that subspace **is** $\mathop{\mathrm{im}}X$, for skew $X$, $X^{\mathsf T}X=-X^2$ and its top eigenspace is $\mathop{\mathrm{im}}X$. So $\mathop{\mathrm{im}}Y\subseteq\mathop{\mathrm{im}}X$, and equality follows from $\dim=4$ on both sides (the block's "and symmetrically" also works). Sound.
5. Triangle equality $\lVert A-B\rVert_F=\lVert A\rVert_F+\lVert B\rVert_F$ with $A=XY$, $B=YX$ and $\lVert A\rVert_F=\lVert B\rVert_F=1\ne0$ forces $A=-B$, i.e. $XY=-YX$. Sound. The auxiliary $\lVert XY\rVert_F=\lVert YX\rVert_F$ is an identity for skew $X,Y$, both sides equalling $\mathop{\mathrm{tr}}(X^2Y^2)$, so it is not an extra assumption.

**The "if" direction is sound too**, and its arithmetic is right in the record's pairing: $X^2=Y^2=-P_V/2$, $[X,Y]=2XY$, so $\lVert[X,Y]\rVert^2=2\mathop{\mathrm{tr}}(Y^{\mathsf T}X^{\mathsf T}XY)=\mathop{\mathrm{tr}}(Y^{\mathsf T}P_VY)=\mathop{\mathrm{tr}}(Y^{\mathsf T}Y)=2$, the middle step using $P_VY=Y$, which is where the **equal-images hypothesis is consumed**.

**And the closure L29 needs goes through.** Equality in L29 forces $T_{1,N-1,N}=2$; since $T_{1,N-1,N}\le\sum_\gamma T_{1,N-1,\gamma}=\lVert[v_1,v_{N-1}]\rVert^2\le2$, the pair saturates, and by total symmetry of $T$ so does $(v_{N-1},v_N)$. L31's "only if" then gives $\mathop{\mathrm{im}}v_{N-1}=\mathop{\mathrm{im}}v_N$ of dimension $4$, so [Lemma L30](../findings/stratum-two-negative.md)'s $U$ is four-dimensional and $r=4$. **The three lines are real.**

## Q2, all three conditions are independent, and none is missing

Each witness below kills one condition while satisfying the other two *and* orthonormality, and has bracket norm $\ne2$, so no condition can be dropped, and the characterisation is not over-strong.

| condition dropped | witness | the other two hold? | $\lVert[X,Y]\rVert^2$ |
| --- | --- | --- | --- |
| $XY=-YX$ | $X=I_1/\sqrt2$ self-dual, $Y=J_1/\sqrt2$ anti-self-dual on $\mathbb R^4$, these **commute** | yes: both rank $4$, all singular values $1/\sqrt2$, images both $\mathbb R^4$, and $\langle X,Y\rangle=0$ | $0$ |
| rank $4$ with equal singular values | $X=\varphi_{12}$, $Y=\varphi_{34}$ | yes: $XY=YX=0$ so they anticommute; orthonormal | $0$ |
| $\mathop{\mathrm{im}}X=\mathop{\mathrm{im}}Y$ | $I_1/\sqrt2$ on $\mathbb R^4\oplus0$ and on $0\oplus\mathbb R^4$ inside $\mathfrak{so}(8)$ | yes: anticommute, both rank $4$ with singular values $1/\sqrt2$ | $0$ |

The self-dual/anti-self-dual pair is the sharp one: it is the reason the anticommuting clause **cannot** be deduced from "rank $4$, equal singular values, equal images, orthonormal", which is the deduction a reader in a hurry would make.

**Orthonormality is redundant in the "only if" direction**: $XY=-YX$ gives $\mathop{\mathrm{tr}}(XY)=0$, hence $\langle X,Y\rangle=0$; and rank $4$ with singular values $1/\sqrt2$ already gives $\lVert X\rVert^2=1$. Harmless as a hypothesis, and it is how the consumers supply the pair anyway.

## Q4, the range of $n$

**The block states no range, and none is needed.** At $n\le3$ there is no rank-$4$ element and $(s_1+s_2)^2\le1<2$, so both sides of the equivalence are empty and the statement is vacuously true. At $n=4$ the equality case exists (the quaternionic pair) and the equal-images clause is vacuous, both images being $\mathbb R^4$. At $n=5$ the clause has content (two distinct $4$-planes in $\mathbb R^5$ meet in dimension $3$) and the witness embeds, so the equivalence is non-vacuous in both directions. **A one-clause "the content is at $n\ge4$" would help a reader and change nothing.**

One cosmetic looseness: the listed eigenvalues *"$i(\pm s_i\pm s_j)$ and $i(\pm s_i)$"* are the $B_m$ roots; at even $n$ the short roots $i(\pm s_i)$ are absent. Since $s_1+s_2\ge s_1$ always, the maximum is unaffected and the bound stays correct.

## Q6, the citations, classified

| site | what it takes |
| --- | --- |
| [stratum-two-negative.md:82](../findings/stratum-two-negative.md), the L29 bridge | the **"only if"**: equality $\Rightarrow$ equal images of dimension $4$ |
| [stratum-two-negative.md:200](../findings/stratum-two-negative.md) | the **rank clause alone**: *"the bracket cap forces both to rank $4$"* |
| [stratum-two-negative.md:267](../findings/stratum-two-negative.md) | the **"only if"**: *"At the bracket cap, $W$ is a padded $\mathrm{Weyl}_4$ element"* |
| [stratum-two-negative.md:278](../findings/stratum-two-negative.md), the $\delta$ table | **anticommutation and equal supports** |
| [stratum-two-negative.md:353](../findings/stratum-two-negative.md) | the **rank-$4$-with-equal-singular-values clause alone** |
| [stratum-two-negative.md:424](../findings/stratum-two-negative.md), the assembled table | **all three conditions**, as the $\delta=0$ row |
| [stratum-two-negative.md:502](../findings/stratum-two-negative.md), the L72 block | the **"only if"**, as what closes L29's clause |
| [LEDGER.md:622](../findings/LEDGER.md), [:914](../findings/LEDGER.md) | attribution only |
| [LEDGER.md:912](../findings/LEDGER.md) | the **"only if"**, spelled out in three lines |
| [INDEX-results.md:44](../findings/INDEX-results.md), [:86](../findings/INDEX-results.md) | attribution only |
| [results.md:148](../results.md), [:424](../results.md) | the statement, landscape and canonical |
| [ELIM-stratum.md:95](ELIM-stratum.md) | the **"only if"**, for a second closure of the stratum |

**Every consumer that names L31 takes the "only if", and that is the direction I checked hardest.** The consumers that take only the inequality cite [conventions.md](../findings/conventions.md) instead, so the cap and its equality case are drawn from separate places and both are sound.

## The defects

**1. Both in-file anchors to L31 are dead.** [stratum-two-negative.md:82](../findings/stratum-two-negative.md) and [:502](../findings/stratum-two-negative.md) both link

> `[Lemma L31](../findings/fence-posts.md#post-f31-the-sharp-target-is-not-freely-described-and-n-cannot-be-smuggled-in-as-a-trace)`

while the heading reads *"Lemma L31 (the bracket cap, characterised), canonical statement and proof"*, whose anchor is `#lemma-l31--the-bracket-cap-characterised--canonical-statement-and-proof`. The old title survives in the links. **These are the two sites through which the newly load-bearing closure is reached**, so the reader sent to check the three-line argument lands nowhere.

**2. The provenance line is false, and demonstrably so.** The block says

> *"Moved here from [results.md](../results.md) on 2026-08-31, where the argument was the only copy."*

At `a9e4b8c0^` (the parent of the commit *"refactor(results): the proofs move to findings"*), the distinctive phrase *"top singular subspace"* is present in **both** `results.md` **and** `findings/stratum-two-negative.md`, at line 128 of that revision. So this file already carried the complete argument. **The duplicate is still here, at [stratum-two-negative.md:257–263](../findings/stratum-two-negative.md)**, in development form and with the numerics attached. [Lemma L29](../findings/stratum-two-negative.md)'s provenance line thirty lines away has already been repaired with exactly the right wording, *"**The claim once made here, that results.md held the only copy, is false**: this file already carried the complete argument before the move, which is why it appears twice below"*, and **L31's was not**. The same sentence fits verbatim.

**3. The index in the consuming sentence slips mid-clause.** [stratum-two-negative.md:82](../findings/stratum-two-negative.md) reads

> *"equality forces $T_{1,N-1,N}=2$, hence $\lVert[v_2,v_3]\rVert^2=2$, hence $\mathop{\mathrm{im}}v_2=\mathop{\mathrm{im}}v_3$ of dimension $4$"*

the triple is indexed $1,N-1,N$ and the pair is then indexed $2,3$. The mathematics is right under the reading "$v_2,v_3$ = the second and third support vectors = $v_{N-1},v_N$", and $v_{N-1},v_N$ is the pair the conclusion actually needs, since [Lemma L30](../findings/stratum-two-negative.md)'s $U$ is built from the two negative eigenvectors. **Written as it stands it names a pair that does not exist in the sentence's own indexing.** [LEDGER.md:912](../findings/LEDGER.md) repeats it verbatim.

**4. The proof establishes rank $4$ for $X$ and asserts it for both.** The statement says *"both $X$ and $Y$ have rank $4$"*; the proof runs the root-system argument on $X$'s angles only and never says the roles swap. The development form above it does (*"Symmetric in $X$ and $Y$, so both"*) and the canonical block dropped that clause. One phrase restores it.

**5. No range of $n$ is stated.** Correct as written (see Q4), but a reader checking the $4$-plane witness has to establish the vacuity at $n\le3$ himself.

**6. A consumer under-uses the lemma.** [stratum-two-negative.md:200](../findings/stratum-two-negative.md) argues *"the bracket cap forces both to rank $4$, so the sum has rank $\le8<n$ and $\epsilon_{\min}=0$"*. L31 gives $\mathop{\mathrm{im}}X=\mathop{\mathrm{im}}Y$, so the sum has rank exactly $4$ and the conclusion holds at every $n\ge5$ rather than only $n\ge9$. True as written, weaker than what is available.

## What the parent checked, re-checked

The quaternionic witness and the $\lVert[\varphi_{12},\varphi_{13}]\rVert^2=1$ contrast are both correct. I re-derived the second by structure constants: $[\varphi_{12},\varphi_{13}]=-\varphi_{23}$, norm-squared $1$, which is also what $(s_1+s_2)^2=1$ predicts for $\varphi_{12}$'s profile $s=(1,0)$. So $2$ is a genuine cap and the generic value is well below it.

## Screen

*Permitted screening only, seconds of compute on objects I constructed for the purpose, reported as a screen and never as evidence for a positive claim.* In the record's own half-trace pairing: $\lVert\mathop{\mathrm{ad}}_X\rVert_{\rm op}^2$ agreed with $(s_1+s_2)^2$ to twelve digits on four angle profiles at $n=6$ and $n=7$; the quaternionic pair returned exactly $2$ with anticommutator residual $0$; and the three independence witnesses returned bracket norm $0$ with the stated ranks, singular values and orthonormality. Nothing in the screen disagrees with the derivations above, and the derivations stand on their own.

## Adjacent, out of scope, flagged not fixed

[Lemma L35](../findings/stratum-two-negative.md) at line 442 relaxes $T$ to *"any nonnegative totally symmetric tensor with row marginals $m-2$ and pair caps $\sum_\gamma T_{\alpha\beta\gamma}\le2$"*. [conventions.md](../findings/conventions.md) records the Killing marginal as $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=2(n-2)$ and rules that *"sums over pairs are over ORDERED pairs unless the line says otherwise"*; [bounds.md:31](../findings/bounds.md) and [fence-posts.md:175](../findings/fence-posts.md) both write $2(n-2)$. **L35's $m-2$ is the unordered-pair value carried under a convention that defaults to ordered**, and it is the only site in the record stating the marginal that way without saying $\beta<\gamma$ as [bounds-relaxations.md:172](../findings/bounds-relaxations.md) does. The number is defensible; the line does not say which reading it takes. **This does not touch L31 and I have not pursued it.**

## Recommended repairs

1. Fix the two dead anchors at [:82](../findings/stratum-two-negative.md) and [:502](../findings/stratum-two-negative.md) to `#lemma-l31--the-bracket-cap-characterised--canonical-statement-and-proof`.
2. Replace the provenance line with L29's already-repaired wording, naming [:257–263](../findings/stratum-two-negative.md) as the surviving duplicate.
3. Reindex line 82's pair to $v_{N-1},v_N$, and the same sentence at [LEDGER.md:912](../findings/LEDGER.md).
4. Restore *"symmetric in $X$ and $Y$, so both"* to the canonical proof.
5. Add *"the content is at $n\ge4$; at $n\le3$ both sides are empty"* to the statement.
6. Sharpen [:200](../findings/stratum-two-negative.md) from rank $\le8$ to rank $4$.
