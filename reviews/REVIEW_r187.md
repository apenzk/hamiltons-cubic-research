# Gate 2 review 187, the coefficient check tests one linear functional, the elimination is sound at every r, and the pairing's cost model rests on a false symmetry

Everything below is exact: integer arithmetic over **F_10007** where the objects are defined mod p, `Fraction` over **Q** for the extremiser and the normalisation, and float64 only where an exactness bound is separately proved. Scripts: [scripts/reviewers/r187/](../scripts/reviewers/r187/).

| Claim | Verdict |
| --- | --- |
| 1a. The coefficient check tests a SUM | **Upheld, with three witnesses.** A swap, a reversal and a one-unit shift all pass 6/6. The mid-review patch adding one weighted identity is **also defeated**, by an explicit witness |
| 1b. The rewritten Vandermonde elimination at r > 2 | **Sound, and now proved.** 54/54 against the S6 symmetrisation at r = 3..6, 1272/1272 permutation-covariant, plus a derivation of why the truncated grid is legitimate |
| 2. The raising-operator check reads a cache | **Circular.** `raise_vec` re-applies the operator `raise_mono` used to *define* the nullspace. It tests the JSON round-trip. A check that can fail is supplied |
| 3. The round trip as discriminator | **Right discriminator, wrong claim attached.** It pins the *encoding* and fails on three witnesses; it pins nothing about W_0, three other Weyl tensors with different `tr(S³)` pass it |
| 4. Normalisation self-consistency | **Consistent, and the stated hazard is weaker than recorded.** The two conventions differ by a uniform 2^d grading; a uniform power of 4 rescales the Gram unknowns and cannot change PSD-ness |
| **Bonus (unbriefed).** run_n5_pairing.py's "20 identical slot-splittings" | **False, refuted with a witness.** 12–16 distinct values among the 20. The cost projection is short by a factor of 20 |

---

## Claim 1a, the sum test, and why one more weighting is not the fix

[attack_sum_test.py](../scripts/reviewers/r187/attack_sum_test.py).

The validation `sum_d coeff(d, 6-d) == J(A+B)` is **one linear functional evaluated on seven unknowns**. Anything in the six-dimensional kernel of that functional passes. Three witnesses, each genuinely different from the shipped coefficients on 6/6 matchings:

| rule | what it does | plain sum identity |
| --- | --- | --- |
| swap | exchanges `coeff(2,4)↔coeff(4,2)` and `coeff(1,5)↔coeff(5,1)` | **6/6 PASS** |
| reverse | sends `beta` to its reversal everywhere | **6/6 PASS** |
| shift | moves one unit of mass from `(2,4)` to `(4,2)` | **6/6 PASS** |

The shipped **teeth** test does not close the gap. It substitutes a different *map* (the vertex-ordered `eval_polarised`), whose sum already differs from `J(A+B)`, so it is caught; a redistribution keeps the sum and survives verbatim. Concretely at matching 0: vertex-ordered sum `1785` against target `5442` (caught), swap sum `5442` (not caught).

**The patch that landed mid-review is still not enough.** [run_n5_coefficient.py](../scripts/runs/run_n5_coefficient.py) now also checks the weighted identity `sum_d c_d · 3^d · 5^(6-d) = J(3A + 5B)` at the single point `(s1,s2) = (3,5)`. Two linear functionals on seven unknowns leave a **five-dimensional** space of redistributions. Solving the 2 × 7 system gives, for instance,

> `delta = (2002, 8004, 1, 0, 0, 0, 0)` added to `(coeff(0,6), …, coeff(6,0))`

which satisfies `sum(delta) = 0` and `sum_d delta_d · 3^d · 5^(6-d) = 0`. Measured: plain identity **6/6 PASS**, weighted identity at (3,5) **6/6 PASS**, three of the seven coefficients moved.

**The check that pins each beta.** Seven distinct values of `t` in `J(tA + B) = sum_d coeff(d,6-d) · t^d` give a 7 × 7 Vandermonde of full rank, so the family of identities determines every coefficient and nothing smaller does. Measured with `t = 1..7`: shipped coefficients **6/6 pass**; swap **6/6 rejected**, reverse **6/6 rejected**, shift **6/6 rejected**, and the `delta` witness above **6/6 rejected**. The general form for r tensors is `sum_beta coeff(beta) · s^beta = J(sum_k s_k A_k)` over a grid of `s` large enough to be unisolvent, the same grid the extractor already builds, which makes the strengthened check nearly free.

