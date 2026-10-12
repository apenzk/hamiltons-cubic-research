# Step 9 sweep, 2026-09-28k: a route for I73's asymmetric spectra and case (b)

*Position file: [2026-09-28k-step8-position.md](2026-09-28k-step8-position.md).*

## Batch 1: the manager's angle, and the margin (c) must clear (derived)

- **The unbalanced products are asymmetric three-value critical points just below $\theta_0$.** $S^p\times S^q$ with $p\ne q$ has three eigenvalues (inside each factor and across) with unequal multiplicities, and [L232](../findings/diagonal-half.md) gives $\theta_{p,q}^2=\frac{2(n-1)(p-1)(q-1)}{(n-2)pq}$. At $n=2m$ and $(p,q)=(m-1,m+1)$, $$\frac{\theta_{m-1,m+1}^2}{\theta_0(n)^2}=\frac{m^3(m-2)}{(m-1)^3(m+1)}=1-\frac2{m^3}+O(m^{-4}),$$ the $m^{-1}$ and $m^{-2}$ terms cancelling. At $n=12$ this is $S^5\times S^7$ at $1.22824$ against $1.23603$ ([W7](../findings/INDEX-traps.md)). **So any argument placing three-value critical points below $\theta_0$ must lose less than a relative $n^{-3}$ on the unbalanced products.**
- **The manager's angle cannot do that.** L50 writes $\theta=\tfrac32p_3(\lambda)+E$. The first term's maximum over unit traceless spectra sits at a two-value spectrum, so it separates nothing, and the bounds on $E$ (SecondKindE's $C_nt_{\max}$, trace positivity's $\tfrac32\mu$) are frame and second-kind quantities that never read the number of values of $\lambda$ and lose a factor of order one at the products ($E/t_{\max}\approx\theta_0$ at the balanced product against $C_n\to2.12$). **Closed.**
- **What reads the value exactly on the products is the diagonal theorem.** [L57](../findings/problem.md) gives $P\le\Theta_n$ on diagonal $W$, equality only at the balanced product, and it is exact on every $S^p\times S^q$. **So a route for (c) at even $n$ is "a three-value critical point above $\theta_0$ is diagonal in some frame", which is [I36](../plan.md)'s first link ([I75](../plan.md)), whose remaining content is $s\le2$, that is I73 itself.** The reduction is circular.

## Batch 2: case (b) (record)

- [F39](../findings/fence-posts.md)'s saddle has its ascent direction outside every eigenspace-pair span, and [27c](2026-09-27c-LIT-step8-sweep.md)'s fixed-point splittings ([R51](../routes.md)) are the only global comparison on file. Nothing in batch 1 bears on it.

## Phase 3b

| route | closes | attackable | margin | analytic | value | how close to P |
|---|---|---|---|---|---|---|
| L50 with SecondKindE on the spectrum count | 3 | 0 | 0 | 1 | **0** | loses order one where (c) needs $n^{-3}$ |
| diagonality of three-value critical points above $\theta_0$ | 3 | 0 | 1 | 1 | **0** | circular, it is I75 and so I73 |
| R51's fixed-point comparisons at a three-value point | 2 | 1 | 1 | 1 | **2** | (b) at best, a lemma with no path ([27c](2026-09-27c-LIT-step8-sweep.md)) |

**No route for I73 from this sweep.** *Every candidate either loses a factor the unbalanced products forbid or reduces to diagonality at the maximiser, which is the open statement in its other forms.*
