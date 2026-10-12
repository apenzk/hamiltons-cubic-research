# Gate 2, Reviewer 115: the sign convention, the kernel tolerance, and what the cone sweep can say

Independent rebuild from the definitions, `so(n)` structure constants, `R^#`, `Weyl_n` as the nullspace of Bianchi plus Ricci, the block masses `S_ABC`, and a Newton solver on the criticality equation, written before any project script was opened. Every number below is mine unless labelled as the record's.

## Verdicts

| # | Claim | Verdict | The number that decides it |
| --- | --- | --- | --- |
| 1 | Two conditions, and `S_hhm = S_hmh` identically | **CONFIRMED** | `S_hhm - S_hmh = 0` exactly everywhere tested, and it is a theorem, not a measurement |
| 2 | `theta = -1.054093` gives `S_mmm = 12`, `S_hhm = 36`; `theta = +1.054093` is graded | **CONFIRMED** | both signs reproduced from the product metric, not from a vertex matrix |
| 3 | `theta = 0.418198` is ungraded: `S_mmm = 21.5213`, `S_hhm = 7.1738`, `dim m = 10` | **CONFIRMED** | `theta = 0.418198317`, gap `0.00217480`, and `S_mmm(-W) = 3.9e-25`, the old `S = 0` located exactly |
| 4 | Kernel tolerance: true `dim m = 2`, `S_hhm = 8`; without it `dim m = 5`, `S_mmm = 2.64` | **CONFIRMED** | `2.6443` reproduced; and `S_hhm(padded CP2 in R^n) = 4(n-4)` exactly |
|, | The inference from the zero-graded sweep | **CONFIRMED in conclusion, REFUTED in scope** | graded excess `9`, ungraded excess `0` in `122/122`; and gradient ascent reaches `sqrt(3/2)` from `100/100` random starts |

## Gatekeepers passed before anything was adjudicated

- `Id^# = (n-2) Id` on `so(6)`, exactly, fixes the `1/2` in the `R^#` convention.
- `dim Weyl_6 = 84`, from the nullspace of 15 Bianchi and 21 Ricci equations on the 120-dimensional `Sym^2(Lambda^2)`.
- `<A, Q_pol(B,C)>` fully symmetric to `1e-9`, so `grad theta = 3 Q(W)` and criticality is a projected eigenvalue equation.
- **`Q` preserves `Weyl_6`.** `|Ric(Q(W))| <= 9e-17` over 20 random Weyl directions, so no projection step is needed and the record's bare `Q(W) = theta W` is literally right rather than shorthand.
- `dim` of the `sigma(3,3)`-invariant subspace of `Weyl_6` is `45`, as claimed.
- `theta` is exactly `SO(6)`-invariant: `|d theta| <= 1.3e-15` under 20 genuine group elements `Lambda^2(exp A)`, not tangent-line approximations to them.

## 1. The two-condition test, CONFIRMED, and it is a theorem

`<[X,Y],Z>` on `so(n)` under `<A,B> = tr(A^T B)/2` is totally antisymmetric, cyclic invariance and antisymmetry in every index pair verified to machine zero. So `S_hhm`, `S_hmh` and `S_mhh` are the same sum over the same index set and their equality needs no computation. Measured anyway: `36 = 36 = 36` at `-W_{S3xS3}`, `14.6966 = 14.6966` and `15.556 = 15.556` at random symmetric operators.

Cross-checked against the bracket definition rather than the index sum, by projecting real commutators:

| point | norm of `Pi_m[m,m]` vs `sqrt(S_mmm)` | norm of `Pi_m[h,h]` vs `sqrt(S_hhm)` | norm of `Pi_h[h,m]` vs `sqrt(S_hmh)` |
| --- | --- | --- | --- |
| `-W_{S3xS3}` | 3.4641 / 3.4641 | 6.0 / 6.0 | 6.0 / 6.0 |
| random | 3.51 / 3.51 | 3.83 / 3.83 | 3.83 / 3.83 |

So the test is exactly `S_mmm = 0 AND S_hhm = 0`, the third condition is the second, and `h`/`m` being orthogonal eigenspaces supplies the direct-sum half of the grading for free.

