# Reviewer 80, Gate 2 on the four commits 557307e..73cd9f0

Own machinery throughout, including an independently **derived** sharp formula $(W^\#)_{ab}=\tfrac12\sum c_{amn}c_{bpq}W_{mp}W_{nq}$ matching [review_r30_core.py](../scripts/review_r30_core.py) at $0.0$. Symmetric spaces built from Lie data $\hat R_{(ab),(cd)}=\langle[X_a,X_b],[X_c,X_d]\rangle$, validated by $G_2(\mathbb R^4)=S^2\times S^2$ and $G_2(\mathbb R^6)=G_2(\mathbb C^4)$ agreeing exactly.

| # | claim | verdict |
|---|---|---|
| 1 | the census | rows and maximum CONFIRMED; **three of four "outside" families REFUTED** |
| 2 | fence post F22 | CONFIRMED analytically; one word OVERSTATED |
| 3 | the decision procedure | theorem CONFIRMED; **the implementation REFUTED by witness** |
| 4 | $\mathbb{CP}^m$ critical by symmetry | CONFIRMED; framing OVERSTATED |
| 5 | the surviving bound | CONFIRMED on its own hunt; **the record's evidence for it is unauditable** |

## 1. Three of the four "new" families are wrong

Exact rational arithmetic (integer $V=N\!\cdot\!W$, `Fraction` $\theta^2$):

| claimed | as recorded | exact truth | $S_{\mathfrak{mmm}}$ | verdict |
|---|---|---|---|---|
| $\mathbb{HP}^2$ | $\sqrt{56/45}$, $S=0$ | $\theta^2=56/45$ | $2\times10^{-29}$ | **CONFIRMED** |
| $Q_3=G_2(\mathbb R^5)$ | $\sqrt{6/5}=1.095445$, $S=0$ | $\theta^2=\mathbf{15/26}$, $\theta=0.759554525$ | $\mathbf{30}$ | **REFUTED** |
| $Q_5=G_2(\mathbb R^7)$ | $1.035098$, $S\approx0$ | $\theta^2=\mathbf{45/92}$, $\theta=0.699378606$ | $\mathbf{252}$ | **REFUTED** |
| $Q_6=G_2(\mathbb R^8)$ | $1.024695$, $S\approx0$ | $\theta^2=\mathbf{33/70}$, $\theta=0.686606562$ | $\mathbf{480}$ | **REFUTED** |

$Q_3$ built three independent ways, $SO(5)/(SO(2)\times SO(3))$, $Sp(2)/U(2)$, and the uniform $G_2(\mathbb R^k)$ family validated at $k=4,6$, all giving $15/26$. All three quadrics **are** Weyl and exactly critical; they simply have $S\ne0$ and $\theta\approx0.69$–$0.76$.

**So "$Q_3$ beats $\mathbb{CP}^3$" is WRONG**, $0.7596$ sits far *below* $1.0541$.

**The characterisation is still refuted, by $\mathbb{HP}^2$ alone**, and its hand proof checks out: top eigenvalue multiplicity 3, minimum bivector rank 8 over 400 draws, $\dim\ker\Phi=1$.

**The mechanism, and why it cannot break the bound.** $\mathbb{HP}^2$ and $S^3\times S^5$ are **isospectral** at $n=8$, identical Weyl spectra $\{-0.1593638146^{(15)},0.1195228609^{(10)},0.3984095364^{(3)}\}$, identical $\theta=\sqrt{56/45}$, as are $\mathbb{CP}^4$ and $S^2\times S^6$ at $\theta^2=35/36$. These are **triality pairs**: the outer automorphism of $\mathfrak{so}(8)$ preserves the bracket (hence $\#$) and the inner product (hence $W^2$), so it preserves $\theta$ and $S$, but is not in $O(8)$, one member is diagonal, the other is not. That is precisely how a point escapes the "$\mathbb{CP}^m$ + paddings + sums" list, **and it exists only at $n=8$**, where the diagonal maximum is $S^4\times S^4$ at $\sqrt{21/16}=1.145644<\sqrt{3/2}$.

**Hunt over 26 spaces** ($\mathbb{CP}^{2..5}$, $\mathbb{HP}^{1..4}$, $G_2(\mathbb R^{5..8})$, $G_3(\mathbb R^{6,7})$, $G_4(\mathbb R^8)$, complex and quaternionic Grassmannians, $SU(q)/SO(q)$, $Sp(q)/U(q)$, $SO(2m)/U(m)$, the groups $SU(3)$, $SO(5)$): $S=0$ holds **only** at $\mathbb{CP}^m$ and $\mathbb{HP}^2$; nothing exceeds $\sqrt{3/2}$.

## 2. Fence post F22

The strengthening is analytically correct and trivial: $\delta_{\mathrm{Id}}=2\,\mathrm{Id}_{\Lambda^2}$ commutes with every $W$, so $\mathrm{Id}\in\ker\Phi_W$ always. Since $\mathbb{CP}^2$ ($\theta=1.2247$) and $\mathbb{CP}^5$ ($\theta=0.9487$) are both exactly critical with the same kernel, the conclusion survives restriction to the critical set.

**OVERSTATED:** "no refinement can track $\theta$" is proved only where $\dim\ker\Phi_W=1$; at the paddings ($11$, $4$) and sums ($2$, $3$) nothing is established. The full singular spectrum of $\Phi_W$ was checked and is **not** monotone in $\theta$, smallest nonzero $0.5064$ at $Q_3$ ($\theta=0.760$) against $0.4472$ at $\mathbb{CP}^5$ ($\theta=0.949$).

## 3. The decision procedure, theorem right, implementation wrong

**Both directions analytically confirmed**, and the Zariski replacement of `undetermined` is correct: the coincident-sum locus is the zero set of a symmetric polynomial in the eigenvalues, hence polynomial in $A$; a Gaussian draw misses a proper algebraic subset with probability 1. In exact arithmetic one failed draw suffices.

**REFUTED as implemented, witness.** A diagonal Weyl tensor at $n=6$ with one eigenvalue gap tuned to $3\times10^{-9}$, conjugated by an exact $SO(6)$ rotation, returns **`NON-DIAG (proved, rank)`** on a point diagonal by construction. Above the $10^{-9}$ simplicity tolerance the eigenvalues register as simple; below $\approx10^{-8}$ the computed eigenvector is a mixture $\varphi_{12}+\varepsilon\varphi_{34}$ reading as rank 4. Gaps of $10^{-10},10^{-9},10^{-8},10^{-7},10^{-6}$ all return `diagonal` correctly; $3\times10^{-9}$ fails. **This is the dangerous direction**, a false `NON-DIAG` admits diagonal points into the target set, and the diagonal points are the ones above $\sqrt{3/2}$. The rank certificate runs *first* and short-circuits, so the correct kernel test behind it can never catch the failure.

**A better fix than the probabilistic branch.** The recorded bug case ($\mathbb{CP}^2{+}\mathbb{CP}^2$ in $n=12$) has a 2-dimensional top eigenspace with **minimum bivector rank 8**, so non-diagonality is *deterministically certified*. Generalising the rank certificate from "simple eigenvalue with a rank $>2$ eigenvector" to "**eigenspace containing no rank-2 element**" removes the probabilistic branch entirely, and it is exactly the argument the record already uses by hand for $\mathbb{HP}^2$.

## 4. $\mathbb{CP}^m$ by symmetry

$Q(\mathrm{Weyl}_n)\subseteq\mathrm{Weyl}_n$ confirmed ($\le3\times10^{-16}$ at $n=5..8$); the trace vanishes because $\mathrm{tr}(W^\#)=-\lVert W\rVert^2$ identically. **Bonus:** the repo's screen $Q(W)=\theta W$ is therefore *equivalent* to the constrained $\Pi_{\mathrm{Weyl}}Q(W)=\theta W$, no critical points are being screened away. $\dim\mathrm{Weyl}^{U(m)}_{2m}=1$ confirmed at $m=2,3,4$, and it is classical: the $U(m)$-invariant algebraic curvature tensors form a 2-dimensional space (constant sectional plus constant holomorphic sectional), and removing the Ricci trace leaves one.

**OVERSTATED:** "this explains the census's equality case". $\mathbb{HP}^2$ **also** has $\dim\mathrm{Weyl}^{\mathfrak k(W)}=1$ ($\mathfrak k=\mathfrak{so}(5)\oplus\mathfrak{so}(3)$, $\dim13$) (the record's table omits it) and $\mathbb{HP}^2$ is not the maximum. The mechanism explains **criticality**, not **maximality**.

## 5. The sum law is stronger than recorded

Four things need not be assumed: $\circ$-orthogonality is **automatic** ($[\mathfrak{so}(n_1),\mathfrak{so}(n_2)]=0$ kills the polarised $\#$); $Q$ maps block-supported operators into the same block, so criticality of the sum **forces** criticality of each summand; $S(W)=S(W_1)+S(W_2)$; hence $\tfrac1{\theta^2}=\tfrac1{\theta_1^2}+\tfrac1{\theta_2^2}$ and $|\theta|<\min(|\theta_1|,|\theta_2|)$. Verified exactly: $1/\theta^2=4/3,\,2,\,9/5$.

**So the right statement is stronger: the supremum over the non-diagonal $S=0$ set is attained at block-indecomposable points, and sums may be dropped from the search entirely.** As written ("the entire summed family is capped with no enumeration") it is circular, it caps a sum only by its summands. As a *reduction* it is complete and sound.

**The bound stands; the record's argument for it does not.** `REVIEW_r78.md` **does not exist in the repository** and [findings/INDEX.md](../findings/INDEX.md) links to it twice, the $\sim20$-subalgebra sweep and the 3000-start Newton run have no artefact. And "154 distinct critical values at $n=6$, none with $S=0$" cannot be right: $\mathbb{CP}^3$ is an $n=6$ critical point with $S=2\times10^{-30}$ and $\theta^2=10/9$ exactly. An independent Newton enumeration (1200 starts, 651 converged, 70 distinct $|\theta|$) reproduced the *artefact*, maximum $\theta$ found $0.408$, $\mathbb{CP}^3$ never appearing. **Random-start Newton on $\mathrm{Weyl}_6$ does not reach the high-$\theta$ basin, so such an enumeration is not evidence of completeness in either direction.**

## Method split

**Analytical:** the $\delta_{\mathrm{Id}}$ argument; the diagonality iff and its corollary; the Zariski/probability-1 argument; automatic $\circ$-orthogonality, forced summand criticality, additivity of $S$, and the $1/\theta^2$ law; $\dim\mathrm{Weyl}^{U(m)}=1$ from the classical two-dimensional space; triality invariance of $\theta$ and $S$. **Exact rational:** all $\theta^2$ values and criticality checks. **Floating point only:** $\ker\Phi_W$ dimensions, $\dim\mathrm{Weyl}^K$, isospectrality, minimum-bivector-rank sampling, the tolerance witness, the Newton enumerations.
