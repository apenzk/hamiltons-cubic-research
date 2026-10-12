# Review r190, the pointwise fence post, the omega contraction, and the cheap basis

Gate 2, adversarial. Everything below was re-derived from definitions and re-measured with scripts written for this review, under [scripts/reviewers/r190/](../scripts/reviewers/r190/). Exact arithmetic throughout: rational over $\mathbb Q$ where the object is rational, and $\mathbb F_p[i]$ at primes and sample points chosen independently of the record's.

## Verdict table

| Claim | Verdict | What decided it |
| --- | --- | --- |
| 1, no Hermitian block-diagonal form in the $P_i$ equals $F_5$ pointwise | **Upheld, and strengthened** | Replicated at $p=1000003$ ($p\equiv3\bmod4$): coefficient rank $89$, augmented $90$. Dropping block-diagonality entirely (full Hermitian $G$ on all $41$ covariants, $1681$ real unknowns, $1721$ points), still gives coefficient rank $1681$ (full) against augmented rank $1682$ |
| 1a, mod-$p$ inconsistency implies inconsistency over $\mathbb Q$ | **Sound, but the write-up omits the step that makes it sound** | The argument works only because [random_weyl](../scripts/reviewers/r179/weyl_invariants.py) is a purely *rational* construction |
| 1b, the Hermitian parametrisation | **Correct** | $89=\sum_\lambda m_\lambda^2$ confirmed; row $\cdot$ $x$ matches the honest double sum $\sum_{ij}G_{ij}P_i\overline{P_j}$ exactly, and the value is real |
| 1c, the corrected structural story | **Correct, and now measured rather than asserted** | The invariant Hermitian block-diagonal forms in the $P_i$ have dimension exactly $1$, supported precisely on the trivial block's diagonal |
| 1d, "and does it explain the rank deficit of exactly $1$" | **The question is empty** | An augmented rank can never exceed the coefficient rank by more than $1$. "$90$ against $89$" carries one bit, inconsistency, and no quantitative agreement to explain |
| 2, the omega contraction applies no multiplicity factor | **Correct as written. No change to claim 1** | The highest-weight vectors are built in the *monomial* convention, which is the convention [Pval](../scripts/runs/run_n5_certificate.py) evaluates. Applying multiplicities destroys $SO(5)$-invariance of the trivial-block covariant |
| 3, $F_5$'s normalisation in that script | **Correct, and the hazard is inert here** | $q$ and $\operatorname{tr}(M^3)$ are both pure tensor contractions; and the $3/2$ and the $9$ are the *same* in both conventions |
| 4 (the cheap-basis rank result | **Real, not a sampling artefact), now exhaustive** | The whole cap-$8$ family is $3$ isomorphism classes $\times\ 3^6$ slot assignments $=2187$ diagrams; all were evaluated and the rank is $10$ at three independent primes |
| 4a, "and only $\le 12$ gives $14$" | **A check that could not fail** | Every loopless matching has all ten balanced cuts $\le 12$, so the cap-$12$ filter admits $100\%$ of diagrams |

---

## Claim 2, the omega contraction

**The question is which convention the cached highest-weight vectors live in**, and it is settled by [raise_mono](../scripts/runs/run_n5_highest_weight.py), the routine that defines them. For a monomial index $t=(a,b,c)$ it loops over the three *slots*, replaces each by $E$ applied to it, and re-sorts. On $t=(a,a,a)$ that produces the coefficient $3\,E_{a\to s}$ on the monomial $(a,a,s)$.

- In the **polynomial monomial** convention the coefficient vector $u$ means $\sum_t u[t]\,x_{t_1}x_{t_2}x_{t_3}$, and the derivation gives $D(x_a^3)=3x_a^2D(x_a)$, coefficient $3$. **Match.**
- In the **symmetric tensor** convention $u$ means $\sum_t u[t]\,e_{t_1}\odot e_{t_2}\odot e_{t_3}$ with $\odot$ the sum over distinct permutations, and $D(e_a\otimes e_a\otimes e_a)=e_a\odot e_a\odot e_s$, coefficient $1$. **Mismatch.**

So the cache is in the monomial convention, [Pval](../scripts/runs/run_n5_certificate.py) evaluates the monomial convention, and **no multiplicity factor belongs anywhere**. Applying one would amount to a diagonal rescaling $D$ of the monomial basis, and $Du$ is not in the kernel of the raising operators.

**The test that could have failed.** The trivial block $\lambda=(0,0)$ carries exactly one highest-weight vector, so $P_1$ must be an $SO(5)$-invariant cubic on $\mathcal W_5$. [claim2_convention.py](../scripts/reviewers/r190/claim2_convention.py) feeds $W$ and $gW$ for exact orthogonal $g$ over $\mathbb F_p$ built from Pythagorean rotations:

