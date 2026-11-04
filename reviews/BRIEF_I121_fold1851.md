# Gate 2 brief (one reader), a fold and a Lean file: the r1851/r1852 fold on I121's small-mass note, and CPmE.lean

**This round compares text against something fixed, so it has one reader.** Two comparisons. Verdict per item: CONFIRMED, PLAUSIBLE or REFUTED with corrections. **Analysis-only footing**: read and compare, computing only to check a value, the smallest computation that does it.

## Item 1: the fold against the findings it answers

The fold is commit `f1ae74a7`. It answers [REVIEW_r1851.md](REVIEW_r1851.md) and [REVIEW_r1852.md](REVIEW_r1852.md), which audited the note's sections from "The visible cubic is a Kneser triangle sum" onward on the brief [BRIEF_I121_kneser.md](BRIEF_I121_kneser.md). Read both reports in full, then check the sections as they stand now (quoted below, verbatim at dispatch):

- every finding of either report is applied, or its non-application is stated with a reason;
- where the two reports disagree (whether $t_{\max}^2=\tfrac3{n+2}$ at every $m$), the resolution cites a statement that settles it, and that statement says what the fold says it says ([L95](../findings/bispectral.md), `kappaSq_CP` in [L95.lean](../lean/HamiltonsCubic/Results/L95.lean));
- no repaired sentence claims more than the reports allow, and no new claim entered under cover of the fold.

## Item 2: CPmE.lean against the claim it types

The draft is `/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d3790d3b-3383-4c5d-9548-46ea15965c86/scratchpad/CPmE.lean` (it compiles, and is not yet in the tree). Check that `cp_E` states the note's closed form $E(\mathbb{CP}^m)=\dfrac9{2\sqrt{3m(m^2-1)(2m-1)}}$ from the stated spectrum and $\theta$: in particular that $\theta=(m+1)(2m-1)/\sqrt N$ with $N=3m(m^2-1)(2m-1)$ equals $\sqrt{(m+1)(2m-1)/(3m(m-1))}$ at $m\ge2$, that $\mathop{\mathrm{tr}}W^3=K/(N\sqrt N)$ is the normalised cube sum of the stated spectrum, that the hypothesis $N>0$ is the right one, and that the docstring's "not typed" line is accurate. Run `#print axioms` on `cp_E` if you can (`lake env lean` on a copy with the line appended, from the `lean/` directory), and exhibit one $m$ satisfying the hypothesis.

## The sections as they stand at dispatch

## The visible cubic is a Kneser triangle sum, and the matching family allows it to be large (screens)

**Structure.** *The visible coordinates parametrise $B_f$ completely*: on each four-set the three $X_\pi$ sum to zero identically (each $X$ is orientation-independent), and each $J_\pi$ is $\tfrac23$ of a signed difference of the other two $X$'s ([r1851](REVIEW_r1851.md), [r1852](REVIEW_r1852.md)). So the visible cubic is $24\,T(X)$ with $T(X)=\sum_RX_{12}X_{13}X_{23}$, **a weighted triangle sum on the Kneser graph $KG(n,2)$**, whose vertices are the edges of $K_n$, whose edges are disjoint pairs, whose triangles are the rectangles and whose maximum cliques, at even $n$, are the perfect matchings. The matching inequality caps each clique's mass, $E(M)=\sum_{e<f\in M}4X_{ef}^2\le t^2$, so $24T\le24\kappa_nt^3$ with $\kappa_n=\max\{T:\max_ME(M)\le1\}$.

**Screens** ([screen_I121_visible_cubic.py](../scripts/misc/screen_I121_visible_cubic.py), normalised ascent from random starts, giving lower bounds on $\kappa_n$, establishing nothing positive):

| $n$ | $\kappa_n\ge$ | $\max_ME(M)$ at unit four-set mass | $24T$ there |
|---|---|---|---|
| $6$ | $0.213$ | $0.13$ | $0.24$ |
| $8$ | $1.289$ | $0.063$ | $0.48$ |
| $10$ | $2.724$ | $0.043$ | $0.59$ |