**Worth adding to the record.** `S_ABC` depends only on the *subspaces*, never on the eigenbasis chosen inside a degenerate eigenspace, since it equals `sum ||Pi_C [X_a,X_b]||^2` over any orthonormal bases of `A` and `B`. Every symmetric point here has a degenerate spectrum, so this is what makes the test well posed without a basis convention. The only genuine choice is the `h`/`m` split, which is what claim 4 is about.

## 2. The sign claim, CONFIRMED

Built from the geometry rather than from a vertex matrix: `R_op` of `S^3(1) x S^3(1)` is `1` on the six within-block 2-planes and `0` on the nine mixed ones; the metric is Einstein with `Ric = 2g`, `s = 12`, so `W = R_op - (s/(n(n-1))) Id = R_op - 0.4 Id`, normalised. Checks: `|Ric(W)| = 2.2e-16`, Bianchi residual `0.0`, `tr W = -2.2e-16`.

| sign | `theta` | `dim m` | `S_mmm` | `S_hhm` | `S_hmm` | `S_hhh` | graded |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `+W` | `+1.054093` | 9 | `0.0` | `0.0` | `36.0` | `12.0` | **YES** |
| `-W` | `-1.054093` | 6 | `12.0` | `36.0` | `0.0` | `0.0` | no |

Every block mass moves, exactly as claimed, and `||Q(W) - theta W|| = 2.7e-16` at both signs. The `theta > 0` split is the symmetric pair `so(6) = so(3)+so(3) + R^3 (x) R^3`, `dim h = 6`, `dim m = 9`, the isotropy decomposition of `SO(6)/(SO(3)xSO(3))`, which is *why* it is graded.

The record's `sphere_product_W(3,3)` builds the same operator by a different route: its entries are `1.5` within blocks and `-1` across, mine `0.6` and `-0.4`; after normalisation both are `1/sqrt(10) = 0.3162` and `-0.2108`. **No disagreement.**

## 3. The refutation at `theta = 0.418198`, CONFIRMED

Solved with my own Newton iteration on `(q(x) - theta x, ||x||^2 - 1)` in the 45-dimensional `sigma(3,3)` cone, 600 random starts, no reference to the project's solver. One converged point matches:

```
theta              = 0.418198317
||Q(W) - theta W|| = 4.33e-14      |Ric(W)| = 2.4e-16      Bianchi = 2.2e-16
eigenvalues  -0.3176706 -0.2490763 -0.2270890 -0.1829346 -0.1794237 -0.1767049
             -0.1622569 -0.1336137 -0.1318331 -0.0021748
              0.3059601  0.3222510  0.3664909  0.3720596  0.3960160
smallest |lambda| = 0.00217480
```

| convention | `dim m` | `S_mmm` | `S_hhm` | `S_hhh` | graded |
| --- | --- | --- | --- | --- | --- |
| `+W`, the record's | 10 | **21.521307798668** | **7.173769266223** | `3.9e-25` | no |
| `-W` | 5 | **`3.91e-25`** | `25.652461467555` | `21.52130779867` | no |

All four claimed figures match, and the diagnosis is confirmed exactly: **the recorded `S = 0` is `S_mmm(-W) = 3.9e-25`**, which is `S_hhh(+W)` under the relabelling `m' = h`. Stable under every kernel tolerance from `0` to `1e-4`, so this is a sign error and not a tolerance error.

**Two things the claim does not say, and both strengthen it.**

- **Even on `-W` the point is ungraded**: `S_hhm(-W) = 25.65`. The old record was wrong twice over (wrong sign *and* a one-condition test) and either fix alone would have caught it.
- `S_hhh(+W) = 0` means the 5-dimensional `h` has `[h,h] subset m`, so `h` is not a subalgebra at all. This point is as far from graded as the block structure permits, which makes it a much better witness than "some `S` is nonzero" suggests.

Digit-for-digit against [run_grading_test.py](../scripts/runs/run_grading_test.py), whose row reads `gap 2.1748e-03, theta 0.418198, S_mmm 21.5213, S_hhm 7.1738, dim m 10`. **No disagreement.**

