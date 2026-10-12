# Gate 2 review 189, the fence post holds and is stronger than the record measured, but block-diagonality is an unstated restriction, the mod-p bridge is unstated, and "a rank deficit of exactly 1" explains nothing

Exact throughout. Integer arithmetic over **F_65537** where the objects under test are themselves defined there (the covariants, the pointwise systems, the per-block invariance sweep), exact integers over **Z** for the extremiser and the witness tensor, exact rationals for the Weyl dimension formula. Every rank reported mod p is a *lower* bound on the char-0 rank, and every place that matters below uses it in the safe direction. Scripts: [scripts/reviewers/r189/](../scripts/reviewers/r189/).

| Claim | Verdict |
| --- | --- |
| 1. Fence post: no Hermitian form in the `P_i` equals `F_5` pointwise | **Upheld, and true in a stronger sense than the record established.** [run_n5_certificate.py](../scripts/runs/run_n5_certificate.py) tests 89 of the 1681 unknowns a general Hermitian form carries. I ran the unrestricted 1681-unknown system: **coefficient rank 1681 (full), augmented 1682, inconsistent.** The restriction is legitimate, by a torus-weight argument the record never gives |
| 1a. Does mod-p inconsistency imply inconsistency over **Q**? | **Yes, and the argument is two lines, but it appears nowhere in the record.** It works *because* the augmented rank came out at exactly (unknowns + 1); the same printout with a rank-deficient coefficient matrix would prove nothing over **Q** |
| 1b. Is the 89-unknown Hermitian parametrisation right? | **Right, and now validated end-to-end rather than against itself.** 89 = Σm², the `2·Re` / `−2·Im` entries are correct, and the covariants are genuine *highest-weight* vectors of the stated weight, tested through the evaluation the certificate actually uses, with a control that fails |
| 1c. Does the corrected structural story explain a rank deficit of exactly 1? | **The story is right; the explanandum is empty.** Invariant Hermitian dimension is exactly **1**, on the trivial block, and `P_1 = 144·tr(W³)` exactly. But an augmented rank never exceeds the coefficient rank by more than 1, so the "1" is forced by linear algebra and carries no structural information. The record's *reason* ("invariant only where the covariant is itself invariant"), is a **non-sequitur as a general principle** |
| 2. The omega contraction and the missing multiplicity factors | **Correct as written; the factors would be a bug.** The cache's raising operator is a derivation on monomials, so the `u_i` are polynomial coefficient vectors and `Σ u[t] ω ω ω` is the matching evaluation. Inserting 1/3/6 destroys the highest-weight property in 216 of 246 cases |
| 3. `F_5`'s normalisation in that script | **Right, and inert for claim 1 either way.** `F_5` vanishes exactly at the padded CP² extremiser in the script's own flat convention, and perturbing the 3/2 or the 9 breaks that. Consistency of a linear system survives any nonzero rescaling of the target |
| 4. The cheap-basis obstruction | **Real, and now exhaustive rather than sampled.** The screen depends only on the underlying multigraph, and there are exactly **3** isomorphism classes with worst cut ≤ 8. All 2187 diagrams they carry span **rank 10**; cap 10 gives **13** over all 10935; cap 12 gives **14** over all 17496. The docstring's claim that the count "runs 4, 6, 8, 10, 12" is impossible, **8 is the floor** |

---

## Claim 1, what was measured, what was concluded, and the gap between them

### 1a. The bridge to **Q**, which the record does not state

