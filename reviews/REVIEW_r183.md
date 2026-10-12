# Gate 2 review 183, the flat/Λ² grading, the invariance proof, and the rational placement

All arithmetic below is exact over **Q** (Python `Fraction`) or exact over **Z**; the one place a prime appears is in reproducing the record's own diagram selection, and the solve that matters is redone over Q without it. Scripts: [scripts/reviewers/r183/](../scripts/reviewers/r183/).

| Claim | Verdict |
| --- | --- |
| 1. F_5 carries a factor error and its placement proves nothing | **Refuted, with proof.** The two conventions differ by a *uniform* 64; the built F_5 vanishes at W_0 exactly |
| 2. The mod-p placement does not establish a rational one | **Refuted, with the rational coordinates.** Solved over Q at exact integer points; all 14 coordinates are in (1/4)Z |
| 3. Invariance rests on 30 random tests | **Upheld as a gap, and closed.** Invariance now proved outright, and the form is unique up to scale, but the script's closing cross-check is false: the two norms differ by 4 |
| 4. The Weyl-integration 14 is unchecked at n=5 | **Confirmed independently.** 14, from a character built without the Weyl character formula, with a validation that separates n=5 from n=6 |
| 5. The copies script has not been rerun | **Rerun. All 41 copies match the Weyl dimension formula.** |

---

## Claim 1, the suspected factor error is a grading, and it cancels

[run_n5_sextic_basis.py](../scripts/runs/run_n5_sextic_basis.py) computes both `q` and `trM3` from the **flat 25×25 reshape** `M_{(ab),(cd)} = W_abcd` over all *ordered* index pairs, while [run_n5_extremiser.py](../scripts/runs/run_n5_extremiser.py) and the rest of the record use the **Λ² operator** `A_{(ij),(kl)} = W_ijkl` on the 10 unordered pairs. They are different matrices, so the brief's suspicion was well aimed. They are not, however, unrelated.

**Proposition.** For every k ≥ 2, `tr(M^k) = 2^k tr(A^k)`.

*Proof.* `tr(M^k)` sums `W_{a₁b₁a₂b₂} ⋯ W_{a_k b_k a₁b₁}` over all ordered pairs. A term with `a_i = b_i` vanishes by antisymmetry in the first two slots. Swapping `a_i ↔ b_i` flips the sign of exactly the two factors carrying that pair, so the summand is unchanged; each of the k unordered pairs is therefore counted exactly twice. ∎

**Corollary.** Every degree-d invariant that is a product of traces of words in A, of total word length d, is multiplied by exactly `2^d` on passing from A to M. In particular `q = |W|²_flat = 2² tr(A²)` and `trM3 = 2³ tr(A³)`, so

> F_5 as built = (3/2)·(4 tr A²)³ − 9·(8 tr A³)² = 64 · [ (3/2) tr(A²)³ − 9 tr(A³)² ] = 64 · F_5 as the record means it,

identically as polynomials. The scalar is uniform and positive, so membership in the invariant span, the vanishing locus, and sum-of-squares status are all unaffected.

This is worth stating as the grading, rather than as a coincidence of `4³ = 8²`: the flat and Λ² conventions agree up to `2^degree` on the *whole subalgebra of operator-trace invariants*, so no degree-6 combination of such traces can be spoiled by the mix-up. Verified for k = 2 … 6 at three exact points of Weyl_5 in [claim1_grading.py](../scripts/reviewers/r183/claim1_grading.py), and the F_5 identity at six exact points in [claim1_claim3.py](../scripts/reviewers/r183/claim1_claim3.py).

### The vanishing at W_0

W_0 was rebuilt from its definition (the CP² Weyl tensor padded to R⁵) as a rank-4 tensor over Q, working with `S = √6 W_0` to keep everything rational, and checked to satisfy first Bianchi and Ric = 0 exactly. Then, exactly:

| | value at `√6 W_0` |
| --- | --- |
| `tr(A²)` | 6, so `‖W_0‖²_Λ² = 1` |
| `tr(A³)` | 6, so `tr(W_0³) = 1/√6` |
| `q` (flat) | 24 = 4·6 |
| `trM3` (flat) | 48 = 8·6 |
| **F_5 as built** | **0** |
| **F_5 as the record means it** | **0** |

`(3/2)·24³ − 9·48² = 20736 − 20736`. The built polynomial does vanish at the extremiser, which is what θ = √(3/2) at n = 5 requires. **Claim 1 is refuted.**

*What the episode does leave standing:* the record now runs two live normalisations of ‖W‖² that differ by a factor of 4, and nothing in the pipeline announces which one a given script speaks. See claim 3.

## Claim 2, the placement is valid over Q, and here are the coordinates