- plain contraction: invariant at all six samples;
- multiplicity-weighted contraction: **invariant at none of them**;
- and $P_1 = 144\cdot\operatorname{tr}(M^3)$ exactly, the same ratio at every sample, with imaginary part zero.

Since $\operatorname{Sym}^3(\mathcal W_5)$ contains the trivial representation once, $\operatorname{tr}(M^3)$ spans the invariant cubics, so this pins $P_1$ completely and not merely up to invariance.

**One negative result about the tests available.** [claim2_covariance.py](../scripts/reviewers/r190/claim2_covariance.py) checks all $41$ vectors against the torus characters: $P_u(g_{01}W)=\zeta^{-w_1}P_u(W)$ with $\zeta=(3+4i)/5$, and likewise for $g_{23}$ and $w_2$. All $41$ pass, **and so do all $41$ of the multiplicity-weighted versions.** The weighting is diagonal within each weight space, so torus covariance cannot see it. Anyone re-checking the convention should use the trivial-block invariance test, which discriminates, rather than a weight check, which does not.

**Consequence for claim 1: none.** The rank verdict stands on the convention actually used, which is the right one.

## Claim 1, the fence post

### The reduction to $\mathbb Q$

The stated form of the argument ("a rank can only drop on reduction"), is the right shape and gives the conclusion:

$$\operatorname{rank}_p(A)=89=\#\text{columns}\ \Rightarrow\ \operatorname{rank}_{\mathbb Q}(A)=89,\qquad \operatorname{rank}_{\mathbb Q}(A\,|\,b)\ \ge\ \operatorname{rank}_p(A\,|\,b)=90 .$$

**What the write-up leaves out is the hypothesis that makes the reduction legal at all**: the rows must be reductions of exact rational rows. They are, but only because every step upstream is rational, [random_weyl](../scripts/reviewers/r179/weyl_invariants.py) starts from an integer tensor and divides only by $n-2=3$ and $2(n-1)(n-2)=24$; the cache stores exact Gaussian rationals; and $i\mapsto 256$ is a ring homomorphism on $\mathbb Z[i]$ localised away from $p$. **The one place this could have broken is the choice to carry $(\mathrm{re},\mathrm{im})$ pairs through [gq2](../scripts/runs/run_n5_certificate.py) rather than collapsing to a single element of $\mathbb F_p$, collapsing first would make "take the real part" incompatible with reduction, and the certificate would prove nothing.** The script does it correctly; the record should say why it matters.

### The parametrisation

$89=\sum_\lambda m_\lambda^2$ over the block table, $16+16+9$ from the multiplicity $4,4,3$ blocks, $36$ from nine multiplicity-$2$ blocks, $12$ singletons, and $41$ highest-weight vectors. The off-diagonal entries $2\operatorname{Re}$ and $-2\operatorname{Im}$ are what $G_{ij}P_i\overline{P_j}+G_{ji}P_j\overline{P_i}=2\big(a\operatorname{Re}z-b\operatorname{Im}z\big)$ requires with $z=P_i\overline{P_j}$ and $G_{ij}=a+bi$. [claim1_parametrisation.py](../scripts/reviewers/r190/claim1_parametrisation.py) confirms row $\cdot$ $x$ against the honest double sum at three samples, and confirms the sum is real.

### The structural story

**Confirmed, and it is stronger than the record presents it.** [claim1_invariant_subspace.py](../scripts/reviewers/r190/claim1_invariant_subspace.py) imposes $f_G(gW)=f_G(W)$ over $160$ (sample, rotation) pairs on the $89$ unknowns: rank $88$, nullspace dimension **exactly $1$**, and the surviving direction is supported on the single coordinate $|P_1|^2$ of the trivial block. A mod-$p$ nullspace is an upper bound for the dimension over $\mathbb Q$, and $|P_1|^2$ supplies the matching lower bound, so this is exact.

**That turns the numerical result into a one-line argument, which the record should adopt in place of the rank measurement.** If $\sum_{ij}G_{ij}P_i\overline{P_j}=F_5$ pointwise then the left side is invariant, hence $G$ lies in the one-dimensional invariant subspace, hence $F_5=c\,|P_1|^2=144^2c\,\operatorname{tr}(M^3)^2$. But $F_5=\tfrac32 q^3-9\operatorname{tr}(M^3)^2$ and $q^3,\operatorname{tr}(M^3)^2$ are independent invariant sextics, so $c$ does not exist. No sampling, no prime.

### Where the record's scope is narrower than its sentence

