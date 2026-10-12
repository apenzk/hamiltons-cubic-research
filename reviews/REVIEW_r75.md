# Reviewer 75, Gate 2 on the three commits since d657dcc

Independent machinery from the definitions; Weyl dims $35/84/168/300/770$ match the formula.

| # | claim | verdict |
|---|---|---|
| 1 | frame-independent diagonality | **CONFIRMED**, and weaker than it needs to be, supplies an N&S test |
| 2 | the correction to Reviewer 74 | **CONFIRMED**, and re-proved without appeal to construction |
| 3 | the coverage census | **REFUTED in part**, one row's only coverage is unsound; one count wrong; $\ge25$ band points omitted |
| 4 | $\mathbb{CP}^m$ below threshold | **CONFIRMED** exactly, scope holds |
| 5 | "no catalogued band point exceeds $\sqrt{3/2}$" | **REFUTED, wrong, not overstated** |

## 5. The counterexample was in the record

$S^5\times S^7$ at $n=12$: $\theta=1.228239158>\sqrt{3/2}$, Weyl ($10^{-16}$), critical ($4.1\times10^{-16}$), $S_{\mathfrak{mmm}}=0$ **exactly** (the negative graph is complete bipartite, hence triangle-free), $\dim\mathfrak m=35<36$. Derived the closed form twice independently:

$$\theta^2(S^p\times S^q)=\frac{2(p-1)(q-1)(p+q-1)}{pq(p+q-2)},$$

which returns $\theta_0(n)^2$ at $p=q$. In exact rationals $\theta^2(S^5\times S^7)=\tfrac{264}{175}=\tfrac32+\tfrac3{350}$. **25 band points above $\sqrt{3/2}$ at $n\le20$**, rising to $1.306120$ at $S^9\times S^{11}$, within $0.12\%$ of $\theta_0(20)$, and $\to\sqrt2$.

[findings/INDEX.md](../findings/INDEX.md) already stated "$S^5\times S^7$ at $n=12$ sits at $1.228239>\sqrt{3/2}$", and [plan.md](../plan.md) lists it among the symmetric-space equality points. **The R73 pattern exactly, refuted by a point in the project's own tables.**

*Consequence:* the diagonal/non-diagonal split is not bookkeeping. **B1 must deliver $\theta_0(n)$, not $\sqrt{3/2}$, and it is load-bearing at every even $n\ge12$**, not merely at the $C_5$ blow-up.

## 1. The necessary-and-sufficient test the author lacked

For symmetric $A$ let $\delta_A(X)=AX+XA$ on $\Lambda^2$ (diagonal in the $\phi$ basis with entry $a_i+a_j$), and $\Phi_W(A)=[W,\delta_A]$.

> **$W$ is diagonal in some orthonormal frame $\iff$ some $A\in\ker\Phi_W$ has pairwise-distinct sums $a_i+a_j$.**
> **Corollary (hard certificate): $\dim\ker\Phi_W<n$ proves $W$ is diagonal in no frame**, with no hypothesis on eigenvalue multiplicity.

($\Rightarrow$) every $A$ diagonal in the frame lies in $\ker\Phi_W$, and a generic one has distinct sums. ($\Leftarrow$) such a $\delta_A$ has simple spectrum with $A$'s coordinate 2-planes as eigenvectors, and $W$ commutes with it, so $W$ preserves each line.

It **removes "undetermined" from the census entirely**: $\mathbb{CP}^{2,3,4,5}$ and padded $\mathbb{CP}^3$ give $\dim\ker\Phi<n$ (non-diagonal, proved); the $C_5$ blow-up, $S^3\times S^5$, $S^4\times S^6$, $S^3\times S^7$, $S^2\times S^8$, $S^5\times S^7$ give $\ge n$ and a diagonalising frame is **produced**, off-diagonal $\le1.7\times10^{-15}$; $\mathbb{CP}^2{+}\mathbb{CP}^2$, $\mathbb{CP}^3{+}\mathbb{CP}^3$, $\mathbb{CP}^2{}^{\times3}$ give $2,2,3$, non-diagonal, proved. This generalises the record's Plücker obstruction, which is only necessary.

