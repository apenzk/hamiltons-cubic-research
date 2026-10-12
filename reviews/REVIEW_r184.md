# Gate 2 review 184, the rational placement, the 41 copies, and a check that could not have failed

Everything below is exact: `Fraction` over **Q**, Gaussian rationals for the highest-weight arithmetic, Python integers for the diagram evaluations. The prime 10007 appears once, only to reproduce the record's own diagram selection; every conclusion is re-established without it. Sage enters as a second, independent character engine. Scripts: [scripts/reviewers/r184/](../scripts/reviewers/r184/).

Reviewer 183 worked the same brief in parallel. Where we overlap we agree to the last coefficient, and I say so rather than restating the derivation. Two places I reach a different conclusion from the record *and* go past 183 are marked **NEW**.

| Claim | Verdict |
| --- | --- |
| 1. F_5 carries a factor error, so its placement proves nothing | **Refuted.** The built F_5 is exactly 64 × the record's, uniformly; it vanishes at W_0 |
| 2. The mod-p placement does not establish a rational one | **Refuted, constructively.** Exact coordinates over Q, confirmed on 12 held-out points |
| 3. Invariance rests on 30 random pairs | **Gap upheld and closed.** Proved outright as AᵀG + GA = 0; the two norms differ by 4 |
| 4. The Weyl-integration 14 is unchecked at n = 5 | **Confirmed, 14**, by Sage plethysm on a five-rung ladder that could have failed at each rung |
| 5. The copies script has not been rerun | **Rerun. 41/41 match.** But its closure needed one more check, see **NEW (b)** |

---

## Claim 2, the placement is rational, and here are the coordinates

The record's supporting argument, as the brief states it, is **valid**, and each step survives inspection:

1. The 14 diagram functionals have integer coefficients. If a rational relation held among them, clearing denominators to a primitive integer relation and reducing mod p would give a nonzero relation over F_p. The mod-p rank of 14 therefore forces Q-independence. Sound.
2. Complete metric contractions of W^⊗6 are O(5)-invariant of degree 6, so the 14 sit inside the invariant space; with dim = 14 they span it.
3. F_5 is a degree-6 O(5)-invariant, both `‖W‖⁶` and `tr(W³)²` are polynomials in traces of the Λ² operator, which O(5) conjugates. So F_5 lies in the span *a priori*.

Step 2 is the only load-bearing import, and it is claim 4's number. So the argument is airtight **conditional on 14**, and it establishes existence only, the coordinates the record holds are residues mod 10007, which are not coordinates over Q.

I closed both gaps by solving over Q directly ([exact_placement.py](../scripts/reviewers/r184/exact_placement.py)):

- The record's selection is reproduced bit-for-bit, same seeds, same generator call sequence: **14 independent diagrams from 15 matchings**, as the record reports.
- Weyl tensors over **Z** were built by clearing the `1/(n−2)` and `1/(2(n−1)(n−2))` denominators with a factor 24; degree-6 homogeneity makes that factor invisible in the coordinates. All four symmetries and Ric = 0 are asserted exactly on each.
- The 14 diagrams were evaluated exactly (Python-int `tensordot`, no modulus), and the system solved by exact Gaussian elimination on **18** points. Rank 14.

Coordinates of F_5 in the record's own Λ²-operator normalisation:

| | | | | | | |
| --- | --- | --- | --- | --- | --- | --- |
| c₀ = −39 | c₁ = −3/4 | c₂ = −3 | c₃ = −3 | c₄ = 51/2 | c₅ = −27 | c₆ = −21/2 |
| c₇ = −6 | c₈ = −27 | c₉ = −3 | c₁₀ = −6 | c₁₁ = −9 | c₁₂ = 3 | c₁₃ = 9 |

All fourteen are nonzero, matching the script's `nonzero in 14 of 14`, and all lie in (1/4)Z. The decisive check: this vector reproduces F_5 exactly at **12 further integer Weyl tensors never used in the fit**. A fit on 18 points that survives 12 held-out points is a placement, not a curve fit. For the built F_5 the coordinates are 64× these.

**Verdict: refuted.** The placement is rational, the argument the record gives for it is sound, and the coordinates are now explicit and independent of any prime.

## Claim 5, the rerun, and what per-block agreement does not prove

`python3 scripts/runs/run_n5_copies.py` from a clean start, 145 s, pure `Fraction`, negligible memory. Log: [copies_rerun.txt](../scripts/reviewers/r184/copies_rerun.txt).

**41 copies built, 41 `OK`, zero `!!`.** `generated == want` on every line. The `want > 900` guard never fired: the largest block is λ = (6,4) at 810, so nothing was truncated.

