# Gate 2 brief, I121's small-mass node: the visible cubic as a Kneser triangle sum, the $\mathbb{CP}^m$ calibration, large $E$ and good frames, and the block products

**Cold brief. The claims are quoted verbatim from [reviews/2026-09-28d-I121-smallmass-direct.md](2026-09-28d-I121-smallmass-direct.md) as it stands at dispatch. You are asked to break them.** Verdicts per claim: CONFIRMED, PLAUSIBLE or REFUTED with corrections. **Analysis-only footing**: argue from the definitions, reading the written chain link by link; compute only to refute or to check a value, the smallest computation that does it (numpy under `sage -python`). A run of a few minutes on objects you construct is allowed; no sweeps or open-ended searches. **Screens are screens, not evidence for a positive claim; check that every sentence drawn from a screen says no more than it shows.**

## Definitions

- $\mathcal W_n$: algebraic Weyl tensors as symmetric operators on $\Lambda^2\mathbb R^n$ in the orthonormal basis $e_{ab}$, Hilbert–Schmidt norm, $Q(R)=R^2+R^\#$ with $I^\#=(n-2)I$, $P(W)=\langle Q(W),W\rangle$, $E(W)=P(W)-\tfrac32\operatorname{tr}W^3$. A frame's diagonal mass is $t^2=\lVert\pi_{\mathcal D}W\rVert^2$, and $t_{\max}^2$ its maximum over $O(n)$.
- On a four-set $Q=\{i<j<k<l\}$ with raw entries $a=W_{ij,kl}$, $b=W_{ik,jl}$, $c=W_{il,jk}$ and Bianchi $a=b-c$: for a pairing $(e|f)$ of $Q$, $J_{ef}=W_{e,f}$ and $X_{ef}=\tfrac12(W_{e_0f_0,e_1f_1}+W_{e_0f_1,e_1f_0})$ with edges ordered $e=(e_0<e_1)$, $f=(f_0<f_1)$. A rectangle $R$ is three disjoint edges, $T(X)=\sum_RX_{12}X_{13}X_{23}$, and for a perfect matching $M$, $E(M)=\sum_{e<f\in M}4X_{ef}^2$. $\varepsilon_n=\theta_0-\tfrac3{2\theta_0}$ with $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$.

## Givens (Gate 2 passed)

- **The rectangle identity** ([r1846](REVIEW_r1846.md), [r1847](REVIEW_r1847.md)): $\langle\nu_{12}\circ\nu_{13},\nu_{23}\rangle=\tfrac32J_{12}J_{13}J_{23}+4X_{12}X_{13}X_{23}$, $\lVert\nu_Q\rVert^2=4X_\pi^2+3J_\pi^2$ at each pairing, and $P(B_f)=\sum_R(9JJJ+24XXX)$.
- **The reduction** ([r1849](REVIEW_r1849.md), [r1850](REVIEW_r1850.md)): $\theta^2\le\tfrac32+\theta E$ at every unit critical point, $\theta\ge\theta_0$ forces $E\ge\varepsilon_n$, and at pair-free $W$ in a globally maximal frame $E$ is the diagonal term, a coupling and the visible cubic $24T$, per matching $P(D_M)$ with $\lVert D_M\rVert^2=E(M)$.
- **The matching inequality** ([r1836](REVIEW_r1836.md), [r1837](REVIEW_r1837.md)): in a globally maximal frame $E(M)\le t^2$ for every perfect matching, among other terms.
- **$\theta(\mathbb{CP}^m)^2=\tfrac{(m+1)(2m-1)}{3m(m-1)}$** ([INDEX-values.md](../findings/INDEX-values.md)) and the maximal-frame mass $\tfrac3{n+2}$ of $\mathbb{CP}^4$, $\mathbb{CP}^5$ ([r1843](REVIEW_r1843.md), from [diagonality.md](../findings/diagonality.md)).

## The claims

## The visible cubic is a Kneser triangle sum, and the matching family allows it to be large (screens)

**Structure.** *The visible coordinates parametrise $B_f$ completely*: on each four-set the three $X_\pi$ sum to zero in the sorted-edge orientation, and each $J_\pi$ is $\tfrac23$ of a signed sum of the other two $X$'s. So the visible cubic is $24\,T(X)$ with $T(X)=\sum_RX_{12}X_{13}X_{23}$, **a weighted triangle sum on the Kneser graph $KG(n,2)$**, whose vertices are the edges of $K_n$, whose edges are disjoint pairs, whose triangles are the rectangles and whose maximum cliques are the perfect matchings. The matching inequality caps each clique's mass, $E(M)=\sum_{e<f\in M}4X_{ef}^2\le t^2$, so $24T\le24\kappa_nt^3$ with $\kappa_n=\max\{T:\max_ME(M)\le1\}$.

