import HamiltonsCubic.Results.L52RecordEq

set_option linter.style.longLine false

/-!
# L52's "if" half is false without the `ψ` stipulation

[findings/bispectral.md](../../../findings/bispectral.md), Lemma L52: *"The 'if' half is false without the `ψ` stipulation
above. At a coordinate-diagonal `W` read in the staircase basis, both operators are diagonal in one shared frame and the
bound is strict."* This file gives a witness at `n = 4`:

* **`Wst`**: the coordinate-diagonal weight `2` on the pairing `{01, 23}` and `−1` on `{02, 13}` and `{03, 12}`;
* **`Rst`**: `diagOp (t • Wst)` at `t = √(1/12)`, first Bianchi (`diagOp_bianchi`), coordinate-diagonal (`Rst_coordDiag`)
  and of unit norm (`Rst_unit`);
* **`wst`**: the complete frame `(e₀ ± e₁)/√2`, `(e₂ ± e₃)/√2` of `ℝ⁴` (`wst_complete`), which is no eigenbasis of `K`;
* **`staircase_strict`**: for every admissible `M₊` and `m`, `L52_record` at `(Rst, wst)` is strict. At equality
  `L52_eq_diagonalises` would force `w₀ᵀ K w₁ = 0`, and here `w₀ᵀ K w₁ = −2t ≠ 0` (`wst_cross`).

* **`Rst_ricci`**, **`whst`**, **`whst_complete`**, **`whst_perp`**, **`whst_cross`**, **`staircase_strict_helmert`**: the
  record's own staircase, the Helmert frame `𝟏/2, (1,−1,0,0)/√2, (1,1,−2,0)/√6, (1,1,1,−3)/√12` whose last three members
  span `𝟏^⊥`, at the Ricci-flat `Rst`, with `h₂ᵀ K h₃ = 24 t b c ≠ 0`, so the bound is strict in the record's `S²₀` frame.

`wst` is a basis of `S²` with no member along `𝟏` and so no `S²₀` reading; `whst` is the record's.
-/

namespace HamiltonsCubic.SecondKind

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.Results

/-- The weight: `2` on `{01, 23}`, `−1` on the other two pairings. -/
noncomputable def Wst : Matrix (Fin 4) (Fin 4) ℝ := fun i j =>
  if i = j then 0 else if i.val + j.val = 1 ∨ i.val + j.val = 5 then 2 else -1

theorem Wst_symm (i j : Fin 4) : Wst i j = Wst j i := by
  unfold Wst; by_cases h : i = j
  · subst h; rfl
  · simp [h, Ne.symm h, add_comm]

theorem Wst_hollow (i : Fin 4) : Wst i i = 0 := by simp [Wst]

/-- The scale `t = √(1/12)`. -/
noncomputable def tst : ℝ := Real.sqrt (1 / 12)

theorem tst_sq : tst * tst = 1 / 12 := Real.mul_self_sqrt (by norm_num)
theorem tst_pos : 0 < tst := Real.sqrt_pos.mpr (by norm_num)

noncomputable def Wt : Matrix (Fin 4) (Fin 4) ℝ := tst • Wst

theorem Wt_symm (i j : Fin 4) : Wt i j = Wt j i := by simp [Wt, Wst_symm i j]
theorem Wt_hollow (i : Fin 4) : Wt i i = 0 := by simp [Wt, Wst_hollow]

/-- The operator. -/
noncomputable def Rst : Matrix (Fin 4) (Fin 4) ℝ → Matrix (Fin 4) (Fin 4) ℝ := diagOp Wt

theorem Rst_lin : IsLinOp Rst := isLinOp_diagOp Wt
theorem Rst_skew : ∀ X, IsSkew X → IsSkew (Rst X) := fun X hX => diagOp_skew Wt Wt_symm X hX
theorem Rst_sym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (Rst X) Y = inner2 X (Rst Y) :=
  fun X Y _ _ => diagOp_selfAdjoint Wt X Y
