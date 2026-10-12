# Reviewer 59, adversarial audit of five claims

Independent implementation, written from the brief's definitions only ([r59core.py](scratchpad/r59core.py) and siblings in the session scratchpad). No code under review was imported. Calibration: `dim Weyl_n` reproduces `n(n+1)(n+2)(n-3)/12` at n = 4, 5, 6, 7 (10 / 35 / 84 / 168); the identity `<W,W^#> = 1/2 sum_{abg} c'^2_{abg} lam_a lam_b lam_g` reproduces to 1e-14 on random symmetric W at n = 4, 5, 6; `theta` of the padded self-dual Weyl_4 tensor with spectrum (2,-1,-1)/sqrt6 comes out at 1.224744871391589 = sqrt(3/2).

| Claim | Verdict |
| --- | --- |
| 1. Lemma L29, the bound `theta <= sqrt(3/2)` | **CONFIRMED** |
| 1'. Lemma L29, the equality case as an *iff* | **PLAUSIBLE**, the "only if" is proved, the "if" rests on an unproved finiteness that I could only check numerically |
| 2. Padding reduction | **CONFIRMED** |
| 3. Bracket cap, both directions | **CONFIRMED** |
| 4. Second-kind identification and the `2 b Sigma` bound | **CONFIRMED**, and the hypothesis is genuinely load-bearing |
| 5. Diagonal half | **CONFIRMED** |

## The most important structural finding: the Lemma L29 stratum is one orbit family

The stratum is **not** vacuous, but it is far smaller than the statement suggests, and that changes how the lemma should be read.

Ricci-flatness of `W = sum_a lam_a v_a v_a^T` is exactly `sum_a lam_a v_a v_a^T = 0` **as n x n matrices** (verified: `Ric_ij = sum_k R_ikjk = sum_a lam_a (v_a v_a^T)_ij`). With one positive and two negative eigenvalues this reads

> `lam_1 v_1 v_1^T = a v_2 v_2^T + b v_3 v_3^T`,  all three terms positive semidefinite.

Three consequences follow immediately:

- `lam_1 = a + b` (take traces; each `v_a` has `tr(v_a^T v_a) = 2`), which is the trace-freeness the proof uses.
- `im v_2, im v_3 subset im v_1` and `im v_1 = im v_2 + im v_3`. So the **support of W is exactly `im v_1`**, of even dimension r, and **every stratum element is an O(n)-padding of a full-support element of Weyl_r with r even**. In particular the stratum is dimension-free in the strongest sense: nothing new appears as n grows past r.
- r = 4 is realised: the self-dual (or anti-self-dual) Weyl_4 tensors with Lambda^+ spectrum `(a+b, -a, -b)`. These are the *only* rank-3 signature-(1,2) elements of Weyl_4, because a nonzero trace-free 3 x 3 block contributes a positive eigenvalue, so one of `W^+`, `W^-` must vanish.

On that r = 4 family the eigenvectors `v_2, v_3` are an orthonormal pair inside `Lambda^+ = su(2)`, where `||[x,y]||^2 = 2` for *every* orthonormal pair. So `T_{1,N-1,N} = 2` identically, the pair cap is **saturated at every t**, and

> `theta = f(t) = 9 sqrt2 t(t+1) / (4 (t^2+t+1)^{3/2})` **exactly**, not merely `<=`.

Measured at n = 6 (padded): t = 0.1 / 0.3 / 0.5 / 0.7 / 0.9 / 1.0 gives theta = 0.299299322 / 0.757251117 / 1.030864790 / 1.168364372 / 1.219662553 / 1.224744871, matching f(t) to all printed digits. Searches at n = 5, 6, 7 over random starts returned only rank-4-supported solutions, with `||[v_2,v_3]||^2` = 2 to 2e-7.

**Reading this back onto the proof.** Every step of the written proof checks out: the `(+++)`, `(++-)` blocks vanish because `T` kills repeated indices and only one positive index exists; `(---)` vanishes by the pigeonhole plus total antisymmetry of `c'`; the surviving block is `3 T_{1,N-1,N} lam_1 a b <= 6 lam_1 a b`; `tr W^3 = 3 lam_1 a b` by `lam_1 = a+b`; the sum collapses to `9(a+b)ab = f(t)`, symmetric under `t -> 1/t`, unique stationary point t = 1, `f(1) = sqrt(3/2)`. **The bound is correct and the "estimate" is in fact an identity on the whole stratum.**