- **So the matching family alone allows a visible cubic of order one at $t^2\approx0.45/n$** at $n=8,10$, comparable to $\varepsilon_n\le0.354$, spread over many matchings (the maximisers carry $23$ to $35$ times the clique cap in total visible mass at $n=8,10$). *This is the $n^{-1/2}$ barrier in the language of the reduction.*
- **The diagonal equation does not exclude these maximisers robustly.** At a pair-free critical point $\theta A=Q(A)+D(B_f)$, with $D(B_f)_{ij}=\sum_{kl}(\tfrac32J^2-2X^2)$ over the pairings $(ij|kl)$, so $\theta t\le\lVert D(B_f)\rVert+(1+\sqrt2)t^2$, and the matching inequality needs $t^2\ge\max_ME(M)$. At the $n=8$ maximisers ($\lVert D(B_f)\rVert=0.14$, $0.20$) and $\theta=\theta_0(8)$ that pair of conditions holds with $0.005$ to spare ([r1851](REVIEW_r1851.md)), so it neither excludes them nor leaves room. *Only the norm consequence of the diagonal equation is tested here, not its solvability.*
- **The four-set value those caps allow** ([screen_I121_capped_fourset.py](../scripts/misc/screen_I121_capped_fourset.py), maximising $P(B_f)=9\sum JJJ+24\sum XXX$ at unit mass under $\max_ME(M)\le c/n$, local ascent, so lower bounds): $0.53$, $0.75$, $0.81$ at $c=\tfrac12$ and $n=8,10,12$, and $0.83$, $0.84$, $0.85$ at $c=2$, against the four-set sups $0.833$, $0.949$, $1.033$ that unconstrained ascent reached in the [first sweep](2026-09-28b-LIT-step8-sweep.md) and $\theta_0=1.146$, $1.200$, $1.236$. *At these maximisers $9\sum JJJ=0.133$ and $24\sum XXX=0.392$ at $n=8$, $0.132$ and $0.622$ at $n=10$* ([r1851](REVIEW_r1851.md), [r1852](REVIEW_r1852.md), and reproduced here), the visible part the larger. *In these ascents the cap lowers the reachable four-set value by about a fifth at $n=12$; whether a bound follows is open.*
- **What is left unused** is the block part of criticality, $\theta\nu_Q=[Q(W)]_{\chi_Q}$ for every four-set, and frame maximality beyond the matching family.


## Calibration on $\mathbb{CP}^m$: the reduction's sufficient condition fails at $n=12$

$\mathbb{CP}^m$'s Weyl tensor has $\Lambda^2$-spectrum proportional to $2(m^2-1)$, $m-2$ and $-(m+1)$ with multiplicities $1$, $m^2-1$ and $m^2-m$ (from the curvature operator's $2(m+1)$, $2$, $0$ on $\langle\omega\rangle$, $\mathfrak{su}(m)$, $\mathfrak u(m)^\perp$ minus its trace part; at $m=2$ it is $W_{\mathbb{CP}^2}$'s $(2,-1,-1,0,0,0)$). With $\theta^2=\tfrac{(m+1)(2m-1)}{3m(m-1)}$ ([INDEX-values.md](../findings/INDEX-values.md), matching the catalogue at $m=3,4,5$), exactly:

| $m$ | $n$ | $\theta$ | $\mathop{\mathrm{tr}}W^3$ | $\theta\lambda_{\max}$ | $E$ | $\varepsilon_n$ | maximal-frame $t^2$ |
|---|---|---|---|---|---|---|---|
| $5$ | $10$ | $0.948683$ | $0.579751$ | $0.8000$ | $0.079057$ | $-0.050000$ | $0.250$ |
| $6$ | $12$ | $0.924962$ | $0.580604$ | $0.7778$ | $0.054056$ | $+0.022473$ | $0.214$ |
| $7$ | $14$ | $0.908514$ | $0.579469$ | $0.7619$ | $0.039311$ | $+0.072789$ | $0.188$ |
| $8$ | $16$ | $0.896421$ | $0.577694$ | $0.7500$ | $0.029881$ | $+0.109789$ | $0.167$ |

*The maximal-frame mass is $\tfrac3{n+2}$ at every $m$, by [L95](../findings/bispectral.md) (`kappaSq_CP`: the unitary frame attains the maximum over all frames). In closed form $E(\mathbb{CP}^m)=\dfrac9{2\sqrt{3m(m^2-1)(2m-1)}}$, decreasing in $m$, while $\varepsilon_n$ increases* ([r1851](REVIEW_r1851.md); checked here at $m=5,6$). **So at $n=12$, $\mathbb{CP}^6$ is a small-mass critical point with $E>\varepsilon_{12}$**, and "$E<\varepsilon_n$ at small mass" is false there: the reduction cannot close the node at $n=12$ down to $t^2=\tfrac3{14}$ by bounding $E$ alone. The loss is L198's step spread over the spectrum: $1-\theta\mathop{\mathrm{tr}}W^3=0.463$ at $\mathbb{CP}^6$, of which the top eigenvalue carries $0.157$, $\mathfrak{su}(6)$ $0.077$ and the negative eigenspace $0.229$ ([r1851](REVIEW_r1851.md), [r1852](REVIEW_r1852.md)). **From $n=14$, $\mathbb{CP}^m$ sits below $\varepsilon_n$**, by the closed form and the monotonicity of both sides, and $E(\mathbb{CP}^m)\to0$ as $\mathop{\mathrm{tr}}W^3\to\tfrac23\theta$.

