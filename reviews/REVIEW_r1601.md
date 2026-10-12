# Review r1601: L126's DF(M) at the sphere product (L126DF), commit a376ab92, the kernel clause (L126Final), commits eabb0055 and 332386a2, and L260's relabel, commit f6075daf

**Standfirst.** [L126DF.lean](../lean/HamiltonsCubic/Results/L126DF.lean) proves that the unit-free sphere weight satisfies w_ab² + (w²)_ab = (n − 1) w_ab off the diagonal, so `t • sphereWeight T` is critical with multiplier t(n − 1), and `split_DF` discharges every hypothesis of `critMap_hasDerivAt` at M = `restrict hW` and the (2,2) Bianchi vector v, so the derivative of F(W) = Q(W) − P(W)W along M + s v, read against every test operator, is 2M∘v − P(M)v, zero exactly at (p,q) = (3,3). [L126Final.lean](../lean/HamiltonsCubic/Results/L126Final.lean) gives v ≠ 0 and the algebraic kernel clause. The identity was checked by hand in all four placements, both modules build, and the audits read 8/8 and 3/3 on the standard three. The gaps are in the text around the theorems: L126Final's header still calls the hypotheses owed, two pointers omit the new files, and "tangent" is used for ⟨M, v⟩ = 0 in `CurvOp2` while v's membership in the Weyl space is left uncomposed.

| # | Claim | Verdict |
| --- | --- | --- |
| A-1 | `sphere_offdiag`: w_ab² + (w²)_ab = (n − 1) w_ab for a ≠ b, unit-free `sphereWeight` | **CONFIRMED** (by hand, within and across) |
| A-2 | the multiplier t(n − 1) is the critical value θ = P(M) at unit norm | **CONFIRMED** (by hand, P(M) = ⟨M, Q(M)⟩ = λ‖M‖², which the Lean statements do not need) |
| A-3 | `split_DF` discharges `critMap_hasDerivAt`'s four hypotheses at the stated M and v | **CONFIRMED** |
| A-4 | v lies in the record's tangent space (Weyl, ⟨M, v⟩ = 0) | **CONFIRMED WITH GAPS** (true by hand, Bianchi in L121Bianchi and Ricci-flatness trivial, but neither is composed and the file says "tangent" for ⟨M, v⟩ = 0 alone) |
| A-5 | the L126 row owes only the general-diagonal clause | **CONFIRMED** |
| A-6 | `split_kernel_iff` described as the algebraic kernel of 2M∘ − P(M) after 332386a2 | **CONFIRMED WITH GAPS** (now accurate as a statement, but L126Final.lean:16-17 still says the hypotheses are owed) |
| A-7 | f6075daf: L260's row reads partial | **CONFIRMED** |
| B | builds succeed, audits 8/8 (L126DF) and 3/3 (L126Final) on propext, Classical.choice, Quot.sound, no `sorry` | **CONFIRMED** |
| C | downstream consistency | **CONFIRMED WITH GAPS** (L126Final.lean:16-17, second-order.md:1704, L126Statement.lean:52-57, lean/INDEX.md:483) |
| D | style | **CONFIRMED** (no em dashes, no backticked link text, no hard wraps in the changed markdown) |

**Summary:** L126's kernel clause at the sphere product is now DF(M)'s kernel in the derivative sense, sound and faithful, r1600's gap 1 is closed. The gaps are one stale "owed" in L126Final, two pointers that omit L126Final and L126DF, and v's Weyl membership left to prose.

## 1. Files and commits

