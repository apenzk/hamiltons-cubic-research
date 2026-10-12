# Gate 2 review 186, the extremiser repair, the scope of the 64, and a witness for the polarised diagram

Everything below is exact: `Fraction` over **Q** for claims 3, 4 and 5, `Fraction` over **Q(i)** for claim 2, and exact integer arithmetic over **F_10007** for claim 1 (where the objects under test are themselves defined mod p). Scripts: [scripts/reviewers/r186/](../scripts/reviewers/r186/).

| Claim | Verdict |
| --- | --- |
| 1. The polarised diagram's checks may not pin it | **Upheld, with a witness.** A vertex-swapped map passes both checks and differs on distinct tensors, but the shipped map is nonetheless correct |
| 2. The cubic forms' support, and the cache | **Confirmed.** 1..195, mean 48.5, all inside the 234; the cache is faithful, proved by an exact identity the record never runs |
| 3. The extremiser repair | **Genuine.** The undoubled vector *is* the CP² Weyl tensor, verified against an independent Fubini–Study route; same object as the spectrum and tr(W_0³) |
| 4. The 64 as a grading | **Identity correct, scope narrower than "all 14".** The operator-trace sextics span exactly **4** of the 14 dimensions |
| 5. G_tensor = 4 G_operator | **Confirmed on all 630 entries.** The SDP must be carried in the operator normalisation |

---

## Claim 3, the repair swaps in the right object, and the check could have failed

[claim3_extremiser.py](../scripts/reviewers/r186/claim3_extremiser.py) rebuilds `√6 W_0` from scratch as a rank-4 rational tensor `R_A`, component matrices for the self-dual forms, no coordinate vectors, none of the record's machinery, and then audits the coordinate map.

**The undoubled vector denotes exactly `R_A`.** [sym2_to_R](../scripts/runs/run_n5_weyl_module.py) applied to `{(a,b): S[a][b]}` reproduces `R_A` entrywise over all 625 components; applied to the doubled vector it does not. The doubled vector's Λ² operator is `2S − diag(S)` (confirmed entrywise, so reviewer 184's diagnosis is exact) and that object carries `tr(A²) = 15` and `tr(A³) = 39/2` against `6` and `6`. **The old test therefore certified an object with the wrong invariants**, and the repair replaces it with the one whose spectrum and traces the script prints, since `S` is built once and both the coordinate vector and the traces are read off it.

**An independent route to `W_0`.** Route B takes the Fubini–Study curvature tensor of constant holomorphic sectional curvature, `R_ijkl = δδ − δδ + JJ − JJ + 2 J_ij J_kl`, the formula in [cp2_tensor.py](../scripts/cp2_tensor.py), re-typed over Q, checks it is Einstein with scalar 24, subtracts its Ricci and scalar parts by Kulkarni–Nomizu, and pads the Weyl part to R⁵. It shares no code with route A. Result:

> supports coincide, and `R_A = (1/2)·Weyl(FS)`, a single positive rational ratio across every nonzero component.

So the object the record calls `W_0` is the CP² Weyl tensor, normalised so that `‖W_0‖²_Λ² = 1`.

**Bianchi and Ric = 0, from the definitions.** On `R_A` directly: antisymmetry in both slot pairs, pair symmetry, `max|R_ijkl + R_iklj + R_iljk| = 0` and `max|Σ_m R_mimj| = 0`, all over the full index range.

**Could the check have failed?** The Bianchi + Ricci row system has **rank 20** on the 55-dimensional `Sym²(Λ²)`, leaving 35, so it is 20 independent conditions, and 20 of 20 random integer coordinate vectors are rejected. Structured near-misses: one off-diagonal entry bumped violates 1 row, one diagonal entry bumped violates 2, a swap of two Λ² basis vectors violates 4.

*One caveat the record should carry.* Membership alone does **not** pin the spectrum. The Λ⁺ frame with eigenvalues `(1,1,−2)` and the **anti**-self-dual frame with `(2,−1,−1)` both satisfy Bianchi and Ric = 0 with 0 rows violated; the first has `tr(A³) = −6`, i.e. `θ < 0` in the record's convention. What pins `W_0` is the explicit construction plus the spectrum, not the membership test, and both now read off the same `S`.

## Claim 4, the identity is right, and it covers 4 of the 14

[claim4_grading.py](../scripts/reviewers/r186/claim4_grading.py).