theorem Rst_bianchi (i j k l : Fin 4) : bianchi Rst i j k l = 0 := diagOp_bianchi Wt Wt_symm i j k l

theorem R4_Rst (i j k l : Fin 4) :
    R4 Rst i j k l = Wt i j * ((if i = k ∧ j = l then (1 : ℝ) else 0) - (if j = k ∧ i = l then (1 : ℝ) else 0)) := by
  unfold R4 Rst; rw [diagOp_phi Wt Wt_symm, HamiltonsCubic.FamilyLayer.inner2_smul_left, inner2_phi_phi]

theorem Rst_coordDiag : IsCoordDiag Rst := by
  intro i j k l h
  rw [R4_Rst]
  have h1 : ¬(i = k ∧ j = l) := fun e => h (Or.inl ⟨e.1.symm, e.2.symm⟩)
  have h2 : ¬(j = k ∧ i = l) := fun e => h (Or.inr ⟨e.1.symm, e.2.symm⟩)
  simp [h1, h2]

theorem Kmat_Rst (a b : Fin 4) : Kmat Rst a b = Wt a b := by
  show R4 Rst a b a b = Wt a b
  rw [R4_Rst]
  by_cases h : a = b
  · subst h; simp [Wt_hollow]
  · simp [h, Ne.symm h]

theorem Rst_unit : normSq Rst = 1 := by
  unfold Rst Wt
  rw [diagOp_normSq_smul tst Wst Wst_symm Wst_hollow, diagOp_normSq Wst Wst_symm Wst_hollow]
  simp only [Fin.sum_univ_four, Wst]
  norm_num [Fin.ext_iff]
  nlinarith [tst_sq]

/-- `s = √(1/2)`. -/
noncomputable def sst : ℝ := Real.sqrt (1 / 2)
theorem sst_sq : sst * sst = 1 / 2 := Real.mul_self_sqrt (by norm_num)

/-- The frame `(e₀ + e₁)/√2`, `(e₂ + e₃)/√2`, `(e₀ − e₁)/√2`, `(e₂ − e₃)/√2`. -/
noncomputable def wst : Fin 4 → Fin 4 → ℝ :=
  ![![sst, sst, 0, 0], ![0, 0, sst, sst], ![sst, -sst, 0, 0], ![0, 0, sst, -sst]]

theorem wst_complete (i j : Fin 4) : ∑ k, wst k i * wst k j = if i = j then 1 else 0 := by
  fin_cases i <;> fin_cases j <;> simp [Fin.sum_univ_four, wst] <;> nlinarith [sst_sq]

/-- **The cross term is `−2t`.** -/
theorem wst_cross : wst 0 ⬝ᵥ (Kmat Rst *ᵥ wst 1) = -2 * tst * (2 * (sst * sst)) := by
  have w00 : wst 0 0 = sst := rfl
  have w01 : wst 0 1 = sst := rfl
  have w02 : wst 0 2 = 0 := rfl
  have w03 : wst 0 3 = 0 := rfl
  have w10 : wst 1 0 = 0 := rfl
  have w11 : wst 1 1 = 0 := rfl
  have w12 : wst 1 2 = sst := rfl
  have w13 : wst 1 3 = sst := rfl
  have W02 : Wst 0 2 = -1 := by unfold Wst; norm_num [Fin.ext_iff]
  have W03 : Wst 0 3 = -1 := by unfold Wst; norm_num [Fin.ext_iff]
  have W12 : Wst 1 2 = -1 := by unfold Wst; norm_num [Fin.ext_iff]
  have W13 : Wst 1 3 = -1 := by unfold Wst; norm_num [Fin.ext_iff]
  simp only [dotProduct, mulVec, Fin.sum_univ_four, Kmat_Rst, Wt, Matrix.smul_apply, smul_eq_mul,
    w00, w01, w02, w03, w10, w11, w12, w13, W02, W03, W12, W13]
  ring

