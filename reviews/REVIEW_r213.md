# Gate 2 review r213 -- the n=5 certificate (Theta_5 = sqrt(3/2))

Reviewer 213. Brief: brief18.md. Assigned claims 1, 2, 3 plus the falsification hunt.
Reviewer 214 runs 4-6 concurrently.

Status: COMPLETE. Every assigned claim survives. No refutation found.

| # | Claim | Verdict |
|---|---|---|
| 0 | Falsification hunt: a concrete W with F_5(W) < 0 | **NOT FOUND** -- the bound is sharp and attained |
| 1 | The certificate is positive definite (third route) | **CONFIRMED** by two further routes |
| 1b | Block partition [3,3,2,1,2,1,2,1,2,2,1,1,1,1,1,1] is the right one | **CONFIRMED** from the adapted-basis cache |
| 2 | The point lies in the affine family, exactly over Q | **CONFIRMED**, and the lift survives a held-out prime |
| 3 | The lifted rows are the sextic coordinates (W_0 row zero; rhs = F_5) | **CONFIRMED**, and the sextic matches F_5 at 40 fresh points |

## 0. The falsification hunt -- no negative F_5, and the bound is sharp

Weyl_5 was rebuilt from the tensor symmetries alone ([hunt_f5_negative.py](../scripts/reviewers/r213/hunt_f5_negative.py)): Sym^2(Lambda^2) with the totally antisymmetric part removed and Ricci = 0, giving an orthonormal 35-dimensional basis, every element checked against the four symmetries. Nothing is imported from the programme.

F_5 >= 0 is exactly `|tr(W^3)| <= |W|^3 / sqrt(6)`, so the hunt is a maximisation of `|tr(W^3)|` on the unit sphere. Riemannian gradient ascent, 3000 random starts, both signs ([hunt_wide.py](../scripts/reviewers/r213/hunt_wide.py)):

| quantity | value |
|---|---|
| max `tr(W^3)/|W|^3` over 3000 ascents | 0.4082482904639 |
| `1/sqrt(6)` | 0.4082482904639 |
| excess | 1.1e-15 (float noise) |
| distinct critical values reached | ONE, all 3000 starts |
| constrained Hessian at the maximiser | negative semidefinite, no positive eigenvalue |

The maximiser's Lambda^2 operator has spectrum proportional to `(-2, 1, 1, 0^7)` with `|W|=1` fixing the scale at `1/(2 sqrt 6)` -- the padded `W_{CP^2}`, which is the orbit the certificate's cubics are made to vanish on. So the ascent lands on `W_0` from every start, `F_5` vanishes there to 8e-15, and the bound `sqrt(3/2)` is **sharp and attained** rather than merely true.

**This is the strong form of the test the programme's own [run_n5_falsify.py](../scripts/runs/run_n5_falsify.py) does not perform.** That script draws 30000 Weyl tensors with small integer coordinates in a 35-dimensional space and reports the minimum of `F_5/|W|^6`; random sampling in 35 dimensions never approaches a measure-zero orbit, so its minimum is uninformative about the extremiser. Ascent reaches the extremiser from every start and still finds nothing negative.

**Verdict: no counterexample.** This corroborates the claim; it does not prove it, and the fact that the maximum is *attained* means the SOS certificate must be for a form with a real zero, which is the delicate case.

## 1. Positive definiteness -- a third and a fourth route agree

[c1_pd_third_route.py](../scripts/reviewers/r213/c1_pd_third_route.py) reads only n5_certificate.json.

**Route (a), exact LDL^H over Q(i), reconstructed and compared.** Every block factors as `M = L D L^H` with `L` unit lower triangular over `Q(i)` and `D` real diagonal; `L D L^H` is recomputed and compared to `M` entry by entry over `Q`, and matches. All 47 pivots are positive rationals. A *verified* factorisation is a proof object rather than a test -- `v^H M v = sum_r d_r |(L^H v)_r|^2` with every `d_r > 0` -- which is exactly what the two LDLs that lied here were missing.

