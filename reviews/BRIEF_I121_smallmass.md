# Gate 2 brief, the small-mass node of (MG): the threshold form, the pair identity and its bound, for I121

**Cold brief. The claims are quoted verbatim from [reviews/2026-09-28b-LIT-step8-sweep.md](2026-09-28b-LIT-step8-sweep.md) and [reviews/2026-09-28b-step8-position.md](2026-09-28b-step8-position.md) as they stand at dispatch. You are asked to break them.** Verdicts per claim: CONFIRMED, PLAUSIBLE or REFUTED with corrections. **Analysis-only footing**: argue from the definitions, reading the written chain link by link; compute only to refute or to check a value, the smallest computation that does it, saying why an argument could not (numpy is available under `sage -python`). A run of a few minutes on objects you construct is allowed; no sweeps, censuses or open-ended searches. **The screens quoted in the claims are screens, not evidence for a positive claim**; check that the text never uses them as more.

## Definitions

- $\mathcal W_n$: algebraic Weyl tensors as symmetric operators on $\Lambda^2\mathbb R^n$, Hilbert–Schmidt inner product. $Q(R)=R^2+R^\#$, $P(W)=\langle Q(W),W\rangle$, $T(X,Y,Z)=\langle Q(X,Y),Z\rangle$ the totally symmetric trilinear form, $L_XY=Q(X,Y)$. A unit critical point has $Q(W)=\rho W$; $\Theta_n=\max P$ on the unit sphere; $\theta_0(n)$ the balanced product's value.
- In an orthonormal frame: $A$ the diagonal part, $B_p$ the pair part (entries $W(e_i\wedge e_k,e_j\wedge e_k)$), $B_f$ the four-set part (entries with four distinct indices), $t=\lVert A\rVert$. The **maximal frame** maximises $t$ over $O(n)$. **(MG)**: $\rho\le\max\{\sqrt{3/2},P(A)/\lVert A\rVert^3\}$ there.

## Givens

- **[L120](../findings/second-order.md)** (Lean): $\mathcal W_n$ splits into the sign-character summands (diagonal, pair blocks, four-set blocks), $L_M$ preserves each at diagonal $M$, and $Q$ is equivariant, so $T(X,Y,Z)=0$ unless the characters of $X,Y,Z$ multiply to the trivial one.
- **The one-plane bound** (Gate 2, [r1797](REVIEW_r1797.md), [r1798](REVIEW_r1798.md)): in a globally maximal frame, each pair block satisfies $\lVert B_{ij}\rVert^2\le\tfrac12\sum_k(a_{ik}-a_{jk})^2$.
- **The forced sum** (derived in the first sweep, screened): $\sum_{j<k}\lVert\hat\delta^{jk}\rVert^2=\tfrac{n-1}2$ for a unit diagonal Weyl operator, $\hat\delta^{jk}_i=\tfrac12(\hat a_{ji}-\hat a_{ki})$.
- **[L218](../findings/second-order.md)** (Gate 2): $\sup\langle L_d\nu,\nu\rangle=\tfrac{\sqrt3}2$ over unit diagonal $d$ and unit $\nu\perp\mathcal D_n$.
- **[L57](../findings/problem.md)**: $P(A)\le\theta_0(n)\lVert A\rVert^3$ for diagonal $A$ at even $n$.
- **Banach's theorem** (1938; Kellogg 1928 in finite dimension): on a real Hilbert space the norm of a symmetric multilinear form equals the supremum of its polynomial on the unit sphere. *Check the statement and its hypotheses where the claims use it.*
- The catalogue values the claims quote ($\mathbb{CP}^m$, $\mathbb{HP}^m$, symmetric spaces) are in [findings/INDEX-values.md](../findings/INDEX-values.md).

## The claims

### From the position file

## Screened already, dead

