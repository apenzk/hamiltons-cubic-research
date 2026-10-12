# REVIEW r1772: L248Op.lean (bdc0eebf), L248_op and L244_xfree_op

Gate 2 reader for the Lean layer. Commit [bdc0eebf](../lean/HamiltonsCubic/Results/L248Op.lean), file [L248Op.lean](../lean/HamiltonsCubic/Results/L248Op.lean). Analysis only: one `lake env lean` check file (axioms and a non-vacuity instance) and hand screens, no sweeps.

| Claim | Verdict | Reason |
|---|---|---|
| `sharpBil2_nonneg_of_nonpos` | CONFIRMED | in C's eigenframe every term of `sharpBil2_eigen` at X = Y is λ_β λ_γ · c², a product of two nonpositive numbers times a square |
| `L248_op` | CONFIRMED | the expansion of (W − M)#(W − M) at rk1 x reproduces θλ − λ² + 2Mλ + (n − 2)M² term for term |
| `L244_xfree_op` | CONFIRMED | `L248_op` at λ = −a, M = a gives a(n − 5 − θ) ≥ 0, and a > 0 divides it out |
| Normalisation of # | CONFIRMED | `sharpMap_id` rests on `sharpOp_id`, the record's anchor I#I = (n − 2)I |
| Non-vacuity | CONFIRMED | every hypothesis of `L248_op` is met at the unit balanced S³ × S³, checked in the kernel |
| Axioms | CONFIRMED | all three theorems on propext, Classical.choice, Quot.sound |
| INDEX rows L248, L244 | CONFIRMED WITH OBSERVATIONS | both rows describe the code, and two small points are noted below |

Summary: the three theorems are sound, match the record's L248 and L244 (ii) x-free bound, and are non-vacuous. Three observations, none a defect: `hsa` duplicates a field of `IsWeyl2`, M is more general than the record's b, and the record's word "unit" is not needed.

## 1. `sharpBil2_nonneg_of_nonpos`