## 4. The kernel tolerance, CONFIRMED

Padded `W_CP2` at `n=6`, built as `diag(2,-1,-1)/sqrt(6)` on the self-dual 3-space of `Lambda^2 R^4 subset Lambda^2 R^6`: `|Ric| = 0.0`, Bianchi `0.0`, `theta = 1.224744871 = sqrt(3/2)` to nine digits, `||Q(W) - theta W|| = 0` exactly, a critical point, not merely a test object. `numpy.linalg.eigh` spreads its 12-dimensional exact kernel over `[-9.5e-17, +8.2e-17]`.

| split | `dim m` | `S_mmm` | `S_hhm` | graded |
| --- | --- | --- | --- | --- |
| `lambda < 0`, no tolerance | **5** | **2.6443** | 16.8814 | no |
| `lambda < -1e-9` | **2** | `4.7e-64` | **8.0** | no |

Both claimed numbers reproduced, `2.6443` included. **The tolerance is load-bearing and the record is right to say so.**

**Two things the claim does not mention.**

- The no-tolerance figures are **not reproducible in principle**. `dim m = 5` and `S_mmm = 2.64` are whatever signs the LAPACK driver happens to put on eleven zeros; a different BLAS, a permuted basis, or a different `n` gives a different answer. That I matched `2.64` is luck, not confirmation. The record should present `2.64` as an illustration, never as a datum that a rebuild must reproduce.
- **Closed form, and it is exact.** `S_hhm` of padded `W_CP2` in `R^n` is `4(n-4)`: measured `0, 4, 8, 12, 16` at `n = 4,5,6,7,8`. The `n=4` zero *is* the record's own "graded in its native dimension 4", and the linear growth is the padding leak `[e_a ^ e_z, e_b ^ e_z] = ±e_a ^ e_b`, counted once per added direction `z`. This is a cheap exact control the record could carry in place of a floating-point one.

## The inference: what the zero-graded sweep does and does not say

### The sweep reproduces

My own basis, my own Newton solver, 400 random starts per cone:

| cone | `dim` | `S3xS3` in it | converged | graded | `theta_max`, Newton | `theta_max`, **ascent** | maximiser `S_mmm` / `S_hhm` / `dim m` |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `sigma(1,5)` | 49 | YES | 296/400 | **0** | 0.645497 | **1.224745** | `6e-33` / **8** / 2 |
| `sigma(2,4)` | 44 | YES | 305/400 | **0** | 0.575081 | **1.224745** | `1e-33` / **8** / 2 |
| `sigma(3,3)` | 45 | YES | 310/400 | **0** | 0.726409 | **1.224745** | `4e-33` / **8** / 2 |
| `J`, `U(3)` | 48 | no | 294/400 | **0** | 0.559949 | **1.224745** | `8e-34` / **8** / 2 |

`1205` converged, `0` graded, against the record's `1493` and `0` (compared against the table published in [findings/nondegeneracy.md](../findings/nondegeneracy.md); a live run of [run_graded_cone_sweep.py](../scripts/runs/run_graded_cone_sweep.py) was started here but had not finished at the time of writing, while [run_grading_test.py](../scripts/runs/run_grading_test.py) was run to completion and agreed digit-for-digit on the decisive row). Subspace dimensions `49, 44, 45, 48` agree exactly. `S^3 x S^3` lies in three of the four cones (residuals `4e-16`, `4e-16`, `3.6e-16`; `0.75` for `J`). **The claim's factual base is sound.**

### The conclusion is right, and the record already carries most of the reason

The gap floor is a lower bound on the smallest nonzero `|lambda|` over the **graded** set. A sweep that samples no graded point constrains it in neither direction. **That is correct and I endorse it.** [findings/nondegeneracy.md](../findings/nondegeneracy.md) already says so, already reports Reviewer 116's 40-direction basin table, and already notes that the sweep misses padded `W_CP2` too, so the reading offered here is not new, and the brief's phrasing is a compressed version of what is on record.

