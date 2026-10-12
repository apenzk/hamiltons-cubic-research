# REVIEW r1777: L219Diag.lean (5278d8d6, a36e563b)

| Claim | Verdict | Reason |
|---|---|---|
| `hasChar_of_sig`, `sig_of_hasChar` | CONFIRMED | `sig k` conjugates by `(flip k)ᵀ` outside and `act` by `flip k`, and `flip_T` identifies the two |
| `diagonal_iff_even` | CONFIRMED | products of flips give every sign matrix (`act_diag_set`) and `trivial_block_iff` identifies the fixed set with `restrict (diagOp w)` |
| `sig_isWeyl2` | CONFIRMED | on skew `X`, `restrict (act (flip k) (extendL V)) X = flip k * V(cS k X) * flip k = sig k V X`, and `act_mem` keeps the extension in `weylModuleS` |
| `even_odd_isWeyl2` | CONFIRMED | closure of `IsWeyl2` under sums and scalars applied to `V` and `sig k V` |
| Record's n−1 redundancy clause | UNTYPED | the Lean quantifies over all `k : Fin n`, and nothing in the layer states that `−I` acts trivially or that `n−1` reflections suffice |
| lean/INDEX.md L219 row | CONFIRMED WITH OBSERVATIONS | matches the code, with a markdown defect and the redundancy clause absent from its Owed list |

**Summary:** the two commits prove what they say with the standard three axioms, and the only gap against the record is the untyped `k = 1,…,n−1` refinement, which is a one-line lemma (a screen compiled it).

## 1. Coordinate-diagonal against `restrict (diagOp w)` and `IsDiagonalOp`

