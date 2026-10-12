# Review r1860: L3's attainment, L3Attain.lean

*Cold Gate 2 brief on [L3Attain.lean](../lean/HamiltonsCubic/Results/L3Attain.lean): five theorems exhibiting a direction off the orbit tangent at which [L3Quad.lean](../lean/HamiltonsCubic/Results/L3Quad.lean)'s `L3_hessian` holds with equality, plus the r1859 repairs to [lean/INDEX.md](../lean/INDEX.md) and [L149Statement.lean](../lean/HamiltonsCubic/Results/L149Statement.lean). Analysis only. Run: one `lake env lean` scratch file with `#print axioms` on the five theorems, and one screen compiling a copy of `L3_attained` with `hq : 2 ≤ Tᶜ.card` in place of `3 ≤ Tᶜ.card`. Both exited 0. The olean was checked newer than the source before the screen.*

| # | Claim | Verdict |
|---|---|---|
| 1 | `LeLin_diag_of_phi` | CONFIRMED |
| 2 | `lam_witness` | CONFIRMED |
| 3 | `L3_attained` | CONFIRMED WITH OBSERVATIONS (O1, O2) |
| 4 | `L3_sharp` | CONFIRMED |
| 5 | `orbit_bilinear_zero` | CONFIRMED WITH OBSERVATIONS (O4) |
| 6 | INDEX L3 row, L149 row, L149Statement docstring | CONFIRMED WITH OBSERVATIONS (O3, O5) |

**Summary.** The five theorems prove what they state on the standard three axioms, `L3_sharp`'s hypotheses and conjuncts are syntactically `L3_hessian`'s, so equality in the bound is literally exhibited, and the defects found are one slack hypothesis and two labels that read wider than the Lean at one edge case.

## A. Hypothesis inventory

- `LeLin_diag_of_phi`: `hwt`, `hu` give Weyl-ness of both diagonal operators and are used by `diagOp_isWeyl`. `hP` is used in the final `field_simp` to cancel `P(M)⁻¹ · P(M)`. `h` is used on every `φ_ab` after [phi_expand](../lean/HamiltonsCubic/Results/L41Statement.lean) and two applications of [lin_sum](../lean/HamiltonsCubic/Results/L126Orbit.lean). No unused hypothesis.
- `lam_witness`: `hp : 3 ≤ p` is used for two distinct indices of `T` and for `κ ≠ 0` (it needs `p ≠ 2`). `hq : 1 ≤ q` is used for the index `c ∉ T` and for division by `q`. Both are needed: at `p = 2`, `κ = 0` and `h_a + h_b = 0` on `T = {a, b}`, so `lamW` vanishes and the nonzero conclusion is false.
- `L3_attained`: `hp` feeds `lam_witness` and `λ_p < ½`. `hq : 3 ≤ q` is slack: only `2 ≤ q` is consumed (by `sphereWeight_isWeight`, `sphere_lam`, `sphere_isCritical`), and the screen compiled the proof unchanged with `2 ≤ q` (O1). `ht` gives `θ > 0`. `hn` gives `‖M‖ = 1` and `θ = P(M)` through `theta_of_critical_unit`. The `innerOp2 M K = 0` hypothesis inside the orbit conjunct is taken and discarded (`_`), which is harmless since the conjunct only weakens by having it.
- `L3_sharp`: `hp : 4 ≤ m` and `hpq` are used for `m − 1 ≠ 0` and the identity `n − 2 = 2(m − 1)`. Everything else passes to `L3_attained`.
- `orbit_bilinear_zero`: `ha`, `hWa`, `hcrit`, `hθ` are the arguments of [hessB_op](../lean/HamiltonsCubic/Results/L24HessOp.lean). `hv` is the whole content. `lam` is free, as `hcrit` needs.
- Consumed: [sphere_lam](../lean/HamiltonsCubic/Results/L127DnUnits.lean) needs `2 ≤ p`, `2 ≤ q` and `Σ_T h = 0`. [lamW_isWeight](../lean/HamiltonsCubic/Results/L127DnSpan.lean) needs `Σ_T h = 0` and `κ q = −(p − 2)`. [LeLin_selfAdj](../lean/HamiltonsCubic/Results/L27Close.lean) needs Weyl-ness of all three. [hessQ_eq_Le](../lean/HamiltonsCubic/Results/L120Eigen.lean) needs unit, Weyl, critical, `P ≠ 0` and `v ∈ W^⊥ ∩ 𝒲ₙ`. [bridge_apply](../lean/HamiltonsCubic/Results/L126GenBridge.lean) needs linearity and skew-preservation of `S`. All are discharged in the file.

## B. Where the witness lives