### Where the *iff* is not yet proved

The written proof gives `equality => t = 1 and T = 2`, hence `spectrum = (2,-1,-1)/sqrt6`. It does **not** give the converse, which the statement asserts. The converse needs: every W with spectrum `(2,-1,-1)/sqrt6` has `T = 2`. Claim 3 supplies the missing half of the argument:

> equality in the pair cap forces `im v_2 = im v_3`, of dimension 4. Since `im v_1 = im v_2 + im v_3`, equality forces **r = 4**. Contrapositive: any full-support stratum element with `r >= 6` has `T < 2` strictly, hence `theta < f(t)`, hence a tensor with spectrum `(2,-1,-1)/sqrt6` and `theta < sqrt(3/2)`, which would refute the "if" direction.

So the *iff* is equivalent to: **no full-support rank-3 signature-(1,2) element of Weyl_r exists for even r >= 6.** I could only test this numerically, by minimising the joint Ricci + Bianchi residual over orthonormal triples with `sigma_min(v_1) >= delta`:

| r | delta | best residual over multistarts | starts |
| --- | --- | --- | --- |
| 6 | 0.20 | 1.8e-2 | 20 |
| 6 | 0.05 | 1.415e-3 | 10 |
| 6 | 0.02 | 2.346e-4 | 10 |
| 8 | 0.15 | 2.1e-2 | 12 |
| 10 | 0.12 | 2.6e-2 | 5 |

The residual scales like `delta^2` as `delta -> 0`, i.e. it is the smooth cost of pushing off the rank-4 solution manifold, with no separate branch anywhere. That is strong evidence, not a proof. **r >= 12 is untested.** This does not touch the bound `theta <= sqrt(3/2)`, which is what the programme actually consumes; it touches only the equality clause.

## Claim 2, padding reduction: CONFIRMED

I reproduced the proof rather than trusting it, and verified each step numerically.

1. For a 2-form v and unit u, `<u ^ e_i, v> = -(v u)_i` (checked at n = 6 on random v). So `u ^ u-perp` is orthogonal to the whole negative eigenspace exactly when `u` is in the common kernel, and `ker v_{N-1} ∩ ker v_N` *is* the common kernel of the plane they span, so the conclusion is basis-independent even though the rank hypothesis is not.
2. `r_1 + r_2 < n` gives `dim(ker v_{N-1} ∩ ker v_N) >= n - r_1 - r_2 > 0`, so such a u exists.
3. `Ric(u,u) = sum_i <W(u ^ e_i), u ^ e_i>` in this normalisation (checked: `sum_i R[0,i,0,i]` is 1e-15 on random Weyl_6).
4. Each summand is `>= 0` because `u ^ e_i` lies in the span of the nonnegative eigenvectors; a zero sum of nonnegative terms kills each, and `<W xi, xi> = 0` with `xi` in the nonnegative eigenspace forces `W xi = 0`. Hence `W` vanishes on the (n-1)-dimensional `u ^ u-perp`.
5. The restriction to `Lambda^2(u-perp)` is in `Weyl_{n-1}`: Bianchi is inherited, and `Ric'_ij = Ric_ij - R_{i u j u} = 0`.
6. Padding preserves `theta` **exactly**, and for a structural reason: for a "new" pair a = (i, n), `[phi_a, phi_m]` lands in the span of new pairs whenever m is old, so `c_{a,m,p} = 0` for old m, p and the sharp has no off-block rows at all. Measured over the pad pairs 4→5, 4→6, 5→6, 5→7, 6→7: Weyl residual <= 5e-16, sharp block match <= 5.6e-17, sharp off-block **exactly 0.0**, theta identical to 12 digits.

Two sharpness notes, neither a defect:

- The rank hypothesis is a *sufficient* criterion and is basis-dependent when `-a = -b`; the invariant hypothesis is "the negative eigenspace has a nonzero common kernel".
- It misses the case the programme cares most about at small n: **padded `W_{CP^2}` has negative eigenvector ranks 4 + 4 = 8, so the criterion applies only from n = 9**, even though the tensor is padded at every n >= 5. The padded diagonal-K4 tensor (ranks 2 + 2 = 4) satisfies it from n = 5, so the claim is not vacuous.

