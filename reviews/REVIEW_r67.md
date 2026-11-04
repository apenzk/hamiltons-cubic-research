# Reviewer 67, the two marginal identities, the block bounds, and the band

Independent re-implementation throughout: the `so(n)` basis, the Cartan 3-form tensor, both test points, all six bounds and the linear programme were written from the brief's definitions alone. No `b0_*.py` and no other project script was read, imported or run. Scripts: [review_r67_core.py](../scripts/review_r67_core.py), [review_r67_c1c3.py](../scripts/reviewers/r67/review_r67_c1c3.py), [review_r67_c3.py](../scripts/reviewers/r67/review_r67_c3.py), [review_r67_c4.py](../scripts/reviewers/r67/review_r67_c4.py), [review_r67_c4b.py](../scripts/reviewers/r67/review_r67_c4b.py), [review_r67_c4_attack.py](../scripts/reviewers/r67/review_r67_c4_attack.py), [review_r67_c5.py](../scripts/review_r67_c5.py), [review_r67_lp.py](../scripts/reviewers/r67/review_r67_lp.py). Log: [reviewer67.log](agent_logs/reviewer67.log).

## Headline

**All three bounds in C4 are genuine upper bounds.** Each of the four steps the brief singles out is correct, and I give a proof of every one, including proofs of the two facts they rest on, the row marginal `2(n-2)` (Killing form) and the pair cap `2` (a two-line eigenvalue argument that also identifies the equality case). A hard adversarial search over frames and spectra found no violation anywhere.

**C5 is settled in the negative, and much more strongly than "we could not find one".** No sharper bound *of that kind* exists at all. Everything (a), (b), (c) use is a short list of linear facts about `T`; the linear programme that maximises `theta` over *all* `T` satisfying exactly that list is the class ceiling, and it already stands at **1.6038 at n = 6** and **2.2913 at n = 8**, against targets `1.2247`. At the `n = 8` witness bound (b) equals the class ceiling to five digits, there is not one digit of room left to sharpen. **Frame-realisability is not "the missing ingredient"; it is the only ingredient left.**

**Two new valid bounds are contributed anyway** (a knapsack refinement (d) and a per-row refinement (e)) which cut the band maxima roughly in half while staying **exact at all eight test points**.

## Verdicts

| Claim | Verdict | One line |
|---|---|---|
| C1, two marginal identities, multiplicities 6/4/2 | **CONFIRMED, derived** | Both come from counting ordered arrangements of an unordered triple; residuals `≤ 3.6e-15` at all eight points. |
| C2, `gamma = 2 S_mhh`, `gamma = 0` iff `m^perp` is a subalgebra | **CONFIRMED on `S = 0`; needs a hypothesis added** | In general `gamma = 2 S_mhh − 6 S_mmm`; the stated form and the subalgebra equivalence both need `S_mmm = 0`. |
| C3, the monotonicity is false | **CONFIRMED, and sharpened** | Every number reproduces exactly. Better: `S_mhh = S_mmm = 0` says precisely that `(h,m)` is a *symmetric pair*, so that stratum is a finite list. |
| C4(a) mass form | **CONFIRMED VALID** | Proof below; exact at the four sphere products to `≤ 2.2e-16`; ratios `23.00, 69.00, 152.33, 283.67`. |
| C4(b) spectral form | **CONFIRMED VALID** | LP duality, sound; it also needs `tr W = 0`, which the brief does not list. Exact at padded `W_CP2`; ratios `3.88, 4.92, 5.94, 6.95`. |
| C4(c) min form | **CONFIRMED VALID and exact at all eight** | `≤ 2.2e-16` at every one. |
| C5, the band is not closed by any of them | **CONFIRMED, with one numerical correction and a much stronger conclusion** | The maximum of (c) at `n = 8` is `10.31`, not `8.16` (`d = 15` is right). And **no bound of the class can ever close it**. |
| C6, non-composability; min circumvents it | **CONFIRMED numerically; the stated mechanism is right but one phrase is wrong** | All four ratio ranges reproduce. "Worse than either parent" is false as written, at padded `W_CP2` the swap (`2.04`) beats parent (a) (`28.17`) by a factor of 14. |

## Conventions, re-derived

With `<X,Y> = ½ tr(X^T Y)` the `phi_ij = E_ij − E_ji` are orthonormal, `omega(x,y,z) = <[x,y],z>` is totally antisymmetric, and in the `phi` basis it is supported exactly on the triangles of `K_n` with values `±1`. Both test points were rebuilt from their definitions and reproduce their recorded invariants exactly:

