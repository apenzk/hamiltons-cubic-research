import HamiltonsCubic.Results.OddJ1

set_option linter.style.longLine false

/-!
# The torus slice of `𝔰𝔬(2m + 1)`: the cubic form (the odd L271) and statement H for `m ≥ 7`

[The R48 working note](../../../reviews/2026-09-27-R48-torus-families.md), batch 12, Gate 2 by r1714 and r1715.
`𝔰𝔬(2m + 1)` is the skew matrices on `Option (Fin m × Fin 2)`, the added index `none` being `e_{2m+1}`, so
`𝔰𝔬(2m) ⊂ 𝔰𝔬(2m + 1)` is the old block and `𝔭 = span(e_a ∧ e_none)` its complement. The torus-invariant operator
`A ⊕ ⊕_α μ_α I_{R_α}` with `U_ij = μ_{ε_i - ε_j}`, `V_ij = μ_{ε_i + ε_j}` and `w_i = μ_{ε_i}` is
`torusOpOdd A U V w = extOp (torusOp A U V) + shortOp w`: L271's operator on `𝔰𝔬(2m)` extended by zero (`extOp`),
plus `w_i` on each short root plane `R_{ε_i} = span(e_{(i,0)} ∧ e_none, e_{(i,1)} ∧ e_none)` (`shortOp`).

- `L280_norm`, `L280_F`: `‖C‖² = ‖A‖² + ‖U‖² + ‖V‖² + 2‖w‖²` and
  `F(C) = 3 ∑ A_ii (d_i + w_i²) - 3 ∑_{i ≠ j} A_ij P_ij Q_ij + ½(tr P³ + tr Q³) + 3 wᵀ P w`.
  Proof: `Ftri_odd_split` gives `F(E + S) = F(E) + 3 F(S, E, S)`, because the middle slot kills every bracket in the
  other mixed terms (`Ftri_mid_kills` with the support lemmas `br_old_old`, `br_old_new`, `br_new_old`, `br_new_new`).
  `Ftri_ext` (from `phiTri_ext`) makes `F(E)` L271's value, and `Ftri_SES` with `torus_diag` and `SES_value` makes
  `F(S, E, S) = ∑ w_i² A_ii + wᵀ P w`.
- `H_torus_slice_odd`: for `m = n + 1 ≥ 7`, `F(C) ≤ (2m-1)/√(m(2m+1)) ‖C‖³`. Proof: `F = 3⟨A, A_μ⟩ + T` with
  `‖A_μ‖ = g`, Cauchy–Schwarz (`mat_cs`), L279's `J1odd_holds` after rescaling to `b = 1`, AM-GM in `g`, and
  `odd_scalar`, the closed form `κ²(x + y)³ - y(c₀y + 9x/(4λ))² = (2m-1)²(2mx - y)²(8mx + (6m-1)y)/(32m⁴(2m+1))`.
-/

namespace HamiltonsCubic.OddTorus

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.I117S

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-! ## `𝔰𝔬(k)` inside `𝔰𝔬(k + 1)`, the stabiliser of the added vector `none` -/

/-- A matrix on `ι` placed on the old indices of `Option ι`, zero on the added row and column. -/
def embedM (Y : Matrix ι ι ℝ) : Matrix (Option ι) (Option ι) ℝ := fun a b =>
  match a, b with
  | some p, some q => Y p q
  | _, _ => 0

/-- The old-index block of a matrix on `Option ι`. -/
def restrictM (X : Matrix (Option ι) (Option ι) ℝ) : Matrix ι ι ℝ := fun p q => X (some p) (some q)

theorem embedM_mem (Y : skewSub ι) : embedM (Y : Matrix ι ι ℝ) ∈ skewSub (Option ι) := by
  show (embedM (Y : Matrix ι ι ℝ))ᵀ = -embedM (Y : Matrix ι ι ℝ)
  have hY : (Y : Matrix ι ι ℝ)ᵀ = -(Y : Matrix ι ι ℝ) := Y.2
  ext a b
  cases a <;> cases b <;> simp [embedM]
  rename_i p q
  rw [← Matrix.transpose_apply (Y : Matrix ι ι ℝ) p q, hY, Matrix.neg_apply]

theorem restrictM_mem (X : skewSub (Option ι)) : restrictM (X : Matrix (Option ι) (Option ι) ℝ) ∈ skewSub ι := by
  show (restrictM (X : Matrix (Option ι) (Option ι) ℝ))ᵀ = -restrictM (X : Matrix (Option ι) (Option ι) ℝ)
  have hX : (X : Matrix (Option ι) (Option ι) ℝ)ᵀ = -(X : Matrix (Option ι) (Option ι) ℝ) := X.2
  ext p q
  simp only [restrictM, Matrix.transpose_apply, Matrix.neg_apply]
  rw [← Matrix.transpose_apply (X : Matrix (Option ι) (Option ι) ℝ) (some q) (some p), hX, Matrix.neg_apply]
  simp

/-- `𝔰𝔬(k) → 𝔰𝔬(k + 1)`. -/
noncomputable def embedL : skewSub ι →ₗ[ℝ] skewSub (Option ι) where
  toFun Y := ⟨embedM (Y : Matrix ι ι ℝ), embedM_mem Y⟩
  map_add' Y Z := by
    apply Subtype.ext; ext a b; cases a <;> cases b <;> simp [embedM]
  map_smul' c Y := by
    apply Subtype.ext; ext a b; cases a <;> cases b <;> simp [embedM]

/-- `𝔰𝔬(k + 1) → 𝔰𝔬(k)`, the old-index block. -/
noncomputable def restrictL : skewSub (Option ι) →ₗ[ℝ] skewSub ι where
  toFun X := ⟨restrictM (X : Matrix (Option ι) (Option ι) ℝ), restrictM_mem X⟩
  map_add' X Y := by apply Subtype.ext; ext p q; simp [restrictM]
  map_smul' c X := by apply Subtype.ext; ext p q; simp [restrictM]

/-- **An operator on `𝔰𝔬(k)` extended by zero to `𝔰𝔬(k + 1)`**: it acts on the old block and kills every
`e_a ∧ e_none`. -/
noncomputable def extOp (R : CurvOp2 ι) : CurvOp2 (Option ι) :=
  LinearMap.toContinuousLinearMap (embedL ∘ₗ (R : skewSub ι →ₗ[ℝ] skewSub ι) ∘ₗ restrictL)

theorem extOp_apply (R : CurvOp2 ι) (X : skewSub (Option ι)) : extOp R X = embedL (R (restrictL X)) := rfl

theorem restrictM_embedM (Y : Matrix ι ι ℝ) : restrictM (embedM Y) = Y := by
  ext p q; rfl

theorem embedM_phi (p q : ι) : embedM (phi p q) = phi (some p) (some q) := by
  ext a b
  cases a <;> cases b <;> simp [embedM, phi, Matrix.single_apply]

theorem restrictM_phi (p q : ι) : restrictM (phi (some p) (some q)) = phi p q := by
  ext a b; simp [restrictM, phi, Matrix.single_apply]

theorem restrictM_phi_none_l (b : Option ι) : restrictM (phi none b) = 0 := by
  ext p q; simp [restrictM, phi, Matrix.single_apply]

theorem restrictM_phi_none_r (a : Option ι) : restrictM (phi a none) = 0 := by
  ext p q; simp [restrictM, phi, Matrix.single_apply]

theorem embedM_mul (X Y : Matrix ι ι ℝ) : embedM X * embedM Y = embedM (X * Y) := by
  ext a b
  cases a <;> cases b <;> simp [embedM, Matrix.mul_apply, Fintype.sum_option]

theorem embedM_br (X Y : Matrix ι ι ℝ) : br (embedM X) (embedM Y) = embedM (br X Y) := by
  unfold br; rw [embedM_mul, embedM_mul]; ext a b; cases a <;> cases b <;> simp [embedM]

