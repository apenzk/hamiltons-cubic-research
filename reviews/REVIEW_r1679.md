# REVIEW r1679: L52's two remarks (b1c89c3d) and the repair of r1678's gaps (d1970136)

**Verdict: CONFIRMED WITH GAPS.** The six declarations of [L52Remarks.lean](../lean/HamiltonsCubic/Results/L52Remarks.lean) are correct, faithful to the block ([bispectral.md:84](../findings/bispectral.md#L84), [:94](../findings/bispectral.md#L94)) and 6/6 on the standard three, and L52.lean is 11/11. r1678 G1, G2 and G4 are repaired by owing them, which r1678 allowed. G3 is repaired in L52.lean's header and left standing in the row's opening, and the new `threshold_nonempty` docstring reads the penalty threshold as the record's neighbourhood sentence, which concerns a different bound in a different variable. The one-line bound `θ ≤ (3/2)(M₊ + m)`, a hypothesis of `one_line_half`, is neither declared nor owed. **partial** is right.

## Claims

| # | Claim | Verdict |
|---|---|---|
| 1 | `rot4` is `|U|²` for the `π/4` rotation in the degenerate eigenplane of `μ = (1, 1, 2)`, entries `½` | **CONFIRMED WITH GAPS** (G1): true by hand, `U` undeclared |
| 2 | `rot4_ds`, `rot4_rowtight`, `rot4_not_perm` render "a `π/4` rotation inside a degenerate eigenplane is row-tight and is no permutation" | **CONFIRMED** |
| 3 | `ratio_le`, `display_needs_small_C` formalise "the display can return `θ ≤ Θ_n` at some `t_F < 2` only if `C ≤ Θ_n/3`" | **CONFIRMED WITH GAPS** (G2): the change of variables and the range of `t_F` are undeclared, and owed only as "the second display itself" |
| 4 | `one_line_half`: "then the one-line bound gives `θ ≤ Θ_n/2`" | **CONFIRMED WITH GAPS** (G3): the one-line bound is a hypothesis, undeclared and not owed |
| 5 | r1678 G1, G2, G4 repaired | **CONFIRMED** (owed, with accurate descriptions) |
| 6 | r1678 G3 repaired, L52.lean's header accurate | **CONFIRMED WITH GAPS** (G4, G5) |
| 7 | The L52 row is consistent, the owed list complete, **partial** right | **CONFIRMED WITH GAPS** (G3, G4) on the list and opening, **CONFIRMED** on the state |
| 8 | Axiom audit | **CONFIRMED**: L52Remarks 6/6, L52 11/11 on the standard three |

## 1. The `π/4` example

- In the eigenbasis of `μ = (1, 1, 2)` the eigenplane of `1` is `span(e₀, e₁)`. The rotation by `π/4` there is `U = [[c, −s, 0], [s, c, 0], [0, 0, 1]]` with `c = s = 1/√2`, and `|U|²` is `[[½, ½, 0], [½, ½, 0], [0, 0, 1]]`, which is `rot4` at [L52Remarks.lean:28](../lean/HamiltonsCubic/Results/L52Remarks.lean#L28). Checked entrywise by hand.
- Row-tightness: rows 0 and 1 are supported on columns `{0, 1}`, where `μ = 1`, and row 2 on column 2. Jensen is an identity on a row whose support carries one value of `μ`, for every `g`, which is `rot4_rowtight`. The record needs tightness for a strictly convex `g` only, so the Lean statement is stronger than required and still true.
- `rot4_not_perm` shows `P` has the entry `½`, so `P` is no permutation matrix and `U` is no signed permutation, the record's "`U` itself need not be a permutation".
- `K = Pμ = (1, 1, 2)`, a rearrangement of `μ`, as `eq_rearrangement` predicts. The example is consistent with the counting argument.
- **G1.** The docstring at [:27](../lean/HamiltonsCubic/Results/L52Remarks.lean#L27) calls `rot4` "the `π/4` rotation's squared entries", and no `U` is declared, so the passage from a rotation to `P` rests on the docstring. `cos²(π/4) = sin²(π/4) = ½` closes it in a few lines. The `μ` used is not a unit trace-free spectrum, which the block's abstract "only if" sentence does not ask for.

## 2. The second display's arithmetic

- **The change of variables.** The display is `θ ≤ (t_F/2)^{3/2} Θ_n + (9/2) C (1 − t_F/2)`. With `u = √(t_F/2)` and `t_F ∈ [0, 2]`, `u² = t_F/2` and `(t_F/2)^{3/2} = u³`, so the display is `θ ≤ u³ Θ + (9/2) C (1 − u²)`, the hypothesis `h` at [:72](../lean/HamiltonsCubic/Results/L52Remarks.lean#L72). `t_F < 2` is `u < 1`. Correct.
- **The derivation.** `u³ Θ + (9/2) C (1 − u²) ≤ Θ` is `(9/2) C (1 − u²) ≤ Θ (1 − u³)`. Dividing by `1 − u > 0` gives `(9/2) C (1 + u) ≤ Θ (1 + u + u²) ≤ (3/2) Θ (1 + u)` by `ratio_le` and `Θ ≥ 0`, and dividing by `1 + u > 0` gives `C ≤ Θ/3`. This is the Lean proof step for step.
- **Sharpness.** At `u = 0` the conclusion is `C ≤ 2Θ/9`, and as `u → 1` the constraint tends to `C ≤ Θ/3`, so `Θ/3` is the sharp constant over `[0, 1)`. The record's constant is the right one.
- **The hypotheses.** `u ∈ [0, 1)` is `t_F ∈ [0, 2)`. `Θ ≥ 0` holds for the record's `Θ_n > 0` and is used. `C ≥ 0` is unused (the binder is `_hC`) and harmless. The reading "the display returns `θ ≤ Θ_n`" as "its right-hand side is at most `Θ_n`" is the only reading under which the record's sentence is a statement about the display.
- `one_line_half` is `linarith` from `θ ≤ (3/2) C` and `C ≤ Θ/3`, the record's closing step.
- **G2.** The change of variables and `t_F ∈ [0, 2]` are undeclared. The owed entry "the second display itself" covers the display and does not name either.
- **G3.** The one-line bound `θ ≤ (3/2)(M₊ + m)` ([bispectral.md:86](../findings/bispectral.md#L86), "immediate from `μᵢ ≤ M₊` and `ωᵢ ≥ −m`" at [:63](../findings/bispectral.md#L63)) enters `one_line_half` as the hypothesis `hθ`. No L52 file declares it (grepped `one_line` and `(3 / 2) * (M` across `lean/HamiltonsCubic`: only `one_line_half` itself), and the owed list does not name it. It is used by three of the row's claims: `one_line_half`, the neighbourhood sentence, and `strictly_loose`'s reading.

## 3. r1678's gaps

- **G1 (composition at `whst`)**: owed, with the right description (`ψ₀` entry `−¼ΣK = 0`, `omega_lower_iff` at general `w`, `sum_diag_split` and `L52_record_S20` fixed at `wK`). Repaired.
- **G2 (the staircase sentence at every `n`)**: owed, with the triangular induction named and `n = 4` as the only declared case. Repaired.
- **G4 (the neighbourhood sentence)**: owed with its strictness at `Mpair` and its continuity step. The third part, exactness, is `L52_if_psi` and is declared. Repaired.
- **G3 (stale text)**: partly repaired.
  - L52.lean's header ([L52.lean:10-14](../lean/HamiltonsCubic/Results/L52.lean#L10)) is accurate. It no longer calls the headline refuted, says the figures come from an earlier form of the block, and names what `strictly_loose` needs and what is undeclared. `3.674235` survives in bispectral.md at [:53](../findings/bispectral.md#L53), outside the L52 block, and the cap at [:273](../findings/bispectral.md#L273), in another block, so "an earlier form of the block" is the right description.
  - **G4.** The row's opening at [lean/INDEX.md:384](../lean/INDEX.md#L384) is unchanged. It still says "what makes the heading deny what the same file uses", quotes *"Strictly loose at every unit Weyl tensor"* with "where the block argues it informally", and says "confirming *'its negative is not independent'*". The block's heading is now "the shared-frame majorization bound, and what its equality clause needs", which denies nothing, and none of the three quoted phrases appears in bispectral.md (grepped `strictly loose`, `negative is not independent`, `informally`: no hits). r1678 G3's fix named "the row's opening".
  - **G5.** The new `threshold_nonempty` docstring ([L52.lean:98-101](../lean/HamiltonsCubic/Results/L52.lean#L98)) calls `4/3 < 2` "the record's 'beats the strict one-line bound on a neighbourhood of the diagonal family' read at the penalty". The arithmetic is true: `(9/2) C (1 − t/2) > (3/2) C` exactly for `t < 4/3`. The identification is wrong on two counts. The record's sentence at [bispectral.md:86](../findings/bispectral.md#L86) is about the first display, the majorization bound, and `4/3` is about the penalty of the second display. The second display adds `(t_F/2)^{3/2} Θ_n`, so "the penalty does not lose" on `(4/3, 2]` says nothing about the display. And the record's neighbourhood is a set of Weyl tensors, while `(4/3, 2]` is an interval of `t_F`.

## 4. The row as a whole

- The declaration counts match: L52.lean has 11 theorems, L52Remarks 6, and the audits return 11/11 and 6/6.
- Owed entries checked against the block, [bispectral.md:69-102](../findings/bispectral.md#L69): the padded `W_CP²` figures, the second display, the Verification paragraph, the `whst` composition, the staircase at every `n`, the neighbourhood sentence and r1677 G7 are all present and accurate. Missing: the one-line bound (G3), and the change of variables with the range of `t_F` (G2).
- **partial** is right: the owed list is non-empty and carries claims the block asserts.

## 5. Axiom audit

`python3 scripts/misc/axiom_audit.py --only L52Remarks.lean`: 6/6 clean on the standard three. `--only L52.lean`: 11/11 clean. No `sorry`, no `native_decide`.

## Gaps

- **G1 (minor), [L52Remarks.lean:27-28](../lean/HamiltonsCubic/Results/L52Remarks.lean#L27).** `rot4` is asserted to be `|U|²` for the `π/4` rotation, with no `U` declared. Fix: declare `U` with `Real.cos (π/4)` and `Real.sin (π/4)`, and prove `rot4 i j = U i j ^ 2` and `Uᵀ U = 1`, or owe it.
- **G2 (minor), [L52Remarks.lean:71-72](../lean/HamiltonsCubic/Results/L52Remarks.lean#L71), [lean/INDEX.md:384](../lean/INDEX.md#L384).** The passage from `t_F` to `u` (`u = √(t_F/2)`, `(t_F/2)^{3/2} = u³`, `t_F ∈ [0, 2]`) is undeclared and not owed by name. Fix: a lemma in `Real.rpow`, or an owed entry.
- **G3, [L52Remarks.lean:82](../lean/HamiltonsCubic/Results/L52Remarks.lean#L82), [bispectral.md:86](../findings/bispectral.md#L86), [lean/INDEX.md:384](../lean/INDEX.md#L384).** The one-line bound `θ ≤ (3/2)(M₊ + m)` is `one_line_half`'s hypothesis and appears nowhere in the owed list. Fix: declare it at `Mpair` and `ringW` from `μᵢ ≤ M₊`, `ωᵢ ≥ −m`, `Σμ² = 1`, `Σω² = 3`, or owe it.
- **G4, [lean/INDEX.md:384](../lean/INDEX.md#L384).** The row's opening quotes a heading and three phrases the block no longer prints (r1678 G3, unrepaired in the row). Fix: re-anchor the opening as L52.lean's header was, saying the figures come from an earlier form of the block.
- **G5, [L52.lean:98-101](../lean/HamiltonsCubic/Results/L52.lean#L98).** `threshold_nonempty`'s docstring equates the penalty's `t_F > 4/3` with the record's neighbourhood sentence, which is about the first display and a neighbourhood in `Weyl_n`. Fix: say the penalty alone stays below the one-line bound on `(4/3, 2]`, and drop the identification.

## What would break each claim, and what was done

| Claim | Breaking object | What was done |
|---|---|---|
| 1 | An entry of `|U|²` other than `½`, `0`, `1` at the stated places | Squared the rotation entrywise by hand |
| 2 | A row of `rot4` whose support carries two values of `μ` | Read each row's support against `μ = (1, 1, 2)` |
| 3 | `(u, Θ, C)` with `u ∈ [0, 1)`, `Θ ≥ 0`, display `≤ Θ` and `C > Θ/3` | Rederived by hand, checked `u = 0` and `u → 1`, the second showing `Θ/3` sharp |
| 4 | A declaration of the one-line bound elsewhere, which would dissolve G3 | Grepped `lean/HamiltonsCubic` for `one_line` and `(3 / 2) * (M` |
| 5, 6 | A quoted phrase still present in the block | Grepped bispectral.md for the row's three quotations and the header's figures |
| 7 | A block assertion neither declared nor owed | Read bispectral.md:69-102 sentence by sentence against the row |
| 8 | A non-standard axiom | Ran the axiom audit on both files, a screen of seconds |