**Where my numbers differ from Reviewer 116's, on the two quantities the reading rests on:**

| radius | R116 recovery of `S3xS3` | mine, 40 draws each |
| --- | --- | --- |
| 0.001 | 68% | **95%** |
| 0.005 | 48% | **95%** |
| 0.01 | 22% | **78%** |
| 0.05 | 32% | **52%** |
| 0.1 | 10% | **18%** |
| 0.5 | 12% | **2.5%** |
| 1.0 | **0%** | **0%** |

Mine is monotone; R116's is not (22% then 32%, 10% then 12%). The difference is the solver (Levenberg–Marquardt on the residual versus Newton with an explicit Jacobian) and the non-monotonicity is LM's step control, not a property of the basin. **Both agree on the only load-bearing entry, `0/40` at radius `1`, where the sweep's own starts sit.** Similarly, my cone ceilings `0.6455 / 0.5751 / 0.7264 / 0.5599` sit below R116's `0.8811 / 0.8811 / 0.7599 / 0.7921`. Both are sampler artefacts and neither is a fact about the cone; the record should stop quoting ceilings to four decimals as if they were.

### Where the scope is wrong, and it matters for the open item

The record's diagnosis, [fence post F13](../findings/fence-posts.md), *"random-start Newton does not reach the high-`theta` basin"*, and its open item (*"a census of the graded critical set needs a method that is not random-start Newton"*), are both scoped to the sampler's **reach**. Two measurements say the real obstruction is elsewhere.

**First: the null result is forced by rank, not by reach.** Inside the `sigma(3,3)` cone, for the Jacobian of the criticality map on the unit sphere:

| point | `ker(Jacobian)` | orbit directions inside the cone | **excess** |
| --- | --- | --- | --- |
| `S^3 x S^3` (graded) | 9 | 0 | **9** |
| all 122 ungraded critical points found | (|), | **0**, in 122 of 122 |
| the `theta = 0.418198` point | 6 | 6 | 0 |

Every graded point at `n=6` is a **degenerate zero** of the criticality map, and a root-finder with a residual cutoff converges to nondegenerate zeros. So `0/1205` is not a coverage shortfall that more starts, better seeds, or more compute would repair, it is what the solver is *for*. In the full 84-dimensional space I reproduce the record's own `(3,3)` exception exactly: `ker(Hess) = 18` against an orbit of `9`, with the orbit lying inside the kernel to `4.5e-15`.

**Second: random starts do reach the top, a different method just has to ask.** Projected gradient ascent on `theta`, from the same random starts:

- `theta_max` over all of `Weyl_6` is `sqrt(3/2) = 1.224744871`. That **value** is already on record ([fence post F1](../findings/fence-posts.md) calls it "the global supremum over `Weyl_n`, which was already known"). What is new is that it is **reached from 100/100 random starts** in the full 84-dimensional space, and 59–60/60 in each of the four cones, in seconds.
- Its spectrum is `{0.816497, -0.408248, -0.408248, 0^12}` (the padded `W_CP2` orbit) and it is **ungraded**: `S_mmm = 0`, `S_hhm = 8`, `dim m = 2`.

So *"random-start Newton does not reach the high-`theta` basin"* is true but reads as a statement about random starts, and it is not: **random starts reach the global maximum every single time under ascent.** The obstruction is root-finding on `Q(W) - theta W`, which is indifferent to `theta` and lands in the dense low-`theta` soup of nondegenerate saddles. Fence post F13 should be restated with that scope, and half the open item is already answered, ascent censuses the top of the `theta` spectrum reliably.

**Third, and this is why the other half of the open item is hard: `S^3 x S^3` is a saddle, so no ascent method will find it either.**

| quantity at `S^3 x S^3`, full `Weyl_6` | value |
| --- | --- |
| constrained Hessian signature | 65 negative, 19 zero, **0 positive** |
| null space, tangential | 18 = 9 orbit + **9 transverse** |
| `theta` change on the transverse null cone, `eps = 0.05` | `+4.2e-5` to `-5.1e-5` |
| the same at `eps = 0.2` | `+2.4e-3` to `-3.6e-3`, scaling as `eps^3` |