| n | point | d | theta | S_mmm | S_mmh | S_mhh | S_hhh |
|---|---|---|---|---|---|---|---|
| 6 | padded `W_CP2` | 2 | 1.2247448714 | 0 | 2 | 4 | 14 |
| 6 | balanced sphere | 9 | 1.0540925534 | 0 | 18 | 0 | 2 |
| 8 | padded `W_CP2` | 2 | 1.2247448714 | 0 | 2 | 8 | 46 |
| 8 | balanced sphere | 16 | 1.1456439237 | 0 | 48 | 0 | 8 |
| 10 | padded `W_CP2` | 2 | 1.2247448714 | 0 | 2 | 12 | 106 |
| 10 | balanced sphere | 25 | 1.2000000000 | 0 | 100 | 0 | 20 |
| 12 | padded `W_CP2` | 2 | 1.2247448714 | 0 | 2 | 16 | 202 |
| 12 | balanced sphere | 36 | 1.2360330812 | 0 | 180 | 0 | 40 |

The two structural facts the whole edifice rests on are **proved here, not assumed**.

**Row marginal.** `sum_{b,g} T_abg = sum_b ||[v_a,v_b]||² = ||ad(v_a)||²_HS = −B(v_a,v_a)` with `B` the Killing form. For `so(n)`, `B(X,Y) = (n−2) tr(XY) = −2(n−2)<X,Y>`, so the row sum is `2(n−2)` for every unit `v_a`. Measured deviation over 800 random orthonormal frames at `n = 5,6,7,8`: `≤ 1.8e-14`.

**Pair cap.** Bring a unit `x` to block form with angles `θ_1 ≥ θ_2 ≥ …`, so `sum θ_i² = 1`. The eigenvalues of `ad(x)` on `Λ²Rⁿ` are `± i(θ_i ± θ_j)` and `± i θ_i`, so `||ad(x)||_op = θ_1 + θ_2 ≤ sqrt(2(θ_1²+θ_2²)) ≤ sqrt 2`. Hence `sum_g T_abg = ||[v_a,v_b]||² ≤ 2`, **with equality only when `θ_1 = θ_2 = 1/sqrt2` and the rest vanish**, i.e. when `x` is `1/sqrt2` times a complex structure on a 4-plane. That is exactly `A_1 = (phi_12+phi_34)/sqrt2`, which is why padded `W_CP2` saturates the cap (`max_pair = 2.000000`) and the sphere product does not (`max_pair = 1.000000`). This single observation explains every exactness pattern in C4.

## C1, CONFIRMED, and derived rather than measured

Sum the row marginal over the `d` rows in `m`. Ordered triples `(a,b,g)` with `a ∈ m` fall into three patterns, and the multiplicity of each is the number of ordered arrangements of the corresponding unordered triple that put an `m`-index first:

- all three in `m`: `3! = 6` arrangements → `6 S_mmm`;
- two in `m`, one in `h`: 2 choices of which `m`-index leads, `2` arrangements of the rest → `4 S_mmh`;
- one in `m`, two in `h`: the `m`-index must lead, `2` arrangements of the rest → `2 S_mhh`.

`6 S_mmm + 4 S_mmh + 2 S_mhh = 2 d (n−2)`. Summing instead over the `N−d` rows in `h`: `6 S_hhh`, then `4 S_mhh` (2 choices of leading `h`-index × 2), then `2 S_mmh` (the `h`-index leads, 2 arrangements), `6 S_hhh + 4 S_mhh + 2 S_mmh = 2(N−d)(n−2)`. **The multiplicities 6/4/2 are correct and the derivation is a two-line count.** With `S_mmm = 0` the stated solutions follow by elimination, and both are reproduced exactly at all eight points (residual `≤ 3.6e-15`).

**A caveat the brief's instruction anticipates.** Fitting integer weights `(w_mmm, w_mmh, w_mhh)` to identity 1 against all eight test points leaves `w_mmm` completely free (every value from 0 to 8 fits) because `S_mmm = 0` at all eight. **The `6` in the first identity is invisible to measurement on this test set and can only be derived.** Identity 2 is pinned uniquely to `(6, 4, 2)` by the same fit. So "verify by deriving, not only by measuring" was the right instruction.

Independent confirmation of the pair cap's equality case: maximising `||ad(x)||_op` over unit `x` returns `1.4142135624 = sqrt 2` at every `n = 4,…,8`, so the cap `2` is attained and not merely an upper bound.

The one-parameter-family reading is right: at fixed `n, d` and `S_mmm = 0`, `S_mhh` determines `S_mmh` and `S_hhh`.

## C2, CONFIRMED on `{S = 0}`; the general statement needs `S_mmm = 0` added

Every step checks out, with the multiplicities counted the same way:

- `mu = sum_{a,b ∈ m} ||[e_a,e_b]||² = 6 S_mmm + 2 S_mmh`;
- `X = sum_{a ∈ m, b ∈ h} ||[e_a,e_b]||² = 2 S_mmh + 2 S_mhh`;
- `mu + X = sum_{a ∈ m} sum_{b} ||[e_a,e_b]||² = 2(n−2) d`, the row marginal again;
- hence `gamma := 2(n−2)d − 2 mu = (mu + X) − 2 mu = X − mu = **2 S_mhh − 6 S_mmm**`.