## Claim 3, bracket cap: CONFIRMED, both directions, and every hypothesis is needed

**Forward.** Maximising `||[X,Y]||^2` over orthonormal pairs, 30 multistarts each at n = 4, 5, 6, 7, 8: max = 2.000000000000 at every n, and **all 150 maximisers** satisfy anticommuting (<= 7e-8), rank exactly (4,4), singular values all 0.707107, and equal image (projector difference <= 7e-8).

**Reverse**, exactly, in n = 8 with the quaternionic pair `X = I/sqrt2`, `Y = J/sqrt2` on a common 4-space: `||X||^2 = ||Y||^2 = 1`, `<X,Y> = 0` (automatic, `tr(IJ) = tr K = 0`), `||[X,Y]||^2 = 2.000000000000`. The general reverse argument is two lines: rank 4 with all singular values `1/sqrt2` on a common image V means `X = I_c/sqrt2`, `Y = J_c/sqrt2` for complex structures on V; anticommuting makes `K = I_c J_c` a complex structure; `[X,Y] = K` and `||K||^2 = 2`.

Dropping any one hypothesis strictly lowers the value:

| perturbation | `||[X,Y]||^2` |
| --- | --- |
| rank 4, sv 1/sqrt2, anticommuting, **disjoint** images | 0.000000000000 |
| rank 4, sv 1/sqrt2, images overlapping in dim 2 | 0.500000000000 |
| equal image, singular values (0.989, 0.989, 0.146, 0.146) | 1.289522373741 |
| equal image, anticommuting, **rank 8** (quaternionic on H^2) | 1.000000000000 |
| the stated case | 2.000000000000 |

## Claim 4, second-kind identification: CONFIRMED; the hypothesis does real work

**The identification is exact.** With `u = e_n`, X supported on `u ^ u-perp`, `h_ij = X_{(i,u),(j,u)}`: the block of `W o X` matches `(1/2) sum_{kl} R_{ikjl} h_{kl}` to **1.1e-16** on random padded Weyl tensors across the pad pairs 4→5, 4→6, 5→6, 5→7, 6→7 (values of order 0.5). The block is also invariant, leakage from those rows is exactly 0.0, so "restriction" is literally a block, not a compression. `Rring_e` needs no index restriction: since `e` kills `u ^ u-perp`, every component `e_{i u j l}` vanishes, so `Rring_e` automatically preserves `Sym(u-perp)`. The map is linear in e, so the `e = W/theta` normalisation is cosmetic here.

**The bound `lam_max(Rring_W) <= 2 b Sigma`.** I reproduced the derivation independently and each link checks numerically:

- `lam_max(Rring_W) = max over orthonormal frames of lam_max(K)`, `K_ab = <W(f_a ^ f_b), f_a ^ f_b>`. Verified to 1e-8 on six random Weyl_5 / Weyl_6 tensors, using the frame that diagonalises the top eigenvector of `Rring_W`.
- K is symmetric with zero diagonal and zero row sums (Ricci-flatness), so Gershgorin gives `lam_max(K) <= max_a sum_b |K_ab| = 2 max_a sum_b max(0, -K_ab)`.
- `K_ab >= -b ||P_neg(f_a ^ f_b)||^2`, and `sum_b <f_a ^ f_b, v_k>^2 = (v_k v_k^T)_aa <= s_1(v_k)^2`. Summing over the negative eigenvectors gives `2 b Sigma`.

The hypothesis enters at exactly one place: `Sigma` sums over **two** eigenvectors, which is the whole negative eigenspace only when there are at most two negative eigenvalues.

**It does fail without the hypothesis, as asserted.** Padded `S^3 x S^3` (Weyl part of the Einstein product; spectrum 0.316228 with multiplicity 6 and -0.210819 with multiplicity 9, theta = 1.054092553):

| n | `lam_max(Rring_W)` | `2 b Sigma` | holds |
| --- | --- | --- | --- |
| 6, 7, 8, 10 | 1.26491106 | 0.84327404 | **no** |

