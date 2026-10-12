# REVIEW r1151: the Lean for the L237 cap reduction and the class-trace test

*Gate 2 reviewer r1151, 2026-09-25, brief [2026-09-25-L237cap-classtrace-gate2-brief.md](2026-09-25-L237cap-classtrace-gate2-brief.md), files as committed at 3f6ec723: [L237Cap.lean](../lean/HamiltonsCubic/Results/L237Cap.lean) and [ClassTraceTest.lean](../lean/HamiltonsCubic/Results/ClassTraceTest.lean). Every comparison below is by hand. The only computation was the build and the axiom audit.*

## Summary

| item | verdict |
|---|---|
| 1a. `exists_c_topSum` | CONFIRMED, both branches |
| 1b. `rowSum_le_of_slotSets` | CONFIRMED (the extra `0 < r` is harmless) |
| 1c. `bracket_cap` | REFUTED as a statement of its claim, correction A: the existential forgets that `N` is a normal form of `x`, and the conclusion as typed holds for an `N` built from a norm bound alone |
| 1d. `Rows`, `sixteenD_identity`, `D_neg_of_kappa`, `D_neg_iff`, `witness_rows` | CONFIRMED, all nine rows match r1149 item 2 term by term |
| 2. INDEX rows and the "Typed:" line | L237 row and the working file's line CONFIRMED, and the L244 row REFUTED in one phrase (correction B) |
| 3. build and axioms | CONFIRMED: both modules build (exit 0, one long-line lint warning at L237Cap.lean line 96), 3/3 and 4/4 declarations on the standard three axioms, no `sorry`, no `native_decide` |

## Item 1

### 1a. exists_c_topSum

- The statement is the claim verbatim: hypothesis over every `S` with `S.card ≤ r`, `0 < r`, conclusion `∃ c, r c + ∑ₖ max(μₖ - c, 0) ≤ B`. No weakening.
- Case `card K ≤ r`: `c = 0`, and `∑ max(μₖ, 0)` is the sum over the positive set, whose card is at most `card K ≤ r`, so the hypothesis applies. Correct.
- Case `card K > r`: `S` a maximiser of the sum over `r`-sets, `c = min_S μ`. The exchange argument shows every `k ∉ S` has `μₖ ≤ c` (else swapping the minimiser for `k` beats the maximum), so `∑ max(μ - c, 0) = ∑_S (μ - c)` and the left side is `∑_S μ ≤ B`. Correct. `0 < r` is used for `S` nonempty, which the minimum needs.

### 1b. rowSum_le_of_slotSets

- Matches the claim: `N` a normal form, `O` orthogonal on both sides, `X = O N.X Oᵀ`, the bound on every slot set of card at most `r`, `y` orthonormal skew, conclusion `∑ⱼ ⟨yⱼ, -ad_X² yⱼ⟩ ≤ B`. It composes 1a with `kyFan_conj`, whose statement I read.
- `0 < r` is an extra hypothesis. At `r = 0` the claim is `0 ≤ B`, which the empty set in the hypothesis already gives, so nothing of substance is lost.

### 1c. bracket_cap, correction A

- The claim: the bound holds "over the slot eigenvalues of some normal form **of x**". The declaration concludes `∃ k (N : NormalForm ι k), ∀ r ψ c, …`, and `NormalForm` is only index maps `p, q` and weights `s`. Nothing in the conclusion ties `N.X` to `x`. The same shape is inherited from `kyFan_skew` in [L240NormalForm.lean](../lean/HamiltonsCubic/Results/L240NormalForm.lean), which discards the `O` that `skew_normal_form` supplies.
- **The typed conclusion is satisfiable without the normal form of x.** For `card ι = n ≥ 3` take `k = 1`, one block `(p, q)`, weight `S`. Its slot eigenvalues are `S²` on the `2(n - 2)` slots meeting exactly one of `p, q` and `0` elsewhere. For any `c` and the top-`r` set `T` (`r ≤ n(n-1)/2` whenever `r` orthonormal skew `ψ` exist), `r c + ∑ max(μ - c, 0) ≥ ∑_T (c + max(μ - c, 0)) ≥ ∑_T μ ≥ min(r, 2(n - 2)) S²`. The left side is at most `r ‖ad_x‖²_op`, so `S² ≥ (n(n-1)/2) ‖ad_x‖²_op` makes the conclusion hold for every `r, ψ, c`. So the declaration is true with a witness that knows only a norm bound on `x`, and it cannot be combined with the owed half of L237 ("any six slots of a unit normal form sum to at most 8"), which needs `N` to be the normal form of `x`.
- The proof is sound: the witness actually used is the normal form of `x`. The defect is in the statement.
- **Correction A**: add the conjugacy to the conclusion, `∃ (k : ℕ) (N : NormalForm ι k) (O : Matrix ι ι ℝ), O * Oᵀ = 1 ∧ Oᵀ * O = 1 ∧ x = O * N.X * Oᵀ ∧ ∀ …`, obtained from `skew_normal_form` and `kyFan_conj` directly (the same change to `kyFan_skew` fixes both). No consumer of `bracket_cap` or `kyFan_skew` exists in the layer yet, so nothing downstream moves.