A second, independent handle is homogeneity: `coeff(beta; sA, uB) = s^{beta_0} u^{beta_1} coeff(beta; A, B)`, one equation per `beta` with no sum anywhere. Measured 63/63 for the shipped extractor, and it rejects the swap rule, since `s²u⁴ ≠ s⁴u²`. **It is a self-consistency check** (the extractor appears on both sides) so it belongs beside the t-family, not instead of it.

**Could these witnesses have failed?** Yes: each requires the seven coefficients to be pairwise distinct, which the record never establishes. They are, on all six matchings tested.

**What the attack does not show.** The shipped `coeff` is *correct*. Every witness above is a hypothetical rule, not the implementation. The finding is about the validation, not the arithmetic.

## Claim 1b, the elimination at r ≥ 3, with a proof

[stress_vandermonde.py](../scripts/reviewers/r187/stress_vandermonde.py), [why_truncation_works.py](../scripts/reviewers/r187/why_truncation_works.py), [mutants.py](../scripts/reviewers/r187/mutants.py).

The shipped tests use r = 1 and r = 2 only. Three oracles at r = 3, 4, 5, 6:

- **Against the S6 symmetrisation**, the sum over the `6!/beta!` distinct vertex placements of `eval_polarised`, a wholly separate code path. 18 shapes × 3 matchings, up to 720 placements each: **54/54 agree**.
- **Permutation covariance**, relabelling the tensors and the multi-index together must fix the coefficient. This is precisely what a peeling-index bug breaks, and it is invisible at r ≤ 2 on symmetric shapes: **1272/1272 invariant**.
- **The full partition identity**, the sum over *all* `beta` with `|beta| = 6`, not one slice, against `J(E_0 + … + E_{r-1})`: **6/6 match** at r = 3 and r = 4.

### Why the truncated grid is legitimate

The extractor samples `x_i` only on `0..beta_i`, while `J(sum_k x_k A_k)` has degree 6 in every `x_i`. Interpolating a degree-6 polynomial through `beta_i + 1` points does **not** recover its degree-`beta_i` coefficient, so every pass but the last extracts a polluted value. The pollution is harmless, and here is why.

For a node set `S` of size `b+1`, the map "leading coefficient of the interpolant through `S`" is the divided difference `[S]`, and for any `g`,

> `[S] g = sum_{e ≥ b} h_{e-b}(S) · [x^e] g`,

`h_j` the complete homogeneous symmetric polynomial in the nodes, `h_0 = 1`. So pass `i` multiplies the wanted term by exactly 1 and adds terms in which the *surviving* variables carry strictly smaller total degree, the polynomial is homogeneous of degree 6, so consuming more than `beta_i` powers of `x_i` leaves fewer for the rest. After passes `0..r-2` the running value is `c_beta · o^{beta_{r-1}} + (degree < beta_{r-1})`, and the final pass interpolates a polynomial of degree exactly `beta_{r-1}` through `beta_{r-1}+1` nodes (an exact interpolation), returning `c_beta`. ∎

The derivation makes two falsifiable predictions, both tested:

| prediction | test | result |
| --- | --- | --- |
| the node *set* is irrelevant, only its size | grids `0..b`, `1..b+1`, `b..0`, and `3,17,29,…` | **18/18 agree in all four** |
| squareness (rows = columns) is load-bearing | widen every grid to `0..6`, keep `beta_i + 1` columns | **0/18 agree at r ≥ 3** under the shipped group ordering |

The second is a live hazard the code does not document. `coeff` iterates its groups over `{x[1:] for x in cur}`, a **set**, whose order is arbitrary. That is harmless only because every system is square, so the solution is unique regardless of row order. Widen the grid and the systems become over-determined and inconsistent; the elimination then reads a solution off whichever rows it happens to pivot on, that subset varies from group to group, and the running value stops being the evaluation of any single polynomial. Sorting the groups restores correctness (18/18), which is the diagnosis. **A comment on the `m == n` invariant belongs in the source.**

### Could the r ≥ 3 checks have failed?

Six mutants of the elimination, each a bug a person would plausibly write, run through every oracle:

| mutant | disagrees with S6 (r≥3) | breaks permutation covariance | shipped `beta=(6)` | shipped sum identity |
| --- | --- | --- | --- | --- |
| shipped (control) | 0/18 | 0/126 | PASS | PASS |
| always `betas[0]` | 16/18 | 63/126 | PASS | **FAIL** |
| peel from the back | 16/18 | 12/126 | PASS | **FAIL** |
| reversed beta order | 16/18 | 12/126 | PASS | **FAIL** |
| take `sol[0]` | 18/18 | 0/126 | **FAIL** | **FAIL** |
| grid always `0..6` | 18/18 | 117/126 | PASS | **PASS** |