/-- **The "if" half is false without the `ψ` stipulation**: at the coordinate-diagonal, first-Bianchi, unit-norm `Rst`
read in the complete frame `wst`, which does not diagonalise `K`, the bound `L52_record` is strict for every admissible
`M₊` and `m`. -/
theorem staircase_strict (Mp m : ℝ)
    (hμ : ∀ j, (Mpair_isHermitian Rst Rst_lin Rst_skew Rst_sym).eigenvalues j ≤ Mp)
    (hω : ∀ j, -m ≤ (Bw_isHermitian Rst Rst_lin Rst_skew Rst_sym wst wst_complete).eigenvalues j) :
    Pcubic Rst < (3 / 2) * (∑ p : Pairs 4, Kmat Rst p.1.1 p.1.2 ^ 3
          + 3 * Mp * (1 - ∑ p : Pairs 4, Kmat Rst p.1.1 p.1.2 ^ 2))
        - (1 / 2) * (∑ u, Bw wst (ringW Rst) u u ^ 3
          + 3 * m * (∑ u, Bw wst (ringW Rst) u u ^ 2 - 3)) := by
  have hle := L52_record Rst Rst_lin Rst_skew Rst_sym wst wst_complete Rst_bianchi Rst_unit Mp m hμ hω
  refine lt_of_le_of_ne hle fun heq => ?_
  have h0 := L52_eq_diagonalises Rst Rst_lin Rst_skew Rst_sym wst wst_complete Rst_bianchi Rst_unit Mp m hμ hω heq
    (k := 0) (l := 1) (by decide)
  rw [wst_cross, sst_sq] at h0
  have := tst_pos
  linarith

/-! ## The record's staircase, the Helmert frame of `𝟏 ⊕ 𝟏^⊥` -/

/-- Each row of `Wst` sums to `0`. -/
theorem Wst_row (a : Fin 4) : ∑ c, Wst a c = 0 := by
  have w00 : Wst 0 0 = 0 := Wst_hollow 0
  have w01 : Wst 0 1 = 2 := by unfold Wst; norm_num [Fin.ext_iff]
  have w02 : Wst 0 2 = -1 := by unfold Wst; norm_num [Fin.ext_iff]
  have w03 : Wst 0 3 = -1 := by unfold Wst; norm_num [Fin.ext_iff]
  have w10 : Wst 1 0 = 2 := by unfold Wst; norm_num [Fin.ext_iff]
  have w11 : Wst 1 1 = 0 := Wst_hollow 1
  have w12 : Wst 1 2 = -1 := by unfold Wst; norm_num [Fin.ext_iff]
  have w13 : Wst 1 3 = -1 := by unfold Wst; norm_num [Fin.ext_iff]
  have w20 : Wst 2 0 = -1 := by unfold Wst; norm_num [Fin.ext_iff]
  have w21 : Wst 2 1 = -1 := by unfold Wst; norm_num [Fin.ext_iff]
  have w22 : Wst 2 2 = 0 := Wst_hollow 2
  have w23 : Wst 2 3 = 2 := by unfold Wst; norm_num [Fin.ext_iff]
  have w30 : Wst 3 0 = -1 := by unfold Wst; norm_num [Fin.ext_iff]
  have w31 : Wst 3 1 = -1 := by unfold Wst; norm_num [Fin.ext_iff]
  have w32 : Wst 3 2 = 2 := by unfold Wst; norm_num [Fin.ext_iff]
  have w33 : Wst 3 3 = 0 := Wst_hollow 3
  rw [Fin.sum_univ_four]
  fin_cases a <;> simp only [Fin.zero_eta, Fin.mk_one, Fin.reduceFinMk, w00, w01, w02, w03, w10, w11, w12, w13, w20, w21, w22, w23, w30, w31, w32, w33] <;> norm_num

/-- **`Rst` is Ricci-flat**: each row of `Wst` sums to `0`. -/
theorem Rst_ricci (a b : Fin 4) : Ric Rst a b = 0 := by
  unfold Rst
  rw [diagOp_ric Wt Wt_symm]
  split_ifs with h
  · simp only [Wt, Matrix.smul_apply, smul_eq_mul, ← Finset.mul_sum, Wst_row, Wst_hollow, mul_zero, sub_zero]
  · rfl