- a376ab92: [L126DF.lean](../lean/HamiltonsCubic/Results/L126DF.lean) new (211 lines), the aggregator import, the L126 row at [lean/INDEX.md:482](../lean/INDEX.md#L482), STATUS.md and plan-lean.md counts (850 to 851 files, correct for one new file, and the partial count 105 to 106 carries f6075daf's relabel, whose own message promised the STATUS block but whose diff touched only lean/INDEX.md and plan-lean.md).
- eabb0055: [L126Final.lean](../lean/HamiltonsCubic/Results/L126Final.lean), `splitVec_phi`, `splitVec_ne_zero`, `split_kernel_iff`.
- 332386a2: r1600's repair, L126Final's header and docstring narrowed to the algebraic kernel, L126Bridge docstrings, the 8/8 count, and the `split_LeLin` pointers.
- f6075daf: L260's state in [lean/INDEX.md:111](../lean/INDEX.md#L111).

## 2. The sphere identity and the multiplier (A-1, A-2)

Write p = |S|, q = |Sᶜ|, n = p + q, α = q/(p − 1) inside S, β = p/(q − 1) outside, −1 across, 0 on the diagonal (the definition at [Families.lean:308](../lean/HamiltonsCubic/Base/Families.lean#L308)).

- **Within S**, a ≠ b: w_ab = α. In (w²)_ab = Σ_c w_ac w_cb the p − 2 indices c ∈ S \ {a, b} give α² each, the q indices outside give (−1)(−1) = 1, and c ∈ {a, b} give 0. So w_ab² + (w²)_ab = (p − 1)α² + q = q²/(p − 1) + q = q(n − 1)/(p − 1) = (n − 1)α.
- **Across**, a ∈ S, b ∉ S: w_ab = −1. The p − 1 indices c ∈ S \ {a} give α(−1), summing to −q; the q − 1 indices c ∉ S \ {b} give (−1)β, summing to −p; c ∈ {a, b} give 0. So 1 − q − p = −(n − 1) = (n − 1) w_ab.
- Outside and the other cross placement follow by the p ↔ q symmetry, which the Lean proof treats as separate cases with the same bookkeeping (`sw_in`, `sw_out` encode the zero diagonal as α − [c = a]α).

`sphere_diagCrit` scales by t: (tw)² terms carry t², and t²(n − 1)w = t(n − 1)(tw), matching the `linear_combination t ^ 2 * h`. `sphere_isCritical` passes through `isCritical_srg_form_uncond` ([L68Statement.lean:475](../lean/HamiltonsCubic/Results/L68Statement.lean#L475)), which is unconditional since `diagCriticalityIsCritical` was discharged.

**A-2.** At Q(M) = λM, P(M) = ⟨M, Q(M)⟩ = λ‖M‖², so at unit norm λ = P(M) = θ, and t(n − 1) is θ. The Lean does not state this equality, and nothing in `split_DF` needs it: `critMap_hasDerivAt` takes any λ, since only ⟨v, Q(M)⟩ = λ⟨v, M⟩ = 0 enters.

## 3. The hypotheses of critMap_hasDerivAt (A-3)

[L126Kernel.lean:51](../lean/HamiltonsCubic/Results/L126Kernel.lean#L51) needs `IsSelfAdjoint2 M`, `IsSelfAdjoint2 H`, `Qop2 M = lam • M` and `innerOp2 M H = 0`.

- **`IsSelfAdjoint2 M`**: `isSelfAdjoint2_restrict hW`, with hW from `diagOp_isWeyl`.
- **Criticality on `CurvOp2`**: `IsCritical (extend M) th` is transported from `sphere_isCritical` through `Qop_congr_on_skew` and `extend_restrict_on_skew` on each φ_ab, then `isCritical2_of_extend` ([CubicBridge.lean:173](../lean/HamiltonsCubic/Results/CubicBridge.lean#L173)). This is the right route, since `IsCritical` is read on basis bivectors.
- **`IsSelfAdjoint2 v`**: each rk2(U, V) is symmetric in the pairing (`rk2_symm`, a two-line expansion), and v is a real combination of three of them.
- **⟨M, v⟩ = 0**: through `innerOp_rk2`, ⟨diagOp w, U ⊙ V⟩ = ⟨wV, U⟩ + ⟨wU, V⟩, and for disjoint pairs w φ_kl = w_kl φ_kl is orthogonal to φ_ij. All three terms vanish because i, j, k, l are distinct, which the `simp` closes from the six inequalities.

The second conjunct is `split_kernel_iff` verbatim, so `split_DF` says what its docstring says, in the weak form (every Z) that [L126Kernel.lean](../lean/HamiltonsCubic/Results/L126Kernel.lean) already justifies as the derivative in finite dimension.

## 4. Is v in the record's tangent space (A-4)

The record's tangent space at M is the tangent space of the unit sphere of the Weyl space, so v must be Weyl as well as orthogonal to M. The layer's `IsWeyl` ([WeylReal.lean:126](../lean/HamiltonsCubic/Base/WeylReal.lean#L126)) asks skew-preservation, symmetry, first Bianchi and Ric = 0.

- **Bianchi**: [L121Bianchi.lean:78](../lean/HamiltonsCubic/Results/L121Bianchi.lean#L78) `fourSet_bianchi_iff` gives it for coefficients (2, −1, −1), sum 0.
- **Ricci-flat**: every component of each rk2 term has index set {i, j} ∪ {k, l} split across the two pairs with all four distinct, and a Ricci contraction needs an index shared between the pairs, so Ric(v) = 0. By hand, not stated.
- **Needed?** Not for `critMap_hasDerivAt`, which lives on all of `CurvOp2`. Needed for the reading "v ∈ T_M, v ∈ ker DF(M)" in the record's domain. And because `split_LeLin` gives the eigen-equation for the full, unprojected Fox product, a Weyl-projected F would give the same kernel verdict on this v.

**Gap.** [L126DF.lean:7](../lean/HamiltonsCubic/Results/L126DF.lean#L7) ("tangency discharged"), line 158 ("self-adjoint and tangent") and line 190 use "tangent" for ⟨M, v⟩ = 0 in `CurvOp2`. The row's parenthesis, "(criticality on `CurvOp2`, v self-adjoint, ⟨M,v⟩=0)", is accurate. Either compose `IsWeyl (extend v)` from `fourSet_bianchi_iff` plus a Ricci lemma, or say "orthogonal to M" in place of "tangent".

## 5. Honesty of the rows (A-5, A-6, A-7)

- **L126 row, 482.** The Owed clause now reads "the clause at a general diagonal critical M, that a four-set block meets ker DF(M) exactly when Σ_ijkl = θ², which is proved here only at sphere products". That is the one remaining piece of the record's statement beyond the sphere product, since `critMap_kernel_iff` is general and L121's block identification is proved. Accurate.
- **L126Final after 332386a2.** `split_kernel_iff`'s docstring states "2M∘v − P(M)v = 0 ... exactly when (p,q) = (3,3)", the algebraic kernel, as r1600 required. **But the module header, [L126Final.lean:16-17](../lean/HamiltonsCubic/Results/L126Final.lean#L16), still says the hypotheses "are owed at this M and v"**, which a376ab92 made stale. It should point to `split_DF` in L126DF.
- **L260, f6075daf.** The row's own notes list the singular value expansion, the range argument, the reduction and the equality case as not stated, so **partial** is the right state, and plan-lean.md row 120 follows.

## 6. Soundness (B)

- `lake build HamiltonsCubic.Results.L126DF HamiltonsCubic.Results.L126Final`: exit 0, 8791 jobs, no errors, warnings only in unrelated files.
- `axiom_audit.py --only L126DF.lean`: 8/8 clean. `--only L126Final.lean`: 3/3 clean. Standard three only. No `sorry` in either file.

## 7. Downstream (C)

- [L126Final.lean:16-17](../lean/HamiltonsCubic/Results/L126Final.lean#L16): "owed" is stale (§5).
- [second-order.md:1704](../findings/second-order.md#L1704): the machine-check note ends at `split_LeLin` and names neither L126Final (v ≠ 0, the kernel clause) nor L126DF (the derivative reading).
- [L126Statement.lean:52-57](../lean/HamiltonsCubic/Results/L126Statement.lean#L52): the "What is NOT typed here" list stops at L126Bridge and L126Splits, omitting L126Final and L126DF.
- [lean/INDEX.md:483](../lean/INDEX.md#L483): the statement row names L126Final "giving v ≠ 0 and the algebraic kernel clause" and does not name L126DF, which upgrades that clause to DF(M).

## 8. Style (D)

No em dashes in either Lean file or in the changed rows. No backticks inside link text. The changed markdown rows are single lines. The semicolons in row 482 ("...; standard three axioms") predate these commits and were flagged at r1598.

## Verdict

**CONFIRMED WITH GAPS.** L126DF is sound and faithful and closes r1600's gap 1: at the sphere product the (2,2) Bianchi vector lies in the kernel of DF(M), in the derivative sense, exactly at S³ × S³. The gaps are textual: L126Final's stale "owed", "tangent" used without v's Weyl membership, and three pointers that do not yet name L126Final or L126DF.
