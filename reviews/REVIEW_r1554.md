# Review r1554: L141 (a) as a half-contraction at every base point (commit f61d4e2b) and r1553's gaps repaired (commit 267b2d6c)

**Standfirst.** [L141Contract.lean](../lean/HamiltonsCubic/Results/L141Contract.lean) builds, audits 2/2 on the standard three and carries no `sorry`, `admit` or `native_decide`. [L140Statement.lean](../lean/HamiltonsCubic/Results/L140Statement.lean) audits 7/7 and [L116Sharp.lean](../lean/HamiltonsCubic/Results/L116Sharp.lean) 13/13. `dkMult` is the correct Daleckii–Krein multiplier of f(x) = ½(|x| − x) at any spectrum, the kernel block carries the record's one-sided value, and `half_contraction` is L141 (a) in a consistent Frobenius norm, conditional on the derivative's shape. `g1_sq_le_quarter_general` is the original proof with the normalisation removed, and `g1_sq_le_quarter` is unchanged. r1553's four gaps are closed and the S³ × S³ weight is right. The gaps are in the prose around the new theorem: the L141 row still carries the struck constant 2.464 as owed and omits part (b), L141Statement.lean's header still calls part (a) untyped, and three smaller residues.

| # | claim | verdict |
| --- | --- | --- |
| A-1a | `dkMult` is the Daleckii–Krein multiplier of f at any spectrum, repeated and single-zero pairs included | **CONFIRMED** |
| A-1b | the kernel block {λ = 0}² with Z = ½(\|D\| − D) is the record's one-sided value | **CONFIRMED** |
| A-1c | `half_contraction` states part (a) with the shape as hypotheses `hE`, `hKK`, an import the record names | **CONFIRMED WITH GAP** (the record asserts the shape inside L141 (a)'s own proof, the named import is L140's at the competitor) |
| A-1d | ‖Alt Z‖² ≤ ¼‖H‖² in `fn2` is the record's ‖·‖ ≤ ½‖·‖ in a consistent norm | **CONFIRMED** (Alt enters abstractly, see gap 4) |
| A-2 | `g1_sq_le_quarter_general` is the original proof at any norm, `g1_sq_le_quarter` states the same as before | **CONFIRMED** |
| A-3 | the L141, L141 (statement) and L140 (statement) rows are accurate and the L141 owed list complete | **GAP** at the reviewed commits (struck constant 2.464 listed as owed, part (b) absent), mostly closed by 5f8f7bc6 |
| A-4 | r1553 gaps 1–4 closed, `degenerate_S3S3`'s weight is S³ × S³'s Weyl tensor up to scale | **CONFIRMED** (one header line not updated, observation) |
| B | build, axiom audits, no `sorry`/`admit`/`native_decide` | **CONFIRMED** |
| C | no downstream text still calls L141 (a) untyped in Lean | **GAP** ([L141Statement.lean:66–74](../lean/HamiltonsCubic/Results/L141Statement.lean#L66)) |
| D | style of the markdown edits | **CONFIRMED WITH GAP** (one semicolon splice) |

**Summary:** the theorem is sound and faithful, r1553 is fully repaired, and the defects are a stale owed list carrying a withdrawn constant, one stale file header, and three minor residues.

## 1. Fidelity of L141Contract.lean (A-1)

- **The multiplier.** `dkMult lam i j` is −1 when λᵢ = λⱼ < 0, 0 when λᵢ = λⱼ ≥ 0, and `divDiff λᵢ λⱼ` = (f(λᵢ) − f(λⱼ))/(λᵢ − λⱼ) otherwise ([L141Contract.lean:31](../lean/HamiltonsCubic/Results/L141Contract.lean#L31), [L141Statement.lean:115](../lean/HamiltonsCubic/Results/L141Statement.lean#L115)). At a repeated nonzero eigenvalue f is linear nearby, so f′ = −1 on negatives and 0 on positives, which is what the first branch returns. At a pair with exactly one zero eigenvalue the values are distinct, and divDiff(0, λ) = f(λ)/λ is −1 for λ < 0 and 0 for λ > 0, the correct one-sided mixed entry. The value at λᵢ = λⱼ = 0 is never read, since `hE` excludes the kernel block. `dkMult_mem` follows from `divDiff_mem_Icc` and is correct.
- **The kernel block.** For t > 0 the compression of V + tH to the spectral subspace near 0 is tH_KK + O(t²), and f is positively homogeneous, so the first-order term on that block is f(H_KK) = ½(|D| − D) with D = H_KK. That is the record's "the exact value is D₋" at [second-order.md:1821](../findings/second-order.md#L1821). `hKK` carries it with `absD` on K × K, and `hAs`, `hsq` ask only that `absD` be a symmetric square root of D², which is weaker than |D| and so a strengthening. Only ‖absD‖ = ‖D‖ on the block is used, through `frob_eq_of_sq_eq`.
- **The import label (gap 3).** [L141Contract.lean:20–21](../lean/HamiltonsCubic/Results/L141Contract.lean#L20) says the shape is one "which the record imports". The import the record names is L140's identification of Z at the competitor, from L135 (c) ([route-a.md:309](../findings/route-a.md#L309)). L141 (a) at an arbitrary base point asserts the shape inside its own proof with no citation, and at a degenerate V the classical Daleckii–Krein theorem does not apply, f failing C¹ at 0, which the record itself notes at [route-a.md:87](../findings/route-a.md#L87). So the shape at a general base point is the block's own uncited step, including the mixed (kernel, nonkernel) entries. The INDEX row lists it as owed, which is the honest status. The file header should say "the block asserts" rather than "the record imports".
- **The norms.** `fn2` is the Frobenius sum of squares on N × N matrices, N = dim Λ², in an orthonormal eigenbasis of V. The record's norm on 𝒲ₙ ⊂ S²(Λ²) is a fixed multiple of that Frobenius norm and `Alt` projects inside S²(Λ²) ([lean/INDEX.md:29](../lean/INDEX.md#L29)), so both sides scale together and ‖Alt Z‖² ≤ ¼‖H‖² is ‖D(Alt W₋)_V[H]‖ ≤ ½‖H‖ with D(Alt W₋) = Alt ∘ DW₋ by linearity. An orthogonal change of basis preserves idempotence and self-adjointness for `fip`, so the hypotheses `hidem` and `hsa` are what the record's "Alt is an orthogonal projection" means in eigen-coordinates.
- **Gap 4 (minor).** `Alt` in `half_contraction` is any idempotent `fip`-self-adjoint linear map, and `haltH` stands for Bianchi on H. [AltPart.lean](../lean/HamiltonsCubic/Base/AltPart.lean) proves both properties of the concrete Alt, but no step conjugates it into V's eigenbasis and instantiates the theorem there. The row does not name that instantiation as owed.

## 2. L140Statement.lean (A-2)

- [g1_sq_le_quarter_general](../lean/HamiltonsCubic/Results/L140Statement.lean#L129) keeps the original proof body with `hnorm` removed from the binders and the closing `rw [hnorm] at hfinal; linarith` replaced by `exact hfinal`. The file builds with `hnorm` out of scope, so no intermediate step used it, and the conclusion `fn2 (Alt Z) ≤ (1/4) * fn2 H` is exactly the `hfinal` the old proof reached.
- [g1_sq_le_quarter](../lean/HamiltonsCubic/Results/L140Statement.lean#L212) has the same binders, the same conclusion `fn2 (Alt Z) ≤ 1 / 4` and the same docstring as before, now proved by the general form at ‖H‖² = 1.

## 3. The rows (A-3)

- **L140 (statement)** ([lean/INDEX.md](../lean/INDEX.md)): the appended sentence, that `g1_sq_le_quarter_general` states the estimate at any norm, is accurate.
- **L141 (statement)** ([lean/INDEX.md:522](../lean/INDEX.md#L522)): accurate in content. Style gap in section 7.
- **L141** ([lean/INDEX.md:521](../lean/INDEX.md#L521)), **gap 1**: the row still opens with c_n = 2.464 θ₀(n)/(n − 2) and closes with "Owed: ... and the constant 2.464". The record's part (b) constant is c_n = 3θ₀(n)/(n − 2), sharp and attained on the within-factor pair block ([second-order.md:1825](../findings/second-order.md#L1825)), and the 2.464 figure is the output of the crossing argument the record strikes at [second-order.md:1833](../findings/second-order.md#L1833). [L141Statement.lean:165](../lean/HamiltonsCubic/Results/L141Statement.lean#L165) already types `cn n = 3 * theta0 n / (n - 2)`. So the owed list names a withdrawn constant and omits what part (b) actually owes, which L141Statement.lean's own header lists at lines 75–86: Hess(P|_S), κₙ, Q's additivity over L120's blocks, L133's support table, the attainment clause and the domain T_{W*}S ∩ T_{W*}𝒪^⊥. The same struck constant sits in [L141.lean:16](../lean/HamiltonsCubic/Results/L141.lean#L16) and `c_decays` at [L141.lean:50–53](../lean/HamiltonsCubic/Results/L141.lean#L50), and in [findings/INDEX-results.md:157](../findings/INDEX-results.md#L157). These predate f61d4e2b, but the commit rewrote the row's owed list and carried the constant forward.
- **Gap 1 after the reviewed commits.** Commit 5f8f7bc6, which landed during this review, removes 2.464 from the L141 row, from L141.lean (`c_decays` now reads c = 3 · 2/(n − 2), building with 6/6 clean on the standard three) and from findings/INDEX-results.md row 141, and replaces the owed constant by "part (b) at the operator (Hess(P|_S), κₙ, L120's blocks)". That closes gap 1 except for a residue: the owed list still omits L133's support table, the attainment clause and the domain T_{W*}S ∩ T_{W*}𝒪^⊥, all of which L141Statement.lean's header names as untyped.
- The row's change from "statement: not typed" to "statement: typed" is defensible, part (a) now being typed as an implication and part (b)'s arithmetic being typed in L141Statement.lean.

## 4. r1553's gaps (A-4)

- **Gap 1 closed.** [L116Statement.lean:39–46](../lean/HamiltonsCubic/Results/L116Statement.lean#L39) now points at L116Sharp.lean's `sharp_not_bianchi` and `degenerate_diag` for both items.
- **Gap 2 closed.** [degenerate_S3S3](../lean/HamiltonsCubic/Results/L116Sharp.lean#L137) types the S³ × S³ instance on `Fin 6`. The weight is right: unit spheres give sectional curvature 1 within a factor and 0 across, Ric = 2g, scal = 12, and an Einstein metric has W = R − scal/(n(n − 1)) · Id on Λ², so w = 1 − 2/5 = 3/5 within and −2/5 across. The row sums to 2 · 3/5 − 3 · 2/5 = 0, so it is trace-free. In L116Statement's convention `diagT w i j i j = w_ij` ([L116Sharp.lean:77](../lean/HamiltonsCubic/Results/L116Sharp.lean#L77)), the eigenvalue on eᵢ ∧ eⱼ, so this is the Weyl operator itself, and "up to scale" covers any other normalisation. The theorem holds for every symmetric hollow w, so the numbers identify the instance rather than carry the proof. Rcp's W_{ℂP²} shape and Ricci-flatness are now named untyped in the row, which is the other half of the gap. *Observation*: the file header at [L116Sharp.lean:15–17](../lean/HamiltonsCubic/Results/L116Sharp.lean#L15) still says "S³ × S³ among it" without naming `degenerate_S3S3` (gap 6).
- **Gap 3 closed.** The L116 row names Rcp's identification with CP2Sharp's W_{ℂP²} and its Ricci-flatness as the untyped step that would witness the refuted inference.
- **Gap 4 closed.** The unused `(try rw [hw]; ring)`, the no-op `ring`s and the unused `if_true` are gone. The build now prints `linter.flexible` warnings at [L116Sharp.lean:88](../lean/HamiltonsCubic/Results/L116Sharp.lean#L88) and [:96](../lean/HamiltonsCubic/Results/L116Sharp.lean#L96), a different linter from the three r1553 named, flagging `simp_all` and `simp` followed by further tactics. Observation only.

## 5. Soundness (B)

- `lake build HamiltonsCubic.Results.L141Contract HamiltonsCubic.Results.L116Sharp HamiltonsCubic.Results.L140Statement`: success, 8712 jobs.
- `axiom_audit.py --only L141Contract.lean`: 2/2 clean. `--only L140Statement.lean`: 7/7 clean. `--only L116Sharp.lean`: 13/13 clean. All rest on propext, Classical.choice and Quot.sound alone.
- No `sorry`, `admit` or `native_decide` in the three files. The one hit is the prose "There is no `sorry`." at L140Statement.lean:55.

## 6. Downstream (C)

- **Gap 2**: [L141Statement.lean:66–74](../lean/HamiltonsCubic/Results/L141Statement.lean#L66), under "What is NOT typed here", still says part (a) is not typed, that `Alt` and `W₋` "are not nameable in the record's Lean layer", and that "the passage from a multiplier bound to an operator-norm bound ... and the use of Alt(H) = 0 ... and of Alt being an orthogonal projection, are not" typed. L141Contract.lean's `half_contraction` now types exactly that passage, and AltPart.lean carries `Alt` and W₋ ([lean/INDEX.md:29](../lean/INDEX.md#L29)). The header names neither.
- [lean/INDEX.md:29](../lean/INDEX.md#L29) lists L141 among the files that name the absence of Alt, which is true of L141Statement.lean's stale header and will become false once gap 2 is repaired.
- [findings/INDEX-results.md:157](../findings/INDEX-results.md#L157) reads "Lean: partial" with a pointer to lean/INDEX.md, consistent with the row. It carries the struck 2.464 (gap 1). [findings/second-order.md](../findings/second-order.md) and [findings/route-a.md](../findings/route-a.md) carry no Lean status for L141 (a).

## 7. Style (D)

- The edited rows are single lines with no em dash and no backticks inside link text.
- **Gap 5 (minor)**: [lean/INDEX.md:522](../lean/INDEX.md#L522), new in f61d4e2b, splices two clauses with a semicolon: "Part (a)'s estimate is typed in L141Contract.lean with the derivative's Daleckii–Krein shape as hypotheses; the derivative ... itself needs the Daleckii–Krein calculus". The semicolon in the L140 statement row predates both commits.

## Verdict

**CONFIRMED WITH GAPS.** `half_contraction` is sound and faithful to L141 (a) with the derivative's shape as hypotheses, `g1_sq_le_quarter_general` is the original proof at any norm, and r1553's gaps are closed. Gaps:

1. [lean/INDEX.md:521](../lean/INDEX.md#L521): the L141 row lists "the constant 2.464" as owed, a figure the record strikes at [second-order.md:1833](../findings/second-order.md#L1833) in favour of c_n = 3θ₀/(n − 2), which [L141Statement.lean:165](../lean/HamiltonsCubic/Results/L141Statement.lean#L165) already types. Part (b)'s real owed content is absent from the list. The same constant stood in L141.lean:16 and :50–53 and in findings/INDEX-results.md:157. **Closed by 5f8f7bc6** except that the new owed list omits L133's support table, the attainment clause and the domain (section 3).
2. [L141Statement.lean:66–74](../lean/HamiltonsCubic/Results/L141Statement.lean#L66): the header still calls part (a) and the multiplier-to-operator passage untyped and Alt unnameable.
3. [L141Contract.lean:20–21](../lean/HamiltonsCubic/Results/L141Contract.lean#L20): "which the record imports" misattributes the shape. At a general base point the block asserts it in its own proof, the named import being L140's at the competitor. Minor.
4. [lean/INDEX.md:521](../lean/INDEX.md#L521): the abstract `Alt` of `half_contraction` is not instantiated at AltPart's Alt in V's eigenbasis, and the owed list does not say so. Minor.
5. [lean/INDEX.md:522](../lean/INDEX.md#L522): a semicolon clause splice. Minor.
6. [L116Sharp.lean:15–17](../lean/HamiltonsCubic/Results/L116Sharp.lean#L15): the header does not name `degenerate_S3S3`. Minor.