noncomputable def ast : ℝ := Real.sqrt (1 / 2)
noncomputable def bst : ℝ := Real.sqrt (1 / 6)
noncomputable def cst : ℝ := Real.sqrt (1 / 12)
theorem ast_sq : ast * ast = 1 / 2 := Real.mul_self_sqrt (by norm_num)
theorem bst_sq : bst * bst = 1 / 6 := Real.mul_self_sqrt (by norm_num)
theorem cst_sq : cst * cst = 1 / 12 := Real.mul_self_sqrt (by norm_num)
theorem bst_pos : 0 < bst := Real.sqrt_pos.mpr (by norm_num)
theorem cst_pos : 0 < cst := Real.sqrt_pos.mpr (by norm_num)
theorem ast_sq2 : ast ^ 2 = 1 / 2 := by rw [sq]; exact ast_sq
theorem bst_sq2 : bst ^ 2 = 1 / 6 := by rw [sq]; exact bst_sq
theorem cst_sq2 : cst ^ 2 = 1 / 12 := by rw [sq]; exact cst_sq

/-- **The Helmert staircase**: `𝟏/2`, then `(1, −1, 0, 0)/√2`, `(1, 1, −2, 0)/√6`, `(1, 1, 1, −3)/√12`, spanning `𝟏^⊥`. -/
noncomputable def whst : Fin 4 → Fin 4 → ℝ :=
  ![![1 / 2, 1 / 2, 1 / 2, 1 / 2], ![ast, -ast, 0, 0], ![bst, bst, -2 * bst, 0], ![cst, cst, cst, -3 * cst]]

theorem whst_complete (i j : Fin 4) : ∑ k, whst k i * whst k j = if i = j then 1 else 0 := by
  have e00 : whst 0 0 = 1 / 2 := rfl
  have e01 : whst 0 1 = 1 / 2 := rfl
  have e02 : whst 0 2 = 1 / 2 := rfl
  have e03 : whst 0 3 = 1 / 2 := rfl
  have e10 : whst 1 0 = ast := rfl
  have e11 : whst 1 1 = -ast := rfl
  have e12 : whst 1 2 = 0 := rfl
  have e13 : whst 1 3 = 0 := rfl
  have e20 : whst 2 0 = bst := rfl
  have e21 : whst 2 1 = bst := rfl
  have e22 : whst 2 2 = -2 * bst := rfl
  have e23 : whst 2 3 = 0 := rfl
  have e30 : whst 3 0 = cst := rfl
  have e31 : whst 3 1 = cst := rfl
  have e32 : whst 3 2 = cst := rfl
  have e33 : whst 3 3 = -3 * cst := rfl
  rw [Fin.sum_univ_four]
  fin_cases i <;> fin_cases j <;> simp only [Fin.zero_eta, Fin.mk_one, Fin.reduceFinMk, e00, e01, e02, e03, e10, e11, e12, e13, e20, e21, e22, e23, e30, e31, e32, e33] <;> norm_num [Fin.ext_iff] <;> ring_nf <;> simp only [ast_sq2, bst_sq2, cst_sq2] <;> norm_num

/-- The staircase's last three members lie in `𝟏^⊥`, so the frame is the record's `S²₀` reading. -/
theorem whst_perp (k : Fin 4) (hk : k ≠ 0) : ∑ i, whst k i = 0 := by
  fin_cases k
  · exact absurd rfl hk
  all_goals (simp [Fin.sum_univ_four, whst]; try ring)

