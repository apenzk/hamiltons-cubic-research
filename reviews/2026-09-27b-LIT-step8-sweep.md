# Step 9 literature sweep, 2026-09-27b: U$_{\mathrm s}'$ off the torus family

Works from [the position file](2026-09-27b-step8-position.md).

## Batch 1: can an invariant of $\mathop{\mathrm{Sym}}^2\mathfrak{so}(n)$ be conjugated into the torus slice?

**No section exists, so no reduction of that kind.** *A representation of a compact group is polar exactly when it is orbit-equivalent to an s-representation (Dadok's classification, stated in [Kollross, polar actions on symmetric spaces](https://arxiv.org/abs/math/0506312) and [Gorodski–Kollross, representations of low copolarity](https://arxiv.org/abs/2106.00458) for the statement and its context). An irreducible s-representation on $\mathbb R^D$ has rank $r$ with $D\ge r(r+1)/2$, so $r\le\sqrt{2D}$, while the $SO(n)$-orbits on the Weyl module have codimension at least $D-\dim SO(n)$, with $D=n(n+1)(n+2)(n-3)/12$. For $n\ge5$ that codimension exceeds $\sqrt{2D}$, so the Weyl module is not polar and has no section containing the torus slice.* **So H off the torus slice needs an argument about the maximiser, not about the orbit space.** *This is an argument from a cited classification, checked here only by the dimension count.*

## Batch 2: what the torus result leaves, in the record's own objects

- **U$_{\mathrm s}'$ is asked on every compact simple $\mathfrak h\subseteq\mathfrak{so}(n)$** ([L270](../findings/second-order.md) (3), through [L256](../findings/second-order.md) and [L260](../findings/second-order.md)), and at $n=12$ these include $\mathfrak{so}(k)$, $k\le12$, $\mathfrak{su}(k)$, $k\le6$, $\mathfrak{sp}(k)$, $k\le3$, and $\mathfrak g_2$. R47 covered only $\mathfrak h=\mathfrak{so}(2m)$ at torus-invariant idempotents.
- **Stable idempotents need not be torus-invariant**: [L263](../findings/second-order.md)'s $\mathfrak g_2$ idempotent on $\mathfrak{so}(7)$ is invariant under $G_2$'s rank-two torus only. It is heavy and harmless to H ([L270](../findings/second-order.md)), but it shows that torus invariance is not automatic.
- **J1's machinery uses one property of the root-adapted basis**: every nonzero structure constant closes a triangle of roots, which gives the row Cauchy–Schwarz its $n=m-1$ slots and the walk its reversibility. Every compact simple algebra has such a basis (a Chevalley basis made real), with its own triangle pattern.

## Phase 3: routes

| route | closes | attackable | margin | analytic | value | reach toward the open statement |
|---|---|---|---|---|---|---|
| **R48, U$_{\mathrm s}'$ on the torus family of every compact simple $\mathfrak h$** by J1's walk machinery on its root triangles | 1 | **3** | 1 | 1 | **3** | U$_{\mathrm s}'$ at every torus-invariant idempotent of every simple $\mathfrak h\subseteq\mathfrak{so}(n)$. Leaves the non-invariant ones |
| R49, a stable idempotent is invariant under a maximal torus of its own simple algebra | 2 | 1 | 1 | 1 | 2 | with R48, all of U$_{\mathrm s}'$ and so H. No method: L263 shows invariance fails for some idempotents, so stability has to force it |
| R50, for a fixed spectrum, the cubic $\sum\lambda_a\lambda_b\lambda_cT_{abc}$ is largest at a root-adapted basis (a Schur–Horn statement for this cubic) | 2 | 1 | 1 | 1 | 2 | H directly, bypassing idempotents. No method, and no analogue found in the convexity literature for cubic forms |
| [R44](../routes.md), U$_{\mathrm s}$ in general | 2 | 1 | 1 | 1 | 2 | as before |

**No route reaches the open statement with a method, and the reach gate does not fire.** **Pick: R48**, the only route with a live method, which extends L274 to L276 to the remaining torus families. **R49 is its fallback and the route that would finish I117**, recorded with the obstacle that stability, not the idempotent equation, has to force the torus.