**(i) The identity.** `tr(M^k) = 2^k tr(A^k)` holds exactly at six random rational points of Weyl_5 for `k = 1..6`. It has teeth in both hypotheses: breaking pair antisymmetry in one entry makes it fail at `k = 2,3,4`, and adding a self-pair entry `W_00cd = W_cd00 = 1` symmetrically (which leaves `A` untouched, since `A` never reads a self-pair), also makes it fail at `k = 2,3,4`. So "the diagonal vanishes" is load-bearing rather than decorative.

**(ii) The scope.** A degree-6 diagram whose matching glues whole pair-slots is a product of `tr(A^{k_i})` with `Σ k_i = 6`; `tr(A) = 0` on Weyl, so the surviving partitions are `6`, `4+2`, `3+3`, `2+2+2`, **four** monomials. Their evaluation matrix at 12 exact rational points has rank exactly 4 over Q, and adjoining F_5 leaves the rank at 4 (F_5 is an operator-trace sextic). Adjoining random diagram functionals mod 10007 raises the rank **ten** more times, to 14.

> **The grading covers a 4-dimensional subspace of the 14-dimensional space of invariant sextics, not all of it.**

The other ten directions have no second convention to be scaled between: a diagram functional is a contraction over ordered indices and has one value. There is nothing there for the grading to cover, and correspondingly nothing there that the mix-up could spoil.

**(iii) Which of the record's two positions is true.** The replacement, and the retraction is justified, the retracted note is refuted by its own examples. It said a sextic "mixing the two differently (q² times a quadratic, say, or q times tr), would scale its terms by different powers and the built polynomial would be WRONG, not scaled". Measured: `q²·q` scales by **64**, `q·tr` by **32**, `tr(A²)tr(A⁴)` by **64**. The grading is by *degree*, so every term of a homogeneous degree-6 operator-trace invariant carries the same 64 whatever its shape. The note's error was reading the ratio off the monomial's shape rather than its degree.

*What the record should add:* the sentence in [run_n5_sextic_basis.py](../scripts/runs/run_n5_sextic_basis.py) is accurate as scoped ("for the whole operator-trace subalgebra") but a reader coming to it from the 14 will want the dimension. It is 4 of 14, and F_5 is one of the four.

## Claim 5, the factor of 4, and which side the SDP must sit on

[claim5_normalisation.py](../scripts/reviewers/r186/claim5_normalisation.py) builds both Grams on the 35 basis vectors of Weyl_5: `G_tensor[i][j] = Σ_ijkl R S` over ordered indices, `G_operator[i][j] = Σ_{a,b ∈ PAIRS} A_R A_S`. **`G_tensor = 4·G_operator` on all 630 entries**, exactly. At `√6 W_0` the two read 24 and 6, so `‖W_0‖²` is 4 against 1. Reviewer 183's claim is confirmed.

