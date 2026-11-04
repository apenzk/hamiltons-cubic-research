# Richard, Seshadri, Noncoercive Ricci flow invariant curvature cones

| | |
| --- | --- |
| **Source** | [Noncoercive Ricci flow invariant curvature cones](https://arxiv.org/abs/1308.1190) |
| **Identifier** | arXiv:1308.1190v1, 6 Aug 2013; math.DG |
| **Retrieved** | 2026-09-02, by [LIT-srg-forward](../../reviews/LIT-srg-forward.md) |

## Consulted for

Search target 4 of [LIT-srg-forward](../../reviews/LIT-srg-forward.md): the equation $Q(R)=\lambda R$ at symmetric spaces and what it does to a Ricci-flow-invariant cone. Found from Bhattacharya's acknowledgement of Thomas Richard and from the record's existing [richard-2014-curvature-cones-ricci-flow](../richard-2014-curvature-cones-ricci-flow/) folder; it is the paper in which the record's [Lemma 46](../../findings/problem.md) appears in print with a proof, and the paper whose Proposition 4.3 is the mechanism behind DGK's phrase "obstructions to an evolution towards constant curvature".

## Statements that matter

- **Lemma 4.1**, a nonnegatively curved Einstein symmetric space has $Q(R)=\lambda R$ with $\mathop{\mathrm{Ric}}=\lambda g$. Proof: Brendle's $\Delta R+2Q(R)=\lambda R$ for Einstein metrics, with $\nabla R=0$. Together with Lemma 3.1 (Böhm–Wilking: $Q(I)=(n-1)I$, $B(W,I)=0$) this gives $Q(R_W)=\lambda R_W$: the record's Lemma 46, in the $R=R_I+R_W$ decomposition.
- **Proposition 4.3**, a Ricci-flow-invariant cone containing $R$ of an Einstein symmetric space in its interior contains $R_W$. Proof by the explicit solution $\bar R(t)=\frac{1}{1-(1-\varepsilon)t}\bar R_I+\frac1{1-t}\bar R_W$ of Hamilton's ODE from $\bar R=R-\varepsilon I$, valid because both parts are eigenvectors of $Q$. **This is why a $\theta$-critical Weyl tensor obstructs pinching**: along the ODE the Weyl part of a critical point blows up at the same rate as the whole, so no invariant cone can separate it from the identity.
- **Theorem 0.1 and Corollary 0.3** ($n\ge4$), a closed convex $O(n)$-invariant Ricci-flow-invariant cone with $I$ in its interior that contains a nonzero Ricci-flat operator, or the curvature operator of a nontrivial Einstein symmetric space, is the whole space or $\{s\ge0\}$. Consequence for the record: every $\theta$-critical $W\ne0$ that is the Weyl tensor of a symmetric space kills every invariant cone finer than $\{s\ge0\}$ that contains it in its interior; in the record's language, the cone that the conjecture would build must have every critical $W$ on its boundary.
- **Lemma 3.2**, a specific computation $B(R_0,Q(R_0)_W)=aR_0$, $a>0$, at $R_0$ the traceless Ricci part of $S^{n-2}\times H^2$, used to show a Ricci-flat operator forces the Weyl space into the cone.

## Verdict

**Lemma 46 has a citable source with a two-line proof, and the flow-side meaning of a critical point is made explicit: a $\theta$-critical $W$ is a ray along which Hamilton's ODE is homogeneous.** The paper proves nothing about which $W$ are critical and carries no bound on $\theta$; its critical points are the symmetric-space ones, and the record's algebraic critical points (DGK's SRG solutions, the maximal tori, $\mathrm{ad}(\mathfrak{su}(3))$) are outside its scope. It changes no plan item and supplies citations for Lemma 46 and for the "obstruction" framing.