**Screens** ([screen_I121_visible_cubic.py](../scripts/misc/screen_I121_visible_cubic.py), normalised ascent from random starts, giving lower bounds on $\kappa_n$, establishing nothing positive):

| $n$ | $\kappa_n\ge$ | $\max_ME(M)$ at unit four-set mass | $24T$ there |
|---|---|---|---|
| $6$ | $0.213$ | $0.13$ | $0.24$ |
| $8$ | $1.289$ | $0.063$ | $0.48$ |
| $10$ | $2.724$ | $0.043$ | $0.59$ |

- **So the matching family alone allows a visible cubic of order one at $t^2\approx0.45/n$**, comparable to $\varepsilon_n\le0.354$, spread over many matchings (the maximisers carry $23$ to $35$ times the clique cap in total visible mass). *This is the $n^{-1/2}$ barrier in the language of the reduction.*
- **The diagonal equation does not exclude these maximisers either.** At a critical point $\theta A=Q(A)+\operatorname{diag}Q(B_p)+D(B_f)$, so $\lVert D(B_f)\rVert\lesssim\theta t$ at small mass, with $D(B_f)_{ij}=\sum_{kl}(\tfrac32J^2-2X^2)$ over the pairings $(ij|kl)$. At the $n=8$ maximisers rescaled to unit four-set mass, $\lVert D(B_f)\rVert=0.14$ and $0.20$ against $\theta t\approx0.33$.
- **The four-set value those caps allow** ([screen_I121_capped_fourset.py](../scripts/misc/screen_I121_capped_fourset.py), maximising $P(B_f)=9\sum JJJ+24\sum XXX$ at unit mass under $\max_ME(M)\le c/n$, local ascent, so lower bounds): $0.53$, $0.75$, $0.81$ at $c=\tfrac12$ and $n=8,10,12$, and $0.83$, $0.84$, $0.85$ at $c=2$, against the unconstrained four-set sups $0.833$, $0.949$, $1.033$ of the [first sweep](2026-09-28b-LIT-step8-sweep.md) and $\theta_0=1.146$, $1.200$, $1.236$. *At the maximisers the value is almost all visible*: $9\sum JJJ=0.009$ to $0.063$ against $24\sum XXX=0.48$ to $0.60$ at $n=8,10$. *In these ascents the cap lowers the reachable four-set value by about a fifth at $n=12$; whether a bound follows is open.*
- **What is left unused** is the block part of criticality, $\theta\nu_Q=[Q(W)]_{\chi_Q}$ for every four-set, and frame maximality beyond the matching family.


## Calibration on $\mathbb{CP}^m$: the reduction's sufficient condition fails at $n=12$ (unreviewed)

$\mathbb{CP}^m$'s Weyl tensor has $\Lambda^2$-spectrum proportional to $2(m^2-1)$, $m-2$ and $-(m+1)$ with multiplicities $1$, $m^2-1$ and $m^2-m$ (from the curvature operator's $2(m+1)$, $2$, $0$ on $\langle\omega\rangle$, $\mathfrak{su}(m)$, $\mathfrak u(m)^\perp$ minus its trace part; at $m=2$ it is $W_{\mathbb{CP}^2}$'s $(2,-1,-1,0,0,0)$). With $\theta^2=\tfrac{(m+1)(2m-1)}{3m(m-1)}$ ([INDEX-values.md](../findings/INDEX-values.md), matching the catalogue at $m=3,4,5$), exactly:

| $m$ | $n$ | $\theta$ | $\operatorname{tr}W^3$ | $\theta\lambda_{\max}$ | $E$ | $\varepsilon_n$ | maximal-frame $t^2$ |
|---|---|---|---|---|---|---|---|
| $5$ | $10$ | $0.948683$ | $0.579751$ | $0.8000$ | $0.079057$ | $-0.050000$ | $0.250$ |
| $6$ | $12$ | $0.924962$ | $0.580604$ | $0.7778$ | $0.054056$ | $+0.022473$ | $0.214$ |
| $7$ | $14$ | $0.908514$ | $0.579469$ | $0.7619$ | $0.039311$ | $+0.072789$ | $0.188$ |
| $8$ | $16$ | $0.896421$ | $0.577694$ | $0.7500$ | $0.029881$ | $+0.109789$ | $0.167$ |

*The maximal-frame mass is $\tfrac3{n+2}$, measured at $m=4,5$ ([r1843](REVIEW_r1843.md)) and the formula beyond.* **So at $n=12$, $\mathbb{CP}^6$ is a small-mass critical point with $E>\varepsilon_{12}$**, and "$E<\varepsilon_n$ at small mass" is false there: the reduction cannot close the node at $n=12$ down to $t^2=\tfrac3{14}$ by bounding $E$ alone. The loss is L198's step, $\theta\lambda_{\max}=0.78$ at $\mathbb{CP}^6$ against the $1$ it spends. **From $n=14$, $\mathbb{CP}^m$ sits below $\varepsilon_n$**, and $E(\mathbb{CP}^m)\to0$ as $\operatorname{tr}W^3\to\tfrac23\theta$.