- [sharpBil2_eigen](../lean/HamiltonsCubic/Results/I117Statements.lean#L2787) states `sharpBil2 C X Y = (1/2) * ∑ β, ∑ γ, lam β * lam γ * ⟪b β, toSk (brS X (ofSk (b γ)))⟫ * ⟪b β, toSk (brS Y (ofSk (b γ)))⟫` for any orthonormal basis b with C b_β = λ_β b_β. At X = Y the two inner products coincide, so every term is λ_β λ_γ · c² with c = ⟨b_β, [X, b_γ]⟩.
- The proof takes b from `opSk_symm` (Mathlib's `eigenvectorBasis` of the symmetric `opSk C`), reads λ_β ≤ 0 off `hneg` at the unit b_β, and closes with `mul_nonneg_of_nonpos_of_nonpos`, `mul_self_nonneg` and the factor 1/2. The `rw [mul_assoc]` regroups (λλ·c)·c into λλ·(c·c), which is what `h2` states.
- **The lemma holds equally at PSD C.** λ_β ≥ 0 for all β also makes each product nonnegative, and C#C is quadratic in C, so (−C)#(−C) = C#C. It is a property of any semidefinite C, either sign. The file needs only the NSD case, W − M being NSD.
- Sign sanity: at C = I (PSD, every λ = 1) the formula gives ⟨(I#I)X, X⟩ = (n − 2)⟨X, X⟩ ≥ 0, consistent.

## 2. The expansion in `L248_op`

- **Ftri C C (rk1 x) = ⟨(C#)x, x⟩.** [Ftri_sharp](../lean/HamiltonsCubic/Results/I117Statements.lean#L71) gives `Ftri C C Y = innerOp2 Y (sharpMapCL C)`, and [innerOp2_rk1](../lean/HamiltonsCubic/Results/I117G2.lean#L54) with `innerOp2_comm` gives `innerOp2 (rk1 x) S = inner2 (S x) x`. So `hF` is right, and `key` becomes `0 ≤ Ftri C C (rk1 x)` through `inner2_sharpMap` (⟨R#X, Y⟩ = sharpBil2 R X Y).
- Bilinearity of Ftri in the first two slots (`Ftri_add_left`, `Ftri_add_mid`, `Ftri_smul_left`, `Ftri_smul_mid`) splits C = W + (−M)I into F(W,W) − M F(I,W) − M F(W,I) + M² F(I,I).
- **Cross terms.** `sharpB idOp W` is (1/2)(sharpMapCL(I + W) − sharpMapCL I − sharpMapCL W) ([I117Statements.lean:1348](../lean/HamiltonsCubic/Results/I117Statements.lean#L1348)). Paired with x it equals (1/2)(F(I+W, I+W) − F(I,I) − F(W,W)) = (1/2)(F(I,W) + F(W,I)), which is `e2` after the add lemmas. The Lean uses both cross terms and never needs Ftri's symmetry in its first two slots.
- **I#W = −W.** [L265_weyl_clause](../lean/HamiltonsCubic/Results/I117Sharp.lean#L35): `sharpB idOp W = (-1) • W` at `IsWeyl2 W`. So ⟨(I#W)x, x⟩ = −λ and F(I,W) + F(W,I) = −2λ (`hIW`).
- **I#I = (n − 2)I.** [sharpMap_id](../lean/HamiltonsCubic/Results/CubicBridge.lean#L216), and ⟨x, x⟩ = 1 gives F(I,I) = n − 2 (`hII`).
- **W# = θW − W².** `sharpMapCL W = θ • W − compOp2 W` from `Qop2 W = θ • W`, and at Wx = λx it gives F(W,W) = θλ − λ² (`hWW`).
- Assembly: 0 ≤ θλ − λ² + 2Mλ + (n − 2)M² = λ(θ − λ + 2M) + (n − 2)M², the record's first inequality with b replaced by M.
- **Normalisation.** `sharpMapCL` bundles `sharpMap`, whose coefficients are `sharpBil2`, the polarisation of `sharpQF2`. `sharpQF2_id` is `rfl` against the record-layer `sharpQF`, and `sharpMap_id` rewrites to [sharpOp_id](../lean/HamiltonsCubic/Base/StructureConstants.lean#L217), `id# X = (n − 2) X` at every skew X and every n. That is the record's anchor, so the # here is the record's #.

## 3. `Qop2 W = θ • W` and the unit norm

- [Qop2](../lean/HamiltonsCubic/Base/Bivectors2.lean#L825) is `compOp2 R + sharpMapCL R`, and `compOp2 R = R.comp R`. So `Qop2 W = θ • W` is W² + W# = θW verbatim.
- **Unit norm is not needed.** Under W → tW, θ → tθ, λ → tλ, M → tM every term of λ(θ − λ + 2M) + (n − 2)M² scales by t², so the inequality is homogeneous and holds at every scale. The record's "unit" matters only when θ is read as θ(W) = P(W)/‖W‖³, which neither side of this lemma uses. The Lean's `hx1` normalises the eigenvector x, which is a different and necessary normalisation (it makes ⟨x, x⟩ = 1 in `hWW`, `hII`, `hIW`).

## 4. W ⪯ M against b = λ_max, and non-vacuity

- `hM` is ⟨WX, X⟩ ≤ M⟨X, X⟩ for all X, i.e. M ≥ λ_max. The record's b = λ_max is the case M = λ_max, which satisfies `hM` by the spectral theorem. The Lean is strictly more general.
- **Observation O1.** The file states no corollary at M = λ_max in eigenvalue form, so reaching the record's exact wording needs the one-line spectral bound ⟨WX, X⟩ ≤ λ_max⟨X, X⟩ supplied by the caller. It is standard and harmless, and the INDEX row states the ⪯ form correctly.
- **Non-vacuity, kernel-checked.** In a scratch file I compiled an `example` stating that at n = 6 there exist W, θ, M, λ, x with `IsSelfAdjoint2 W`, `IsWeyl2 W`, `Qop2 W = θ • W`, `hM`, `W x = λ • x`, ⟨x, x⟩ = 1 and `normSq2 W = 1`. The witness, which compiled with no errors:
  - W = `restrict (diagOp_isWeyl hw)` from `balanced_unit 3` in [L120Witness.lean](../lean/HamiltonsCubic/Results/L120Witness.lean#L84), the unit balanced S³ × S³.
  - x = φ₀₁, an eigenvector by `diagOp_phi` with λ = w₀₁, and ⟨φ₀₁, φ₀₁⟩ = 1.
  - M = Σ_{a,b} |w_ab|, with `hM` by a helper lemma (⟨diagOp w X, X⟩ ≤ (Σ|w|)⟨X, X⟩).
- **Hand screen at a tight case.** W_CP² on Λ²ℝ⁴ in the layer's normalisation (X ↦ −X + JXJᵀ + ⟨J, X⟩J, `WCPm_critical` at m = 2, Q(W) = 6W) has spectrum {4, −2, 0}. At λ = −2, M = 4: −2(6 + 2 + 8) + 2·16 = 0. Equality, consistent with CP² saturating L70 ([L70 row](../lean/INDEX.md)). At λ = 4: 4(6 − 4 + 8) + 32 = 72 ≥ 0. This is a screen, not evidence.

## 5. `L244_xfree_op` against L244 (ii)

- L244 (ii) ([second-order.md](../findings/second-order.md#lemma-l244-the-per-vector-ceiling-on-a-symmetric-three-value-critical-point)): eigenvalues (−a, 0, a), a = 1/√(2p), multiplicities (p, N − 2p, p), then θ ≤ (min(κ_{p−1}(x), κ_p(x) − 2, n − 4) − 1)/√(2p), "in particular θ ≤ (n − 5)/√(2p)". The Lean's θ ≤ a(n − 5) is the "in particular" clause.
- Derivation: `L248_op` at λ = −a, M = a gives −a(θ + 3a) + (n − 2)a² ≥ 0, i.e. a((n − 5)a − θ) ≥ 0, and `nlinarith` divides by a > 0. Correct.
- **What the symmetric family supplies and the Lean drops.** The family gives λ_max = a = −λ_min (so W ⪯ a and an eigenvalue −a), plus the three-value spectrum, the multiplicities and a = 1/√(2p). The Lean uses only the first pair: W ⪯ a and a unit eigenvector at −a. It holds at every spectrum with λ_min = −λ_max, which is L248's "at a = b" remark.
- The per-x κ bound of (ii) is outside this file, and the INDEX row says "(ii)'s x-free bound" and keeps the κ form under `per_vector_ceiling` as typed from hypotheses. Consistent.

## 6. Axioms

`#print axioms` in the scratch check file:

```
'HamiltonsCubic.L248Op.sharpBil2_nonneg_of_nonpos' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L248Op.L248_op' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L248Op.L244_xfree_op' depends on axioms: [propext, Classical.choice, Quot.sound]
```

No `sorryAx`, no `native_decide` (no `Lean.ofReduceBool`).

## 7. lean/INDEX.md rows

- **L248** ([INDEX.md:225](../lean/INDEX.md#L225)): status **proved**, "`L248_op` PROVED at the operator level", hypotheses listed as self-adjoint Weyl, Q(W) = θW, W ⪯ M, unit eigenvector. The code matches, including the three ingredient lemmas and the standard three axioms.
- **L244** ([INDEX.md:220](../lean/INDEX.md#L220)): status **partial**, with "(ii)'s x-free bound at the operator level, PROVED" and the hypotheses W ⪯ a, eigenvalue −a. Matches `L244_xfree_op`. It omits a > 0, which the theorem takes as `ha`. That is a wording gap of one hypothesis (observation O3).
- **Observation O2.** `hsa : IsSelfAdjoint2 W` in `L248_op` and `L244_xfree_op` is redundant: [IsWeyl2](../lean/HamiltonsCubic/Base/Bivectors2.lean#L352)'s `selfAdjoint` field is the statement of [IsSelfAdjoint2](../lean/HamiltonsCubic/Results/TraceOp.lean#L178) verbatim (my witness discharges `hsa` as `(isWeyl2_restrict _).selfAdjoint`). Harmless, and the rows' "self-adjoint Weyl" wording follows the code.

## 8. Falsifiers and the search

- **`sharpBil2_nonneg_of_nonpos`**: a self-adjoint NSD C and a bivector X with sharpBil2 C X X < 0. The eigenframe formula excludes it termwise. I checked the formula's sign at C = I (gives (n − 2)⟨X, X⟩, correct) and read the proof at source.
- **`L248_op`**: a critical Weyl W, an M ≥ λ_max and a unit eigenvector with λ(θ − λ + 2M) + (n − 2)M² < 0. Searched: the hand screen at W_CP² (equality at λ_min, the tight case) and the record's own S⁵ × S⁷ check (0.193 ≤ 0.382). Nothing found, and the tightness at CP² shows the constant cannot be improved in general.
- **`L244_xfree_op`**: a critical Weyl W with W ⪯ a, eigenvalue −a and θ > a(n − 5). It is an algebraic consequence of `L248_op`, so a falsifier of it falsifies `L248_op`. At W_CP² with a normalised to λ_max: λ_min = −λ_max fails there ({4, −2}), so it is outside the hypotheses. No further search, per the analysis-only rule.

## Overall verdict

**CONFIRMED WITH OBSERVATIONS.** O1: the Lean's M generalises the record's b = λ_max, and the specialisation needs the caller's spectral bound. O2: `hsa` duplicates `IsWeyl2.selfAdjoint`. O3: the L244 INDEX row omits the hypothesis a > 0.