The record's claim quantifies over **block-diagonal** $G$. Nothing in the pointwise demand forces block-diagonality, Schur's lemma applies to an *invariant* form, and the pointwise route is precisely the one that drops invariance as a hypothesis. [claim1_full_hermitian.py](../scripts/reviewers/r190/claim1_full_hermitian.py) closes the gap: full Hermitian $G$ on all $41$ covariants, $1681$ real unknowns, $1721$ sample points, at $p=1000003$.

```
mode full: 1681 real unknowns, 1721 sample points
  coefficient rank 1681 / 1681
  augmented   rank 1682
  CONSISTENT: False
```

**So the fence post holds against the full Hermitian cone, not only the block-diagonal one.** The full-rank $1681$ also says the map $G\mapsto f_G$ is injective on all of $\mathrm{Herm}(41)$, which is a fact worth keeping: it means a certificate, if one exists in the $P_i$, is unique.

### The "rank deficit of exactly 1"

There is nothing here to explain. Appending one column raises a rank by at most one, so **augmented $=$ coefficient $+\,1$ is the only outcome an inconsistent system can produce.** The phrasing in the record invites the reader to see agreement between a one-dimensional invariant subspace and a one-unit rank gap; the two numbers are unrelated, and the second could not have come out otherwise.

## Claim 3, $F_5$'s normalisation

**Two separable questions, and the record conflates them.**

**A global constant cannot affect the verdict.** The system is $Ax=b$ in the Gram unknowns; $Ax=cb$ is consistent iff $Ax=b$ is, for any $c\ne0$. So the factor of $64$ the record flags as a hazard is *inert for this test*, and so is any rescaling of the $u_i$ or of the weight basis, which rescales columns of $A$. The hazard is real for the SDP that would consume a Gram matrix; it is not real here.

**What could break the verdict is $q$ and $\operatorname{tr}$ in different conventions**, because that changes the polynomial rather than scaling it. In [run_n5_certificate.py](../scripts/runs/run_n5_certificate.py) both are pure contractions of the rank-$4$ tensor (`einsum('abcd,abcd->')` and the trace of the flat $25\times25$ reshape) so they match. [claim3_normalisation.py](../scripts/reviewers/r190/claim3_normalisation.py) builds the $n=5$ extremiser over $\mathbb Q$ from the $\Lambda^+$ frame of $\mathbb{CP}^2$, verifies all five Weyl conditions, and evaluates:

| convention pair | $\tfrac32q^3-9t^2$ |
| --- | --- |
| both tensor ($q=96$, $t=384$) | $0$ |
| both operator ($q=24$, $t=48$) | $0$ |
| $q$ tensor, $t$ operator | $1306368$ |
| $q$ operator, $t$ tensor | $-1306368$ |

**So the $3/2$ and the $9$ are convention-independent**, $q_{\text{tensor}}=4q_{\text{op}}$ and $t_{\text{tensor}}=8t_{\text{op}}$ scale $q^3$ and $t^2$ by the same $64$, which is exactly the $64$ the record identified, and it factors out of $F_5$ entirely. The mixed rows show the check could have failed. The record's quoted pair $(24,48)$ reproduces as the operator-convention values of the same tensor.

## Claim 4, the cheap basis

### The cap is not a free parameter, and one of the three data points is vacuous

**An exact identity fixes the scale.** [random_matching](../scripts/reviewers/r179/weyl_invariants.py) forbids pairing two slots of the same vertex, so all $12$ edges of the $6$-vertex multigraph are non-loops. A non-loop edge $\{u,v\}$ is cut by exactly $6$ of the $10$ balanced $3{+}3$ splittings, choose $u$'s two companions from the remaining four. Hence

$$\sum_{S}\mathrm{cross}(S)=6\times 12=72\quad\text{for every diagram,}$$

the mean cut is $7.2$, and cuts are even, so **$\max_S\mathrm{cross}(S)\ge 8$ always**. [claim4_cap_structure.py](../scripts/reviewers/r190/claim4_cap_structure.py) confirms the sum is $72$ at all $200000$ random matchings and finds the worst-count distribution $8:8.1\%$, $10:84.2\%$, $12:7.7\%$.

Two consequences for how the record reads:

- **$\text{cap}=8$ is the extreme value**, not a mild restriction, it forces every one of the ten cuts to sit at or below the mean-rounded-up.
- **$\text{cap}=12$ is no filter at all.** A cut can never exceed $12$, so "only $\le 12$ gives $14$" is the statement that the unrestricted family spans, which was already established. It belongs on [plan.md](../plan.md)'s table of checks that could not fail.

### The rank result, decided exhaustively