- The record's clause: *W is coordinate-diagonal in an orthonormal frame (e_1,…,e_n) exactly when its σ_{e_k}-odd part vanishes for k = 1,…,n−1, the last reflection being redundant since −I acts trivially.* Proof step 3 reads "coordinate-diagonal" as $W\in\mathcal D_n$, the Γ-fixed subspace, and the proof opens with "$O(n)$ acts on $\mathcal W_n$".
- `diagonal_iff_even` states the right side as `∃ w, IsWeight w ∧ V = restrict (diagOp_isWeyl hw)`, with `FamilyLayer.diagOp w X = w ∘ X` entrywise ([Families.lean:147](../lean/HamiltonsCubic/Base/Families.lean#L147)) and `IsWeight` symmetric, hollow, zero row sums. That is the record's $\mathcal D_n$.
- `IsDiagonalOp` in [L1Statement.lean:76](../lean/HamiltonsCubic/Results/L1Statement.lean#L76) asks every φ_ij to be an eigenvector. On Weyl operators the two agree:
  - `IsDiagonalOp ⇒ diagOp`: `diag_eq` and `wOf_isWeight` in L1Statement.lean give `W X = diagOp (wOf c) X` on skew `X` with `wOf c` a weight.
  - `diagOp ⇒ IsDiagonalOp`: `w ∘ φ_ij = w_ij φ_ij`, since φ_ij is supported on (i,j), (j,i) and `w` is symmetric. By hand, and untyped as a lemma.
- The bridge lives on bare functions `Matrix → Matrix`, while `diagonal_iff_even` lives on `CurvOp2`. No lemma composes them, and none is needed for the clause as the record states it (it names $\mathcal D_n$, not the eigenvector property).
- Verdict: the same notion on $\mathcal W_n$.

## 2. All k against k = 1,…,n−1

- The Lean hypothesis is `∀ k : Fin n`. For the ⇒ direction this is stronger than the record's, so the record's refinement (only n−1 reflections needed) is not what is proved.
- The redundancy is untyped: a grep of L219*.lean, L120*.lean and WeylAction.lean finds no `act (-1)` lemma and no `Fin.last`/`castSucc` restriction.
- Needed? Only for the record's sharper wording. It follows from `act (−1) R = R` for every `R : CurvLin ι` together with `act_diag_set` at `s = univ` (`diagSet univ = −1`). Screen: the lemma `act (-1 : Matrix ι ι ℝ) R = R` closed by `simp [act_apply]` in a scratch file that has since been deleted.
- Observation O1: either type the n−1 form (a few lines on top of `diagonal_iff_even`) or add it to the INDEX row's Owed list. The L219Diag.lean module docstring also paraphrases the record as "for every $k$", which drops the record's range.

## 3. `sig_isWeyl2`

- `act g R Z = g * R (gᵀ Z g) * gᵀ` ([WeylAction.lean:20](../lean/HamiltonsCubic/Results/WeylAction.lean#L20)). `cS k X = (flip k)ᵀ X (flip k)`. `sig k V X = cS k (V (cS k X))`.
- On skew `X`: `act (flip k) (extendL V) X = F * extend V (Fᵀ X F) * Fᵀ = F * V(cS k X) * Fᵀ` by `extend_apply`, and `flip_T` (`Fᵀ = F`, a diagonal matrix) turns this into `Fᵀ * V(cS k X) * F = sig k V X`. The proof does exactly that rewrite.
- `act_mem` needs `Fᵀ F = 1`, supplied by `flip_orth`. `extendL_mem` gives the extension in `weylModuleS`, and `.1` of the membership is `IsWeyl` of the bare function, which `isWeyl2_restrict` turns into `IsWeyl2`.
- Sound.

## 4. Conjugation convention in `hasChar_of_sig`, `sig_of_hasChar`

- `HasChar c S R` is `S * extend R (Sᵀ Z S) * Sᵀ = c • extend R Z`, the action of `S`. `cS` conjugates by `Fᵀ … F`, the action of `F⁻¹ = Fᵀ`. The two differ for a general orthogonal `S` and coincide for `flip k` because it is symmetric.
- Both proofs invoke `flip_T` explicitly at the point where the conventions meet, so neither silently assumes `S = Sᵀ`.
- Right for the coordinate reflection. *A general unit u keeps this property* (a reflection is symmetric), so the convention will not bite when the frame rotation is done.

## 5. Axioms

`#print axioms` via `lake env lean` on a scratch file:

- `diagonal_iff_even`: [propext, Classical.choice, Quot.sound]
- `sig_isWeyl2`: [propext, Classical.choice, Quot.sound]
- `hasChar_of_sig`, `sig_of_hasChar`, `even_odd_isWeyl2`: the same three.

No `sorryAx`, no `Lean.ofReduceBool`.

## 6. lean/INDEX.md "L219 (statement)" row

- Matches the code: `diagonal_iff_even` in the coordinate frame, through `hasChar_of_sig`/`sig_of_hasChar`, `act_diag_set`, `trivial_block_iff`. `sig_isWeyl2` and `even_odd_isWeyl2` via `act_mem`. Standard three axioms. All confirmed.
- O2: the row carries `****The reflection preserves $\mathcal W_n$, PROVED**`, four opening asterisks against two closing, which renders as stray markup. There is also a double space before it.
- O1 again: the Owed list names ⟨b∘b,c⟩, the operator identities, a general u and the 3/4 bound, and omits the n−1 refinement of the diagonality clause.

## 7. Falsifiers

- `hasChar_of_sig`/`sig_of_hasChar`: a skew `Z` and a `V` with `sig k V = V` but `F extend V(FZF) F ≠ extend V Z`. Looked for by reading the matrix identity through with `F = Fᵀ`, `F² = 1`. None exists, and the kernel accepts it.
- `diagonal_iff_even`: a Weyl `V` fixed by every `flip k` but outside `restrict (diagOp w)`, or a weight `w` whose operator is moved by some `flip k`. Looked for by tracing `act_diag_set` (flips generate every sign matrix via `signMat_eq_diag_set`) and the ⇐ specialisation `flip k = signMat (sgn k)` (`rfl`, with `sgn_mul_self`). None.
- Correspondence with the record: an operator the record calls coordinate-diagonal that is not `restrict (diagOp w)`. Looked for through `diag_eq`/`wOf_isWeight` in §1. None on $\mathcal W_n$.
- Redundancy clause: a Weyl `W` fixed by σ_{e_1},…,σ_{e_{n−1}} and moved by σ_{e_n}. Excluded by `act (−1) = id`, screened in Lean (§2). Edge `n ≤ 1`: `Λ²` is zero and both sides hold trivially.
- `sig_isWeyl2`: a Weyl `V` with `sig k V` failing the Bianchi or trace clause. Excluded by `act_mem`, traced in §3.

## Overall verdict

**CONFIRMED WITH OBSERVATIONS.** O1: the record's k = 1,…,n−1 refinement is untyped and unlisted as owed. O2: stray asterisks in the INDEX row.
