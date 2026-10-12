# Step 8 sweep, 2026-09-28f: the range between the uniform threshold and the product step

*Position file: [2026-09-28f-step8-position.md](2026-09-28f-step8-position.md).*

## Batch 1, outward and the record

- **Second-kind cubic estimates** (candidates 1 and 2): searched outward ("Weyl tensor", "curvature operator of the second kind", cubic estimates, sharp constants). The recent papers found are on file: [cone-conditions-2025](../references/cone-conditions-2025-second-kind/README.md) (arXiv 2508.11226) and [new-rigidity-2025](../references/new-rigidity-2025-second-kind/README.md) (arXiv 2601.06556). Their engine, Lemma 3.2 of the first, bounds the Bochner cubic by the bottom partial sum $\lambda_1+\lambda_2$ of the second-kind spectrum against the Einstein constant $\bar\lambda$, and every term carries $\bar\lambda$, so at a Weyl tensor ($\bar\lambda=0$) it says nothing. *The mechanism, a partial sum at the bottom controlling a cubic, is the shape candidate 1 needs.*
- **Top $\Lambda^2$ eigenvalue of a Weyl tensor** (candidate 2): searched, nothing on bounding $p_3(\lambda)$ through the Ricci constraint $\sum\lambda_k\varphi_k^2=0$.
- **Candidate 3 screened out by the record.** R53's attempt 4 at a general diagonal part ([2026-09-28 sweep](2026-09-28-LIT-step8-sweep.md)) fails because the frame budgets of the modes touching a concentrated diagonal part sum to order $n\,t^2$, which against $b^2=1-t^2$ only gives $t\gtrsim n^{-1/2}$. At the new threshold, a constant $t$, the budgets still exceed $b^2$ once $n\gtrsim30$, so the threshold does not rescue the knapsack.

## Phase 3b

| route | closes | attackable | margin | analytic | value | reach toward P |
|---|---|---|---|---|---|---|
| maximality with the test direction $Z(h)$, $h$ the bottom eigenvector of $\mathring W$ | 3 | 2 | 1 | 1 | 6 | a relation between $\theta$ and $\mu$ at a global maximiser, toward target.md's branch 1, which with the frame cap closes (MG) at even $n$ |
| the $\Lambda^2$ loss through the Ricci constraint | 2 | 1 | 1 | 1 | 2 | a sharper $\theta^2\le\tfrac32+\theta E$, raising the threshold |
| R53's knapsack above the threshold | 2 | 0 | 1 | 1 | 0 | screened out |

**Pick: maximality with $Z(h)$.** It is the only candidate using information the $E$ route leaves unused (the Hessian at a global maximiser), its objects are all on file (the lift in [target.md](../findings/target.md), $Z(h)$ and its fourth-moment norm in [bispectral.md](../findings/bispectral.md)), and the threshold makes its pairing $\langle W,Z(h)\rangle=\mu/2$ bounded below at every candidate maximiser. *What would falsify it: the Hessian bound along $Z(h)$ holding with room at $\mathbb{CP}^m$-like points above $\sqrt{3/2}$, so that it carries no constraint.*

## The pick closes: maximality along $Z(h)$ is vacuous at small mass (derived)

- **$Z(h)$ is diagonal in $h$'s eigenframe.** With $h=\operatorname{diag}(d)$ in its eigenframe $F$ ($\sum d=0$, $\sum d^2=1$), $\Lambda^2h$ is the diagonal curvature tensor with sectional entries $d_id_j$, its Ricci contraction is $-\operatorname{diag}(d_i^2)$, and the Weyl projection subtracts Kulkarni–Nomizu products of diagonal tensors, so $Z(h)$ has entries $z_{ij}=d_id_j-\tfrac{d_i^2+d_j^2}{n-2}+\tfrac1{(n-1)(n-2)}$ and no others.
- **So the Hessian along it sees only $W$'s diagonal in $F$.** The sign group of $F$ fixes $Z$, so $Q(Z,Z)$ is diagonal in $F$ and $T(W,Z,Z)=\langle W,Q(Z,Z)\rangle=T(A_F,Z,Z)$, with $A_F$ the diagonal part of $W$ in $F$. In the NPW basis $\mathring Z$ is $z_{ab}$ on $\varphi_{ab}$ and $-Z_K$ on the diagonal, which gives $T(A_F,Z,Z)=\sum_{a<b}K_{ab}z_{ab}^2+\tfrac12\operatorname{tr}(KZ_K^2)$, of order $t_F\lVert Z\rVert^2$.
- **Maximality bounds it from above**, $T(W,Z,Z)\le\tfrac\theta2(\lVert Z\rVert^2+\tfrac{\mu^2}4)$, and a quantity of order $t_F$ satisfies that at small mass with room to spare. *At the balanced product $Z(h)$ is parallel to $W$ and the bound is an equality, which is why the direction looked promising.* **The Hessian is an upper bound on a cubic, so it constrains only directions where the cubic is large, and a direction built from a frame-diagonal object sees only the frame's diagonal.**

**Candidate 2 is the remaining route**, the $\Lambda^2$ loss $\theta p_3(\lambda)\le1$ ([L198](../findings/bounds.md)'s rows summed with weight $\lambda_k^2$), graded 2.

## Candidate 2 screened: the $\Lambda^2$ loss is where the $\mathbb{CP}^m$ live (derived)

- **The loss, written exactly.** Weighting [L198](../findings/bounds.md)'s rows by $\lambda_k^2$ gives $\theta p_3(\lambda)=p_4(\lambda)+\tfrac12S$ with $S=\sum c_{k\alpha\gamma}^2\lambda_k^2\lambda_\alpha\lambda_\gamma$, and $1-\theta p_3=\tfrac12\sum_k\lambda_k^2\delta_k$ with $\delta_k\ge0$ L198's row deficit. *This is a contraction of the rows, which the record already says is spectrally determined index by index; the content would be a bound on $S$.* Dropping the signs of $\lambda_\alpha\lambda_\gamma$ gives $\tfrac12S\le\tfrac12B$ with $B=\sum\lambda_k^2\lambda_\alpha^2\lVert[\varphi_k,\varphi_\alpha]\rVert^2=2\operatorname{tr}\big((W^2)^\#\big)$, and at padded $W_{\mathbb{CP}^2}$ that step loses everything ($S=0$, $B=1$).
- **What a sharper $p_3$ bound would have to beat.** $\theta=\tfrac32p_3(\lambda)+E$ is an identity, so the $E$ route's two losses are $p_3\le1/\theta$ and $E\le Ct_{\max}$ and nothing else. $\mathbb{CP}^6$ sits at $\tfrac32p_3=0.871$, $E=0.054$, $t_{\max}=0.46$. **So a bound on $p_3$ in terms of $t_{\max}$ that clears $\theta_0$ at $t_{\max}$ up to the $\mathbb{CP}^m$ scale must be sharp at the $\mathbb{CP}^m$ themselves**, and those points are cleared only by their value ([post F22](../findings/fence-posts.md), R6). *A stability version of L198's equality case (near-saturation forces a padded four-dimensional block and hence large frame mass) could still raise the threshold part of the way, but not past the $\mathbb{CP}^m$.*

**All three candidates are closed or screened.** Three closures on I121 since the last derivation commit; by the churn rule the next pick comes from a fresh sweep that questions the approach.
