# Reviewer 58, audit of five claims

Independent implementation in [scripts/review_r58_core.py](../scripts/review_r58_core.py) and the `review_r58_*.py` scripts beside it. Nothing under review was imported. Calibration before any verdict: `dim Weyl_n` reproduces `n(n+1)(n+2)(n-3)/12` at n=4,5,6; the self-dual construction of the CP^2 Weyl operator lands in Weyl_4 with Bianchi and Ricci residual exactly 0, spectrum `(2,-1,-1,0,0,0)/sqrt6` and `theta = 1.2247448713915885`; `max theta` over Weyl_4 by 30-start ascent is `1.224744871391583`. The machinery also reproduces, independently, four numbers the programme records: `0.500000` for `lam_max(L_e)` on the padding-leaving directions at padded W_CP2, `0.816497` for `lam_max(Rring)` there, `2/3` for `lam_max(Rring_e)`, and `1.264911` for `lam_max(Rring)` at S^3 x S^3.

| # | Claim | Verdict |
|---|---|---|
| 1 | Lemma L29 | **CONFIRMED** (stratum is non-vacuous; one residual case untested) |
| 2 | Padding reduction | **CONFIRMED**, and both hypothesis and conclusion can be sharpened |
| 3 | Bracket cap "iff" | **CONFIRMED as a statement; the recorded proof has a real gap**, repair supplied |
| 4 | Second-kind identification and `2 b Sigma` bound | **CONFIRMED**, hypothesis verified load-bearing |
| 5 | Diagonal half | **CONFIRMED** |

Separately, and outside the five: **item (iii) of the B0 assembly is REFUTED**, see the last section. It is the most consequential thing in this report.

## Claim 1, Lemma L29: CONFIRMED

**The stratum is not empty, and it is larger than padded W_CP2.** Weyl_4 splits as `S^2_0(Lambda^+) + S^2_0(Lambda^-)`, so any trace-free symmetric operator on the 3-dimensional self-dual space is a Weyl_4 tensor. Taking `W^+ = diag(q+r, -q, -r)` and `W^- = 0` gives one positive and two negative eigenvalues for every `q, r > 0`, a genuine two-parameter family (one parameter after scaling), padding into every `n >= 4` with Bianchi and Ricci residual exactly 0. Padded W_CP2 is its `q = r` member. So Lemma L29 is a statement about a one-parameter family of orbits, not a single point, and it is nowhere vacuous.

**Every step of the proof checks out.** In the eigenbasis, the three vanishing blocks come out at exactly `0.0e+00` (a few at `1e-99`, pure underflow) across the family at n=4,6,7. The surviving `(+--)` block equals `3 T_{1,N-1,N} lam_1 a b` on the nose, and the pair cap is *attained*, `T_{1,N-1,N} = ||[v_{N-1},v_N]||^2 = 2.000000000` at every member, not only at the extremiser. Sympy confirms `f(t)` has the single stationary point `t = 1` on `t > 0`, with `f(1) = sqrt(6)/2` exactly and `f -> 0` at both ends.

**A sharpening worth recording: on the padded stratum the estimate is an identity, not an inequality.** Because the cap is attained throughout, `theta` equals the bound `lam_1^3 - a^3 - b^3 + 6 lam_1 a b = 9 q r (q+r) / ||W||^3` at every member, agreeing to twelve digits at (q,r) = (1,1), (1,0.5), (1,0.1), (1,3), (1,0.01), (2,0.7) and at n = 4, 6, 7 alike. The maximum `sqrt(3/2)` at `q = r` is therefore the true maximum of `theta` on the stratum, not merely of an upper bound.

**The "iff" holds on everything reachable.** The forward direction follows from the uniqueness of `t = 1`. The reverse direction (spectrum `(2,-1,-1)/sqrt6` implying `theta = sqrt(3/2)`), needs the cap attained, which is not automatic from the spectrum alone; it holds at every stratum member found, verified at n=5,6,8.

