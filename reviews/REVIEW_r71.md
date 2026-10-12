# Reviewer 71, Gate 2 on the ten unreviewed commits since 096a02d

Ran 2026-08-24, same brief as [Reviewer 72](REVIEW_r72.md), independently. Log `agent_logs/reviewer71.log`. Everything from its own implementation, importing nothing from `scripts/b_*.py`; repo scripts run only afterwards for comparison.

**Both reviewers reached the same verdict on every disputed claim.** Where they differ it is by R71 finding *more*.

| # | claim | verdict |
|---|---|---|
| 1 | $\lambda$-weighted identity and bound | **CONFIRMED**, all four parts |
| 2a | $q_2(W)=-2W$ | CONFIRMED, a two-line theorem, not a coincidence |
| 2b | Berger ratios | **WRONG**, and irreproducible |
| 2c | sectional range blind to $\lambda_{\min}$ | **CONFIRMED and strengthened** |
| 2d | the derived $|\lambda_{\min}|$ bound | derivation correct; numbers understated |
| 3 | $\lambda_{\max}\le(n-2)|\lambda_{\min}|$ | **CONFIRMED**; equality structural, not degeneracy |
| 4 | the $W_{\mathbb{CP}^2}$ filter | **LOGICALLY UNSOUND**, and the record contradicts itself |
| 5 | second-order screen | values confirmed; **three rows have no content** |
| 6 | the characterisation | **REFUTED** |
| 7 | $E(\tfrac12)$ not a discriminator | **CONFIRMED**, with a one-line proof |

## The refutation, reproduced with the repository's own code

| point | $n$ | crit. residual | $\lambda_{\max}(L_e|_{e^\perp})$ | $\#>\tfrac12$ |
|---|---|---|---|---|
| $\mathbb{HP}^2$ | 8 | $1.4\times10^{-15}$ | $0.50000000$ | **0** |
| $\mathbb{HP}^2$ padded | 10 | $1.4\times10^{-15}$ | $0.50000000$ | **0** |
| $\mathbb{HP}^2$ padded | 12 | $1.4\times10^{-15}$ | $0.50000000$ | **0** |

Padding preserves criticality because $(\mathrm{pad}\,W)^\#=\mathrm{pad}(W^\#)$: $WA_bW=0$ whenever $\phi_b$ leaves the padded block.

**And the restated conjecture fails either way it is read**, because padding acts *oppositely* on the two families:

| family | padded to | verdict |
|---|---|---|
| $\mathbb{CP}^2$ | $n=6,8,10,12$ | **saturates** $0.50000000$ |
| $\mathbb{HP}^2$ | $n=10,12$ | **saturates** $0.50000000$ |
| $S^3\times S^3$ | $n=8,10,12$ | violates $0.60000000$ |
| $S^3\times S^5$, $S^4\times S^4$ | $n=10,12$ | violates $0.57142857$ |
| $S^5\times S^5$ | $n=12$ | violates $0.55555556$ |

If padded points count as family members (and the record counts padded $W_{\mathbb{CP}^2}$) then padded $S^3\times S^5$ violates and "⇐" fails. If they do not, padded $\mathbb{HP}^2$ saturates outside the family at $n\ne8$ and "⇒" fails, with no triality escape.

## Triality, built explicitly

$\tau$ constructed as the spin representation on $\Delta_+=\mathbb O$ via octonion left multiplications, $\rho(\phi_{ij})=-\tfrac12L_{\bar e_i}L_{e_j}$; the $28\times28$ matrix is exactly orthogonal ($\lVert MM^\mathsf{T}-I\rVert=0$) and an anti-homomorphism, so $-M$ is a genuine automorphism of $\mathfrak{so}(8)$.

| invariant | $S^3\times S^5$ | $\tau(S^3\times S^5)$ | $\mathbb{HP}^2$ |
|---|---|---|---|
| sectional range | $[-0.159364,0.398410]$ | $[-0.089642,0.119523]$ | $[-0.089642,0.119523]$ |
| 4th moment of $K$ | $2.52\times10^{-5}$ | $1.21\times10^{-5}$ | $1.21\times10^{-5}$ |
| Casimir of top eigenspace on $\mathbb R^8$ | $(-2,-2,-2,0^5)$ | $(-\tfrac34)^{\times8}$ | $(-\tfrac34)^{\times8}$ |