theorem embedM_transpose (X : Matrix ι ι ℝ) : (embedM X)ᵀ = embedM Xᵀ := by
  ext a b; cases a <;> cases b <;> simp [embedM]

theorem inner2_embedM (X Y : Matrix ι ι ℝ) : inner2 (embedM X) (embedM Y) = inner2 X Y := by
  unfold inner2; rw [embedM_transpose, embedM_mul]
  simp [Matrix.trace, Fintype.sum_option, embedM]

theorem restrictL_phi (p q : ι) :
    restrictL (⟨phi (some p) (some q), phi_mem_skewSub _ _⟩ : skewSub (Option ι)) = ⟨phi p q, phi_mem_skewSub p q⟩ :=
  Subtype.ext (restrictM_phi p q)

theorem restrictL_phi_none_l (b : Option ι) :
    restrictL (⟨phi none b, phi_mem_skewSub _ _⟩ : skewSub (Option ι)) = 0 :=
  Subtype.ext (restrictM_phi_none_l b)

theorem restrictL_phi_none_r (a : Option ι) :
    restrictL (⟨phi a none, phi_mem_skewSub _ _⟩ : skewSub (Option ι)) = 0 :=
  Subtype.ext (restrictM_phi_none_r a)

theorem embedL_phi (p q : ι) :
    embedL (⟨phi p q, phi_mem_skewSub p q⟩ : skewSub ι) = ⟨phi (some p) (some q), phi_mem_skewSub _ _⟩ :=
  Subtype.ext (embedM_phi p q)

theorem brS_embedL (X Y : skewSub ι) : brS (embedL X) (embedL Y) = embedL (brS X Y) :=
  Subtype.ext (embedM_br _ _)

theorem restrictL_embedL (Y : skewSub ι) : restrictL (embedL Y) = Y := Subtype.ext (restrictM_embedM _)

theorem brS_zero_left {κ : Type*} [Fintype κ] [DecidableEq κ] (Y : skewSub κ) : brS 0 Y = 0 :=
  Subtype.ext (by simp [brS, br])

theorem brS_zero_right {κ : Type*} [Fintype κ] [DecidableEq κ] (X : skewSub κ) : brS X 0 = 0 :=
  Subtype.ext (by simp [brS, br])

/-- **`Φ` is unchanged by extension by zero**: only the old coordinate bivectors reach an extended operator, and
on them the bracket and the pairing are those of `𝔰𝔬(k)`. -/
theorem phiTri_ext (A B C : CurvOp2 ι) : phiTri (extOp A) (extOp B) (extOp C) = phiTri A B C := by
  unfold phiTri
  congr 1
  let T : Option ι → Option ι → Option ι → Option ι → ℝ := fun i j k l =>
    inner2 ((extOp B (brS (extOp A ⟨phi i j, phi_mem_skewSub i j⟩) (extOp C ⟨phi k l, phi_mem_skewSub k l⟩)) :
      skewSub (Option ι)) : Matrix (Option ι) (Option ι) ℝ)
      ((brS ⟨phi i j, phi_mem_skewSub i j⟩ ⟨phi k l, phi_mem_skewSub k l⟩ : skewSub (Option ι)) :
        Matrix (Option ι) (Option ι) ℝ)
  show ∑ i, ∑ j, ∑ k, ∑ l, T i j k l = _
  have h1 : ∀ j k l, T none j k l = 0 := fun j k l => by
    simp only [T, extOp_apply, restrictL_phi_none_l, map_zero, brS_zero_left, Submodule.coe_zero, inner2,
      Matrix.transpose_zero, Matrix.zero_mul, Matrix.trace_zero, mul_zero]
  have h2 : ∀ p k l, T (some p) none k l = 0 := fun p k l => by
    simp only [T, extOp_apply, restrictL_phi_none_r, map_zero, brS_zero_left, Submodule.coe_zero, inner2,
      Matrix.transpose_zero, Matrix.zero_mul, Matrix.trace_zero, mul_zero]
  have h3 : ∀ p q l, T (some p) (some q) none l = 0 := fun p q l => by
    simp only [T, extOp_apply, restrictL_phi_none_l, map_zero, brS_zero_right, Submodule.coe_zero, inner2,
      Matrix.transpose_zero, Matrix.zero_mul, Matrix.trace_zero, mul_zero]
  have h4 : ∀ p q r, T (some p) (some q) (some r) none = 0 := fun p q r => by
    simp only [T, extOp_apply, restrictL_phi_none_r, map_zero, brS_zero_right, Submodule.coe_zero, inner2,
      Matrix.transpose_zero, Matrix.zero_mul, Matrix.trace_zero, mul_zero]
  have h5 : ∀ p q r s, T (some p) (some q) (some r) (some s)
      = inner2 ((B (brS (A ⟨phi p q, phi_mem_skewSub p q⟩) (C ⟨phi r s, phi_mem_skewSub r s⟩)) : skewSub ι) : Matrix ι ι ℝ)
        ((brS ⟨phi p q, phi_mem_skewSub p q⟩ ⟨phi r s, phi_mem_skewSub r s⟩ : skewSub ι) : Matrix ι ι ℝ) := fun p q r s => by
    simp only [T, extOp_apply, restrictL_phi, brS_embedL, restrictL_embedL]
    rw [← embedL_phi p q, ← embedL_phi r s, brS_embedL]
    exact inner2_embedM _ _
  simp only [Fintype.sum_option, h1, h2, h3, h4, h5, Finset.sum_const_zero, zero_add]

/-! ## The torus-invariant operators of `𝔰𝔬(2m + 1)` -/

variable {m : ℕ}

/-- The weight pattern of the short root planes: `w_i` on `e_{(i, s)} ∧ e_none`, zero elsewhere. -/
def shortW (w : Fin m → ℝ) : Option (Fin m × Fin 2) → Option (Fin m × Fin 2) → ℝ := fun a b =>
  match a, b with
  | some p, none => w p.1
  | none, some q => w q.1
  | _, _ => 0

theorem shortW_symm (w : Fin m → ℝ) (a b : Option (Fin m × Fin 2)) : shortW w a b = shortW w b a := by
  cases a <;> cases b <;> rfl

theorem shortM_mem (w : Fin m → ℝ) (X : skewSub (Option (Fin m × Fin 2))) :
    (Matrix.of fun a b => shortW w a b * (X : Matrix (Option (Fin m × Fin 2)) (Option (Fin m × Fin 2)) ℝ) a b)
      ∈ skewSub (Option (Fin m × Fin 2)) := by
  show (Matrix.of fun a b => shortW w a b * (X : Matrix _ _ ℝ) a b)ᵀ = -(Matrix.of fun a b => shortW w a b * (X : Matrix _ _ ℝ) a b)
  have hX : (X : Matrix (Option (Fin m × Fin 2)) (Option (Fin m × Fin 2)) ℝ)ᵀ = -(X : Matrix _ _ ℝ) := X.2
  ext a b
  simp only [Matrix.transpose_apply, Matrix.of_apply, Matrix.neg_apply]
  rw [shortW_symm w b a, ← Matrix.transpose_apply (X : Matrix _ _ ℝ) a b, hX, Matrix.neg_apply, mul_neg]