`lam_max(Rring_W)/theta = 1.200000` exactly, independent of the padding dimension. A second, sharper point against dropping the hypothesis: with a 9-dimensional negative eigenspace, `Sigma` is **not even well defined**, over 4000 random orthonormal 2-frames of that eigenspace it ranges from 0.934411 up to 2, so the bound's right-hand side depends on a basis choice that the hypothesis is what removes.

**Inside the hypothesis it holds**, with slack except at one point. Over the whole Lemma L29 stratum padded into n = 6: `2 b Sigma` runs 1.342 / 1.200 / 1.069 / 0.956 / 0.859 / 0.816497 against `lam_max(Rring_W)` 0.738 / 0.780 / 0.802 / 0.812 / 0.816 / 0.816497 for t = 0.1 … 1.0, **exactly tight only at t = 1**, i.e. only at padded `W_{CP^2}`, confirming the reported 0.816497 on both sides. The padded diagonal-K4 tensor (2 negative eigenvalues, theta = -0.866025404) has 0.577350 against 2.309401.

## Claim 5, diagonal half: CONFIRMED

A coordinate-diagonal symmetric operator is in `Weyl_n` iff its weight matrix w (symmetric, zero diagonal) has **all row sums zero**: Bianchi holds identically since every 4-distinct-index term is off-diagonal, and `Ric_ij` for `i != j` vanishes automatically while `Ric_ii = sum_k w_ik`. Verified: the diagonal subspace of my `Weyl_n` basis has dimension `n(n-1)/2 - n` (5 at n = 5, 9 at n = 6) and every element has zero row sums to 1e-9.

The eigenvalues of such a W are exactly the entries `w_ij`, so "at most two negative eigenvalues" means at most two negative entries. Then:

> a vertex whose row is nonzero has row sum zero, hence carries a negative entry; two negative pairs touch at most four vertices; so any fifth vertex has an identically zero row. Support <= 4 coordinates, and the restriction still has zero row sums, so it is a diagonal `Weyl_4` tensor.

That is the whole proof and it is airtight, no LP, no dimension restriction. (A support of 3 or fewer forces W = 0, since zero row sums on a triangle force all three weights to vanish.) A randomised hunt at n = 5, 6, 7, 8 for a zero-row-sum w with <= 2 negative entries and support > 4 returned nothing, as it must.

## What I could not test

- **The pair cap `||[X,Y]||^2 <= 2` itself** was excluded from the brief. I did re-derive `max = 2` numerically at n = 4…8, which is consistent with it, but I did not audit its proof.
- **Full-support stratum elements at r >= 12.** The r = 6, 8, 10 exclusions are numerical multistart evidence with a clean `delta^2` residual signature, not proofs. This is the single crack, and it sits under the *equality clause* of Lemma L29, not under its bound.
- **Claim 4's identification for non-padded e.** The statement only makes sense where `e` annihilates `u ^ u-perp` (otherwise `e X` and `X e` are not zero and the block is not the sharp part alone), so "padded" is not a restriction I imposed but the content of the hypothesis.
- **Claim 2 by direct falsification search.** My constrained optimiser never landed a feasible point (<= 2 negative eigenvalues *and* a nonzero common kernel) at n = 6, so that search returned no information either way. The verdict rests on the derivation in §Claim 2, whose every step I verified numerically.

## Suggested corrections to the written statements

1. **Lemma L29's proof should carry the converse of its equality clause.** Add: equality in the pair cap forces `im v_{N-1} = im v_N` (Claim 3), hence `im v_1 = im v_{N-1} + im v_N` is 4-dimensional, hence W is a padded self-dual `Weyl_4` tensor, on which `theta = f(t)` identically. Without that step "if and only if" is asserted, not proved, and it is equivalent to the untested non-existence of full-support stratum elements in `Weyl_r`, r >= 6.
2. **Say that the pair cap is saturated identically on the stratum, not just at the extremiser.** The current remark ("it is *attained* at the extremiser") understates it: `T_{1,N-1,N} = 2` for every t, so `theta = f(t)` is an equality on the whole stratum and the lemma's chain loses nothing anywhere.
3. **Claim 2's hypothesis should be stated invariantly** ("the negative eigenspace has a nonzero common kernel"), with `r_1 + r_2 < n` recorded as the sufficient criterion it is. As stated it is basis-dependent under a repeated negative eigenvalue, and it does not reach padded `W_{CP^2}` below n = 9.


---

## Synthesis carried in REVIEW.md

