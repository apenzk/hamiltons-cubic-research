# Reviewer 61, adversarial audit of the B0 argument (C1–C6)

Everything below was computed from a from-scratch implementation in [scripts/review_r61_core.py](../scripts/review_r61_core.py) and its companions. No file matching `scripts/b0_*.py` was read, imported or run. [findings/INDEX.md](../findings/INDEX.md) and [plan.md](../plan.md) were read for context only, and the only literature file opened was [references/petersen-wink-2019-bochner-technique/notes.md](../references/petersen-wink-2019-bochner-technique/notes.md), after the identity had already been verified and re-derived independently.

**Gatekeepers passed before any claim was tested.** $\dim\mathrm{Weyl}_m$ reproduces $m(m+1)(m+2)(m-3)/12$ at $m=4\ldots8$; $\theta$ at the balanced sphere products reproduces $\theta_0(n)=\frac{n-1}{n}\sqrt{2(n-2)/(n-1)}$ to nine digits at $n=6,8,10,12$; $Q$ maps $\mathrm{Weyl}_6$ into itself at $3\times10^{-16}$; the Fubini–Study operator is Bianchi-exact and its Weyl part is Ricci-flat at $10^{-16}$.

## Verdicts

| claim | verdict | how it was attacked |
| --- | --- | --- |
| **C1** identity + attribution | **CONFIRMED**, with a sharper general form | full spectral decomposition of the map $\mathcal A$ on $\mathrm{Sym}^2(\Lambda^2)$; hypotheses dropped one at a time |
| **C2** positivity and kernel of $N_v$ | **CONFIRMED** (and elementary, one line) | direct Rayleigh quotient; kernel compared as projectors |
| **C3** centraliser collapse | **CONFIRMED**; the recorded *proof* is more elaborate than needed and has one unstated step | every multiplicity partition of $p$ at $m=4,6,8,10,12$, plus adversarial singular-value relations |
| **C4** the theorem | **CONFIRMED**; the logical step is valid | independent convex (SDP) certificate of infeasibility at $m=6,8,10,12$ over every multiplicity pattern, with a feasible degenerate control |
| **C5** the refutation on the record | **CONFIRMED**, the recorded B0 statement is FALSE at $m=6$ and $m=8$ | both witnesses rebuilt from scratch and fully screened |
| **C6** scope of the refutation | **SPLIT: clause 1 REFUTED, clause 2 CONFIRMED and strengthened, clause 3 overstated** | explicit $\theta>0$ witnesses; structured SDP screen; a one-parameter exact deformation |

---

## C1, the identity, and the attribution: CONFIRMED

**The identity holds.** $\sum_\alpha\lambda_\alpha\mathrm{ad}(v_\alpha)^2=2W$ on $\mathrm{Weyl}_m$ at $\le7\times10^{-15}$ for $m=4,5,6,7,8$, and $\|\mathcal A(W)\|=2$ exactly at $\|W\|=1$. The eigenbasis form and the structure-constant form $\sum_{g,h}W_{gh}C_gC_h$ agree at $4\times10^{-15}$ ([review_r61_c1.py](../scripts/review_r61_c1.py)).

**A stronger statement is available, and it settles the "what without either hypothesis" question exactly.** $\mathcal A$ is *linear* in $W$ and $SO(m)$-equivariant, so by Schur it is a scalar on each irreducible summand of $\mathrm{Sym}^2(\Lambda^2\mathbb R^m)$. Computing its full matrix ([review_r61_c1_spectrum.py](../scripts/reviewers/r61/review_r61_c1_spectrum.py)) gives exactly four eigenvalues, with multiplicities matching the four summands to the digit:

| summand | $\dim$ | $\mathcal A$ eigenvalue |
| --- | --- | --- |
| $\mathrm{Weyl}_m$ | $m(m+1)(m+2)(m-3)/12$ | $+2$ |
| $S^2_0(\mathbb R^m)$ (traceless Ricci) | $m(m+1)/2-1$ | $-(m-4)$ |
| $\mathbb R\cdot\mathrm{Id}$ (scalar) | $1$ | $-2(m-2)$ |
| $\Lambda^4\mathbb R^m$ (Bianchi defect) | $\binom m4$ | $-4$ |