So the brief's `mu = 2 S_mmh` and `gamma = 2 S_mhh` are the `S_mmm = 0` specialisations, exactly as intended, and they hold to machine precision at all eight points. **The correction is small but real: without `S_mmm = 0`, `gamma = 0` does not imply `S_mhh = 0`** (it implies `S_mhh = 3 S_mmm`), so the chain "`gamma = 0` iff `[h,h] ⊆ h` iff `m^perp` is a subalgebra" needs `S_mmm = 0` as a standing hypothesis. On `{S = 0}` it is exactly right, since `S_mhh = 0` says `<[h,h],m> = 0`.

## C3, CONFIRMED the refutation, and it can be made much sharper

Every number in the counterexample reproduces exactly: padded `W_CP2` has `S_mhh = 4, 8, 12, 16` at `n = 6, 8, 10, 12` (i.e. `2(n−4)`) with `theta = sqrt(3/2)` throughout and `S_mmm = 0` (trivially, `m` is a 2-plane and `omega` is a 3-form); the balanced sphere product has `S_mhh = 0`, `S_mmm = 0` and `theta = 1.0540926, 1.1456439, 1.2000000, 1.2360331 = theta_0(n)`. Below the crossover `n = 6+2sqrt7 ≈ 11.29` the larger `S_mhh` wins. **The refutation stands.**

It can be stated far more strongly, because the `S_mhh = 0` stratum of `{S = 0}` is *classified*, not merely constrained:

> `S_mmm = 0` says `[m,m] ⊥ m`, i.e. `[m,m] ⊆ h`. `S_mhh = 0` says `[h,h] ⊥ m`, i.e. `[h,h] ⊆ h`. Together with `[h,m] ⊆ m` (automatic, by invariance of `omega`), that is exactly a **`Z_2`-graded (symmetric) decomposition** of `so(n)`. So the `S_mhh = 0` stratum is the finite list `h = so(p)+so(q)` and `h = u(n/2)`, nothing else.

The tempting monotonicity therefore predicts that the maximiser of `theta` over `{S = 0}` lies on that finite list. Maximising `theta` over each member (rotations inside `h`, rotations inside `m`, and the spectrum; [review_r67_c3.py](../scripts/reviewers/r67/review_r67_c3.py)) gives at `n = 6`:

| `h` | `dim h` | `d` | max `theta` found |
|---|---|---|---|
| `so(1)+so(5)` | 10 | 5 | 0.884973 |
| `so(2)+so(4)` | 7 | 8 | **1.112603** |
| `so(3)+so(3)` | 6 | 9 | 1.054093 = `theta_0(6)` |

against `sqrt(3/2) = 1.224745` at padded `W_CP2`, which has `S_mhh = 4`. So the prediction fails against the *whole stratum*, not merely against one member of it. Two by-products worth recording: the search recovers `theta_0(6)` exactly at `so(3)+so(3)`, which validates it; and **inside the graded stratum the balanced sphere product is not the maximiser at `n = 6`**, `so(2)+so(4)` reaches `1.1126` once the spectrum is allowed more than two values. (Those points are `S = 0` tensors, not necessarily Weyl operators, so this bounds the stratum, not the critical set.)

## C4, the validity question, settled: **all three are genuine upper bounds**

This is the claim the brief calls load-bearing, so I give the whole chain rather than a verdict. Write the eigenvalue decomposition of `theta` by sign block,

`theta = sum lam³ + 3[(+++) + (++−) + (+−−) + (−−−)]`,

where each block is `sum` over unordered triples of `T · lam_a lam_b lam_g` restricted to that sign pattern.

### The four steps the brief asks about

1. **`(++−) ≤ 0`.** Two positive factors and one negative give a negative product, and `T ≥ 0`. **True, and true unconditionally, `S = 0` is not needed.** Same for `(−−−) ≤ 0`; on `{S = 0}` it is `= 0` outright, which is a stronger statement than the argument needs.
2. **`(+++) ≤ lam_1³ S_hhh`.** Every positive triple is an `h`-triple (`h ⊇` the positive eigenspace, since `h = m^perp` holds the zeros too), each factor is `≤ lam_1`, and `T ≥ 0`, so dropping to all `h`-triples only adds nonnegative terms. **True.** Loose by exactly the zero-eigenvalue triples, which is where the `23x–284x` overshoot at padded `W_CP2` comes from.
3. **`(+−−) ≤ lam_1 b² S_mmh`.** A `(+−−)` triple has two indices in `m` and one positive index in `h`, and `S_mmh` counts all such triples with the third index anywhere in `h`. `lam_a |lam_b||lam_g| ≤ lam_1 b²`. **True.**
4. **`3(+++) ≤ h_3 (s²−u)` when `d ≥ 3`.** **True, and `d` is irrelevant to it.** Relax to the LP `max 3 sum_{a<b<g positive} T lam_a lam_b lam_g` subject to `T ≥ 0` and `sum_{g positive} T_abg ≤ 2`, valid because the true pair cap sums over *all* `g` and `T ≥ 0`. Its dual is `min 2 sum_{a<b} z_ab` subject to `z_ab + z_ag + z_bg ≥ 3 lam_a lam_b lam_g`, `z ≥ 0`. Take `z_ab = mu lam_a lam_b`: feasibility reads `mu ≥ 3/(1/lam_a + 1/lam_b + 1/lam_g)`, the harmonic mean of the triple, which is increasing in each argument, so the binding value is the harmonic mean `h_3` of the **three largest** positives. The dual objective is `mu · (s² − u)`. Weak duality gives the bound. Nothing in this refers to the negative eigenspace; a large `d` only means more of each pair's budget is spent outside the positive block, which makes the true `(+++)` *smaller*. With fewer than three positives, `(+++) = 0` and `h_3 = 0`, so it degenerates correctly.

