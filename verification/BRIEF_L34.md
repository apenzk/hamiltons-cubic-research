# Brief for round L34

**Verbatim extracts. Nothing here is paraphrased.**

## A. The canonical statement, from results.md

```markdown
##### Lemma L34, full support with two negative eigenvalues, at $m=6$ and $m=8$

For $m=6$ and $m=8$ there is a $W\in\mathrm{Weyl}_m$ with exactly two negative eigenvalues and $\dim U=m$, where $U=\mathrm{im}\,v_{N-1}+\mathrm{im}\,v_N$.

**Construction.** Pad two copies of $W_4(q,r)$ onto 4-planes of $\mathbb R^m$ and add. Both defining conditions are linear, so the sum is a $\mathrm{Weyl}_m$ element whatever the planes do; each summand contributes exactly one negative eigenvalue, and the support is the union of the planes. Orthogonal planes at $m=8$ give spectrum $\{-1/\sqrt3\ (\times2),\ 1/(2\sqrt3)\ (\times4)\}$ and $\theta=-\sqrt3/2$; planes meeting in a 2-plane at $m=6$ give $(-3,-1,1,1,1,1)/\sqrt{14}$ and $\theta=-1.030865$. $\square$

**Proof:** [stratum-two-negative.md](findings/stratum-two-negative.md)
```

## B. The landscape statement, from results.md

```markdown
- **Lemma L34 (landscape). Full support with two negative eigenvalues, at $m=6$ and $m=8$.** Two padded signature-$(2,1)$ $\mathrm{Weyl}_4$ tensors on 4-planes sum to a $\mathrm{Weyl}_m$ element with $\dim U=m$, refuting the descent statement B0 rested on. In general position they reach $\theta=+0.485$.
```

## C. The block in findings/stratum-two-negative.md, lines 369-396

```markdown
#### Lemma L34, full support with two negative eigenvalues, at $m=6$ and $m=8$, canonical statement and proof

*Moved here from [results.md](../results.md) on 2026-08-31. **The first clause of the note that stood here survives against git, results.md did hold the only copy, and the second is now true, the duplication having been resolved on 2026-09-06**: that file carried the whole construction byte-identical and then points at the file duplicating it. [isotropy-cap.md](isotropy-cap.md) also holds an unlinked copy of this block.*

Needed because item B0's descent had been recorded as closing once *no* $\mathrm{Weyl}_m$ element with at
most two negative eigenvalues has full support, a statement stronger than Lemma L33 settles, and one whose
claimed equivalence to the rank-3 question holds only at a single positive eigenvalue.

**Statement.** For $m=6$ and $m=8$ there is a $W\in\mathrm{Weyl}_m$ with exactly two negative eigenvalues and
$\dim U=m$, where $U=\mathrm{im}\,v_{N-1}+\mathrm{im}\,v_N$.

**Construction.** Pad two copies of $W_4(q,r)$ onto 4-planes of $\mathbb R^m$ and add. Both defining conditions
are linear, so the sum is a $\mathrm{Weyl}_m$ element whatever the planes do; each summand contributes exactly
one negative eigenvalue, and the support is the union of the planes. Orthogonal planes at $m=8$ give spectrum
$\{-1/\sqrt3\ (\times2),\ 1/(2\sqrt3)\ (\times4)\}$ and $\theta=-\sqrt3/2$; planes meeting in a 2-plane at
$m=6$ give $(-3,-1,1,1,1,1)/\sqrt{14}$ and $\theta=-1.030865$. $\square$

**Why the recorded equivalence fails.** With one positive eigenvalue, Ricci-flatness forces
$U=\mathrm{im}\,v_1$, so full support means a nondegenerate eigenvector and Lemma L33 applies. With several
positive eigenvalues it reads
$\sum_{\lambda_\alpha>0}\lambda_\alpha v_\alpha v_\alpha^{\mathsf T}=b\,yy^{\mathsf T}+c\,zz^{\mathsf T}$
and constrains no rank at all. That is the gap the witnesses occupy.

**What it does not reach, stated plainly.** These witnesses do **not** all carry $\theta\le0$: $P$ is cubic and
additive only over Frobenius-orthogonal supports, so 4-planes in general position keep the cross term and
reach $\theta=+0.485408612 *(measured, not derived, and [isotropy-cap.md](isotropy-cap.md) records $+0.6259$ for the same family, a conflict this block does not resolve)*$ at $m=6$ and $+0.115574271$ at $m=8$. And two 4-planes span at most eight
dimensions, so the construction is silent at $m\ge10$, where a structured convex screen finds every rank class
infeasible and a one-parameter deformation shows the margin reaching zero only where the support degenerates.
```

