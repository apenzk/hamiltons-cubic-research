# REVIEW_r1047: `face_hands_down` from Birkhoff (commit `f83e3c8e`)

**Scope**: commit `f83e3c8e` on [I106bFace.lean](../lean/HamiltonsCubic/Results/I106bFace.lean) and [lean/INDEX.md](../lean/INDEX.md), sole reviewer. **The mathematics and the Lean are sound. Two of the commit's claims ABOUT the record are not.**

| # | claim | verdict |
|---|---|---|
| 1 | `hadamardSelf_mem_doublyStochastic` is correct in Mathlib's sense | **CONFIRMED** |
| 2 | `value_le_perm` is correct and is the Birkhoff bound | **CONFIRMED** |
| 3 | `face_hands_down` is proved, kernel-clean, and the SAME statement | **CONFIRMED** |
| 4 | `hzero` is genuinely unused | **CONFIRMED**, by deletion |
| 5 | the file carries no `sorry` | **CONFIRMED**, with two false leftover sentences about one |
| 6 | this does not close R28's rung | conclusion **CONFIRMED**, the committed justification **REFUTED** |
| 7 | both halves were already on the record | **REFUTED as written**: the JOIN was on the record too, from 2026-09-17 |

## What was run

One elaboration of a copy of the committed file, `lake env lean` on a scratch file at the `lean/` top level, 35 seconds, with four probe declarations appended and `#print axioms` on every new theorem. The file was copied, never edited, and the copy is deleted. **No sweep, no census, no search**: every run was seconds on objects already in hand, which is what the analysis-only rule permits without asking, and nothing here rests on a numerical result.

## Claim 1, CONFIRMED