Two readings. The shipped suite is **not** vacuous against implementation bugs, it catches four of the five wrong mutants. And it is blind to the fifth, which is exactly the "make the grid safer" edit, and blind to every redistribution. The oracles added here catch all six.

## Claim 2, the raising-operator check is circular

[claim2_circularity.py](../scripts/reviewers/r187/claim2_circularity.py).

[run_n5_highest_weight.py](../scripts/runs/run_n5_highest_weight.py) **defines** the 41 vectors as the joint nullspace of `E1C` and `E2C` under `raise_mono`. [run_n5_cubic_forms.py](../scripts/runs/run_n5_cubic_forms.py) then reads `E1C`, `E2C` and the vectors from the cache the first script wrote, and applies `raise_vec`, the same three-slot walk, the same `EC[x][t]` substitution, the same `sorted(rest + [t])` key, differing only in the accumulator's zero element and in carrying the coefficient `co` explicitly where the nullspace solve folded it in. **41/41 annihilated cannot fail unless the JSON round-trip corrupts a coefficient.** It is a serialisation test wearing a representation-theory label.

The perturbation "teeth" test is genuine but tests the same tautology: a vector with one extra monomial leaves the kernel of the operator that defined the kernel.

**A check on the same cache that can fail.** The block multiplicities must reconcile with `dim Sym³(Weyl_5)` through the Weyl dimension formula for B_2, `dim V_(λ1,λ2) = (2/3)·a·b·(a−b)(a+b)` with `a = λ1 + 3/2`, `b = λ2 + 1/2`, a formula nothing in the pipeline uses:

> 24 blocks, multiplicities summing to 41, `sum_λ mult(λ)·dim V_λ = 7770 = C(37,3) = dim Sym³(Weyl_5)`. **MATCH.**

It could have failed: a single wrong multiplicity moves the total by `dim V_λ ≥ 1` (measured: +1 for (0,0), +5 for (1,0), +14 for (2,0), +35 for (2,1)). A second cheap one, also passing: every support monomial of every highest-weight vector carries weight exactly `λ`, **1436/1436**.

The genuinely independent content already in the record is the **Casimir** check inside the highest-weight script, which uses all ten generators rather than the two that defined the kernel. That check, not the annihilation, is what licenses the 41.

## Claim 3, the round trip pins the encoding, not W_0

[claim3_roundtrip.py](../scripts/reviewers/r187/claim3_roundtrip.py).

**(a) As a discriminator for the encoding it is the right test, and it has teeth.** Bianchi + Ricci = 0 is blind to all of them; the round trip separates the correct encoding from every one:

| encoding of `√6 W_0` | Bianchi + Ricci | round trip |
| --- | --- | --- |
| correct (undoubled) | pass | **pass** |
| doubled off-diagonals | pass | fail |
| halved off-diagonals | pass | fail |
| globally scaled by 2 | pass | fail |

**(b) It pins nothing about W_0.** The round trip asserts that `sym2_to_R` inverts the coordinate reading, a property of the *map*, satisfied by the correct encoding of any symmetric operator on Λ². Three other Weyl tensors, built the same way from different frames or spectra:

| candidate | Weyl? | round trip? | `tr(S³)` |
| --- | --- | --- | --- |
| `diag(2,−1,−1)` on a rotated frame | yes | **pass** | 6 |
| spectrum `(1,−1,0,…)` | yes | **pass** | 0 |
| spectrum `(3,−2,−1,…)` | yes | **pass** | 18 |
| `√6 W_0` itself | yes | **pass** | 6 |

Two of these are Weyl tensors with a **different** `tr(S³)`, hence a different θ. So reviewer 186's caveat survives the repair: what pins `W_0` is the explicit rank-3 construction together with the exact spectrum `(2,−1,−1,0⁷)` accounting for all 10 of Λ², and that spectrum check *can* fail, it reports the multiplicities and their total. The script's own line should say the round trip settles the **convention**; `tr(W_0³) = 1/√6` rests on the spectrum.

## Claim 4, the record is consistent, and the recorded hazard is weaker than stated

[claim4_normalisation.py](../scripts/reviewers/r187/claim4_normalisation.py).

The `2^k` grading holds exactly on `√6 W_0` for `k = 2..6` (`tr(M^k)` = 24, 48, 288, 960, 4224 against `2^k tr(A^k)`) and on four random Weyl_5 tensors for `k = 2,3,4`. Consequently `|·|²` scales by 4, `tr(·³)` by 8, and `F_5 = (3/2)|W|⁶ − 9 tr(W³)²` by **64 uniformly**, measured `64.000000` at three points where `F_5 ≠ 0`, and `F_5(W_0) = 0` in both conventions.