**What I could not settle.** Ricci-flatness forces `lam_1 v_1 v_1^T = a v_2 v_2^T + b v_3 v_3^T` as `n x n` matrices (residual `6e-16`), so `ker v_1` sits inside the common kernel of both negative eigenvectors and a member is a padding whenever `rank v_1 < n`. Since skew rank is even, that settles every odd `n` outright and leaves only `rank v_1 = n` at even `n >= 6`. A hunt over that case, 400 starts at n=6 and 120 at n=8, with `v_1` held block-diagonal and nondegenerate and `b/a` confined to `[0.2, 5]`, reached a residual floor of `2.5e-5` and `5.3e-5` with no solution, and every near-miss drifted back toward `rank v_1 = 4`. That is strong evidence the stratum is exactly the paddings of the Weyl_4 family, but it is evidence, not a proof.

## Claim 2, padding reduction: CONFIRMED, and provable in one line

The identity `Ric = sum_alpha lam_alpha v_alpha v_alpha^T` (each `v_alpha` read as a skew matrix, residual `6.1e-16`) does the whole job. Ricci-flatness makes `sum_{lam>0} lam_alpha M_alpha = sum_{lam<0} |lam_alpha| M_alpha =: S` with every `M_alpha = v_alpha v_alpha^T` positive semidefinite, so the image of *every* eigenvector with nonzero eigenvalue lies in `U := im v_{N-1} + im v_N`. For `u` orthogonal to `U`, all `v_alpha u = 0`, hence `W(u ^ w) = 0` for every `w`, measured at `0.0` to `4.7e-17` across the family at n = 6, 8, 9. The restriction to `Lambda^2(u-perp)` is Ricci-flat for the stated reason, and the zero-eigenvalue count comes out at 12, 25 and 33 against the claimed floor of `n-1` = 5, 7, 8.

Two corrections, both in the claim's favour:

- **The stated hypothesis is strictly stronger than the argument needs.** `r_1 + r_2 < n` should be `dim(im v_{N-1} + im v_N) < n`. This matters at the points the programme actually uses: at padded W_CP2 in n = 6, 7, 8 the ranks are `4` and `4`, so `r_1 + r_2 = 8 >= n` and the Proposition as written does not apply, yet `dim U = 4` and the conclusion holds. The programme recovers this elsewhere via `im X = im Y` at the cap, but the Proposition should carry the sharp form.
- **The conclusion is stronger than stated.** `W` is a padding of a `Weyl_{dim U}` tensor, not merely of a `Weyl_{n-1}` one, the descent is a single step to `dim U`, measured at `4` in every case above, rather than one dimension at a time.

## Claim 3, bracket cap: statement CONFIRMED, recorded proof has a gap

**Reverse direction is true, and one line.** If `X, Y` are skew, rank 4, all singular values `1/sqrt2`, with `im X = im Y = V`, then `X^2 = Y^2 = -P_V/2`; anticommuting gives `[X,Y] = 2XY`, so `||[X,Y]||^2 = 2 tr(Y^T X^T X Y) = tr(Y^T P_V Y) = tr(Y^T Y) = 2`. Orthogonality is automatic, since anticommuting forces `tr(XY) = 0`. Measured at exactly `2.000000000000` for the quaternionic pair at n = 4, 5, 6, 8, 10, and across 200 random rotations combined with random mixtures `(cos t) J + (sin t) K` of the top eigenspace, the full range was `[2.000000000000, 2.000000000000]`.

**Forward direction is true, but the recorded derivation does not prove it.** The step "the cap forces `s_1^2 >= 1/2`, and `sum_i s_i^2 = 1` then leaves only `s_1 = s_2 = 1/sqrt2` with everything else zero, or the rank-2 case" is a non-sequitur: the profiles `s^2 = (0.5, 0.3, 0.2)` and `s^2 = (0.6, 0.3, 0.1)` both satisfy `s_1^2 >= 1/2` with `sum = 1` at **rank 6**. The intermediate bound `4 s_1^2` is also very lossy, at rank 2 it reads `4` against a true maximum of `1`.