The second-order form is negative semidefinite, but on the 9 degenerate directions transverse to the orbit the **cubic** term takes both signs. `S^3 x S^3` is therefore a degenerate saddle of monkey type, not a local maximum, which is exactly why ascent escapes it (19/20 draws at `eps = 0.01`) while Newton still recovers it (31/40). **Both a root-finder and an ascent method will miss the graded points at `n=6`, for the same underlying reason: they are degenerate.** The record's proposed remedy (enumerate isotropy subalgebras), is the right one, and the reason it is *necessary* rather than merely convenient is the excess table above.

### Net verdict on the inference

**CONFIRMED in conclusion, REFUTED in scope.** The sweep is silent on the gap floor: correct. "The search cannot reach graded points from random starts": true of the search actually run, false as stated about random starts. "Says NOTHING": too strong, the same starts under ascent establish that the `theta`-maximiser of `Weyl_6` and of every one of these four cones is `sqrt(3/2)`, ungraded, and strictly above the graded `S^3 x S^3` at `1.054093` (ratio `1.1619`). That is silent on the *floor* but not on the graded set's position in the `theta` spectrum.

## An internal inconsistency in the record, found on the way

[findings/nondegeneracy.md](../findings/nondegeneracy.md) states: *"the two 'leaks' recorded at `W_CP2` as `4.0` and `4.899` are one quantity reported twice, being `sqrt(16)` and `sqrt(24)`."*

Two numbers that are one quantity reported twice must be equal, and `4.0 != 4.899`. My closed form settles where they came from: `S_hhm(padded W_CP2 in R^n) = 4(n-4)`, so `16` is `n=8` and `24` is `n=10`. They are the same *functional* at two different dimensions, never two values at one point. The underlying identity `S_hhm = S_hmh` is correct and I confirm it at `n = 5,6,7,8` (`4/4`, `8/8`, `12/12`, `16/16`). The sentence should say the two recorded leaks were one quantity measured at two different `n`, or one of the two figures is misattributed and should be traced.

## Method note

The shared scratchpad for this session is written concurrently by another agent, and my first library file was overwritten mid-run under a colliding filename. All numbers above were recomputed from scratch in an isolated directory afterwards; the claim-2 and claim-4 results that predated the collision were reproduced there identically before being reported.


---

## Synthesis carried in REVIEW.md

### Reviewer 115's addition, which is the one that changes the conclusion

**The sweep's zero is FORCED by degeneracy, not by basin size.** Every graded point at $n=6$ is a degenerate zero of the criticality map (excess $9$) while all $122$ ungraded points 115 found have excess $0$. Reproduced here independently inside $\sigma(3,3)$: $\ker J=9$ against orbit $0$ at $S^3\times S^3$, and $\ker J=6$ against orbit $6$ at every random-start point. **A residual-cutoff root-finder converges to nondegenerate zeros, so $0$ of $1205$ is structural and no amount of compute changes it.**

**Two consequences the cycle had not drawn.**

- **"Says nothing" was too strong, and fence post F13 needs rescoping.** The same random starts under gradient *ascent* reach $\theta_{\max}=\sqrt{3/2}$ from $100$ of $100$ starts in full $\mathrm{Weyl}_6$ and $59$–$60$ of $60$ per cone. Random starts reach the top fine; **root-finding on the criticality equation** is what cannot see graded points.
- **Isotropy enumeration is necessary, not merely convenient.** $S^3\times S^3$ is a *degenerate saddle*: zero positive Hessian directions, but $\theta$ takes both signs at cubic order on the $9$ null directions transverse to the orbit. So ascent misses it too, and neither general-purpose method can reach it.

**Three corrections to the record.**