**The sharpening.** [run_n5_inner_product.py](../scripts/runs/run_n5_inner_product.py) records the hazard as "powers of 4 leak into the SDP". The leak is real for the *recorded numbers* and inert for the *question*: `P_i` is linear in the Gram, so `P_i conj(P_j)` scales by 16 while `F_5` scales by 64, and the system `<P_i conj(P_j), J_b> = <F_5, J_b>` mismatches by a single factor of 4 **uniform in i, j and b**. A uniform positive scalar rescales the Gram unknowns `G → 4G` and leaves feasibility and PSD-ness untouched. What would be fatal is a *non-uniform* mix, one that scales some `(i,j,b)` entries and not others. No such mix exists in the record today, because the pairing is not assembled: [run_n5_pairing.py](../scripts/runs/run_n5_pairing.py) is a timing projection and computes no entry. **The record is self-consistent under the tensor normalisation; the note should say which kind of leak it is guarding against.**

## Bonus, run_n5_pairing.py's cost model rests on a false symmetry

[pairing_symmetry.py](../scripts/reviewers/r187/pairing_symmetry.py). Unbriefed, found while checking claim 1.

The script's route is stated as

> `<P_i conj(P_j), J_b> = 20 · D_b(U_i in slots 1–3 ; conj(U_j) in slots 4–6)`, "by symmetry of `D_b` every one of the C(6,3) = 20 slot-splittings gives the same value"

and `D_b` as implemented is `eval_polarised`, the **vertex-ordered** form, the same object whose coefficient claim reviewer 185 refuted, for the same reason. Measured over the 20 splittings of a 3+3 pattern on two random Weyl tensors:

| matching | distinct values among the 20 | `sum of the 20` = `coeff(3,3)`? | `20 × (one splitting)` = `coeff(3,3)`? |
| --- | --- | --- | --- |
| 0 | 12 | **yes** (6758) | no (6987 vs 6758) |
| 1 | 16 | **yes** (2681) | no (3151 vs 2681) |
| 2 | 12 | **yes** (766) | no (327 vs 766) |

The symmetric polarisation is the **sum** over the 20 placements, which is what `coeff(3,3)` returns, an independent corroboration of claim 1b at `beta = (3,3)`. Two consequences:

1. The identity as written is false, and the docstring's argument that "the function was correct; only its earlier use was not" reinstates the refuted use in a new place.
2. The cost is `|supp|² × 20 × 36 × 14`, **twenty times** the projected figure. The projection that "decides whether this route runs" is off by 20×, and the number the script prints should be re-derived before that decision is taken.

## Two files changed under this review

[run_n5_polarised_diagram.py](../scripts/runs/run_n5_polarised_diagram.py) switched from object dtype to float64 BLAS mid-review, on a `2^53` bound. Checked, since every oracle here depends on it: [ep_exactness.py](../scripts/reviewers/r187/ep_exactness.py) re-runs the identical contraction schedule in Python-int arithmetic and finds **30/30 agreement**, with the largest partial sum actually occurring at `3.21e12` against `2^53 = 9.01e15`, **2806× headroom** at p = 10007. Every result above was re-run after the switch and is unchanged. The bound in the docstring is stated for p = 65537, where the headroom falls to roughly 65× and still holds; it should be re-checked, as the comment says, if `n` grows.

[run_n5_coefficient.py](../scripts/runs/run_n5_coefficient.py) gained the single weighted identity, addressed under claim 1a.

## What should change

1. **Replace the single weighted identity with the seven-point `t`-family** in [run_n5_coefficient.py](../scripts/runs/run_n5_coefficient.py), and state in the comment that seven independent weightings is the minimum that pins seven coefficients. Add the `delta = (2002, 8004, 1, 0, 0, 0, 0)` witness as the teeth case.
2. **Add an r ≥ 3 shape to the shipped suite**, one `beta = (2,2,2)` against the S6 symmetrisation, and one permutation-covariance case. Both are cheap and both catch mutants the current suite misses.
3. **Document the `m == n` invariant** in `coeff`: the group loop iterates a set, so row order is arbitrary, and correctness rests on every Vandermonde system being square.
4. **Retire "41/41 annihilated" as evidence** and print the Weyl-dimension reconciliation `7770 = 7770` instead, which is the check on the cache that can fail.
5. **Re-label the round trip** in [run_n5_extremiser.py](../scripts/runs/run_n5_extremiser.py) as a convention test, and attach `tr(W_0³) = 1/√6` to the spectrum line.
6. **Re-derive [run_n5_pairing.py](../scripts/runs/run_n5_pairing.py)'s projection** with the factor of 20 restored, before that projection is used to choose a route.