`mem_doublyStochastic` in [DoublyStochasticMatrix.lean](../lean/.lake/packages/mathlib/Mathlib/Analysis/Convex/DoublyStochasticMatrix.lean#L52) is `(∀ i j, 0 ≤ M i j) ∧ M *ᵥ 1 = 1 ∧ 1 ᵥ* M = 1`, so the three obligations are entrywise nonnegativity, row sums and column sums, and that is what the proof discharges: `mul_self_nonneg` for the entries, the diagonal of `Q * Qᵀ = 1` for the rows, the diagonal of `Qᵀ * Q = 1` (obtained by `mul_eq_one_comm`) for the columns. **Both orthogonality identities are genuinely needed and both are used.** Kernel-clean on `[propext, Classical.choice, Quot.sound]`.

## Claim 2, CONFIRMED

- [ConvexOn.exists_ge_of_mem_convexHull](../lean/.lake/packages/mathlib/Mathlib/Analysis/Convex/Jensen.lean#L377) is Mathlib's maximum principle, `∃ y ∈ t, f x ≤ f y`, and it is applied with `t` the permutation matrices and `x = Q ⊙ Q` placed in their hull by Birkhoff. That is the Birkhoff bound itself.
- **The `ConvexOn` instance is real, not a trivially true goal.** The anonymous constructor is checked against `ConvexOn ℝ Set.univ (fun M => (Aᵀ * M).trace)`, whose second field is the inequality with `x, y ∈ univ` and `p + q = 1` introduced. `le_of_eq rfl` closes it because `simp only` has normalised both sides to the same term, linearity of `M ↦ (Aᵀ * M).trace` being an equality rather than an inequality. The term typechecks, so the instance holds at the stated function.
- **`s.permMatrix ℝ` on the right is not a weakening.** It is the permutation matrix rather than its Hadamard square, and `permMatrix_hadamard_self` identifies the two, which is the rewrite `face_hands_down` performs.
- **At `k = 0` and `k = 1` the statement is non-vacuous and trivial.** Both hypotheses are satisfiable there (checked: `(1 : Matrix (Fin 0) (Fin 0) ℝ)` and the `Fin 1` identity), and at `k = 0` both values are `0`, at `k = 1` orthogonality forces `Q = ±1` so `Q ⊙ Q` IS the permutation matrix. The content starts at `k = 2`. This costs the argument nothing, since `face_hands_down` carries `2 ≤ k`.

## Claim 3, CONFIRMED

The diff has three hunks and none of them touches `value`, `Splits`, `IsSignedPerm` or `splits_of_isSignedPerm`. Binder for binder, the theorem before and after `f83e3c8e` differs in the single character of `hzero` becoming `_hzero`: `(hk : 2 ≤ k)`, `(A)`, `(Q)`, `(hQ : Q * Qᵀ = 1)`, the zero-diagonal binder, `(hmax)`, and the conclusion `∃ P, P * Pᵀ = 1 ∧ Splits P ∧ value A (P ⊙ P) = value A (Q ⊙ Q)` are otherwise identical.

**Two further checks, because a proof can be right about the wrong statement through the definitions rather than the binders.**

1. A restatement written out by hand, with `value` replaced by `(Aᵀ * ·).trace` and `Splits` by its existential over `R` and `C`, is discharged by `face_hands_down hk A Q hQ hz hmax` directly. So neither definition was quietly changed under the theorem.
2. The hypotheses are jointly satisfiable at `k = 2`: the swap permutation matrix is orthogonal, has zero diagonal, and is maximal for `A = 0`. The theorem is not vacuous at the smallest size it admits.

`#print axioms face_hands_down` gives `[propext, Classical.choice, Quot.sound]`, and the same for `hadamardSelf_mem_doublyStochastic`, `permMatrix_hadamard_self`, `isSignedPerm_permMatrix` and `value_le_perm`. **All five are kernel-clean.**

## Claim 4, CONFIRMED by deletion

The binder was removed entirely, not renamed, and the committed proof was pasted underneath unchanged. `face_hands_down_no_hzero` elaborates and prints the standard three axioms. **The zero-diagonal hypothesis is idle, exactly as the commit says.**

## Claim 5, CONFIRMED, with a leftover

The file elaborates with exit status `0` and no `declaration uses 'sorry'` warning. The string `sorry` survives at three places in the file and all three are prose.

**Two of those three are now false and should be fixed**:

- [line 37](../lean/HamiltonsCubic/Results/I106bFace.lean#L37), the module docstring: "`face_hands_down` carries a named `sorry` and is the item's open content."
- [line 356](../lean/HamiltonsCubic/Results/I106bFace.lean#L356), the theorem's own docstring: "**Named `sorry`.** The proof is the item's remaining work and nothing in the record may cite this." **That sentence forbids citing a theorem the same file now proves**, which is the most costly of the leftovers: a reader who obeys it will re-derive what is available. The docstring's header, "THE OPEN CONTENT of I106b, stated before it is derived", is stale for the same reason.

## Claim 6, the conclusion CONFIRMED and the committed reasoning REFUTED

**The conclusion is right**: Birkhoff on a single `Q` does not reach R28's rung.

**The justification committed to [plan.md](../plan.md) does not establish it.** The sentence is that the joint image of `P ↦ ((EᵀP)^∘2, (FᵀP)^∘2)` "is a proper subset of the product of two Birkhoff polytopes, so the extreme points of its convex hull are not pairs of permutations and a linear functional's maximum need not sit at one".

- **The arithmetic is right.** `dim O(k) = k(k−1)/2`, `dim B_k = (k−1)²`, the product has dimension `2(k−1)²`, and the image has dimension at most `k(k−1)/2`, with equality whenever the fibres are finite, which they are for invertible `E` and `F`. The gap is strict at every `k ≥ 2`.
- **The inference from it is invalid, and the record contains its own counterexample.** The convex hull of a low-dimensional set can be full-dimensional and can have exactly the ambient polytope's vertices. That is the single-`Q` case: `X_k` has dimension `k(k−1)/2 < (k−1)²` for every `k ≥ 3` and is a proper subset of `B_k`, yet [r976](REVIEW_r976.md) and [r977](REVIEW_r977.md) both proved `conv(X_k) = B_k`, whose extreme points ARE the permutation matrices. **Applied at `k = 3` to the single-`Q` case, the committed argument would contradict a result the record already holds.**
- **The valid ground is unrealizability, and the parent has it elsewhere.** Post F72 in [fence-posts.md](../findings/fence-posts.md), staged but outside this commit, gives it: both components are permutation matrices only when `G = EᵀF` is itself a signed permutation, so for a generic coupling the joint image contains NO pair of permutations and the maximum cannot sit at one. Second ground, already on the record from 2026-09-17: [LEDGER.md](../findings/LEDGER.md#L95) records a non-vertex frame beating every vertex frame by `0.0144`, `0.3885` and `0.7896` at `E ≠ F`.
- **One overreach in the same sentence.** "The extreme points of its convex hull are not pairs of permutations" is absolute where the record supports "need not be". Whichever permutation pairs the image does contain remain extreme points of the hull, being extreme in the larger product.

**Correction to make**: replace plan.md's dimension-and-properness clause with F72's realizability clause, which is a proof rather than a heuristic.

## Claim 7, REFUTED as written

The claim in the commit message and in [lean/INDEX.md](../lean/INDEX.md) is "both halves were already on the record and nobody joined them". **The first clause is true and the second is false.**

The join was made on 2026-09-17 by both Gate 2 readers, and recorded in three places:

- [r976](REVIEW_r976.md#L26): "Every `Q^∘2` is doubly stochastic, so `X_n ⊆ B_n`. Every permutation matrix is orthostochastic ... Birkhoff gives `B_n = conv(Π_n)`". Its line 167 goes further: "`face_hands_down`'s named `sorry` is dischargeable in principle, the mathematical content being Birkhoff plus the observation that a linear functional and its convex hull share a maximum", and it names [doublyStochastic_eq_convexHull_permMatrix](../lean/.lake/packages/mathlib/Mathlib/Analysis/Convex/Birkhoff.lean#L166), the very lemma this commit uses, together with the two one-line facts the formalisation would still need.
- [r977](REVIEW_r977.md#L20): "The convex hull of the orthostochastic set is the whole Birkhoff polytope, so the maximum of `⟨R, A⟩` over `X_k` is attained at a permutation matrix. Three lines." Its line 123 names the witness and the `Splits` sets, and the `2 ≤ k` binder in the statement as committed exists because r977 found the `k = 0` falsity.
- [LEDGER.md](../findings/LEDGER.md#L95) and the R28 row of [routes.md](../routes.md) both carry the joined statement.

**What is new in `f83e3c8e` is the Lean formalisation of a consequence the record had drawn four days earlier, and that is worth having.** The framing "nobody joined them" credits the commit with the observation rather than the proof, and it removes the attribution to r976 and r977. **Correction**: say that the record drew this on 2026-09-17 (r976, r977) and that this commit types it.

## Overreach sweep on the INDEX row

Each sentence the commit added, against what the declarations support.

| sentence | verdict |
|---|---|
| "`face_hands_down` IS PROVED, 2026-09-21, AND IT FOLLOWS FROM BIRKHOFF-VON NEUMANN RATHER THAN FROM THE FACE" | supported |
| "`value A ·` is linear and `Q ⊙ Q` is doubly stochastic at an orthogonal `Q`, so the maximum sits at a permutation matrix, which is orthogonal and `Splits`" | supported, with one imprecision: `Splits` holds for a permutation matrix only at `2 ≤ k`, which `splits_of_isSignedPerm` requires |
| "`hzero` IS NEVER USED ... irrelevant to the statement" | supported, and reproduced here by deleting the binder |
| "Both halves were already on the record and nobody joined them" | **REFUTED**, see claim 7 |
| the four names "are the four steps, all on the standard three axioms" | supported, `#print axioms` on each |
| "Mathlib supplies `doublyStochastic_eq_convexHull_permMatrix` and `ConvexOn.exists_ge_of_mem_convexHull`" | supported |
| "WHAT IT DOES NOT CLOSE ... the rung is untouched, and so is the criticality work beside it" | supported, the criticality declarations being about critical points |
| "The statement was the commuting-case simplification ... now closed as such" | supported by the R28 row and the file's own scope note |
| retained: "the file now carries ONE `sorry`, `face_hands_down`" | **FALSE after this commit, and it contradicts the row's own status cell**, which now reads "proved, no `sorry`" |

## Corrections, in the order they cost the record

1. **[lean/INDEX.md](../lean/INDEX.md), I106b row**: delete "and the file now carries ONE `sorry`, `face_hands_down`", which the same row now contradicts.
2. **[lean/INDEX.md](../lean/INDEX.md) and the commit's framing**: replace "nobody joined them" with the attribution to [r976](REVIEW_r976.md) and [r977](REVIEW_r977.md), 2026-09-17, and say the new work is the formalisation.
3. **[plan.md](../plan.md), I106b**: replace the properness-and-dimension inference with F72's realizability argument, since the committed one would refute the single-`Q` case if it were valid.
4. **[I106bFace.lean](../lean/HamiltonsCubic/Results/I106bFace.lean) lines 37 and 356**: the module docstring and the theorem docstring still announce a named `sorry` and forbid citing the theorem.

## What I did not find

No weakened hypothesis, no strengthened conclusion, no `sorryAx`, no `native_decide`, no defect in the four new declarations or in the Mathlib lemmas they lean on. **The Lean half of this commit is exactly what it says it is.**