### Assembling (a)

From the second marginal identity with `S_mmm = 0` and `S_mhh ≥ 0`: `S_hhh ≤ (n−2)(2N−3d)/6`. From the first: `S_mmh ≤ d(n−2)/2`. Combining with steps 1–3,

`theta ≤ sum lam³ + (3/2) lam_1 b² (n−2) d + (1/2) lam_1³ (n−2)(2N−3d)`. **VALID.**

It needs `S_mmm = 0` (that hypothesis is used twice, once in each mass bound) and it does *not* need `tr W = 0`. (`2N − 3d > 0` throughout the admissible range, since `d ≤ floor(n²/4)` gives `2N − 3d ≥ n²/4 − n > 0` for `n > 4`, so the second term is never a negative "bound" on a nonnegative mass.)

### Assembling (b)

For `(+−−)`, group by the `m`-pair: `3(+−−) = 3 sum_{b<g ∈ m} |lam_b||lam_g| sum_{a>0} T_abg lam_a ≤ 3 lam_1 · 2 · sum_{b<g ∈ m} |lam_b||lam_g| = 3 lam_1 ((sum_m |lam|)² − v)`. **The step that turns `(sum_m |lam|)²` into `s²` is tracelessness**, `sum_m |lam| = s`. Combined with step 4 and `(++−), (−−−) ≤ 0`,

`theta ≤ sum lam³ + h_3 (s²−u) + 3 lam_1 (s²−v)`. **VALID.**

**A witness for the tracelessness hypothesis.** Applying (b)'s formula literally to the operator `(1,−1,−1)/sqrt3` on the self-dual 3-space of `Λ²R⁴` (`tr = −0.5774`) gives `theta = 0.962250` against a formula value of `−0.769800`; the spectrum `(0.5,−1,−1)/1.5` gives `0.333333` against `−1.333333`. Both are legitimate symmetric operators on `Λ²Rⁿ`, they are simply not traceless, and `s² − v` then has nothing to do with `2 sum_{b<g in m} |lam_b||lam_g|`. **So `tr W = 0` is load-bearing in (b), not decorative.** (Weyl operators are traceless, so the bound is fine where it is used; the hypothesis just needs to be written down.)

**One correction to how (b) is filed.** It uses the pair cap, `T ≥ 0` and `tr W = 0`, and *nothing else*. It does **not** need `S_mmm = 0`: `(−−−) ≤ 0` holds for sign reasons alone. So (b) is a bound on *every* traceless `W`, which is a strictly stronger statement than the record makes, and the reason it has no `n` in it. Conversely `tr W = 0` is a genuine hypothesis that the brief's statement of (b) omits; dropping it breaks the bound immediately.

### Assembling (c)

Both terms of each `min` bound the *same* block, so the min of the two is a bound on that block. **VALID**, needing `S_mmm = 0` and `tr W = 0` together.

### Numerical confirmation of exactness, and of the failure ratios

| n | point | `theta` | (a) | (a)/θ | (b) | (b)/θ | (c) | (c)/θ | swap | swap/θ |
|---|---|---|---|---|---|---|---|---|---|---|
| 6 | padded `W_CP2` | 1.224745 | 28.1691 | 23.00 | 1.224745 | **1.0000** | 1.224745 | **1.0000** | 2.0412 | 1.67 |
| 6 | balanced sphere | 1.054093 | 1.054093 | **1.0000** | 4.0899 | 3.88 | 1.054093 | **1.0000** | 1.8130 | 1.72 |
| 8 | padded `W_CP2` | 1.224745 | 84.5074 | 69.00 | 1.224745 | **1.0000** | 1.224745 | **1.0000** | 2.8577 | 2.33 |
| 8 | balanced sphere | 1.145644 | 1.145644 | **1.0000** | 5.6347 | 4.92 | 1.145644 | **1.0000** | 2.2679 | 1.98 |
| 10 | padded `W_CP2` | 1.224745 | 186.5695 | 152.33 | 1.224745 | **1.0000** | 1.224745 | **1.0000** | 3.6742 | 3.00 |
| 10 | balanced sphere | 1.200000 | 1.200000 | **1.0000** | 7.1259 | 5.94 | 1.200000 | **1.0000** | 2.6815 | 2.23 |
| 12 | padded `W_CP2` | 1.224745 | 347.4193 | 283.67 | 1.224745 | **1.0000** | 1.224745 | **1.0000** | 4.4907 | 3.67 |
| 12 | balanced sphere | 1.236033 | 1.236033 | **1.0000** | 8.5909 | 6.95 | 1.236033 | **1.0000** | 3.0748 | 2.49 |