**NEW (a), the block list is right, checked against a second engine.** [sym3_decomp.sage](../scripts/reviewers/r184/sym3_decomp.sage) decomposes `Sym³(V_(2,2))` in Sage's `WeylCharacterRing`, which shares no code with the record. It returns **24 blocks, 41 copies, Σ mult·dim = 7770 = dim Sym³(Weyl_5)**, and the block-and-multiplicity list agrees with the rerun *entry by entry*. So the record's highest-weight search missed no block and invented none, a statement the rerun alone cannot make, since it only ever visits blocks the search already found.

**NEW (b), `generated == want` on all 41 does not close the claim, and neither does the 7770 sum.** `generate()` computes the dimension of `U(n⁻)·u` for one highest-weight vector at a time. Two copies of the *same* λ could each come out at the right dimension and still be the same subspace; the dimensions would sum to 7770 and the copies would nonetheless fail to be a direct sum. The script never tests this, and the sum-to-7770 argument silently assumes it away. The missing statement:

> h.w. vectors of the λ-isotypic component `V_λ ⊗ Mult_λ` correspond to elements of `Mult_λ`, and `V_λ ⊗ m₁ ∩ V_λ ⊗ m₂ = 0` for independent m₁, m₂. So the copies of one λ are independent **iff** its h.w. vectors are.

[hw_independent.py](../scripts/reviewers/r184/hw_independent.py) ranks the h.w. vectors per λ exactly over Q(i): **every λ's h.w. set is independent, and its size equals Sage's multiplicity for that λ**. Only with this in hand does 41 × (right dimension) become "the 41 copies are a direct-sum decomposition of Sym³(Weyl_5)".

**Verdict: the rerun passes, and the claim is now genuinely closed rather than closed by a sum.**

## Claim 1, the 64, and the extremiser's own convention

`q` and `trM3` in [run_n5_sextic_basis.py](../scripts/runs/run_n5_sextic_basis.py) use the flat 25×25 reshape over *ordered* index pairs; the rest of the record uses the 10×10 Λ² operator. Measured exactly at 30 integer Weyl tensors: **`F_5 built / F_5 record = 64` at every one of them**, a single Fraction, no exceptions ([exact_placement.py](../scripts/reviewers/r184/exact_placement.py)). `q_flat = 4 tr(A²)`, `tr M³ = 8 tr(A³)`, and `4³ = 8² = 64`. Reviewer 183 gives the structural reason (`tr(Mᵏ) = 2ᵏ tr(Aᵏ)`, so trace-word invariants are graded by `2^degree`); I confirm the identity by measurement and concur.

The vanishing test the brief demands: rebuilding W_0 from the padded CP² definition and evaluating the *built* F_5 gives **exactly 0** ([conventions.py](../scripts/reviewers/r184/conventions.py)).

**NEW (c), a defect inside [run_n5_extremiser.py](../scripts/runs/run_n5_extremiser.py) that this exposed.** Its closing membership test builds the Sym²(Λ²) coordinate vector as

```python
vec[k] = S[a][b] * (1 if a == b else 2)
```

but `wm.sym2_to_R` sends the basis element (a,b), a ≠ b, to the tensor with `R10_{ab} = R10_{ba} = 1`. The undoubled coordinate is therefore the operator entry, and the doubled vector represents **2S − diag(S)**, not S. So the line printed as "W_0 satisfies first Bianchi and Ric = 0 exactly: True" is a true statement about a different tensor.

Three things pin this down:

- With the doubling, the flat/Λ² norm ratio measures **10**; without it, **4**, the standard `R_ijkl R_ijkl = 4‖A‖²_F`. Only the undoubled reading is consistent with the rest of the record.
- [run_n5_inner_product.py](../scripts/runs/run_n5_inner_product.py) feeds `BASIS` coordinates to `sym2_to_R` with no doubling, so the pipeline's operative convention is the undoubled one and the extremiser is the outlier.
- The undoubled vector **also** satisfies Bianchi and Ric = 0, so `W_0 ∈ Weyl_5` is true. The doubled one passes because `diag(S)` is itself a diagonal Weyl tensor (every `Ric_ii = Σ_{m≠i} d_im` vanishes on it) so both vectors happen to lie in the same nullspace.

The conclusion stands; the check does not. In reviewer 181's terms it is a validation that could not have failed the way it was meant to, and the same coordinate slip in a script that computed anything downstream would propagate.

**Verdict: the brief's suspicion is refuted for F_5; a real convention defect surfaced next door.**

## Claim 3, invariance, proved rather than sampled

Three random pairs per generator is not adequate as a proof. For a nonzero bilinear form on Q³⁵ sampled at entries in {−3,…,3}, the Schwartz–Zippel bound gives a false pass with probability ≤ 13/49 per pair, so ≤ (13/49)³ ≈ **1.9 % per generator**, small, but it is a probability where the condition is linear and an identity is free.