/-- **The staircase's cross term** `h₂ᵀ K h₃ = 24 t b c`. -/
theorem whst_cross : whst 2 ⬝ᵥ (Kmat Rst *ᵥ whst 3) = 24 * tst * bst * cst := by
  have u0 : whst 2 0 = bst := rfl
  have u1 : whst 2 1 = bst := rfl
  have u2 : whst 2 2 = -2 * bst := rfl
  have u3 : whst 2 3 = 0 := rfl
  have v0 : whst 3 0 = cst := rfl
  have v1 : whst 3 1 = cst := rfl
  have v2 : whst 3 2 = cst := rfl
  have v3 : whst 3 3 = -3 * cst := rfl
  have W00 : Wst 0 0 = 0 := Wst_hollow 0
  have W11 : Wst 1 1 = 0 := Wst_hollow 1
  have W22 : Wst 2 2 = 0 := Wst_hollow 2
  have W33 : Wst 3 3 = 0 := Wst_hollow 3
  have W01 : Wst 0 1 = 2 := by unfold Wst; norm_num [Fin.ext_iff]
  have W02 : Wst 0 2 = -1 := by unfold Wst; norm_num [Fin.ext_iff]
  have W03 : Wst 0 3 = -1 := by unfold Wst; norm_num [Fin.ext_iff]
  have W10 : Wst 1 0 = 2 := by unfold Wst; norm_num [Fin.ext_iff]
  have W12 : Wst 1 2 = -1 := by unfold Wst; norm_num [Fin.ext_iff]
  have W13 : Wst 1 3 = -1 := by unfold Wst; norm_num [Fin.ext_iff]
  have W20 : Wst 2 0 = -1 := by unfold Wst; norm_num [Fin.ext_iff]
  have W21 : Wst 2 1 = -1 := by unfold Wst; norm_num [Fin.ext_iff]
  have W23 : Wst 2 3 = 2 := by unfold Wst; norm_num [Fin.ext_iff]
  have W30 : Wst 3 0 = -1 := by unfold Wst; norm_num [Fin.ext_iff]
  have W31 : Wst 3 1 = -1 := by unfold Wst; norm_num [Fin.ext_iff]
  have W32 : Wst 3 2 = 2 := by unfold Wst; norm_num [Fin.ext_iff]
  simp only [dotProduct, mulVec, Fin.sum_univ_four, Kmat_Rst, Wt, Matrix.smul_apply, smul_eq_mul,
    u0, u1, u2, u3, v0, v1, v2, v3, W00, W11, W22, W33, W01, W02, W03, W10, W12, W13, W20, W21, W23, W30, W31, W32]
  ring

/-- **The record's staircase**: at the Ricci-flat, coordinate-diagonal, first-Bianchi, unit-norm `Rst` read in the
Helmert frame `whst` (the record's `S²₀` staircase: `𝟏/2` and a basis of `𝟏^⊥`), `L52_record` is strict for every
admissible `M₊` and `m`, the cross term `h₂ᵀ K h₃ = 24 t b c` being nonzero. -/
theorem staircase_strict_helmert (Mp m : ℝ)
    (hμ : ∀ j, (Mpair_isHermitian Rst Rst_lin Rst_skew Rst_sym).eigenvalues j ≤ Mp)
    (hω : ∀ j, -m ≤ (Bw_isHermitian Rst Rst_lin Rst_skew Rst_sym whst whst_complete).eigenvalues j) :
    Pcubic Rst < (3 / 2) * (∑ p : Pairs 4, Kmat Rst p.1.1 p.1.2 ^ 3
          + 3 * Mp * (1 - ∑ p : Pairs 4, Kmat Rst p.1.1 p.1.2 ^ 2))
        - (1 / 2) * (∑ u, Bw whst (ringW Rst) u u ^ 3
          + 3 * m * (∑ u, Bw whst (ringW Rst) u u ^ 2 - 3)) := by
  have hle := L52_record Rst Rst_lin Rst_skew Rst_sym whst whst_complete Rst_bianchi Rst_unit Mp m hμ hω
  refine lt_of_le_of_ne hle fun heq => ?_
  have h0 := L52_eq_diagonalises Rst Rst_lin Rst_skew Rst_sym whst whst_complete Rst_bianchi Rst_unit Mp m hμ hω heq
    (k := 2) (l := 3) (by decide)
  rw [whst_cross] at h0
  have := mul_pos (mul_pos tst_pos bst_pos) cst_pos
  linarith

end HamiltonsCubic.SecondKind