Every bolded entry is equality to `≤ 2.2e-16`. All four claimed ratio ranges, `23x–284x`, `3.9x–7.0x`, `1.67x–3.67x`, `1.72x–2.49x`, reproduce.

**Why the exactness is structural, not luck.** At the balanced sphere product `h` is a subalgebra, so `S_mhh = 0` makes *both* mass bounds equalities; the spectrum takes two values, so `lam_1³` and `lam_1 b²` are attained on every triple; and `S_hhh` contains no zero-eigenvalue triples because there are no zero eigenvalues. Hence (a) is an identity there. At padded `W_CP2` there is one positive eigenvalue, so `(+++) = 0 = h_3(s²−u)`; the single `m`-pair `(A_2,A_3)` saturates the pair cap at exactly `2`, the equality case of the cap proof above, `A_1` being `1/sqrt2` times a complex structure on the 4-plane, and the one positive eigenvalue *is* `lam_1`. Hence (b) is an identity there.

### The attack that failed

I tried to break validity rather than confirm it. Free variables: the orthonormal eigenframe of `so(n)` (first `d` columns spanning an isotropic subspace, so `S_mmm = 0` holds exactly) and the spectrum (negative exactly there, traceless, unit). Objective `theta − bound`; any positive value is a refutation. Three modes ([review_r67_c4.py](../scripts/reviewers/r67/review_r67_c4.py), [review_r67_c4_attack.py](../scripts/reviewers/r67/review_r67_c4_attack.py)):

- **`d ≤ 2`**, where every `d`-plane is isotropic, so the frame is *completely unconstrained* and this is exactly the stratum where (b) and (c) are exact. Frame hill-climb (`expm` of random skew perturbations) alternating with spectrum optimisation, `n = 6,7,8`.
- **local ascent seeded at the two exact points**, where the bounds have zero margin and any wrong sign in the derivation would show up immediately.
- **random isotropic `m ⊆` the symmetric-pair odd part**, `d` from 3 up to the cap, `n = 6,8,10`.

**No violation anywhere.** At the balanced sphere product the best attainable is `theta − (a) = theta − (c) = 0.0` exactly; at padded `W_CP2`, `theta − (b) = theta − (c) = −1.8e-15`. The margins elsewhere are genuinely small (`−9.5e-3` for (b) at `n=6, d=3`), so the search is landing near tightness rather than far from it.

**One false alarm, worth recording because it is a trap in this exact computation.** My first run reported `theta − (b) = +3.9e-8` at `n = 6`. It was mine, not the claim's: `spectral_stats` classified eigenvalues with a two-sided tolerance, so the optimiser learned to park eleven eigenvalues at `~1e-9`, where they counted as neither positive nor negative and dropped `9.8e-9` of positive mass out of `s`. Since (b)'s `(+−−)` term is `3 lam_1 (s²−v)` and rests on the identity `s = sum_m |lam|`, losing mass from `s` shrinks the bound by exactly `3 lam_1 · 2s · 9.8e-9 = 3.9e-8`. **Any implementation of (b) that classifies signs with a tolerance is not implementing (b).** Snap to zero first, then classify strictly.

## C5, CONFIRMED, with a numerical correction, and then closed for good

### The recorded numbers

Maximising bound (c) over spectra with `3 ≤ d < floor(n²/4)` ([review_r67_c5.py](../scripts/review_r67_c5.py); structured 6-parameter families over every positive-count, then a full-dimensional polish) confirms the qualitative claim and the location of the argmax, but **not the value**:

At `n = 8` the sweep is complete (`d = 3…15`, cap `16`). The maximum of (c) is **10.3085** at `d = 15`, attained at a spectrum with one large positive (`0.6225`), two mid (`0.2055`) and a flat tail. So the recorded location is right and the recorded value `8.16` is about 26% low, an under-converged maximisation, not a different quantity. **The conclusion the number was carrying (the band is wide open), is only strengthened.**

The same correction holds at the other two dimensions, and by more (targets: `1.224745` at `n = 8,10`, `1.236033` at `n = 12`). Sweeping `d` upward (the bound is monotone increasing in `d` over almost the whole range, so these are the values at the top of the sweep rather than at an interior peak):