- `D = restrict (diagOp (lamW T κ (e_a − e_b)))` is a diagonal Weyl operator with `L_e D = λ_p D`, so it lies in `𝒟ₙ ∩ E(λ_p)`. In L27's decomposition that is the diagonal (traceless diagonal matrix) direction of the `S²₀(ℝ^p)` summand for the factor `T`. Lean has no `S²₀` object, so membership in that summand is an identification by eigenvalue and shape, and it is untyped (O3).
- Attainment needs only `D ∈ N` with the Hessian at the bound, and that is what is proved. `D ⊥ M` comes from self-adjointness with `L_e M = M` and `λ_p ≠ 1`. `D ⊥ E(½) ∩ W^⊥ ∩ 𝒲ₙ` comes from self-adjointness with `λ_p ≠ ½`. Both are proved, not assumed.
- `L3_sharp`'s `hperp` and orbit conjuncts are character-for-character `L3_hessian`'s hypotheses `hperp` and `horb`, with the same `restrict (diagOp_isWeyl …)` term for `M`. So `L3_hessian` applies to this `D` and holds with equality. Equality in the bound is literally exhibited.
- The record's "with equality on `S²₀(ℝ^m)`" is a whole-summand claim. Lean gives one direction of it. At `m = 4` the `λ_m`-eigenspace also contains `Λ²⊗Λ²` (`μ = λ_4 = ⅓`), so equality holds on more than `S²₀` there, which the record's wording leaves implicit (O3).

## C. κ and the nonzero argument

- Syntactic match: `lam_witness`'s type writes `lamW T (-((T.card : ℝ) - 2) / Tᶜ.card) h`, which is sphere_lam's `κ` term verbatim, and `L3_attained` feeds it to `sphere_lam` through `LeLin_diag_of_phi` without a rewrite of `κ`. The `set κ` inside the proof is local.
- Value: `κ q = −(p − 2)`, which is `lamW_isWeight`'s row-sum condition, proved by `field_simp` with `q ≥ 1`.
- Nonzero: with `a ∈ T`, `c ∉ T`, `a ≠ b`, `lamW(a, c) = κ h_a = κ`. [phi](../lean/HamiltonsCubic/Base/WeylReal.lean) `a c = single c a 1 − single a c 1` has entry `−1` at `(a, c)`, so `D(φ_ac)(a, c) = −κ ≠ 0`. [diagOp_phi](../lean/HamiltonsCubic/Base/Families.lean) needs symmetry, supplied by `lamW_symm`. Sound.

## D. The polarisation

- `orbit_bilinear_zero` states `(hessQ(v + w) − hessQ(v) − hessQ(w))/2 = 0`. [hessB_op](../lean/HamiltonsCubic/Results/L24HessOp.lean) identifies this with `⟨6θ(L_e − ½)v, w⟩`, and proves it symmetric in `v, w` through `LeRestr_isSymmetric`. So it is the symmetric bilinear form of the quadratic form `hessQ`, and `hv` kills its first slot.
- `hessQ` is defined as `‖v‖²` times a second derivative along a great circle, which is not visibly quadratic. The bilinear reading rests on [hessQ_op](../lean/HamiltonsCubic/Results/L24HessOp.lean), which is proved. Right form.
- It gives `Hess(K, ·) = 0` on `W^⊥ ∩ 𝒲ₙ` for every `½`-eigenvector `K`, which is the record's "the Hessian vanishes on `T_{W*}𝒪`" read as a kernel statement, once `E(½) ∩ W^⊥ = T𝒪`. That identification is [L27_half_span](../lean/HamiltonsCubic/Results/L27Span.lean), which excludes `(3, 3)` (O4).

## E. Edge cases

- `p = 3`: `λ_3 = ¼`. `hLPh` needs `p − 2 < p − 1` and `p − 1 > 0`, both fine. `κ = −1/q ≠ 0`. No hidden division by `p − 2`. Clean.
- `q`: nothing assumes `q ≥ 3`. The hypothesis is stronger than the proof uses (O1).
- Small `n`: `p, q ≥ 3` forces `n ≥ 6`, and `L3_sharp` forces `n ≥ 8`. At `(3, 3)`, `L3_attained` still holds, but its orthogonality conjunct is to `E(½) ∩ W^⊥`, which there is 18-dimensional against a 9-dimensional orbit. The Lean statement is stronger than orbit-tangent orthogonality, so it is true. The docstring's parenthetical "(the orbit tangent)" is the inaccuracy (O2).
- Existence of `t` with `hn`: `normSq` scales as `t²`, so a positive `t` exists. The hypothesis is non-vacuous and identical to `L3_hessian`'s.

## F. Axioms

All five: `[propext, Classical.choice, Quot.sound]`. No `sorryAx`, no `Lean.ofReduceBool`.

