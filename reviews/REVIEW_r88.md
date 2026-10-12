# Reviewer 88, the Dimension Lemma and the irreducibility hypothesis

**NO NUMERICAL CHECKING WAS USED.** Every computation in this report is exact: hand algebra plus `sympy` with `Rational`/`symbols`. No floating point, no sampling, no eigenvalue solver, no optimisation. The one place a decimal appears below (`168/13 = 12.923…`) is a decimal *expansion* of an exact rational, not a computed float.

**Method.** Claims 1, 2, 3 were derived from the definitions before the author's text was opened; claims 4–6 were checked against Cartan's classification and re-derived where a closed form was asserted. Target: [findings/graded-half.md](../findings/graded-half.md) §"THE SYMMETRIC CLASS IS CLOSED" (lines 71–98), script [b_symmetric_dimension_lemma.py](../scripts/route-b/b_symmetric_dimension_lemma.py).

---

## Verdicts at a glance

| # | Claim | Verdict |
| --- | --- | --- |
| 1 | `tr R = n/4`, `c = 1/(2(n-1))`, `‖W‖² = ‖R‖² − n/(8(n−1))` | **CONFIRMED** |
| 2 | Eigenvalue data: block multiplicities, `1/2` on the centre, **zero off `h`** | **CONFIRMED** (and provable, not merely citable) |
| 3 | Dimension Lemma and its Cauchy–Schwarz | **CONFIRMED**, threshold exact |
| 4 | Coverage of rank ≥ 2 + `OP²`; family formulas; twelve exceptionals | **CONFIRMED** |
| 5 | Residue = the rank-one spaces; the five low-rank coincidences | **CONFIRMED** |
| 6 | `‖W‖² ≥ 1/6` on every compact **irreducible** symmetric space, equality only at `CP²` | **CONFIRMED as stated** |
| ★ | The irreducibility hypothesis, and whether the scope was narrowed | **Hypothesis is load-bearing; two write-up statements are FALSE**, see below |
| ☆ | Refutation of the enumeration at [REVIEW.md:217](../REVIEW.md#L217) | **CONFIRMED** |

---

## 1. The normalisation constants, CONFIRMED

Derived cold. With `⟨R(e_i∧e_j), e_k∧e_l⟩ = R_{ijkl}` and `|e_i∧e_j| = 1`,

- `tr R = Σ_{i<j} R_{ijij} = ½ Σ_{i,j} R_{ijij} = ½ scal`. Einstein constant `1/2` gives `scal = n/2`, hence **`tr R = n/4`**.
- `c = tr R / N = (n/4)/(n(n−1)/2) = **1/(2(n−1))**`.
- `‖W‖² = ‖R − cI‖² = ‖R‖² − 2c·tr R + c²N = ‖R‖² − c²N`, and `c²N = n(n−1)/2 · 1/(4(n−1)²) = **n/(8(n−1))**`.

The subtraction is not merely a trace removal: for an Einstein metric the Ricci part of the curvature decomposition vanishes, and the constant-curvature operator `k·Id` has `Ric = (n−1)k g`, so `k = λ/(n−1) = 1/(2(n−1)) = c`. Hence `W = R − cI` **is** the Weyl operator, not just the trace-free part of `R`. That identification is used but never stated in the write-up; it is correct.

Independent confirmation of the whole normalisation on the round sphere: `h = so(n)`, `R = k·Id` with `k = 1/(2(n−1))`, so `tr R = k·N = n/4` ✓ and `W = 0` ✓.

## 2. The eigenvalue data, CONFIRMED, and it is a theorem rather than a citation

The load-bearing point (**`R` vanishes on the `N − dim h` directions of `Λ²` off `h`**), is true, and provable in three lines without Petersen–Stanfield:

Let `g = h ⊕ p`, `n = dim p`, and let `Φ : Λ²p → h`, `X∧Y ↦ [X,Y]`. For a symmetric space `R(X,Y)Z = −[[X,Y],Z]`, and ad-invariance of the metric gives

    ⟨R(X∧Y), Z∧W⟩ = ⟨[X,Y],[Z,W]⟩ = ⟨Φ(X∧Y), Φ(Z∧W)⟩,   i.e.  R = Φ*Φ.

Three consequences, all needed by the argument and all correct:

1. `ker R = ker Φ`, so `rank R = dim [p,p] = dim h` (`[p,p] = h` for an effective irreducible pair). **`R` is supported on a subspace of dimension exactly `dim h`.**
2. `Φ*` is the isotropy inclusion `h ↪ so(p) ≅ Λ²p` up to normalisation, since `⟨Φ*A, Z∧W⟩ = ⟨A,[Z,W]⟩ = ⟨A·Z, W⟩`. So the support **is** the copy of `h` inside `Λ²`, not merely some subspace of the same dimension.
3. `ΦΦ* : h → h` is `Ad(H)`-equivariant, hence scalar on each `Ad(H)`-irreducible summand. A simple ideal is `Ad(H)`-irreducible, so the multiplicities **are** the block dimensions `d_i = dim h_i`; the centre of `h` has dimension ≤ 1 for an irreducible symmetric space.
4. `R = Φ*Φ ⪰ 0`, which is Petersen–Stanfield Theorem A's lower bound recovered for free.

**Independent check of all of it on the Hermitian family**, from the complex-space-form tensor rather than from any table. For holomorphic sectional curvature `4c`, writing `ω₀ = Σ_k e_k ∧ Je_k` (so `|ω₀|² = m` and `⟨ω₀, Z∧W⟩ = ⟨JZ,W⟩`), the curvature operator is exactly

    R = c[ Id + (J∧J) + 2 ω₀⊗ω₀ ]  on Λ²ℝ^{2m},   c = 1/(4(m+1)) for Ric = ½g.

Eigenvalues: `c(1+1+2m) = **1/2** on the centre ℝω₀`; `c(1+1) = **1/(2(m+1))** on su(m)` (where `J∧J = +1`, `⊥ ω₀`); and `c(1−1) = **0**` on the `J∧J = −1` complement, whose dimension is `m(m−1) = N − dim u(m)` ✓. So the centre eigenvalue `1/2`, the block-constancy, and the vanishing off `h` are all confirmed from scratch.

**Two phrasing caveats, neither affecting the argument.** (i) "the isotropy decomposition IS the eigenspace decomposition" is false when two blocks share an eigenvalue (the write-up's own `Gr_C(2,2)` row is that case) and is false as literally stated in any case, since the genuine eigenspace decomposition of `R` on `Λ²` also contains the `(N − dim h)`-dimensional kernel. The usable reading, "`R` is a constant on each block", is what is true and what the argument uses. (ii) Cauchy–Schwarz needs only `Σ d_i = dim h` and `Σ d_i λ_i = n/4`, so degeneracies are harmless.

## 3. The Dimension Lemma, CONFIRMED, threshold exact

Direction of Cauchy–Schwarz is right. With vectors `(√d_i)` and `(√d_i λ_i)`,

    (Σ d_i λ_i)² ≤ (Σ d_i)(Σ d_i λ_i²)  ⟹  ‖R‖² ≥ (n/4)² / dim h,

a **lower** bound on `‖R‖²`, which is what a lower bound on `‖W‖²` needs. Valid for any signs, equality iff all `λ_i` coincide. Including the zero directions would only enlarge `Σ d_i`, so the restriction of the support to `h` (claim 2) is exactly what makes the denominator `dim h` and not `N`.

Threshold rederived independently:

    ‖W‖² ≥ 1/6  ⟸  (n/4)²/D ≥ 1/6 + n/(8(n−1)) = (7n−4)/(24(n−1))
                ⟺  D ≤ 24n²(n−1) / (16(7n−4)) = **3n²(n−1) / (2(7n−4))**.

Matches the author's constant on the nose (`sympy` `solve`, exact). The `7n−4` is `4(n−1)+3n`, the write-up gives no derivation, and it is correct.

**A structural remark the write-up misses.** The Cauchy–Schwarz equality case (`all λ_i equal`) is precisely the two-eigenvalue Casimir member `W_h ∝ Π_h − (r/N)Id`: `λ = n/(4r)` on `h` and `0` off it gives `‖R‖² = (n/4)²/r` exactly. So the Dimension Lemma is the statement *"for fixed `dim h`, the two-eigenvalue member is the worst case"*. This is why the threshold is algebraically identical to the one already at [REVIEW.md:217](../REVIEW.md#L217), which was derived from `θ = (2/n)√(rN/(N−r))`: `θ² ≥ 3/2 ⟺ r ≥ 3nN/(7n−4)`, and `3nN/(7n−4) = 3n²(n−1)/(2(7n−4))` identically. The write-up's "AGREEMENT" classification is right, and the reason for the agreement is this, not coincidence.

## 4. Coverage, CONFIRMED

**Shift thresholds.** Each really is the first admissible rank ≥ 2, with `rank` read off Cartan's list:

| type | space | `n` | `dim h` | rank | shift used | correct? |
| --- | --- | --- | --- | --- | --- | --- |
| AIII | `Gr_C(p,q)` | `2pq` | `p²+q²−1` | `min(p,q)` | `p=2+a, q=2+a+b` | ✓ (`Gr(p,q)≅Gr(q,p)`, so `p≤q` is WLOG) |
| BDI | `Gr_R(p,q)` | `pq` | `p(p−1)/2+q(q−1)/2` | `min(p,q)` | `p=2+a, q=2+a+b` | ✓ |
| CII | `Gr_H(p,q)` | `4pq` | `p(2p+1)+q(2q+1)` | `min(p,q)` | `p=2+a, q=2+a+b` | ✓ |
| AI | `SU(m)/SO(m)` | `(m−1)(m+2)/2` | `m(m−1)/2` | `m−1` | `m=3+a` | ✓ |
| AII | `SU(2m)/Sp(m)` | `(m−1)(2m+1)` | `m(2m+1)` | `m−1` | `m=3+a` | ✓ |
| DIII | `SO(2m)/U(m)` | `m(m−1)` | `m²` | `⌊m/2⌋` | `m=4+a` | ✓ |
| CI | `Sp(m)/U(m)` | `m(m+1)` | `m²` | `m` | `m=2+a` | ✓ |
| II | simple `G` | `dim g` | `dim g` | `rank g` | `dim ≥ 6` | ✓ (generous: smallest rank-2 algebra is `su(3)` at 8; only `su(2)` at 3 is excluded) |

Every `(n, dim h)` pair in the table is the standard one. The eight families plus the twelve exceptionals exhaust Cartan's list.

**Certificates.** `P = 3n²(n−1) − 2(7n−4)·dim h` after substitution, exact `sympy` `Poly` coefficients:

| family | all coefficients ≥ 0 | smallest coefficient | `P` at `a=b=0` |
| --- | --- | --- | --- |
| AIII | yes | `24` | `616` |
| BDI | yes | `3` | `48` |
| CII | yes | `192` | `7200` |
| AI | yes | `3/8` | `114` |
| AII | yes | `24` | `3696` |
| DIII | yes | `3` | `2192` |
| CI | yes | `3` | `236` |
| II | yes | `3` | `84` |

All eight are valid, and (the point the write-up does not make but needs for claim 6), every one has `P(0,0) > 0` with all coefficients non-negative, so `P > 0` **strictly** for all `a,b ≥ 0`. Strict inequality in the dimension bound gives strict inequality in `‖W‖² > 1/6`, which is what makes "equality exactly at `CP²`" true rather than merely unrefuted.

**The twelve exceptionals**, `dim h = dim G − dim M`, checked against the standard list, with the bound as an exact rational:

| space | `n` | `dim h` | bound `3n²(n−1)/(2(7n−4))` | covered |
| --- | --- | --- | --- | --- |
| EI `E6/Sp(4)` | 42 | 36 | `54243/145` | ✓ |
| EII `E6/(SU(6)×SU(2))` | 40 | 38 | `7800/23` | ✓ |
| EIII `E6/(SO(10)×SO(2))` | 32 | 46 | `11904/55` | ✓ |
| EIV `E6/F4` | 26 | 52 | `12675/89` | ✓ |
| EV `E7/SU(8)` | 70 | 63 | `28175/27` | ✓ |
| EVI `E7/(SO(12)×SU(2))` | 64 | 69 | `32256/37` | ✓ |
| EVII `E7/(E6×SO(2))` | 54 | 79 | `115911/187` | ✓ |
| EVIII `E8/SO(16)` | 128 | 120 | `780288/223` | ✓ |
| EIX `E8/(E7×SU(2))` | 112 | 136 | `174048/65` | ✓ |
| FI `F4/(Sp(3)×SU(2))` | 28 | 24 | `1323/8` | ✓ |
| FII `F4/SO(9) = OP²` | 16 | 36 | `160/3` | ✓ |
| G `G2/SO(4)` | 8 | 6 | `168/13` | ✓ |

All twelve dimension pairs are correct and all twelve clear the bound. `780288/223 = 3499.05…` confirms the write-up's "`E8/SO(16)`: 120 against 3499". Ranks: all are ≥ 2 except FII (`OP²`, rank 1), matching "rank ≥ 2 plus `OP²`" exactly.

## 5. The residue, CONFIRMED

All five low-rank coincidences check out:

| claim | dimension from the family formula | identification |
| --- | --- | --- |
| `SU(2)/SO(2) = S²` | AI at `m=2`: `(m−1)(m+2)/2 = 2` | `S³/S¹`, the Hopf quotient ✓ |
| `SU(4)/Sp(2) = S⁵` | AII at `m=2`: `(m−1)(2m+1) = 5` | `su(4)≅so(6)`, `sp(2)≅so(5)`, so `SO(6)/SO(5)` ✓ |
| `SO(6)/U(3) = CP³` | DIII at `m=3`: `m(m−1) = 6` | `so(6)≅su(4)`, `u(3) ↔ s(u(3)⊕u(1))` ✓ |
| `Sp(1)/U(1) = S²` | CI at `m=1`: `m(m+1) = 2` | `S³/S¹` ✓ |
| `Gr_H(1,1) = S⁴` | CII at `p=q=1`: `4pq = 4` | `sp(2)≅so(5)`, `sp(1)⊕sp(1)≅so(4)` ✓; `= HP¹` ✓ |

Sweeping the excluded parameters of every family gives exactly `{S^n, RP^n, CP^m, HP^m, OP²}` (the compact rank-one symmetric spaces), plus `SO(4)/U(2) = S²` and `S³` (type II, `dim 3`), which are already on that list. So the residue is what is claimed.

Two consistency points worth recording. The lemma *never* covers spheres (`dim so(n) ≤ 3n²(n−1)/(2(7n−4)) ⟺ 7n−4 ≤ 3n ⟺ n ≤ 1`) or `CP^m` (`m² ≤ 3m²(2m−1)/(7m−2) ⟺ m ≤ −1`), as it must not, since both would then be forced above `1/6` and `CP²` sits exactly at it. It *does* cover `HP^m` for every `m ≥ 3` (see below), so listing `HP^m` in the residue is redundant but harmless.

Both rank-one closed forms rebuilt from block data rather than taken from the script:

- `CP^m`: centre `1/2` (mult 1) and `su(m)` at `1/(2(m+1))` (mult `m²−1`) give `tr R = m/2 = n/4` ✓ and `‖W‖² = 3m(m−1)/(4(m+1)(2m−1))`, matching `1/(4θ²)` from the recorded `θ² = (m+1)(2m−1)/(3m(m−1))`. Increasing in `m` (derivative numerator `3(3m²−2m+1) > 0`) so the minimum over `m ≥ 2` is `**1/6** at m = 2`, and `CP¹ = S²` gives `0` as it must.
- `HP^m`: from Petersen–Stanfield §3.5, `λ_{sp(1)} = m/(2(m+2))` (mult 3) and `λ_{sp(m)} = 1/(2(m+2))` (mult `m(2m+1)`) give `tr R = m = n/4` ✓ and, using `(5m+1)(4m−1) − 2(m+2)² = 9(2m+1)(m−1)`,

      ‖W‖² = 9m(m−1)(2m+1) / (4(m+2)²(4m−1)),

  which is exactly `1/(4θ²)` for the recorded `θ²(HP^m) = (m+2)²(4m−1)/(9m(m−1)(2m+1))`. At `m=2` it is `**45/224**`, confirming the write-up's figure, and `45/224 > 1/6` ✓.

## 6. The theorem, CONFIRMED as stated

`‖W‖² ≥ 1/6` on every compact irreducible symmetric space, equality exactly at `CP²`: the census is complete, the certificates are strict, the residue is handled, and the `CP²` equality is exact (`1/2 + 3·(1/6) = 1 = n/4`; `‖R‖² = 1/4 + 3/36 = 1/3`; `‖W‖² = 1/3 − 4/24 = **1/6**`). Verified by hand and by exact rational arithmetic. I found nothing wrong with the theorem in its stated scope.

---

## ★ The irreducibility hypothesis, the question that matters

### (a) Conjecture A does not restrict to irreducible, and nothing in the record excludes `S⁵×S⁷`

[README.md](../README.md) states the goal as: `P` restricted to unit-norm `W` is maximised on the Weyl tensor of **products of spheres** for `n ≥ 12`. No irreducibility, no `S = 0`, no non-diagonality. The record's `S` (graded compression slack) and "non-diagonal" are *classifiers used to split the critical set*, not hypotheses of the conjecture, and neither excludes `S⁵×S⁷` anyway: with `k = 2` blocks, `e₃ = 0`, so `S = 0` (graded), and a product of round spheres is diagonal in coordinate 2-planes. `S⁵×S⁷` sits squarely inside Conjecture A's scope, in its *granted* diagonal half.

It does not contradict Conjecture A, because the conjecture's target is `θ ≤ θ₀(n)`, not `θ ≤ √(3/2)`:

    θ²(S⁵×S⁷) = 264/175 = 1.508…  <  θ₀(12)² = 55/36 = 1.527…    ✓

### (b) The hypothesis is doing real work, the bound is false one step outside it, by `1/1056`

`S⁵×S⁷` normalised to Einstein constant `1/2` needs radii `r₁² = 8`, `r₂² = 12`, so `R = 1/8` on `Λ²p₁` (10 directions), `1/12` on `Λ²p₂` (21 directions), `0` on the 35 cross directions. Then

    tr R = 10/8 + 21/12 = 3 = n/4 ✓        (so it is Einstein at constant 1/2, and claim 1 applies verbatim)
    ‖R‖² = 5/32 + 7/48 = 29/96
    ‖W‖² = 29/96 − 3/22 = **175/1056**,     1/6 = 176/1056,     shortfall exactly **1/1056**.

And `1/(4‖W‖²) = 264/175`, which reproduces the recorded `θ = 1.228239158` for the `5+7` split at [findings/graded-half.md:30](../findings/graded-half.md#L30) to every digit, an exact cross-check that the `θ = 1/(2‖W‖)` bridge and this reviewer's arithmetic agree.

So: **the theorem's conclusion is false for a reducible compact symmetric space, and false by a razor-thin margin.** The irreducibility hypothesis is not decorative and is not vacuous, it is precisely the hypothesis that excludes the counterexample. Note also that the `Q(W) = λW` identity the whole quadratic reformulation rests on is proved for *locally symmetric Einstein* spaces with no irreducibility (graded-half.md line 110), so the class on which `θ = 1/(2‖W‖)` holds is strictly larger than the class on which `‖W‖² ≥ 1/6` holds. `dim h(S⁵×S⁷) = 10 + 21 = 31` against the bound `3·144·11/(2·80) = 297/10 = 29.7`, so the Dimension Lemma correctly declines to cover it, the lemma is not contradicted, only the theorem's extension would be.

### (c) Two statements in the record are FALSE, and should be struck

The **Theorem** and **Corollary** at [graded-half.md:82](../findings/graded-half.md#L82) and [:92](../findings/graded-half.md#L92) say "irreducible" and are correct. Two other statements drop the word and become false:

- [plan.md:25](../plan.md#L25): *"**Conjecture A restricted to compact symmetric spaces is exactly `‖W‖² ≥ 1/6`, with equality only at `CP²`.**"*, **FALSE.** `S⁵×S⁷` is a compact symmetric space with `‖W‖² = 175/1056 < 1/6`. Conjecture A restricted to compact symmetric spaces is `‖W‖² ≥ n²/(8(n−1)(n−2))`, i.e. `θ ≤ θ₀(n)`; at `n = 12` that is `9/55 = 0.1636…`, which `175/1056 = 0.1657…` satisfies.
- [graded-half.md:122–124](../findings/graded-half.md#L122): the same sentence, where the prose says "restricted to compact symmetric spaces" and the display says "for every compact irreducible symmetric space". The two halves disagree; the prose is the wrong one.

Even in the irreducible reading, "**is exactly**" overstates: for `n ≥ 12` the demand `‖W‖² ≥ 1/6` is strictly *stronger* than Conjecture A needs (`1/6 > n²/(8(n−1)(n−2)) ⟺ n² − 12n + 8 > 0 ⟺ n > 6+2√7`), and for `n < 12` it is the right statement only because `CP²` is then the maximiser. It is the correct target, but it is not a restatement.

The section heading **"THE SYMMETRIC CLASS IS CLOSED"** ([graded-half.md:71](../findings/graded-half.md#L71)) is likewise stronger than what follows it; the qualifier arrives in the same sentence, so this is a heading to tighten rather than an error.

### And the gap is closable in four lines, which is why I do not call the theorem hollow

For a product `M = M₁ × … × M_k` of compact symmetric spaces, Einstein forces every factor to carry the *same* constant `1/2`, `R` is block-diagonal with zero on all cross directions, and `tr R = Σ n_a/4 = n/4` automatically. Hence

    ‖W‖²(M) = Σ_a ‖W_a‖²_{n_a}  +  [ Σ_a n_a/(8(n_a−1)) − n/(8(n−1)) ],

where the bracket depends on the partition alone. The bracket being fixed, `‖W‖²` is **minimised over a given partition exactly when every `‖W_a‖² = 0`**, i.e. when every factor has constant curvature (Einstein + `W=0` forces this for `n_a ≥ 4`; automatic for `n_a ≤ 3`), that is, when `M` is a **product of spheres**. Checks: `S⁵×S⁷` gives `5/32 + 7/48 − 3/22 = 175/1056` ✓; `CP²×S⁸` gives `1/6 + 1/6 + 1/7 − 3/22 = 157/462`, far above `1/6`, so no mixed product threatens anything.

Consequence: `sup θ` over **all** compact symmetric spaces, reducible included, equals `max(θ₀(n), √(3/2)) = θ₀(n)` for `n ≥ 12`, attained at the balanced sphere product, exactly what Conjecture A asserts. The reducible case is therefore not a hole in the mathematics; it is a hole in the write-up, and a short one. **My recommendation: state the additivity identity, kill the two false sentences, and the section can honestly be titled "the symmetric class is closed" instead of only the irreducible half of it.**

### The blunt part

The scope *is* narrower than Conjecture A, but the narrowing that actually limits this result is not "irreducible". It is "**symmetric**". The theorem eliminates one structured slice of the critical set; the record's own assessment ([graded-half.md:200](../findings/graded-half.md#L200), [:242](../findings/graded-half.md#L242)) is that the critical points that matter (generic ungraded ones at `n ≥ 12`), have "no known construction and no search that finds them", and the ungraded ceiling still stands at `0.900828` with a `0.324` gap. Nothing in this cycle moves that. The Corollary at line 92 is correctly scoped and is a real addition to Route B; the framing around it ("the symmetric class is closed", "Conjecture A restricted to compact symmetric spaces **is** `‖W‖² ≥ 1/6`") reads as more than that, and one of those framings is flatly false.

---

## ☆ The `HP²` refutation of [REVIEW.md:217](../REVIEW.md#L217), CONFIRMED

REVIEW.md:217 asserts that the only subalgebras of `so(n)` meeting `dim h ≥ (3n/(7n−4))·C(n,2)` are `so(n)` itself and `u(n/2)`. Exact arithmetic at `n = 8`:

    bound = 3·8²·7 / (2·(7·8−4)) = 1344 / 104 = **168/13 = 12.923076…**
    sp(1) ⊕ sp(2) ⊂ so(8):  dim = 3 + 10 = **13 > 168/13**          EXCEEDS
    dim u(4) = 16,  dim so(8) = 28                                    so it is neither

`sp(1)⊕sp(2)` acts irreducibly on `ℍ² = ℝ⁸` as the isotropy of `HP²`, so it is a genuine subalgebra of `so(8)` and a genuine third case. **The enumeration at REVIEW.md:217 is incomplete; the refutation stands.**

The accompanying claim that it is the only quaternionic one also holds, exactly:

| `sp(1)⊕sp(m) ⊂ so(4m)` | `dim h` | bound | exceeds? |
| --- | --- | --- | --- |
| `m=2` (`n=8`) | 13 | `168/13` | **yes** |
| `m=3` (`n=12`) | 24 | `297/10` | no |
| `m=4` (`n=16`) | 39 | `160/3` | no |
| `m=5` (`n=20`) | 58 | `1425/17` | no |
| `m=6` (`n=24`) | 81 | `4968/41` | no |

The script's own scope note (that this refutes the enumeration without re-enumerating all such subalgebras), is the honest statement and should be kept.

---

## Summary

Claims 1–6 are all correct as stated, and several are stronger than the write-up realises: the vanishing of `R` off `h` is provable in three lines rather than citable; the Cauchy–Schwarz equality case is exactly the two-eigenvalue Casimir member, which explains the agreement with REVIEW.md:217; and the certificates' strict positivity is what earns "equality exactly at `CP²`". The `HP²` refutation is exact. I found no error in the mathematics of the section.

I found one real error in the record, twice stated: **"Conjecture A restricted to compact symmetric spaces is exactly `‖W‖² ≥ 1/6`"** is false, refuted by `S⁵×S⁷` at `‖W‖² = 175/1056`, short of `1/6` by `1/1056`. The irreducibility hypothesis in the theorem is genuine and load-bearing, the theorem itself is correctly scoped, and the reducible remainder is closable by a four-line additivity argument that the write-up should carry out rather than gesture at.