### 1d. ClassTraceTest

- `Rows` against [r1149](REVIEW_r1149.md) item 2, with `d = (p, m, p)`:
  - (A)₀, (A)₁, (A)₂: `t000+2t001+2t002+t011+2t012+t022 = (n-2)p`, `t001+2t011+2t012+t111+2t112+t122 = (n-2)m`, `t002+2t012+2t022+t112+2t122+t222 = (n-2)p`. These are `∑_{a,b} t_{cab}` over ordered pairs with total symmetry, each off-diagonal pair counted twice. Match.
  - (B)₀, (B)₁, (B)₂: right sides `p, 0, -p`, left sides `t_{c22} - t_{c00} + t_{c12} - t_{c01}`. Match, and I re-derived the telescoping `a ∑_a (t_{ca2} - t_{ca0})` and the right side `-λ_c d_c / a`.
  - (C)₀, (C)₁, (C)₂: `t000-2t002+t022 = -(κ+1)p`, `t001-2t012+t122 = 0`, `t002-2t022+t222 = (κ-1)p`. Match: `λ₀(θ-λ₀)p/a² = -(κ+1)p` and `λ₂(θ-λ₂)p/a² = (κ-1)p` with `κ = θ/a`.
- `sixteenD_identity` states r1149's correction B with `D = (t222 - t002 + p)/2` and `κ` for `θ√(2p)`. It uses (A)₀, (A)₂, (B)₁, (B)₂, (C)₀, (C)₁, (C)₂, closed by `linarith`, which the build checks.
- `D_neg_of_kappa`: hypotheses `0 < p`, `n - 5 < κ`, and nonnegativity of exactly the three traces in the identity. That is the claim, strict inequality as in the working file's "κ > n - 5". No missing hypothesis.
- `D_neg_iff`: from (B)₂ and (C)₁, `t001 - t012 = 2D`, so the equivalence holds. Matches.
- `witness_rows`: the tuple is r1149's witness (`t000 = (n-κ-5)p/4`, `t002 = (n+κ-1)p/4`, `t022 = (n-κ-1)p/4`, `t111 = (n-2)m`, `t222 = (n+κ-5)p/4`, the rest `0`), and `D = 0` there. It proves the rows only, which is what the brief claims. The nonnegativity of that point on `κ ≤ n - 5` stays in prose (r1149), and the Lean does not claim it.
- `κ`, `n`, `p`, `m` are free reals and the rows are hypotheses, as the file's docstring says. No vacuity: `witness_rows` shows `Rows` is satisfiable at every parameter value.

## Item 2

- **L237 row** of [lean/INDEX.md](../lean/INDEX.md): claims `exists_c_topSum` and `rowSum_le_of_slotSets` as described, "at every skew X conjugate to the normal form", and lists the six-slot bound as remaining. Nothing beyond the declarations. CONFIRMED.
- **Working file's "Typed:" line** in [the working file](2026-09-25-I73c-per-vector-rows.md): names the four ClassTraceTest declarations, which carry the identity, the forced sign, the E₀ form and the explicit point on the rows. CONFIRMED.
- **L244 row, correction B**: "over the slot eigenvalues of x's normal form" claims the link that correction A adds. Until `bracket_cap` carries the conjugacy, the row should read "over the slot eigenvalues of some normal form (the conjugacy to x owed in the statement)", or the statement should be strengthened and the row kept.

## Item 3

- `lake build HamiltonsCubic.Results.L237Cap HamiltonsCubic.Results.ClassTraceTest` from `lean/`: exit 0, "Build completed successfully (8738 jobs)". One style warning, line 96 of L237Cap.lean over 100 characters.
- `python3 scripts/misc/axiom_audit.py --only L237Cap`: 3/3 clean, standard three axioms. `--only ClassTraceTest`: 4/4 clean, standard three axioms.
- No `sorry`, `native_decide` or `axiom` in either file. Both files complete.