Which one the SDP must use: the diagram functionals `D_1 … D_14` are evaluated by ordered-index contraction, and the coordinates the record carries (`−39, −3/4, −3, …`), are those of the **operator-normalised** F_5 in that basis (the flat build is 64 times them). Coordinates in a basis do not involve an inner product, so the constraint falls entirely on the pairing side: `⟨W³, u_i⟩` and the Gram must be normalised to match the F_5 whose coordinates are used. Since the listed coordinates are the operator ones (and since `‖W_0‖² = 1` and `θ = √(3/2)` are the record's statements everywhere else), **the operator (Λ²) normalisation is the one to carry, and [run_n5_inner_product.py](../scripts/runs/run_n5_inner_product.py)'s Gram must be divided by 4 before it enters the SDP.** The alternative, keeping the tensor Gram and the ×64 integer coordinates, is equally consistent; what cannot survive is leaving the choice unstated.

## Claim 1, the checks do not pin the map, and here is the witness; the map is right anyway

[claim1_polarised.py](../scripts/reviewers/r186/claim1_polarised.py).

**The witness.** Define `eval_wrong` as [eval_polarised](../scripts/runs/run_n5_polarised_diagram.py) precomposed with the transposition of vertices 0 and 1. It passes check (a) `J(W,…,W) =` the unpolarised evaluation, 12/12, and check (b) multilinearity in slot 0, 12/12, and it differs from the shipped map on six distinct tensors at **12 of 12** matchings. Both checks are blind to any relabelling of the six vertices, which is a group of order 720, and the values are genuinely spread: across a sample of 103 permutations of the six tensors, up to 103 distinct values. **The brief's suspicion is upheld.**

**The shipped map is nevertheless correct.** An independent evaluator, explicit leg lists and `np.tensordot` with a greedy least-output contraction order, sharing no index bookkeeping with the shipped einsum-letter code, agrees with it at **25 of 25** matchings on six distinct Weyl tensors, and at 24 of 24 after permuting the tensors.

**What the two checks *do* pin, stated positively.** A multilinear form whose diagonal restriction is `J` has a *unique* symmetrisation, namely the polarisation of `J`. Multilinearity holds in every slot, not only slot 0 (6/6 matchings for each of the six), so the shipped map's S₆-symmetrisation is forced to be right, and it is: `(1/720) Σ_π eval_polarised(T_π)` equals the finite-difference polarisation `(1/720) Σ_S (−1)^{6−|S|} J(Σ_S T)` at every matching tried. The vertex-permutation ambiguity the witness exhibits is therefore invisible to any consumer that symmetrises, and fatal to one that does not.

**The docstring's recipe was one that does not.** For `J(x T_0 + y T_1)` at a fixed matching, the coefficient of `x³y³` extracted by Vandermonde interpolation over F_p is **1407**. One assignment ("the diagram contracted with the six basis tensors the monomial names"), gives **2883**. The sum over the 20 assignments gives **1407**. Reviewer 185 reached the same conclusion by an independent route and has already corrected the file; this is a second, independent confirmation, and it adds the positive half: the function is sound, only its advertised use was not.

**The self-pair branch.** It is unreachable through [random_matching](../scripts/reviewers/r179/weyl_invariants.py), which forbids intra-vertex pairs, and it cannot be reached from a legal matching by contraction either: every leg crossing two live tensors is contracted at the merge that joins them, so no internal leg ever survives into the final loop. It is dead code under the only generator that calls it.

## Claim 2, the support is as reported, and the cache is faithful

[claim2_cache.py](../scripts/reviewers/r186/claim2_cache.py) reads `n5_hw_cache.json` and rebuilds the weight combinatorics independently: 7770 monomials in 169 weight spaces, the largest of dimension **234** at weight `(0,0)`, so the bound the record quotes is the largest Sym³ weight space, as claimed. The 41 vectors have supports `1..195` with mean `48.5`, each support lies inside a single weight space, and each is within that space's dimension (the extreme cases being 195 of 234 and 183 of 210).

**Faithfulness of the round trip is not asserted, it is proved.** Each Gaussian rational is stored as two `[numerator, denominator]` pairs and read back by exact `Fraction` construction, so the round trip either is exact or breaks an algebraic identity. The identity: every cached vector must be annihilated by both raising operators. Rebuilding the derivation action from the cached `E1C`, `E2C` gives **41 of 41 annihilated exactly over Q(i)**, and bumping one coefficient by 1 is rejected in **40 of 40** vectors with support ≥ 2. The block labels also match the weights of their supports, 41 of 41.

*A gap, small but real.* [run_n5_cubic_forms.py](../scripts/runs/run_n5_cubic_forms.py) opens by promising "Check: P_i is the cubic form of a highest-weight vector, so as a polynomial it is annihilated by both raising operators" and closes by saying that check "is the next step". The script runs no check at all, it reports sizes read from a cache. The check passes; it should be in the script that advertises it, since the cache is gitignored and nothing else re-validates it downstream.

## What this review would have the record change

1. **Record the dimension with the grading.** The 64 covers 4 of the 14 invariant sextics, F_5 among them. The remaining ten have a single convention and are untouched by it.
2. **Name the normalisation in the SDP, once.** Operator (Λ²) throughout, with [run_n5_inner_product.py](../scripts/runs/run_n5_inner_product.py)'s Gram divided by 4, that is the convention `‖W_0‖² = 1`, `θ = √(3/2)` and the listed F_5 coordinates already live in.
3. **Move the raising-operator check into [run_n5_cubic_forms.py](../scripts/runs/run_n5_cubic_forms.py).** It passes from the cache alone, and it is the only thing standing between a corrupted cache and the pairing stage.
4. **Note next to the extremiser that membership does not pin the spectrum.** Two wrong spectra pass it with zero rows violated; the construction and the printed eigenvalues are what identify `W_0`.