## G. INDEX rows and what L3 still owes

- L3 row, "The bound is attained, PROVED": matches the Lean. "orthogonal to the orbit tangent" at `p, q ≥ 3` is implied by the proved orthogonality to all of `E(½) ∩ W^⊥ ∩ 𝒲ₙ`, since the orbit tangent sits inside that space by L24's equivariance identity. It does not overclaim.
- The row lists `p, q ≥ 3` for `L3_attained`, faithful to the Lean. Nothing claims the whole `S²₀` summand.
- L149 row and [L149Statement.lean](../lean/HamiltonsCubic/Results/L149Statement.lean) docstring: the stated shape of `L149_margin` (coefficients `3θ/(2(m − 1))` and `3θ(m − 4)/(2(m − 1))`, `H = H_s + H_r`, `H_r` orthogonal to the `½`- and `λ_m`-eigenvectors) matches [L149Margin.lean](../lean/HamiltonsCubic/Results/L149Margin.lean) line 276. The three untyped joining steps are named, and `hmargin`, `hop` remain hypotheses of the typed theorem, as both texts say (O5).
- L3 still owes the local-maximum clause, the strict maximum transverse to the orbit through a tubular neighbourhood or Morse–Bott argument, as the row records. The `S²₀` identification of the equality set is also untyped (O3). Neither is claimed.

## H. What would break each statement, and what I did

- Claim 1 breaks on a skew `X` outside the span of the `φ_ab`, or a `foxProd` that is not linear. Checked `phi_expand` (full expansion with coefficient `½⟨Z, φ_ab⟩`) and `isLinOp_foxProd`. Neither exists.
- Claim 2 breaks at `p = 2` (`κ = 0`, `D = 0`) or at `q = 0` (no `c`). Both excluded by hypothesis. Checked the sign of the `(a, c)` entry by hand.
- Claim 3 breaks if `λ_p = ½` or `λ_p = 1`, which would kill the orthogonality arguments. `λ_p = (p − 2)/(2(p − 1)) < ½` always. Also breaks if the `κ` fed to `sphere_lam` differed from the one in `lam_witness`: checked syntactically.
- Claim 4 breaks if the `M` term differed from `L3_hessian`'s. Compared the two statements line by line.
- Claim 5 breaks if `hessQ`'s polarisation were asymmetric or not bilinear. Read `hessB_op` and `hessQ_op`.
- Claim 6 breaks if a row asserted `S²₀`-wide equality or an orbit identification at `(3, 3)`. Read both rows and the docstring. The row's `(3, 3)` inclusion is harmless by G.
- Screens run: the axioms file and the `q ≥ 2` recompile. No numerical hunt.

## Observations

- **O1.** `L3_attained`'s `hq : 3 ≤ Tᶜ.card` can be `2 ≤ Tᶜ.card`: a copy with that hypothesis and the proof unchanged (bar the local `hqR` bound) compiled clean. Harmless, and `L3_sharp` is unaffected. Weakening would make the `(p, 2)` products covered too.
- **O2.** The `L3_attained` docstring and the module header gloss "orthogonal to every `½`-eigenvector" as "(the orbit tangent)" at `p, q ≥ 3`. At `(3, 3)` the two differ (18 against 9 dimensions, the record's own count). The Lean is correct. The gloss should say "which is the orbit tangent off `(3, 3)`, by `L27_half_span`".
- **O3.** Lean exhibits equality at one diagonal direction of the `λ_p`-eigenspace. The record's "equality on `S²₀(ℝ^m)`" as a whole summand, and its identification of `lamW` with `S²₀`'s diagonal part, are untyped. At `m = 4` equality also holds on `Λ²⊗Λ²`, which the record could state.
- **O4.** `orbit_bilinear_zero` is stated at a general unit critical Weyl `a`, for `½`-eigenvectors. Its reading as "the Hessian vanishes on the orbit tangent" needs `L27_half_span` (or L24's inclusion `T𝒪 ⊆ E(½)` for the direction that matters), which the INDEX row names for `L3_hessian` and could name here.
- **O5.** The L149 docstring leaves implicit that the block's `w` is `‖H_r‖` at `‖H‖ = 1`. That identification is part of the "normalisation" step it names as untyped, so nothing is overclaimed.

## Overall verdict

**CONFIRMED WITH OBSERVATIONS.** All five theorems hold on the standard three axioms, L3's constant `−6θ/(n − 2)` is shown sharp by a direction that meets `L3_hessian`'s hypotheses verbatim, and the r1859 repairs to the INDEX and the L149 docstring are accurate. O1 and O2 are small edits worth making. O3 and O4 are wording in the record and the row.