/-- **The short-root part** `⊕_i w_i I_{R_{ε_i}}`, `R_{ε_i} = span(e_{(i,0)} ∧ e_none, e_{(i,1)} ∧ e_none)`. -/
noncomputable def shortOp (w : Fin m → ℝ) : CurvOp2 (Option (Fin m × Fin 2)) :=
  LinearMap.toContinuousLinearMap
    { toFun := fun X => ⟨Matrix.of fun a b => shortW w a b * (X : Matrix _ _ ℝ) a b, shortM_mem w X⟩
      map_add' := fun X Y => by apply Subtype.ext; ext a b; simp [mul_add]
      map_smul' := fun c X => by apply Subtype.ext; ext a b; simp; ring }

/-- **The torus-invariant operator `A ⊕ ⊕_α μ_α I_{R_α}` on `𝔰𝔬(2m + 1)`**, with `U_ij = μ_{ε_i - ε_j}`,
`V_ij = μ_{ε_i + ε_j}` and `w_i = μ_{ε_i}`: L271's operator on `𝔰𝔬(2m)` extended by zero, plus the short part. -/
noncomputable def torusOpOdd (A U V : Matrix (Fin m) (Fin m) ℝ) (w : Fin m → ℝ) : CurvOp2 (Option (Fin m × Fin 2)) :=
  extOp (torusOp A U V) + shortOp w

/-! ## The two supports: `𝔰𝔬(2m)` (old) and `𝔭 = span(e_a ∧ e_none)` (new) -/

section Support

variable {κ : Type*} [Fintype κ] [DecidableEq κ]

/-- Supported on the old block: zero on the `none` row and column. -/
def IsOld (X : Matrix (Option κ) (Option κ) ℝ) : Prop := ∀ a, X a none = 0 ∧ X none a = 0

/-- Supported on `𝔭`: zero on the old block and at the corner. -/
def IsNew (X : Matrix (Option κ) (Option κ) ℝ) : Prop := (∀ p q, X (some p) (some q) = 0) ∧ X none none = 0

theorem br_old_old {X Y : Matrix (Option κ) (Option κ) ℝ} (hX : IsOld X) (hY : IsOld Y) : IsOld (br X Y) := by
  intro a
  constructor
  · simp [br, Matrix.sub_apply, Matrix.mul_apply, (hX _).1, (hY _).1]
  · simp [br, Matrix.sub_apply, Matrix.mul_apply, (hX _).2, (hY _).2]

theorem br_old_new {X Y : Matrix (Option κ) (Option κ) ℝ} (hX : IsOld X) (hY : IsNew Y) : IsNew (br X Y) := by
  constructor
  · intro p q
    simp [br, Matrix.sub_apply, Matrix.mul_apply, Fintype.sum_option, (hX _).1, (hX _).2, hY.1]
  · simp [br, Matrix.sub_apply, Matrix.mul_apply, (hX _).1, (hX _).2]

theorem br_new_old {X Y : Matrix (Option κ) (Option κ) ℝ} (hX : IsNew X) (hY : IsOld Y) : IsNew (br X Y) := by
  constructor
  · intro p q
    simp [br, Matrix.sub_apply, Matrix.mul_apply, Fintype.sum_option, (hY _).1, (hY _).2, hX.1]
  · simp [br, Matrix.sub_apply, Matrix.mul_apply, (hY _).1, (hY _).2]

theorem br_new_new {X Y : Matrix (Option κ) (Option κ) ℝ} (hX : IsNew X) (hY : IsNew Y) (hXs : Xᵀ = -X)
    (hYs : Yᵀ = -Y) : IsOld (br X Y) := by
  have sX : ∀ a b, X b a = -X a b := fun a b => by
    have := congrFun (congrFun hXs a) b; simpa [Matrix.transpose_apply] using this
  have sY : ∀ a b, Y b a = -Y a b := fun a b => by
    have := congrFun (congrFun hYs a) b; simpa [Matrix.transpose_apply] using this
  intro a
  cases a with
  | none =>
    have h : (br X Y) none none = 0 := by
      simp only [br, Matrix.sub_apply, Matrix.mul_apply]
      rw [sub_eq_zero]
      refine Finset.sum_congr rfl fun c _ => ?_
      rw [sX c none, sY c none]; ring
    exact ⟨h, h⟩
  | some p =>
    constructor
    · simp [br, Matrix.sub_apply, Matrix.mul_apply, Fintype.sum_option, hX.1, hY.1, hX.2, hY.2]
    · simp [br, Matrix.sub_apply, Matrix.mul_apply, Fintype.sum_option, hX.1, hY.1, hX.2, hY.2]

/-- **`F(A, B, C) = 0` when the middle slot kills every bracket** `[A X, C Y]`. -/
theorem Ftri_mid_kills (A B C : CurvOp2 κ) (h : ∀ X Y : skewSub κ, B (brS (A X) (C Y)) = 0) : Ftri A B C = 0 := by
  unfold Ftri phiTri
  simp [h, inner2]

end Support

theorem extOp_old (R : CurvOp2 ι) (X : skewSub (Option ι)) : IsOld (extOp R X).1 := by
  intro a; cases a <;> exact ⟨rfl, rfl⟩

theorem extOp_kills_new (R : CurvOp2 ι) (X : skewSub (Option ι)) (hX : IsNew X.1) :
    extOp R X = 0 := by
  have : restrictL X = 0 := Subtype.ext (by ext p q; exact hX.1 p q)
  rw [extOp_apply, this, map_zero, map_zero]

theorem shortOp_apply (w : Fin m → ℝ) (X : skewSub (Option (Fin m × Fin 2))) (a b : Option (Fin m × Fin 2)) :
    (shortOp w X).1 a b = shortW w a b * X.1 a b := rfl

theorem shortOp_new (w : Fin m → ℝ) (X : skewSub (Option (Fin m × Fin 2))) :
    IsNew (shortOp w X).1 :=
  ⟨fun p q => by rw [shortOp_apply]; simp [shortW], by rw [shortOp_apply]; simp [shortW]⟩

theorem shortOp_kills_old (w : Fin m → ℝ) (X : skewSub (Option (Fin m × Fin 2)))
    (hX : IsOld X.1) : shortOp w X = 0 := by
  apply Subtype.ext; ext a b
  rw [shortOp_apply]
  cases a <;> cases b <;> simp [shortW, (hX _).1, (hX _).2]

theorem shortOp_isSelfAdjoint2 (w : Fin m → ℝ) : IsSelfAdjoint2 (shortOp w) := by
  intro X Y
  show inner2 (shortOp w X).1 Y.1 = inner2 X.1 (shortOp w Y).1
  rw [inner2_eq_sum, inner2_eq_sum]
  congr 1
  refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_
  rw [shortOp_apply, shortOp_apply]; ring

theorem inner2_embedM_l (Z : Matrix ι ι ℝ) (Y : Matrix (Option ι) (Option ι) ℝ) :
    inner2 (embedM Z) Y = inner2 Z (restrictM Y) := by
  rw [inner2_eq_sum, inner2_eq_sum]
  simp [Fintype.sum_option, embedM, restrictM]

theorem inner2_embedM_r (Z : Matrix ι ι ℝ) (Y : Matrix (Option ι) (Option ι) ℝ) :
    inner2 Y (embedM Z) = inner2 (restrictM Y) Z := by
  rw [inner2_eq_sum, inner2_eq_sum]
  simp [Fintype.sum_option, embedM, restrictM]

theorem extOp_isSelfAdjoint2 (R : CurvOp2 ι) (hR : IsSelfAdjoint2 R) : IsSelfAdjoint2 (extOp R) := by
  intro X Y
  show inner2 (embedM (R (restrictL X)).1) Y.1 = inner2 X.1 (embedM (R (restrictL Y)).1)
  rw [inner2_embedM_l, inner2_embedM_r]
  exact hR (restrictL X) (restrictL Y)

theorem Ftri_ext (R : CurvOp2 ι) : Ftri (extOp R) (extOp R) (extOp R) = Ftri R R R := by
  unfold Ftri; rw [phiTri_ext]

/-- **The split**: `F(E + S) = F(E) + 3 F(S, E, S)`. -/
theorem Ftri_odd_split (A U V : Matrix (Fin m) (Fin m) ℝ) (w : Fin m → ℝ) :
    Ftri (torusOpOdd A U V w) (torusOpOdd A U V w) (torusOpOdd A U V w)
      = Ftri (extOp (torusOp A U V)) (extOp (torusOp A U V)) (extOp (torusOp A U V))
        + 3 * Ftri (shortOp w) (extOp (torusOp A U V)) (shortOp w) := by
  set E := extOp (torusOp A U V) with hE
  set S := shortOp w with hS
  have hSsa : IsSelfAdjoint2 S := shortOp_isSelfAdjoint2 w
  have sk : ∀ Z : skewSub (Option (Fin m × Fin 2)), Z.1ᵀ = -Z.1 := fun Z => Z.2
  have hEES : Ftri E E S = 0 := Ftri_mid_kills _ _ _ fun X Y =>
    extOp_kills_new _ _ (br_old_new (extOp_old _ X) (shortOp_new w Y))
  have hESE : Ftri E S E = 0 := Ftri_mid_kills _ _ _ fun X Y =>
    shortOp_kills_old w _ (br_old_old (extOp_old _ X) (extOp_old _ Y))
  have hSEE : Ftri S E E = 0 := Ftri_mid_kills _ _ _ fun X Y =>
    extOp_kills_new _ _ (br_new_old (shortOp_new w X) (extOp_old _ Y))
  have hSSS : Ftri S S S = 0 := Ftri_mid_kills _ _ _ fun X Y =>
    shortOp_kills_old w _ (br_new_new (shortOp_new w X) (shortOp_new w Y) (sk _) (sk _))
  have hESS : Ftri E S S = Ftri S E S := Ftri_symm12 hSsa
  have hSSE : Ftri S S E = Ftri S E S := Ftri_symm23 hSsa S E
  show Ftri (E + S) (E + S) (E + S) = _
  simp only [Ftri_add_left, Ftri_add_mid, Ftri_add_right]
  rw [hEES, hESE, hSEE, hSSS, hESS, hSSE]
  ring

/-! ## `F(S, E, S)`: the short planes are eigenplanes of `S`, and their brackets are old coordinate bivectors -/

theorem shortOp_phi (w : Fin m → ℝ) (a b : Option (Fin m × Fin 2)) :
    shortOp w ⟨phi a b, phi_mem_skewSub a b⟩ = shortW w a b • ⟨phi a b, phi_mem_skewSub a b⟩ := by
  apply Subtype.ext; ext c d
  rw [shortOp_apply]
  simp only [Submodule.coe_smul, Matrix.smul_apply, smul_eq_mul, phi, Matrix.sub_apply, Matrix.single_apply]
  by_cases h1 : b = c ∧ a = d
  · obtain ⟨rfl, rfl⟩ := h1; rw [shortW_symm w b a]
  · by_cases h2 : a = c ∧ b = d
    · obtain ⟨rfl, rfl⟩ := h2; rfl
    · simp [h1, h2]

theorem phiS_swap {κ : Type*} [Fintype κ] [DecidableEq κ] (a b : κ) :
    (⟨phi b a, phi_mem_skewSub b a⟩ : skewSub κ) = -⟨phi a b, phi_mem_skewSub a b⟩ := by
  apply Subtype.ext; simp [phi]

theorem brS_psi (p r : Fin m × Fin 2) :
    brS (⟨phi (some p) none, phi_mem_skewSub _ _⟩ : skewSub (Option (Fin m × Fin 2))) ⟨phi (some r) none, phi_mem_skewSub _ _⟩
      = embedL ⟨phi p r, phi_mem_skewSub p r⟩ := by
  apply Subtype.ext
  show br (phi (some p) none) (phi (some r) none) = embedM (phi p r)
  rw [embedM_phi]
  ext a b
  rcases a with _ | a <;> rcases b with _ | b <;>
    simp [br, phi, Matrix.mul_apply, Matrix.sub_apply, Matrix.single_apply, Finset.sum_ite_eq, sub_mul, mul_sub]
  all_goals (try simp only [@eq_comm _ r p]); (try ring)

/-- The quantity `F(S, E, S)` sums: `E`'s pairing on the bracket of two coordinate bivectors, `[φ_ij, φ_kl]`. -/
noncomputable def Gq (T : CurvOp2 (Fin m × Fin 2)) (i j k l : Option (Fin m × Fin 2)) : ℝ :=
  inner2 (extOp T (brS ⟨phi i j, phi_mem_skewSub i j⟩ ⟨phi k l, phi_mem_skewSub k l⟩)).1
    (brS ⟨phi i j, phi_mem_skewSub i j⟩ ⟨phi k l, phi_mem_skewSub k l⟩).1

theorem Gq_swap_l (T : CurvOp2 (Fin m × Fin 2)) (i j k l : Option (Fin m × Fin 2)) : Gq T j i k l = Gq T i j k l := by
  unfold Gq
  rw [phiS_swap i j, show (-(⟨phi i j, phi_mem_skewSub i j⟩ : skewSub (Option (Fin m × Fin 2))))
    = (-1 : ℝ) • ⟨phi i j, phi_mem_skewSub i j⟩ from (neg_one_smul ℝ _).symm, brS_smul_left, map_smul,
    Submodule.coe_smul, Submodule.coe_smul, i2_smul_l, i2_smul_r]
  ring

theorem Gq_swap_r (T : CurvOp2 (Fin m × Fin 2)) (i j k l : Option (Fin m × Fin 2)) : Gq T i j l k = Gq T i j k l := by
  unfold Gq
  rw [phiS_swap k l, show (-(⟨phi k l, phi_mem_skewSub k l⟩ : skewSub (Option (Fin m × Fin 2))))
    = (-1 : ℝ) • ⟨phi k l, phi_mem_skewSub k l⟩ from (neg_one_smul ℝ _).symm, brS_smul_right, map_smul,
    Submodule.coe_smul, Submodule.coe_smul, i2_smul_l, i2_smul_r]
  ring

theorem Gq_psi (T : CurvOp2 (Fin m × Fin 2)) (p r : Fin m × Fin 2) :
    Gq T (some p) none (some r) none = inner2 (T ⟨phi p r, phi_mem_skewSub p r⟩).1 (phi p r) := by
  unfold Gq
  rw [brS_psi, extOp_apply, restrictL_embedL]
  exact inner2_embedM _ _

/-- **`F(S, E, S) = ½ ∑_{p, q} w_p w_q ⟨T φ_pq, φ_pq⟩`**, over the old coordinate bivectors. -/
theorem Ftri_SES (w : Fin m → ℝ) (T : CurvOp2 (Fin m × Fin 2)) :
    Ftri (shortOp w) (extOp T) (shortOp w)
      = (1 / 2) * ∑ p, ∑ q, w p.1 * w q.1 * inner2 (T ⟨phi p q, phi_mem_skewSub p q⟩).1 (phi p q) := by
  unfold Ftri phiTri
  have hterm : ∀ i j k l : Option (Fin m × Fin 2),
      inner2 (extOp T (brS (shortOp w ⟨phi i j, phi_mem_skewSub i j⟩) (shortOp w ⟨phi k l, phi_mem_skewSub k l⟩))).1
        (brS ⟨phi i j, phi_mem_skewSub i j⟩ ⟨phi k l, phi_mem_skewSub k l⟩).1
      = shortW w i j * shortW w k l * Gq T i j k l := fun i j k l => by
    unfold Gq
    rw [shortOp_phi, shortOp_phi, brS_smul_left, brS_smul_right, map_smul, map_smul, Submodule.coe_smul,
      Submodule.coe_smul, i2_smul_l, i2_smul_l]
    ring
  simp only [hterm]
  have e1 : ∀ p r, Gq T none (some p) (some r) none = Gq T (some p) none (some r) none := fun p r => Gq_swap_l T _ _ _ _
  have e2 : ∀ p r, Gq T (some p) none none (some r) = Gq T (some p) none (some r) none := fun p r => Gq_swap_r T _ _ _ _
  have e3 : ∀ p r, Gq T none (some p) none (some r) = Gq T (some p) none (some r) none := fun p r => by
    rw [Gq_swap_l, Gq_swap_r]
  simp only [Fintype.sum_option, shortW, zero_mul, mul_zero, Finset.sum_const_zero, zero_add, add_zero, e1, e2, e3,
    Gq_psi, Finset.sum_add_distrib]
  ring

theorem inner2_phi_r {κ : Type*} [Fintype κ] [DecidableEq κ] (M : Matrix κ κ ℝ) (p q : κ) :
    inner2 M (phi p q) = (1 / 2) * (M q p - M p q) := by
  rw [inner2_eq_sum]
  congr 1
  simp [phi, Matrix.single_apply, mul_sub, Finset.sum_sub_distrib, ite_and]

/-- **The coordinate diagonal of L271's operator**: `A_ii` on the Cartan bivector of plane `i`, `½(U_ij + V_ij)` on
every coordinate bivector joining planes `i ≠ j`. -/
theorem torus_diag (A U V : Matrix (Fin m) (Fin m) ℝ) (hU : Uᵀ = U) (hV : Vᵀ = V) (p q : Fin m × Fin 2) :
    inner2 (torusOp A U V ⟨phi p q, phi_mem_skewSub p q⟩).1 (phi p q)
      = if p.1 = q.1 then (if p.2 = q.2 then 0 else A p.1 p.1) else (1 / 2) * (U p.1 q.1 + V p.1 q.1) := by
  have hUs : ∀ x y, U y x = U x y := fun x y => by rw [← Matrix.transpose_apply U x y, hU]
  have hVs : ∀ x y, V y x = V x y := fun x y => by rw [← Matrix.transpose_apply V x y, hV]
  show inner2 (skewPartM (torusMat A U V (phi p q))) (phi p q) = _
  rw [inner2_skewPartM _ _ (phi_mem_skewSub p q), inner2_phi_r]
  obtain ⟨i, s⟩ := p
  obtain ⟨j, t⟩ := q
  by_cases hij : i = j
  · subst hij
    fin_cases s <;> fin_cases t <;>
      simp [torusMat, phi, Matrix.single_apply, J2_00, J2_01, J2_10, J2_11, Finset.sum_ite_eq, Finset.sum_ite_eq'] <;> ring
  · fin_cases s <;> fin_cases t <;>
      simp [torusMat, hij, Ne.symm hij, phi, Matrix.single_apply, blk, cPart_00, cPart_01, cPart_10, cPart_11,
        aPart_00, aPart_01, aPart_10, aPart_11, hUs j i, hVs j i] <;> ring

/-- `F(S, E, S)` summed out: `∑_i w_i² A_ii + wᵀ P w`. -/
theorem SES_value (A U V : Matrix (Fin m) (Fin m) ℝ) (w : Fin m → ℝ) (hU : IsPairWeights U) (hV : IsPairWeights V) :
    (1 / 2 : ℝ) * ∑ p : Fin m × Fin 2, ∑ q : Fin m × Fin 2, w p.1 * w q.1
        * (if p.1 = q.1 then (if p.2 = q.2 then 0 else A p.1 p.1) else (1 / 2) * (U p.1 q.1 + V p.1 q.1))
      = ∑ i, w i ^ 2 * A i i + ∑ i, ∑ j, w i * (U + V) i j * w j := by
  set F : Fin m × Fin 2 → Fin m × Fin 2 → ℝ := fun p q => w p.1 * w q.1
    * (if p.1 = q.1 then (if p.2 = q.2 then 0 else A p.1 p.1) else (1 / 2) * (U p.1 q.1 + V p.1 q.1)) with hF
  have hre : ∑ p, ∑ q, F p q = ∑ i, ∑ j, ∑ s : Fin 2, ∑ t : Fin 2, F (i, s) (j, t) := by
    rw [Fintype.sum_prod_type]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [Finset.sum_comm]
    simp only [Fintype.sum_prod_type]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [Finset.sum_comm]
  have key : ∀ i j : Fin m, ∑ s : Fin 2, ∑ t : Fin 2, F (i, s) (j, t)
      = 2 * ((if i = j then w i ^ 2 * A i i else 0) + w i * (U + V) i j * w j) := fun i j => by
    simp only [hF, Fin.sum_univ_two]
    by_cases h : i = j
    · subst h; simp [hU.2 i, hV.2 i]; ring
    · simp [h]; ring
  rw [hre, Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => key i j]
  simp only [← Finset.mul_sum, Finset.sum_add_distrib, Finset.sum_ite_eq, Finset.mem_univ, if_true]
  ring

theorem inner2_phi_self' {κ : Type*} [Fintype κ] [DecidableEq κ] (i j : κ) :
    inner2 (phi i j) (phi i j) = if i = j then 0 else 1 := by
  rw [inner2_phi_r]
  by_cases h : i = j
  · subst h; simp [phi]
  · simp [phi, Matrix.single_apply, h, Ne.symm h]; ring

theorem inner2_old_new {κ : Type*} [Fintype κ] [DecidableEq κ] {X Y : Matrix (Option κ) (Option κ) ℝ}
    (hX : IsOld X) (hY : IsNew Y) : inner2 X Y = 0 := by
  rw [inner2_eq_sum]
  simp [Fintype.sum_option, (hX _).1, (hX _).2, hY.1, hY.2]

theorem innerOp2_ext_short (T : CurvOp2 (Fin m × Fin 2)) (w : Fin m → ℝ) :
    innerOp2 (extOp T) (shortOp w) = 0 := by
  unfold innerOp2
  simp [inner2_old_new (extOp_old T _) (shortOp_new w _)]

theorem normSq2_ext (R : CurvOp2 ι) : normSq2 (extOp R) = normSq2 R := by
  unfold normSq2 innerOp2
  congr 1
  let T : Option ι → Option ι → ℝ := fun i j =>
    inner2 (extOp R ⟨phi i j, phi_mem_skewSub i j⟩).1 (extOp R ⟨phi i j, phi_mem_skewSub i j⟩).1
  show ∑ i, ∑ j, T i j = _
  have h1 : ∀ j, T none j = 0 := fun j => by
    simp only [T, extOp_apply, restrictL_phi_none_l, map_zero, Submodule.coe_zero, inner2, Matrix.transpose_zero,
      Matrix.zero_mul, Matrix.trace_zero, mul_zero]
  have h2 : ∀ p, T (some p) none = 0 := fun p => by
    simp only [T, extOp_apply, restrictL_phi_none_r, map_zero, Submodule.coe_zero, inner2, Matrix.transpose_zero,
      Matrix.zero_mul, Matrix.trace_zero, mul_zero]
  have h3 : ∀ p q, T (some p) (some q) = inner2 (R ⟨phi p q, phi_mem_skewSub p q⟩).1 (R ⟨phi p q, phi_mem_skewSub p q⟩).1 :=
    fun p q => by
      simp only [T, extOp_apply, restrictL_phi]
      exact inner2_embedM _ _
  simp only [Fintype.sum_option, h1, h2, h3, Finset.sum_const_zero, zero_add]

theorem normSq2_short (w : Fin m → ℝ) : normSq2 (shortOp w) = 2 * ∑ i, w i ^ 2 := by
  unfold normSq2 innerOp2
  simp only [applyPhi, shortOp_phi, Submodule.coe_smul, i2_smul_l, i2_smul_r, inner2_phi_self']
  simp [Fintype.sum_option, shortW, Fintype.sum_prod_type, Fin.sum_univ_two]
  rw [← Finset.sum_add_distrib, Finset.mul_sum, Finset.mul_sum]
  exact Finset.sum_congr rfl fun i _ => by ring

/-- **The odd L271, the norm.** -/
theorem L280_norm (A U V : Matrix (Fin m) (Fin m) ℝ) (w : Fin m → ℝ) (hU : IsPairWeights U) (hV : IsPairWeights V) :
    normSq2 (torusOpOdd A U V w)
      = (∑ i, ∑ j, A i j ^ 2) + (∑ i, ∑ j, U i j ^ 2) + (∑ i, ∑ j, V i j ^ 2) + 2 * ∑ i, w i ^ 2 := by
  unfold torusOpOdd
  have h1 : normSq2 (extOp (torusOp A U V) + shortOp w)
      = normSq2 (extOp (torusOp A U V)) + 2 * innerOp2 (extOp (torusOp A U V)) (shortOp w) + normSq2 (shortOp w) := by
    unfold normSq2
    rw [innerOp2_add_left, innerOp2_add_right, innerOp2_add_right, innerOp2_comm (shortOp w) (extOp (torusOp A U V))]
    ring
  rw [h1, innerOp2_ext_short, normSq2_ext, normSq2_short, L271_norm A U V hU hV]
  have h2 : (1 / 2 : ℝ) * (∑ i, ∑ j, (U + V) i j ^ 2) + (1 / 2) * (∑ i, ∑ j, (U - V) i j ^ 2)
      = (∑ i, ∑ j, U i j ^ 2) + (∑ i, ∑ j, V i j ^ 2) := by
    simp only [Finset.mul_sum, ← Finset.sum_add_distrib]
    exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by
      simp only [Matrix.add_apply, Matrix.sub_apply]; ring
  linarith

/-- **The odd L271, the cubic.** -/
theorem L280_F (A U V : Matrix (Fin m) (Fin m) ℝ) (w : Fin m → ℝ) (hA : Aᵀ = A) (hU : IsPairWeights U)
    (hV : IsPairWeights V) :
    Ftri (torusOpOdd A U V w) (torusOpOdd A U V w) (torusOpOdd A U V w)
      = 3 * ∑ i, A i i * (dvec U V i + w i ^ 2) - 3 * (∑ i, ∑ j, if i = j then 0 else A i j * (U + V) i j * (U - V) i j)
        + (1 / 2) * Matrix.trace ((U + V) * (U + V) * (U + V)) + (1 / 2) * Matrix.trace ((U - V) * (U - V) * (U - V))
        + 3 * ∑ i, ∑ j, w i * (U + V) i j * w j := by
  rw [Ftri_odd_split, Ftri_ext, Ftri_torus A U V hA hU hV, Ftri_SES]
  simp only [torus_diag A U V hU.1 hV.1]
  rw [SES_value A U V w hU hV]
  have h : ∑ i, A i i * (dvec U V i + w i ^ 2) = ∑ i, A i i * dvec U V i + ∑ i, w i ^ 2 * A i i := by
    rw [← Finset.sum_add_distrib]; exact Finset.sum_congr rfl fun i _ => by ring
  rw [h]; ring

/-! ## H on the odd slice: the one-variable step -/

/-- **The odd tangency, in closed form**: `κ²(x + y)³ - y(c₀y + 9x/(4λ))² = (2m-1)²(2mx - y)²(8mx + (6m-1)y) /
(32m⁴(2m+1))`, so `√y (c₀ y + 9x/(4λ)) ≤ κ √(x + y)³` for `x ≥ 0`, `y > 0`. -/
theorem odd_scalar (M x y : ℝ) (hM : 7 ≤ M) (hx : 0 ≤ x) (hy : 0 < y) :
    Real.sqrt y * (Real.sqrt 2 * (2 * M - 1) * (4 * M - 1) / (8 * M ^ 2) * y
        + 9 * x / (4 * (3 * Real.sqrt 2 * M / (2 * (2 * M - 1)))))
      ≤ (2 * M - 1) / Real.sqrt (M * (2 * M + 1)) * Real.sqrt (x + y) ^ 3 := by
  set s := Real.sqrt 2 with hs
  have hs2 : s ^ 2 = 2 := Real.sq_sqrt (by norm_num)
  have hs0 : 0 < s := Real.sqrt_pos.2 (by norm_num)
  have hM0 : 0 < M := by linarith
  have hM1 : 0 < 2 * M - 1 := by linarith
  have hk : 0 < M * (2 * M + 1) := by positivity
  set k := Real.sqrt (M * (2 * M + 1)) with hkd
  have hk2 : k ^ 2 = M * (2 * M + 1) := Real.sq_sqrt hk.le
  have hk0 : 0 < k := Real.sqrt_pos.2 hk
  have hbeta : 9 * x / (4 * (3 * s * M / (2 * (2 * M - 1)))) = s * (3 * (2 * M - 1) / (4 * M)) * x := by
    field_simp
    linear_combination (9 * x - 18 * x * M) * hs2
  rw [hbeta]
  have hsy : Real.sqrt y ^ 2 = y := Real.sq_sqrt hy.le
  have hsxy : Real.sqrt (x + y) ^ 2 = x + y := Real.sq_sqrt (by linarith)
  have hL0 : 0 ≤ Real.sqrt y * (s * (2 * M - 1) * (4 * M - 1) / (8 * M ^ 2) * y + s * (3 * (2 * M - 1) / (4 * M)) * x) := by
    apply mul_nonneg (Real.sqrt_nonneg _)
    apply add_nonneg
    · exact mul_nonneg (div_nonneg (mul_nonneg (mul_nonneg hs0.le hM1.le) (by linarith)) (by positivity)) hy.le
    · exact mul_nonneg (mul_nonneg hs0.le (div_nonneg (by linarith) (by positivity))) hx
  have hR0 : 0 ≤ (2 * M - 1) / k * Real.sqrt (x + y) ^ 3 :=
    mul_nonneg (div_nonneg hM1.le hk0.le) (pow_nonneg (Real.sqrt_nonneg _) 3)
  -- compare squares
  have hsq : (Real.sqrt y * (s * (2 * M - 1) * (4 * M - 1) / (8 * M ^ 2) * y + s * (3 * (2 * M - 1) / (4 * M)) * x)) ^ 2
      ≤ ((2 * M - 1) / k * Real.sqrt (x + y) ^ 3) ^ 2 := by
    have e1 : (Real.sqrt y * (s * (2 * M - 1) * (4 * M - 1) / (8 * M ^ 2) * y + s * (3 * (2 * M - 1) / (4 * M)) * x)) ^ 2
        = 2 * y * ((2 * M - 1) * (4 * M - 1) / (8 * M ^ 2) * y + 3 * (2 * M - 1) / (4 * M) * x) ^ 2 := by
      have : (Real.sqrt y * (s * (2 * M - 1) * (4 * M - 1) / (8 * M ^ 2) * y + s * (3 * (2 * M - 1) / (4 * M)) * x)) ^ 2
          = Real.sqrt y ^ 2 * s ^ 2 * ((2 * M - 1) * (4 * M - 1) / (8 * M ^ 2) * y + 3 * (2 * M - 1) / (4 * M) * x) ^ 2 := by
        ring
      rw [this, hsy, hs2]; ring
    have e2 : ((2 * M - 1) / k * Real.sqrt (x + y) ^ 3) ^ 2 = (2 * M - 1) ^ 2 / (M * (2 * M + 1)) * (x + y) ^ 3 := by
      have : ((2 * M - 1) / k * Real.sqrt (x + y) ^ 3) ^ 2 = (2 * M - 1) ^ 2 / k ^ 2 * (Real.sqrt (x + y) ^ 2) ^ 3 := by
        ring
      rw [this, hk2, hsxy]
    have key : (2 * M - 1) ^ 2 / (M * (2 * M + 1)) * (x + y) ^ 3
        - 2 * y * ((2 * M - 1) * (4 * M - 1) / (8 * M ^ 2) * y + 3 * (2 * M - 1) / (4 * M) * x) ^ 2
        = (2 * M - 1) ^ 2 * (2 * M * x - y) ^ 2 * (8 * M * x + (6 * M - 1) * y) / (32 * M ^ 4 * (2 * M + 1)) := by
      field_simp
      ring
    have hpos : 0 ≤ (2 * M - 1) ^ 2 * (2 * M * x - y) ^ 2 * (8 * M * x + (6 * M - 1) * y) / (32 * M ^ 4 * (2 * M + 1)) := by
      apply div_nonneg
      · apply mul_nonneg (mul_nonneg (sq_nonneg _) (sq_nonneg _))
        nlinarith
      · positivity
    rw [e1, e2]; linarith
  have := Real.sqrt_le_sqrt hsq
  rwa [Real.sqrt_sq hL0, Real.sqrt_sq hR0] at this

/-- Matrix Cauchy–Schwarz, `∑ A_ij B_ij ≤ ‖A‖ ‖B‖`. -/
theorem mat_cs {k : ℕ} (A B : Matrix (Fin k) (Fin k) ℝ) :
    ∑ i, ∑ j, A i j * B i j ≤ Real.sqrt (∑ i, ∑ j, A i j ^ 2) * Real.sqrt (∑ i, ∑ j, B i j ^ 2) := by
  have hsum : ∀ F : Fin k → Fin k → ℝ, ∑ i, ∑ j, F i j = ∑ p : Fin k × Fin k, F p.1 p.2 :=
    fun F => (Fintype.sum_prod_type' F).symm
  rw [hsum (fun i j => A i j * B i j), hsum (fun i j => A i j ^ 2), hsum (fun i j => B i j ^ 2)]
  exact Real.sum_mul_le_sqrt_mul_sqrt _ _ _

/-- **H on the torus slice of `𝔰𝔬(2m + 1)`, `m ≥ 7`.** -/
theorem H_torus_slice_odd (n : ℕ) (hn : 6 ≤ n) (A U V : Matrix (Fin (n + 1)) (Fin (n + 1)) ℝ) (w : Fin (n + 1) → ℝ)
    (hA : Aᵀ = A) (hU : IsPairWeights U) (hV : IsPairWeights V) :
    Ftri (torusOpOdd A U V w) (torusOpOdd A U V w) (torusOpOdd A U V w)
      ≤ (2 * ((n : ℝ) + 1) - 1) / Real.sqrt (((n : ℝ) + 1) * (2 * ((n : ℝ) + 1) + 1))
        * (normSq2 (torusOpOdd A U V w)) ^ ((3 : ℝ) / 2) := by
  have hM7 : (7 : ℝ) ≤ (n : ℝ) + 1 := by
    have : (6 : ℝ) ≤ n := by exact_mod_cast hn
    linarith
  set M : ℝ := (n : ℝ) + 1 with hMd
  set r := Real.sqrt 2 with hr
  have hr0 : 0 < r := Real.sqrt_pos.2 (by norm_num)
  set lam := 3 * r * M / (2 * (2 * M - 1)) with hlam
  have hlam0 : 0 < lam := by rw [hlam]; apply div_pos (by positivity) (by linarith)
  set c0 := r * (2 * M - 1) * (4 * M - 1) / (8 * M ^ 2) with hc0
  set κ := (2 * M - 1) / Real.sqrt (M * (2 * M + 1)) with hκ
  have hκ0 : 0 ≤ κ := div_nonneg (by linarith) (Real.sqrt_nonneg _)
  obtain ⟨SA, hSA⟩ : ∃ x, x = ∑ i, ∑ j, A i j ^ 2 := ⟨_, rfl⟩
  obtain ⟨b2, hb2⟩ : ∃ x, x = ∑ i, ∑ j, U i j ^ 2 + ∑ i, ∑ j, V i j ^ 2 + 2 * ∑ i, w i ^ 2 := ⟨_, rfl⟩
  obtain ⟨G2, hG2⟩ : ∃ x, x = ∑ i, (dvec U V i + w i ^ 2) ^ 2
      + ∑ i, ∑ j, (if i = j then 0 else ((U + V) i j * (U - V) i j) ^ 2) := ⟨_, rfl⟩
  obtain ⟨T, hT⟩ : ∃ x, x = (1 / 2 : ℝ) * (Matrix.trace ((U + V) * (U + V) * (U + V))
      + Matrix.trace ((U - V) * (U - V) * (U - V))) + 3 * ∑ i, ∑ j, w i * (U + V) i j * w j := ⟨_, rfl⟩
  set Amo : Matrix (Fin (n + 1)) (Fin (n + 1)) ℝ := fun i j =>
    if i = j then dvec U V i + w i ^ 2 else -((U + V) i j * (U - V) i j) with hAmo
  have hSA0 : 0 ≤ SA := by rw [hSA]; positivity
  have hb20 : 0 ≤ b2 := by rw [hb2]; positivity
  have hG20 : 0 ≤ G2 := by
    rw [hG2]; apply add_nonneg (by positivity)
    exact Finset.sum_nonneg fun i _ => Finset.sum_nonneg fun j _ => by split_ifs <;> positivity
  -- the cubic form: `F = 3 ⟨A, A_μ⟩ + T`
  have hF : Ftri (torusOpOdd A U V w) (torusOpOdd A U V w) (torusOpOdd A U V w)
      = 3 * ∑ i, ∑ j, A i j * Amo i j + T := by
    rw [L280_F A U V w hA hU hV, hT]
    have hpt : ∀ i j, A i j * Amo i j = (if i = j then A i i * (dvec U V i + w i ^ 2) else 0)
        - (if i = j then 0 else A i j * (U + V) i j * (U - V) i j) := fun i j => by
      by_cases h : i = j
      · subst h; simp [hAmo]
      · simp only [hAmo, if_neg h, sub_zero, zero_sub]; ring
    simp only [hpt, Finset.sum_sub_distrib, Finset.sum_ite_eq, Finset.mem_univ, if_true]
    ring
  have hGe : G2 = ∑ i, ∑ j, Amo i j ^ 2 := by
    rw [hG2]
    have hpt : ∀ i j, Amo i j ^ 2 = (if i = j then (dvec U V i + w i ^ 2) ^ 2 else 0)
        + (if i = j then 0 else ((U + V) i j * (U - V) i j) ^ 2) := fun i j => by
      by_cases h : i = j
      · subst h; simp [hAmo]
      · simp only [hAmo, if_neg h, zero_add, neg_sq]
    simp only [hpt, Finset.sum_add_distrib, Finset.sum_ite_eq, Finset.mem_univ, if_true]
  have hX : ∑ i, ∑ j, A i j * Amo i j ≤ Real.sqrt SA * Real.sqrt G2 := by
    rw [hSA, hGe]; exact mat_cs A Amo
  have hN : normSq2 (torusOpOdd A U V w) = SA + b2 := by
    rw [L280_norm A U V w hU hV, hSA, hb2]; ring
  have hpow : (SA + b2) ^ ((3 : ℝ) / 2) = Real.sqrt (SA + b2) ^ 3 := by
    rw [Real.sqrt_eq_rpow, ← Real.rpow_natCast, ← Real.rpow_mul (by linarith)]; norm_num
  rw [hF, hN, hpow]
  rcases eq_or_lt_of_le hb20 with hb0 | hbpos
  · -- no root part
    have z1 : ∑ i, ∑ j, U i j ^ 2 = 0 := by
      have := Finset.sum_nonneg fun i (_ : i ∈ Finset.univ) => Finset.sum_nonneg fun j (_ : j ∈ Finset.univ) => sq_nonneg (V i j)
      have := Finset.sum_nonneg fun i (_ : i ∈ Finset.univ) => sq_nonneg (w i)
      have := Finset.sum_nonneg fun i (_ : i ∈ Finset.univ) => Finset.sum_nonneg fun j (_ : j ∈ Finset.univ) => sq_nonneg (U i j)
      linarith
    have z2 : ∑ i, ∑ j, V i j ^ 2 = 0 := by
      have := Finset.sum_nonneg fun i (_ : i ∈ Finset.univ) => Finset.sum_nonneg fun j (_ : j ∈ Finset.univ) => sq_nonneg (V i j)
      have := Finset.sum_nonneg fun i (_ : i ∈ Finset.univ) => sq_nonneg (w i)
      linarith
    have z3 : ∑ i, w i ^ 2 = 0 := by
      have := Finset.sum_nonneg fun i (_ : i ∈ Finset.univ) => sq_nonneg (w i)
      linarith
    have ez : ∀ (F : Fin (n + 1) → Fin (n + 1) → ℝ), ∑ i, ∑ j, F i j ^ 2 = 0 → ∀ i j, F i j = 0 := fun F h i j => by
      have e1 := (Finset.sum_eq_zero_iff_of_nonneg (fun i _ => Finset.sum_nonneg fun j _ => sq_nonneg (F i j))).mp h i
        (Finset.mem_univ i)
      have f1 := (Finset.sum_eq_zero_iff_of_nonneg (fun j _ => sq_nonneg (F i j))).mp e1 j (Finset.mem_univ j)
      exact pow_eq_zero_iff (n := 2) (by norm_num) |>.mp f1
    have hU0 : U = 0 := by ext i j; exact ez (fun i j => U i j) z1 i j
    have hV0 : V = 0 := by ext i j; exact ez (fun i j => V i j) z2 i j
    have hw0 : ∀ i, w i = 0 := fun i => by
      have := (Finset.sum_eq_zero_iff_of_nonneg (fun i _ => sq_nonneg (w i))).mp z3 i (Finset.mem_univ i)
      exact pow_eq_zero_iff (n := 2) (by norm_num) |>.mp this
    have hT0 : T = 0 := by rw [hT, hU0, hV0]; simp [hw0]
    have hA0 : ∀ i j, Amo i j = 0 := fun i j => by
      simp only [hAmo, hU0, hV0]; split_ifs <;> simp [dvec, hw0]
    simp only [hA0, mul_zero, Finset.sum_const_zero, hT0, add_zero]
    positivity
  · -- rescale the root weights to the unit sphere
    obtain ⟨b, hbdef⟩ : ∃ x, x = Real.sqrt b2 := ⟨_, rfl⟩
    have hb : 0 < b := by rw [hbdef]; exact Real.sqrt_pos.mpr hbpos
    have hbb : b ^ 2 = b2 := by rw [hbdef]; exact Real.sq_sqrt hb20
    set c := 1 / b with hc
    have hcb : c * b = 1 := by rw [hc]; field_simp
    have hU' : IsPairWeights (c • U) := ⟨by rw [Matrix.transpose_smul, hU.1], fun i => by simp [hU.2 i]⟩
    have hV' : IsPairWeights (c • V) := ⟨by rw [Matrix.transpose_smul, hV.1], fun i => by simp [hV.2 i]⟩
    have hunit : ∑ i, ∑ j, (c • U) i j ^ 2 + ∑ i, ∑ j, (c • V) i j ^ 2 + 2 * ∑ i, (fun i => c * w i) i ^ 2 = 1 := by
      simp only [Matrix.smul_apply, smul_eq_mul, mul_pow, ← Finset.mul_sum]
      have : c ^ 2 * b2 = 1 := by rw [← hbb, ← mul_pow, hcb, one_pow]
      rw [hb2] at this; linarith
    have hJ := HamiltonsCubic.OddJ1.J1odd_holds n hn (c • U) (c • V) (fun i => c * w i) hU' hV' hunit
    have hsP : c • U + c • V = c • (U + V) := (smul_add c U V).symm
    have hsQ : c • U - c • V = c • (U - V) := (smul_sub c U V).symm
    rw [hsP, hsQ, trace_cube_smul, trace_cube_smul] at hJ
    have hd : ∀ i, dvec (c • U) (c • V) i = c ^ 2 * dvec U V i := fun i => by
      simp only [dvec, Matrix.smul_apply, smul_eq_mul, Finset.mul_sum]
      exact Finset.sum_congr rfl fun l _ => by ring
    simp only [hd, Matrix.smul_apply, smul_eq_mul] at hJ
    have hTc : (1 / 2 : ℝ) * (c ^ 3 * Matrix.trace ((U + V) * (U + V) * (U + V)) + c ^ 3 * Matrix.trace ((U - V) * (U - V) * (U - V)))
        + 3 * ∑ i, ∑ j, c * w i * (c * (U + V) i j) * (c * w j) = c ^ 3 * T := by
      have e : ∑ i, ∑ j, c * w i * (c * (U + V) i j) * (c * w j) = c ^ 3 * ∑ i, ∑ j, w i * (U + V) i j * w j := by
        rw [Finset.mul_sum]
        exact Finset.sum_congr rfl fun i _ => by rw [Finset.mul_sum]; exact Finset.sum_congr rfl fun j _ => by ring
      rw [hT, e]; ring
    have hGc : ∑ i, (c ^ 2 * dvec U V i + (c * w i) ^ 2) ^ 2
        + ∑ i, ∑ j, (if i = j then (0 : ℝ) else (c * (U + V) i j * (c * (U - V) i j)) ^ 2) = c ^ 4 * G2 := by
      rw [hG2, mul_add, Finset.mul_sum, Finset.mul_sum]
      congr 1
      · exact Finset.sum_congr rfl fun i _ => by ring
      · refine Finset.sum_congr rfl fun i _ => ?_
        rw [Finset.mul_sum]
        exact Finset.sum_congr rfl fun j _ => by split_ifs <;> ring
    rw [hTc, hGc] at hJ
    -- `T ≤ c₀ b³ - λ G/b`
    have hTb : T ≤ c0 * b ^ 3 - lam * G2 / b := by
      have hb3 : 0 < b ^ 3 := by positivity
      have e : T = b ^ 3 * (c ^ 3 * T) := by rw [← mul_assoc, ← mul_pow, mul_comm b c, hcb, one_pow, one_mul]
      have e2 : lam * G2 / b = b ^ 3 * (lam * (c ^ 4 * G2)) := by rw [hc]; field_simp
      rw [e, e2]
      nlinarith [mul_le_mul_of_nonneg_left hJ hb3.le]
    -- AM-GM in `g = √G2`
    set sa := Real.sqrt SA with hsad
    set sg := Real.sqrt G2 with hsgd
    have hsA : sa ^ 2 = SA := Real.sq_sqrt hSA0
    have hsG : sg ^ 2 = G2 := Real.sq_sqrt hG20
    have hamgm : 3 * sa * sg - lam * G2 / b ≤ 9 * SA * b / (4 * lam) := by
      have key : 9 * SA * b / (4 * lam) - (3 * sa * sg - lam * G2 / b)
          = lam / b * (sg - 3 * b * sa / (2 * lam)) ^ 2 := by
        rw [← hsA, ← hsG]; field_simp; ring
      have : 0 ≤ lam / b * (sg - 3 * b * sa / (2 * lam)) ^ 2 := by positivity
      linarith
    -- the closed-form tangency
    have hsc := odd_scalar M SA b2 hM7 hSA0 hbpos
    have hbeq : Real.sqrt b2 * (c0 * b2 + 9 * SA / (4 * lam)) = c0 * b ^ 3 + 9 * SA * b / (4 * lam) := by
      rw [← hbdef, ← hbb]; ring
    rw [hbeq] at hsc
    linarith [hX, hTb, hamgm, hsc]

end HamiltonsCubic.OddTorus