**The repair.** For `X` in a Cartan subalgebra with angles `s_1 >= s_2 >= ...`, the roots of `so(n)` give `ad_X` eigenvalues `i(±s_i ± s_j)` and `i(±s_i)`, so `||ad_X||_op = s_1 + s_2` and `max_{||Y||=1} ||[X,Y]||^2 = (s_1 + s_2)^2` exactly. Verified to twelve digits on seven profiles:

| singular values of X | sum s^2 | max &#124;&#124;[X,Y]&#124;&#124;^2 | (s1+s2)^2 | recorded 4 s1^2 |
|---|---|---|---|---|
| (0.7071, 0.7071) | 1 | 2.000000000000 | 2.000000000 | 2.000000 |
| (1, 0) | 1 | 1.000000000000 | 1.000000000 | 4.000000 |
| (0.7071, 0.5477, 0.4472) | 1 | 1.574596669241 | 1.574596669 | 2.000000 |
| (0.7746, 0.5477, 0.3162) | 1 | 1.748528137424 | 1.748528137 | 2.400000 |
| (0.8367, 0.5477, 0) | 1 | 1.916515138991 | 1.916515139 | 2.800000 |
| (0.5831, 0.5745, 0.5745) | 1 | 1.339925368978 | 1.339925369 | 1.360000 |
| (0.7071, 0.5, 0.5) | 1 | 1.457106781187 | 1.457106781 | 2.000000 |

Maximising `(s_1 + s_2)^2` subject to `sum_i s_i^2 = 1` gives `2` by Cauchy–Schwarz, with equality exactly at `s_1 = s_2 = 1/sqrt2` and the rest zero, rank exactly 4. The recorded equality analysis for `im X = im Y` and `XY = -YX` is then correct as written, since with `s_1 = s_2 = 1/sqrt2` the chain is tight at every step. The conclusion stands; the derivation of rank 4 should be replaced.

## Claim 4, second-kind identification and the `2 b Sigma` bound: CONFIRMED

**The identification is exact, not approximate.** Building the product `X o Y = (1/2)(XY+YX) + sharp_bilin(X,Y)` from the given definitions reproduces `W o W = Q(W)` to `2.8e-17`, and `L_e` comes out self-adjoint to `8.9e-16`. On symmetric operators supported on `u ^ u-perp`, `L_e` matches `(1/2) Rring_e` with residual `0.000e+00` at padded W_CP2 for n = 6, 8, 10 and `2e-16` to `5e-15` on random paddings of Weyl_5 and Weyl_6, with the constant `1/2` pinned. Leakage out of that block is `0.000e+00` at every point, so the block is exactly `L_e`-invariant. A third route (`max` over frames of `lam_max(K)` with `K_ab = <W(e_a ^ e_b), e_a ^ e_b>`), agrees to nine digits with the `Rring` matrix at every stratum member tested.

One caveat on how the identification connects onward: the space of symmetric operators supported on `u ^ u-perp` meets `Weyl_n` only in `{0}` (dimension 0 measured at n = 6 and n = 8), so the passage from this exact identity to the Weyl-constrained 27-dimensional "block (a)" needs a step I did not audit. The numbers agree at padded W_CP2 (`1/3` on the block against `lam_max(Rring_e) = 2/3`), so the step is presumably sound.

**The inequality holds, and the hypothesis genuinely carries it.** `lam_max(Rring_W) <= 2 b Sigma` holds across the stratum and is exactly tight at padded W_CP2, ratio `1.000000` at n = 6, 8, 10, both sides `0.816496581`. Applied where `dim m > 2` it fails at every structured point tried:

| point | n | #neg | lam_max(Rring) | 2 b Sigma (top 2) | ratio | 2 b Sigma (all negatives) |
|---|---|---|---|---|---|---|
| S^3 x S^3 | 6 | 9 | 1.264911 | 0.754949 | 1.68 | 2.9344 |
| S^2 x S^4 | 6 | 8 | 1.161895 | 0.713509 | 1.63 | 2.3492 |
| S^4 x S^4 | 8 | 16 | 1.309307 | 0.566894 | 2.31 | 3.5673 |
| S^3 x S^5 | 8 | 15 | 1.274911 | 0.589350 | 2.16 | 3.7294 |
| S^5 x S^5 | 10 | 25 | 1.333333 | 0.414435 | 3.22 | 3.9904 |