## Large $E$ came with a good frame in both screens (screens)

*The candidate the reduction points to is frame-free: $t_{\max}(W)^2=\max_g\lVert\pi_{\mathcal D}(gW)\rVert^2$ and $E(W)$ are both $O(n)$-invariant, and the node follows if $E(W)\ge\varepsilon_n$ at a critical point forces $t_{\max}(W)^2\ge\tau$.* **Calibration**: the balanced product has $E\approx\theta_0$ at $t_{\max}=1$, a normalised sum of $k$ products in generic frames has $E\approx\theta_0/\sqrt k$ at $t_{\max}\gtrsim1/\sqrt k$ (the cross terms being small), and $\mathbb{CP}^m$ has $E\to0$ at $t_{\max}^2=\tfrac3{n+2}$, so the scaling the data suggest is $E\lesssim C\,t_{\max}$.

**The capped four-set maximisers are not small-mass tensors** ([screen_I121_large_E_frame.py](../scripts/misc/screen_I121_large_E_frame.py)): built as operators and normalised, they have $t^2=0$ in their own frame and large $E$, and ascent over $O(n)$ finds frames with half their mass on the diagonal. *Each $t^2$ found is exact in an explicit frame, so it is a lower bound on $t_{\max}^2$.*

| $n$ | cap $\max_ME(M)$ | $P$ | $E$ | $t_{\max}^2\ge$ (four starts) |
|---|---|---|---|---|
| $8$ | $0.063$ | $0.525$ | $0.392$ | $0.542$ ($0.541$ to $0.542$) |
| $10$ | $0.05$ | $0.754$ | $0.622$ | $0.451$ ($0.438$ to $0.451$) |

**So the configurations that pass the matching family with a large visible cubic are near-diagonal tensors seen in bad frames**, like F81's witness but spread over many matchings, and full frame maximality moves them far from small mass. *The matching family cannot see this, since no single $\tfrac\pi4$ matching rotation raises the diagonal mass beyond the cap. What would prove the node is the statement these screens support: in a globally maximal frame the visible cubic is $O(t)$, equivalently $E\lesssim Ct_{\max}$ at critical points.*

## Next: the block equations in these coordinates (unreviewed)

*The rectangle identity fixes the product itself*: in the metric $\langle u,v\rangle=4X_uX_v+3J_uJ_v$ on $V_{Q_3}$, relative to the rectangle's pairing, $\nu_1\circ\nu_2$ has coordinates $(X,J)=(X_1X_2,\tfrac12J_1J_2)$, since $4(X_1X_2)X_3+3(\tfrac12J_1J_2)J_3=\tau$ for every $\nu_3$. So at pair-free $W$ the $\chi_Q$ component of $Q(W)=\theta W$ reads $\theta\nu_Q=2L_A\nu_Q+2\sum_g\nu_{e\cup g}\circ\nu_{f\cup g}$, summed over the pairings $(e|f)$ of $Q$ and the edges $g$ disjoint from $Q$, each term a vector along its own pairing's $(X,J)$ axes. *These are the equations the visible-cubic screens left unused, and the next derivation is what they force on $T(X)$ at small $t$.*

## The Lean table

| claim | declaration | what it covers |
|---|---|---|
| the $X$'s parametrise $B_f$, sum to zero per four-set, $J$ from $X$ | none: coordinate algebra on raw entries, checkable by hand | check it |
| cliques of $KG(n,2)$ are the perfect matchings | none: a combinatorial fact | check it |
| the $\mathbb{CP}^m$ spectrum and the table | none: the layer has no $\mathbb{CP}^m$ at general $m$ | check the spectrum and the arithmetic |
| the screens and the large-$E$ table | none: screens | check their wording |
| $\nu_1\circ\nu_2=(X_1X_2,\tfrac12J_1J_2)$ and the block equation | none on the operators (RectOp covers the matched triple only) | check it |

## What to attack

1. The Kneser structure: do the three $X$'s of a four-set sum to zero in the stated orientation, is each $J$ determined by the $X$'s, and are the maximum cliques of $KG(n,2)$ exactly the perfect matchings?
2. The $\mathbb{CP}^m$ calibration: the Weyl spectrum and multiplicities, $\operatorname{tr}W^3$, $E$ and the $n=12$ conclusion, including whether $\tfrac3{n+2}$ is established at $m=6$.
3. The large-$E$ section: whether a found frame's $t^2$ is a valid lower bound on $t_{\max}^2$, whether the scaling calibrations are right (sums of products with small cross terms), and whether anything is stated beyond the screens.
4. The block equations: the product's coordinates in the stated metric and the stated form of the $\chi_Q$ component at pair-free $W$.