Verified at $m=4,5,6,7$ from the spectrum and independently at $m=5,6,7,8$ on explicitly constructed summands (Kulkarni–Nomizu operators, $\mathrm{Id}$, random $4$-forms), residuals $\le3\times10^{-15}$.

**Which hypothesis does what.**

- **Bianchi alone** already gives the classical Weitzenböck form: $\mathcal A(R)=2R-(\mathrm{Ric}\cdot\omega+\omega\cdot\mathrm{Ric})$, exact at $6\times10^{-16}$ for random Bianchi-satisfying, *Ricci-free* $R$ at $m=5,6,7$. It fails at $O(1)$ on a generic symmetric operator.
- **Ricci-flatness alone does NOT suffice**, and the reason is explicit: $\Lambda^4$ *is* Ricci-flat and carries eigenvalue $-4$, not $+2$. On a Ricci-flat operator, $\mathcal A(W)=2W_{\mathrm{Weyl}}-4W_{\Lambda^4}$; measured $\|\mathcal A-2W\|\approx1.6$–$2.4$ at $\|W\|=1$.

So both hypotheses are load-bearing, with Bianchi doing the structural work and Ricci-flatness only clearing the two $\mathrm{Ric}$ terms.

**Attribution: the sub-claim is correct.** The sign convention is fixed by the $1$-form check, $\sum_{g,h}W_{gh}\varphi_g\varphi_h=-\mathrm{Ric}(W)$ *exactly* (residual $0.0$, any symmetric $W$, $m=5,6$), so the project's $\mathcal A$ is $-q(R)$ in the convention where $q(R)=\mathrm{Ric}$ on $1$-forms, and the identity is the classical 2-form Weitzenböck term $q(R)\omega=\mathrm{Ric}\circ\omega+\omega\circ\mathrm{Ric}-2\mathring R\omega$ specialised to Ricci-flat. Two refinements to the record:

1. What [Petersen–Wink Prop. 1.6](https://arxiv.org/abs/1908.09958) supplies is the *eigenbasis* form of the curvature term of a Lichnerowicz Laplacian, $g(\mathcal R(\hat T),\hat T)=\sum_\alpha\lambda_\alpha|\Xi_\alpha T|^2$. The specific 2-form formula with the $\mathrm{Ric}$ terms and the $\mathring R$ term is separately classical (Bochner–Weitzenböck), not Prop. 1.6 itself. Citing Prop. 1.6 for "the identity in eigenbasis form" is right; citing it for the $\mathrm{Ric}\circ\omega+\omega\circ\mathrm{Ric}-2\mathring R\omega$ formula would not be.
2. The record's derivation ("Ricci-flat kills the $\mathrm{Ric}$ terms, first Bianchi gives $\mathring R=R$ on skew $\omega$") is correct as written and matches the measurement.

*Not new, and correctly flagged as not new.* What is new, and what I could not find in the literature, is C2's splitting into per-eigenvector positive-semidefinite pieces.

## C2, positivity: CONFIRMED (and trivial)

$\langle u,N_vu\rangle=2\langle v,u\rangle^2+\|[v,u]\|^2$, since $\mathrm{ad}(v)$ is skew for $\langle X,Y\rangle=\tfrac12\mathrm{tr}(X^\mathsf TY)$. Positivity and $\ker N_v=v^\perp\cap\mathfrak z(v)$ are immediate from that one line; numerically $\lambda_{\min}(N_v)\ge-3.4\times10^{-16}$ and the kernel projector matches $v^\perp\cap\mathfrak z(v)$'s at $\le4\times10^{-14}$ for $m=4,6,8$ ([review_r61_c2_c3.py](../scripts/review_r61_c2_c3.py)).

The rescaling step is also right: with $x=\sqrt{\lambda_1}\hat x$ etc., $\mathcal A(W)=2W$ becomes exactly $N_x=N_y+N_z$, and $A=B+C$ with all three PSD gives $\ker A\subseteq\ker B\cap\ker C$. No gap.

## C3, centraliser collapse: CONFIRMED, but the recorded proof is the long way round

**The statement is true.** $\dim(\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp)=1$, spanned by $x$, at **every** multiplicity partition of $p=m/2$ for $m=6,8,10,12$ (26 partitions in total), with the $x$-containment residual $\le6\times10^{-15}$; at $m=4$ it is $3$ exactly when $x$ is a multiple of a complex structure and $1$ otherwise. Adversarial singular-value patterns, $\alpha_1=\alpha_2+\alpha_3$, geometric ratios, spreads of $10^{12}$, near-collisions at $10^{-9}$, change nothing ([review_r61_c3_adversarial.py](../scripts/reviewers/r61/review_r61_c3_adversarial.py)).

**The case analysis is unnecessary, and I could not find a pattern it misses, because the whole thing collapses to one root-system line.** Put $\mathfrak t=$ the Cartan spanned by the $p$ coordinate $2$-planes of $x$, and $a=(a_1,\dots,a_p)$ its singular values, all $>0$ by nondegeneracy. Then $\mathfrak t\subseteq\mathfrak z(x)$, so $\mathfrak c\supseteq\mathfrak t\cap x^\perp=a^\perp$, a hyperplane of $\mathfrak t$, and hence
$$\mathfrak z(\mathfrak c)\ \subseteq\ \mathfrak z(\mathfrak t\cap x^\perp)\ =\ \mathfrak t\oplus\bigoplus\{\mathfrak g_\beta:\beta\propto a\}.$$
Every root of $D_p$ is $\pm e_i\pm e_j$ and so has $p-2$ zero coordinates; $a$ has none. For $p\ge3$ that forces $\mathfrak z(\mathfrak c)\subseteq\mathfrak t$, and then $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp\subseteq\mathfrak t\cap(a^\perp)^\perp=\mathbb R x$. For $p=2$ the roots have *no* zero coordinate, $a\propto(1,1)$ is admissible, and that is exactly $x\propto$ a complex structure, the $m=4$ exception, where the extra piece is the $\mathfrak{su}(2)^+$ the claim names.

This derivation needs **no** multiplicity case split, no $\mathfrak u(m_j)$ decomposition, and none of the $\mathfrak{su}(k)$-commutant facts. It is also uniform in $\alpha$, which is why the adversarial sweep found nothing.

**Two things to fix in the recorded proof, neither fatal.**

- *An unstated step.* "The commutant of $\mathfrak{su}(k)$ acting on $\mathbb C^k$ inside $\mathfrak{so}(2k)$" is a statement about one block. $\mathfrak z(\mathfrak c)$ is a centraliser inside $\mathfrak{so}(m)$, so the argument also needs the off-diagonal blocks to die, which follows from $\mathrm{Hom}_{\mathfrak{su}(m_j)}(\text{trivial},\mathbb C^{m_j})=0$ but is not said.
- *A branch stated as if dangerous that never survives.* The $k=2$ case is flagged as giving a $3$-dimensional $\mathfrak{su}(2)$. At $m\ge6$ it never contributes: the codimension-1 slice of the centre contains an element with distinct eigenvalues on the two blocks, whose centraliser inside each $\mathfrak{su}(2)^+$ is one-dimensional. Measured at $m=8$, pattern $(2,2)$: $\dim\mathfrak z(\mathfrak c)=2$, not $6$.

**The exact mechanism, which is worth recording.** $\dim(\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp)>1$ **iff** the singular-value vector is proportional to a root of $D_p$, i.e. iff $x$ has exactly two nonzero singular values and they are equal, i.e. iff $x$ is a multiple of a **rank-4 complex structure**. At $p=2$ that is compatible with nondegeneracy; at $p\ge3$ it forces a zero singular value. The degenerate case is not vacuous: a rank-4 $J$ padded into $\mathbb R^6,\mathbb R^8,\mathbb R^{10}$ returns $\dim=3$ every time, and that is exactly the configuration the C4 semidefinite test finds *feasible* (below). The two computations agree on where the escape is.

## C4, the theorem: CONFIRMED, and the logical step is sound

**The deduction is valid.** $N_x=N_y+N_z$ with all three PSD gives $\mathfrak c:=\ker N_x=x^\perp\cap\mathfrak z(x)\subseteq\ker N_y=y^\perp\cap\mathfrak z(y)$, i.e. simultaneously $y\perp\mathfrak c$ and $y\in\mathfrak z(\mathfrak c)$, so $y\in\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp=\mathbb Rx$ by C3, contradicting $y\perp x$, $y\ne0$. Same for $z$. Nothing is missing.

**Independent certificate, by a different method.** The question "is there $W\in\mathrm{Weyl}_m$ whose only eigenvalue of one sign sits on a prescribed $x$?" is an exact *convex* feasibility problem: $\exists W\in\mathrm{Weyl}_m$ with $G=W+\hat x\hat x^{\mathsf T}\succeq0$ and $G\hat x=0$. I maximised the margin $t$ in $G\succeq t\Pi$ ([review_r61_c4_sdp_sweep.py](../scripts/review_r61_c4_sdp_sweep.py)):

- **Infeasible at every multiplicity pattern**, $m=6,8,10,12$ (26 patterns): margins $-0.050$ to $-0.069$.
- **The degenerate control is feasible**: a rank-4 $J$ padded into $\mathbb R^6,\mathbb R^8,\mathbb R^{10}$ gives $t=+2\times10^{-11}$, $+2\times10^{-10}$, $+3\times10^{-10}$. So the program is not trivially infeasible, and nondegeneracy is exactly the hypothesis doing the work.
- **The infeasibility does not depend on the singular values, only on nondegeneracy.** Four $\alpha$-draws per pattern (consecutive integers, powers of two, near-collisions at $10^{-6}$, and random), give margins $-0.013$ to $-0.140$ at $m=6,8$, never near zero ([review_r61_c4_alpha.py](../scripts/reviewers/r61/review_r61_c4_alpha.py)). This is what C3's root argument predicts.
- **The $m=4$ dichotomy is reproduced exactly**: $x$ a complex structure gives $t=-4\times10^{-8}$, i.e. zero to solver accuracy (feasible); $x=\mathrm{diag}(1,2)$-type gives $t=-1.000$ (infeasible).
- **The $m=4$ exception is realised by a named tensor**: the Weyl part of the Fubini–Study operator at $m=4$ has spectrum $\{-0.408248\times2,\ +0.816497\}$ (rank 3, signature $(1,2)$, positive eigenvector the Kähler form, rank 4 = full) and $\theta=+1.224745=\sqrt{3/2}$ ([review_r61_c6_cpk.py](../scripts/reviewers/r61/review_r61_c6_cpk.py)).

The SDP is *stronger* than C4 as stated: it allows any number of eigenvalues of the other sign and any rank, and is still infeasible. That confirms C4's "the same argument also excludes exactly ONE negative eigenvalue with any number of positives", independently of the argument.

**One redundancy in the phrasing.** $\mathrm{Weyl}_m$ is a linear space, so $W\mapsto-W$ maps signature $(1,2)$ with nondegenerate positive eigenvector onto signature $(2,1)$ with nondegenerate negative eigenvector. The two halves of C4's "concretely" sentence are the same statement. The SDP returns bit-identical margins for the two, as it must.

**A consequence of C1 that the record does not have, and that the remaining B0 question can use.** Contracting $2W=\sum_\alpha\lambda_\alpha\mathrm{ad}(v_\alpha)^2$ with a unit $u$ gives $\sum_\alpha\lambda_\alpha\|[v_\alpha,u]\|^2=-2\langle u,Wu\rangle$. At $u=v_N$, the most negative eigenvector, the negative terms drop out and
$$\|\mathrm{ad}_{v_N}\|_{\mathrm{op}}^2\ \ge\ \frac{2|\lambda_N|}{T_+},\qquad T_+=\textstyle\sum_{\lambda>0}\lambda .$$
With exactly two negative eigenvalues $T_+=b+c\le2|\lambda_N|$, so $\|\mathrm{ad}_{v_N}\|_{\mathrm{op}}\ge1$; and $\|\mathrm{ad}_X\|_{\mathrm{op}}=s_1+s_2$ for unit skew $X$ (verified to $10^{-8}$ at $m=6,8,10$), which is $\le\sqrt2$ with equality only at rank 4 with $s_1=s_2$. So **the most negative eigenvector of a two-negative Weyl tensor has $s_1+s_2\ge1$: at least half of its norm sits inside a single 4-plane.** The $m=6$ C5 witness attains this with equality, $\|\mathrm{ad}_y\|_{\mathrm{op}}=s_1+s_2=1.224745=\sqrt{2|\lambda_N|/T_+}$ to six digits ([review_r61_adnorm.py](../scripts/reviewers/r61/review_r61_adnorm.py)).

## C5, the recorded B0 statement is FALSE at $m=6$ and $m=8$: CONFIRMED

Both witnesses rebuilt from the self-dual forms with no reference to the project's code ([review_r61_c5.py](../scripts/review_r61_c5.py)). Every reported figure reproduces:

| witness | Ricci | Bianchi | $\mathrm{dist}(\mathrm{Weyl})$ | $\#\text{neg}$ | spectrum | $\theta$ | $\dim U$ |
| --- | --- | --- | --- | --- | --- | --- | --- |
| $m=8$, orthogonal 4-planes | $0$ | $0$ | $6\times10^{-16}$ | $2$ | $\{-0.57735^{\times2},\,0.288675^{\times4}\}$ | $-0.866025$ | $8$ |
| $m=6$, 4-planes overlapping in a 2-plane | $0$ | $0$ | $4\times10^{-16}$ | $2$ | $(-3,-1,1,1,1,1)/\sqrt{14}$ | $-1.030865$ | $6$ |

Weyl membership is automatic and needs no check beyond the arithmetic: Ricci-flatness and Bianchi are linear, so a sum of padded $\mathrm{Weyl}_4$ elements is a $\mathrm{Weyl}_m$ element whatever the planes do. **The statement "no element of $\mathrm{Weyl}_m$ with $\dim\mathfrak m\le2$ has $\dim U=m$, for even $m\ge6$" is false at $m=6$ and at $m=8.**

Two independent cross-checks of the sign bookkeeping, since it is easy to conflate two tensors that differ by a sign. $W_4(q,r)=-(q+r)w_1\otimes w_1+qw_2\otimes w_2+rw_3\otimes w_3$ as written in C5 has signature $(2,1)$ (one negative eigenvalue) and $\theta=-\sqrt{3/2}$ at $q=r$; the B0 base-case family, which is the one with $\dim\mathfrak m\le2$ *negative* directions and $\theta=9qr(q+r)/\|W\|^3=+\sqrt{3/2}$, is its negative. Both appear in the record and they are not the same tensor. My machinery reproduces the base-case value $\sqrt{3/2}=1.224745$ independently, and it also reproduces it as the Weyl part of Fubini–Study at $m=4$.

## C6, scope: clause 1 REFUTED, clause 2 CONFIRMED and strengthened, clause 3 overstated

### Clause 1, "every witness of this kind has $\theta\le0$, because each summand does", REFUTED

$P$ is **cubic**, so it is additive over summands only when the cross terms vanish, which needs the two supports to be genuinely disjoint. For orthogonal 4-planes the cross term is exactly zero and the claim holds ($\theta_{\mathrm{sum}}=\theta_A/\sqrt2$). For **overlapping** 4-planes it does not. Three explicit $m=6$ witnesses ([review_r61_c6_theta_positive.py](../scripts/reviewers/r61/review_r61_c6_theta_positive.py)), each with exactly two negative eigenvalues, $\dim U=6$, Ricci and Bianchi at $10^{-17}$, and $\mathrm{dist}(\mathrm{Weyl})\le6\times10^{-16}$:

| witness | $\theta(A)$ | $\theta(B)$ | $\theta(A+B)$ | $P(A)+P(B)$ | cross term |
| --- | --- | --- | --- | --- | --- |
| 1 | $-0.110200$ | $-0.004707$ | $\mathbf{+0.138402}$ | $-0.003610$ | $+0.020143$ |
| 2 | $-0.056001$ | $-0.482091$ | $\mathbf{+0.120981}$ | (|), |
| 3 | $-0.225481$ | $-0.124776$ | $\mathbf{+0.096468}$ | (|), |

Both summands negative, the sum positive. The stated *reason* fails, and so does the stated conclusion for this construction.

### Clause 2, "two 4-planes span at most 8 dimensions, so nothing at $m\ge10$", CONFIRMED, and now it has a mechanism

The clause as written is true by inspection of the construction. What I found is that it is not an artefact of the construction: **the rank-4 requirement appears to be forced.** With the two negative directions $y,z$ fixed and orthonormal, existence is an exact SDP, so each configuration gets a definitive answer. Screening structured $(y,z)$ by $(\mathrm{rank}\,y,\mathrm{rank}\,z)$ and singular-value pattern over random relative positions ([review_r61_c6_screen.py](../scripts/reviewers/r61/review_r61_c6_screen.py)):

- at $m=6$, the *only* class reaching margin $\approx0$ is $(4,4)$ with **equal** singular values, $-4.6\times10^{-5}$, against $-3\times10^{-3}$ to $-1.1\times10^{-1}$ for all fifteen other classes;
- at $m=8$, likewise: $(4,4)$ equal gives $-6.7\times10^{-5}$, everything else $-1.7\times10^{-3}$ to $-9.3\times10^{-2}$;
- at $m=10$ the sweep is **exhaustive over rank classes**, all 19 admissible $(\mathrm{rank}\,y,\mathrm{rank}\,z)$ pairs in both singular-value variants, 38 rows, and $(4,4)$ is not admissible since $4+4<10$. **Every one of the 38 is infeasible.** The best is $(4,6)$ equal at $-1.4\times10^{-3}$, then $(6,4)$ equal at $-1.9\times10^{-3}$ and $(4,8)$ equal at $-2.1\times10^{-3}$; the deficit grows steadily as either rank leaves 4, reaching $-3.9\times10^{-2}$ at $(6,6)$ and $-6.6\times10^{-2}$ at $(2,10)$. Even the best $m=10$ row is $30\times$ further from feasibility than the $(4,4)$ rows that *are* feasible at $m=6$ and $m=8$;
- at $m=12$, 18 classes had completed when this report was written and **all are infeasible**, with the same shape: the best is $(4,8)$ equal at $-2.0\times10^{-3}$, followed by $(4,10)$ equal at $-2.6\times10^{-3}$ and $(4,12)$ equal at $-2.8\times10^{-3}$, against $-3.2$ to $-4.2\times10^{-2}$ once $\mathrm{rank}\,y$ leaves 4. The remaining $m=12$ classes were still running; the live log is [agent_logs/r61_c6_screen.out](agent_logs/r61_c6_screen.out).

Equal singular values at rank 4 means $y$ and $z$ are rank-4 complex structures, whose images are 4-planes, so $\dim U\le8$ and $m\ge10$ is closed for this family. The one-parameter deformation makes the same point exactly ([review_r61_c6_epsilon.py](../scripts/reviewers/r61/review_r61_c6_epsilon.py)): with $y$ a rank-4 complex structure and $z$ deformed to singular values $(1,1,\varepsilon)$,

| $\varepsilon$ | $0$ | $10^{-6}$ | $10^{-4}$ | $10^{-2}$ | $0.1$ | $0.3$ | $1$ |
| --- | --- | --- | --- | --- | --- | --- | --- |
| margin, $m=8$ | $-1.5\!\times\!10^{-9}$ | $-5.4\!\times\!10^{-8}$ | $-9.2\!\times\!10^{-7}$ | $-9.1\!\times\!10^{-5}$ | $-8.6\!\times\!10^{-4}$ | $-2.1\!\times\!10^{-3}$ | $-2.7\!\times\!10^{-3}$ |
| margin, $m=10$ | $-7.2\!\times\!10^{-10}$ | $-4.2\!\times\!10^{-8}$ | $-5.6\!\times\!10^{-7}$ | $-5.5\!\times\!10^{-5}$ | $-5.2\!\times\!10^{-4}$ | $-1.3\!\times\!10^{-3}$ | $-1.8\!\times\!10^{-3}$ |

$\varepsilon=0$ is feasible and has $\dim U=8$; every $\varepsilon>0$ has $\dim U=m$ and is strictly infeasible, with the margin going to zero only in the unattained limit. This is Reviewer 59's "$\delta^2$ floor with no separate branch", now with an exact convex certificate at each point rather than a residual floor, and it also explains it: the deficit vanishes precisely where the support degenerates.

**This is still not a proof.** The rank classes at $m=10$ are exhausted, but relative positions inside each class are sampled at random, and the deformation is one path. What would close it is the statement *"in a two-negative $\mathrm{Weyl}_m$ tensor both negative eigenvectors are rank-4 complex structures"*, which my $\|\mathrm{ad}_{v_N}\|_{\mathrm{op}}\ge1$ corollary points at but does not reach ($\ge1$, not $=\sqrt2$).

### Clause 3, "B0's conclusion is untouched", true as a statement, overstated as written

I could not break the conclusion. Frank–Wolfe ascent inside the exact convex description of the two-negative stratum ([review_r61_c6_ascent2.py](../scripts/reviewers/r61/review_r61_c6_ascent2.py)) tops out at $\theta=+1.187171$ at $m=6$ and $+0.032$ at $m=8$, and at $m=6$ the maximiser's support **collapses toward 4 dimensions** as $\theta$ climbs, consistent with $\sup\theta=\sqrt{3/2}$ attained at padded $W_{\mathbb{CP}^2}$, which has $\dim U=4$. Maximising $\theta$ over the padded-4-plane family with no support constraint returns exactly $\sqrt{3/2}=1.224745$, and it does so by collapsing to a *single* padded $\mathrm{Weyl}_4$ summand ([review_r61_c6_theta.py](../scripts/reviewers/r61/review_r61_c6_theta.py)). So the conclusion looks right.

But "untouched" reads as though nothing was lost, and something was. The descent through $\dim U<n$ **was** the proof of the conclusion on that stratum; with it refuted at $m=6,8$, the conclusion $\sup\theta\le\sqrt{3/2}$ on $\dim\mathfrak m\le2$ is now *unproved*, not merely differently proved. The honest form is: *the statement survives every attack made on it, and its proof does not.*

---

## What I attacked and failed to break

- **C1**, by dropping each hypothesis separately, by comparing against three candidate Weitzenböck forms, and by diagonalising $\mathcal A$ on the whole of $\mathrm{Sym}^2(\Lambda^2)$. It held, and the failure modes off $\mathrm{Weyl}_m$ turned out to be exactly computable.
- **C3**, by enumerating all 26 multiplicity partitions at $m=6,8,10,12$ and by hand-picking singular-value relations (sum relations, geometric ratios, $10^{12}$ spreads, $10^{-9}$ collisions). Nothing moved; the root-system argument explains why nothing can.
- **C4**, by an entirely different method from the one on the record (convex feasibility rather than centraliser containment), at four dimensions and every multiplicity pattern, with a positive control to prove the test has teeth. Infeasible everywhere it should be, feasible exactly where C3 predicts an escape.
- **C6 clause 2 / the $m\ge10$ question**, by four independent searches: a nonconvex penalty search over the whole of $\mathrm{Weyl}_m$ (which failed to recover the *known* $m=6$ witness and is therefore reported as uncalibrated, not as evidence), a structured SDP screen over all rank/singular-value classes with $\mathrm{rank}\,y+\mathrm{rank}\,z\ge m$, an SDP homotopy started from a feasible padded configuration (which stalled: the feasible $(y,z)$ set is thin, every random perturbation goes infeasible), and the $\varepsilon$-deformation above. **No full-support two-negative element was found at $m=10$ or $m=12$, and none should be expected from this family.**
- **The Fubini–Study family** was screened as a possible ready-made counterexample at $m=6,8,10,12$: the Kähler form is the *top positive* eigenvector at every $m$, and $\#\mathrm{neg}$ is $6,12,20,30$, no help to either side.

## Corrections offered

1. **C1's general form** should be recorded as the four Schur constants, not just the $\mathrm{Weyl}$ one; "Ricci-flatness alone fails because $\Lambda^4$ is Ricci-flat with eigenvalue $-4$" is the crisp answer to the hypothesis question.
2. **C3's proof should be replaced by the root argument.** It is three lines, uniform in the singular values, needs no multiplicity case split, and yields the sharp mechanism (proportionality to a root of $D_p$) that the case analysis obscures. The recorded sketch also omits the off-diagonal-block step and flags a $k=2$ branch that never survives.
3. **C4's two "concretely" clauses are one clause**, by $W\mapsto-W$.
4. **C6's clause 1 is false as stated and as reasoned.** Replace with: *for Frobenius-orthogonal supports $P$ is additive and $\theta_{\mathrm{sum}}=\theta_A/\sqrt2\le0$; when the 4-planes overlap the cross term survives and $\theta>0$ occurs* (three explicit $m=6$ witnesses, up to $+0.1384$).
5. **C6's clause 3 wording.** "The conclusion is untouched" should become "the conclusion is not contradicted by anything found, but it no longer has a proof on this stratum".
6. **New, and usable:** $\|\mathrm{ad}_{v_N}\|_{\mathrm{op}}^2\ge2|\lambda_N|/T_+$, hence $s_1+s_2\ge1$ for the most negative eigenvector whenever there are exactly two negative eigenvalues, with equality at the $m=6$ witness. Sharpening $\ge1$ to $=\sqrt2$ would close the $m\ge10$ question outright, since $s_1+s_2=\sqrt2$ forces rank 4.


---

## Synthesis carried in REVIEW.md

### Reviewer 61: the same six claims, on an identical brief

Full report in [reviews/REVIEW_r61.md](reviews/REVIEW_r61.md). Agrees with Reviewer 60 on every verdict.

**The identity, settled exactly rather than sampled.** $\mathcal A$ is linear and $SO(m)$-equivariant, so Schur makes it diagonal on $\mathrm{Sym}^2(\Lambda^2)$ with four constants: $+2$ on $\mathrm{Weyl}_m$, $-(m-4)$ on $S^2_0$, $-2(m-2)$ on the scalar, $-4$ on $\Lambda^4$. That answers the hypothesis question outright, **Ricci-flatness alone fails because $\Lambda^4$ is itself Ricci-flat and carries $-4$**.

**The collapse proof, replaced.** Three root-system lines with no multiplicity case split: $\mathfrak c\supseteq\mathfrak t\cap x^\perp=a^\perp$, so $\mathfrak z(\mathfrak c)\subseteq\mathfrak t\oplus\bigoplus\{\mathfrak g_\beta:\beta\propto a\}$, and no root of $D_p$ is proportional to an all-nonzero vector once $p\ge3$. Confirmed at 26 partitions plus adversarial singular-value relations, sum relations, geometric ratios, $10^{12}$ spreads, $10^{-9}$ collisions.

**Where the two reviewers disagreed, and how it was settled.** Reviewer 60 held that the root argument covers only the multiplicity-free pattern and that a case split on the number of blocks is needed. That objection applies to the earlier block-by-block sketch, not to the argument above, which uses the **full** maximal torus rather than the block centres: checked directly here, $\mathfrak t\cap x^\perp\subseteq\mathfrak c$ with commutator exactly $0$ at every multiplicity pattern tried. Reviewer 61's proof is general. Reviewer 60's finer measurement survives, $\dim\mathfrak z(\mathfrak c)$ equals the number of blocks, so the old sketch's $k=2$ clause named a contribution the centre slice cancels.

**On $m\ge10$**, a structured convex screen over rank and singular-value classes: at $m=6,8$ the only near-feasible class is two rank-4 complex structures, images spanning $\le8$ dimensions; every $m=10$ class screened is infeasible, best $-1.4\times10^{-3}$, with the deficit growing monotonically as either rank leaves $4$. A one-parameter deformation makes it exact, $\varepsilon=0$ feasible with $\dim U=8$, every $\varepsilon>0$ strictly infeasible with $\dim U=m$, the margin reaching zero only in the unattained limit. **That is Reviewer 59's $\delta^2$ floor, now with a certificate at each point and an explanation.**

**New and usable**: contracting the identity at the most negative eigenvector gives $\|\mathrm{ad}_{v_N}\|_{\rm op}^2\ge2|\lambda_N|/T_+$, hence $s_1+s_2\ge1$ whenever there are exactly two negative eigenvalues, with equality at the $m=6$ witness. Sharpening $\ge1$ to $=\sqrt2$ forces rank $4$ and closes $m\ge10$ outright.
