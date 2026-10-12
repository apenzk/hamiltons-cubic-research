# Gate 2 review 188, the raising check is circular but its conclusion survives, the normalisation choice has no consumer, and the round trip does not pin W_0

Exact throughout: `Fraction` over **Q(i)** for the cached raising operators, `Fraction` over **Q** for the normalisation arithmetic, integer arithmetic over **F_1000000009** for the kernel sweep of claim 2 and over **F_10007** for claim 1 (where the objects under test are themselves defined mod p). Character theory for the block table is done in exact rationals with no numerics at all. Scripts: [scripts/reviewers/r188/](../scripts/reviewers/r188/).

| Claim | Verdict |
| --- | --- |
| 1. The coefficient check tests a sum | **Upheld, with two witnesses that pass it**, and the shipped extraction is nevertheless *proved* correct, for every `r` and every multi-index, by Stirling triangularity |
| 2. The raising-operator check reads a gitignored cache | **Upheld and sharpened: the check is circular and could not have failed.** It re-applies the matrices that defined the vectors. The conclusion is true anyway, I rebuilt the block table from characters, with no pipeline code, and sandwiched the 41 |
| 3. The round trip as discriminator | **Right test, wrong billing.** It is an encoding test and it does not pin `W_0`: the (1,1,−2) frame passes Bianchi, Ric = 0 *and* the round trip, with θ = −√(3/2) |
| 4. The normalisation decision | **Self-consistent, and inert.** No script in `scripts/runs/` mixes the two, no script consumes the invariant Gram, and Θ² = 3/2 is the same number in both conventions |

---

## Claim 2, the check is circular, and the conclusion is true for reasons the check does not supply

**The circularity is exact, not approximate.** [run_n5_highest_weight.py](../scripts/runs/run_n5_highest_weight.py) defines each `u_i` as a vector in `nullspace_G(rows)` where `rows` is assembled by `raise_mono(m, E1C)` and `raise_mono(m, E2C)`. [run_n5_cubic_forms.py](../scripts/runs/run_n5_cubic_forms.py) then reports "both raising operators annihilate `u_i`: 41/41" by computing `raise_vec(u, E1)` and `raise_vec(u, E2)` from the *same* `E1C`, `E2C`, serialised and deserialised through the cache. The two routines are the same loop over the same matrix. **The only failure this check can register is an arithmetic bug inside `nullspace_G`.** An error in `E1C` or `E2C` (a wrong root vector, a wrong `to_weight_coords` solve, a wrong Cartan), propagates identically into both sides and is invisible. So it belongs in [plan.md](../plan.md)'s table of checks that could not have failed.

**The teeth are blunter than the check.** The perturbation draws `k` uniformly from all 7770 monomials, so the perturbed vector almost always sits at a *different weight* from `u_i` and is raised nontrivially for that reason alone. Exactly one monomial in Sym³ is annihilated by both operators (the cube of the (2,2) weight vector) so "36/36 survive" is a near-certainty by construction. A tooth that meant something would perturb *inside* the λ-weight space.

**And the cache is not self-describing.** It stores `weights`, `hw`, `E1C`, `E2C`, but not `WBASIS`, the 35 weight vectors in Weyl_5 coordinates. The `u_i` are coordinate vectors against a basis the cache does not contain, so the docstring's headline object, "the 41 cubic forms `P_i(W) = <W³, u_i>`, in real coordinates on Weyl_5", cannot be formed from the cache. The script does not form it either: no `P_i`, no inner product, no `F_5`, no 14 × 36 system appears anywhere in it.

### What I could establish without the pipeline

[claim2_plethysm.py](../scripts/reviewers/r188/claim2_plethysm.py) decomposes `Sym³(V_(2,2))` for **B2** from characters alone (Freudenthal for the weight multiplicities, then peeling the highest dominant weight), using no `GENS`, no `BASIS`, no raising operator and no cache.

> **41 summands over 24 distinct λ, dimensions summing to 7770, and the hardcoded `BLOCKS` table matches entry for entry.**