The last row is an $O(8)$ invariant and settles it: $S^3\times S^5$'s top eigenspace is $\mathfrak{so}(3)$ acting as $\mathbb R^3\oplus5\mathbb R$, $\mathbb{HP}^2$'s is $\mathfrak{sp}(1)$ acting isotypically, different $O(8)$ orbits, with $\tau(S^3\times S^5)$ in $\mathbb{HP}^2$'s.

## Berger, irreproducible, not merely wrong

Exact ratios by direct optimisation (30–50 L-BFGS restarts; for diagonal operators the exact fact $K_{\max}/K_{\min}=\max/\min$ diagonal entry): **exactly $1.0000$** at $\mathbb{CP}^{2,3,4,5}$, **exactly $0.7500$** at $S^3\times S^3$, $S^6\times S^6$ and the $C_5$ blow-up. Berger is *tight* at every $\mathbb{CP}^m$ (the classical extremiser of the $2/3$ constant) and $0.75$ is the plain polarisation value $\tfrac12(K_{\max}-K_{\min})$ elsewhere. The true contrast is $0.75$ vs $1.00$, far narrower than recorded.

**Worse: the quoted numbers are not reproducible by their own script.** It seeded from `abs(hash(lbl))`, and CPython salts `hash` per process. Two runs gave $\mathbb{CP}^3=0.945$ then $0.871$; $C_5=0.524$ then $0.335$. The $0.970/0.858$ came from a third, unrecoverable run. *Fixed 2026-08-24: the scripts now seed from `zlib.crc32`.*

**Sampling bias runs one way in every use**, so every *conclusion* survives while every *number* is soft: the violation test's RHS is understated (a pass is genuine), the tightness ratio is depressed (so the record understates how tight Berger is), and the fence-post-21 shortfall is understated.

## Strengthenings

- **$|\lambda_{\min}|/|K_{\min}|=\tfrac{2(m+1)}3=\tfrac{n+2}3$ exactly at $\mathbb{CP}^m$**, $2.000,2.667,3.333,4.000$ at $m=2..5$. The recorded $2.7$ and $3.3$ are right; the **linear growth in $n$** is the stronger statement and was not recorded.
- **Fence post F21's shortfall is $2.47$–$9.86\times$**, not $2.5$–$7.8$, and grows exactly within families: sphere products $3.73\to14.59$ at $n=6\to20$; $\mathbb{CP}^{n/2}$ $2.47\to8.66$ at $n=6\to16$.
- **$\lambda_{\max}\le(n-2)|\lambda_{\min}|$ has equality at every $\mathbb{CP}^m$**, $m=2..6$, and it is structural: the top eigenvector's entire $R$-row of mass $2(n-2)$ sits on $E(\lambda_{\min})$, exactly zero on $\mathfrak p$ and on $\ker$. *But "strictly below 1 everywhere else" rests on nine points*, maximising the ratio over $\mathrm{Weyl}_6$ and $\mathrm{Weyl}_8$ (40 restarts) gives best non-Kähler $0.99906$ at $n=6$. No counterexample, but untested rather than proved.
- **The row marginal $\sum_\beta R_{\alpha\beta}=2(n-2)$ is a theorem**, not a measurement: $-\mathrm{tr}(\mathrm{ad}\,v_\alpha)^2=-(n-2)\mathrm{tr}(v_\alpha^2)=2(n-2)$.
- **Excess $\ge0$ has a one-line proof.** Differentiating $Q(W_t)=\theta W_t$ along an orbit gives $e\circ\dot W=\tfrac12\dot W$: **every orbit tangent lies in $E(\tfrac12)$**. So the excess is exactly "$\tfrac12$-eigenvectors beyond the symmetry directions".

## The filter, unsound, and self-contradicting

The six rows are *one tautology* ($\theta=\sqrt{3/2}$ is $W_{\mathbb{CP}^2}$'s value by definition), *one shared with six other points* (Lemma L24 is exactly $0.500000$ at $S^3\times S^3$, $S^4\times S^4$, $S^3\times S^5$, $S^5\times S^5$, $[4,4]$, $[3,5]$ too), *one about the wrong points* (Berger at $\mathbb{CP}^{3,4}$, not $\mathbb{CP}^2$), *one embedding-dependent* (fails at padded $W_{\mathbb{CP}^2}$, ratio $0.3333$), *one vacuous theorem* (Ge's), and *one category error* ($\ker W=0$ failing is being outside a hypothesis, not a bound being tight).