The theoretical argument the brief sketches is airtight, and it is worth writing out because it is what makes the numerics unnecessary:

1. The diagram functionals `D_1 … D_14` have **integer** coefficients. If some rational relation `Σ q_i D_i = 0` held, clear denominators to integers of gcd 1 and reduce mod p: not every coefficient is divisible by p, so the evaluation vectors would satisfy a nontrivial F_p-relation, contradicting the mod-p rank of 14. Independence mod p therefore *implies* independence over Q.
2. The degree-6 invariant space is cut out of a rational vector space by rational linear equations, so its Q-dimension equals its C-dimension, which is 14 (claim 4, independently). Fourteen Q-independent invariants in a 14-dimensional Q-space are a Q-basis.
3. `F_5 = (3/2)‖W‖⁶ − 9 tr(W³)²` is a degree-6 O(5)-invariant with rational coefficients, manifestly, both `‖W‖²` and `tr(W³)` are complete contractions. So F_5 lies in the Q-span, with unique rational coordinates.

Independently of that argument, [claim2_rational.py](../scripts/reviewers/r183/claim2_rational.py) reproduces the record's own 14 matchings from its seeds, evaluates them in **exact integer arithmetic** at 20 exact integer points of Weyl_5 (all four symmetries re-verified over Z at each point), and solves the 20×14 system over Q with `Fraction`. The system has rank 14, is consistent, and reproduces F_5 at all 20 points. Coordinates of the record's F_5 in its own basis:

> −39, −3/4, −3, −3, 51/2, −27, −21/2, −6, −27, −3, −6, −9, 3, 9

(the built F_5 has these times 64, all integers: −2496, −48, −192, −192, 1632, −1728, −672, −384, −1728, −192, −384, −576, 192, 576). **Claim 2 is refuted; the placement is rational and explicit.**

## Claim 3, invariance, proved; and a false cross-check

### The proof, in one line

The form is `⟨R,S⟩ = Σ_{ijkl} R_ijkl S_ijkl`, i.e. the restriction to Weyl_5 ⊂ (R⁵)^⊗4 of the standard inner product on the fourth tensor power. Each generator `A_pq = E_pq − E_qp` is skew on R⁵, and it acts on the tensor power by derivation, one slot at a time. Slot by slot, `⟨A·x, y⟩ + ⟨x, A·y⟩` contributes `⟨A_pq u, v⟩ + ⟨u, A_pq v⟩ = 0`. Summing the four slots gives skewness. Invariance needs no sampling at all.

### The complete check, replacing the 30 tests

The record's 30 random pairs are replaced by the exact matrix identity `Aᵀ G + G A = 0`, all 35×35 entries, for **all 10 generators**, over Q. It holds. Two further exact results:

- **Uniqueness.** Solving `Aᵀ X + X A = 0` over all generators for symmetric X gives a solution space of dimension **1** out of 630. The invariant symmetric form on Weyl_5 is unique up to scale, so *any* correctly-built invariant form is a positive multiple of this one, and there is nothing to choose.
- **Positive definiteness** is then automatic on the compact-group side, and the record's LDLᵀ verdict is consistent with it.

### The factor, and the sentence that is not true

The brief asks how the rank-4 tensor norm compares with the Λ² operator norm. Entrywise, over Q:

> **G_tensor = 4 · G_operator**, exactly, for all 35×35 entries.

This is the k = 2 case of the proposition above. Both are invariant (checked separately), as they must be by uniqueness. But [run_n5_inner_product.py](../scripts/runs/run_n5_inner_product.py) closes with

> *"cross-check: the record has |W_0|^2 = 1 from the Lambda^2 spectrum, computed there without this form. Two routes, one number."*

**It is not one number.** Under the Gram that script has just built, `‖W_0‖² = 4`, not 1, and the script never applies its Gram to W_0, so it prints agreement it did not compute. The line should be deleted or corrected to state the factor. This is the same normalisation split as claim 1, and it is the live hazard in the pipeline: if `⟨W³, u_i⟩` is later formed with this tensor Gram while F_5 is carried in the operator normalisation, powers of 4 will enter the SDP silently. **The gap the claim names is real; the conclusion the script drew is correct; one of its printed cross-checks is false.**

## Claim 4, 14, from a different character

[run_n5_constraint_count.py](../scripts/runs/run_n5_constraint_count.py) gets the character of Weyl_5 from the **Weyl character formula for B₂ at λ = (2,2)**, which presupposes that Weyl_5 is that irreducible. [claim4_weyl_integration.py](../scripts/reviewers/r183/claim4_weyl_integration.py) instead builds the character from the decomposition that defines the module,

> `char(Weyl_n) = h₂(Λ²V) − h₂(V) − Λ⁴V`,