Let `C` be the integer matrix of *coefficients* of the 89 real sextics `B_k` (the columns `2·Re(P_i conj P_j)`, `−2·Im(P_i conj P_j)`, `|P_i|²`) against the monomials of degree 6, and `f` the coefficient vector of `F_5`. The cached data is Gaussian-rational with **denominators bounded by 144 and none divisible by p** ([the scan is in c5](../scripts/reviewers/r189/c5_reproduce.py)'s preamble check), so reduction mod p is faithful and the script's row entries are exactly the reductions evaluated at F_p-points. Evaluation is F_p-linear on coefficients, so

> `90 = rank_{F_p}[evaluations] ≤ rank_{F_p}[C̄ | f̄] ≤ rank_Q[C | f]`, while `rank_Q[C] ≤ 89` because `C` has 89 columns.

An augmented rank strictly above the coefficient rank is inconsistency, so the pointwise identity fails over **Q**, hence over **R** (a rational linear system solvable over **R** is solvable over **Q**), hence for PSD `G` in particular. **Rank only drops on reduction, and here it drops in the direction that helps.**

The load-bearing detail is that the augmented rank reached *exactly* `unknowns + 1`. Had the run printed, say, coefficient rank 85 and augmented 86, nothing about **Q** would follow, `2x = 1` is consistent over **Q** and inconsistent mod 2. The record's sentence *"coefficient rank 89, full, so a solution would have been unique"* notices fullness and spends it on uniqueness, which is the one thing it is not needed for.

**Sampling cannot manufacture this verdict.** Each sample point contributes one row; more rows can only raise the augmented rank. So the 140 points are a *witness* of inconsistency, never an artefact of it, the failure mode of too few points is a false report of consistency. Reproduced at 100, 140 (two seed sets) and 200 points, all 89/90: [c5_reproduce.py](../scripts/reviewers/r189/c5_reproduce.py).

### 1b. The parametrisation is right, and the restriction it hides is bigger than the parametrisation

**The Hermitian bookkeeping is correct.** For `i < j`, `G_ij P_i conj(P_j) + G_ji P_j conj(P_i) = 2·Re(G_ij z)` with `z = P_i conj(P_j)`, so `Re G_ij` enters with `2·Re z` and `Im G_ij` with `−2·Im z`, which is what the script writes; the diagonal enters with `Re(P_i conj P_i)`. `Σ m² = 89` over the 24 blocks, and `Σ m·dim V_λ = 7770 = dim Sym³(W_5)` by the Weyl dimension formula for **B2**, so the block table is complete and the 41 covariants are one per irreducible summand (reviewer 188 established the same table from characters).

**But a general Hermitian form on 41 covariants has 41² = 1681 real unknowns, and the script tests 89.** Nothing in the script, the docstring or [plan.md](../plan.md) says why cross-block terms may be dropped. The gap is fillable, and this is the argument the record should carry:

> For `g` in the maximal torus, `P_i(gW) = χ_{λ_i}(g)^{-1} P_i(W)`, so `P_i conj(P_j)` transforms by `χ_{λ_j} χ_{λ_i}^{-1}`, trivial exactly when `λ_i = λ_j`. If `Σ_{ij} G_ij P_i conj(P_j) = F_5` and `F_5` is invariant, split the identity by torus character: the trivial-character part is precisely the block-diagonal part of `G`, and it alone must equal `F_5`. So the block-diagonal part of any solution is itself a Hermitian solution, **block-diagonality is without loss of generality.**

The premise is verified rather than assumed: `P_i(gW) = (c − i·s)^{λ_c} P_i(W)` holds in **328 of 328** cases across two rotation planes, two rotation parameters, two sample tensors and all 41 covariants ([c1_weights.py](../scripts/reviewers/r189/c1_weights.py)). And the conclusion is verified directly: [c3_full_hermitian.py](../scripts/reviewers/r189/c3_full_hermitian.py) assembles the **full 1681-unknown** system over 1750 points and reports **coefficient rank 1681, augmented rank 1682**. So the fence post as *stated* ("no Hermitian form in the `P_i` equals `F_5` pointwise"), is true, not merely the block-diagonal shadow of it that was measured.

**Are the `u_i` the highest-weight vectors the parametrisation assumes?** Reviewer 188 showed the shipped check re-applies the matrices that defined the vectors and so could not have failed. [c1c_highestweight.py](../scripts/reviewers/r189/c1c_highestweight.py) closes that differently: it differentiates the *evaluated cubic* `P_i` along a root vector of so(5) built from scratch out of the 5×5 antisymmetric matrices, splitting `F_p[i]` into its two idempotent components so all linear algebra sits over the field `F_p`. It never reads `E1C` or `E2C`.

> **`E_α · P_i = 0` in 246 of 246 cases** (two simple roots × 41 covariants × three sample tensors), in both split components.

This tests the cache, the weight-basis tensors, the omega contraction and the monomial convention *at once*, which is what a certificate consuming all four needs.

### 1c. The structural story: right conclusion, wrong reason, and nothing to explain

[c2_blockinvariance.py](../scripts/reviewers/r189/c2_blockinvariance.py) computes, block by block, the dimension of the Hermitian `G` for which `Σ G_ij P_i conj(P_j)` is invariant, imposing `S(gW) = S(W)` over 48 (W, gW) pairs with `g` drawn from SO(5, F_p) by Cayley transform. A sampled nullity is an *upper* bound on the true one and a mod-p nullity is an upper bound on the rational one, so the zeros below are proved zeros.

> **Every one of the 23 nontrivial blocks: dimension 0. The trivial block: dimension 1. Total 1 of 89.**

And the trivial covariant is not merely invariant, it is identifiable: **`P_1 = 144·tr(W³)` exactly**, on every sample, with zero imaginary part. So the invariant Hermitian forms reachable in the `P_i` are exactly `R·tr(W³)²`, and

> `F_5 = (3/2)‖W‖⁶ − 9·tr(W³)²` lies in that span only if `‖W‖⁶` does.

That is the whole of the fence post, and it needs no rank computation. [c7_witness.py](../scripts/reviewers/r189/c7_witness.py) turns it into a **single point**: the padded 4-dimensional Weyl tensor with Λ⁺ spectrum `(1, −1, 0)` (Bianchi, pair symmetry and `Ric = 0` all verified over **Z**), has `tr(W³) = 0` and `‖W‖² = 32`, so every invariant Hermitian form in the `P_i` vanishes there while `F_5 = 49152`. One tensor, exact integers, no sampling.

**Two corrections to the record's wording.**

*The stated reason is false as a general principle.* [plan.md](../plan.md) reads "`Σ G_ij P_i conj(P_j)` is invariant only where the covariant is itself invariant". Taken as a principle it is wrong: summing `|P_k|²` over a **full** basis of an irrep copy is invariant while no individual `P_k` is, that is exactly how a symmetry-adapted SOS works. What is true here is narrower and rests on the `u_i` being *one highest-weight vector per copy* rather than a full basis: the torus grading confines `G` to the diagonal blocks, and on a block with `λ ≠ 0` invariance requires `Σ_j (Σ_i G_ij P_i)·(E_α conj P_j) = 0`. For the twelve blocks of multiplicity 1 that is a product of two nonzero polynomials in an integral domain, so `G = 0` outright; for the twelve with `m ≥ 2` I have it measured, not proved. The record's premise (that `g⁻¹u_i` leaves the span of the `u_j`), is a correct observation, but it is a statement about the span failing to be G-stable, and by itself it does not deliver the conclusion.

*A rank deficit of exactly 1 is not a fact about this problem.* Appending one column raises a rank by at most one, so an inconsistent system with coefficient rank 89 has augmented rank 90 necessarily. Nothing structural is being explained, and the numerical coincidence with the one-dimensional invariant subspace found in `c2` is a coincidence: the two 1s are unrelated quantities. **This belongs in [plan.md](../plan.md)'s table of checks that could not have failed.**

### Scope, unchanged

The ansatz draws its `L_k` from the 41-dimensional span of highest-weight covariants inside a 7770-dimensional `Sym³`. The fence post therefore closes a *shortcut* (dropping the Reynolds average) and says nothing against the averaged route, which is what the record claims for it. That reading is correct: pointwise equality implies equality of the averages, so the pointwise demand is strictly the stronger one.

---

## Claim 2, the multiplicity factors would be the error

`raise_mono` in [run_n5_highest_weight.py](../scripts/runs/run_n5_highest_weight.py) acts on `x_a x_b x_c` by replacing one factor at a time and summing over positions, the derivation rule on *polynomials*, which supplies the factor 2 on `x_a² x_b` by visiting the repeated slot twice. So the cached `u_i` are coefficient vectors against polynomial monomials, and `P_i(W) = Σ_t u[t] ω_{t1} ω_{t2} ω_{t3}` is the evaluation dual to the operator that defined them. **No multinomial factor belongs anywhere.**

The check has teeth: re-reading the same `u_i` as symmetric-tensor components (multiplying each coefficient by 1, 3 or 6 according to the repeat pattern), leaves the *weight* untouched (the weight test still passes 328/328, so the weight test alone does not discriminate) but destroys the highest-weight property:

> **`E_α · P̃_i = 0` in only 30 of 246 cases**, against 246 of 246 for the vectors as the script reads them.

The rank verdict is untouched, and would be untouched by any invertible rescaling of the columns in any case.

---

## Claim 3, the 3/2 and the 9

[c4_f5_normalisation.py](../scripts/reviewers/r189/c4_f5_normalisation.py) builds the padded CP² extremiser over **Z** from the self-dual 2-forms `w1, w2, w3` with weights `(2, −1, −1)`, verifies the four curvature symmetries and `Ric = 0`, and evaluates the script's own `F5`:

> flat `q = ⟨W,W⟩ = 96`, flat `tr(M³) = 384`, and `(3/2)·96³ − 9·384² = 0` **exactly**. Controls `(1, 9)`, `(3/2, 8)`, `(3/2, 10)` and `(2, 9)` all miss by ±147456 or more.

The same tensor read as a Λ² operator gives `tr(A²) = 24` and `tr(A³) = 48` (the record's own numbers), with `q_flat/tr(A²) = 4` and `tr_flat/tr(A³) = 8` confirmed entry-wise, so the script's `F_5` is `64×` the record's, uniformly, because `4³ = 8² = 64`. **No mixing:** `omegas` contracts all four tensor indices, `q` uses `einsum('abcd,abcd->')` and `t3` uses the flat 25×25 reshape, one convention throughout.

For claim 1 the whole question is inert: consistency of `A x = b` is invariant under nonzero column scalings and a nonzero scalar on `b`. What *would* have mattered is a *relative* error between the two terms, and the vanishing at the extremiser is precisely the test that catches one.

---

## Claim 4, the obstruction is real, and the cheap end is cheaper on paper than in fact

The screen `worst_cross(m) ≤ 8` is a maximum over 3+3 splittings of *vertices*, so it depends only on the underlying 4-regular loopless multigraph on 6 vertices, not on which slots the edge-ends occupy. That makes the cheap family finite and small. [c6_cheap_basis.py](../scripts/reviewers/r189/c6_cheap_basis.py) enumerates all of it:

> **3355 labelled 4-regular loopless multigraphs on 6 vertices, 24 isomorphism classes. Worst-cut values that occur: 8, 10, 12, and nothing below 8.** Exactly **3** classes reach 8; 15 reach 10; all 24 reach 12.

Per vertex the four incident edge-ends split into the `{0,1}` and `{2,3}` index pairs in 3 ways once W's own antisymmetries and pair exchange are quotiented out, so each class carries `3⁶ = 729` diagrams. Evaluating every one of them at 25 random Weyl tensors over **F_65537**:

| worst 3+3 cut | diagrams (all of them) | rank |
| --- | --- | --- |
| ≤ 8 | 2187 | **10** |
| ≤ 10 | 10935 | **13** |
| ≤ 12 | 17496 | **14** |

**No sampling anywhere, no skipped diagram.** The record's 10 / 13 / 14 is exact and the obstruction is a property of the family, not of the 40000 draws. Since a mod-p rank is a lower bound, the 10 could in principle be a shortfall of `F_10007` in the shipped run, it is not: the same 10 holds over `F_65537` on an exhaustive family.

One correction. The docstring of [run_n5_cheap_basis.py](../scripts/runs/run_n5_cheap_basis.py) says the count "runs 4, 6, 8, 10, 12, giving reduced tensors of 5^c entries, 625 up to 244 million". **The 625 end is unreachable for the quantity the code screens on:** the worst-case count over splittings is never below 8, so the cheapest reduced tensor any basis can carry is `5⁸ = 390625`, three orders of magnitude above the figure quoted. A per-splitting count of 4 or 6 does occur; the memory driver, which is what `worst_cross` returns and what the CAP compares against, does not.

---

## What could have failed, and did not

The equivariance test (328/328), the highest-weight test with its failing control (246/246 against 30/246), the completeness of the block table (`Σ m·dim V_λ = 7770`), the extremiser vanishing with four failing controls, the full 1681-unknown system, and the exhaustive cheap-basis rank are each falsifiable and each came out on the record's side. The two findings that move the record are that **the tested claim was narrower than the stated one** (repaired here by the torus argument and by running the unrestricted system) and that **the rank deficit of 1 explains nothing**.