- $S_{\mathfrak{hhm}}(\text{padded }W_{\mathbb{CP}^2}\text{ in }\mathbb R^n)=4(n-4)$ **exactly**, confirmed here at $n=4,\dots,9$ as $0,4,8,12,16,20$. It is now the asserted control, replacing a measured $8.000$.
- **[nondegeneracy.md](findings/nondegeneracy.md) was internally inconsistent** in calling the leaks $4.0$ and $4.899$ "one quantity reported twice". The closed form places $\sqrt{16}$ at $n=8$ and $\sqrt{24}$ at $n=10$: one functional, two dimensions. *Corrected.*
- The $\theta=0.418198$ point is ungraded **on both signs**, and $S_{\mathfrak{hhh}}(+W)=0$ means its $\mathfrak h$ is not even a subalgebra.

**Where the two reviewers disagree.** Their basin recovery rates differ, $95/95/78/52/18/2.5/0\%$ against $68/48/22/32/10/12/0\%$, which 115 attributes to Levenberg–Marquardt step control rather than to the basin. **They agree on the only load-bearing figure, $0$ at relative radius $1$**, and the degeneracy mechanism supersedes the argument either rate was serving. *Recorded as an open disagreement rather than resolved by preferring one.*

**Provenance caveat, stated by 115 itself.** It compared against the working tree rather than `HEAD`, which already carried 116's uncommitted references, so its differing rates are a disagreement with work not yet committed. Its decisive row still agreed with its own solver digit-for-digit.


## Reviewers 117 and 118, the product route, and a hypothesis the record had lost

**All four lemmas CONFIRMED. The inference drawn from them is REFUTED, and a second error was found that is larger than the first.**

**SINGLE-AUDITED, and that is a defect in this round.** Reviewer 117 logged its phase plan and died before its first phase transition, leaving no report and no scripts; its partial carries nothing citable. **The two-implementation guarantee is absent here.** What compensates, partly, is that every one of 118's decisive numbers was rebuilt in-session from an independent construction and agreed to every printed digit, the $\perp$-sum witness at $\Pi=5.726473$ and the $834$-dimensional graded subspace both. *That is corroboration by the author, which is weaker than a second cold implementation and is recorded as such.*

| Claim | Verdict | What decides it |
| --- | --- | --- |
| The sharpening $\theta\le[\Pi-\lambda^+_{\min}\Delta]/4$ | **CONFIRMED, and inert** | gain exactly $0$ at every $\Delta=0$ point, which is every point that matters |
| The reduction $\Pi\le2\sqrt6\Rightarrow$ the target | **CONFIRMED as an implication, VACUOUS in fact** | $\Pi=5.726473$ at a *critical* $S=0$ non-diagonal point at $n=12$ |
| $\Pi(\text{padded }W_{\mathbb{CP}^2})=2\sqrt6$ for all $n$ | **CONFIRMED, a real theorem, every step** | residual $\le9\times10^{-16}$ at eight dimensions |
| Two eigenvalues $+\ \Delta=0\Rightarrow$ equality, and the crossover | **CONFIRMED**, with one hypothesis superfluous | $\Pi-2\sqrt6=-0.683,-0.316,-0.099,+0.045,+0.148$ at $n=6,8,10,12,14$ |
| "The failure at diagonal points carries no information" | **REFUTED** | $\Pi=4.954462$ at a **non-diagonal** $S=0$ point with $\theta=1.236031>\sqrt{3/2}$ |

**The route is closed and the closure is [fence post F28](../findings/INDEX.md).** $\Pi$ is unbounded on $\{S=0$, non-diagonal, critical$\}$: the $\perp$-sum $c_1W_{S^k\times S^k}\oplus c_2W_{\mathbb{CP}^2}$ is critical to $10^{-16}$ with $S=0$ exactly, and $\Pi/2\sqrt6$ runs $0.90,1.17,1.41$ at $n=10,12,14$. **Reproduced here to every printed digit from an independent construction.** The mechanism is an argument: criticality forces $1/\theta^2=\sum1/\theta_i^2$, so $\perp$-summing drives $\theta$ down while $\Pi$ grows with $4(n-1)$.