| n | `d` swept | recorded max of (c) | this review's max of (c) | at `d` | max of (d) | max of (e) |
|---|---|---|---|---|---|---|
| 8 | 3…15 (complete) | 8.16 | **10.3085** | 15 | 6.9233 | 5.5650 |
| 10 | 3…22 | 11.13 | **≥ 15.8106** | 22 | ≥ 11.0380 | ≥ 8.3453 |
| 12 | 26…32 | 13.78 | **≥ 22.7491** | 32 | ≥ 15.8141 | ≥ 10.4041 |

So the recorded band maxima are low by 26%, at least 42% and at least 65% respectively (the `n = 10` and `n = 12` sweeps were stopped short of the cap; both columns were still rising in `d`). **The three new numbers make the gap between the bounds and the target wider, not narrower**, which is the direction that matters for the conclusion the record draws from them.

### A sharper valid bound: (d) and (e)

Two refinements, both valid by the same block-wise-minimum argument that licenses (c):

**(d), knapsack.** For `(+++)`, the mass `sum T` over positive triples is at most `S_hhh ≤ (n−2)(2N−3d)/6` *and* each individual `T_abg ≤ 2` (immediate from the pair cap). So the block is at most `3 ×` the fractional-knapsack value: spend the mass budget on the largest triple products `lam_a lam_b lam_g`, at most `2` per triple. Same for `(+−−)` with the `m`-pair products `|lam_b||lam_g|`, budget `S_mmh ≤ d(n−2)/2`. This dominates *both* halves of (c)'s minima at once: `lam_1³ ×` mass is the knapsack with every product replaced by its maximum, and `h_3(s²−u)` / `3 lam_1 (s²−v)` are the knapsack with the mass budget removed.

**(e), per-row.** The row marginal is an identity for *every* index, not only in aggregate: `sum_{b<g} T_abg = n−2` for each `a`. So `3(+++) = sum_{a>0} lam_a sum_{b<g} T_abg lam_b lam_g ≤ sum_{a>0} lam_a · knap(pairs of the other positives; cap 2; budget n−2)`, and likewise `3(+−−) ≤ 3 s · knap(m-pairs; cap 2; budget n−2)`. Take the minimum with (d)'s terms.

**Both stay exact at all eight test points** (`≤ 8.9e-16`), because at the sphere product every product is equal so the knapsack is the mass bound, and at padded `W_CP2` the single `m`-pair takes the whole cap.

*(An implementation warning I had to learn the hard way: the knapsack candidate list must not be truncated to the top few eigenvalues. A pair `(1, k+1)` can beat a pair `(k−1, k)`, so truncation **under**-estimates the knapsack, and an under-estimated knapsack is not an upper bound. The list is padded with copies of a value dominating every excluded term.)*

### The band still is not closed, and now provably cannot be, by anything of this kind

Bounds (d) and (e) cut the band maxima by roughly a factor of two, and they are still two orders of magnitude away from the target. That is not a failure of ingenuity, and the remaining work should not be spent on a sixth variant. Here is why.

**Every bound of this kind is a function of `lam`, `d`, `n` that is valid for every `T` obeying a fixed short list of linear facts:** `T ≥ 0`, totally symmetric, vanishing on repeated indices; `sum_{b,g} T_abg = 2(n−2)`; `sum_g T_abg ≤ 2`; `T = 0` on triples inside `m`. (Bounds (a)–(e) use nothing else; (b), (d), (e) additionally use `tr W = 0`, which is a fact about `lam`.) So for any such bound `B`,

  `B(lam, d, n) ≥ LP(lam, d, n) := max { theta(lam,T) : T obeys that list }`,

and the linear programme on the right is computable exactly ([review_r67_lp.py](../scripts/reviewers/r67/review_r67_lp.py); `C(N,3)` variables, `N` equalities and `C(N,2)` inequalities, solved with HiGHS). **Explicit witnesses, every constraint verified on the returned `T` to `≤ 7.1e-15`:**

| n | d (in the band) | `theta(lam, T*)` | target | (a) | (b) | (c) | (d) | (e) |
|---|---|---|---|---|---|---|---|---|
| 6 | 4 | **1.603821** | 1.224745 | 7.0720 | 1.9269 | 1.9269 | 1.8754 | 1.8754 |
| 8 | 4 | **2.291288** | 1.224745 | 12.7676 | **2.2917** | **2.2917** | **2.2917** | **2.2917** |
| 12 | 10 | **2.494207** | 1.236033 | 26.1186 | 4.5540 | 3.4916 | 3.4916 | 3.4916 |

Read the middle row. At `n = 8, d = 4` bound (b) (and hence (c), (d), (e)), **already equals the class ceiling to five digits**. There is literally nothing left to sharpen at that spectrum: the LP's optimal `T*` is a totally symmetric, nonnegative tensor with the exact row marginals `2(n−2) = 12`, pair sums capped at `2.000000`, and `S_mmm = 0`, whose `theta` is `2.2913`, `1.87` times `sqrt(3/2)`. Sweeping the whole band at `n = 8` the ceiling peaks at `2.2910` (`d = 5`) and is still `1.6327` at `d = 11`, the last value swept.