## Large $E$ and the maximal frame (screens)

*The candidate the reduction points to is frame-free: $t_{\max}(W)^2=\max_g\lVert\pi_{\mathcal D}(gW)\rVert^2$ and $E(W)$ are both $O(n)$-invariant, and the node follows if $E(W)\ge\varepsilon_n$ at a critical point forces $t_{\max}(W)^2\ge\tau$.* **Calibration**: the balanced product has $E\approx\theta_0$ at $t_{\max}=1$, a normalised sum of $k$ products in generic frames has $E\approx\theta_0/\sqrt k$ at $t_{\max}\gtrsim1/\sqrt k$ (the cross terms being small), and $\mathbb{CP}^m$ has $E\to0$ at $t_{\max}^2=\tfrac3{n+2}$, so the scaling the data suggest is $E\lesssim C\,t_{\max}$.

**The capped four-set maximisers are not small-mass tensors** ([screen_I121_large_E_frame.py](../scripts/misc/screen_I121_large_E_frame.py)): built as operators and normalised, they have $t^2=0$ in their own frame and large $E$, and ascent over $O(n)$ finds frames with half their mass on the diagonal. *Each $t^2$ found is exact in an explicit frame, so it is a lower bound on $t_{\max}^2$.*

| $n$ | realised $\max_ME(M)$ | $P$ | $E$ | $t_{\max}^2\ge$ (four starts) |
|---|---|---|---|---|
| $8$ | $0.063$ | $0.525$ | $0.392$ | $0.542$ ($0.541$ to $0.542$) |
| $10$ | $\le0.05$ | $0.754$ | $0.622$ | $0.451$ ($0.438$ to $0.451$) |

**What this shows, and what it does not** ([r1851](REVIEW_r1851.md), [r1852](REVIEW_r1852.md)). These are two tensors, $B_f$ alone, not critical, at $t^2=0$ in their own frame, where they violate the matching inequality. A tensor $A+B_f$ that would pass the matching family, with $\lVert A\rVert^2\ge\max_ME(M)$, keeps by the triangle inequality only $t_{\max}^2\ge0.21$ at $n=8$ and $0.20$ at $n=10$, the $\mathbb{CP}^m$ scale, and the frames found hold half the mass off the diagonal. *So the screens are consistent with "large $E$ comes with a good frame" and do not support it beyond that, and the reading "in a maximal frame the visible cubic is $O(t)$" matches $E\lesssim Ct_{\max}$ only at pair-free $W$ with $t^2=O(1/n)$, the pair part entering $E$ at order $\sqrt nt$ elsewhere.* At $n=12$, $\mathbb{CP}^6$ also caps any threshold at $t_{\max}(\mathbb{CP}^6)^2=\tfrac3{14}$ for the $E$ route.

## Next: the block equations in these coordinates

*The rectangle identity fixes the product itself* ([r1851](REVIEW_r1851.md), [r1852](REVIEW_r1852.md), CONFIRMED): in the metric $\langle u,v\rangle=4X_uX_v+3J_uJ_v$ on $V_{Q_3}$, relative to the rectangle's pairing, $\nu_1\circ\nu_2$ has coordinates $(X,J)=(X_1X_2,\tfrac12J_1J_2)$, since $4(X_1X_2)X_3+3(\tfrac12J_1J_2)J_3=\tau$ for every $\nu_3$. So at pair-free $W$ the $\chi_Q$ component of $Q(W)=\theta W$ reads $\theta\nu_Q=2L_A\nu_Q+2\sum_g\nu_{e\cup g}\circ\nu_{f\cup g}$, summed over the pairings $(e|f)$ of $Q$ and the edges $g$ disjoint from $Q$, each term a vector along its own pairing's $(X,J)$ axes, with $L_A=Q(A,\cdot)$. *These are the equations the visible-cubic screens left unused, and the next derivation is what they force on $T(X)$ at small $t$.*

## Lean table

| item | declaration | covers |
|---|---|---|
| 2 | `cp_norm`, `cp_cube`, `cp_E_poly`, `cp_E` in the CPmE draft | the closed form's algebra, given the spectrum |
| 1 | none: a fold of prose | compare |