**The larger finding: the target statement had lost its criticality hypothesis**, in [findings/INDEX.md](../findings/INDEX.md), [plan.md](../plan.md), [target.md](target.md) and [bounds.md](bounds.md) alike. Without it the target is false at every even $n\ge12$, by a dimension count rather than a search, the $\mathfrak{so}(6)\oplus\mathfrak{so}(6)$-graded subspace of $\mathrm{Weyl}_{12}$ has dimension $834$ with $S\equiv0$ identically, against a $54$-dimensional diagonal locus. **Four Gate 2 rounds were briefed from those forms**, so they were auditing a statement that is false as written. *Corrected in place; the intended statement is untouched.*

**Three further record errors 118 names.**

- "The recorded bound's failure is entirely at $\Delta=0$" is **false**, the $\perp$-sum witnesses have $\Delta>0$ and fail anyway.
- The named open question *does $\theta>\sqrt{3/2}$ force $\Delta=0$?* is answered **no**.
- [problem.md](problem.md) item 12's "none of the subalgebra family is coordinate-diagonalizable" is **false**: the balanced sphere product is a member and is diagonal.

**And the screen was blind by construction.** [run_lambda_product.py](../scripts/runs/run_lambda_product.py) tested only sphere products and padded $W_{\mathbb{CP}^2}$, every case diagonal or a single padded symmetric space, and **no $\perp$-sum of two nonzero critical points**, which is the family that kills the route. *A screen that cannot contain the falsifier is not evidence, which is [post F25](fence-posts.md) recurring inside a bound rather than inside a hunt.*


## Reviewer 122, the lift is correct and is not a reduction

**Steps 1–5 rederived by hand, residuals $\le3\times10^{-17}$. Step 4's normalisation pinned three independent ways**, against $\tfrac12cc\,RR$ in an orthonormal $\Lambda^2$ basis (difference exactly $0$), against Hamilton's $3$-manifold ODE $\dot x=x^2+yz$, and by being *the only* normalisation making $\mathbb{CP}^2$ critical. **The raw structure-constant sum is twice it**, which is the trap that would have invalidated everything downstream.

**THE CENTRAL FINDING, and it is one line of algebra from the cycle's own boxed identity.** $\lambda\mu=\mu^2-\mathrm{LOSS}$ rearranges to $\mathrm{LOSS}=\mu(\mu-\lambda)$. So "$\mathrm{LOSS}\ge\mu^2/n$" and "$\lambda\le\tfrac{n-1}n\mu$" are **one statement written twice**, every tabulated $\mathrm{LOSS}$ is $\mu^2-\lambda\mu$ the long way, and the three-term decomposition is a proof *strategy* rather than a reduction. **This is [fence post F28](../findings/INDEX.md)'s error repeated one cycle later**, a quantity tight at the extremiser is the original problem.

**Three further blows, each specific.**

- **The proposed next step is maximally lossy.** At every sphere product the $C$-term cancels the $N$-term exactly, so $\mathrm{LOSS}$ *is* the commutator mass and *is* $\mu^2/n$; "drop the commutator mass" forfeits $100\%$ of the margin on the branch it targets.
- **No lossy step is admissible anywhere.** $\mathrm{CD}_n$ is an equality on *both* branches' extremal families, gap $\le7\times10^{-16}$ at $S^6\times S^6$ and at $\mathbb{CP}^2$.
- **The second branch does no work at any known point.** Provably vacuous at $n=4$ ($\mu\le2/\sqrt3$, so $\tfrac{n-1}n\mu\le0.866<\sqrt{3/2}$), inert through $n=11$, and first firing at $n=12$ on the **diagonal** locus the target already excludes.

**Two upgrades and one free consequence.**

- $\mathrm{LOSS}=\mu^2/n$ at $S^p\times S^q$ is now a **theorem for all $p,q\ge2$**, proved by reducing $W$ to three scalars on $\Lambda^2V_1\oplus V_1\wedge V_2\oplus\Lambda^2V_2$ and computing symbolically, upgraded from this cycle's measurement.
- A **criticality-free** form: $\mathrm{LOSS}(h)=\mu^2+\langle Q(W)^{\!\circ}h,h\rangle$ at every Weyl tensor and every eigenvector. *The cycle's "control" tested the $\lambda\mu$ form, not the identity.*
- $\lVert\mathring W\rVert_F^2=3$ gives $\mu<\sqrt3$, so $\mathrm{CD}_n\Rightarrow\lambda\le\sqrt3$ for free.