**A certified rational margin.** [c1c_margin.py](../scripts/reviewers/r213/c1c_margin.py) runs the same verified LDL on `M - c I`: every block stays positive definite at `c = 21/1000` and fails at `c = 213/10000`. So `lambda_min > 21/1000` is a statement over Q, and the true value sits between `0.021` and `0.0213`.

**Route (b), sympy eigenvals on the exact matrices.** All 47 eigenvalues strictly positive; smallest is `0.021258` in block 1, largest `16.786` in block 2. The margin agrees with the `2.34e-2` the pipeline reports.

Smallest pivots and eigenvalues:

| block | size | smallest pivot | smallest eigenvalue |
|---|---|---|---|
| 0 | 3 | 2.381e-02 | 0.0232287 |
| 1 | 3 | 2.258e-02 | 0.0212577 |
| 2 | 2 | 5.868e-01 | 0.0233650 |
| 4 | 2 | 2337/100000 | 0.0233700 |
| 8 | 2 | 2.564e-02 | 0.0233643 |

**"Alternating coefficients" is a valid test here, and the reasoning is sound.** For a Hermitian `M`, `det(xI-M) = sum_m (-1)^m e_m(lambda) x^{k-m}`, so the alternation the script checks is `e_m(lambda) > 0` for every `m`. Then `p(-t) = (-1)^k sum_m e_m t^{k-m}` has no root for `t >= 0`, and Hermiticity makes all roots real, so all roots are positive. Hermiticity is by construction (`M[j][i]` is set to the conjugate of `M[i][j]`), and the real-trace asserts are a redundant check on it. The test is correct; my objection is only that it shares the file's block reading with everything else, so it could not have caught the r211/r212 defect either.

*Dead code in [run_n5_verify.py](../scripts/runs/run_n5_verify.py):* `charpoly` defines a local `mul` whose body is a malformed generator expression; it is never called (the used routine is `cm`). Harmless, and worth deleting.

## 2. Membership in the affine family -- exact over Q, with a held-out prime

[c2_affine_exact.py](../scripts/reviewers/r213/c2_affine_exact.py) reimplements CRT and rational reconstruction rather than importing run_n5_lift's.

| check | result |
|---|---|
| lift from primes 1, 2, 3 only | all 1920 entries reconstruct |
| reduce that lift mod the held-out fourth prime | 0 of 1920 residues disagree |
| 4-prime lift equals the 3-prime lift | yes |
| max height vs reconstruction bound | 3.59e16 vs 8.55e23, ratio 4.2e-8 |
| `A x - B` at the certificate point, over Q | 0 of 40 equations violated |
| exact rank over Q | `rank(A) = 13 = rank([A|B])`, consistent |
| affine family dimension | `47 - 13 = 34` |

The held-out prime is the check the programme's own lift does not run: it uses all four primes at once, so a reconstruction error would have to be caught by the height bound alone. Reducing a three-prime lift mod a fourth 41-bit prime misses a wrong rational with probability `O(2^-41)` per entry, and 1920 entries agree.

## 1b. The block partition -- rebuilt from the adapted basis, not read off the dump

[c1b_block_order.py](../scripts/reviewers/r213/c1b_block_order.py) opens n5_adapted.pkl and recovers the column partition from the multiplicities, then compares.

| step | result |
|---|---|
| blocks in the adapted basis | 24, with 41 copies |
| sort key `(-multiplicity, weight)` | a **strict** total order -- no ties, so no tie-break to get wrong |
| dumped block labels | equal to that order, restricted to the surviving blocks |
| restricted size predicted by the parity rule `m - [lambda_2 even]` | `[3,3,2,1,2,1,2,1,2,2,1,1,1,1,1,1]` |
| dumped shape | identical |
| blocks the dump drops | the 8 with predicted size 0, and only those |
| sum of squares | 47 = the column count of the rows |