> **Answer to C5's second question: a sharper valid bound of this kind that stays below `max(sqrt(3/2), theta_0(n))` does not exist.** Not "was not found", cannot exist, because a `T` meeting every constraint such a bound is entitled to use already has `theta = 1.60` at `n = 6` and `2.29` at `n = 8`.

This converts the record's diagnosis into a theorem of sorts. The record says "what is missing is which spectra an `S = 0` Weyl tensor can actually have… that is frame-realisability". The LP shows that frame-realisability is not merely *a* missing ingredient but the *only* remaining one: the marginal/pair-cap/isotropy relaxation is exhausted, and it overshoots by 31% at `n = 6`, 87% at `n = 8` and 102% at `n = 12`. Any further progress has to constrain `T` by something that is not a marginal, the record's own `b(W^#) = −b(W²)` relation is the natural candidate, since it couples `lam` to the frame.

## C6, CONFIRMED numerically; the mechanism is right, one phrase is not

The swap (keep (b)'s `h_3(s²−u)` for `(+++)`, take (a)'s `(3/2) lam_1 b² (n−2) d` for `(+−−)`) reproduces every recorded ratio: `1.67, 2.33, 3.00, 3.67` at padded `W_CP2` and `1.72, 1.98, 2.23, 2.49` at the balanced sphere products (table above). It is exact at neither end, and the stated reason is correct: each parent's exactness is a property of the *pairing*. At the sphere product `S_mhh = 0` makes the mass bounds equalities while `h_3(s²−u)` charges all `C(P,2)` positive pairs at full weight; at padded `W_CP2` the pair cap is attained on the single `m`-pair while the mass bound `(3/2) lam_1 b²(n−2)d` grows linearly in `n` against a truth that does not.

**The correction.** "Worse than either parent everywhere" is false as a statement about both parents. At padded `W_CP2` the swap is `2.04, 2.86, 3.67, 4.49` while parent (a) is `28.17, 84.51, 186.57, 347.42`, the swap beats (a) there by a factor of `14` to `77`. The true and defensible statement is: **the swap is worse than `min(a,b)` at every one of the eight points, and tight at none.** Since `min(a,b) ≥ (c)`, that is the same as saying it is dominated by (c).

**Taking the min circumvents rather than violates non-composability, and the reason is structural.** Non-composability is a statement about *choosing* one estimate per block once and for all: any fixed choice is loose wherever the other choice is the tight one. The `min` makes no choice, both estimates remain valid bounds on the *same* block, so their pointwise minimum is a bound on that block, and at each end it silently selects the tight one. That is why (c) is exact at all eight points while every fixed pairing is exact at most at one end. **No contradiction: the fence post is about term-swapping, not about taking minima.** The same argument licenses the further minima in bounds (d) and (e) above.

## What I attacked and failed to break

Stated plainly, because it is the honest half of an adversarial report.

- **The validity of (a), (b), (c).** This was the target and I went at it hardest: three attack modes, joint frame-and-spectrum hill-climbing, seeded at the exact points where the margin is zero, plus the `d ≤ 2` stratum where the frame is entirely unconstrained. Nothing. Every apparent violation traced back to my own numerics (twice), and the derivations survive step by step. Bounds (d) and (e), which I added, were also attacked and held.
- **The four step-level checks the brief listed.** `(+++) ≤ lam_1³ S_hhh`, `(+−−) ≤ lam_1 b² S_mmh`, `(++−) ≤ 0`, and the harmonic-mean dual at `d ≥ 3` are all correct; I could not find a hypothesis any of them needs beyond `S_mmm = 0` (for (a)) and `tr W = 0` (for (b)).
- **The 6/4/2 multiplicities.** Both identities derive from a two-line count of ordered arrangements, and identity 2 is uniquely pinned by the data as well.
- **`gamma = 2 S_mhh`.** The three ingredients (`mu`, `X`, `mu + X = 2(n−2)d`) are each individually right, and the conclusion is right on `{S = 0}`.
- **The exactness claims.** All eight equalities hold to `≤ 8.9e-16`, at (a), (b), (c) and at the two new bounds, and each has a structural explanation rather than a coincidental one.
- **C3's counterexample.** I looked for a way the comparison could be unfair (different `d`, different `n`-dependence) and instead found that it can be *strengthened*, since the `S_mhh = 0` stratum is a finite classified list whose maximum I could bound directly.

## Corrections, in order of how much they matter