- **Averaging identities.** Writing $P$ as an average over frames of a diagonal cubic, or over 3-planes as in [L118](../findings/curvature-invariants.md) ($144\theta=\mathbb E[N^3]+10\,\mathbb E[NNN]$), bounds $t^3\ge P/K$ with $K$ the cubic's maximum on unit arguments. At the balanced product each random frame or 3-plane sees $O(1/n)$ of the curvature, so $K$ grows like $n^3$ and the bound is $t\gtrsim n^{-1}$, Schur's order. *This is [R24](../routes.md)'s successor criterion: an average cannot beat an average.*
- **Sectional-curvature moments.** $\lvert K\rvert\le t$ in L118's moments gives $\theta\lesssim n^6t^3/c_n$ with $c_n\sim n^6/144$, the same order.

### From the sweep

## Batch 1, the record

- **Small diagonal mass does not force small value, so a bound must have threshold form.** $\mathbb{CP}^m$ is a critical family with maximal-frame diagonal mass $\kappa^2=\tfrac3{m+1}\to0$ while $\theta(\mathbb{CP}^m)$ stays bounded below ($1.054,\,0.986,\,0.949$ at $m=3,4,5$), which [INDEX-values.md](../findings/INDEX-values.md) records as refuting "large $\theta$ forces near-diagonality". **So no bound $P\le F(t)$ with $F(t)\to0$ exists, and what can hold is: $\theta>\sqrt{3/2}$ forces $t\ge t_0$**, which is (MG)'s dichotomy.
- **The natural far-from-diagonal families sit at or below $\sqrt{3/2}$.** $\sqrt{3/2}$ is proved to be the maximum over every compact irreducible symmetric space, the quaternionic family is closed in form and decreasing ($\sup\sqrt{56/45}$), and the highest non-diagonal $\{S=0,\Delta>0\}$ point on record is $1.088948$ ([INDEX-values.md](../findings/INDEX-values.md)).
- **The record's support line stops at the node's edge.** [L220](../findings/second-order.md): a critical point in $\mathcal D_n\oplus V_Q$ with a four-set component has $\theta\le\sqrt{3/2}$. [L221](../findings/second-order.md): the same on disjoint four-set families, and $\theta^2\le\tfrac65$ on two four-sets sharing two indices with $\tau\le0$. **Open there: $\tau>0$, three shared indices, pair blocks.**

## Phase 3a: at small $t$ the pair blocks drop out (derived here, unreviewed)

The one-plane bound caps each pair block, $\lVert B_{jk}\rVert^2\le2t^2\lVert\hat\delta^{jk}\rVert^2$, and the forced sum $\sum_{j<k}\lVert\hat\delta^{jk}\rVert^2=\tfrac{n-1}2$ ([the first sweep](2026-09-28-LIT-step8-sweep.md), attempt 1) gives
$$\lVert B_{\mathrm{pair}}\rVert^2\le(n-1)\,t^2 .$$
**So when $t^2\ll\tfrac1{n-1}$ the off-diagonal part lies almost wholly in four-set blocks**, $W\approx A+\sum_QB_Q$, which is L220's and L221's setting with their pair-block item gone. What remains open there is overlap: four-sets sharing three indices, and $\tau>0$, **the configuration of [I104](../plan.md)'s rectangles**, which the first sweep also met as the closed branch's open core. *The window $n^{-1}\lesssim t\lesssim n^{-1/2}$, between Schur's floor and this regime, still carries pair mass and is not covered by this reading.*

## Phase 3b, the routes for the node

| route | closes | attackable | margin | analytic | value | reach toward P |
|---|---|---|---|---|---|---|
| **the four-set line at small $t$**: extend L220 and L221 to overlapping four-sets, quantitatively, so that a critical point whose off-diagonal part is almost wholly four-set has $\theta\le\sqrt{3/2}$ or a large diagonal | 2 | 2 | 1 | 1 | **4** | (MG) at $t^2\ll\tfrac1n$; the window up to $n^{-1/2}$ and the large-$t$ regime stay |
| a maximality mechanism forcing diagonal mass above $\sqrt{3/2}$, the threshold form the $\mathbb{CP}^m$ family demands, from L24's cap or global comparison | 3 | 1 | 1 | 1 | 3 | the whole node; no method yet, and every average is ruled out by scaling ([position](2026-09-28b-step8-position.md)) |
| a bounded falsifier screen: ascents from far-from-diagonal seeds at $n=12$, tracking maximal-frame mass | 3 | 3 | 1 | 0 | 0 | a falsifier would refute (MG) and Conjecture A; the catalogue already records many ascents, all ending at products above $\sqrt{3/2}$ |