## 2. Confirmed, and independently

Three generic rotations of the $C_5$ blow-up: $\theta$, $\dim\mathfrak m$, $S$, $\Delta=12$, $\dim E(1)=1$ all unchanged to $10^{-12}$; only $\max|W-\mathrm{diag}\,W|$ moves ($0\to0.079$–$0.128$). **Applied to the rotated operator with no knowledge of its provenance, the $\ker\Phi$ test returns DIAGONAL and reconstructs a frame at residual $3.5\times10^{-15}$.** R74's Witness 2 is void, and the author is not moving goalposts: $\theta$ is $O(n)$-invariant, so a frame-dependent "non-diagonal" would partition nothing.

## 3. Three holes in the census

**(i) "Covered by H" is unsound at padded $\mathbb{CP}^3$, the one row where H is the *only* coverage.** $T_{abc}$ is totally symmetric, so the two-condition test is right **only when $\ker W=0$**. Padded $\mathbb{CP}^3$ has $\ker W=13$, and the full block decomposition gives $T_{\mathfrak{mzz}}=24\ne0$: $[\mathfrak z,\mathfrak z]$ hits $\mathfrak m$ and **no assignment of the kernel gives a $\mathbb Z_2$-grading. It is not graded.** Same defect with B2 as backup at $\mathbb{CP}^2{+}\mathbb{CP}^2$ ($T_{\mathfrak{mzz}}=32$), $\mathbb{CP}^3{+}\mathbb{CP}^3$ ($140$), $\mathbb{CP}^2{}^{\times3}$ ($96$). This is exactly the trap [b_symmetry_defect.py](../scripts/b_symmetry_defect.py)'s own header warns about.

**(ii) "Four of the twelve band points live at $n=8,10$" is wrong**, **nine** do (four at $n=8$, five at $n=10$); on the alternative reading (coverage *including* B1 at those $n$) it is **five**. Neither is four; the error understates the exposure.

**(iii) $\dim E(1)>1\Rightarrow$ B2 is the unproved converse, but it survived attack.** Solving $X\circ X=X$ inside $E(1)$ by Newton from 400 starts at the $K_4$ blow-up ($n=8$, $\dim E(1)=12$) and $K_5$ ($n=10$, $\dim E(1)=20$): both genuinely $\circ$-split, hundreds of idempotents at $10^{-16}$. Control $\mathbb{CP}^3$ yields none. Still an unproved converse, and B2 itself only *owes* $M(n)\le\sqrt3$.

**(iv) Twelve hand-picked points is not a census.** It omits $S^5\times S^7$ and $S^4\times S^8$ at $n=12$ alone, both already in [plan.md](../plan.md); also padded $S^3\times S^5$, padded $S^4\times S^6$, the unequal-weight sum $\mathbb{CP}^2+S^3\times S^5$, and the $K_4$/$K_5$ blow-ups. **Every one of the twelve has $\theta<\sqrt{3/2}$, so by claim 4's own argument the entire H column is vacuous.**

## Outside the brief

- **Multi-block sphere products can never be band points.** With correct Einstein weights, $k\ge3$ blocks always contain a cross-edge triangle: $S_{\mathfrak{mmm}}=162,384,180,648$ at $[3,3,3]$, $[4,4,4]$, $[2,3,5]$, $[3,3,3,3]$, and $\dim\mathfrak m$ exceeds the cap in every case.
- $L_e$ at $\mathbb{CP}^m$ has a **second** eigenvalue above $\tfrac12$ ($0.625,0.600,0.583$ at $m=3,4,5$).
- *Self-reported bug:* a stray transpose in its own $\Lambda^2$ lift initially made the sphere products read as non-diagonal, caught by the homomorphism control $\Lambda^2(g)\Lambda^2(h)=\Lambda^2(gh)$. The same convention appears wherever $\Lambda^2g$ is built by hand.
