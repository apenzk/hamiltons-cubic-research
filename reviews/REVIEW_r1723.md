# REVIEW r1723: the r1721 repair to L52StairAll

**Standfirst.** Cold Gate 2 repair review of commit 2546d8e9 to [L52StairAll.lean](../lean/HamiltonsCubic/Results/L52StairAll.lean) and the L52 row of [lean/INDEX.md](../lean/INDEX.md), against [REVIEW_r1721.md](REVIEW_r1721.md) gaps G1 to G3 and [findings/bispectral.md](../findings/bispectral.md) line 503. Analysis only: Lean source and definitions read, no `lake build`. One screen, seconds of exact rational arithmetic in plain Python at n = 4 on `Wst` (reported as a screen, not as evidence). Heartbeats in [agent_logs/review-r1723.log](../agent_logs/review-r1723.log).

| # | Claim | Verdict |
|---|---|---|
| Q1 | `Kmat_diagOp`: `Kmat (diagOp w) a b = w a b` for w symmetric and hollow, at every n, and `Kmat` is the record's K = (W_abab) with the sign and normalisation of `Kmat_Rst` | CONFIRMED |
| Q2 | `no_unit_stair_K` says the record's sentence at coordinate-diagonal W | CONFIRMED |
| Q3a | G1: the header scopes the unit-norm contradiction to coordinate-diagonal W | CONFIRMED (one residual quotation, Section 3) |
| Q3b | G3: `entry_eq`'s docstring states the j < i case it proves | CONFIRMED |
| Q3c | The INDEX row's L52StairAll sentences claim only what the file types | CONFIRMED |

**One line.** All three r1721 gaps are closed. `Kmat_diagOp` is correct and needs exactly its symmetry hypothesis. The INDEX row now says "coordinate-diagonal" where r1721 asked for it.

## 1. Kmat_diagOp (Q1)