The r211/r212 defect is fixed and the fix is not merely self-consistent: the order is recoverable from an object that the dump does not touch. What makes it robust now is that [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py) derives `_ord` inline from the same `sorted(ADAPTED, key=lambda l: (-len(ADAPTED[l]), l))` expression `herm_row` uses, rather than restating it.

## 3. The rows -- the rhs is F_5, exactly, at every sample point

[c3_rhs_is_F5.py](../scripts/reviewers/r213/c3_rhs_is_F5.py) regenerates the 40 sample tensors from the pipeline's seed (offset 1, the probe draw consumed before the loop), verifies each is an algebraic Weyl tensor, and computes `F_5 = (3/2)(W.W)^3 - 9 tr(W^3)^2` here, over Q, by direct contraction on the rank-4 tensor.

| check | result |
|---|---|
| the 40 regenerated tensors satisfy all four Weyl symmetries and Ricci = 0 | 0 failures |
| lifted rhs vs F_5 recomputed from the tensor | **40/40 exactly equal over Q** |
| `|W_0|^2` | 24 |
| `F_5(W_0)` | exactly 0 |
| certificate's sextic `row(W_i) . x` vs `F_5(W_i)` | 40/40 exactly equal |

This closes the rhs half of claim 3 with no room left: the mod-p evaluator inside the pipeline, the CRT lift, and the sample-point regeneration all agree with an independent exact computation on the tensor itself.

## A documentation inaccuracy, not a mathematical one

[findings/sym3-blocks.md](../findings/sym3-blocks.md) and [findings/INDEX.md](../findings/INDEX.md) say the certificate is "a Gram with **rational** entries at denominator `10^5`". The `10^5` is the rounding denominator applied to the 34 kernel coefficients, not a denominator of the Gram. Of the 47 entries, 34 do have a denominator dividing `10^5`; the other 13 do not, and the largest is `49895950104000000`, about `5e16`. The certificate is no worse for it -- the entries are exact rationals either way -- but the sentence as written describes a matrix that is not the one in the file.

## The extremiser, exactly

[w0_spectrum.py](../scripts/reviewers/r213/w0_spectrum.py): `W_0`'s `Lambda^2` operator has spectrum `(2, 0^7, -1, -1)`, and exactly over Z

`|W_0|^2 = 24`, `tr(W_0^3) = 48`, `6 tr(W_0^3)^2 = 13824 = |W_0|^6`,

so `F_5(W_0) = 0` with equality holding exactly, not to floating tolerance. The ascent maximiser of section 0 has the same normalised spectrum up to the sign `W -> -W`, so it lies in the orbit of `W_0`, and the bound `Theta_5 = sqrt(3/2)` is attained.

## 3 (continued). The decisive test: 40 points the certificate was never shown

The brief's worry about the rows is the right one -- that the Gram's sextic agrees with `F_5` at exactly the 40 fitting points and nowhere else. That is answered by measurement rather than by an argument.

[r213_assemble_80.py](../scripts/reviewers/r213/r213_assemble_80.py) is a copy of [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py) with two changes -- `NSAMP = 80` and a dump path inside this reviewer's directory, so nothing under review is touched. The pipeline's sample RNG is seeded once, so the first 40 points are the published ones and the last 40 are new. [c3_holdout.py](../scripts/reviewers/r213/c3_holdout.py) then checks the certificate against them.

| check | result |
|---|---|
| the run's first 40 rows and rhs vs the published dump | byte-for-byte identical |
| `rhs == F_5` recomputed from the tensor, all 80 points | 0 mismatches |
| `row(W) . x == F_5(W)`, all 80 points | 0 mismatches |
| **of which the 40 HELD-OUT points** | **0 mismatches** |
| restricted rank at 40 / at 80 points | 13 / 13 |
| `rank([rows | F_5])` at 80 points | 13, still consistent |
| the RESTRICTED row at `W_0` | **0 of 47 entries nonzero** -- the restriction annihilates `W_0`, as `K` requires |
| the unrestricted sampled rank at 80 points | 14 |

