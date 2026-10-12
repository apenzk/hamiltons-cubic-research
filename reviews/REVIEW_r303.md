# Reviewer 303, the second-order operator on the diagonal locus

Cold adversarial audit of J1–J4 of `brief7.md`, plus J5 and J6 added mid-task by the coordinator. Everything below was rebuilt from the definitions in [scripts/reviewers/r303/](../scripts/reviewers/r303/) and imports nothing under review: $\mathfrak{so}(n)$ structure constants by literal commutators of $E_{ab}-E_{ba}$ under $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, the sharp product as $(R\# S)_{\alpha\beta}=\tfrac12c_{\alpha\gamma\varepsilon}c_{\beta\delta\zeta}R_{\gamma\delta}S_{\varepsilon\zeta}$, $\mathrm{Weyl}_n$ as the nullspace of first Bianchi together with the Ricci contraction of the $4$-tensor, and $L_WH=\tfrac12(WH+HW)+W\# H$.

**Gatekeepers passed before any claim was touched.** $c$ totally antisymmetric with entries $0,\pm1$; $\dim\mathrm{Weyl}_n=35,84$ at $n=5,6$; $W\#I=-W$ at $6\times10^{-16}$; $\operatorname{tr}(W^\#)=-\lVert W\rVert^2$ at $4\times10^{-16}$; $Q(W)=\theta W$ at every sphere product at $10^{-16}$ with $\theta_0(6)=1.054093$ and $\theta_0(8)=1.145644$ reproduced; and Hamilton's diagonal $\#$-formula recovered from the structure constants rather than assumed.

## Verdicts

| Claim | Verdict | One line |
| --- | --- | --- |
| **J1**, diagonal invariance and the $n\times n$ formula | **CONFIRMED**, and it is a **theorem**, not a measurement | Invariance holds at non-critical $W$ and for $H$ outside $\mathrm{Weyl}_n$ too, with off-diagonal mass exactly $0.00\mathrm{e}{+}00$; one reading caveat, the matrix identity carries a spurious diagonal that the operator does not |
| **J2**, the Rayleigh form | **CONFIRMED** | Exact to $4\times10^{-16}$ at critical and non-critical $M$ alike, in the $n\times n$ Frobenius normalisation; the $\Lambda^2$ pairing is **half** of it |
| **J3**, the reduction | **REFUTED as an equivalence**, CONFIRMED as a one-way necessary condition | The dimension count and admissibility are exactly right; but every $\theta/2$-eigenvector is an $\mathfrak{so}(n)$-orbit direction and **none of them is diagonal**, so the reduced criterion has $\ge 2\times$ slack at every maximiser and can never be sharp |
| **J4**, the family is vacuous | **REFUTED** | $\dim\ker M=1$ is an accident of connected test points: **every** diagonal critical point with disconnected support has $\dim\ker M=\#\text{components}$, and there the family is admissible, non-radial, and satisfies $\mathcal L(N)=\theta N$ **exactly** |
| **J5** (the algebraic candidates carry none of the violation | **PLAUSIBLE**), substance right, the $C_5$ half is wrong | At the sphere products the reason is stronger than stated and covers *all* invariant matrices; at the $C_5$ blow-up $M\circ M$ and $M^2$ do **not** vanish, they project to Frobenius norm $0.210819$, but their Rayleigh quotient is exactly $0$ |
| **J6**, the obstruction is representation-theoretic | **PLAUSIBLE** for a *uniform* construction, **REFUTED** as stated | Every sub-claim at the $C_5$ blow-up reproduces; but at the low-symmetry $\Delta>0$ points the top eigenvector **lies inside** the trivial isotype, so an equivariant construction is unobstructed there |

**The prize was not found.** Across $123$ distinct diagonal critical points at $n=6,\dots,10$, every one with $\Delta>0$ has $\lambda_{\max}(\mathcal L)/\theta\ge1.0856$, more than **twice** the threshold. The diagonal half of V3 survives, with a wider margin than it claims.

## J1, the operator, and why the invariance is unconditional

**The derivation, which the record does not give.** In the coordinate pair basis the only non-zero structure constants are $c_{(ab)(bd)(ad)}=\pm1$ for distinct $a,b,d$. For diagonal $R,S$ the sharp product reads $(R\#S)_{\alpha\beta}=\tfrac12\sum_{\gamma\varepsilon}c_{\alpha\gamma\varepsilon}c_{\beta\gamma\varepsilon}r_\gamma s_\varepsilon$, so a non-zero entry needs one index pair $\{\gamma,\varepsilon\}$ that is simultaneously of the form $\{(ax),(bx)\}$ and $\{(cy),(dy)\}$. Two distinct pairs meet in **exactly one** vertex, so $x=y$ and $\{a,b\}=\{c,d\}$: $\alpha=\beta$. **Diagonality is forced by the pair combinatorics alone**, no criticality, no symmetry, no Ricci-flatness. Reading off the surviving entry gives Hamilton's formula $(R\# S)_{(ab)(ab)}=\tfrac12(MN+NM)_{ab}$, and $\tfrac12(WH+HW)$ contributes $M_{ab}N_{ab}$, which is the claimed $\mathcal L$.

**And the tests confirm it where the record did not look.** Off-diagonal mass of $L_WH$ is exactly $0.00\mathrm{e}{+}00$ (bit-for-bit zero, not $6\times10^{-17}$), at $S^3\times S^5$, at random **non-critical** diagonal $W$ ($n=6,7,8$, criticality residual $0.15$–$0.24$), and for $H$ with **non-zero row sums**, i.e. outside $\mathrm{Weyl}_n$ entirely. The $n\times n$ formula matches to $4\times10^{-16}$ throughout ([j1_invariance.py](../scripts/reviewers/r303/j1_invariance.py)).

### The one correction: the identity carries a diagonal the operator does not

$\mathcal L(N)=M\circ N+\tfrac12(MN+NM)$ read as a matrix identity assigns $\mathcal L(N)$ the diagonal $\langle M_i,N_i\rangle$, measured at $0.14$–$0.91$ on the tests. The $\Lambda^2$ object has no such entry (a diagonal Weyl operator *is* a hollow matrix) so the operator is the **hollow part** of the right-hand side. This is not cosmetic:

$$\sum_{j\ne i}\big(\mathcal L N\big)_{ij}=\langle M_i,N_i\rangle+\tfrac12\big[(MN\mathbf 1)_i+(NM\mathbf 1)_i\big]-(MN)_{ii}=0$$

for $M\mathbf1=N\mathbf1=0$, **because** the $-(MN)_{ii}$ from hollowing cancels the $M\circ N$ row sum. Keeping the diagonal gives row sums $2\langle M_i,N_i\rangle$, measured at $0.28$–$0.81$, and the zero-row-sum space is then *not* invariant. So the hollowing is load-bearing, and it is what makes $\mathcal L$ an endomorphism of the admissible space at **every** $M$, critical or not. The same reading repairs $D\Phi(M)[N]/2$: its diagonal is the derivative of the $\operatorname{diag}(s)$ term on the other side of the criticality equation, not part of $\mathcal L$.

## J2, the Rayleigh form

$\langle N,\mathcal L N\rangle=\sum_{ij}M_{ij}N_{ij}^2+\operatorname{tr}(MN^2)$ holds to $4\times10^{-16}$ at $n=6,7,8$, at critical and non-critical $M$, and for $N$ with non-zero row sums. **The normalisation is the $n\times n$ Frobenius one**, $\langle A,B\rangle=\sum_{ij}A_{ij}B_{ij}$; the $\Lambda^2$ pairing $\langle H,L_WH\rangle$ is exactly half of it, as it must be since $\lVert N\rVert_F^2=2\lVert H\rVert_{\Lambda^2}^2$. The Rayleigh **quotient** is therefore convention-free, which is why nothing downstream breaks. The derivation is one line from J1: $\sum_{ij}N_{ij}(MN)_{ij}=\operatorname{tr}(MN^2)$, and the hollow correction drops out because $N_{ii}=0$.

## J3, the reduction is real, the "no representation theory" is the sales pitch

**What checks.** The admissible space is exactly right: for every hollow symmetric zero-row-sum $N$, $\mathrm{diag}(N)$ lies in $\mathrm{Weyl}_n$ to $1.6\times10^{-15}$, and conversely the diagonal part of $\mathrm{Weyl}_n$ has dimension exactly $n(n-3)/2$, $9,14,20$ at $n=6,7,8$, against $\dim\mathrm{Weyl}_n=84,\,168,\,300$. $\mathcal L$ is self-adjoint on it to $10^{-16}$, and $M$ itself is an eigenvector with eigenvalue exactly $\theta$, so $e^\perp$ is correctly the orthogonal complement of $M$ inside that space.

**What fails: the reduction is strictly lossy, and lossy exactly where Lemma L24 bites.** Comparing the diagonal restriction against $\lambda_{\max}(L_e)$ on all of $\mathrm{Weyl}_6\cap W^\perp$ ([j3_full_vs_diag.py](../scripts/reviewers/r303/j3_full_vs_diag.py)):

| diagonal critical point | $\theta$ | diagonal $\lambda_{\max}/\theta$ | **full** $\lambda_{\max}/\theta$ |
| --- | --- | --- | --- |
| $S^3\times S^3$ | $1.054093$ | $0.250000$ | $\mathbf{0.500000}$ |
| $S^2\times S^4$ | $0.968246$ | $0.333333$ | $\mathbf{0.666667}$ |
| padded $S^2\times S^3$ | $0.942809$ | $0.625000$ | $0.750000$ |
| padded $S^2\times S^2$ | $0.866025$ | $0.666667$ | $1.000000$ |

**The mechanism is exact and settles the question in general.** $Q$ is $O(n)$-equivariant, so differentiating $Q(gWg^{-1})=gQ(W)g^{-1}$ gives $L_W([A,W])=\tfrac\theta2[A,W]$ for every $A\in\mathfrak{so}(n)$: **the orbit directions are exact $\theta/2$-eigenvectors.** For diagonal $W$ they are purely off-diagonal, so the diagonal restriction contains none of them and its top eigenvalue at a maximiser sits strictly below $\theta/2$, measured at $0.250,0.333,0.375,0.375$ at $S^3\times S^3$, $S^4\times S^4$, $S^3\times S^5$, $S^4\times S^5$. The reduced criterion is therefore **never sharp**, and $S^2\times S^4$ shows it is not merely unsharp but blind: it passes the diagonal test at $1/3$ while failing the real one at $2/3$.

**So the surviving reading is one-way**, diagonal $\lambda_{\max}>\theta/2$ certifies non-maximality; diagonal $\lambda_{\max}\le\theta/2$ certifies nothing. This matches the coordinator's mid-task correction, reached here independently.

**Is it vacuous?** No, but the pitch is. It is a genuine $n\times n$ certificate and it is cheap. What "no representation theory" cannot mean is that the isotypic structure went away: it reappears **inside** the $n\times n$ problem as the $\mathrm{Aut}(M)$-isotype decomposition of $V$, which is exactly what J5 and J6 are about. The reduction moved the representation theory from $O(n)$ to the point's own finite symmetry group; it did not remove it.

## J4, REFUTED: the family is not vacuous, and $\dim\ker M=1$ is an accident

The three algebraic parts are correct and reproduce: $N_{ij}=2M_{ij}(a_i+a_j)$ for $A=\operatorname{diag}(a)$; the row sums are $2(Ma)_i$; and, substituting criticality,

$$(\mathcal LN)_{ij}=(a_i+a_j)\big[M_{ij}^2+\theta M_{ij}\big]+2\big(M\operatorname{diag}(a)M\big)_{ij}$$

which I re-derived from J1 rather than checking numerically. The conclusion drawn from them is what fails.

**Two mechanisms give $\dim\ker M\ge2$, and one of them revives the family.**

1. **Padding.** Appending a zero row to a critical $M$ leaves criticality intact (the appended row satisfies $0=\theta\cdot0$ and $s_{n+1}=0$) so every padded point has $\ker M\supseteq\langle\mathbf1,e_{n+1}\rangle$. Found at $n=6,\dots,10$ with $\dim\ker M$ up to $7$. Here the family stays vacuous, and provably: $a\in\langle\mathbf1,e_{n+1}\rangle$ has $a_i+a_j$ constant on $\operatorname{supp}M$, so $N$ is radial.
2. **Disconnected support, and this one breaks the claim.** If $M_1,M_2$ are critical with $\operatorname{tr}M_k^2=2$ then $M=\alpha M_1\oplus\beta M_2$ is critical for $\alpha=\theta/\theta_1$, $\beta=\theta/\theta_2$ and $\theta=(\theta_1^{-2}+\theta_2^{-2})^{-1/2}$, verified at $10^{-16}$ for three pairs, with $\theta$ matching the closed form to $15$ digits. Then $\ker M=\langle\mathbf1_{C_1},\mathbf1_{C_2}\rangle$, and $a=\alpha^{-1}\mathbf1_{C_1}-\beta^{-1}\mathbf1_{C_2}$ gives an $N$ that is **admissible** (row sums $4\times10^{-12}$), **non-radial** ($\lVert N-\mathrm{rad}\,M\rVert=2.0$), and satisfies $\mathcal L(N)=\theta N$ to $3\times10^{-11}$.

The witness the solver found first is $n=8$, $\theta=\sqrt6/4=0.612372$: two disjoint copies of the $n=4$ sphere-product matrix, $\dim\ker M=2$, no zero rows, $\Delta=0$, criticality residual $1.1\times10^{-11}$ from the solver and $3.6\times10^{-16}$ when rebuilt exactly as the direct sum ([j4_revive.py](../scripts/reviewers/r303/j4_revive.py)). The withdrawn $\theta$-free criterion evaluates there to $+0.612396$, i.e. $\langle N,\mathcal LN\rangle-\tfrac\theta2\lVert N\rVert^2=+1.2248$, **a genuine violation from a genuine admissible direction.**

**What the family actually proves.** $\Phi$ is block-diagonal on a disconnected $M$, so $\mathcal L$ acts as $\theta$ on the whole two-dimensional span $\{\alpha M_1\oplus\beta M_2\}$, of which $M$ is one line. Hence:

> **No diagonal critical point with disconnected support is a local maximum**, the relative-scaling direction is an exact $\theta$-eigenvector, twice the threshold.

**What survives of the record's paragraph.** The withdrawal of the criterion is still right *at connected points*, and for the reason given: at $S^3\times S^3$, $S^3\times S^5$ and $S^4\times S^4$ the criterion's quadratic form in $a$ has top eigenvalue $+1.405$, $+1.544$, $+1.146$ but the maximising $a$ has $\lVert Ma\rVert$ of order $0.3$–$1.1$, inadmissible, exactly as diagnosed. I found no connected critical point with $\dim\ker M\ge2$ in $123$ points; that remains a plausible conjecture and is not what the record claimed.

## J5, right for the wrong reason at the sphere products, wrong at $C_5$

**At the sphere products the claim is true and understates itself.** $\dim(V\cap M^\perp)^{\mathrm{Aut}(M)}=\mathbf 0$ at $S^3\times S^3$ ($\lvert\mathrm{Aut}\rvert=72$), $S^3\times S^5$ ($720$) and $S^4\times S^4$ ($1152$). So it is not that these three candidates vanish, **every** $\mathrm{Aut}(M)$-invariant matrix does, block-constant or not, and $M\circ M$, $M^2$, $M^{\circ3}$, $M^3$, $M\circ M^2$ all project to $\le10^{-15}$. That is the cleaner claim the coordinator asked about, and it is the correct one.

**At the $C_5$ blow-up the claim is false as stated.** With weights $(+0.298142,-0.149071,+0.074536)$ on (within, adjacent, non-adjacent), $\theta=0.670820$, $\Delta=12.000000$, criticality $1.5\times10^{-16}$, reproducing the record's point, the trivial isotype of $V\cap M^\perp$ is **one**-dimensional, and

| candidate | $\lVert\text{projection into }V\cap M^\perp\rVert$ | Rayleigh$/\theta$ |
| --- | --- | --- |
| $M\circ M$ | $0.210819$ | $1.2\times10^{-15}$ |
| $M^2$ | $0.210819$ | $1.2\times10^{-15}$ |
| $M^{\circ3}$ | $0.047140$ | $0$ |
| $M^3$ | $0.094281$ | $0$ |

Triple-checked by three independent routes: the basis projection, a symbolic computation in the three orbit weights giving residual $(0.044444,0.011111,-0.022222)$, and a rank test showing $\{M\circ M,M,\mathbf U\}$ has rank $3$. **The substance of J5 survives** (the projection carries none of the violation) but the reason is different and sharper: the trivial isotype is one-dimensional, $\mathcal L$ is $\mathrm{Aut}(M)$-equivariant, so that line is an exact **$0$-eigenvector**. "Projects to exactly zero" should be replaced by "lands in the trivial isotype, where $\mathcal L$ is $0$ at $C_5$ and the isotype is empty at the sphere products".

## J6, true at $C_5$, false in general, and the right statement is about *uniform* constructions

**At the $C_5$ blow-up every sub-claim reproduces.** $\lvert\mathrm{Aut}(M)\rvert=320=2^5\rtimes D_5$; the top eigenspace has dimension $2$ at $\lambda_{\max}/\theta=1.206011$; it is invariant as a set to $3.05\times10^{-15}$; and no vector in it is fixed pointwise. **A cleaner certificate than the deviation figure**: the trivial isotype of $V\cap M^\perp$ is one-dimensional with eigenvalue $0\ne1.206\,\theta$, so the top eigenspace meets it in $\{0\}$, exactly, by eigenvalue separation, with no tolerance involved.

**But it is an artefact of the symmetry.** Sweeping $\lvert\mathrm{Aut}(M)\rvert$ against the isotype structure over the $n=8$ census ([j56.py](../scripts/reviewers/r303/j56.py)):

| $\theta$ | $\Delta$ | $\lambda_{\max}/\theta$ | $\lvert\mathrm{Aut}\rvert$ | $\dim$ top | $\dim$ trivial isotype | best in trivial isotype$/\theta$ |
| --- | --- | --- | --- | --- | --- | --- |
| $0.462910$ | $4.241$ | $1.6007$ | $14$ | $2$ | $1$ | $-1.0000$ |
| $0.277495$ | $6.512$ | $2.2793$ | $12$ | $1$ | $3$ | $\mathbf{2.2793}$ |
| $0.162893$ | $10.239$ | $3.8665$ | $4$ | $1$ | $6$ | $\mathbf{3.8665}$ |
| $0.161868$ | $11.157$ | $3.9275$ | $2$ | $1$ | $10$ | $\mathbf{3.9275}$ |
| $0.094597$ | $9.611$ | $6.9796$ | $6$ | $1$ | $4$ | $\mathbf{6.9796}$ |
| $0.082270$ | $15.179$ | $8.0413$ | $16$ | $1$ | $2$ | $\mathbf{8.0413}$ |

At every low-symmetry $\Delta>0$ point the top eigenspace is **one**-dimensional and **inside** the trivial isotype: the violating direction is $\mathrm{Aut}(M)$-invariant and an equivariant construction can reach it. So "a proof of V3 cannot exhibit its test direction by an equivariant construction" is **false as a statement about $\Delta>0$ points**. Only two of the seventeen $n=8$ points hide their top eigenspace from the trivial isotype, and both are among the most symmetric.

**The statement that survives is about uniformity.** A proof must cover the $C_5$ blow-up, where the obstruction is real; so no *single* equivariantly-built $N$ works at every $\Delta>0$ point. That closes the class the coordinator wanted closed, but for a different reason, the obstruction is a property of a few symmetric points, not of the $\Delta>0$ stratum.

**On which group is the right one.** For the *diagonal* problem it is exactly $\mathrm{Aut}(M)$, the weighted-graph automorphisms: the continuous isotropy does not act on $V$, because a rotation mixing two twin coordinates moves a diagonal operator off the diagonal locus. The sign-flip subgroup acts on $V$ by $N_{ij}\mapsto\varepsilon_i\varepsilon_jN_{ij}$ but stabilises $M$ only for $\varepsilon$ constant on components, where it acts trivially. So $320$ is right here. **For the full problem the group is larger and the obstruction correspondingly stronger**: $\dim\mathfrak k(W)=\{A\in\mathfrak{so}(10):[\Lambda^2A,W]=0\}$ measures **exactly $5$** at the $C_5$ blow-up, the $\mathfrak{so}(2)^5$ of within-block twin rotations, which is where $\Delta$'s $g_{ab}=0$ edges live.

## The prize: not found, and the margin is wide

$123$ distinct diagonal critical points with $\theta>0$ were solved to criticality residual $<10^{-10}$ at $n=6,\dots,10$, least-squares from random starts, the idempotent power iteration from both signs, explicit sphere products and paddings, plus a root scan of the $5$-block circulant family that recovers the $C_5$ blow-up at $\theta=0.670820$, $\Delta=12.000000$ and the record's $n=8$ circulants at $\theta=0.555683$ and $\theta=0.082270$ ([census2.py](../scripts/reviewers/r303/census2.py)).

**Every point with $\Delta>0$ clears the threshold by more than a factor of two**, and the closest approach falls with $n$ nowhere:

| $n$ | $\Delta>0$ points | $\min\lambda_{\max}/\theta$ over them | attained at |
| --- | --- | --- | --- |
| $6$ | $1$ | $2.3155$ | $\theta=0.308607$ |
| $7$ | $4$ | $1.6007$ | $\theta=0.462910$ |
| $8$ | $14$ | $1.0856$ | $\theta=0.655584$ |
| $9$ | $26$ | $1.3807$ | $\theta=0.555683$ |
| $10$ | $45$ | $1.7346$ | $\theta=0.379479$ |

**A sharper conjecture than V3 is what the data actually supports**: every diagonal critical point with $\Delta>0$ has $\lambda_{\max}(\mathcal L)\ge\theta$, not merely $>\theta/2$. If that is the true statement, a proof has a factor-two cushion to spend, and the $\theta$-eigenvector of J4's revived family is one place such a bound is attained exactly.

**Two cautions for anyone reading this as support for V3.**

- **Refuting V3 needs more than the diagonal operator.** Since the diagonal $\lambda_{\max}$ is only a lower bound (J3), a diagonal point with $\Delta>0$ and diagonal $\lambda_{\max}\le\theta/2$ would not by itself refute V3, the full $\mathrm{Weyl}_n$ value would have to be computed too. The census closes the easier half of that door and leaves the harder half untested.
- **The converse of V3 is false, and visibly so.** $\Delta=0$ does **not** imply the second-order condition holds: the paddings and the disconnected sums all have $\Delta=0$ with $\lambda_{\max}/\theta\in\{0.5833,0.6000,0.6250,0.6667,1.0000,1.2500,1.3333\}$. Any attempt to prove V3 through an equivalence rather than an implication is dead on arrival.

## What I did not reach

- The full-$\mathrm{Weyl}_n$ comparison of J3 was run at $n=6$ ($\dim84$) only; $n=8$ ($\dim300$) and $n=10$ ($\dim770$) are affordable and would confirm the orbit-direction mechanism at a $\Delta>0$ point rather than at maximisers.
- The census is a lower bound on the critical set. It missed the $C_5$ blow-up and the disconnected $n=8$ point until each was sought by a targeted solve, so "every $\Delta>0$ point has $\lambda_{\max}\ge\theta$" is evidence from $123$ points, not a sweep.
- The census stops at $n=10$. Runs at $n=11$ and $n=12$ were started and killed unfinished; the $\Delta>0$ margin's behaviour past $n=10$ is untested here.
- Whether a **connected** diagonal critical point can have $\dim\ker M\ge2$ is open; a positive answer would revive J4's family at a point that matters.