- Definitions read. `Kmat R a b = R4 R a b a b` ([L54Basis.lean:35](../lean/HamiltonsCubic/Results/L54Basis.lean#L35)), `R4 R i j k l = inner2 (R (phi i j)) (phi k l)` ([L209FoxClosure.lean:42](../lean/HamiltonsCubic/Results/L209FoxClosure.lean#L42)), `inner2 X Y = ½ tr(XᵀY)`, `phi i j = E_ji − E_ij` ([WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean)), `diagOp w X = (w_ab X_ab)` ([Families.lean:147](../lean/HamiltonsCubic/Base/Families.lean#L147)).
- Derivation. `diagOp_phi` (symmetry only) gives `diagOp w (phi a b) = w_ab • phi a b`, and `inner2_phi_phi` at (a, b, a, b) is 1 − [a = b]. So K_ab = w_ab for a ≠ b, and at a = b both sides are 0 by hollowness. The proof follows exactly this route and is `Kmat_Rst`'s proof with `Wt` replaced by a general w.
- Sign and normalisation. inner2(φ_ab, φ_ab) = 1 for a ≠ b, so the φ_ab are unit and K_ab = W_abab carries the positive sign, matching `Kmat_Rst` (`Kmat Rst a b = Wt a b`). At Fin 4, `Kmat_diagOp` specialises to `Kmat_Rst`.
- Falsifier looked for: a w for which K ≠ w. Without symmetry, direct computation gives K_ab = (w_ab + w_ba)/2, so a non-symmetric w falsifies the conclusion and `hsym` is necessary, which the statement carries. Hollowness enters only at a = b. No falsifier within the hypotheses.
- **Screen** (n = 4, w = `Wst`, exact rationals, built from the Lean definitions of phi, inner2, diagOp): K = w entrywise; ‖diagOp Wst‖² over the orthonormal φ_ab basis = 12, so ‖diagOp Wt‖² = 12 · (1/12) = 1, agreeing with `Rst_unit`; Kψ_1 = −2ψ_1, Kψ_2 = (4, 4, −2, −6) and Kψ_3 = (4, 4, −8, 0) are not multiples of ψ_2, ψ_3. So the one unit-norm object in hand escapes `no_unit_stair_K`'s hypothesis, which is what the theorem requires.

## 2. no_unit_stair_K against the record (Q2)

- Statement: w with `IsWeight w` (symmetric, hollow, zero row sums), every `stair k`, k > 0, an eigenvector of `Kmat (diagOp w)`, conclusion `normSq (diagOp w) ≠ 1`. The proof rewrites `Kmat (diagOp w)` to w by `Kmat_diagOp` and calls `no_unit_stair`.
- Record, line 503: the staircase ψ_k "diagonalise K on 𝟏⊥ only when K happens to be diagonal in them", with the witness "the n = 4 coordinate-diagonal tensor". The Lean reading is the strong form the L52 row stated: at coordinate-diagonal W with Ricci-flat weight, the staircase diagonalising K is impossible at unit norm. Eigenvector of K for each ψ_k, k ≥ 1, is "diagonalises K on 𝟏⊥" because K𝟏 = 0 (r1721 Section 1). `normSq` is Σμ² by `sum_mu_sq`.
- Coordinate-diagonal W is `diagOp w` for a symmetric w, and its Ricci-flatness is zero row sums (`diagOp_ric`). The diagonal of w does not act on skew X, so taking w hollow is a choice of representative and loses no case.
- Falsifier looked for: a unit-norm `diagOp w` with IsWeight whose K has all ψ_k as eigenvectors. `stair_forces_zero` excludes it, and the screen object fails the hypothesis at ψ_2. None found.

## 3. The G1 and G3 repairs and the INDEX row (Q3)

- G1. The header adds "*The contradiction with unit norm needs `W` coordinate-diagonal*: at a general Ricci-flat `W` the staircase still forces `K = 0`, and `K = 0` does not force `W = 0`", citing r1721's A ⊕ (−A) witness. This is what r1721 asked. The general-W half is prose backed by `stair_forces_zero` with `K_row_sum` ([L54Basis.lean:134](../lean/HamiltonsCubic/Results/L54Basis.lean#L134)), symmetry and hollowness of `Kmat R` being immediate but not composed into one declaration here. The text says no more than that.
- Residual (presentational, no verdict change). Header lines 12–14 still quote the old owed wording "at a Ricci-flat $W$ … forces $K=0$ …, against $\sum\mu^2=1$" and continue "This file proves it at every `n`". The following parenthetical and the scope paragraph qualify it, but a reader stopping at the quotation meets the wording r1721 refuted as stated. Recommended: insert "[coordinate-diagonal]" into the quotation or reword "proves it" to "proves its coordinate-diagonal form". No other copy of the unscoped wording exists in findings/, lean/INDEX.md, plan-lean.md, plan.md, STATUS.md or results.md (grep for "a staircase diagonalising" and "Ricci-flat $W$ a staircase").
- G3. `entry_eq`'s docstring now leads with "`K_ij = K_i0` for `j < i`", its type, and marks the a_{max(i,j)} reading as a consequence "with symmetry". Repaired.
- INDEX row, L52StairAll sentences: the declarations named (`below_step`, `row_const`, `col0_zero`, `stair_forces_zero`, `no_unit_stair`, `Kmat_diagOp`, `no_unit_stair_K`) exist with the stated content; "no unit-norm coordinate-diagonal $W$ with Ricci-flat weight has its staircase diagonalising $K$" is `no_unit_stair_K`'s type; "at a general Ricci-flat $W$ the staircase still forces $K=0$, which does not force $W=0$" is the scoped prose with its r1721 citation. The row claims nothing untyped as typed.

## Overall verdict

**CONFIRMED.** `Kmat_diagOp` is correct at every n with the record's sign and normalisation, `no_unit_stair_K` states the record's staircase sentence at coordinate-diagonal W, and r1721's G1, G2 and G3 are repaired. One presentational residual: the header's quotation of the old owed sentence (lines 12–14) is still unscoped before the scope paragraph corrects it.