An interpolant that merely matched `F_5` on the fitting set would miss a fresh point with probability `1 - O(2^-41)`; it survives 40 of them.

## A bonus for claim 4, which is reviewer 214's: the identity step can be closed without any rank argument

The record's argument is `ker(ev . mu) contains ker(mu)`, `rank(ev . mu) = 13 = rank(mu)`, therefore `ev` is injective on the image. The brief asks whether the two `13`s are ranks of the same map -- a fair worry, because one is measured on the restricted map and the other is asserted of `mu`.

**The step does not need that comparison.** Every entry of a row is itself an `O(5)`-invariant sextic: `B^lambda_ij(W) = <c^{lambda,i}(W), c^{lambda,j}(W)>_Q` with `Q` the invariant form on the abstract `V(lambda)`, and `c^{lambda,i}(gW) = rho_lambda(g) c^{lambda,i}(W)` leaves the multiplicity index alone, so `B_ij(gW) = B_ij(W)`. The restricted entries are fixed real-linear combinations of these, so they are invariant sextics too. Both `row . x` and `F_5` therefore live in `(Sym^6 Weyl_5)^{O(5)}`, which has dimension **14** by Weyl integration ([run_n5_constraint_count.py](../scripts/runs/run_n5_constraint_count.py)).

So it suffices that evaluation at the 40 points is injective on that 14-dimensional space -- a statement about the points alone, with no reference to `mu`. [c4_ev_injective.py](../scripts/reviewers/r213/c4_ev_injective.py) establishes it from outside the pipeline: 120 explicit invariant sextics, built as complete contractions of six copies of `W` over random perfect matchings of the 24 indices, evaluated at the same 40 sample tensors.

| singular values 10-18 of the 40 x 120 evaluation matrix | 0.675, 0.614, 0.530, 0.375, 0.328, 9.4e-15, 5.6e-15, 4.5e-15, 3.6e-15 |
|---|---|
| numerical rank | **14**, with a 14-decade gap |
| theoretical cap | 14 |

Rank 14 against a cap of 14 means the 40 evaluation functionals span the full dual, so evaluation is injective on **every** invariant sextic. Two invariant sextics agreeing at those 40 points are equal, full stop. `row . x = F_5` identically, and neither `rank(mu) = 13` nor `F_5 in image(mu)` is needed for it.

*This is a strengthening, not a correction: the record's argument may well be right. It is simply replaced by one whose only input is a rank measured on objects built independently of the pipeline.*

## Verdict

| # | Claim | Verdict |
|---|---|---|
| 0 | a concrete `W` with `F_5(W) < 0` | **not found**; 3000 gradient ascents all reach `1/sqrt(6)` exactly, at the orbit of `W_0` |
| 1 | the certificate is positive definite | **STANDS**, by verified exact `LDL^H` over `Q(i)` and by sympy eigenvals, with `lambda_min > 21/1000` certified over Q |
| 1b | the block partition is the right one | **STANDS**; order and shape recovered from n5_adapted.pkl, matching the dump, and the sort key has no ties |
| 2 | the point lies in the affine family | **STANDS**; all 40 equations hold exactly over Q, and the lift is confirmed by a held-out fourth prime |
| 3 | the rows are the sextic's coordinates | **STANDS**; rhs `= F_5` exactly at all 40 points, restricted row at `W_0` identically zero, and the sextic matches `F_5` at 40 fresh points |

**Nothing found that refutes `Theta_5 = sqrt(3/2)`.** The two defects flagged in the brief -- the block order and the LDL that passed an indefinite matrix -- are both genuinely fixed, and both fixes survive being rederived from outside the files that made them.

Two items for the record, neither mathematical:
- the certificate's entries are not "at denominator `10^5`"; 13 of the 47 have larger denominators, up to `5e16`;
- [run_n5_verify.py](../scripts/runs/run_n5_verify.py)'s `charpoly` carries an unused, malformed local `mul`.