**Choice: the four-set line at small $t$**, since it attaches the node to proved results (L220, L221) and one named open core. Its first step is the quantitative form of L220, with pair mass bounded by $(n-1)t^2$ rather than zero.

## Batch 2, a screen deciding the four-set reading: $P$ on the pure four-set sector

*A screen, not evidence for a positive claim* ([screen_I121_fourset_sector.py](../scripts/misc/screen_I121_fourset_sector.py), twelve random-start ascents per $n$). $F_n$ is the operators with zero diagonal and zero pair blocks in a frame, $\dim F_n=2\binom n4$.

| $n$ | $\dim F_n$ | largest $P$ found on $F_n$ | $\theta_0(n)$ | room |
|---|---|---|---|---|
| $8$ | $140$ | $0.833333=\tfrac56$ | $1.145644$ | $0.31$ |
| $10$ | $420$ | $0.948683=\sqrt{9/10}$, the catalogued $\theta(\mathbb{CP}^5)$ | $1.2$ | $0.25$ |
| $12$ | $990$ | $1.032768$ | $1.236033$ | $0.20$ |
| $14$ | $2002$ | $1.090847$ (starts spread $1.045$ to $1.091$, not converged) | $\sqrt{78/49}=1.261680$ | $0.17$ |

- **So at $n\le12$ a tensor wholly in the four-set sector is not a maximiser, with room.** At small $t$ a global maximiser is $W=A+B_{\mathrm{pair}}+B_{\mathrm{four}}$ with $\lVert A\rVert=t$ and $\lVert B_{\mathrm{pair}}\rVert^2\le(n-1)t^2$, so $\sup_{F_n}P+\operatorname{err}(t)<\theta_0(n)$ excludes it. The $+c_*$ modes are a subsector, where I122's reduction gives $P\le\tfrac{5\sqrt3}{12}\max\{\tfrac2{\sqrt3},\tfrac{m-2}{\sqrt{\binom m2}}\}<1.021$.
- **Where it thins.** The sup grows with $n$ in shrinking steps ($0.116$, $0.084$, $0.058$) while $\theta_0(n)^2=\tfrac{(m-1)(2m-1)}{m^2}\to2$ at $n=2m$, so the room shrinks more slowly ($0.31,0.25,0.20,0.17$) and nothing in range suggests it closes, and a crude error term $\operatorname{err}(t)\sim(1+\sqrt{n-1})\,t$ makes the exclusion vacuous at $n=12$, where Schur's floor is already $t\ge0.18$. *What would make it work is an error term that does not pay $\sqrt n$ for the pair mass, which the circle form suggests: on the circle through $\hat A$, $\nu$ the pair part enters $q=P(\nu)$ only through its own cubic couplings.*
- **Graded**: the four-set sector route closes $2$ (the regime $t^2\ll\tfrac1n$), attackable $1$ (its core is a supremum like I122's, with no method), so value $2$, below the maximality mechanism's $3$, which has no concrete step. **Both need invention, and the four-set sector is the one with a screened quantity and room.**

## The four-set route's first link: criticality removes the pair part's linear error (derived here, unreviewed)

Split $W=A+B_p+B_f$ in the maximal frame into diagonal, pair and four-set parts, $\lVert A\rVert=t$. By [L120](../findings/second-order.md) every cross term between different sign characters vanishes, so
$$P(W)=P(A)+P(B_p)+P(B_f)+3\langle L_AB_p,B_p\rangle+3\langle L_AB_f,B_f\rangle+3T(B_p,B_p,B_f)+3T(B_f,B_f,B_p),$$
and the one term linear in $B_p$ is $3T(B_f,B_f,B_p)$, the source of the crude $\sqrt n$. **Criticality removes it.** The pair-character part of $Q(W)=\rho W$ is $\rho B_p=\pi_pQ(B_f)+\pi_pQ(B_p)+2L_AB_p+2\pi_pQ(B_p,B_f)$, and pairing with $B_p$ gives $T(B_f,B_f,B_p)=\rho\lVert B_p\rVert^2-P(B_p)-2\langle L_AB_p,B_p\rangle-2T(B_f,B_p,B_p)$. So
$$\rho=P(B_f)+3\langle L_AB_f,B_f\rangle+P(A)+3\rho\lVert B_p\rVert^2-3\langle L_AB_p,B_p\rangle-2P(B_p)-3T(B_p,B_p,B_f),$$
**in which every term but $P(B_f)$ is $O(t)$ or $O(\lVert B_p\rVert^2)=O((n-1)t^2)$.** **Typed**: `pair_identity` and `small_mass_bound` in [PairIdentity.lean](../lean/HamiltonsCubic/Results/PairIdentity.lean), standard three axioms. *The Lean proof needs only $T(A,A,B_f)=0$ among the cross terms: $T(A,A,B_p)$ and $T(A,B_p,B_f)$ cancel against three times the paired criticality, so the identity holds in any frame where the diagonal part's square has no four-set component.* *Gate 1: the identity holds to $1\times10^{-15}$ at $S^4\times S^4$ rotated into a random frame ($t=0.236$, pair and four-set masses $0.47$ each), a critical point in a generic frame ([check_I121_pair_identity.py](../scripts/misc/check_I121_pair_identity.py)).* With $S_F=\sup P$ on the unit four-set sector, $\bar\mu=\tfrac{\sqrt3}2$, and $K$ an $O(1)$ constant from the norm of $Q$ as a bilinear map,
$$\rho\ \le\ S_F+3\bar\mu\,t+K(n-1)\,t^2+\theta_0t^3 .$$
**So if $S_F<\theta_0(n)$, a global maximiser has $t\gtrsim\sqrt{(\theta_0-S_F)/(Kn)}$**, of order $n^{-1/2}$ against Schur's $n^{-1}$, which is where attempt 4's joint bound of the [first sweep](2026-09-28-LIT-step8-sweep.md) stops failing. **$\bar\mu=\tfrac{\sqrt3}2$ is on the record as [L218](../findings/second-order.md)**, $\Lambda_n=\tfrac{\sqrt3}2$ exactly, which caps both $\langle L_AB_f,B_f\rangle$ and $\langle L_AB_p,B_p\rangle$ by $\tfrac{\sqrt3}2t$ times the squared norm. *Agreement: the four-set case also follows in two lines from L121, $\mu_Q^2=\tfrac18[3(A^2+B^2+C^2)-(A+B+C)^2]\le\tfrac38(A^2+B^2+C^2)\le\tfrac34\lVert\hat A\rVert^2$, equality at the padded $S^2\times S^2$.* *The two regimes then meet up to constants, and what the route owes is (i) $S_F<\theta_0(n)$ at every even $n\ge12$, screened at $n\le12$ with room $0.2$ to $0.3$ and an I122-type supremum, (ii) $\bar\mu$ and $K$ explicit, (iii) the joint bound's constant at $t\sim n^{-1/2}$.*

## The route's constants, explicit (derived here, unreviewed)

- **$K$ from Banach's theorem.** $T(X,Y,Z)=\langle Q(X,Y),Z\rangle$ is a symmetric trilinear form on the Hilbert space $\mathcal W_n$, and on a real Hilbert space the norm of a symmetric multilinear form equals the supremum of its polynomial on the unit sphere (Banach 1938, Kellogg 1928 in finite dimension). So $\lvert T(X,Y,Z)\rvert\le\Theta_n\lVert X\rVert\lVert Y\rVert\lVert Z\rVert$, which is $\rho$ at a global maximiser.
- **The bound.** With [L218](../findings/second-order.md) for both $L_A$ terms and $P(A)\le\theta_0t^3$,
$$\rho\ \le\ S_F\lVert B_f\rVert^3+\tfrac{3\sqrt3}2\,t\,\lVert B_f\rVert^2+\theta_0t^3+\lVert B_p\rVert^2\Big(6\rho+\tfrac{3\sqrt3}2\,t+2\rho\lVert B_p\rVert\Big),\qquad\lVert B_p\rVert^2\le(n-1)t^2 .$$
- **What it gives, honestly.** At $t=c\,n^{-1/2}$ the error is about $6\rho c^2+2\rho c^3$, so with room $\delta=\theta_0-S_F$ a global maximiser has $t\ge c\,n^{-1/2}$ with $c\approx\sqrt{\delta/(6\rho)}$, about $0.15$ at the screened room. **That beats Schur's $\sqrt6/n$ only from $n\approx270$**, so the route is asymptotic: it removes the small-mass regime for large $n$ and leaves $12\le n\lesssim270$ to other means.

## The Lean table

| claim | declaration | what it covers |
|---|---|---|
| the pair identity | `pair_identity` in [PairIdentity.lean](../lean/HamiltonsCubic/Results/PairIdentity.lean) | abstract: a symmetric trilinear $T$, $T(A,A,B_f)=0$, and paired pair criticality; **not** that $T(A,A,B_f)=0$ holds in the frame (L120), nor the pairing of criticality |
| the bound, scalar | `small_mass_bound` | the inequality once each term is bounded; **not** the bounds themselves |
| the pair mass $\le(n-1)t^2$ | none: one-plane bound summed with the forced sum; check it | |
| Banach's constant | none: a classical theorem applied to $T$ on $\mathcal W_n$; check the application | |
| threshold form from $\mathbb{CP}^m$ | none: an argument from catalogued values; check it | |
| averaging identities die by scaling | none: an order-of-magnitude argument; check it | |
| the reach, $t\gtrsim c\,n^{-1/2}$, beating Schur from $n\approx270$ | none: arithmetic on the bound; check it | |

## What to attack

1. **The pair identity's use**: does L120 give $T(A,A,B_f)=0$, and does pairing the pair-character part of $Q(W)=\rho W$ with $B_p$ give exactly the stated equation? Is the expansion of $P(W)$ complete?
2. **The pair mass bound** $\lVert B_p\rVert^2\le(n-1)t^2$: normalisations, the factor between $\lVert B_{ij}\rVert^2$ and $\lVert x\rVert^2$, and the forced sum's use at $A=t\hat A$.
3. **The bound**: each term's cap, Banach's theorem applied to $T$ on $\mathcal W_n$ (does it need $T$ symmetric on $\mathcal W_n$ exactly, and is $\sup|P|=\Theta_n$), and the arithmetic of "$t\ge c\,n^{-1/2}$ with $c\approx\sqrt{\delta/(6\rho)}$" and "beats Schur from $n\approx270$".
4. **The threshold-form argument**: does $\mathbb{CP}^m$ with $\kappa^2=\tfrac3{m+1}$ and $\theta$ bounded below really exclude every bound $P\le F(t)$ with $F\to0$? Is $\kappa^2$ the maximal-frame mass $t^2$ in this brief's normalisation?
5. **The dead ends**: is the scaling argument against averaging identities right, and does it cover L118's 3-plane identity?
6. **The four-set sector reading**: "at $t^2\ll\tfrac1n$ the off-diagonal part lies almost wholly in four-set blocks" and the statement of what the four-set route owes. Is anything claimed beyond what the screens show?
7. **Hypotheses**: every place global maximality, the maximal frame, even $n$, or $S_F<\theta_0(n)$ is used. Is any used unstated?
