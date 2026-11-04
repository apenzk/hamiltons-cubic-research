### Reviewer 22: the Fox algebra identification and the Killing constant

**The mathematics survives; two claims about it overstated, and the shipped script contradicted its own docstring.**

**The identification is exact, with no factor slip.** Implementing Fox's product from his tensor formula (5.11) with no project code in the path gives $X*Y=-1.000000000000\cdot F_X(Y)$ at residual $2\times10^{-16}$, at $n=5,6,7$ on random Weyl pairs and at $u$; the sign is his curvature convention, under which $-\mathrm{Id}$ is an isometric algebra isomorphism. Two corrections: his metric is complete contraction, measured at exactly $4.0000000000\times$ Frobenius, so $\kappa_{\text{Fox}}=(2n-1)(n-1)/16$; and idempotents are not unit vectors ($|e|=1/\theta$), so the form "$\kappa=1+\sum\lambda_i^2$" does not apply as written. The measured numbers are unaffected.

**The group is $O(n)$.** The space of $SO(4)$-invariant symmetric forms on $\mathrm{MC}_W$ is **two**-dimensional by exact Casimir-kernel computation, against one at $n=5,6$, which is why Fox states the hypothesis with $O(n)$. His **Theorem 1.3** states both conclusions for this algebra directly and is the correct citation.

**Constancy is real, not a two-point coincidence.** $\mathop{\mathrm{tr}}(F_W^2)=\kappa$ at roughly 90 points across $n=4\ldots14,16$: all sphere-product splittings, the $\mathfrak{su}(m)$ Kähler points, the Fox plateau, and random unit Weyl operators with criticality residual $\approx1$. Maximum deviation $4\times10^{-13}$. The bilinear form checks at random pairs with $\langle X,Y\rangle\ne0$ to $5\times10^{-16}$, the cross-term check between $u$ and $W^*$ is vacuous, since those are exactly orthogonal.

**The closed form is derivable and holds well outside the fit.** $\kappa=\tfrac32\sum m_ir_i^2=(2n^2-3n+1)/4$ follows from the $F_u$ multiplicities, re-measured exactly at $n=4\ldots12$; held-out dimensions $4,5,6,7,9,11,13,14,16$ are all exact, with $n=14,16$ by an independent matrix-free projector route.

**What is refuted: the claim that it constrains anything new.** Both identities are arithmetic consequences of spectra already recorded, at $u$ the $\tfrac13$ and $-\tfrac16$ multiplicities stand in ratio $1:2$ so $\mathop{\mathrm{tr}}L=0$ cancels identically, and the balanced sphere's $(1,16,54,148,81)$ gives $\tfrac{21}{16}\cdot20=26.25$, from a table committed the previous day. Since the identities hold at *every* $W$, they are not properties of idempotents at all.

**The strongest available claim was not the one made.** Fox's **Remark 1.4** explicitly leaves $\kappa$ uncomputed for $\dim V>4$, so the closed form supplies a number the source does not have, checkable against his **Theorem 1.5(2)** value $21/16$ at $\dim V=4$, which it matches.

**Defects fixed after the audit:** the script divided $\mathop{\mathrm{tr}}L^2$ by $\theta^2$ and printed `DIFFER` at every $n$, contradicting its own docstring; the cross-term line divided by zero and printed `nan`; and $\kappa$ collided with the defect-penalty coefficient already in use elsewhere.
