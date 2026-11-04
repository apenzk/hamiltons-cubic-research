# Step 9 position, 2026-09-27b: after the torus family closed, U$_{\mathrm s}'$ off it

**Entered because R47 is done and the graded top has no method for what is left.** J1 holds on the whole torus slice of $\mathfrak{so}(2m)$ at $m\ge6$ ([L274](../findings/second-order.md) to [L276](../findings/second-order.md), with $m=6$ resting on one certificate step, [working note](2026-09-27-I117-J1.md) batch 13), so H holds at every torus-invariant point and U$_{\mathrm s}'$ holds on the torus family at $2m\ge12$. [I117](../plan.md) still needs U$_{\mathrm s}'$ for every stable positive-definite $\#$-idempotent on every compact simple $\mathfrak h\subseteq\mathfrak{so}(n)$ ([L270](../findings/second-order.md) (3)), and [I73](../plan.md) (grade $3$) stands on it through I114.

## What previous sweeps covered

[26](2026-09-26-LIT-step8-sweep.md) (moment maps, bracket-mass bounds, Hamilton's ODE, idempotents, great circles), [26d](2026-09-26d-LIT-step8-sweep.md) (idempotent norms in metrised algebras, cubic Weyl invariants, spinor traces), [26e](2026-09-26e-LIT-step8-sweep.md) (partial-transpose moments), [27](2026-09-27-LIT-step8-sweep.md) (homogeneous Einstein metrics' variational side, Koiso's Casimir method, nonlinear Perron–Frobenius). None reduces an invariant of $\mathop{\mathrm{Sym}}^2\mathfrak g$ to the torus slice.

## The objects this sweep adds

- **The walk machinery of J1** ([L274](../findings/second-order.md) to [L276](../findings/second-order.md)): a row Cauchy–Schwarz on the structure constants, a pairing, a reversible walk on the eigenbasis with a row chord in $\sum_jq_j^2$, a weighted column Cauchy–Schwarz and an inequality on the stationary law alone. Its inputs are a basis in which the structure-constant tensor $T_{abc}=\langle[e_a,e_b],e_c\rangle^2$ has the root system's triangle pattern.
- **H in eigenbasis form**: for $X=\sum_a\lambda_ae_a\otimes e_a$, $\langle X\#X,X\rangle=\sum_{abc}\lambda_a\lambda_b\lambda_cT_{abc}$, with row sums $\sum_{bc}T_{abc}=c$ for every orthonormal basis. H is the bound $(c/\sqrt N)\lVert\lambda\rVert^3$ over all orthonormal bases.

## Fence posts bearing

[F80](../findings/fence-posts.md) (U from $C\#C=C$ and $C\succ0$ alone is false). F76 to F79 bear on I73 only.

## Live items and grades

I73 $3$, I36 $3$ (stands on I73), I117 $2$, I115 $2$, the other section 1 items at $2$, each `attackable` $1$.

## The questions for the sweep

1. Is the $SO(n)$-action on $\mathop{\mathrm{Sym}}^2\mathfrak{so}(n)$, or on its Weyl part, polar, so that an invariant function's critical points can be conjugated into a section? The torus slice is the zero-weight space; a section would contain it.
2. Is there a symmetrisation (averaging over a torus, a Steiner-type move) that does not decrease $\langle X\#X,X\rangle/\lVert X\rVert^3$?
3. Does J1's walk machinery apply to the root-adapted bases of the other simple algebras ($\mathfrak{su}(k)$, $\mathfrak{sp}(k)$, the exceptional ones), giving U$_{\mathrm s}'$ on their torus families?
4. For a fixed spectrum $\lambda$, is $\max$ over orthonormal bases of $\sum\lambda_a\lambda_b\lambda_cT_{abc}$ attained at a root-adapted basis (a Schur–Horn or Kostant-type statement for this cubic)?