### Reviewer 59: Lemma L29, the padding reduction, the bracket cap, the second-kind identification, and the diagonal half

Built its own core from the definitions, $\dim\mathrm{Weyl}_n=10/35/84/168$ at $n=4\ldots7$, the cubic identity reproducing to $10^{-14}$, $\theta$(padded $W_{\mathbb{CP}^2}$)$=1.224744871391589$, and imported nothing under review. Full report in [reviews/REVIEW_r59.md](reviews/REVIEW_r59.md).

| claim | verdict |
|---|---|
| Lemma L29, the bound $\theta\le\sqrt{3/2}$ | **CONFIRMED** |
| Lemma L29, equality as an *iff* | **PLAUSIBLE**, the converse is not proved |
| Padding reduction | **CONFIRMED**, hypothesis restated |
| Bracket cap, both directions | **CONFIRMED** |
| Second-kind identification and $2b\Sigma$ | **CONFIRMED**, hypothesis load-bearing |
| Diagonal half | **CONFIRMED**, with its own proof |

**Nothing refuted, and the stratum is not vacuous.**

**The finding that outranks the verdicts.** Ricci-flatness on the stratum reads $\lambda_1v_1v_1^{\mathsf T}=a\,v_2v_2^{\mathsf T}+b\,v_3v_3^{\mathsf T}$, all three terms positive semidefinite. Hence $\mathrm{im}\,v_2,\mathrm{im}\,v_3\subseteq\mathrm{im}\,v_1$ and **the support of $W$ is exactly $\mathrm{im}\,v_1$, of even dimension $r$**. So every stratum element is a padding of a full-support $\mathrm{Weyl}_r$ element with $r$ even, and $r=4$ gives the self-dual $\mathrm{Weyl}_4$ family with $\Lambda^+$ spectrum $(a+b,-a,-b)$. There $v_2,v_3$ are an orthonormal pair in $\Lambda^+\cong\mathfrak{su}(2)$, where **every** orthonormal pair brackets to norm-squared $2$. So the pair cap is saturated **identically on the stratum, not merely at the extremiser**, and $\theta=f(t)$ exactly, verified to all printed digits at $t=0.1\ldots1.0$. *The lemma's estimate is an identity on its own stratum.*

**The one crack.** The proof gives equality $\Rightarrow$ spectrum $(2,-1,-1)/\sqrt6$; the statement asserts *iff*. The bracket-cap result closes the gap by forcing $\mathrm{im}\,v_2=\mathrm{im}\,v_3$ of dimension $4$, hence $r=4$, so the *iff* is **equivalent to** there being no full-support rank-$3$ signature-$(1,2)$ element of $\mathrm{Weyl}_r$ for even $r\ge6$. Excluded numerically at $r=6,8,10$, residual floors $1.8\times10^{-2}$, $2.1\times10^{-2}$, $2.6\times10^{-2}$ with a clean $\delta^2$ decay as the rank constraint relaxes, so no separate branch; **$r\ge12$ untested.** This touches the equality clause only, never the bound.

**Claim 4's hypothesis is doing real work.** The identification is exact to $1.1\times10^{-16}$ across five padding pairs with block leakage exactly $0$; the bound is tight at padded $W_{\mathbb{CP}^2}$ and slack elsewhere on the stratum; and at padded $S^3\times S^3$ (nine negative eigenvalues), it fails, $1.26491106$ against $0.84327404$. Sharper than the record had it: with a nine-dimensional negative eigenspace $\Sigma$ ranges over $0.934$–$2.0$ depending on basis, so **the right-hand side is not even well defined there**.

**Three corrections, all adopted.** Lemma L29 must carry the converse step or drop the *iff*; the pair cap is saturated identically rather than at one point; and the padding reduction's hypothesis is basis-dependent as stated, under a repeated negative eigenvalue the ranks are not determined, and "rank sum $<n$" misses padded $W_{\mathbb{CP}^2}$ below $n=9$, where the ranks are $4+4=8$. The invariant form is **"the negative eigenspace has a nonzero common kernel"**.

**Untested and why**: the pair cap itself, excluded from the brief; $r\ge12$, on compute; and the padding reduction by direct falsification search, whose optimiser never landed a feasible point, that verdict rests on the derivation, every step of which was checked numerically.