**The inference does not follow**: $\dim\mathfrak m=2$ at $\mathbb{CP}^2$ and at every padding, so it is outside the band, and a bound tight off a set can be strict on it. **Counterexample, from the record's own row 1:** "$\theta\le\sqrt{3/2}$ on the band" is tight at $W_{\mathbb{CP}^2}$ and separates the band by definition, taken literally the filter rejects the theorem the programme is proving. **Second:** Lemma L24 is exactly tight there and nevertheless excludes $\mathbb{CP}^{m\ge3}$, $S^2\times S^{n-2}$, the $C_5$ blow-up and every $\ge3$-block product.

**And the record contradicts itself**: [plan.md](../plan.md) says the second-order condition "cannot separate either"; [b_second_order_screen.py](../scripts/b_second_order_screen.py), written six minutes later, says it "PASSES that filter" and justifies it as "strictly slack away from $W_{\mathbb{CP}^2}$", refuted by the table printed directly above it.

## Defects in the second-order screen

1. **Three of nine falsification rows are at non-critical operators**, residuals $0.22$, $0.17$, $0.11$. There $e$ is not idempotent, $\lVert L_ee-e\rVert=0.27,0.21,0.13$, the top eigenvalue is not "$e$ itself", and Lemma L24 has no content. Honest restriction to $e^\perp$ gives $0.786$, $0.943$, $0.960$, **not** the recorded $1.179$, $1.132$, $1.112$.
2. **The strip rule keeps $e$'s eigenvalue whenever $\lambda_{\max}>1$.** $C_5$'s "30" is 29.
3. **The docstring contradicts its own script**: $\mathbb{CP}^3$/$\mathbb{CP}^4$ counts $9$/$16$ against $8$/$15$, the record wrote $m^2$ where the truth is $m^2-1$.
4. **"$[3,3,3]$ and $[4,4,4]$ fail simplicity rather than the bound" is wrong**, an eigenvalue at $1$ off $e$ violates $\sigma\subseteq(-\infty,\tfrac12]$ too. They fail both clauses.

## Falsification attack, nothing else saturates

All exactly critical, all violating: $\mathbb{HP}^3$, $\mathrm{Gr}_{\mathbb C}(2,3)$, $\mathrm{Gr}_{\mathbb R}(3,4)$, $\mathrm{Gr}_{\mathbb R}(2,6)$, $SO(8)/U(4)$, $Sp(3)/U(3)$ ($n=12$); $\mathrm{Gr}_{\mathbb R}(2,3)$, $SO(6)/U(3)$, $Sp(2)/U(2)$ ($n=6$); $\mathrm{Gr}_{\mathbb R}(3,3)$, $SU(4)/SO(4)$ ($n=9$); $\mathrm{Gr}_{\mathbb R}(2,5)$, $\mathbb{CP}^5$ ($n=10$); $SU(3)/SO(3)$ ($n=5$); $\mathrm{Gr}_{\mathbb C}(2,2)$, $\mathfrak{su}(3)$ bi-invariant, $\mathrm{Gr}_{\mathbb R}(2,4)$ ($n=8$). **8-cycle circulants:** criticality re-solved from scratch, recovering 14 points including $\theta=0.555683$ and $0.082270$, which violate at $1.381$ and $8.041$; the only saturating circulant is $\theta_0(8)=1.145644$, i.e. $S^4\times S^4$.

## Also found

- **$S^2\times S^6$ and $\mathbb{CP}^4$ are the same point** under triality (identical spectra, $\theta=0.986013$, $L_e$ top $0.60000000$), already at [findings/INDEX.md](../findings/INDEX.md) line 654. So the $\ge3$-block table lists $[2,6]$ as an independent falsification row when it is $\mathbb{CP}^4$ again.
- **The random rows of the second-order table are meaningless**, random Weyl tensors are not critical, and $\theta\approx0.016$ makes $e=W/\theta$ enormous.
- **`sphere_product_W` is Ricci-flat exactly at two blocks**: at $[2,2,2]$ the unit-normalised operator has Ricci residual $0.41$ and trace $1.2$.