This matters beyond confirming the count. The shipped loop iterates `for lam in sorted(BLOCKS, ...)`, so **an omitted block would have been invisible to it**, the completeness of the table is exactly what the shipped script assumes rather than tests. It is now proved. The same computation reproduces the record's 35 weight labels, `{(0,0): 3, (±1,·): 2, …}`, independently.

### Are the cached operators the right ones?

[claim2_serre.py](../scripts/reviewers/r188/claim2_serre.py) transposes the cache first, `E1C[j][k]` is stored as *input j → output k*, which is how `raise_mono` reads it, and which is worth stating since reading it the other way makes every weight-shift assertion come out false, and then tests `E1`, `E2` directly, without touching the `u_i`:

- **Serre for B2**: `(ad E1)² E2 = 0` and `(ad E2)³ E1 = 0`, both exactly, with `[E1,E2] ≠ 0` and `[E2,[E2,E1]] ≠ 0` and `[E1,[E2,[E2,E1]]] = 0`, the four positive roots of B2, all present, algebra closing at dimension 4.
- **Irreducibility**: `dim ker(E1) ∩ ker(E2) = 1` on Weyl_5 itself, and `codim(im E1 + im E2) = 1`. One highest-weight line, one lowest-weight line, so Weyl_5 is the irreducible `V_(2,2)` rather than a reducible module with the same weights.

[claim2_operators.py](../scripts/reviewers/r188/claim2_operators.py) then sweeps the joint kernel over **every one of the 169 nonempty weight spaces of Sym³**, against the 24 the shipped script visits, over **F_1000000009** with a square root of −1 adjoined. Rank mod p is at most rank over **Q**, so the nullity it reports is an *upper* bound on the true nullity.

> Every weight matches the character-theoretic multiplicity. **Zero spurious kernel at all 141 non-dominant weights, and at the four dominant weights `(1,1)`, `(5,5)`, `(6,1)`, `(6,5)` that occur in Sym³ but carry no copy**, and since the bound goes the safe way, those zeros are proved zero over **Q**. Total 41.

Exact arithmetic over **Q(i)** then confirms the 41 cached vectors lie in the joint kernel and are linearly independent within their weight spaces, giving the lower bound. **Sandwich: 41 ≤ true nullity ≤ 41.** The cached vectors are a basis of the joint kernel of a pair of operators that satisfy Serre, act irreducibly, and reproduce the character-theoretic branching at all 169 weights.

**Verdict.** The claim stands: the shipped check is meaningless as a check. The object it fails to validate is nonetheless correct, and the three tests above are what establishes that, each of them could have failed, and two of them (the non-dominant kernel sweep, the block-table completeness) test things the pipeline has no way to reach.

---

## Claim 4, the choice is consistent, and it has no consumer

[claim4_normalisation.py](../scripts/reviewers/r188/claim4_normalisation.py), exact over **Q** on the rebuilt module.

**Θ² = 3/2 is the same number in both conventions.** At `S = √6 W_0`: `|S|²_tensor = 24` against `tr(A²) = 6` (ratio 4), and `tr_flat(S³) = 48` against `tr_op(S³) = 6` (ratio 8). Since `4³ = 8² = 64`, the ratio `9 tr(W³)²/|W|⁶` is **invariant**, and it is `3/2` computed either way. This is the load-bearing fact: had it not held, `√(3/2)` would be wrong in one of the two conventions and the entire route-B frontier, the `1.224745` in every threshold and filename, would be mis-scaled.

**`F_5` moves by a uniform positive scalar and nothing else.** `F_tensor/F_operator = 64` exactly on six random Weyl tensors over **Q**, so "`F_5` is a sum of squares" and "`F_5` vanishes at `W_0`" are both untouched by the choice.

**Where a mixed use would bite, and whether it exists.** `P_i(W) = <W³, u_i>` uses the Gram three times, so `G → 4G` scales `P_i` by `4³` and `P_i conj(P_j)` by `4⁶`, against `4³` on the sextic side, a residual `4³ = 64`. Reviewer 185's "leaks a `4³`" is the right number. But:

> **No script under `scripts/runs/` imports [run_n5_inner_product.py](../scripts/runs/run_n5_inner_product.py).** [run_n5_cubic_forms.py](../scripts/runs/run_n5_cubic_forms.py) names it in prose and forms no `P_i`; [run_n5_dictionary.py](../scripts/runs/run_n5_dictionary.py) is a scaffold that stops with "blocked on `run_n5_copies.py`"; [run_n5_copies.py](../scripts/runs/run_n5_copies.py) uses spans and echelon reduction, no inner product anywhere.

The 35 × 35 invariant Gram has **zero consumers**. The decision recorded in [plan.md](../plan.md) is a decision about a computation nobody has written.

**The sweep.** [claim4_sweep.py](../scripts/reviewers/r188/claim4_sweep.py) classifies every normalising line in `scripts/runs/`. One script carries both patterns together with a θ, and two more deserve reading:

| Script | What it does | Verdict |
| --- | --- | --- |
| [run_bispectral_dictionary.py](../scripts/runs/run_bispectral_dictionary.py) | generator returns `W/|W|_tensor`; the loop re-divides by `|M|` before any trace | consistent |
| [run_bispectral_identity.py](../scripts/runs/run_bispectral_identity.py) | line 79 rescales by 2 with the comment `|W|² = 4|M|²`, landing on `|M| = 1` | consistent, and it is the one script that states the factor |
| [run_lovelock_syzygy.py](../scripts/runs/run_lovelock_syzygy.py) | tensor-normalises, then reports only ratios of degree-3 quantities | scale-free |
| [run_invariant_dimension_deg56.py](../scripts/runs/run_invariant_dimension_deg56.py) | tensor-normalises, then takes a rank | scale-free |

Every θ formed anywhere in `scripts/runs/` is formed at `|M| = 1`, the operator convention: [run_diagonal_spread.py](../scripts/runs/run_diagonal_spread.py), [run_kappa_frame_invariant.py](../scripts/runs/run_kappa_frame_invariant.py), [run_graded_gap_hunt.py](../scripts/runs/run_graded_gap_hunt.py), [run_k_bound_falsifier.py](../scripts/runs/run_k_bound_falsifier.py) and the rest all divide by the Frobenius norm of the Λ² matrix.

**Verdict.** Self-consistent, **no mixed use anywhere in `scripts/runs/`**. Two qualifications the record should carry instead of the flat sentence "the SDP is carried in the tensor normalisation":

1. The route-B half of the repo is uniformly in the **operator** convention, and `Θ = √(3/2)` is an operator-convention statement that happens to be convention-free. The commitment to tensor governs the certificate line only.
2. [run_n5_extremiser.py](../scripts/runs/run_n5_extremiser.py) still prints `|W_0|² = 1`. Under the tensor commitment that number is 4. Nothing reads it, so this is a reporting divergence rather than an error, but it is the same divergence that [plan.md](../plan.md) already flags, still live.

---

## Claim 3, the round trip separates the encodings and not the frames

[claim4_normalisation.py](../scripts/reviewers/r188/claim4_normalisation.py), section Q4. Build the Λ⁺ frame operator with spectrum `(1,1,−2)` instead of `(2,−1,−1)`, exactly over **Q**, and put it through both of the extremiser's tests:

> Bianchi and Ric = 0: **passes**. Round trip `sym2_to_R → Λ²` returns `S` entrywise: **passes**. `tr(S³) = −6` against `+6`, so `θ² = 3/2` with **θ negative**.

**So the round trip does not pin `W_0`.** It is a test of the *coordinate encoding* (whether the vector handed to `bianchi_rows`/`ricci_rows` denotes `S` or `2S − diag(S)`) and for that it is the right test and the only one available, since both encodings are Weyl tensors. It says nothing about which Weyl tensor. Reviewer 186's observation survives claim 3 unchanged: membership does not pin the spectrum, and neither does the round trip. **What pins `W_0` is `tr(W_0³) = +1/√6`**, which the script computes and prints but does not use as a gate.

