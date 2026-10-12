# Reviewer 60, adversarial audit of the B0 identity/collapse chain (C1–C6)

Independent implementation throughout: [scripts/review_r60_core.py](../scripts/review_r60_core.py) builds $\mathfrak{so}(m)$, the $\mathrm{Weyl}_m$ constraint system and $\mathrm{ad}$ from the stated conventions alone, and [scripts/review_r60_q.py](../scripts/review_r60_q.py) builds Hamilton's $Q(W)=W^2+W^{\#}$. Nothing under review was read or imported.

**Independent calibration before any verdict.** $\dim\mathrm{Weyl}_m=10,35,84,168,300$ at $m=4,\dots,8$, matching $m(m+1)(m+2)(m-3)/12$. $Q$ reproduces the diagonal graph formula $\theta=\tfrac12(\sum_{ab}M_{ab}^3+\operatorname{tr}M^3)$ to $10^{-9}$ and returns $\theta_0(m)$ at the balanced sphere product to nine digits at $m=6,8,10,12$.

| Claim | Verdict |
| --- | --- |
| C1 identity | **CONFIRMED**; attribution **partly corrected** |
| C1 sub-claim "Ricci-flatness or Bianchi alone" | **Bianchi is load-bearing; Ricci-flatness is not** |
| C2 positivity | **CONFIRMED** (and near-trivial) |
| C3 centraliser collapse | **CONFIRMED**; the stated **proof has a gap**, and the true statement is **sharper** |
| C4 the theorem | **CONFIRMED**, attacked hard, unbroken; admits a **strengthening** |
| C5 the refutation on the record | **CONFIRMED**, the witnesses are genuine |
| C6 scope of the refutation | **PARTLY REFUTED**, the $\theta\le0$ clause is **false**; the $m\ge10$ clause and B0's conclusion stand |

---

## C1, the identity, and what it actually needs. CONFIRMED, attribution corrected

$\sum_\alpha\lambda_\alpha\mathrm{ad}(v_\alpha)^2=2W$ holds to $10^{-15}$ at $m=4,5,6,7,8$, in both the eigenbasis form and the $A(W)=\sum_{g,h}W_{gh}C_gC_h$ form, on random elements of the full $\mathrm{Weyl}_m$ ([scripts/review_r60_c1.py](../scripts/reviewers/r60/review_r60_c1.py)).

**The hypothesis test is the interesting part, and the brief's framing has it backwards.** Dropping each condition in turn and re-fitting:

| space | $\dim$ at $m=6$ | $\|A(W)-2W\|$ | residual after fitting the Ricci term |
| --- | --- | --- | --- |
| Bianchi only (algebraic curvature operators) | 105 | 1.4977 | $9\times10^{-16}$ |
| Ricci-flat only | 99 | 2.6298 | $1.0$ |
| symmetric only | 120 | 2.5979 | $0.82$ |

So for **every** algebraic curvature operator $R$, first Bianchi alone, no trace condition,

$$\sum_{g,h}R_{gh}\,\mathrm{ad}(\phi_g)\mathrm{ad}(\phi_h)\;=\;2R-\bigl(\mathrm{Ric}\cdot\omega+\omega\cdot\mathrm{Ric}\bigr),$$

exactly, with fitted coefficient $-1.0000$ and relative residual $3\times10^{-16}$ at $m=5$ and $9\times10^{-16}$ at $m=6$. **First Bianchi is the load-bearing hypothesis; Ricci-flatness only deletes the correction term.** Ricci-flatness *without* Bianchi fails outright (the Ricci term is zero there and the residual is the whole of $A(W)-2W$).

### Attribution

The identity is the classical Weitzenböck curvature term and is **not new**, that part of the sub-claim survives. Two corrections to the citation:

- **Petersen–Wink Proposition 1.6 is the right pointer but the wrong content.** I pulled the LaTeX source of [arXiv:1908.09958](https://arxiv.org/abs/1908.09958) and counted the shared theorem counter in §1: the sixth numbered environment is `ComputationBochnerTermWithEigenvalues`, so Proposition 1.6 is indeed the eigenbasis proposition. What it says is $\mathfrak R(\hat T)=\sum_\alpha\mathfrak R(\Xi_\alpha)\otimes\Xi_\alpha T$ and $g(\mathfrak R(\hat T),\hat T)=\sum_\alpha\lambda_\alpha|\Xi_\alpha T|^2$, for a *general* tensor $T$. That is the eigenbasis form of the Bochner term. **It does not contain the evaluation $=2W$.**
- **The evaluation is older and belongs to Lichnerowicz/Besse.** The Lichnerowicz Laplacian is $\Delta_Lh=\nabla^*\nabla h-2\mathring Rh+\mathrm{Ric}\circ h+h\circ\mathrm{Ric}$ ([Besse, *Einstein Manifolds*](https://link.springer.com/book/10.1007/978-3-540-74311-8), §1.143); restricted to skew $h$, i.e. to 2-forms, the curvature term is $q(R)\omega=\mathrm{Ric}\cdot\omega+\omega\cdot\mathrm{Ric}-2\mathring R\omega$, which is exactly the displayed identity above. **Sign note:** with this project's conventions the computation returns $A(R)=2R-L_{\mathrm{Ric}}=-q(R)$; the overall sign is a convention on $\mathring R$ and carries no content, but the write-up should not quote both formulas side by side without saying so.

**Recommended correction:** cite the identity as the Weitzenböck curvature term on 2-forms (Besse §1.143 / Lichnerowicz), with Petersen–Wink Prop 1.6 cited for the *eigenbasis* rewriting only, and state the hypothesis as *first Bianchi*, with Ricci-flatness deleting the $L_{\mathrm{Ric}}$ term.

---

## C2, positivity. CONFIRMED

$\mathrm{ad}(v)$ is exactly skew as an operator on $\mathfrak{so}(m)$ in the given orthonormal basis ($\|\mathrm{ad}(v)+\mathrm{ad}(v)^{\mathsf T}\|=0$ identically), so $-\mathrm{ad}(v)^2\succeq0$ and $2v\otimes v\succeq0$ separately: $N_v$ is a sum of two positive semidefinite pieces and its kernel is the intersection of theirs. This is a one-line argument and the write-up can say so. Numerically $\lambda_{\min}(N_v)\ge-10^{-14}$ and $\dim\ker N_v$ matches $\dim(v^\perp\cap\mathfrak z(v))$ at $m=4,\dots,8$ ([scripts/review_r60_c2.py](../scripts/reviewers/r60/review_r60_c2.py)).

$N_x=N_y+N_z$ verified to $3\times10^{-16}$ on an explicit rank-3 $\mathrm{Weyl}_4$ tensor. The inclusion $\ker N_x\subseteq\ker N_y\cap\ker N_z$ then follows because a PSD quadratic form vanishing on a sum of PSD forms kills each, **airtight**.

**One wording correction.** The claim states the split for signature $(1,2)$ with $x$ positive. The identity is about the **minority side** whichever sign it carries: for signature $(2,1)$ with negative eigenvector $x$ one gets the same $N_x=N_y+N_z$. The text should say "minority side", as C4's headline already does.

---

## C3, the centraliser collapse. CONFIRMED, but the stated proof has a gap

**The statement is right.** Every multiplicity partition of $p$ at $m=4,6,8,10,12$ enumerated, four random $\alpha$-draws each plus a random $O(m)$ conjugation ([scripts/review_r60_c3.py](../scripts/review_r60_c3.py)): all 29 patterns give $\dim(\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp)=1$, spanned by $x$ (projection $1.000000$), except $m=4$ pattern $(2)$ which gives $3$, exactly as claimed. Extended to $m=14,16$ on the hard patterns $(p)$, $(2,2,\dots)$, $(1^p)$, $(3,3,2)$, $(5,3)$: all $1$.

### The gap: the quoted case analysis computes the wrong object

The sketch says "the commutant of $\mathfrak{su}(k)$ acting on $\mathbb C^k$ inside $\mathfrak{so}(2k)$ is $\mathbb R\cdot J$ for $k\ge3$, is a 3-dimensional $\mathfrak{su}(2)$ for $k=2$". I confirmed that sub-fact directly ($\dim\mathfrak z(\mathfrak{su}(k))=3,1,1,1$ at $k=2,3,4,5$). **But assembling it block by block gives the wrong answer for $\mathfrak z(\mathfrak c)$**:

| $m$ | partition | $\dim\mathfrak c$ | $\dim\mathfrak z(\mathfrak c)$ actual | block-by-block prediction |
| --- | --- | --- | --- | --- |
| 8 | $(2,2)$ | 7 | **2** | 6 |
| 12 | $(2,2,2)$ | 11 | **3** | 9 |
| 10 | $(2,2,1)$ | 8 | **3** | 7 |
| 12 | $(3,2,1)$ | 13 | **3** | 5 |

Across all 26 patterns at $m=6,\dots,12$, $\dim\mathfrak z(\mathfrak c)$ equals the **number of blocks** $\ell$, never the block-by-block sum ([scripts/review_r60_c3b.py](../scripts/reviewers/r60/review_r60_c3b.py)). The mechanism the sketch omits: $\mathfrak c$ contains not only $\bigoplus_j\mathfrak{su}(m_j)$ but a codimension-1 slice of the centre $\mathrm{span}\{J_1,\dots,J_\ell\}$, and centralising that slice cuts each $k=2$ block's $\mathfrak{su}(2)^+$ down to $\mathbb R\cdot J_j$ whenever $\ell\ge2$. So $\mathfrak z(\mathfrak c)=\bigoplus_j\mathbb R\cdot J_j$, and intersecting with $\mathfrak c^\perp$ leaves exactly $\mathbb R\cdot x$.

**Two consequences for the write-up.** First, the $k=2$ clause as quoted is the thing that would *break* the lemma if the centre slice were not doing the work, it needs to be stated as being cancelled, not as a contribution. Second, the single-block case $\ell=1$ is where the exception lives: with no centre slice to spend, $\mathfrak z(\mathfrak{su}(2))=\mathfrak{su}(2)^+$ survives whole, and that is precisely the $m=4$, pattern $(2)$ answer of 3. The write-up should present $\ell=1$ and $\ell\ge2$ as the real case split, with the root argument (correct as stated: no root of $\mathfrak{so}(2p)$ has more than two nonzero coordinates, and $\alpha_1=-\alpha_2$ is impossible for positive $\alpha$) covering only $(1^p)$.

**The tight point of the whole lemma**, worth recording: for two *equal*-size blocks $(k,k)$ the antilinear intertwiner $\mathbb C^2\cong\overline{\mathbb C^2}$ would need the centre slice $\{\alpha_1t_1+\alpha_2t_2=0\}$ to equal $\{t_1=-t_2\}$, i.e. $\alpha_1=\alpha_2$. Positivity and distinctness of the $\alpha_j$ is exactly what rules it out. Checked at ratios $1+10^{-7},\,1.001,\,1.5,\,2,\,3,\,10^3$ for $(2,2)$, $(3,3)$, $(4,4)$: always 1.

### The true statement is sharper than C3

[scripts/review_r60_c3c.py](../scripts/reviewers/r60/review_r60_c3c.py): $\dim(\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp)=3$ **iff $x$ restricted to its support is a multiple of a complex structure on a 4-dimensional support**, and $=1$ in every other case, *including degenerate $x$*. Degenerate $x$ of support 2, 6, 8 gives 1; support-4 with equal $\alpha$'s gives 3 at $m=6,8,10,12$; support-4 with distinct $\alpha$'s gives 1. So **nondegeneracy at $m\ge6$ is sufficient, not necessary**: what the lemma really needs is that $x$ is not a complex-structure multiple on a 4-plane.

---

## C4, the theorem. CONFIRMED; I could not break it, and it can be strengthened

### The logical step is sound

$c:=\ker N_x=x^\perp\cap\mathfrak z(x)\subseteq\ker N_y$ says exactly $\langle w,y\rangle=0$ and $[y,w]=0$ for all $w\in c$, i.e. $y\in\mathfrak z(c)\cap c^\perp=\mathbb R\cdot x$; but $y\perp x$ as eigenvectors for distinct eigenvalues, so $y=0$. Same for $z$. **No gap.** The rank-3 hypothesis is never used beyond "exactly one eigenvalue on the minority side".

### What I threw at it, and failed

Exact semidefinite feasibility with the minority eigenvector fixed ([scripts/review_r60_c4.py](../scripts/reviewers/r60/review_r60_c4.py)): existence of $W\in\mathrm{Weyl}_m$ with $W\hat x=\pm\hat x$ and $\mp(\hat x\hat x^{\mathsf T}-W)\succeq0$ is exactly "one eigenvalue of that sign, eigenvector $\hat x$", and it is a linear-matrix-inequality feasibility problem. At $m=6$ and $m=8$, for **every** multiplicity pattern, for the complex structure on all of $\mathbb R^m$, and for eight random nondegenerate draws each, in **both** signs: `infeasible` in every case, 0/8 random hits.

**The control rules out a vacuous solver.** With $x$ the degenerate complex structure on a 4-plane the same SDP returns `optimal` with $\|W\|=\sqrt{3/2}$ and signatures $(1,2)$ and $(2,1)$, Ricci and Bianchi residuals $10^{-15}$, i.e. it finds the padded $\mathrm{Weyl}_4$ element, exactly the $m=4$ exception the theorem allows.

### Strengthening

Since C3's real hypothesis is "not a complex-structure multiple on a 4-dimensional support", the theorem is true in this sharper form:

> Let $W\in\mathrm{Weyl}_m$ have exactly one eigenvalue of one sign. If its eigenvector is not a multiple of a complex structure on a 4-dimensional subspace, then $W=0$.

This subsumes "nondegenerate at even $m\ge6$", covers odd $m$ and degenerate minority eigenvectors in one statement, and identifies the padded $\mathrm{Weyl}_4$ family as the *only* thing on the boundary. The final step is also cleaner than the write-up's: with one negative and any number of positives, every $y_i\in\mathbb R\cdot x$ and $y_i\perp x$, so $W=-x\otimes x$, and Ricci-flatness $\sum\lambda_\alpha v_\alpha v_\alpha^{\mathsf T}=-xx^{\mathsf T}=0$ forces $x=0$.

---

## C5, the refutation on the record. CONFIRMED; the witnesses are genuine

Rebuilt from scratch in [scripts/review_r60_c5.py](../scripts/review_r60_c5.py) with my own self-dual basis and my own $\mathrm{Weyl}$ screen. $W_4(q,r)$ is in $\mathrm{Weyl}_4$ for *all* $q,r$ for a reason worth recording: $w_iw_i^{\mathsf T}=\tfrac12I$ and $w_i\wedge w_i=\mathrm{vol}$ for every self-dual $w_i$, so both conditions collapse to $-(q+r)+q+r=0$.

| witness | Ricci | Bianchi | normalised spectrum | $n_{\mathrm{neg}}$ | $\dim U$ | $\theta$ |
| --- | --- | --- | --- | --- | --- | --- |
| $m=8$, orthogonal 4-planes | $0.0$ | $0.0$ | $\{-1/\sqrt3\ (\times2),\ 1/(2\sqrt3)\ (\times4)\}$ | 2 | **8** | $-\sqrt3/2=-0.866025404$ |
| $m=6$, 4-planes meeting in a 2-plane | $0.0$ | $0.0$ | $(-3,-1,1,1,1,1)/\sqrt{14}$ | 2 | **6** | $-1.030864790$ |

Every reported number reproduces exactly, and the residuals are $0.0$, not merely small, the construction is a sum of two exact rank-3 elements, so the eigenvalue count is a computation on a rank-6 matrix with no numerical question attached. **The statement recorded in [plan.md](../plan.md), "no element of $\mathrm{Weyl}_m$ with $\dim\mathfrak m_{\mathrm{neg}}\le2$ has $\dim U=m$, for even $m\ge6$", is false at $m=6$ and $m=8$.** The refutation stands.

---

## C6, scope. PARTLY REFUTED

### (a) "every witness of this kind has $\theta\le0$, because each summand does", **FALSE**

$\theta$ is a cubic form; $\langle W_1+W_2,Q(W_1+W_2)\rangle$ carries cross terms that the summand-wise argument never accounts for, and they are not sign-controlled once the two 4-planes are in **general position** rather than orthogonal or coordinate-aligned. Exact counterexamples, both sums of two padded $W_4$'s, both with $n_{\mathrm{neg}}=2$ and $\dim U=m$ ([scripts/review_r60_c6f.py](../scripts/reviewers/r60/review_r60_c6f.py), integer frames printed there):

| $m$ | $\theta$ | $n_{\mathrm{neg}}$ | $\dim U$ | Ricci | Bianchi |
| --- | --- | --- | --- | --- | --- |
| 6 | $\mathbf{+0.485408612}$ | 2 | 6 | $2.4\times10^{-16}$ | $1.7\times10^{-16}$ |
| 8 | $\mathbf{+0.115574271}$ | 2 | 8 | $8.2\times10^{-17}$ | $5.6\times10^{-17}$ |

Random general-position draws alone reach $+0.6259$ at $m=6$, $+0.2650$ at $m=7$, $+0.1165$ at $m=8$ ([scripts/review_r60_c6a.py](../scripts/review_r60_c6a.py), 4000 draws each). The clause is safe only for **orthogonal** planes, where the two $\Lambda^2$ summands are orthogonal and $P$ is additive; the recorded $m=8$ and $m=6$ witnesses happen to be of that special shape, which is presumably how the error survived.

### (b) "two 4-planes span at most 8 dimensions, so the construction produces nothing at $m\ge10$", **true as stated, but it does not say what it is being used for**

The span bound is correct and $\dim U\le8$ for this construction at every $m$. What it does **not** establish is that the stratum $\{\dim\mathfrak m_{\mathrm{neg}}\le2,\ \dim U=m\}$ is empty at $m\ge10$, that would need an argument about $\mathrm{Weyl}_m$, not about one family. My penalised search over all of $\mathrm{Weyl}_m$ ([scripts/review_r60_c6c.py](../scripts/review_r60_c6c.py), analytic gradients, 40 starts) drives $\sum_{i\ge3}\min(\lambda_i,0)^2$ to $2.0\times10^{-15}$ at $m=10$ and $7.4\times10^{-15}$ at $m=12$ with $n_{\mathrm{neg}}=2$ and $\dim U=m$ reported at both.

**Those are near-misses, not witnesses, and I checked.** Two independent tests:

- **Kernel locking** ([scripts/review_r60_c6e.py](../scripts/reviewers/r60/review_r60_c6e.py)). If the near-kernel $K$ of a converged $W$ were an exact kernel, $\{W'\in\mathrm{Weyl}_m:W'K=0\}$ (an exact linear subspace), would contain it. Projecting onto that subspace at $m=6,8,10$ returns elements with 7–22 negative eigenvalues, never 2. **No exact full-support $n_{\mathrm{neg}}=2$ element was recovered this way at any $m$.**
- **Hard polish against an exact control** ([scripts/review_r60_c6f.py](../scripts/reviewers/r60/review_r60_c6f.py)). Driving the penalty to machine floor and reading the worst eigenvalue beyond the top two:

| point | penalty residual | worst eigenvalue beyond the top two |
| --- | --- | --- |
| $m=8$ best full-support candidate | $5.4\times10^{-20}$ | $-1.01\times10^{-10}$ |
| $m=10$ best full-support candidate | $8.5\times10^{-20}$ | $-1.06\times10^{-10}$ |
| $m=8$ exact padded witness (control) |, | $-2.8\times10^{-17}$ |
| $m=6$ exact padded witness (control) |, | $-1.3\times10^{-16}$ |

Six orders of magnitude separate the candidates from the genuine article, and the candidates' floors do not move as the residual falls by another eleven orders. Both limits also have only six eigenvalues away from zero, i.e. they are collapsing back onto rank 6.

So my result **agrees with the record's** "$520$ starts to a floor of $2.5\times10^{-5}$ and residual floors decaying like $\delta^2$ with no separate branch", I reach a far lower floor with better-conditioned gradients and it is still a floor. Separately, the exact SDP certification ([scripts/review_r60_c6d.py](../scripts/reviewers/r60/review_r60_c6d.py)) maximising $\lambda_{\min}$ of $W$ on $\{y,z\}^\perp$ returns $t=-5\times10^{-10}$ and $-6\times10^{-10}$ at $m=6$ and $m=8$: **the maximum margin is zero, never positive.** The stratum is a boundary set of measure zero, which is why random draws never hit it, and why "no random hit" is correctly flagged in the brief as non-evidence.

### (c) "B0's CONCLUSION ($\sup\theta\le\sqrt{3/2}$ on the stratum) is untouched", **supported, and sharply**

Maximising $\theta$ over $\mathrm{Weyl}_m$ under a continuation penalty enforcing $n_{\mathrm{neg}}\le2$, 25 starts at each of $m=6,8,10,12$, returns

$$\sup\theta=+1.224744871=\sqrt{3/2}\quad\text{at every }m\text{ tested,}$$

attained at $\dim U=4$, $\operatorname{rank}v_N=4$, the padded $\mathrm{Weyl}_4$ element, and nothing above it. Note this is a real constraint and not a vacuous one: $\theta_0(12)=1.236033>\sqrt{3/2}$, so the bound has to be earned at $m=12$, and it holds. **B0's conclusion survives; only the descent route and the $\theta\le0$ rationale are hit.**

---

## Summary of what I attacked and failed to break

- **C1's identity**, random $\mathrm{Weyl}_m$ at five dimensions, both formulations. Unbroken. Broke the *hypothesis attribution* instead: Bianchi alone suffices.
- **C4**, exact SDP feasibility at $m=6,8$, all multiplicity patterns, both signs, plus random nondegenerate draws, with a positive control proving the formulation non-vacuous. Unbroken, and the underlying logic checks line by line.
- **C3's statement**, 29 partitions at $m\le12$ plus five hard patterns at $m=14,16$, adversarial $\alpha$-ratios on equal-size blocks, degenerate $x$ at every support dimension. Unbroken. Broke the *proof sketch* instead.
- **C6(b,c)**, kernel locking, hard polish to $5\times10^{-20}$, and exact SDP margin maximisation at $m=6,8,10,12$. Unbroken.

## What broke

- **C6(a)**, with exact witnesses at $m=6$ ($\theta=+0.485$) and $m=8$ ($\theta=+0.116$).
- **C1's stated hypothesis**, Ricci-flatness is not what the identity needs.
- **C3's proof sketch**, the $k=2$ clause describes a contribution that the centre slice cancels; the real case split is $\ell=1$ versus $\ell\ge2$.


---

## Synthesis carried in REVIEW.md

### Reviewer 60: the Weitzenböck identity, the centraliser collapse, the rank-3 theorem and the full-support witnesses

Full report in [reviews/REVIEW_r60.md](reviews/REVIEW_r60.md). Independent implementation throughout, calibrated first against $\dim\mathrm{Weyl}_m$ and $\theta_0(n)$ at the balanced sphere products to nine digits.

**Confirmed**: the identity $\sum_\alpha\lambda_\alpha\mathrm{ad}(v_\alpha)^2=2W$ at $m=4\ldots8$; $N_v\succeq0$ with $\ker N_v=v^\perp\cap\mathfrak z(v)$; the collapse at all 29 multiplicity partitions to $m=12$ and five hard patterns at $m=14,16$; the rank-3 theorem, attacked by exact semidefinite feasibility with the minority eigenvector fixed, infeasible at every pattern and both signs at $m=6,8$, with a **feasible degenerate control** returning the padded $\mathrm{Weyl}_4$ element at $\|W\|=\sqrt{3/2}$; and both full-support witnesses, residuals exactly $0.0$.

**Broke three things.** *The stated hypothesis of the identity*: first Bianchi alone gives $\mathcal A(R)=2R-(\mathrm{Ric}\cdot\omega+\omega\cdot\mathrm{Ric})$ exactly, so Ricci-flatness only deletes the correction term. *The citation*: from the arXiv LaTeX source, Petersen–Wink Prop 1.6 is the eigenbasis Bochner proposition and does not contain the evaluation $=2W$, which is Lichnerowicz/Besse §1.143. *The claim that every witness has $\theta\le0$*: exact counterexamples at $\theta=+0.485408612$ ($m=6$) and $+0.115574271$ ($m=8$), from 4-planes in general position, both with two negative eigenvalues and $\dim U=m$; the clause holds only for orthogonal planes, where $P$ is additive.

**Two corrections folded in.** The collapse's real criterion is that $x$ be a complex-structure multiple on a $4$-dimensional support, degenerate $x$ included, so nondegeneracy is sufficient, not necessary; and the theorem strengthens to *if $W\in\mathrm{Weyl}_m$ has exactly one eigenvalue of one sign and that eigenvector is not a complex-structure multiple on a $4$-plane, then $W=0$*, covering odd $m$ and degenerate eigenvectors in one statement.

**On $m\ge10$**: penalised search reported full-support two-negative candidates at $m=10,12$ and the reviewer **withdrew them itself**, at penalty residual $8.5\times10^{-20}$ the worst extra eigenvalue still sits at $-1.06\times10^{-10}$ against $-1.3\times10^{-16}$ for the exact padded control, and kernel-locking recovers no exact element. $\sup\theta$ on the stratum comes out at exactly $\sqrt{3/2}$ at $m=6,8,10,12$, non-vacuously since $\theta_0(12)$ exceeds it.
