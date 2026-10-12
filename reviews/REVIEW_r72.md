# Reviewer 72, Gate 2 on the ten unreviewed commits since 096a02d

Ran 2026-08-24. Log `agent_logs/reviewer72.log`. Core written from the definitions and cross-validated against [review_r30_core.py](../scripts/review_r30_core.py) ($\theta$ agrees to $4\times10^{-18}$). Every model point rebuilt from geometry, sphere products as the Weyl projection of a product of round spheres, $\mathbb{CP}^m$ and $\mathbb{HP}^m$ from space-form curvature tensors, $\mathrm{Gr}_{\mathbb C}(p,q)$ and the $\mathfrak{su}(3)$ bi-invariant from $R(X,Y,Z,W)=\langle[X,Y],[Z,W]\rangle$.

| # | claim | verdict |
|---|---|---|
| 1 | $\lambda$-weighted identity and bound | **CONFIRMED** |
| 2a | Ge's $q_2(W)=-2W$ | CONFIRMED (definitional, not a measurement) |
| 2b | Berger never violated / near-tight ratios | inequality CONFIRMED; **the ratios are WRONG** |
| 2c | sectional range blind to $\lambda_{\min}$ at Kähler points | **CONFIRMED** |
| 2d | $|\lambda_{\min}|\le|K_{\min}|+\tfrac23(K_{\max}-K_{\min})(r-1)$ | derivation CONFIRMED; conclusion **strengthened** |
| 3 | per-row identity, $\lambda_{\max}\le(n-2)|\lambda_{\min}|$ | **CONFIRMED and extended** |
| 4 | the $W_{\mathbb{CP}^2}$ filter | **REFUTED as a principle**; the six-row table OVERSTATED |
| 5 | second-order screen | values CONFIRMED; **counts WRONG**; three rows at **non-critical** points |
| 6 | $\mathbb{HP}^2$ / triality / restated characterisation | triality CONFIRMED; **conjecture REFUTED at $n=10$ and $n=12$** |
| 7 | $E(\tfrac12)$ multiplicity not a discriminator | **CONFIRMED** |

## The load-bearing refutation

**"$\mathbb{HP}^2$ padded to $n=10$ violates at $1.0172$" is false.** Cross-checked against the repository's own [review_r34_core.py](../scripts/review_r34_core.py) `Le_matrix`:

| point | $n$ | $\theta$ | criticality | $\lambda_{\max}|_{e^\perp}$ | $\#>\tfrac12$ |
|---|---|---|---|---|---|
| $\mathbb{HP}^2$ padded | **10** | $1.11554670$ | $1.4\times10^{-15}$ | $\mathbf{0.50000000}$ | $\mathbf{0}$ |
| $\mathbb{HP}^2$ padded | **12** | $1.11554670$ | $1.4\times10^{-15}$ | $\mathbf{0.50000000}$ | $\mathbf{0}$ |
| $S^3\times S^5$ padded | 10 | $1.11554670$ | $1.6\times10^{-15}$ | $0.57142857$ | 3 |
| $S^3\times S^5$ padded | 12 | $1.11554670$ | $1.6\times10^{-15}$ | $0.57142857$ | 10 |

No two-block product at $n=10$ or $12$ has $\theta=1.115547$. So padded $\mathbb{HP}^2$ is a critical point at $n\ne8$, outside the named families, saturating with $1$ simple, **the record's own stated falsifier, met, at two dimensions inside Conjecture A's range**. The number $1.0172$ appears in no script; $1.017217$ appears in [findings/INDEX.md](../findings/INDEX.md) as an unrelated regional cap.