The script's own framing ("the test that separates them"), is accurate for the pair it names and reads as more than it is. The two objects it separates differ by an encoding convention; the two objects reviewer 186 named differ by a sign of θ, and the round trip is blind to them.

---

## Claim 1, the sum test, two witnesses, and why the extraction is right anyway

[claim1_sum_witness.py](../scripts/reviewers/r188/claim1_sum_witness.py), over **F_10007**.

**The claim is upheld.** The shipped validation is `sum_d coeff(d, 6−d) == J(A+B)`, and any redistribution passes it. Two witnesses, on five random matchings each:

- **W1, reverse the multi-index**: `coeff'(d, 6−d) := coeff(6−d, d)`. The coefficient sequence is **not palindromic** on any of the five matchings, so W1 is a genuinely different rule, and it passes the shipped check on all five.
- **W2, move mass**: add 1234 to `coeff(2,4)` and subtract it from `coeff(4,2)`. Passes on all five.

**The repair is one character's worth of work.** Weight the sum: `sum_beta c_beta prod_i s_i^{beta_i} == J(sum_i s_i T_i)` at random `s`. That is a Vandermonde system in the ratios, so it pins every coefficient individually. The shipped coefficients pass it on all five matchings at four random points each; **W1 and W2 fail it on all five.** It extends unchanged to `r > 2`: at `r = 3`, all 28 multi-indices of total degree 6 satisfy the weighted identity, while the unweighted sum they currently test is passed by any redistribution among the 28.

**And the rewritten Vandermonde elimination is correct, provably, not by sampling.** The shipped `coeff` fits a degree-`b_i` polynomial in `x_i` through the `b_i + 1` points `0..b_i`, while the true function has degree 6 in each variable. That looks like an interpolation error and is not. The functional it applies is the `b`-th finite difference at 0 over `b!`, which on `x^d` returns the Stirling number `S(d,b)`, and **`S(d,b) = 0` for `d < b`**. So pass `i` annihilates every term with `d_i < b_i`. After all `r` passes, `sum_i d_i = 6 = sum_i b_i` with `d_i >= b_i` for every `i` **forces `d = beta`**, with coefficient `S(b_i,b_i) = 1`. Exact for any `r` and any multi-index of total degree 6, and the argument shows exactly where it would break, namely `|beta| != deg`, which no test exercises because no caller can produce it.

Checked against ground truth rather than trusted: full 7-point extraction in `s` from `J(sA + B)` reproduces the shipped 3-to-5-point answers on three matchings, and the shipped `r = 4` values at `beta = (3,1,1,1)`, `(2,2,1,1)`, `(4,1,1,0)`, `(1,1,1,3)` (shapes the shipped tests never touch), agree with the independent finite-difference extraction.

---

## What each check could have failed on

| Check | Could it have failed? |
| --- | --- |
| `raise_vec(u_i, E1) == 0`, 41/41 | **No.** Same matrix that defined `u_i` as a nullspace; only `nullspace_G` is on trial |
| teeth, 36/36 | **Barely.** One monomial of 7770 is annihilated by both operators; the perturbation draws from all 7770 |
| block table completeness | **Never tested.** The loop iterates over the table. Now proved complete from characters |
| joint kernel away from the 24 blocks | **Yes, and it did not**, 145 weight spaces the pipeline never looks at (141 non-dominant, 4 dominant with no copy), all zero |
| Serre relations on `E1C`, `E2C` | **Yes.** A mis-built root vector pair fails them |
| round trip on the extremiser | **Yes for the encoding, never for the frame**, the (1,1,−2) witness passes it |
| `sum_d coeff = J(A+B)` | **Yes, but not per-β**, W1 and W2 pass it |
| weighted sum at random `s` | **Yes, per-β**, W1 and W2 fail it |