[invariance.py](../scripts/reviewers/r184/invariance.py) settles it: for all **10 generators**, all **1225 entries** of `Aᵀ G + G A` are exactly zero. Invariance holds outright. The Gram is symmetric and its exact Cholesky pivots are all in {8, 9, 12, 16}, strictly positive, so positive definite, confirmed independently of the record's LDLᵀ verifier.

On the normalisation: **G_tensor = 4 · G_operator entrywise**, a single ratio across every one of the 1225 entries, with no entry where one vanishes and the other does not. So `‖W_0‖²` reads 4 under this Gram against 1 in the extremiser. Reviewer 183 found the same and the script's closing "two routes, one number" has since been corrected in the tree; I confirm the factor exactly and add that it is uniform on the whole Gram, not merely on the diagonal.

**Verdict: gap real, now closed; the form is the right one up to the factor 4, which must be fixed on both sides of the SDP.**

## Claim 4, 14, from a third route

[dim_invariants.sage](../scripts/reviewers/r184/dim_invariants.sage) takes Weyl_5 to be the B₂ irrep V_(2,2) (dimension 35 by the Weyl formula, which is the record's own `dimB2`) and reads the multiplicity of the trivial in `Sym^k` by plethysm in Sage's `WeylCharacterRing`:

| k | 1 | 2 | 3 | 4 | 5 | 6 |
| --- | --- | --- | --- | --- | --- | --- |
| dim Symᵏ | 35 | 630 | 7770 | 73815 | 575757 | 3838380 |
| invariants | **0** | **1** | **1** | **4** | **5** | **14** |

Rungs that could have failed: k = 1 must give 0 (no linear invariant), k = 2 must give exactly 1 (`‖W‖²` alone), and k = 3 must give **1**, the Lovelock collapse at n ≤ 5 that makes θ = 3 tr(W³) the only cubic invariant, and the reason the record can identify them. The k = 3 answer is independently corroborated inside the record itself: the multiplicity of λ = (0,0) in the Sym³ decomposition is 1, from both the h.w. search and Sage. **k = 6 gives 14.**

This is a third route to 14, and its assumptions are complementary to reviewer 183's. 183 builds the character from `Sym²(Λ²) = Weyl ⊕ Sym²₀ ⊕ R ⊕ Λ⁴` and never assumes irreducibility, but does not reprove that decomposition. Mine assumes only that Weyl_5 is irreducible with highest weight (2,2), and needs no decomposition. They agree on all six columns. Combined with claim 2's exact rank of 14 over Q, `14 ≤ rank_Q ≤ dim = 14`.

**Verdict: confirmed.**

## What should change in the record

1. **Add the h.w.-independence check to [run_n5_copies.py](../scripts/runs/run_n5_copies.py)**, or state the isotypic argument in its docstring. Per-block dimensions and a 7770 total do not by themselves give a direct sum, and the dictionary needs one.
2. **Fix `vec[k] = S[a][b] * (1 if a == b else 2)`** in [run_n5_extremiser.py](../scripts/runs/run_n5_extremiser.py). Drop the doubling; the check then tests W_0 rather than 2S − diag(S).
3. **Replace the 30 skewness samples** in [run_n5_inner_product.py](../scripts/runs/run_n5_inner_product.py) with `Aᵀ G + G A = 0`. Ten exact 35×35 identities, seconds to run.
4. **Carry the rational coordinates of F_5** and retire the mod-p solve, which is now redundant.
5. **Correct the docstring of [run_n5_sextic_basis.py](../scripts/runs/run_n5_sextic_basis.py)**: it credits reviewer 179's max-intermediate-rank-4 family, but `col()` calls `eval_diagram` with no `maxsize`, so the search runs over *all* matchings. Harmless (the uncapped family is a superset and is lossless at every n) but the losslessness caveat it inherits is not the caveat the code needs.

## Reviewer's own caveats

- Claim 4's Sage route presupposes Weyl_5 ≅ V_(2,2) as a B₂ module. It is corroborated by dimension (35) and by every block of the Sym³ decomposition matching the record's independent h.w. search, but it is an assumption, and 183's route is the one that avoids it.
- The exact coordinates in claim 2 are *the* coordinates because the 14 diagrams are a basis; the 12 held-out points test the solve, not the uniqueness.
- For n = 5 odd, `O(5) = SO(5) × {±I}` and `−I` acts trivially on a rank-4 tensor, so the SO(5) counts above are the O(5) counts. This does not transfer to even n without a separate argument.
- I did not audit `run_n5_highest_weight.py`'s construction of the h.w. vectors themselves. What I verified is that they are independent per λ and that their per-λ counts match Sage's multiplicities, which, with `generated == want` on all 41, is what claim 5 needs.