**And the reverse fails too.** Padded two-block sphere products (the conjecture's own family), violate at exactly $\tfrac12+\tfrac1{2(n-3)}$: $0.6$ for $S^3\times S^3$ at $n=8$, $4/7$ for $S^3\times S^5$ and $S^4\times S^4$ at $n=10$. Padding is neutral for $\mathbb{CP}^2$ and $\mathbb{HP}^2$ and **not neutral** for the sphere products.

**Triality confirmed by a stronger test than the record ran.** $\theta(\mathbb{HP}^2)=\theta(S^3\times S^5)=1.11554670204543$, difference $2.2\times10^{-16}$; identical spectra with multiplicities, identical orbit dimension 15 and isotropy dimension 13. But the isotropy algebras act *inequivalently* on $\mathbb R^8$: symmetric matrices commuting with $\mathfrak k(W)$ have dimension **2** for $S^3\times S^5$ (reducible $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$) and **1** for $\mathbb{HP}^2$ (irreducible $\mathfrak{sp}(2)\oplus\mathfrak{sp}(1)$). Same invariants, inequivalent actions, so not the same $O(8)$-orbit, and the outer automorphism is the only available relation.

## Berger: exactly tight, and the recorded ratios are sampling artefacts

Replacing sampling with L-BFGS over the Grassmannian and over orthonormal four-frames (25 restarts, both signs):

| point | $n$ | $K_{\min}$ | $K_{\max}$ | $\max|R_{1234}|$ | Berger RHS | ratio | record |
|---|---|---|---|---|---|---|---|
| $\mathbb{CP}^2$ | 4 | $-0.20412$ | $0.40825$ | $0.408248$ | $0.40825$ | **1.000** | untested |
| $\mathbb{CP}^3$ | 6 | $-0.07906$ | $0.31623$ | $0.263523$ | $0.26352$ | **1.000** | $0.970$ |
| $\mathbb{CP}^4$ | 8 | $-0.04226$ | $0.25355$ | $0.197203$ | $0.19720$ | **1.000** | $0.858$ |
| $\mathbb{HP}^2$ | 8 | $-0.08964$ | $0.11952$ | $0.139443$ | $0.13944$ | **1.000** | untested |
| $S^3\times S^3$ | 6 | $-0.21082$ | $0.31623$ | $0.263523$ | $0.35136$ | **0.750** | "0.45–0.72" |
| $S^6\times S^6$ | 12 | $-0.11237$ | $0.13484$ | $0.123603$ | $0.16480$ | **0.750** | "0.45–0.72" |
| $C_5$ blow-up | 10 | $-0.14907$ | $0.29814$ | $0.223607$ | $0.29814$ | **0.750** | "0.45–0.72" |

Equality is analytic at $\mathbb{CP}^m$: with FS holomorphic curvature 4 the Weyl part has sectional range of width exactly 3, and $R(e_1,Je_1,e_3,Je_3)=2=\tfrac23\cdot3$. **The bias runs both ways**, the script's docstring claims sampling understates only the RHS, but it understates the LHS too, so the ratio column is biased in an uncontrolled direction.

With exact ranges the fence-post-21 shortfall factors are **larger** than recorded ($\mathbb{CP}^3$ 2.5, $\mathbb{CP}^4$ 3.6, $S^6\times S^6$ 8.4, $C_5$ 9.9), so the dead-end is strengthened. But "**the factor grows with $n$**" is overstated as a general claim: $C_5$ at $n=10$ gives 9.9, above $S^6\times S^6$ at $n=12$.

## The filter fails as a principle, three independent reasons

1. **It rejects the target.** Any *sharp* proof of $\theta\le\sqrt{3/2}$ must be tight where $\theta=\sqrt{3/2}$. Tightness at $W_{\mathbb{CP}^2}$ is the signature of a sharp proof, not a spent one. The filter can validly assert only that such a bound cannot prove the *strict* inequality.
2. **$W_{\mathbb{CP}^2}$ is not in the band.** Its spectrum is $(-0.408248^{\times2},0^{\times3},0.816497)$, so $\dim\mathfrak m=2$ at every padding, outside $\{S=0,\ 3\le\dim\mathfrak m<\lfloor n^2/4\rfloor\}$. *Counterexample shape:* any bound $\theta\le\sqrt{3/2}\cdot f(\dim\mathfrak m)$ with $f(2)=1$, $f(k)<1$ for $k\ge3$ is tight there and separates the band.
3. **The programme does not apply it to itself.** The $\lambda$-weighted bound of claim 1 is tight at $W_{\mathbb{CP}^2}$ to $2.2\times10^{-16}$. Applied consistently the filter discards this cycle's own headline bound.

**The six-row table is really three rows, one circular.** $\theta=\sqrt{3/2}$ is circular ($\sqrt{3/2}$ *is* $W_{\mathbb{CP}^2}$'s value); the Berger row quotes values at two *other* points under a "value at $W_{\mathbb{CP}^2}$" header; Ge's estimate is recorded by the project's own notes as vacuous on $\mathrm{Weyl}_n$; and "$\ker W=0$ fails there" is a hypothesis failing, the opposite of a condition being tight.

## The second-order screen: right values, wrong counts, three invalid rows

Counts inflated by exactly one wherever $\lambda_{\max}(L_e)>1$, the strip rule drops `ev[-1]` only when it is within $10^{-7}$ of 1, so $e$'s own eigenvalue stays in. True counts: $C_5$ **29**, random **37**/**147**, $\mathbb{CP}^3$ **8**, $\mathbb{CP}^4$ **15**. *The record carries 8/15 and 9/16 for the same two points nine lines apart.*

**The $\ge3$-block rows are computed at non-critical points.** `product_weyl` builds equal-radius products, which are Einstein only at equal block dimensions:

| blocks | equal radii: $\theta$, crit residual | Einstein radii: $\theta$, residual |
|---|---|---|
| $[2,2,4]$ | $0.810126$, $\mathbf{2.2\times10^{-1}}$ | $0.690849$, $8.7\times10^{-16}$ |
| $[2,3,3]$ | $0.790077$, $\mathbf{1.7\times10^{-1}}$ | $0.720082$, $1.1\times10^{-15}$ |
| $[3,3,4]$ | $0.809574$, $\mathbf{1.1\times10^{-1}}$ | $0.787839$, $1.9\times10^{-15}$ |

At the genuinely critical versions all three sit at **exactly $1.00000000$**, failing *simplicity*, so the record's structural story puts $[2,2,4]$ and $[2,3,3]$ in the wrong bucket. The conclusion survives; the mechanism was mis-assigned.

## Other candidates tested, none saturating

All critical to $\le3\times10^{-15}$: $\mathbb{HP}^3$ at $n=12\to0.70000000$ (14 above); $\mathrm{Gr}_{\mathbb C}(2,3)$ at $n=12\to1.00000000$ (35 above, fails simplicity); $\mathrm{Gr}_{\mathbb C}(2,2)$ at $n=8\to1.00000000$; $\mathfrak{su}(3)$ bi-invariant $\to0.75000000$, reproducing Observation L25's $3/4$; the two 8-cycle circulants at $\theta=0.555683$ and $0.082270$ violate at $1.38065273$ and $8.04127213$. Among the saved `.npy` witnesses, `review_r61_best_stratum_*` are **not critical** (residual 0.3 and 1.2), so Lemma L24 does not apply to them either.

## Also found

- **There is no criticality screen.** [weyl_screen.py](../scripts/weyl_screen.py) exists because agents read $\theta$ off non-Weyl operators; the same failure has now happened one level up, with Lemma L24 read off non-critical operators. `second_order` should refuse unless $\lVert Q(W)-\theta W\rVert<\mathrm{tol}$.
- **"Product of round spheres" is ambiguous at $\ge3$ blocks.** Equal radii is non-Einstein for unequal blocks; Einstein radii give different $\theta$ ($0.690849$ vs $0.810126$ at $[2,2,4]$). Two blocks is safe because the invariant Weyl space is one-dimensional there, which is also why the closed formula works at two blocks and no more.
- **A second exact $\theta$-coincidence at $n=8$**: $\mathrm{Gr}_{\mathbb C}(2,2)$ and the Einstein $S^2\times S^3\times S^3$ both give $0.7200822998230956/8$, with identical spectra. May share the triality origin.
- **$\lambda_{\max}\le(n-2)|\lambda_{\min}|$ is not padding-invariant**, padded $W_{\mathbb{CP}^2}$ at $n=8$ gives ratio $0.333$, not 1. "Sharp at $\mathbb{CP}^m$" means sharp at $n=2m$ only.