the character form of `Sym²(Λ²) = Weyl ⊕ Sym²₀ ⊕ R ⊕ Λ⁴`, and then applies Weyl integration with `Sym^k` characters from the power sums. It never assumes irreducibility or a highest weight, and it works in any rank.

| n | dim Weyl_n | deg 1 | deg 2 | deg 3 | deg 4 | deg 5 | deg 6 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 5 (B₂) | 35 | 0 | 1 | **1** | 4 | 5 | **14** |
| 6 (D₃) | 84 | 0 | 1 | **2** | 6 | | |

The degree-3 column is a validation that **could have failed**, in the sense reviewer 181 demanded: it returns 1 at n = 5 and 2 at n = 6, so it sees the Lovelock collapse that makes θ = 3 tr(W³) the single cubic invariant at n ≤ 5, a genuinely n-dependent quantity, in two different Lie types, from one code path. The degree-6 answer at n = 5 is **14**, matching the record. Together with claim 2's step 1, this upgrades the mod-p rank of 14 from a lower bound to an equality: 14 ≤ rank_Q ≤ dim = 14.

## Claim 5, the copies script, rerun

`python3 scripts/runs/run_n5_copies.py`, from a clean start after reviewer 182's fix. Result below.

**All 41 copies were built and all 41 matched**, `generated == want` on every line, no early stop (the `want > 900` guard never fired, the largest block is λ = (6,4) at 810). 146 s, pure `Fraction` arithmetic, negligible memory.

One check the script does not make, and which closes the claim properly: the generated dimensions **sum to 7770**, and `dim Sym³(Weyl_5) = C(37,3) = 7770`. So the 41 copies are not merely each of the right size, together they exhaust `Sym³(Weyl_5)` with nothing left over and nothing double-counted. That is the statement the dictionary actually needs, and it now holds.

| λ | copies × dim | λ | copies × dim |
| --- | --- | --- | --- |
| (0,0) | 1 × 1 | (4,0) | 2 × 55 |
| (1,0) | 1 × 5 | (3,1) | 2 × 81 |
| (2,0) | 2 × 14 | (3,3) | 1 × 84 |
| (2,1) | 2 × 35 | (5,0) | 1 × 91 |
| (2,2) | 4 × 35 | (3,2) | 3 × 105 |
| (3,0) | 2 × 30 | (6,0) | 1 × 140 |
| (4,1) | 2 × 154 | (4,4) | 2 × 165 |
| (4,2) | 4 × 220 | (4,3) | 2 × 231 |
| (5,1) | 1 × 260 | (5,2) | 2 × 390 |
| (5,4) | 1 × 429 | (5,3) | 1 × 455 |
| (6,6) | 1 × 455 | (6,2) | 1 × 625 |
| (6,3) | 1 × 770 | (6,4) | 1 × 810 |

## What should change in the record

1. **Delete or correct the false cross-check** at the end of [run_n5_inner_product.py](../scripts/runs/run_n5_inner_product.py). Its Gram gives `‖W_0‖² = 4`; the extremiser's Λ² route gives 1; the two routes give *two* numbers, related by the factor 4 that script never states.
2. **Name the normalisation in every script that carries a norm.** The pipeline now runs `‖W‖²_flat = 4‖W‖²_Λ²` side by side. The 64 in F_5 is harmless *because* of the `2^degree` grading, not by luck, and the next object formed across the two conventions (`⟨W³, u_i⟩` against the tensor Gram, with F_5 in the operator normalisation), will not be.
3. **Replace the 30 random skewness tests** with `Aᵀ G + G A = 0`. It is ten 35×35 exact matrix identities and runs in seconds; sampling was never necessary for a linear condition.
4. **Record the rational coordinates of F_5** (claim 2 above) in place of the mod-p ones. The mod-p solve is now redundant.
5. **Record the 7770 total** in [run_n5_copies.py](../scripts/runs/run_n5_copies.py), per-block agreement without it leaves open that the copy list is incomplete.

## Reviewer's own caveats

- Claim 4's count uses `Sym²(Λ²) = Weyl ⊕ Sym²₀ ⊕ R ⊕ Λ⁴` as an O(n)-decomposition, which the script asserts only through the consequence that every multiplicity in the resulting character is positive and the dimension is 35 (n = 5) and 84 (n = 6). It does not reprove that decomposition.
- Claim 2 checks consistency at 20 exact points; that the coordinates are *the* coordinates rests on step 3 of the argument (F_5 lies in the span a priori), not on the sampling.
- For n odd, `O(n) = SO(n) × {±I}` and `−I` acts trivially on a rank-4 tensor, so the SO(5) count is the O(5) count. At n = 6 that identification is by a separate argument; the n = 6 row is used only as a validation, not as a claim of the record.