Each also fails after padding by two dimensions. My `1.264911` at S^3 x S^3 reproduces the recorded `1.2649` from an independent construction (Weyl projection of the product curvature operator).

**What the hypothesis does, exactly.** The derivation bounds `sum_b |K_ab| <= 2 b sum_k ||v_k e_a||^2` over *all* negative eigenvectors; `Sigma` names only two terms. The full-sum version `2 b sum_{all neg k} s_1(v_k)^2` holds at every sphere product above (last column), so the hypothesis's whole role is to truncate the sum to two terms. That is a bookkeeping role rather than a geometric one, which is worth stating plainly in the write-up.

## Claim 5, diagonal half: CONFIRMED

A coordinate-diagonal `W` is a symmetric `w` with zero diagonal, and Bianchi is automatic because every entry it constrains is off-diagonal (measured at exactly `0.0` at n = 5, 6, 7); Ricci-flatness is exactly the vanishing of `w`'s row sums. Any supported coordinate has a nonzero row summing to zero, hence a negative entry, so the negative edges cover the support and at most two of them cover at most four coordinates. Exhaustive LP over every sign pattern with at most two negative entries at n = 5, 6, 7, 8 returns support size in `{0, 4}` in every feasible case and no case of support above 4.

A stronger conclusion is available and free: on the coordinate-diagonal stratum, `max theta = 0`, not `sqrt(3/2)`. In dimension 4 the diagonal Weyl tensors are `w_12 = w_34 = p`, `w_13 = w_24 = q`, `w_14 = w_23 = r` with `p + q + r = 0`, so each eigenvalue has multiplicity 2 and "at most two negative eigenvalues" permits only one negative value among `p, q, r`; a 401 x 401 grid over that family maxes out at `theta = 0.000000000`. Routing the diagonal half through `max_{Weyl_4} theta = sqrt(3/2)` is correct and very lossy.

## Refuted: item (iii) of the B0 assembly

This sits outside the five claims but is claim 4's downstream consumer and is listed in [plan.md](../plan.md) as one of three items owed. **The hypothesis `dim m <= 2` does not imply `C <= 0`.** Computing `lam_max(L_e)` directly on the Weyl_6 directions leaving the padding (49 of them), across the stratum family:

| q | r | theta | lam_max(L_e) on padding-leaving directions | C |
|---|---|---|---|---|
| 1 | 1.00 | 1.224745 | 0.500000000 | 0 |
| 1 | 0.70 | 1.168364 | 0.524127961 | **> 0** |
| 1 | 0.50 | 1.030865 | 0.594037590 | **> 0** |
| 1 | 0.40 | 0.914531 | 0.669602380 | **> 0** |
| 1 | 0.30 | 0.757251 | 0.808678154 | **> 0** |
| 2 | 0.30 | 0.432332 | 1.416440368 | **> 0** |
| 1 | 0.10 | 0.299299 | 2.046020124 | **> 0** |

Every member of the `dim m = 2` stratum except the maximiser has `C > 0`. The recorded value `0.500000` is recovered exactly at `q = r`, which cross-validates the computation against the programme's own table, and shows that what produces `1/2` there is *being the maximiser*, not having a two-dimensional negative eigenspace. So the sentence "item (iii) has to be proved from `dim m <= 2`, not from paddedness" is refuted: `dim m <= 2` is not sufficient, and no proof from that hypothesis alone can exist.

The two reduced forms fail at different places, and the reduction is the weaker of the two:

- **`lam_max(Rring_e) <= 1`** fails below `r/q = 0.313859338`, that is below `theta = 0.781736 = 0.6383 sqrt(3/2)`. It reaches `1.029630` at `r/q = 0.3`, `1.737037` at `(q,r) = (2, 0.3)` and `2.466667` at `r/q = 0.1`. Confirmed by three independent routes agreeing to nine digits: the `Rring` matrix, the frame form `max lam_max(K)`, and `2 x lam_max` of block (a) of `L_e` built from the `o`-product.
- **`2 b Sigma <= theta`** fails already at `r/q = (sqrt(105) - 5)/10 = 0.524695`, the positive root of `4q^2 - 5qr - 5r^2 = 0`, that is below `theta = 1.054093 = 0.8607 sqrt(3/2)`.

So the reduction discards the band between `0.638` and `0.861` of `sqrt(3/2)` where item (iii) is true but its proposed sufficient condition is false, and both are false below that. The programme's own hedge (that `C <= 0` is wanted only "near the top of the stratum"), survives, but "near" now has to mean `theta > 0.6383 sqrt(3/2)` at the very least, and the `2 b Sigma <= theta` route cannot deliver even that much. The quantifier has to be stated and then defended, and the `2 b Sigma` reduction should be withdrawn as the vehicle.

## What went untested

- Whether a member of the one-positive-two-negative stratum exists with `rank v_1 = n` at even `n >= 6`, which is the only way a non-padded member could arise. Searched hard, none found, floor `2.5e-5`.
- The passage from claim 4's exact identification to the Weyl-constrained 27-dimensional "block (a)", whose numbers agree at padded W_CP2 but whose construction I did not reproduce.
- Everything above is at `n <= 10`. Claims 1, 2, 3 and 5 are dimension-free in their proofs and I have no reason to expect dimension-dependence; claim 4's inequality was checked at n = 6, 8, 10 only.


---

## Synthesis carried in REVIEW.md

### Reviewer 58: the same five claims, on an identical brief

Independent implementation in [scripts/review_r58_core.py](scripts/review_r58_core.py) and the `review_r58_*.py` beside it; nothing under review imported. Calibrated first: $\dim\mathrm{Weyl}_n$ against $n(n+1)(n+2)(n-3)/12$, the self-dual $\mathbb{CP}^2$ operator landing in $\mathrm{Weyl}_4$ with Bianchi and Ricci residual exactly $0$ and $\theta=1.2247448713915885$, and $\max_{\mathrm{Weyl}_4}\theta=1.224744871391583$ by ascent. It also reproduced four of the programme's own numbers independently, $0.500000$, $0.816497$, $2/3$ and $1.264911$. Full report in [reviews/REVIEW_r58.md](reviews/REVIEW_r58.md).

**All five CONFIRMED, agreeing with Reviewer 58's counterpart on every one.** But three of them come with repairs, and one downstream item is refuted outright.

**The refutation, which is the report's headline.** *Item (iii) of the B0 assembly is false as posed.* Computing $\lambda_{\max}(L_e)$ directly on the padding-leaving directions across the stratum family gives $C=0$ **only** at the maximiser and $C>0$ at every other member: $0.524$ at $r/q=0.7$, $0.594$ at $0.5$, $0.809$ at $0.3$, $2.046$ at $0.1$, against the threshold $\tfrac12$. The recorded $0.500000$ is recovered exactly at $q=r$, which cross-validates the computation and shows that **what produces $\tfrac12$ there is being the maximiser, not having a two-dimensional negative eigenspace.** So $\dim\mathfrak m\le2$ is not sufficient for $C\le0$ and no proof from that hypothesis alone can exist. The two reduced forms also fail at different places, $\lambda_{\max}(\mathring R_e)\le1$ below $\theta=0.638\sqrt{3/2}$, and $2b\Sigma\le\theta$ already below $0.861\sqrt{3/2}$, so the reduction discards a band where the statement is true and its sufficient condition false, and **$2b\Sigma$ must be withdrawn as the vehicle.**