The worst cross-pair count depends only on the multigraph, never on which slot of $W$ an edge occupies. And the slot freedom is small: $W$ is antisymmetric in $(0,1)$, antisymmetric in $(2,3)$ and symmetric under swapping the pairs, a group of order $8$, so the $4!$ slot permutations at a vertex collapse to $3$ classes differing at worst by a sign, which cannot change a span. **So the entire cap-$C$ family is covered by (isomorphism classes with $\max$cut $\le C$) $\times\ 3^6$ slot assignments**, and the six $W$'s being the same tensor makes the isomorphism quotient safe.

[claim4_exhaustive.py](../scripts/reviewers/r190/claim4_exhaustive.py) enumerates all $4$-regular loopless multigraphs on $6$ labelled vertices ($3355$ of them, $24$ up to isomorphism, split $3/12/9$ by worst cut $8/10/12$) and evaluates every diagram:

| cap | isomorphism classes | diagrams evaluated | rank |
| --- | --- | --- | --- |
| $8$ | $3$ | $2187$ (all of them) | **$10$** |
| $10$ | $15$ | $10935$ (all of them) | **$13$** |
| $12$ |, | $9842$ before reaching the cap | $14$ |

[claim4_cost.py](../scripts/reviewers/r190/claim4_cost.py) checks the enumeration independently by orbit counting: $\sum_{\text{classes}}720/|\mathrm{Aut}|=3355$, matching the labelled count.

**So the obstruction is real, and the record's $10/13/14$ is not merely achievable but optimal.** Sampling found the right profile; this settles that no better one exists.

One caveat stated honestly: a mod-$p$ rank is a *lower* bound for the rank over $\mathbb Q$, so "only $10$" is the direction a single prime cannot certify. [claim4_structure.py](../scripts/reviewers/r190/claim4_structure.py) repeats the full cap-$8$ family at $p=10007,\,65537,\,999983$ with independent sample points and gets $10$ each time. A higher rank over $\mathbb Q$ would need all three primes to divide every $11\times11$ minor.

### What the three cheapest diagrams are, and what the cost really is

| cap-$8$ class | cut profile | edge multiplicities |
| --- | --- | --- |
| two disjoint doubled triangles | $[0,8,8,8,8,8,8,8,8,8]$ | $2^6$ |
| | $[4,4,8,8,8,8,8,8,8,8]$ | $2^2 1^8$ |
| simple $4$-regular | $[6,6,6,6,8,8,8,8,8,8]$ | $1^{12}$ |

The first is **disconnected** (two doubled triangles, each a $4$-regular loopless multigraph on three vertices) so every diagram in that class factors as a product of two cubic invariants, and the cubic invariants are one-dimensional. That class contributes only the line $\operatorname{tr}(M^3)^2$. This is why the cheap end is thin: the cheapest diagrams are the nearly-disconnected ones, and near-disconnection is exactly what makes a diagram carry little information.

**And the headline memory figure is softer than the max-cut metric suggests.** The pairing is assembled splitting by splitting, so a diagram's real cost is $\sum_S 5^{\mathrm{cross}(S)}$, not $5^{\max}$. Among the nine cut-$12$ classes the costs range over a factor of four, and **the cheapest has only one of its ten splittings at cut $12$**, profile $[6,6,6,6,6,6,8,8,8,12]$, total $245{,}406{,}250$ entries against $976{,}566{,}250$ for the worst, whose profile $[4,4,4,4,4,4,12,12,12,12]$ puts four splittings there. Choosing the $14$th basis element by total cost rather than by worst cut leaves a single $5^{12}$ contraction in the whole assembly, which can be streamed or handled by the slow polarised route while the other $139$ stay small.

## What I would change in the record

1. **State the rationality hypothesis** behind the mod-$p$ reduction in [run_n5_certificate.py](../scripts/runs/run_n5_certificate.py), and say that carrying $(\mathrm{re},\mathrm{im})$ separately is what preserves it.
2. **Replace the rank measurement for claim 1 with the invariant-subspace argument**, which is exact and needs no samples: the invariant Hermitian forms in the $P_i$ are one-dimensional, spanned by $|P_1|^2\propto\operatorname{tr}(M^3)^2$, and $F_5$ is not proportional to that.
3. **Record the full-Hermitian result**, the fence post holds without the block-diagonal restriction, $1681$ unknowns, coefficient rank full, augmented rank $1682$.
4. **Retire "the rank deficit of exactly $1$"** as if it were evidence; it is forced.
5. **Mark "cap $\le 12$ gives $14$" as a check that could not fail** and add the $\sum_S\mathrm{cross}(S)=72$ identity, which is what makes cap $8$ the extreme value.
6. **Promote the cheap-basis result from screened to exhaustive**, and switch the cost metric from worst cut to $\sum_S 5^{\mathrm{cross}(S)}$, which cuts the assembly's peak work to one $5^{12}$ contraction.