## D. The third copy, unlinked, in findings/isotropy-cap.md lines 343-360

```markdown
On $\mathbb R^4$ the self-dual forms are complex structures, and $W_4(q,r)=-(q+r)\,w_1\otimes w_1+q\,w_2\otimes w_2+r\,w_3\otimes w_3$ lies in $\mathrm{Weyl}_4$ with signature $(2,1)$ and a full-rank minority eigenvector; its negative is the B0 base-case family at $\theta=+\sqrt{3/2}$, which is also the Weyl part of the Fubini–Study operator at $m=4$. **So the $520$ starts of Reviewers 58 and 59 were hunting an object that does not exist**, and the obstruction is that a singular-value vector can be proportional to a $D_p$ root only when $p\le2$.

#### REFUTED: the statement B0 was reduced to is not the rank-3 question, and it is false

[plan.md](../plan.md) recorded B0 as closing iff *no element of $\mathrm{Weyl}_m$ with $\dim\mathfrak m\le2$ has $\dim U=m$*, and recorded the rank-3 question as an equivalent form. The equivalence holds only at one positive eigenvalue: with several positives, Ricci-flatness reads $\sum_{\lambda>0}\lambda_\alpha v_\alpha v_\alpha^{\mathsf T}=b\,yy^{\mathsf T}+c\,zz^{\mathsf T}$ and constrains no rank. Padding two copies of $W_4(q,r)$ onto 4-planes and adding gives a $\mathrm{Weyl}_m$ element with exactly two negative eigenvalues (one per summand) and support the union of the planes. Weyl membership needs no check beyond the arithmetic, both conditions being linear:

| $m$ | planes | spectrum | $\dim U$ | $\theta$ |
|---|---|---|---|---|
| $6$ | overlapping in a 2-plane | $(-3,-1,1,1,1,1)/\sqrt{14}$ | $6$ | $-1.030865$ |
| $8$ | orthogonal | $\{-0.57735^{\times2},\,0.288675^{\times4}\}$ | $8$ | $-0.866025$ |

Ricci-flatness, Bianchi and the identity at $10^{-16}$ ([b0_full_support_witness.py](../scripts/lib/b0_full_support_witness.py)); rebuilt from scratch and fully screened by both reviewers. **The recorded statement is false at $m=6$ and $m=8$.**

#### Corrected: these witnesses do not all have $\theta\le0$

$P$ is cubic, so it is additive over summands only when their supports are Frobenius-orthogonal. Orthogonal 4-planes give cross term exactly zero and $\theta_{\rm sum}=\theta_A/\sqrt2\le0$; **overlapping planes keep the cross term, and $\theta>0$ occurs**, three explicit $m=6$ witnesses with both summands negative and sums at $+0.1384$, $+0.1210$, $+0.0965$, each with exactly two negative eigenvalues and $\dim U=6$ (Reviewer 61), and **exact** witnesses at $\theta=+0.485408612$ ($m=6$) and $+0.115574271$ ($m=8$), both with two negative eigenvalues and $\dim U=m$, from 4-planes in **general position** (Reviewer 60); random general-position draws reach $+0.6259$ at $m=6$ and $+0.2650$ at $m=7$. **The clause is safe only for orthogonal planes**, where the two $\Lambda^2$ summands are orthogonal and $P$ is additive, which is the special shape both recorded witnesses happen to have, and presumably how the error survived.

#### So B0's conclusion is now unproved rather than differently proved
```