1. **C5's maximum of (c) at `n = 8` is `10.3085`, not `8.16`** (`d = 15` is right). The recorded figure is an under-converged maximisation. The conclusion drawn from it is unaffected and, if anything, understated.
2. **Bound (b) does not need `S_mmm = 0`, and does need `tr W = 0`.** It is a bound on every traceless symmetric operator on `Λ²Rⁿ`; `(−−−) ≤ 0` holds for sign reasons alone. Filing it as an "`S = 0` bound" understates it, and the tracelessness hypothesis it actually uses is not stated anywhere in the claim.
3. **C2's `gamma = 2 S_mhh` and the subalgebra equivalence need `S_mmm = 0` stated.** In general `gamma = 2 S_mhh − 6 S_mmm`.
4. **C6's "worse than either parent everywhere" is false as written**, at padded `W_CP2` the swap beats parent (a) by a factor of 14 to 77. The defensible statement is that it is dominated by `min(a,b) = (c)` at all eight points and tight at none.
5. **C5's conclusion should be upgraded.** "The band is not closed by any of them" is true but weak; the LP witnesses show no bound of that kind can ever close it, so the file should stop paying for variants.

## Where this leaves the item

The block-bound line of attack is finished as a source of new information, and it finished in a good place: two of its outputs are *exact* at the two families that bracket the problem, which is a real structural fact, (a) is an identity wherever `h` is a subalgebra and the spectrum is two-valued, (b) is an identity wherever a single `m`-pair saturates the pair cap against a single positive eigenvalue. What it cannot do is say anything about the region between them, and the LP witnesses show that is not a defect of the particular expressions but of the information they are built from. The next constraint has to see the *frame*, not just the marginals.


---

## Synthesis carried in REVIEW.md

### Reviewer 67: the marginal identities, the block bounds, and the class ceiling

Full report in [reviews/REVIEW_r67.md](reviews/REVIEW_r67.md). Independent re-implementation throughout; all jobs killed before filing.

**All three bounds are genuine upper bounds**, every step proved rather than measured, including the two facts they rest on: the row marginal $2(n-2)$ is $-B(v,v)$ for the Killing form, and the pair cap $2$ follows from $\|\mathrm{ad}(x)\|_{\rm op}=\theta_1+\theta_2\le\sqrt2$ at unit $x$, with equality exactly when $x$ is $\tfrac1{\sqrt2}$ times a complex structure on a 4-plane, which is why padded $W_{\mathbb{CP}^2}$ saturates it and the sphere product does not. Adversarial search over frames and spectra found no violation; two apparent violations at $3.9\times10^{-8}$ and $3.9\times10^{-10}$ were its own sign-classification tolerance, traced and fixed.

**The class is closed for good.** The LP maximising $\theta$ over *all* $T$ obeying that list of linear facts is the class ceiling, with witnesses exhibited and every constraint verified: $1.6038$ at $n=6$, $2.2913$ at $n=8$, $2.4942$ at $n=12$, against targets $1.2247$ and $1.2360$. At the $n=8$ witness the spectral bound **equals the ceiling to five digits**. Two further valid bounds are contributed (a knapsack refinement and a per-row refinement) which halve the band maxima and stay exact at all eight test points, and still fall far short.

**Corrections.** (b) needs $\mathop{\mathrm{tr}}W=0$, with the explicit witness $(1,-1,-1)/\sqrt3$ giving $\theta=0.9623$ against formula value $-0.7698$, and it does **not** need $S=0$, bounding every traceless operator. $\gamma=2S_{\mathfrak{mhh}}$ needs $S_{\mathfrak{mmm}}=0$ as a standing hypothesis, the general law being $2S_{\mathfrak{mhh}}-6S_{\mathfrak{mmm}}$. The recorded band maxima were under-converged: $10.3085$ at $n=8$ rather than $8.16$, $\ge15.81$ at $n=10$, $\ge22.75$ at $n=12$. And "worse than either parent everywhere" is false, at padded $W_{\mathbb{CP}^2}$ the swap beats parent (a) by $14\times$; the defensible form is that it is dominated by $\min(a,b)$ and tight at neither end.

**A methodological catch worth keeping**: fitting integer weights to the first identity against the eight test points leaves $w_{\mathfrak{mmm}}$ free, because $S_{\mathfrak{mmm}}=0$ at all of them, **the $6$ is invisible to measurement there**, so the instruction to derive rather than measure was load-bearing.

**Bonus, and it is the most useful item.** $S_{\mathfrak{mhh}}=S_{\mathfrak{mmm}}=0$ says exactly that $(\mathfrak h,\mathfrak m)$ is a **symmetric pair**, so that stratum is the finite list $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$, $\mathfrak u(n/2)$. Maximising $\theta$ over the whole list gives $1.1654$ at $n=6$ (at $\mathfrak u(3)$), $1.1456$ at $n=8$, $1.2041$ at $n=10$, all below $\sqrt{3/2}$, so the refutation bites against the entire stratum rather than one point. *Side finding: inside the graded stratum the balanced sphere product is **not** the maximiser at $n=6$ or $n=10$.*
