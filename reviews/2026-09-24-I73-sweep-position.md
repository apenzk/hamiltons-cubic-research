# I73 targeted sweep, position, 2026-09-24

**Chosen by the user 2026-09-24** from [DECISIONS-TO-MAKE.md](../DECISIONS-TO-MAKE.md): one bounded literature sweep for the seven-frame lemma, then a derivation attempt on what it finds.

## The owed statement

**The seven-frame lemma.** $X_1,\dots,X_7$ orthonormal in $\mathfrak{so}(n)$ under $\langle X,Y\rangle=-\tfrac12\operatorname{tr}XY$; $T=\sum_{i\neq j}\lVert[X_i,X_j]\rVert^2$. Owed: $T\le54.06$ uniformly in $n$. Known frames reach $42$ (octonion $L_{e_i}/2$ at $d=8$, the $\mathfrak g_2$-complement at $d=7$, the pencil $u\wedge w_i$). It closes [L173](../findings/bounds-relaxations.md)'s ray at $\sqrt{3/2}$ and so finishes [I73](../plan.md)'s sub-step (c) via [L237](../findings/second-order.md).

## What the record already holds

- [L238](../findings/second-order.md): $T=\mathbb E[(\operatorname{tr}G)^2-\lVert G\rVert_F^2]-168$, $G$ the Gram of $X_iv$; $T\le(1-\tfrac1r)(196+2\operatorname{tr}P^2)-168$ with $r=\min(7,d-1)$, $P=\sum X_i^{\mathsf T}X_i$; isotropic $P$ gives $T\le42$. Exact identity $T=2(1-\tfrac1k)\operatorname{tr}P^2-2\sum\lVert M_{ij}\rVert_F^2$, equality iff pairwise anticommuting and $Q_i=P/k$.
- [L237](../findings/second-order.md): Ky Fan row caps; at the vertex every available bound returns exactly $56$, saturated by $Q_i=\tfrac13\Pi_W$ on a common six-space.
- Screened dead ([ATTEMPTS](../ATTEMPTS.md) 2026-09-24): spin representation (min of vector and spin bounds reaches $56.6$ at $n=8$), a $\mathrm{Cl}_{0,8}$ operator ($147$ on the octonion frame).
- The missing piece, as the record states it: continuity across a small leak off a common six-space $W$, i.e. a quantitative Hurwitz–Radon statement.

## What earlier sweeps covered (do not repeat)

- DDVV for skew matrices, [Ge 2014](../references/ge-2014-ddvv-skew-symmetric/notes.md): constant $\tfrac23$, gives $65.3$.
- DDVV survey and the Clifford-span theorem, [Ge–Li–Tang–Zhou 2024](../references/ge-li-tang-zhou-2024-ddvv-survey/README.md): $42$ only inside a Clifford span.
- Lu–Wenzel conjectures, [notes](../references/ge-li-lu-zhou-2019-lu-wenzel-conjectures/notes.md): row $\le14$, top-six $\le16$.
- Tkachev's Clifford-type extremal algebras, [tkachev-2019-clifford-extremal](../references/tkachev-2019-clifford-extremal/).
- [Weingart 2017](../references/weingart-2017-moments-sectional-curvature/): moments of sectional curvature.

## This sweep's batches

1. Approximate / stable Clifford relations: almost-anticommuting skew matrices, quantitative Hurwitz–Radon, stability of representations of Clifford algebras.
2. Maximal sums of sectional curvatures over $k$-planes in compact Lie groups ($k$-th scalar curvature of $SO(n)$ with the bi-invariant metric).
3. Commutator estimates for $k$ matrices beyond DDVV: Böttcher–Wenzel for families, "sum of squared commutators of orthonormal matrices".
4. Forward citations of Ge 2014 and Ge–Li–Zhou's Clifford-span theorem restricted to $k=7$ or to skew matrices.