**Claim 3's statement stands; its recorded derivation does not.** "The cap forces $s_1^2\ge\tfrac12$, and $\sum s_i^2=1$ then leaves only $s_1=s_2=1/\sqrt2$" is a **non-sequitur**, the profiles $s^2=(0.5,0.3,0.2)$ and $(0.6,0.3,0.1)$ satisfy both at rank $6$. The intermediate $4s_1^2$ is also lossy, reading $4$ at rank $2$ against a true maximum of $1$. **The repair**: the roots of $\mathfrak{so}(n)$ give $\mathrm{ad}_X$ the eigenvalues $i(\pm s_i\pm s_j)$ and $i(\pm s_i)$, so $\max_{\|Y\|=1}\|[X,Y]\|^2=(s_1+s_2)^2$ **exactly** (verified to twelve digits on seven profiles) and maximising that subject to $\sum s_i^2=1$ gives $2$ by Cauchy–Schwarz with equality only at $s_1=s_2=1/\sqrt2$, rank exactly $4$. The equality analysis then stands as written.

**Claim 2 sharpened twice, both in its favour.** The hypothesis should be $\dim(\mathrm{im}\,v_{N-1}+\mathrm{im}\,v_N)<n$, not the rank sum, at padded $W_{\mathbb{CP}^2}$ in $n=6,7,8$ the ranks are $4+4=8\ge n$ and the Proposition as written does not apply, while $\dim U=4$ and the conclusion holds. And the conclusion is stronger: $W$ is a padding of a $\mathrm{Weyl}_{\dim U}$ tensor, **a single step to $\dim U$, measured at $4$ throughout**, not one dimension at a time.

**Claim 1: the stratum is a one-parameter family and the estimate is an identity on it.** $\mathrm{Weyl}_4=S^2_0(\Lambda^+)\oplus S^2_0(\Lambda^-)$, so $W^+=\mathrm{diag}(q+r,-q,-r)$, $W^-=0$ gives a stratum member for every $q,r>0$, with padded $W_{\mathbb{CP}^2}$ its $q=r$ point. The pair cap is attained at **every** member, so $\theta$ equals the bound exactly, $\theta=9qr(q+r)/\|W\|^3$, agreeing to twelve digits at six $(q,r)$ and at $n=4,6,7$. Independently of Reviewer 59, which reached the same conclusion by the $\mathfrak{su}(2)$ route.

**Claim 5 is correct but very lossy.** On the coordinate-diagonal stratum $\max\theta=\mathbf0$, not $\sqrt{3/2}$: in dimension $4$ the diagonal Weyl tensors are $w_{12}=w_{34}=p$, $w_{13}=w_{24}=q$, $w_{14}=w_{23}=r$ with $p+q+r=0$, each eigenvalue doubled, so at most two negative eigenvalues permits only one negative value among $p,q,r$, and a $401^2$ grid maxes at $0.000000000$.

**Claim 4, with a caveat on the joinery.** The identification is exact, $0.000$ residual at padded $W_{\mathbb{CP}^2}$ for $n=6,8,10$, $10^{-16}$ on random paddings, constant $\tfrac12$ pinned, block leakage exactly $0$, and a third route through $\max_{\text{frames}}\lambda_{\max}(K)$ agrees to nine digits. But **the space of symmetric operators supported on $u\wedge u^\perp$ meets $\mathrm{Weyl}_n$ only in $\{0\}$**, measured at $n=6,8$, so the passage from that identity to the Weyl-constrained $27$-dimensional block (a) is a step the reviewer did not audit. Separately, the hypothesis's role in $2b\Sigma$ is **bookkeeping**: the derivation bounds $\sum_b|K_{ab}|$ over *all* negative eigenvectors and $\Sigma$ names only two, and the full-sum version holds at every sphere product tried. That should be said plainly rather than dressed as geometry.

**Untested**: a member with $\mathrm{rank}\,v_1=n$ at even $n\ge6$, searched to a floor of $2.5\times10^{-5}$, none found, every near-miss drifting back to rank $4$; the block-(a) joinery; and everything above $n=10$. *The first of these is settled: no such member exists, Lemma L33, Reviewers 60 and 61.*