**Corrections to the record.** $N=\tfrac14\lvert W\rvert^2I$ for **every** Weyl tensor at $n=4$ (the classical $C_{ipqr}C_{jpqr}$ identity) so the recorded counterexample holds only from $n\ge5$; confirmed here at $1.6\times10^{-16}$. And $\operatorname{tr}N=4$, not $1$, under the file's own normalisation.

**A defect in the brief, not the record.** It omitted the target's $S=0$ and non-diagonal hypotheses and stated step 6 as a standalone lemma rather than one branch of $\mathrm{CD}_n$, *the second time this session a brief narrowed the claim it was auditing.* [target.md](target.md) had both right.

**An unstated hypothesis the chain leaned on.** Criticality gives only $\Pi_{\mathcal W}Q(W)=\lambda W$, and $\Pi_{\mathcal W}$ does not commute with the ring map; the step survives because $Q(W)$ is automatically Ricci-flat for Weyl $W$, which the derivation used silently.


## Reviewers 123 and 124, the odd fourth-moment lemma, closed twice over

**Identical briefs, both CONFIRMED all five claims, and both closed the one open lemma, by different proofs.** That is the strongest outcome this gate can produce, and it is the first time this session two reviewers have *added* a theorem rather than removed one.

**Proof I (123): an exact invariance.** If $t_1+t_2+t_3=0$ then $\sum t^4=\tfrac12(\sum t^2)^2$, Newton with $e_1=0$. So on the circle $\{\sum t=0,\sum t^2=\sigma\}\subset\mathbb R^3$ the quartic is **constant**, and the source's asserted "three-coordinate smoothing" is not a smoothing but a circle of directions along which nothing moves. Rotating one coordinate of each of three values around it preserves constraints *and* objective, so the result is still a minimiser with $\le3$ values by Lagrange; choosing the new triple distinct and avoiding the old three gives $\ge4$ values at $n\ge4$. Contradiction.

**Proof II (124): the three-value branch is zero-dimensional.** The depressed cubic forces $r_1+r_2+r_3=0$, and $\sum m_ir_i=0$ pins $r$ to the line spanned by $\mathbf1\times m$, so that branch is indexed by multiplicities alone. A positivity sub-lemma, $(n-1)M_4-M_2^2$ expanding with all $24$ monomials positive, gives $G\ge\tfrac1{n-1}>\tfrac{n^2+3}{n(n^2-1)}$ for $n>3$.

**Both are parity-blind**, so step 3 becomes one theorem rather than two and the even case is a corollary.

**Agreed side answers.** The orthogonality of claim 2 is *purely formal* and uses neither hypothesis, 124 confirmed it on unconstrained random $v$, inner products $10^{-15}$ while row sums ran to $10^0$; what needs both hypotheses exactly is membership. Even-$n$ equality is **forced**, not permitted, since Cauchy–Schwarz equality is an iff. Odd uniqueness holds for $n\ge5$, with $n=3$ the exception where Lemma A makes $\sum v^4\equiv\tfrac12$ on the whole constraint set and everything ties.

**Three corrections to the record, all folded in.** My "at most four values" was lossy, the per-block bookkeeping discarded $r_1+r_2+r_3=0$, and the right statement is at most three. $Z(v)$ is a **negative** multiple of the vertex matrix, so the equality case reads $S=-V/\lVert V\rVert$. And claim 5 has a one-line structural reason rather than a computation: **block-constant elements of $\mathcal D_n$ form a one-dimensional space**, so $Z$ *must* be proportional to the vertex matrix; the cross value it supplies, $Z_{ab}=-Z_{bb}=-\tfrac{n(n-3)}{(n-1)(n-2)(n+1)}$, fills a blank this record carried.

**Recorded so it is not retried:** the divided-difference direction $h_a=1/\prod_{b\ne a}(r_a-r_b)$ is tangent to both constraints *and* an exact null direction of the second-order form at every three-valued stationary point. **No second-order argument can close this lemma**, which is precisely where the author's own attempt stopped.
