import Mathlib
import HamiltonsCubic.Results.FirstVariation
import HamiltonsCubic.Results.CubicBridge
import HamiltonsCubic.Results.I117LemmaF
import HamiltonsCubic.Results.WeylMaximiser
import HamiltonsCubic.Results.L254
import HamiltonsCubic.Results.FrameExtension

set_option linter.style.longLine false

/-!
# I117's results L260 to L273, stated over the layer's own objects on `𝔰𝔬(n)`

[findings/second-order.md](../../../findings/second-order.md), Lemmas L260 to L273. **Each result's own statement is
typed here over the layer's Hamilton product on `Λ² = 𝔰𝔬(n)`**: `sharpMapCL R = R # R`
([Bivectors2.lean](../Base/Bivectors2.lean)), the trilinear form `phiTri` with
`⟨S, R # R⟩ = -½ Φ(S; R, R)` (`innerOp2_sharpMap_eq_phiTri`, [PhiTri.lean](PhiTri.lean)), the pairing `innerOp2`,
and `I # I = (n - 2) I` (`sharpMap_id`, [CubicBridge.lean](CubicBridge.lean)). *A result stated in the record for a
general compact simple `𝔥` is typed here at `𝔥 = 𝔰𝔬(n)`, the case the programme applies; the Lie-algebra-level
product for a general `𝔥` is not in the layer and is scheduled as an item.* **Where a proof stalls the gap is a
named `sorry`**, and [lean/INDEX.md](../../INDEX.md) says which.

`Ftri A B C = -½ Φ(A; B, C)` is the record's `F(A, B, C) = ⟨A # B, C⟩` (`Ftri_idem`, `Ftri_id` pin the
normalisation), fully symmetric on self-adjoint arguments (`Ftri_symm12`, `Ftri_symm23`).
-/

namespace HamiltonsCubic.I117S

open HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge Matrix Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The identity of `Λ² = 𝔰𝔬(n)`, the record's `I`. -/
noncomputable abbrev idOp : CurvOp2 ι := ContinuousLinearMap.id ℝ (skewSub ι)

/-- The record's `F(A, B, C) = ⟨A # B, C⟩`, read through the layer as `-½ Φ(A; B, C)`. -/
noncomputable def Ftri (A B C : CurvOp2 ι) : ℝ := -(1 / 2) * phiTri A B C

/-- `C # C = C`. -/
def IsIdem (C : CurvOp2 ι) : Prop := sharpMapCL C = C

/-- Stability in the sense of L264: `⟨C # H, H⟩ ≤ ½ ‖H‖²` for every self-adjoint `H ⊥ C`. -/
def IsStable (C : CurvOp2 ι) : Prop :=
  ∀ H : CurvOp2 ι, IsSelfAdjoint2 H → innerOp2 H C = 0 → Ftri C H H ≤ (1 / 2) * normSq2 H

/-- Positive semidefinite on `Λ²`. -/
def IsPSD2 (C : CurvOp2 ι) : Prop :=
  ∀ X : skewSub ι, 0 ≤ inner2 ((C X : skewSub ι) : Matrix ι ι ℝ) ((X : skewSub ι) : Matrix ι ι ℝ)

/-- Positive definite on `Λ²`. -/
def IsPD2 (C : CurvOp2 ι) : Prop :=
  ∀ X : skewSub ι, X ≠ 0 → 0 < inner2 ((C X : skewSub ι) : Matrix ι ι ℝ) ((X : skewSub ι) : Matrix ι ι ℝ)

theorem idOp_isSelfAdjoint2 : IsSelfAdjoint2 (idOp : CurvOp2 ι) := fun _ _ => rfl

/-- **The normalisation anchor**: `I # I = (n - 2) I` as operators. -/
theorem sharpMapCL_id : sharpMapCL (idOp : CurvOp2 ι) = ((Fintype.card ι : ℝ) - 2) • idOp := by
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  rw [sharpMapCL_apply, sharpMap_id]
  rfl

theorem Ftri_symm12 {A B C : CurvOp2 ι} (hC : IsSelfAdjoint2 C) : Ftri A B C = Ftri B A C := by
  unfold Ftri
  rw [phiTri_swap_outer A B C, phiTri_rotate hC B A]

theorem Ftri_symm23 {A : CurvOp2 ι} (hA : IsSelfAdjoint2 A) (B C : CurvOp2 ι) : Ftri A B C = Ftri A C B := by
  unfold Ftri
  rw [phiTri_rotate hA B C, phiTri_swap_outer B C A]

/-- **`F(C, C, Y) = ⟨C # C, Y⟩`**, so at an idempotent it is `⟨C, Y⟩`. -/
theorem Ftri_sharp (C Y : CurvOp2 ι) : Ftri C C Y = innerOp2 Y (sharpMapCL C) := by
  unfold Ftri
  rw [innerOp2_sharpMap_eq_phiTri C Y, phiTri_swap_outer Y C C]

theorem Ftri_idem {C : CurvOp2 ι} (hC : IsIdem C) (Y : CurvOp2 ι) : Ftri C C Y = innerOp2 Y C := by
  rw [Ftri_sharp, hC]

/-- **`F(C, I, I) = ⟨C, I # I⟩ = (n - 2) ⟨C, I⟩`.** -/
theorem Ftri_id (C : CurvOp2 ι) :
    Ftri C idOp idOp = ((Fintype.card ι : ℝ) - 2) * innerOp2 C idOp := by
  unfold Ftri
  rw [← innerOp2_sharpMap_eq_phiTri idOp C, sharpMapCL_id, innerOp2_smul_right]

theorem Ftri_add_mid (A B B' C : CurvOp2 ι) : Ftri A (B + B') C = Ftri A B C + Ftri A B' C := by
  unfold Ftri; rw [phiTri_add_mid]; ring

theorem Ftri_add_right (A B C C' : CurvOp2 ι) : Ftri A B (C + C') = Ftri A B C + Ftri A B C' := by
  unfold Ftri; rw [phiTri_add_right]; ring

theorem Ftri_smul_mid (c : ℝ) (A B C : CurvOp2 ι) : Ftri A (c • B) C = c * Ftri A B C := by
  unfold Ftri; rw [phiTri_smul_mid]; ring

theorem Ftri_smul_right (c : ℝ) (A B C : CurvOp2 ι) : Ftri A B (c • C) = c * Ftri A B C := by
  unfold Ftri; rw [phiTri_smul_right]; ring

/-- **L270 (1)–(2) on `𝔰𝔬(n)`, the operator statement.** For a self-adjoint `#`-idempotent `C` with `q = ‖C‖² > 0`,
`τ = ⟨I, C⟩` and `d = ‖I‖²`, the projection `H = I - (τ/q) C` is orthogonal to `C`, has
`⟨C # H, H⟩ = (n - 2) τ - τ²/q` and `‖H‖² = d - τ²/q`, and `2⟨C # H, H⟩ > ‖H‖²` exactly when
`q (2 (n - 2) τ - d) > τ²`; that condition forces `q (n - 2)² > d` (`idir_heavy`), so the direction `I`
destabilises only idempotents heavier than `I / (n - 2)`. -/
theorem L270_so (C : CurvOp2 ι) (hC : IsSelfAdjoint2 C) (hidem : IsIdem C) (hq : 0 < normSq2 C) :
    let τ := innerOp2 idOp C
    let q := normSq2 C
    let d := normSq2 (idOp : CurvOp2 ι)
    let c := (Fintype.card ι : ℝ) - 2
    let H := idOp + (-(τ / q)) • C
    innerOp2 H C = 0 ∧ Ftri C H H = c * τ - τ ^ 2 / q ∧ normSq2 H = d - τ ^ 2 / q ∧
      (2 * Ftri C H H > normSq2 H ↔ q * (2 * c * τ - d) > τ ^ 2) ∧
      (2 * Ftri C H H > normSq2 H → q * c ^ 2 > d ∨ c ≤ 0) := by
  intro τ q d c H
  have hq0 : q ≠ 0 := ne_of_gt hq
  have hCI : innerOp2 C idOp = τ := innerOp2_comm _ _
  have hCC : innerOp2 C C = q := rfl
  -- the four values of `F(C, ·, ·)` on `{I, C}`
  have f_II : Ftri C idOp idOp = c * τ := by rw [Ftri_id, hCI]
  have f_CI : Ftri C C idOp = τ := by rw [Ftri_idem hidem]
  have f_IC : Ftri C idOp C = τ := by rw [Ftri_symm23 hC, f_CI]
  have f_CC : Ftri C C C = q := by rw [Ftri_idem hidem]; rfl
  refine ⟨?_, ?_, ?_, ?_, ?_⟩
  · show innerOp2 (idOp + (-(τ / q)) • C) C = 0
    rw [innerOp2_add_left, innerOp2_smul_left, hCC]
    field_simp
    ring
  · show Ftri C (idOp + (-(τ / q)) • C) (idOp + (-(τ / q)) • C) = c * τ - τ ^ 2 / q
    rw [Ftri_add_mid, Ftri_add_right, Ftri_add_right, Ftri_smul_mid, Ftri_smul_mid, Ftri_smul_right,
      Ftri_smul_right, f_II, f_IC, f_CI, f_CC]
    field_simp
    ring
  · show innerOp2 (idOp + (-(τ / q)) • C) (idOp + (-(τ / q)) • C) = d - τ ^ 2 / q
    rw [innerOp2_add_left, innerOp2_add_right, innerOp2_add_right, innerOp2_smul_left, innerOp2_smul_left,
      innerOp2_smul_right, innerOp2_smul_right, hCI, hCC]
    have : innerOp2 (idOp : CurvOp2 ι) idOp = d := rfl
    rw [this]
    field_simp
    ring
  · have hB : Ftri C H H = c * τ - τ ^ 2 / q := by
      show Ftri C (idOp + (-(τ / q)) • C) (idOp + (-(τ / q)) • C) = _
      rw [Ftri_add_mid, Ftri_add_right, Ftri_add_right, Ftri_smul_mid, Ftri_smul_mid, Ftri_smul_right,
        Ftri_smul_right, f_II, f_IC, f_CI, f_CC]
      field_simp
      ring
    have hN : normSq2 H = d - τ ^ 2 / q := by
      show innerOp2 (idOp + (-(τ / q)) • C) (idOp + (-(τ / q)) • C) = _
      rw [innerOp2_add_left, innerOp2_add_right, innerOp2_add_right, innerOp2_smul_left, innerOp2_smul_left,
        innerOp2_smul_right, innerOp2_smul_right, hCI, hCC]
      have : innerOp2 (idOp : CurvOp2 ι) idOp = d := rfl
      rw [this]
      field_simp
      ring
    rw [hB, hN]
    set s := τ ^ 2 / q with hs
    have hsq : s * q = τ ^ 2 := by rw [hs]; field_simp
    constructor
    · intro h
      nlinarith [mul_pos hq (show 0 < 2 * c * τ - d - s by linarith)]
    · intro h
      by_contra hn
      push Not at hn
      nlinarith [mul_nonneg hq.le (show 0 ≤ -(2 * c * τ - d - s) by linarith)]
  · intro h
    have hB : Ftri C H H = c * τ - τ ^ 2 / q := by
      show Ftri C (idOp + (-(τ / q)) • C) (idOp + (-(τ / q)) • C) = _
      rw [Ftri_add_mid, Ftri_add_right, Ftri_add_right, Ftri_smul_mid, Ftri_smul_mid, Ftri_smul_right,
        Ftri_smul_right, f_II, f_IC, f_CI, f_CC]
      field_simp
      ring
    have hN : normSq2 H = d - τ ^ 2 / q := by
      show innerOp2 (idOp + (-(τ / q)) • C) (idOp + (-(τ / q)) • C) = _
      rw [innerOp2_add_left, innerOp2_add_right, innerOp2_add_right, innerOp2_smul_left, innerOp2_smul_left,
        innerOp2_smul_right, innerOp2_smul_right, hCI, hCC]
      have : innerOp2 (idOp : CurvOp2 ι) idOp = d := rfl
      rw [this]
      field_simp
      ring
    rw [hB, hN] at h
    have key : q * (2 * c * τ - d) > τ ^ 2 := by
      set s := τ ^ 2 / q with hs
      have hsq : s * q = τ ^ 2 := by rw [hs]; field_simp
      nlinarith [mul_pos hq (show 0 < 2 * c * τ - d - s by linarith)]
    by_cases hc : 0 < c
    · exact Or.inl (HamiltonsCubic.I117.idir_heavy c d τ q hc hq key)
    · exact Or.inr (not_lt.mp hc)

/-! ## The torus-invariant family of `𝔰𝔬(2m)` (L268, L269, L271 to L273)

`𝔰𝔬(2m)` is `skewSub (Fin m × Fin 2)`: coordinate `(i, a)` is the `a`-th vector of the `i`-th plane. A torus-invariant
operator acts on the Cartan (the `J`-blocks on the diagonal) by `A`, and on each off-diagonal `2 × 2` block by `U_ij`
on its `J`-commuting part (the root plane of `ε_i - ε_j`) and `V_ij` on its `J`-anticommuting part (`ε_i + ε_j`).
*Screened against the repository's own Hamilton product* ([curvature_operator.py](../../../scripts/lib/curvature_operator.py)):
at random `A, U, V` it reproduces L271 (1)'s `F` and norm to ten digits, it is an idempotent exactly at solutions of
L268's system, and exchanging `U` and `V` breaks idempotency.
-/

section Torus

variable {m : ℕ}

/-- The complex structure on one coordinate plane. -/
def J2 : Matrix (Fin 2) (Fin 2) ℝ := !![0, -1; 1, 0]

/-- The `(i, j)` block of a `2m × 2m` matrix. -/
def blk (X : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) (i j : Fin m) : Matrix (Fin 2) (Fin 2) ℝ :=
  fun a b => X (i, a) (j, b)

/-- The `J`-commuting part of a block, the root plane of `ε_i - ε_j`. -/
noncomputable def cPart (B : Matrix (Fin 2) (Fin 2) ℝ) : Matrix (Fin 2) (Fin 2) ℝ := (1 / 2 : ℝ) • (B - J2 * B * J2)

/-- The `J`-anticommuting part of a block, the root plane of `ε_i + ε_j`. -/
noncomputable def aPart (B : Matrix (Fin 2) (Fin 2) ℝ) : Matrix (Fin 2) (Fin 2) ℝ := (1 / 2 : ℝ) • (B + J2 * B * J2)

/-- The matrix the torus-invariant operator produces from `X`, before skew-symmetrisation. -/
noncomputable def torusMat (A U V : Matrix (Fin m) (Fin m) ℝ) (X : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) :
    Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ :=
  fun p r => if p.1 = r.1 then (∑ k, A p.1 k * X (k, 1) (k, 0)) * J2 p.2 r.2
    else U p.1 r.1 * cPart (blk X p.1 r.1) p.2 r.2 + V p.1 r.1 * aPart (blk X p.1 r.1) p.2 r.2

/-- The skew part of a matrix. -/
noncomputable def skewPartM {κ : Type*} [Fintype κ] [DecidableEq κ] (M : Matrix κ κ ℝ) : Matrix κ κ ℝ :=
  (1 / 2 : ℝ) • (M - Mᵀ)

theorem skewPartM_mem {κ : Type*} [Fintype κ] [DecidableEq κ] (M : Matrix κ κ ℝ) : skewPartM M ∈ skewSub κ := by
  show (skewPartM M)ᵀ = -(skewPartM M)
  unfold skewPartM
  rw [Matrix.transpose_smul, Matrix.transpose_sub, Matrix.transpose_transpose, ← smul_neg, neg_sub]

theorem torusMat_add (A U V : Matrix (Fin m) (Fin m) ℝ) (X Y : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) :
    torusMat A U V (X + Y) = torusMat A U V X + torusMat A U V Y := by
  ext p r
  simp only [torusMat, Matrix.add_apply]
  split_ifs with h
  · rw [← add_mul, ← Finset.sum_add_distrib]
    congr 1
    exact Finset.sum_congr rfl fun k _ => by ring
  · simp only [cPart, aPart, blk, Matrix.smul_apply, Matrix.sub_apply, Matrix.add_apply, Matrix.mul_apply,
      Fin.sum_univ_two, smul_eq_mul]
    ring

theorem torusMat_smul (A U V : Matrix (Fin m) (Fin m) ℝ) (c : ℝ) (X : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) :
    torusMat A U V (c • X) = c • torusMat A U V X := by
  ext p r
  simp only [torusMat, Matrix.smul_apply, smul_eq_mul]
  split_ifs with h
  · rw [show (∑ k, A p.1 k * (c * X (k, 1) (k, 0))) = c * ∑ k, A p.1 k * X (k, 1) (k, 0) by
      rw [Finset.mul_sum]; exact Finset.sum_congr rfl fun k _ => by ring]
    ring
  · simp only [cPart, aPart, blk, Matrix.smul_apply, Matrix.sub_apply, Matrix.add_apply, Matrix.mul_apply,
      Fin.sum_univ_two, smul_eq_mul]
    ring

/-- **The torus-invariant operator** `A ⊕ ⊕_α μ_α I_{R_α}` on `𝔰𝔬(2m)`, with `U_ij = μ_{ε_i - ε_j}` and
`V_ij = μ_{ε_i + ε_j}`. -/
noncomputable def torusOp (A U V : Matrix (Fin m) (Fin m) ℝ) : CurvOp2 (Fin m × Fin 2) :=
  LinearMap.toContinuousLinearMap
    { toFun := fun X => ⟨skewPartM (torusMat A U V (X : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ)), skewPartM_mem _⟩
      map_add' := fun X Y => by
        apply Subtype.ext
        show skewPartM (torusMat A U V ((X + Y : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ))
          = skewPartM (torusMat A U V (X : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ))
            + skewPartM (torusMat A U V (Y : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ))
        rw [Submodule.coe_add, torusMat_add]; unfold skewPartM; rw [Matrix.transpose_add]; module
      map_smul' := fun c X => by
        apply Subtype.ext
        show skewPartM (torusMat A U V ((c • X : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ))
          = c • skewPartM (torusMat A U V (X : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ))
        rw [Submodule.coe_smul, torusMat_smul]; unfold skewPartM; rw [Matrix.transpose_smul]; module }

/-- The Cartan block the idempotency forces: `A_μ = diag d - P ∘ Q` off the diagonal (L268, L271 (2)). -/
noncomputable def Amu (U V : Matrix (Fin m) (Fin m) ℝ) : Matrix (Fin m) (Fin m) ℝ :=
  fun i j => if i = j then ∑ l, (U i l ^ 2 + V i l ^ 2) else V i j ^ 2 - U i j ^ 2

/-- `d_i = ∑_l (U_il² + V_il²)`. -/
noncomputable def dvec (U V : Matrix (Fin m) (Fin m) ℝ) (i : Fin m) : ℝ := ∑ l, (U i l ^ 2 + V i l ^ 2)

/-- **L268's system** in the pair coordinates: the two root equations of every pair `i ≠ j`. -/
def TorusSystem (U V : Matrix (Fin m) (Fin m) ℝ) : Prop :=
  ∀ i j : Fin m, i ≠ j →
    U i j * (1 - dvec U V i - dvec U V j + 2 * (V i j ^ 2 - U i j ^ 2)) = (U * U + V * V) i j ∧
    V i j * (1 - dvec U V i - dvec U V j - 2 * (V i j ^ 2 - U i j ^ 2)) = (U * V + V * U) i j

/-- Symmetric weights with zero diagonal, the shape of `U` and `V`. -/
def IsPairWeights (U : Matrix (Fin m) (Fin m) ℝ) : Prop := Uᵀ = U ∧ ∀ i, U i i = 0

/-! ## The torus operator's quadratic form -/

theorem J2_00 : J2 0 0 = 0 := rfl
theorem J2_01 : J2 0 1 = -1 := rfl
theorem J2_10 : J2 1 0 = 1 := rfl
theorem J2_11 : J2 1 1 = 0 := rfl

theorem cPart_00 (B : Matrix (Fin 2) (Fin 2) ℝ) : cPart B 0 0 = (B 0 0 + B 1 1) / 2 := by
  simp only [cPart, Matrix.smul_apply, Matrix.sub_apply, Matrix.mul_apply, Fin.sum_univ_two, J2_00, J2_01, J2_10,
    J2_11, smul_eq_mul]; ring
theorem cPart_01 (B : Matrix (Fin 2) (Fin 2) ℝ) : cPart B 0 1 = (B 0 1 - B 1 0) / 2 := by
  simp only [cPart, Matrix.smul_apply, Matrix.sub_apply, Matrix.mul_apply, Fin.sum_univ_two, J2_00, J2_01, J2_10,
    J2_11, smul_eq_mul]; ring
theorem cPart_10 (B : Matrix (Fin 2) (Fin 2) ℝ) : cPart B 1 0 = (B 1 0 - B 0 1) / 2 := by
  simp only [cPart, Matrix.smul_apply, Matrix.sub_apply, Matrix.mul_apply, Fin.sum_univ_two, J2_00, J2_01, J2_10,
    J2_11, smul_eq_mul]; ring
theorem cPart_11 (B : Matrix (Fin 2) (Fin 2) ℝ) : cPart B 1 1 = (B 0 0 + B 1 1) / 2 := by
  simp only [cPart, Matrix.smul_apply, Matrix.sub_apply, Matrix.mul_apply, Fin.sum_univ_two, J2_00, J2_01, J2_10,
    J2_11, smul_eq_mul]; ring
theorem aPart_00 (B : Matrix (Fin 2) (Fin 2) ℝ) : aPart B 0 0 = (B 0 0 - B 1 1) / 2 := by
  simp only [aPart, Matrix.smul_apply, Matrix.add_apply, Matrix.mul_apply, Fin.sum_univ_two, J2_00, J2_01, J2_10,
    J2_11, smul_eq_mul]; ring
theorem aPart_01 (B : Matrix (Fin 2) (Fin 2) ℝ) : aPart B 0 1 = (B 0 1 + B 1 0) / 2 := by
  simp only [aPart, Matrix.smul_apply, Matrix.add_apply, Matrix.mul_apply, Fin.sum_univ_two, J2_00, J2_01, J2_10,
    J2_11, smul_eq_mul]; ring
theorem aPart_10 (B : Matrix (Fin 2) (Fin 2) ℝ) : aPart B 1 0 = (B 0 1 + B 1 0) / 2 := by
  simp only [aPart, Matrix.smul_apply, Matrix.add_apply, Matrix.mul_apply, Fin.sum_univ_two, J2_00, J2_01, J2_10,
    J2_11, smul_eq_mul]; ring
theorem aPart_11 (B : Matrix (Fin 2) (Fin 2) ℝ) : aPart B 1 1 = (B 1 1 - B 0 0) / 2 := by
  simp only [aPart, Matrix.smul_apply, Matrix.add_apply, Matrix.mul_apply, Fin.sum_univ_two, J2_00, J2_01, J2_10,
    J2_11, smul_eq_mul]; ring

/-- The Cartan coordinate of the `t`-th coordinate plane. -/
def xc (X : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) (t : Fin m) : ℝ := X (t, 1) (t, 0)

/-- The Frobenius pairing of `2 × 2` blocks. -/
def frob (B C : Matrix (Fin 2) (Fin 2) ℝ) : ℝ := ∑ c, ∑ d, B c d * C c d

theorem frob_cPart_symm (B C : Matrix (Fin 2) (Fin 2) ℝ) : frob (cPart B) C = frob (cPart C) B := by
  simp only [frob, Fin.sum_univ_two, cPart_00, cPart_01, cPart_10, cPart_11, aPart_00, aPart_01, aPart_10, aPart_11]
  ring

theorem frob_aPart_symm (B C : Matrix (Fin 2) (Fin 2) ℝ) : frob (aPart B) C = frob (aPart C) B := by
  simp only [frob, Fin.sum_univ_two, cPart_00, cPart_01, cPart_10, cPart_11, aPart_00, aPart_01, aPart_10, aPart_11]
  ring

/-- `⟨cPart B, B⟩ = ½((B₀₀ + B₁₁)² + (B₀₁ - B₁₀)²)`. -/
theorem frob_cPart_self (B : Matrix (Fin 2) (Fin 2) ℝ) :
    frob (cPart B) B = (1 / 2) * ((B 0 0 + B 1 1) ^ 2 + (B 0 1 - B 1 0) ^ 2) := by
  simp only [frob, Fin.sum_univ_two, cPart_00, cPart_01, cPart_10, cPart_11, aPart_00, aPart_01, aPart_10, aPart_11]
  ring

/-- `⟨aPart B, B⟩ = ½((B₀₀ - B₁₁)² + (B₀₁ + B₁₀)²)`. -/
theorem frob_aPart_self (B : Matrix (Fin 2) (Fin 2) ℝ) :
    frob (aPart B) B = (1 / 2) * ((B 0 0 - B 1 1) ^ 2 + (B 0 1 + B 1 0) ^ 2) := by
  simp only [frob, Fin.sum_univ_two, cPart_00, cPart_01, cPart_10, cPart_11, aPart_00, aPart_01, aPart_10, aPart_11]
  ring

/-- Pairing against a skew matrix sees only the skew part. -/
theorem inner2_skewPartM {κ : Type*} [Fintype κ] [DecidableEq κ] (M Y : Matrix κ κ ℝ) (hY : Yᵀ = -Y) :
    inner2 (skewPartM M) Y = inner2 M Y := by
  rw [inner2_eq_sum, inner2_eq_sum]
  have hs : ∀ a b, Y b a = - Y a b := fun a b => by
    have := congrFun (congrFun hY a) b
    simpa [Matrix.transpose_apply] using this
  have key : ∑ a, ∑ b, M b a * Y a b = - ∑ a, ∑ b, M a b * Y a b := by
    rw [Finset.sum_comm, ← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [hs]; ring
  have e : ∑ a, ∑ b, skewPartM M a b * Y a b
      = (1 / 2) * (∑ a, ∑ b, M a b * Y a b) - (1 / 2) * ∑ a, ∑ b, M b a * Y a b := by
    simp only [skewPartM, Matrix.smul_apply, Matrix.sub_apply, Matrix.transpose_apply, smul_eq_mul, Finset.mul_sum,
      ← Finset.sum_sub_distrib]
    refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_
    ring
  rw [e, key]; ring

/-- **The pairing of the torus matrix against a skew matrix**, block by block: the Cartan block pairs through `A`,
each off-diagonal block through its two root projections. -/
theorem inner2_torusMat (A U V : Matrix (Fin m) (Fin m) ℝ) (X Y : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ)
    (hY : Yᵀ = -Y) :
    inner2 (torusMat A U V X) Y = ∑ k, ∑ t, A k t * xc X t * xc Y k
      + (1 / 2) * ∑ k, ∑ l, (if k = l then 0 else
          U k l * frob (cPart (blk X k l)) (blk Y k l) + V k l * frob (aPart (blk X k l)) (blk Y k l)) := by
  have hs : ∀ a b, Y b a = - Y a b := fun a b => by
    have := congrFun (congrFun hY a) b
    simpa [Matrix.transpose_apply] using this
  have hkl : ∀ k l, ∑ c : Fin 2, ∑ d : Fin 2, torusMat A U V X (k, c) (l, d) * Y (k, c) (l, d)
      = (if k = l then 2 * (∑ t, A k t * xc X t) * xc Y k else 0) + (if k = l then 0 else
          U k l * frob (cPart (blk X k l)) (blk Y k l) + V k l * frob (aPart (blk X k l)) (blk Y k l)) := by
    intro k l
    by_cases h : k = l
    · subst h
      have h01 := hs (k, 1) (k, 0)
      simp only [torusMat, if_true, Fin.sum_univ_two, add_zero]
      simp [J2, xc, h01]
      ring
    · simp only [torusMat, if_neg h, zero_add]
      simp only [frob, blk, Fin.sum_univ_two]
      ring
  rw [inner2_eq_sum, Fintype.sum_prod_type]
  simp_rw [Fintype.sum_prod_type]
  rw [Finset.sum_congr rfl fun k _ => Finset.sum_comm]
  rw [Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => hkl k l]
  rw [Finset.sum_congr rfl fun k _ => Finset.sum_add_distrib, Finset.sum_add_distrib]
  rw [Finset.sum_congr rfl fun k _ => Finset.sum_ite_eq Finset.univ k (fun _ => (2 * ∑ t, A k t * xc X t) * xc Y k)]
  simp only [Finset.mem_univ, if_true]
  have e : ∑ k, (2 * ∑ t, A k t * xc X t) * xc Y k = 2 * ∑ k, ∑ t, A k t * xc X t * xc Y k := by
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [Finset.mul_sum, Finset.mul_sum, Finset.sum_mul]
    refine Finset.sum_congr rfl fun t _ => ?_
    ring
  rw [e]; ring

/-- **The torus operator is self-adjoint** when its Cartan block is symmetric. -/
theorem torusOp_isSelfAdjoint2 (A U V : Matrix (Fin m) (Fin m) ℝ) (hA : Aᵀ = A) :
    IsSelfAdjoint2 (torusOp A U V) := fun X Y => by
  have hX : (X : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ)ᵀ = -X := X.2
  have hY : (Y : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ)ᵀ = -Y := Y.2
  show inner2 (skewPartM (torusMat A U V X)) Y = inner2 X (skewPartM (torusMat A U V Y))
  rw [inner2_skewPartM _ _ hY, inner2_comm (X : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ),
    inner2_skewPartM _ _ hX, inner2_torusMat _ _ _ _ _ hY, inner2_torusMat _ _ _ _ _ hX]
  congr 1
  · rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun t _ => Finset.sum_congr rfl fun k _ => ?_
    have : A t k = A k t := by rw [← Matrix.transpose_apply A k t, hA]
    rw [this]; ring
  · congr 1
    refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => ?_
    split_ifs
    · rfl
    · rw [frob_cPart_symm, frob_aPart_symm]

/-- `xᵀ A_μ x = ½ ∑_{k,l} (U_kl² (x_k - x_l)² + V_kl² (x_k + x_l)²)`, the Cartan block as a sum of squares. -/
theorem Amu_quad (U V : Matrix (Fin m) (Fin m) ℝ) (hU : IsPairWeights U) (hV : IsPairWeights V) (x : Fin m → ℝ) :
    ∑ k, ∑ t, Amu U V k t * x t * x k
      = (1 / 2) * ∑ k, ∑ l, (U k l ^ 2 * (x k - x l) ^ 2 + V k l ^ 2 * (x k + x l) ^ 2) := by
  obtain ⟨hUt, hU0⟩ := hU
  obtain ⟨hVt, hV0⟩ := hV
  have hsU : ∀ i j, U i j = U j i := fun i j => by rw [← Matrix.transpose_apply U j i, hUt]
  have hsV : ∀ i j, V i j = V j i := fun i j => by rw [← Matrix.transpose_apply V j i, hVt]
  -- both sides expand to the diagonal and off-diagonal parts
  have hL : ∀ k, ∑ t, Amu U V k t * x t * x k
      = (∑ l, (U k l ^ 2 + V k l ^ 2)) * x k ^ 2 + ∑ t, (V k t ^ 2 - U k t ^ 2) * x t * x k := by
    intro k
    have e1 := Finset.add_sum_erase Finset.univ (fun t => Amu U V k t * x t * x k) (Finset.mem_univ k)
    have e2 := Finset.add_sum_erase Finset.univ (fun t => (V k t ^ 2 - U k t ^ 2) * x t * x k) (Finset.mem_univ k)
    rw [← e1, ← e2]
    have e3 : ∑ t ∈ Finset.univ.erase k, Amu U V k t * x t * x k
        = ∑ t ∈ Finset.univ.erase k, (V k t ^ 2 - U k t ^ 2) * x t * x k :=
      Finset.sum_congr rfl fun t ht => by rw [Amu, if_neg (Ne.symm (Finset.ne_of_mem_erase ht))]
    rw [e3]
    simp only [Amu, hU0, hV0, if_true, ite_true]
    ring
  simp_rw [hL]
  rw [Finset.sum_add_distrib]
  have e2 : ∑ k, ∑ l, (U k l ^ 2 * (x k - x l) ^ 2 + V k l ^ 2 * (x k + x l) ^ 2)
      = ∑ k, ∑ l, (U k l ^ 2 + V k l ^ 2) * x k ^ 2 + ∑ k, ∑ l, (U k l ^ 2 + V k l ^ 2) * x l ^ 2
        + 2 * ∑ k, ∑ l, (V k l ^ 2 - U k l ^ 2) * x l * x k := by
    simp only [Finset.mul_sum, ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => ?_
    ring
  have e3 : ∑ k, ∑ l, (U k l ^ 2 + V k l ^ 2) * x l ^ 2 = ∑ k, ∑ l, (U k l ^ 2 + V k l ^ 2) * x k ^ 2 := by
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => ?_
    rw [hsU l k, hsV l k]
  rw [e2, e3]
  simp only [Finset.sum_mul]
  ring

/-! ## The torus operator's inner products -/

theorem skewPartM_of_skew {κ : Type*} [Fintype κ] [DecidableEq κ] (M : Matrix κ κ ℝ) (hM : Mᵀ = -M) :
    skewPartM M = M := by
  unfold skewPartM; rw [hM]; module

theorem J2_skew (a b : Fin 2) : J2 b a = -J2 a b := by
  fin_cases a <;> fin_cases b <;> simp only [Fin.zero_eta, Fin.mk_one, J2_00, J2_01, J2_10, J2_11] <;> norm_num

theorem cPart_transpose (B : Matrix (Fin 2) (Fin 2) ℝ) (c d : Fin 2) : cPart Bᵀ c d = cPart B d c := by
  fin_cases c <;> fin_cases d <;> simp only [Fin.zero_eta, Fin.mk_one, cPart_00, cPart_01, cPart_10, cPart_11, aPart_00, aPart_01, aPart_10, aPart_11, Matrix.transpose_apply] <;> ring

theorem aPart_transpose (B : Matrix (Fin 2) (Fin 2) ℝ) (c d : Fin 2) : aPart Bᵀ c d = aPart B d c := by
  fin_cases c <;> fin_cases d <;> simp only [Fin.zero_eta, Fin.mk_one, cPart_00, cPart_01, cPart_10, cPart_11, aPart_00, aPart_01, aPart_10, aPart_11, Matrix.transpose_apply] <;> ring

theorem cPart_neg (B : Matrix (Fin 2) (Fin 2) ℝ) (c d : Fin 2) : cPart (-B) c d = -cPart B c d := by
  simp only [cPart, Matrix.smul_apply, Matrix.sub_apply, Matrix.neg_apply, Matrix.mul_neg, Matrix.neg_mul, smul_eq_mul]; ring

theorem aPart_neg (B : Matrix (Fin 2) (Fin 2) ℝ) (c d : Fin 2) : aPart (-B) c d = -aPart B c d := by
  simp only [aPart, Matrix.smul_apply, Matrix.add_apply, Matrix.neg_apply, Matrix.mul_neg, Matrix.neg_mul, smul_eq_mul]; ring

/-- For symmetric `U, V` the torus matrix of a skew matrix is skew. -/
theorem torusMat_skew (A U V : Matrix (Fin m) (Fin m) ℝ) (hU : Uᵀ = U) (hV : Vᵀ = V)
    (X : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) (hX : Xᵀ = -X) : (torusMat A U V X)ᵀ = -torusMat A U V X := by
  have hsU : ∀ i j, U i j = U j i := fun i j => by rw [← Matrix.transpose_apply U j i, hU]
  have hsV : ∀ i j, V i j = V j i := fun i j => by rw [← Matrix.transpose_apply V j i, hV]
  have hblk : ∀ k l, blk X l k = -(blk X k l)ᵀ := fun k l => by
    ext c d
    have := congrFun (congrFun hX (l, c)) (k, d)
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    simp only [blk, Matrix.neg_apply, Matrix.transpose_apply]
    linarith
  ext ⟨k, c⟩ ⟨l, d⟩
  simp only [Matrix.transpose_apply, Matrix.neg_apply, torusMat]
  by_cases h : k = l
  · subst h
    simp only [if_true]
    rw [J2_skew]; ring
  · rw [if_neg (Ne.symm h), if_neg h, hblk k l, cPart_neg, aPart_neg, cPart_transpose, aPart_transpose,
      hsU l k, hsV l k]
    ring

theorem xc_torusMat (A U V : Matrix (Fin m) (Fin m) ℝ) (X : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) (t : Fin m) :
    xc (torusMat A U V X) t = ∑ s, A t s * xc X s := by
  simp [xc, torusMat, J2]

theorem blk_torusMat (A U V : Matrix (Fin m) (Fin m) ℝ) (X : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) {k l : Fin m}
    (hkl : k ≠ l) : blk (torusMat A U V X) k l = U k l • cPart (blk X k l) + V k l • aPart (blk X k l) := by
  ext c d
  simp [blk, torusMat, hkl]

theorem frob_cPart_mix (B : Matrix (Fin 2) (Fin 2) ℝ) (u v : ℝ) :
    frob (cPart B) (u • cPart B + v • aPart B) = u * ((1 / 2) * ((B 0 0 + B 1 1) ^ 2 + (B 0 1 - B 1 0) ^ 2)) := by
  simp only [frob, Fin.sum_univ_two, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul, cPart_00, cPart_01, cPart_10, cPart_11, aPart_00, aPart_01, aPart_10, aPart_11]
  ring

theorem frob_aPart_mix (B : Matrix (Fin 2) (Fin 2) ℝ) (u v : ℝ) :
    frob (aPart B) (u • cPart B + v • aPart B) = v * ((1 / 2) * ((B 0 0 - B 1 1) ^ 2 + (B 0 1 + B 1 0) ^ 2)) := by
  simp only [frob, Fin.sum_univ_two, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul, cPart_00, cPart_01, cPart_10, cPart_11, aPart_00, aPart_01, aPart_10, aPart_11]
  ring

/-- `φ_pq(r, s) = δ_qr δ_ps - δ_pr δ_qs`. -/
theorem phi_delta {κ : Type*} [Fintype κ] [DecidableEq κ] (p q r s : κ) :
    phi p q r s = (if q = r then 1 else 0) * (if p = s then 1 else 0) - (if p = r then 1 else 0) * (if q = s then 1 else 0) := by
  unfold phi
  simp only [Matrix.sub_apply, Matrix.single_apply, ite_and]
  split_ifs <;> ring

theorem delta_sum {κ : Type*} [Fintype κ] [DecidableEq κ] (a b : κ) :
    ∑ x : κ, (if x = a then (1 : ℝ) else 0) * (if x = b then 1 else 0) = if a = b then 1 else 0 := by
  simp only [ite_mul, one_mul, zero_mul]
  rw [Finset.sum_ite_eq']
  simp only [Finset.mem_univ, if_true]

/-- **Sums over the `φ` family**: `∑_{p,q} φ_pq(r,s) φ_pq(r',s') = 2(δ_rr' δ_ss' - δ_rs' δ_sr')`. -/
theorem phi_sum_prod {κ : Type*} [Fintype κ] [DecidableEq κ] (r s r' s' : κ) :
    ∑ p : κ, ∑ q : κ, phi p q r s * phi p q r' s'
      = 2 * ((if r = r' ∧ s = s' then 1 else 0) - (if r = s' ∧ s = r' then 1 else 0)) := by
  simp only [phi_delta]
  have expand : ∀ p q : κ,
      ((if q = r then (1 : ℝ) else 0) * (if p = s then 1 else 0) - (if p = r then 1 else 0) * (if q = s then 1 else 0))
        * ((if q = r' then 1 else 0) * (if p = s' then 1 else 0) - (if p = r' then 1 else 0) * (if q = s' then 1 else 0))
      = (if p = s then 1 else 0) * (if p = s' then 1 else 0) * ((if q = r then 1 else 0) * (if q = r' then 1 else 0))
        - (if p = s then 1 else 0) * (if p = r' then 1 else 0) * ((if q = r then 1 else 0) * (if q = s' then 1 else 0))
        - (if p = r then 1 else 0) * (if p = s' then 1 else 0) * ((if q = s then 1 else 0) * (if q = r' then 1 else 0))
        + (if p = r then 1 else 0) * (if p = r' then 1 else 0) * ((if q = s then 1 else 0) * (if q = s' then 1 else 0)) :=
    fun p q => by ring
  simp only [expand, Finset.sum_add_distrib, Finset.sum_sub_distrib, ← Finset.mul_sum, ← Finset.sum_mul, delta_sum]
  split_ifs <;> simp_all <;> norm_num

/-! ## Matrix facts for the torus system (used by L271 and L272) -/

/-- A sum vanishing at `k` and constant `c` elsewhere is `(m - 1) c`. -/
theorem sum_off_one (k : Fin m) (c : ℝ) (f : Fin m → ℝ) (hf : ∀ l, l ≠ k → f l = c) (hk : f k = 0) :
    ∑ l, f l = ((m : ℝ) - 1) * c := by
  rw [← Finset.add_sum_erase _ _ (Finset.mem_univ k), hk, zero_add,
    Finset.sum_congr rfl (fun l hl => hf l (Finset.ne_of_mem_erase hl)), Finset.sum_const,
    Finset.card_erase_of_mem (Finset.mem_univ k), Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]
  have := k.2
  rw [Nat.cast_sub (by omega)]; simp

/-- A sum vanishing at `i ≠ j` and constant `c` elsewhere is `(m - 2) c`. -/
theorem sum_off_two (i j : Fin m) (hij : i ≠ j) (c : ℝ) (f : Fin m → ℝ) (hf : ∀ l, l ≠ i → l ≠ j → f l = c)
    (hi : f i = 0) (hj : f j = 0) : ∑ l, f l = ((m : ℝ) - 2) * c := by
  have hjm : j ∈ Finset.univ.erase i := Finset.mem_erase.mpr ⟨hij.symm, Finset.mem_univ j⟩
  rw [← Finset.add_sum_erase _ _ (Finset.mem_univ i), hi, zero_add, ← Finset.add_sum_erase _ _ hjm, hj, zero_add,
    Finset.sum_congr rfl (fun l hl => hf l (Finset.ne_of_mem_erase (Finset.mem_of_mem_erase hl))
      (Finset.ne_of_mem_erase hl)), Finset.sum_const, Finset.card_erase_of_mem hjm,
    Finset.card_erase_of_mem (Finset.mem_univ i), Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]
  have h2 : 2 ≤ m := by
    have := Fin.val_ne_of_ne hij; have := i.2; have := j.2; omega
  rw [Nat.cast_sub (by omega), Nat.cast_sub (by omega)]; push_cast; ring



/-- **The ground-state identity**: for symmetric `X` with a positive eigenvector `w` (eigenvalue `ρ`),
`ρ ‖v‖² - vᵀXv = ½ ∑_{ij} X_ij w_i w_j (v_i/w_i - v_j/w_j)²`. -/
theorem ground_state {κ : Type*} [Fintype κ] [DecidableEq κ] (X : Matrix κ κ ℝ) (hX : Xᵀ = X) (w v : κ → ℝ) (ρ : ℝ)
    (hw : ∀ i, 0 < w i) (hXw : X.mulVec w = ρ • w) :
    ρ * ∑ i, v i ^ 2 - ∑ i, ∑ j, X i j * v i * v j
      = (1 / 2) * ∑ i, ∑ j, X i j * w i * w j * (v i / w i - v j / w j) ^ 2 := by
  have hs : ∀ i j, X i j = X j i := fun i j => by rw [← Matrix.transpose_apply X j i, hX]
  have hrow : ∀ i, ∑ j, X i j * w j = ρ * w i := fun i => by
    have := congrFun hXw i; simpa [Matrix.mulVec, dotProduct] using this
  have hcol : ∀ j, ∑ i, X i j * w i = ρ * w j := fun j => by
    rw [← hrow j]; exact Finset.sum_congr rfl fun i _ => by rw [hs i j]
  have hwne : ∀ i, w i ≠ 0 := fun i => ne_of_gt (hw i)
  have expand : ∀ i j, X i j * w i * w j * (v i / w i - v j / w j) ^ 2
      = X i j * w j * (v i ^ 2 / w i) - 2 * (X i j * v i * v j) + X i j * w i * (v j ^ 2 / w j) := by
    intro i j
    have hi := hwne i
    have hj := hwne j
    field_simp
    ring
  simp only [expand, Finset.sum_add_distrib, Finset.sum_sub_distrib, ← Finset.mul_sum]
  have t1 : ∑ i, ∑ j, X i j * w j * (v i ^ 2 / w i) = ρ * ∑ i, v i ^ 2 := by
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [← Finset.sum_mul, hrow i]
    have hi := hwne i
    field_simp
  have t3 : ∑ i, ∑ j, X i j * w i * (v j ^ 2 / w j) = ρ * ∑ i, v i ^ 2 := by
    rw [Finset.sum_comm, Finset.mul_sum]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [← Finset.sum_mul, hcol j]
    have hj := hwne j
    field_simp
  rw [t1, t3]
  ring

/-- `X = P + diag d` squared, entrywise, for a zero-diagonal `P`. -/
theorem sq_add_diag (P : Matrix (Fin m) (Fin m) ℝ) (d : Fin m → ℝ) (hP0 : ∀ i, P i i = 0) (i j : Fin m) :
    ((P + Matrix.diagonal d) * (P + Matrix.diagonal d)) i j
      = (P * P) i j + P i j * (d i + d j) + (if i = j then d i ^ 2 else 0) := by
  simp only [Matrix.add_mul, Matrix.mul_add, Matrix.add_apply, Matrix.mul_diagonal, Matrix.diagonal_mul,
    Matrix.diagonal_mul_diagonal, Matrix.diagonal_apply]
  split_ifs with h
  · subst h; rw [hP0]; ring
  · ring


/-- **L271 (2), proved**: L268's system in the pair coordinates is the `P, Q` system,
`P_ij (1 - d_i - d_j - 2 Q_ij²) = (P²)_ij` and `Q_ij (1 - d_i - d_j - 2 P_ij²) = (Q²)_ij` off the diagonal. -/
theorem L271_pq_system {m : ℕ} (U V : Matrix (Fin m) (Fin m) ℝ) :
    TorusSystem U V ↔ ∀ i j : Fin m, i ≠ j →
      (U + V) i j * (1 - dvec U V i - dvec U V j - 2 * (U - V) i j ^ 2) = ((U + V) * (U + V)) i j ∧
      (U - V) i j * (1 - dvec U V i - dvec U V j - 2 * (U + V) i j ^ 2) = ((U - V) * (U - V)) i j := by
  obtain ⟨hP, hQ⟩ := HamiltonsCubic.I117.pq_square U V
  constructor
  · intro h i j hij
    obtain ⟨h1, h2⟩ := h i j hij
    have e := (HamiltonsCubic.I117.pq_entry (U i j) (V i j) (dvec U V i + dvec U V j)
      ((U * U + V * V) i j) ((U * V + V * U) i j)).mp ⟨by rw [← h1]; ring, by rw [← h2]; ring⟩
    refine ⟨?_, ?_⟩
    · rw [hP, Matrix.add_apply, Matrix.add_apply, Matrix.sub_apply]
      simp only [Matrix.add_apply] at e ⊢
      linarith [e.1]
    · rw [hQ, Matrix.sub_apply, Matrix.sub_apply]
      simp only [Matrix.add_apply] at e ⊢
      linarith [e.2]
  · intro h i j hij
    obtain ⟨h1, h2⟩ := h i j hij
    rw [hP] at h1
    rw [hQ] at h2
    have e := (HamiltonsCubic.I117.pq_entry (U i j) (V i j) (dvec U V i + dvec U V j)
      ((U * U + V * V) i j) ((U * V + V * U) i j)).mpr
      ⟨by simp only [Matrix.add_apply, Matrix.sub_apply] at h1 ⊢; linarith,
       by simp only [Matrix.add_apply, Matrix.sub_apply] at h2 ⊢; linarith⟩
    exact ⟨by linarith [e.1], by linarith [e.2]⟩


/-- A `2 × 2` block with both root projections zero, at positive weights, is zero. -/
theorem block_zero_of_pos (B : Matrix (Fin 2) (Fin 2) ℝ) {u v : ℝ} (hu : 0 < u) (hv : 0 < v)
    (h : u * ((1 / 2) * ((B 0 0 + B 1 1) ^ 2 + (B 0 1 - B 1 0) ^ 2))
      + v * ((1 / 2) * ((B 0 0 - B 1 1) ^ 2 + (B 0 1 + B 1 0) ^ 2)) = 0) :
    ∀ c d, B c d = 0 := by
  have h1 : 0 ≤ (B 0 0 + B 1 1) ^ 2 + (B 0 1 - B 1 0) ^ 2 := by positivity
  have h2 : 0 ≤ (B 0 0 - B 1 1) ^ 2 + (B 0 1 + B 1 0) ^ 2 := by positivity
  have hc0 : (B 0 0 + B 1 1) ^ 2 + (B 0 1 - B 1 0) ^ 2 = 0 := by
    by_contra hne
    have hp : 0 < (B 0 0 + B 1 1) ^ 2 + (B 0 1 - B 1 0) ^ 2 := lt_of_le_of_ne h1 (Ne.symm hne)
    nlinarith [mul_pos hu hp, mul_nonneg hv.le h2]
  have ha0 : (B 0 0 - B 1 1) ^ 2 + (B 0 1 + B 1 0) ^ 2 = 0 := by
    by_contra hne
    have hp : 0 < (B 0 0 - B 1 1) ^ 2 + (B 0 1 + B 1 0) ^ 2 := lt_of_le_of_ne h2 (Ne.symm hne)
    nlinarith [mul_pos hv hp, mul_nonneg hu.le h1]
  have sq0 : ∀ a b : ℝ, a ^ 2 + b ^ 2 = 0 → a = 0 ∧ b = 0 := fun a b hab =>
    ⟨(pow_eq_zero_iff two_ne_zero).mp (by linarith [sq_nonneg a, sq_nonneg b]),
      (pow_eq_zero_iff two_ne_zero).mp (by linarith [sq_nonneg a, sq_nonneg b])⟩
  obtain ⟨e1, e2⟩ := sq0 _ _ hc0
  obtain ⟨e3, e4⟩ := sq0 _ _ ha0
  intro c d
  fin_cases c <;> fin_cases d <;> simp only [Fin.zero_eta, Fin.mk_one] <;> linarith

theorem sum_lin {α : Type*} [Fintype α] (a b : ℝ) (f g : α → α → ℝ) :
    ∑ p, ∑ q, (a * f p q + b * g p q) = a * ∑ p, ∑ q, f p q + b * ∑ p, ∑ q, g p q := by
  simp only [Finset.sum_add_distrib, Finset.mul_sum]

theorem sum_pq_swap {α β : Type*} [Fintype α] [Fintype β] (F : α → α → β → ℝ) :
    ∑ p, ∑ q, ∑ k, F p q k = ∑ k, ∑ p, ∑ q, F p q k := by
  rw [Finset.sum_congr rfl fun p _ => Finset.sum_comm, Finset.sum_comm]

theorem xc_phi_sum (t s : Fin m) :
    ∑ p : Fin m × Fin 2, ∑ q : Fin m × Fin 2, xc (phi p q) t * xc (phi p q) s = 2 * (if t = s then 1 else 0) := by
  simp only [xc]
  rw [phi_sum_prod]
  by_cases h : t = s
  · subst h; simp
  · simp [Prod.ext_iff, h]

theorem blk_phi_sum {k l : Fin m} (hkl : k ≠ l) (c d c' d' : Fin 2) :
    ∑ p : Fin m × Fin 2, ∑ q : Fin m × Fin 2, blk (phi p q) k l c d * blk (phi p q) k l c' d'
      = 2 * (if c = c' ∧ d = d' then 1 else 0) := by
  simp only [blk]
  rw [phi_sum_prod]
  simp [Prod.ext_iff, hkl, Ne.symm hkl]

theorem cPart_phi_sum {k l : Fin m} (hkl : k ≠ l) :
    ∑ p : Fin m × Fin 2, ∑ q : Fin m × Fin 2, (1 / 2 : ℝ) * ((blk (phi p q) k l 0 0 + blk (phi p q) k l 1 1) ^ 2
      + (blk (phi p q) k l 0 1 - blk (phi p q) k l 1 0) ^ 2) = 4 := by
  have e : ∀ p q : Fin m × Fin 2, (1 / 2 : ℝ) * ((blk (phi p q) k l 0 0 + blk (phi p q) k l 1 1) ^ 2
      + (blk (phi p q) k l 0 1 - blk (phi p q) k l 1 0) ^ 2)
      = (1 / 2) * (blk (phi p q) k l 0 0 * blk (phi p q) k l 0 0) + blk (phi p q) k l 0 0 * blk (phi p q) k l 1 1
        + (1 / 2) * (blk (phi p q) k l 1 1 * blk (phi p q) k l 1 1)
        + (1 / 2) * (blk (phi p q) k l 0 1 * blk (phi p q) k l 0 1) - blk (phi p q) k l 0 1 * blk (phi p q) k l 1 0
        + (1 / 2) * (blk (phi p q) k l 1 0 * blk (phi p q) k l 1 0) := fun p q => by ring
  simp only [e, Finset.sum_add_distrib, Finset.sum_sub_distrib, ← Finset.mul_sum, blk_phi_sum hkl]
  norm_num

theorem aPart_phi_sum {k l : Fin m} (hkl : k ≠ l) :
    ∑ p : Fin m × Fin 2, ∑ q : Fin m × Fin 2, (1 / 2 : ℝ) * ((blk (phi p q) k l 0 0 - blk (phi p q) k l 1 1) ^ 2
      + (blk (phi p q) k l 0 1 + blk (phi p q) k l 1 0) ^ 2) = 4 := by
  have e : ∀ p q : Fin m × Fin 2, (1 / 2 : ℝ) * ((blk (phi p q) k l 0 0 - blk (phi p q) k l 1 1) ^ 2
      + (blk (phi p q) k l 0 1 + blk (phi p q) k l 1 0) ^ 2)
      = (1 / 2) * (blk (phi p q) k l 0 0 * blk (phi p q) k l 0 0) - blk (phi p q) k l 0 0 * blk (phi p q) k l 1 1
        + (1 / 2) * (blk (phi p q) k l 1 1 * blk (phi p q) k l 1 1)
        + (1 / 2) * (blk (phi p q) k l 0 1 * blk (phi p q) k l 0 1) + blk (phi p q) k l 0 1 * blk (phi p q) k l 1 0
        + (1 / 2) * (blk (phi p q) k l 1 0 * blk (phi p q) k l 1 0) := fun p q => by ring
  simp only [e, Finset.sum_add_distrib, Finset.sum_sub_distrib, ← Finset.mul_sum, blk_phi_sum hkl]
  norm_num

/-- **The inner product of two torus operators**: `⟨T(A, U, V), T(A', U', V')⟩ = ∑ A A' + ∑_{k ≠ l} (U U' + V V')`,
for symmetric root weights. -/
theorem innerOp2_torusOp (A U V A' U' V' : Matrix (Fin m) (Fin m) ℝ) (hU : Uᵀ = U) (hV : Vᵀ = V) (hU' : U'ᵀ = U')
    (hV' : V'ᵀ = V') :
    innerOp2 (torusOp A U V) (torusOp A' U' V')
      = ∑ k, ∑ t, A k t * A' k t + ∑ k, ∑ l, (if k = l then 0 else U k l * U' k l + V k l * V' k l) := by
  unfold innerOp2
  have hterm : ∀ p q : Fin m × Fin 2, inner2 (applyPhi (torusOp A U V) p q) (applyPhi (torusOp A' U' V') p q)
      = ∑ k, ∑ t, ∑ s, A k t * A' k s * (xc (phi p q) t * xc (phi p q) s)
        + (1 / 2) * ∑ k, ∑ l, (if k = l then 0 else
          U k l * U' k l * ((1 / 2) * ((blk (phi p q) k l 0 0 + blk (phi p q) k l 1 1) ^ 2
            + (blk (phi p q) k l 0 1 - blk (phi p q) k l 1 0) ^ 2))
          + V k l * V' k l * ((1 / 2) * ((blk (phi p q) k l 0 0 - blk (phi p q) k l 1 1) ^ 2
            + (blk (phi p q) k l 0 1 + blk (phi p q) k l 1 0) ^ 2))) := by
    intro p q
    have hφ : (phi p q)ᵀ = -phi p q := phi_isSkew p q
    show inner2 (skewPartM (torusMat A U V (phi p q))) (skewPartM (torusMat A' U' V' (phi p q))) = _
    rw [skewPartM_of_skew _ (torusMat_skew A U V hU hV _ hφ),
      skewPartM_of_skew _ (torusMat_skew A' U' V' hU' hV' _ hφ),
      inner2_torusMat _ _ _ _ _ (torusMat_skew A' U' V' hU' hV' _ hφ)]
    simp_rw [xc_torusMat]
    congr 1
    · refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun t _ => ?_
      rw [Finset.mul_sum]
      refine Finset.sum_congr rfl fun s _ => ?_
      ring
    · congr 1
      refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => ?_
      split_ifs with h
      · rfl
      · rw [blk_torusMat _ _ _ _ h, frob_cPart_mix, frob_aPart_mix]; ring
  rw [Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun q _ => hterm p q]
  simp only [Finset.sum_add_distrib, ← Finset.mul_sum]
  have S1 : ∑ p : Fin m × Fin 2, ∑ q : Fin m × Fin 2, ∑ k, ∑ t, ∑ s, A k t * A' k s * (xc (phi p q) t * xc (phi p q) s)
      = 2 * ∑ k, ∑ t, A k t * A' k t := by
    rw [sum_pq_swap]
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [sum_pq_swap]
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun t _ => ?_
    rw [sum_pq_swap]
    simp only [← Finset.mul_sum, xc_phi_sum]
    simp [mul_ite, Finset.sum_ite_eq]
    ring
  have S2 : ∑ p : Fin m × Fin 2, ∑ q : Fin m × Fin 2, ∑ k, ∑ l, (if k = l then (0 : ℝ) else
          U k l * U' k l * ((1 / 2) * ((blk (phi p q) k l 0 0 + blk (phi p q) k l 1 1) ^ 2
            + (blk (phi p q) k l 0 1 - blk (phi p q) k l 1 0) ^ 2))
          + V k l * V' k l * ((1 / 2) * ((blk (phi p q) k l 0 0 - blk (phi p q) k l 1 1) ^ 2
            + (blk (phi p q) k l 0 1 + blk (phi p q) k l 1 0) ^ 2)))
      = 4 * ∑ k, ∑ l, (if k = l then 0 else U k l * U' k l + V k l * V' k l) := by
    rw [sum_pq_swap, Finset.mul_sum]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [sum_pq_swap, Finset.mul_sum]
    refine Finset.sum_congr rfl fun l _ => ?_
    by_cases h : k = l
    · simp [h]
    · simp only [if_neg h]
      rw [sum_lin, cPart_phi_sum h, aPart_phi_sum h]
      ring
  rw [S1, S2]
  ring

/-- The unit root weights, `1` off the diagonal. -/
def onesOff (m : ℕ) : Matrix (Fin m) (Fin m) ℝ := fun i j => if i = j then 0 else 1

theorem onesOff_symm : (onesOff m)ᵀ = onesOff m := by
  ext i j; simp only [onesOff, Matrix.transpose_apply]; split_ifs with h1 h2 h2 <;> simp_all

/-- **The identity of `𝔰𝔬(2m)` is the torus operator with `A = 1` and every root weight `1`.** -/
theorem idOp_eq_torusOp : (idOp : CurvOp2 (Fin m × Fin 2)) = torusOp 1 (onesOff m) (onesOff m) := by
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  have hX : (X : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ)ᵀ = -X := X.2
  have hs : ∀ a b, (X : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) b a = -(X : Matrix _ _ ℝ) a b := fun a b => by
    have := congrFun (congrFun hX a) b
    simpa [Matrix.transpose_apply] using this
  show (X : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) = skewPartM (torusMat 1 (onesOff m) (onesOff m) X)
  rw [skewPartM_of_skew _ (torusMat_skew _ _ _ onesOff_symm onesOff_symm _ hX)]
  ext ⟨k, c⟩ ⟨l, d⟩
  simp only [torusMat]
  by_cases h : k = l
  · subst h
    simp only [if_true, Matrix.one_apply, ite_mul, one_mul, zero_mul, Finset.sum_ite_eq, Finset.mem_univ]
    have hdiag : ∀ a, (X : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) a a = 0 := fun a => by
      have := hs a a; linarith
    fin_cases c <;> fin_cases d
    · simp [J2_00, hdiag]
    · simp only [Fin.zero_eta, Fin.mk_one, J2_01]; rw [hs (k, 1) (k, 0)]; ring
    · simp [J2_10]
    · simp [J2_11, hdiag]
  · simp only [if_neg h, onesOff, one_mul]
    fin_cases c <;> fin_cases d <;>
      simp only [Fin.zero_eta, Fin.mk_one, cPart_00, cPart_01, cPart_10, cPart_11, aPart_00, aPart_01, aPart_10,
        aPart_11, blk] <;> ring

theorem normSq2_torusOp (A U V : Matrix (Fin m) (Fin m) ℝ) (hU : Uᵀ = U) (hV : Vᵀ = V) :
    normSq2 (torusOp A U V) = ∑ k, ∑ t, A k t ^ 2 + ∑ k, ∑ l, (if k = l then 0 else U k l ^ 2 + V k l ^ 2) := by
  unfold normSq2
  rw [innerOp2_torusOp A U V A U V hU hV hU hV]
  congr 1
  · refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun t _ => ?_; ring
  · refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => ?_; split_ifs <;> ring

/-- `‖I‖² = m(2m - 1)` on `𝔰𝔬(2m)`. -/
theorem normSq2_idOp_torus : normSq2 (idOp : CurvOp2 (Fin m × Fin 2)) = (m : ℝ) * (2 * (m : ℝ) - 1) := by
  rw [idOp_eq_torusOp, normSq2_torusOp _ _ _ onesOff_symm onesOff_symm]
  have h1 : ∑ k : Fin m, ∑ t : Fin m, (1 : Matrix (Fin m) (Fin m) ℝ) k t ^ 2 = m := by
    simp [Matrix.one_apply, ite_pow, Finset.sum_ite_eq]
  have h2 : ∀ k : Fin m, ∑ l : Fin m, (if k = l then (0 : ℝ) else onesOff m k l ^ 2 + onesOff m k l ^ 2)
      = ((m : ℝ) - 1) * 2 := fun k =>
    sum_off_one k _ _ (fun l hl => by simp [onesOff, Ne.symm hl]; norm_num) (by simp)
  rw [h1, Finset.sum_congr rfl fun k _ => h2 k]
  simp; ring

theorem L268_torus_pd (hm : 3 ≤ m) (U V : Matrix (Fin m) (Fin m) ℝ) (hU : IsPairWeights U) (hV : IsPairWeights V)
    (hpos : ∀ i j, i ≠ j → 0 < U i j ∧ 0 < V i j) : IsPD2 (torusOp (Amu U V) U V) := by
  intro X hX0
  have hXs : (X : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ)ᵀ = -X := X.2
  have hs : ∀ a b, (X : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) b a = -(X : Matrix _ _ ℝ) a b := fun a b => by
    have := congrFun (congrFun hXs a) b
    simpa [Matrix.transpose_apply] using this
  show 0 < inner2 (skewPartM (torusMat (Amu U V) U V X)) X
  rw [inner2_skewPartM _ _ hXs, inner2_torusMat _ _ _ _ _ hXs, Amu_quad U V hU hV (xc X)]
  set x := xc (X : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) with hx
  set S1 := ∑ k, ∑ l, (U k l ^ 2 * (x k - x l) ^ 2 + V k l ^ 2 * (x k + x l) ^ 2) with hS1
  set S2 := ∑ k, ∑ l, (if k = l then (0 : ℝ) else
    U k l * frob (cPart (blk X k l)) (blk X k l) + V k l * frob (aPart (blk X k l)) (blk X k l)) with hS2
  have h1 : ∀ k l, 0 ≤ U k l ^ 2 * (x k - x l) ^ 2 + V k l ^ 2 * (x k + x l) ^ 2 := fun k l => by positivity
  have h2 : ∀ k l, 0 ≤ (if k = l then (0 : ℝ) else
      U k l * frob (cPart (blk X k l)) (blk X k l) + V k l * frob (aPart (blk X k l)) (blk X k l)) := fun k l => by
    split_ifs with h
    · exact le_refl _
    · obtain ⟨hu, hv⟩ := hpos k l h
      rw [frob_cPart_self, frob_aPart_self]
      positivity
  have hS1n : 0 ≤ S1 := Finset.sum_nonneg fun k _ => Finset.sum_nonneg fun l _ => h1 k l
  have hS2n : 0 ≤ S2 := Finset.sum_nonneg fun k _ => Finset.sum_nonneg fun l _ => h2 k l
  by_contra hle
  push_neg at hle
  have hS1z : S1 = 0 := by linarith
  have hS2z : S2 = 0 := by linarith
  -- every Cartan coordinate vanishes
  have hx0 : ∀ k, x k = 0 := by
    intro k
    obtain ⟨l, hl⟩ : ∃ l, l ≠ k := by
      obtain ⟨a, b, hab⟩ := Fintype.exists_pair_of_one_lt_card (by rw [Fintype.card_fin]; omega : 1 < Fintype.card (Fin m))
      by_cases ha : a = k
      · exact ⟨b, by rw [← ha]; exact Ne.symm hab⟩
      · exact ⟨a, ha⟩
    have hrow := (Finset.sum_eq_zero_iff_of_nonneg (fun k _ => Finset.sum_nonneg fun l _ => h1 k l)).mp hS1z k
      (Finset.mem_univ k)
    have hkl := (Finset.sum_eq_zero_iff_of_nonneg (fun l _ => h1 k l)).mp hrow l (Finset.mem_univ l)
    obtain ⟨hu, hv⟩ := hpos k l (Ne.symm hl)
    have ha : U k l ^ 2 * (x k - x l) ^ 2 = 0 := by
      have := mul_nonneg (sq_nonneg (U k l)) (sq_nonneg (x k - x l))
      have := mul_nonneg (sq_nonneg (V k l)) (sq_nonneg (x k + x l))
      linarith
    have hb : V k l ^ 2 * (x k + x l) ^ 2 = 0 := by linarith
    have ha' : (x k - x l) ^ 2 = 0 := (mul_eq_zero.mp ha).resolve_left (by positivity)
    have hb' : (x k + x l) ^ 2 = 0 := (mul_eq_zero.mp hb).resolve_left (by positivity)
    have := pow_eq_zero_iff (n := 2) (by norm_num) |>.mp ha'
    have := pow_eq_zero_iff (n := 2) (by norm_num) |>.mp hb'
    linarith
  -- every off-diagonal block vanishes
  have hblk : ∀ k l : Fin m, k ≠ l → ∀ c d : Fin 2, blk (X : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) k l c d = 0 := by
    intro k l hkl c d
    have hrow := (Finset.sum_eq_zero_iff_of_nonneg (fun k _ => Finset.sum_nonneg fun l _ => h2 k l)).mp hS2z k
      (Finset.mem_univ k)
    have hz := (Finset.sum_eq_zero_iff_of_nonneg (fun l _ => h2 k l)).mp hrow l (Finset.mem_univ l)
    rw [if_neg hkl, frob_cPart_self, frob_aPart_self] at hz
    obtain ⟨hu, hv⟩ := hpos k l hkl
    exact block_zero_of_pos _ hu hv hz c d
  apply hX0
  apply Subtype.ext
  ext ⟨k, c⟩ ⟨l, d⟩
  show (X : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) (k, c) (l, d) = 0
  by_cases hkl : k = l
  · subst hkl
    have hdiag : ∀ a, (X : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) a a = 0 := fun a => by
      have := hs a a; linarith
    have hxk : (X : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) (k, 1) (k, 0) = 0 := hx0 k
    fin_cases c <;> fin_cases d
    · exact hdiag _
    · show (X : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) (k, 0) (k, 1) = 0
      rw [hs (k, 1) (k, 0), hxk, neg_zero]
    · exact hxk
    · exact hdiag _
  · exact hblk k l hkl c d

/-- The uniform point `μ ≡ 1/c` solves the system exactly at `c = 2(m - 1)` (typed as `torus_uniform_iff`). -/
theorem L268_uniform (m : ℕ) (hm : 3 ≤ m) :
    TorusSystem (fun i j : Fin m => if i = j then 0 else 1 / (2 * ((m : ℝ) - 1)))
      (fun i j : Fin m => if i = j then 0 else 1 / (2 * ((m : ℝ) - 1))) := by
  show TorusSystem (Matrix.of fun i j : Fin m => if i = j then 0 else 1 / (2 * ((m : ℝ) - 1)))
    (Matrix.of fun i j : Fin m => if i = j then 0 else 1 / (2 * ((m : ℝ) - 1)))
  intro i j hij
  set u : ℝ := 1 / (2 * ((m : ℝ) - 1)) with hu
  have hm1 : (m : ℝ) - 1 ≠ 0 := by
    have : (3 : ℝ) ≤ m := by exact_mod_cast hm
    linarith
  have h2u : 2 * ((m : ℝ) - 1) * u = 1 := by rw [hu]; field_simp
  have hd : ∀ k : Fin m, ∑ l : Fin m, ((if k = l then (0 : ℝ) else u) ^ 2 + (if k = l then 0 else u) ^ 2)
      = ((m : ℝ) - 1) * (2 * u ^ 2) := fun k =>
    sum_off_one k _ _ (fun l hl => by rw [if_neg (Ne.symm hl)]; ring) (by simp)
  have hp : ∑ l : Fin m, (if i = l then (0 : ℝ) else u) * (if l = j then 0 else u) = ((m : ℝ) - 2) * u ^ 2 :=
    sum_off_two i j hij _ _ (fun l hli hlj => by rw [if_neg (Ne.symm hli), if_neg hlj]; ring) (by simp)
      (by simp)
  simp only [dvec, Matrix.add_apply, Matrix.mul_apply, Matrix.of_apply]
  simp only [hd, hp, if_neg hij]
  constructor <;> linear_combination (-2 * u ^ 2 - u) * h2u

/-- **L271 (1), the norm half, proved**: `‖C‖² = ‖A‖² + ½‖P‖² + ½‖Q‖²` on the torus family. -/
theorem L271_norm (A U V : Matrix (Fin m) (Fin m) ℝ) (hU : IsPairWeights U) (hV : IsPairWeights V) :
    normSq2 (torusOp A U V) = (∑ i, ∑ j, A i j ^ 2) + (1 / 2) * (∑ i, ∑ j, (U + V) i j ^ 2)
      + (1 / 2) * (∑ i, ∑ j, (U - V) i j ^ 2) := by
  obtain ⟨hUt, hU0⟩ := hU
  obtain ⟨hVt, hV0⟩ := hV
  rw [normSq2_torusOp A U V hUt hVt, add_assoc]
  congr 1
  simp only [Finset.mul_sum, ← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => ?_
  split_ifs with h
  · subst h; simp [hU0, hV0]
  · simp only [Matrix.add_apply, Matrix.sub_apply]; ring

/-- **L272 (2), (3).** At a positive solution, with `ρ` the largest eigenvalue of `X = P + diag d`: `d_i ≥ ρ - 1`
for every `i`, with equality where row `i` of `Q` vanishes, and `∑_{i<j} (U_ij + V_ij) ≤ m/2`. -/
theorem L272_perron (hm : 3 ≤ m) (U V : Matrix (Fin m) (Fin m) ℝ) (hU : IsPairWeights U) (hV : IsPairWeights V)
    (hpos : ∀ i j, i ≠ j → 0 < U i j ∧ 0 < V i j) (hsys : TorusSystem U V) (ρ : ℝ)
    (hρ : ∃ w : Fin m → ℝ, (∀ i, 0 < w i) ∧ ((U + V) + Matrix.diagonal (dvec U V)).mulVec w = ρ • w) :
    (∀ i, ρ - 1 ≤ dvec U V i) ∧ (∀ i, (∀ l, U i l = V i l) → dvec U V i = ρ - 1) ∧
      (1 / 2 : ℝ) * ∑ i, ∑ j, (U i j + V i j) ≤ (m : ℝ) / 2 := by
  obtain ⟨w, hw, hXw⟩ := hρ
  haveI : Nontrivial (Fin m) := Fin.nontrivial_iff_two_le.mpr (by omega)
  set P := U + V with hPdef
  set d := dvec U V with hddef
  set X := P + Matrix.diagonal d with hXdef
  have hPsym : Pᵀ = P := by rw [hPdef, Matrix.transpose_add, hU.1, hV.1]
  have hs : ∀ i j, P i j = P j i := fun i j => by rw [← Matrix.transpose_apply P j i, hPsym]
  have hP0 : ∀ i, P i i = 0 := fun i => by simp [hPdef, hU.2 i, hV.2 i]
  have hPpos : ∀ i j, i ≠ j → 0 < P i j := fun i j h => by
    simp only [hPdef, Matrix.add_apply]; linarith [(hpos i j h).1, (hpos i j h).2]
  have hPnn : ∀ i j, 0 ≤ P i j := fun i j => by
    by_cases h : i = j
    · subst h; rw [hP0]
    · exact (hPpos i j h).le
  have hdnn : ∀ i, 0 ≤ d i := fun i => Finset.sum_nonneg fun l _ => by positivity
  have hXsym : Xᵀ = X := by rw [hXdef, Matrix.transpose_add, hPsym, Matrix.diagonal_transpose]
  have hXnn : ∀ i j, 0 ≤ X i j := fun i j => by
    simp only [hXdef, Matrix.add_apply, Matrix.diagonal_apply]
    split_ifs with h
    · subst h; rw [hP0]; linarith [hdnn i]
    · linarith [hPnn i j]
  have hpq := (L271_pq_system U V).mp hsys
  have hoff : ∀ i j, i ≠ j → (X * X) i j = P i j - 2 * P i j * (U - V) i j ^ 2 := by
    intro i j h
    rw [hXdef, sq_add_diag P d hP0, if_neg h, ← (hpq i j h).1]
    ring
  have hPP : ∀ i, (P * P) i i = ∑ l, P i l ^ 2 := fun i => by
    simp only [Matrix.mul_apply]; exact Finset.sum_congr rfl fun l _ => by rw [hs l i]; ring
  have hdiag : ∀ i, (X * X) i i = (∑ l, P i l ^ 2) + d i ^ 2 := by
    intro i; rw [hXdef, sq_add_diag P d hP0, if_pos rfl, hP0, hPP]; ring
  have hXii : ∀ i, X i i = d i := fun i => by simp [hXdef, hP0]
  have hXij : ∀ i j, i ≠ j → X i j = P i j := fun i j h => by
    simp [hXdef, Matrix.diagonal_apply_ne _ h]
  set δ : Fin m → ℝ := fun i => (∑ l, P i l ^ 2) + d i ^ 2 - d i with hδ
  have hle : ∀ i j, (X * X) i j ≤ X i j + if i = j then δ i else 0 := by
    intro i j
    by_cases h : i = j
    · subst h; rw [hdiag, hXii, if_pos rfl, hδ]; linarith
    · rw [hoff i j h, hXij i j h, if_neg h]; nlinarith [hPnn i j, sq_nonneg ((U - V) i j)]
  have hrow := HamiltonsCubic.I117.perron_row X δ w ρ hw hXw hle
  have hPsq : ∀ i, ∑ l, P i l ^ 2 ≤ 2 * d i := fun i => by
    rw [hddef]; unfold dvec; rw [Finset.mul_sum]
    exact Finset.sum_le_sum fun l _ => by
      simp only [hPdef, Matrix.add_apply]; nlinarith [sq_nonneg (U i l - V i l)]
  have part1 : ∀ i, ρ - 1 ≤ d i := fun i =>
    HamiltonsCubic.I117.perron_d ρ (d i) (hdnn i) (by have := hrow i; rw [hδ] at this; linarith [hPsq i])
  refine ⟨part1, ?_, ?_⟩
  · intro i hi
    have heq : ∀ j, (X * X) i j = X i j + if i = j then δ i else 0 := by
      intro j
      by_cases h : i = j
      · subst h; rw [hdiag, hXii, if_pos rfl, hδ]; ring
      · rw [hoff i j h, hXij i j h, if_neg h]
        have : (U - V) i j = 0 := by simp [Matrix.sub_apply, hi j]
        rw [this]; ring
    have h1 := HamiltonsCubic.I117.perron_row_eq X δ w ρ hw hXw i heq
    have hPsq_eq : ∑ l, P i l ^ 2 = 2 * d i := by
      rw [hddef]; unfold dvec; rw [Finset.mul_sum]
      exact Finset.sum_congr rfl fun l _ => by simp only [hPdef, Matrix.add_apply, hi l]; ring
    obtain ⟨j0, hj0⟩ := exists_ne i
    have hρpos : 0 < ρ := by
      have hsum : (X.mulVec w) i = ρ * w i := by have := congrFun hXw i; simpa using this
      have hge : X i j0 * w j0 ≤ (X.mulVec w) i := by
        simp only [Matrix.mulVec, dotProduct]
        exact Finset.single_le_sum (fun j _ => mul_nonneg (hXnn i j) (hw j).le) (Finset.mem_univ j0)
      have hpos0 : 0 < X i j0 * w j0 := mul_pos (by rw [hXij i j0 (Ne.symm hj0)]; exact hPpos i j0 (Ne.symm hj0)) (hw j0)
      have : 0 < ρ * w i := by linarith
      exact pos_of_mul_pos_left this (hw i).le
    exact HamiltonsCubic.I117.perron_d_eq ρ (d i) (by linarith [hdnn i]) (by rw [hδ] at h1; linarith)
  · have gs := ground_state X hXsym w (fun _ => 1) ρ hw hXw
    have hnn : 0 ≤ (1 / 2 : ℝ) * ∑ i, ∑ j, X i j * w i * w j * (1 / w i - 1 / w j) ^ 2 := by
      apply mul_nonneg (by norm_num)
      exact Finset.sum_nonneg fun i _ => Finset.sum_nonneg fun j _ =>
        mul_nonneg (mul_nonneg (mul_nonneg (hXnn i j) (hw i).le) (hw j).le) (sq_nonneg _)
    have hsumX : ∑ i, ∑ j, X i j * 1 * 1 = (∑ i, ∑ j, P i j) + ∑ i, d i := by
      rw [← Finset.sum_add_distrib]
      refine Finset.sum_congr rfl fun i _ => ?_
      simp only [hXdef, Matrix.add_apply, Matrix.diagonal_apply, mul_one, Finset.sum_add_distrib]
      simp
    have hone : ∑ i : Fin m, (fun _ => (1 : ℝ)) i ^ 2 = m := by simp
    have hd_sum : (m : ℝ) * (ρ - 1) ≤ ∑ i, d i := by
      have := Finset.sum_le_sum fun i (_ : i ∈ Finset.univ) => part1 i
      simp only [Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul] at this
      linarith
    have key : (∑ i, ∑ j, P i j) + ∑ i, d i ≤ (m : ℝ) * ρ := by
      have := gs; simp only [hone] at this; rw [hsumX] at this; linarith
    have hPUV : ∑ i, ∑ j, (U i j + V i j) = ∑ i, ∑ j, P i j := by simp [hPdef]
    rw [hPUV]; linarith


/-- **L272 (1).** At a solution, off the diagonal `X² = X - 2 P ∘ Q ∘ Q`, and `(X² - X)_ii = π_i + d_i² - d_i`
with `π_i = ∑_l P_il²`. -/
theorem L272_square (U V : Matrix (Fin m) (Fin m) ℝ) (hU : IsPairWeights U) (hV : IsPairWeights V)
    (hsys : TorusSystem U V) :
    let X := (U + V) + Matrix.diagonal (dvec U V)
    (∀ i j, i ≠ j → (X * X) i j = X i j - 2 * (U + V) i j * (U - V) i j ^ 2) ∧
      (∀ i, (X * X - X) i i = (∑ l, (U + V) i l ^ 2) + dvec U V i ^ 2 - dvec U V i) := by
  intro X
  obtain ⟨hUt, hU0⟩ := hU
  obtain ⟨hVt, hV0⟩ := hV
  have hsU : ∀ i j, U i j = U j i := fun i j => by rw [← Matrix.transpose_apply U j i, hUt]
  have hsV : ∀ i j, V i j = V j i := fun i j => by rw [← Matrix.transpose_apply V j i, hVt]
  have hP0 : ∀ i, (U + V) i i = 0 := fun i => by simp [hU0, hV0]
  refine ⟨fun i j hij => ?_, fun i => ?_⟩
  · have hpq := ((L271_pq_system U V).mp hsys i j hij).1
    show ((U + V + Matrix.diagonal (dvec U V)) * (U + V + Matrix.diagonal (dvec U V))) i j = _
    rw [sq_add_diag _ _ hP0, if_neg hij, ← hpq]
    simp only [X, Matrix.add_apply, Matrix.diagonal_apply_ne _ hij, Matrix.sub_apply]
    ring
  · have hl : ∀ l, (U + V) i l * (U + V) l i = (U + V) i l ^ 2 := fun l => by
      simp only [Matrix.add_apply]; rw [hsU l i, hsV l i]; ring
    show ((U + V + Matrix.diagonal (dvec U V)) * (U + V + Matrix.diagonal (dvec U V))
      - (U + V + Matrix.diagonal (dvec U V))) i i = _
    rw [Matrix.sub_apply, sq_add_diag _ _ hP0, if_pos rfl, Matrix.mul_apply,
      Finset.sum_congr rfl (fun l _ => hl l)]
    simp only [hP0, zero_mul, add_zero, Matrix.add_apply, Matrix.diagonal_apply_eq, hU0, hV0, zero_add]

/-! ## The Perron step (L272), from `psd_kernel` (the lean session's draft) and a maximiser on the sphere -/

section Perron

variable {κ : Type*} [Fintype κ] [DecidableEq κ]

/-- The quadratic form `xᵀ X x`. -/
def qf (X : Matrix (κ) (κ) ℝ) (x : κ → ℝ) : ℝ := ∑ i, ∑ j, X i j * x i * x j

/-- The squared length. -/
def nsq (x : κ → ℝ) : ℝ := ∑ i, x i ^ 2

theorem qf_smul (X : Matrix (κ) (κ) ℝ) (c : ℝ) (x : κ → ℝ) : qf X (c • x) = c ^ 2 * qf X x := by
  unfold qf; simp only [Pi.smul_apply, smul_eq_mul, Finset.mul_sum]
  exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by ring

theorem nsq_smul (c : ℝ) (x : κ → ℝ) : nsq (c • x) = c ^ 2 * nsq x := by
  unfold nsq; simp only [Pi.smul_apply, smul_eq_mul, Finset.mul_sum]
  exact Finset.sum_congr rfl fun i _ => by ring

/-- **A nonnegative symmetric form vanishing at `w` kills `w`** (drafted by the lean session). -/
theorem psd_kernel (B : Matrix (κ) (κ) ℝ) (hB : Bᵀ = B) (hpsd : ∀ z, 0 ≤ qf B z) {w : κ → ℝ}
    (hw : qf B w = 0) : B.mulVec w = 0 := by
  have expand : ∀ (y : κ → ℝ) (t : ℝ), qf B (w + t • y) = qf B w + 2 * t * (∑ i, y i * (B.mulVec w) i)
      + t ^ 2 * qf B y := by
    intro y t
    have hs : ∀ i j, B i j = B j i := fun i j => by rw [← Matrix.transpose_apply B j i, hB]
    have h4 : ∀ i j, B i j * (w i + t * y i) * (w j + t * y j) = B i j * w i * w j + t * (B i j * w i * y j)
        + t * (B i j * y i * w j) + t ^ 2 * (B i j * y i * y j) := fun i j => by ring
    have s1 : ∑ i, ∑ j, B i j * w i * y j = ∑ i, y i * (B.mulVec w) i := by
      rw [Finset.sum_comm]
      refine Finset.sum_congr rfl fun j _ => ?_
      simp only [Matrix.mulVec, dotProduct, Finset.mul_sum]
      exact Finset.sum_congr rfl fun i _ => by rw [hs i j]; ring
    have s2 : ∑ i, ∑ j, B i j * y i * w j = ∑ i, y i * (B.mulVec w) i := by
      refine Finset.sum_congr rfl fun i _ => ?_
      simp only [Matrix.mulVec, dotProduct, Finset.mul_sum]
      exact Finset.sum_congr rfl fun j _ => by ring
    simp only [qf, Pi.add_apply, Pi.smul_apply, smul_eq_mul, h4, Finset.sum_add_distrib, ← Finset.mul_sum, s1, s2]
    ring
  set v := B.mulVec w
  have hlin : ∀ y : κ → ℝ, ∑ i, y i * v i = 0 := by
    intro y
    set a := ∑ i, y i * v i
    set b := qf B y
    have hq : ∀ t : ℝ, 0 ≤ 2 * t * a + t ^ 2 * b := fun t => by
      have := hpsd (w + t • y); rw [expand, hw] at this; linarith
    by_contra ha
    set c := |b| + 1 with hcdef
    have hc : 0 < c := by positivity
    have hbc : b < c := by have := le_abs_self b; linarith
    have ha2 : 0 < a ^ 2 := by positivity
    set s := -a / c
    have hsc : s * c = -a := by simp only [s]; field_simp
    have h0 := hq s
    have hmul : (2 * s * a + s ^ 2 * b) * c ^ 2 = -2 * a ^ 2 * c + a ^ 2 * b := by
      have : (2 * s * a + s ^ 2 * b) * c ^ 2 = 2 * a * c * (s * c) + (s * c) ^ 2 * b := by ring
      rw [this, hsc]; ring
    have hneg : (2 * s * a + s ^ 2 * b) * c ^ 2 < 0 := by rw [hmul]; nlinarith
    have : 0 ≤ (2 * s * a + s ^ 2 * b) * c ^ 2 := mul_nonneg h0 (by positivity)
    linarith
  funext i
  have := hlin (fun k => v k)
  have hsq : ∑ k, v k ^ 2 = 0 := by rw [← this]; exact Finset.sum_congr rfl fun k _ => by ring
  have hz := (Finset.sum_eq_zero_iff_of_nonneg (fun k _ => sq_nonneg (v k))).mp hsq i (Finset.mem_univ i)
  simpa using hz

/-- The unit sphere of `κ → ℝ` is compact. -/
theorem sphere_compact : IsCompact {x : κ → ℝ | nsq x = 1} := by
  apply Metric.isCompact_of_isClosed_isBounded
  · exact isClosed_eq (by unfold nsq; fun_prop) continuous_const
  · refine (Metric.isBounded_iff_subset_closedBall (0 : κ → ℝ)).mpr ⟨1, fun x hx => ?_⟩
    rw [Metric.mem_closedBall, dist_zero_right]
    refine (pi_norm_le_iff_of_nonneg zero_le_one).mpr fun i => ?_
    have hi : x i ^ 2 ≤ nsq x :=
      Finset.single_le_sum (f := fun j => x j ^ 2) (fun j _ => sq_nonneg (x j)) (Finset.mem_univ i)
    have hx1 : nsq x = 1 := hx
    rw [Real.norm_eq_abs]
    have h2 : |x i| ^ 2 ≤ 1 := by rw [sq_abs]; linarith
    nlinarith [abs_nonneg (x i)]

/-- `qf` of `c I - X` splits. -/
theorem qf_diag_sub (X : Matrix (κ) (κ) ℝ) (c : ℝ) (z : κ → ℝ) :
    qf (Matrix.diagonal (fun _ => c) - X) z = c * nsq z - qf X z := by
  unfold qf nsq
  simp only [Matrix.sub_apply, Matrix.diagonal_apply, sub_mul, Finset.sum_sub_distrib, ite_mul, zero_mul,
    Finset.sum_ite_eq, Finset.mem_univ, if_true, Finset.mul_sum]
  congr 1
  exact Finset.sum_congr rfl fun i _ => by ring

/-- On the unit sphere's maximiser the form is bounded by its value times the squared length. -/
theorem qf_le_of_max (X : Matrix (κ) (κ) ℝ) (lam : ℝ) (hmax : ∀ u, nsq u = 1 → qf X u ≤ lam)
    (z : κ → ℝ) : qf X z ≤ lam * nsq z := by
  have hz0 : 0 ≤ nsq z := Finset.sum_nonneg fun i _ => sq_nonneg (z i)
  rcases hz0.lt_or_eq with hpos | hzero
  · set c := Real.sqrt (nsq z) with hc
    have hcpos : 0 < c := Real.sqrt_pos.mpr hpos
    have hc2 : c ^ 2 = nsq z := Real.sq_sqrt hz0
    have hu : nsq (c⁻¹ • z) = 1 := by
      rw [nsq_smul, inv_pow, hc2, inv_mul_cancel₀ hpos.ne']
    have h := hmax _ hu
    rw [qf_smul, inv_pow, hc2] at h
    have := (inv_mul_le_iff₀ hpos).mp h
    linarith
  · have hzi : ∀ i, z i = 0 := fun i => by
      have := (Finset.sum_eq_zero_iff_of_nonneg (fun k _ => sq_nonneg (z k))).mp hzero.symm i
        (Finset.mem_univ i)
      exact pow_eq_zero_iff (n := 2) (by norm_num) |>.mp this
    have : qf X z = 0 := by simp [qf, hzi]
    rw [this, ← hzero]; simp

end Perron

/-- **L272, the Perron step it needs**: a symmetric matrix with positive off-diagonal entries has a positive
eigenvector. *Mathlib has no Perron–Frobenius theorem; this is the case the torus family uses.* -/
theorem perron_positive_eigvec {κ : Type*} [Fintype κ] [DecidableEq κ] [Nonempty κ] (X : Matrix κ κ ℝ) (hX : Xᵀ = X)
    (hoff : ∀ i j, i ≠ j → 0 < X i j) :
    ∃ (ρ : ℝ) (w : κ → ℝ), (∀ i, 0 < w i) ∧ X.mulVec w = ρ • w := by
  set i0 : κ := Classical.arbitrary κ
  obtain ⟨x0, hx0S, hmax⟩ := (sphere_compact (κ := κ)).exists_isMaxOn
    ⟨fun j => if j = i0 then 1 else 0, by simp [nsq]⟩
    ((by unfold qf; fun_prop : Continuous (qf X)).continuousOn)
  have hx0 : nsq x0 = 1 := hx0S
  set lam := qf X x0
  have hmax' : ∀ u, nsq u = 1 → qf X u ≤ lam := fun u hu => isMaxOn_iff.mp hmax u hu
  set w : κ → ℝ := fun i => |x0 i| with hwdef
  have hw1 : nsq w = 1 := by rw [← hx0]; simp [nsq, hwdef, sq_abs]
  have hge : lam ≤ qf X w := by
    refine Finset.sum_le_sum fun i _ => Finset.sum_le_sum fun j _ => ?_
    by_cases hij : i = j
    · subst hij; simp only [hwdef, mul_assoc, abs_mul_abs_self, le_refl]
    · have := hoff i j hij
      have h2 : x0 i * x0 j ≤ |x0 i| * |x0 j| := by rw [← abs_mul]; exact le_abs_self _
      simp only [hwdef, mul_assoc]
      exact mul_le_mul_of_nonneg_left h2 this.le
  set B := Matrix.diagonal (fun _ : κ => lam) - X with hBdef
  have hBt : Bᵀ = B := by rw [hBdef, Matrix.transpose_sub, Matrix.diagonal_transpose, hX]
  have hpsd : ∀ z, 0 ≤ qf B z := fun z => by
    rw [hBdef, qf_diag_sub]; linarith [qf_le_of_max X lam hmax' z]
  have hBw : qf B w = 0 := by
    rw [hBdef, qf_diag_sub, hw1]; linarith [hmax' w hw1]
  have hker := psd_kernel B hBt hpsd hBw
  have hXw : X.mulVec w = lam • w := by
    rw [hBdef, Matrix.sub_mulVec] at hker
    funext i
    have := congrFun hker i
    simp only [Pi.sub_apply, Matrix.mulVec_diagonal, Pi.zero_apply] at this
    simp only [Pi.smul_apply, smul_eq_mul]
    linarith
  refine ⟨lam, w, fun i => ?_, hXw⟩
  have hwi : 0 ≤ w i := abs_nonneg _
  rcases hwi.lt_or_eq with h | h
  · exact h
  · exfalso
    have hrow : ∑ j, X i j * w j = 0 := by
      have := congrFun hXw i
      simp only [Matrix.mulVec, dotProduct, Pi.smul_apply, smul_eq_mul] at this
      rw [this, ← h, mul_zero]
    have hnn : ∀ j ∈ Finset.univ, 0 ≤ X i j * w j := fun j _ => by
      by_cases hij : i = j
      · subst hij; rw [← h, mul_zero]
      · exact mul_nonneg (hoff i j hij).le (abs_nonneg _)
    have hz := (Finset.sum_eq_zero_iff_of_nonneg hnn).mp hrow
    have hall : ∀ j, w j = 0 := fun j => by
      by_cases hij : i = j
      · subst hij; exact h.symm
      · exact (mul_eq_zero.mp (hz j (Finset.mem_univ j))).resolve_left (hoff i j hij).ne'
    have : nsq w = 0 := by simp [nsq, hall]
    linarith

/-- **Uniqueness of the positive eigenvector's ray**: for symmetric `X` with positive off-diagonal entries and a
positive eigenvector `w`, every eigenvector `v` of the same eigenvalue is proportional to `w`. -/
theorem perron_unique {κ : Type*} [Fintype κ] [DecidableEq κ] (X : Matrix κ κ ℝ) (hX : Xᵀ = X)
    (hoff : ∀ i j, i ≠ j → 0 < X i j) (w v : κ → ℝ) (ρ : ℝ) (hw : ∀ i, 0 < w i) (hXw : X.mulVec w = ρ • w) (hXv : X.mulVec v = ρ • v) :
    ∀ i j, v i * w j = v j * w i := by
  have hgs := ground_state X hX w v ρ hw hXw
  have hlhs : ρ * ∑ i, v i ^ 2 - ∑ i, ∑ j, X i j * v i * v j = 0 := by
    have : ∀ i, ∑ j, X i j * v i * v j = v i * (ρ * v i) := fun i => by
      have h := congrFun hXv i
      simp only [Matrix.mulVec, dotProduct, Pi.smul_apply, smul_eq_mul] at h
      rw [← h, Finset.mul_sum]; exact Finset.sum_congr rfl fun j _ => by ring
    simp only [this, Finset.mul_sum]; rw [← Finset.sum_sub_distrib]
    exact Finset.sum_eq_zero fun i _ => by ring
  rw [hlhs] at hgs
  have hterm : ∀ i j, 0 ≤ X i j * w i * w j * (v i / w i - v j / w j) ^ 2 := fun i j => by
    by_cases hij : i = j
    · subst hij; simp
    · have := hoff i j hij; have := hw i; have := hw j; positivity
  have hsum : ∑ i, ∑ j, X i j * w i * w j * (v i / w i - v j / w j) ^ 2 = 0 := by linarith
  intro i j
  by_cases hij : i = j
  · subst hij; ring
  have h1 := (Finset.sum_eq_zero_iff_of_nonneg (fun i _ => Finset.sum_nonneg fun j _ => hterm i j)).mp hsum i
    (Finset.mem_univ i)
  have h2 := (Finset.sum_eq_zero_iff_of_nonneg (fun j _ => hterm i j)).mp h1 j (Finset.mem_univ j)
  have hpos : 0 < X i j * w i * w j := by have := hoff i j hij; have := hw i; have := hw j; positivity
  have h3 : (v i / w i - v j / w j) ^ 2 = 0 := (mul_eq_zero.mp h2).resolve_left hpos.ne'
  have h4 : v i / w i = v j / w j := by nlinarith [sq_nonneg (v i / w i - v j / w j)]
  have := hw i; have := hw j
  field_simp at h4; linarith

/-- **L271 (3).** A positive solution with `U = V` (that is `Q = 0`) is the uniform point `μ ≡ 1/(2(m - 1))`. -/
theorem L271_Q_zero (hm : 3 ≤ m) (U : Matrix (Fin m) (Fin m) ℝ) (hU : IsPairWeights U)
    (hpos : ∀ i j, i ≠ j → 0 < U i j) (hsys : TorusSystem U U) :
    ∀ i j, i ≠ j → U i j = 1 / (2 * ((m : ℝ) - 1)) := by
  obtain ⟨hUt, hU0⟩ := hU
  have hs : ∀ i j, U i j = U j i := fun i j => by rw [← Matrix.transpose_apply U j i, hUt]
  set X := (U + U) + Matrix.diagonal (dvec U U) with hXdef
  have hXt : Xᵀ = X := by
    rw [hXdef, Matrix.transpose_add, Matrix.transpose_add, hUt, Matrix.diagonal_transpose]
  have hXoff : ∀ i j, i ≠ j → 0 < X i j := fun i j hij => by
    simp only [hXdef, Matrix.add_apply, Matrix.diagonal_apply_ne _ hij, add_zero]; linarith [hpos i j hij]
  haveI : Nonempty (Fin m) := ⟨⟨0, by omega⟩⟩
  obtain ⟨ρ, w, hw, hXw⟩ := perron_positive_eigvec X hXt hXoff
  have hL := L272_perron hm U U ⟨hUt, hU0⟩ ⟨hUt, hU0⟩ (fun i j hij => ⟨hpos i j hij, hpos i j hij⟩) hsys ρ
    ⟨w, hw, hXw⟩
  set δ := ρ - 1 with hδ
  have hd : ∀ i, dvec U U i = δ := fun i => hL.2.1 i (fun l => rfl)
  set k0 : Fin m := ⟨0, by omega⟩
  set k1 : Fin m := ⟨1, by omega⟩
  have hk01 : k0 ≠ k1 := by simp [k0, k1, Fin.ext_iff]
  have hδpos : 0 < δ := by
    rw [← hd k0]; unfold dvec
    have hnn : ∀ l ∈ Finset.univ, 0 ≤ U k0 l ^ 2 + U k0 l ^ 2 := fun l _ => by positivity
    have := Finset.single_le_sum hnn (Finset.mem_univ k1)
    have := hpos k0 k1 hk01
    nlinarith
  have hdiag : ∀ i, (U * U) i i = δ / 2 := fun i => by
    rw [Matrix.mul_apply, ← hd i]; unfold dvec; rw [Finset.sum_div]
    exact Finset.sum_congr rfl fun l _ => by rw [hs l i]; ring
  have hoffeq : ∀ i j, i ≠ j → 2 * (U * U) i j = U i j * (1 - 2 * δ) := fun i j hij => by
    have := (hsys i j hij).1
    simp only [Matrix.add_apply, hd] at this; linarith
  set N : Fin m → Fin m → ℝ := fun i k => U i k + if i = k then δ else 0 with hNdef
  have hcol : ∀ k, U.mulVec (fun i => N i k) = (1 / 2 : ℝ) • (fun i => N i k) := fun k => by
    funext i
    simp only [Matrix.mulVec, dotProduct, Pi.smul_apply, smul_eq_mul, hNdef, mul_add, Finset.sum_add_distrib,
      mul_ite, mul_zero, Finset.sum_ite_eq', Finset.mem_univ, if_true]
    rw [← Matrix.mul_apply]
    by_cases hik : i = k
    · subst hik; rw [hdiag, hU0, if_pos rfl]; ring
    · rw [if_neg hik]; have := hoffeq i k hik; linarith
  have hwpos : ∀ i, 0 < N i k0 := fun i => by
    by_cases h : i = k0
    · subst h; simp [hNdef, hU0, hδpos]
    · simp only [hNdef, if_neg h, add_zero]; exact hpos i k0 h
  have hrel : ∀ k i j, N i k * N j k0 = N j k * N i k0 := fun k =>
    perron_unique U hUt hpos (fun i => N i k0) (fun i => N i k) (1 / 2) hwpos (hcol k0) (hcol k)
  have hNd : ∀ i, N i i = δ := fun i => by simp [hNdef, hU0]
  have hNo : ∀ i j, i ≠ j → N i j = U i j := fun i j h => by simp [hNdef, h]
  have hcolk0 : ∀ j, N j k0 = δ := fun j => by
    by_cases h : j = k0
    · subst h; exact hNd _
    · have e := hrel j j k0
      rw [hNd, hNd, hNo k0 j (Ne.symm h), hs k0 j] at e
      rw [hNo j k0 h] at e ⊢
      have := hpos j k0 h
      nlinarith [sq_nonneg (U j k0 - δ), sq_nonneg (U j k0 + δ)]
  have hconst : ∀ i j, i ≠ j → U i j = δ := fun i j hij => by
    have e := hrel j i j
    rw [hcolk0, hcolk0, hNd, hNo i j hij] at e
    have := mul_right_cancel₀ hδpos.ne' e
    linarith
  have hsum : dvec U U k0 = ((m : ℝ) - 1) * (2 * δ ^ 2) := by
    unfold dvec
    exact sum_off_one k0 _ _ (fun l hl => by rw [hconst k0 l (Ne.symm hl)]; ring) (by rw [hU0]; ring)
  rw [hd k0] at hsum
  have hm1 : (0 : ℝ) < (m : ℝ) - 1 := by
    have : (3 : ℝ) ≤ m := by exact_mod_cast hm
    linarith
  intro i j hij
  rw [hconst i j hij]
  field_simp
  nlinarith [hsum, hδpos]

end Torus

/-! ## The results stated for a compact simple `𝔥`, at `𝔥 = 𝔰𝔬(n)` (L260, L261, L264 to L267), and L254 -/

section SoN

/-- The polarised product `A # B`, from `sharpMapCL`, so that `A # A = sharpMapCL A`. -/
noncomputable def sharpB (A B : CurvOp2 ι) : CurvOp2 ι :=
  (1 / 2 : ℝ) • (sharpMapCL (A + B) - sharpMapCL A - sharpMapCL B)

/-- The record's `κ_n = (n - 2)/√N`, `N = n(n - 1)/2`, as the bound statement H asserts. -/
noncomputable def kappaN (ι : Type*) [Fintype ι] : ℝ :=
  ((Fintype.card ι : ℝ) - 2) / Real.sqrt ((Fintype.card ι : ℝ) * ((Fintype.card ι : ℝ) - 1) / 2)

/-- **Statement H** on `𝔰𝔬(n)`: `F(X, X, X) ≤ κ_n ‖X‖³` for every self-adjoint `X`. -/
def StatementH (ι : Type*) [Fintype ι] [DecidableEq ι] : Prop :=
  ∀ X : CurvOp2 ι, IsSelfAdjoint2 X → Ftri X X X ≤ kappaN ι * normSq2 X ^ ((3 : ℝ) / 2)

/-- The coordinate-diagonal operator with weights `a`, acting entrywise on a skew matrix. -/
noncomputable def coordOp (a : Matrix ι ι ℝ) : CurvOp2 ι :=
  LinearMap.toContinuousLinearMap
    { toFun := fun X => ⟨skewPartM (a ⊙ (X : Matrix ι ι ℝ)), skewPartM_mem _⟩
      map_add' := fun X Y => by
        apply Subtype.ext
        show skewPartM (a ⊙ ((X + Y : skewSub ι) : Matrix ι ι ℝ))
          = skewPartM (a ⊙ (X : Matrix ι ι ℝ)) + skewPartM (a ⊙ (Y : Matrix ι ι ℝ))
        rw [Submodule.coe_add, Matrix.hadamard_add]; unfold skewPartM; rw [Matrix.transpose_add]; module
      map_smul' := fun c X => by
        apply Subtype.ext
        show skewPartM (a ⊙ ((c • X : skewSub ι) : Matrix ι ι ℝ)) = c • skewPartM (a ⊙ (X : Matrix ι ι ℝ))
        rw [Submodule.coe_smul, Matrix.hadamard_smul]; unfold skewPartM; rw [Matrix.transpose_smul]; module }

/-! ## `#` on coordinate-diagonal operators: `(a ⊙ ·) # (a ⊙ ·) = (a ⋆ a) ⊙ ·`, `(a ⋆ a)_xy = ∑_k a_xk a_ky` -/

/-- The weights of `coordOp a # coordOp a`. -/
noncomputable def starW (a : Matrix ι ι ℝ) : Matrix ι ι ℝ := fun x y => ∑ k, a x k * a k y

theorem starW_symm (a : Matrix ι ι ℝ) (ha : aᵀ = a) : (starW a)ᵀ = starW a := by
  have hs : ∀ i j, a i j = a j i := fun i j => by rw [← Matrix.transpose_apply a j i, ha]
  ext x y
  simp only [starW, Matrix.transpose_apply]
  exact Finset.sum_congr rfl fun k _ => by rw [hs y k, hs k x]; ring

theorem hadamard_skew (a X : Matrix ι ι ℝ) (ha : aᵀ = a) (hX : Xᵀ = -X) : (a ⊙ X)ᵀ = -(a ⊙ X) := by
  have hs : ∀ i j, a i j = a j i := fun i j => by rw [← Matrix.transpose_apply a j i, ha]
  ext x y
  have := congrFun (congrFun hX x) y
  simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
  simp only [Matrix.transpose_apply, Matrix.neg_apply, Matrix.hadamard_apply, this, hs y x]
  ring

/-- For symmetric weights the coordinate operator is the Hadamard product on bivectors. -/
theorem coordOp_coe (a : Matrix ι ι ℝ) (ha : aᵀ = a) (X : skewSub ι) :
    ((coordOp a X : skewSub ι) : Matrix ι ι ℝ) = a ⊙ (X : Matrix ι ι ℝ) := by
  show skewPartM (a ⊙ (X : Matrix ι ι ℝ)) = a ⊙ (X : Matrix ι ι ℝ)
  exact skewPartM_of_skew _ (hadamard_skew a _ ha X.2)

theorem hadamard_phi (a : Matrix ι ι ℝ) (ha : aᵀ = a) (i j : ι) : a ⊙ phi i j = a i j • phi i j := by
  have hs : ∀ i j, a i j = a j i := fun i j => by rw [← Matrix.transpose_apply a j i, ha]
  ext x y
  simp only [Matrix.hadamard_apply, Matrix.smul_apply, phi, Matrix.sub_apply, Matrix.single_apply, smul_eq_mul]
  by_cases h1 : j = x ∧ i = y
  · obtain ⟨rfl, rfl⟩ := h1; rw [hs]; try simp
  · by_cases h2 : i = x ∧ j = y
    · obtain ⟨rfl, rfl⟩ := h2; simp [h1]
    · simp [h1, h2]

/-- The bracket with `φ_ij`, entrywise. -/
theorem br_phi_apply (η : Matrix ι ι ℝ) (i j x y : ι) :
    br η (phi i j) x y = η x j * (if i = y then 1 else 0) - η x i * (if j = y then 1 else 0)
      - (if j = x then 1 else 0) * η i y + (if i = x then 1 else 0) * η j y := by
  simp only [br, Matrix.sub_apply, Matrix.mul_apply, phi, Matrix.single_apply, mul_sub, sub_mul,
    Finset.sum_sub_distrib, mul_ite, ite_mul, mul_one, one_mul, mul_zero, zero_mul, ite_and]
  simp [Finset.sum_ite_eq, Finset.sum_ite_eq']
  split_ifs <;> ring

theorem br_phi_sq_pt (a η : Matrix ι ι ℝ) (ha0 : ∀ x, a x x = 0) (hη0 : ∀ x, η x x = 0) {i j : ι} (hij : i ≠ j)
    (x y : ι) : a x y * br η (phi i j) x y ^ 2
      = a x y * ((if i = y then η x j ^ 2 else 0) + (if j = y then η x i ^ 2 else 0)
        + (if j = x then η i y ^ 2 else 0) + (if i = x then η j y ^ 2 else 0)) := by
  rw [br_phi_apply]
  split_ifs <;> subst_vars <;> simp_all <;> ring

theorem sum_ite_outer (j : ι) (f : ι → ι → ℝ) : ∑ x, ∑ y, (if j = x then f x y else 0) = ∑ y, f j y := by
  rw [Finset.sum_congr rfl fun x _ => (show (∑ y, (if j = x then f x y else 0)) = if j = x then ∑ y, f x y else 0 by
    split_ifs <;> simp)]
  rw [Finset.sum_ite_eq]; simp

/-- The weighted square of `[η, φ_ij]` collapses to the rows `i` and `j` of `η`. -/
theorem weighted_br_phi_sq (a η : Matrix ι ι ℝ) (ha : aᵀ = a) (ha0 : ∀ x, a x x = 0) (hη : ηᵀ = -η)
    {i j : ι} (hij : i ≠ j) :
    ∑ x, ∑ y, a x y * br η (phi i j) x y ^ 2 = 2 * ∑ c, (a c i * η c j ^ 2 + a c j * η c i ^ 2) := by
  have hs : ∀ x y, a x y = a y x := fun x y => by rw [← Matrix.transpose_apply a y x, ha]
  have hη' : ∀ x y, η y x = -η x y := fun x y => by
    have := congrFun (congrFun hη x) y; simpa [Matrix.transpose_apply] using this
  have hη0 : ∀ x, η x x = 0 := fun x => by have := hη' x x; linarith
  simp only [br_phi_sq_pt a η ha0 hη0 hij, mul_add, Finset.sum_add_distrib, mul_ite, mul_zero, Finset.sum_ite_eq,
    Finset.mem_univ, if_true, sum_ite_outer]
  have e1 : ∑ y, a j y * η i y ^ 2 = ∑ c, a c j * η c i ^ 2 :=
    Finset.sum_congr rfl fun c _ => by rw [hs j c, hη' c i]; ring
  have e2 : ∑ y, a i y * η j y ^ 2 = ∑ c, a c i * η c j ^ 2 :=
    Finset.sum_congr rfl fun c _ => by rw [hs i c, hη' c j]; ring
  rw [e1, e2]
  ring

/-- **`⟨(a ⊙ ·)#η, η⟩ = ½ ∑_{x,y} (a ⋆ a)_xy η_xy²`** for symmetric weights with zero diagonal. -/
theorem sharpQF2_coordOp (a : Matrix ι ι ℝ) (ha : aᵀ = a) (ha0 : ∀ x, a x x = 0) (η : skewSub ι) :
    sharpQF2 (coordOp a) η = (1 / 2) * ∑ x, ∑ y, starW a x y * (η : Matrix ι ι ℝ) x y ^ 2 := by
  have hη : (η : Matrix ι ι ℝ)ᵀ = -η := η.2
  have hη' : ∀ x y, (η : Matrix ι ι ℝ) y x = -(η : Matrix ι ι ℝ) x y := fun x y => by
    have := congrFun (congrFun hη x) y; simpa [Matrix.transpose_apply] using this
  unfold sharpQF2
  have hterm : ∀ i j : ι, inner2 ((brS η (coordOp a (brS η (coordOp a ⟨phi i j, phi_mem_skewSub i j⟩))) :
      skewSub ι) : Matrix ι ι ℝ) (phi i j)
      = -(a i j * ((1 / 2) * ∑ x, ∑ y, a x y * br (η : Matrix ι ι ℝ) (phi i j) x y ^ 2)) := by
    intro i j
    have hM : IsSkew (br (η : Matrix ι ι ℝ) (phi i j)) := (brS η ⟨phi i j, phi_mem_skewSub i j⟩).2
    have c1 : ((coordOp a ⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι) : Matrix ι ι ℝ) = a i j • phi i j := by
      rw [coordOp_coe a ha]; exact hadamard_phi a ha i j
    have c2 : ((brS η (coordOp a ⟨phi i j, phi_mem_skewSub i j⟩) : skewSub ι) : Matrix ι ι ℝ)
        = a i j • br (η : Matrix ι ι ℝ) (phi i j) := by
      show br (η : Matrix ι ι ℝ) _ = _
      rw [c1]; simp [br, Matrix.mul_smul, Matrix.smul_mul, smul_sub]
    have c3 : ((coordOp a (brS η (coordOp a ⟨phi i j, phi_mem_skewSub i j⟩)) : skewSub ι) : Matrix ι ι ℝ)
        = a i j • (a ⊙ br (η : Matrix ι ι ℝ) (phi i j)) := by
      rw [coordOp_coe a ha, c2, Matrix.hadamard_smul]
    have c4 : ((brS η (coordOp a (brS η (coordOp a ⟨phi i j, phi_mem_skewSub i j⟩))) : skewSub ι) :
        Matrix ι ι ℝ) = a i j • br (η : Matrix ι ι ℝ) (a ⊙ br (η : Matrix ι ι ℝ) (phi i j)) := by
      show br (η : Matrix ι ι ℝ) _ = _
      rw [c3]; simp [br, Matrix.mul_smul, Matrix.smul_mul, smul_sub]
    rw [c4]
    have hAM : IsSkew (a ⊙ br (η : Matrix ι ι ℝ) (phi i j)) := hadamard_skew a _ ha hM
    have adj := HamiltonsCubic.L33Statement.ad_skewAdjoint hAM η.2 (phi_isSkew i j)
    rw [inner2_eq_sum, inner2_eq_sum] at adj
    rw [inner2_eq_sum]
    simp only [Matrix.smul_apply, smul_eq_mul]
    have e : ∑ x, ∑ y, a i j * br (η : Matrix ι ι ℝ) (a ⊙ br (η : Matrix ι ι ℝ) (phi i j)) x y * phi i j x y
        = a i j * ∑ x, ∑ y, br (η : Matrix ι ι ℝ) (a ⊙ br (η : Matrix ι ι ℝ) (phi i j)) x y * phi i j x y := by
      rw [Finset.mul_sum]
      refine Finset.sum_congr rfl fun x _ => ?_
      rw [Finset.mul_sum]
      refine Finset.sum_congr rfl fun y _ => ?_
      ring
    rw [e]
    have adj' : ∑ x, ∑ y, br (η : Matrix ι ι ℝ) (a ⊙ br (η : Matrix ι ι ℝ) (phi i j)) x y * phi i j x y
        = -∑ x, ∑ y, (a ⊙ br (η : Matrix ι ι ℝ) (phi i j)) x y * br (η : Matrix ι ι ℝ) (phi i j) x y := by
      linarith
    rw [adj']
    simp only [Matrix.hadamard_apply]
    have e2 : ∑ x, ∑ y, a x y * br (η : Matrix ι ι ℝ) (phi i j) x y * br (η : Matrix ι ι ℝ) (phi i j) x y
        = ∑ x, ∑ y, a x y * br (η : Matrix ι ι ℝ) (phi i j) x y ^ 2 :=
      Finset.sum_congr rfl fun x _ => Finset.sum_congr rfl fun y _ => by ring
    rw [e2]; ring
  simp only [hterm]
  have hpt : ∀ i j : ι, a i j * ∑ x, ∑ y, a x y * br (η : Matrix ι ι ℝ) (phi i j) x y ^ 2
      = a i j * (2 * ∑ c, (a c i * (η : Matrix ι ι ℝ) c j ^ 2 + a c j * (η : Matrix ι ι ℝ) c i ^ 2)) := by
    intro i j
    by_cases hij : i = j
    · subst hij; rw [ha0]; ring
    · rw [weighted_br_phi_sq a _ ha ha0 hη hij]
  have e : ∀ i j : ι, a i j * ((1 / 2) * ∑ x, ∑ y, a x y * br (η : Matrix ι ι ℝ) (phi i j) x y ^ 2)
      = ∑ c, a i j * (a c i * (η : Matrix ι ι ℝ) c j ^ 2) + ∑ c, a i j * (a c j * (η : Matrix ι ι ℝ) c i ^ 2) := by
    intro i j
    have := hpt i j
    have h2 : ∑ c, a i j * (a c i * (η : Matrix ι ι ℝ) c j ^ 2) + ∑ c, a i j * (a c j * (η : Matrix ι ι ℝ) c i ^ 2)
        = a i j * ∑ c, (a c i * (η : Matrix ι ι ℝ) c j ^ 2 + a c j * (η : Matrix ι ι ℝ) c i ^ 2) := by
      rw [Finset.mul_sum, ← Finset.sum_add_distrib]
      exact Finset.sum_congr rfl fun c _ => by ring
    rw [h2]
    linear_combination (1 / 2) * this
  have hS : ∑ x, ∑ y, starW a x y * (η : Matrix ι ι ℝ) x y ^ 2
      = ∑ c, ∑ j, ∑ i, a c i * a i j * (η : Matrix ι ι ℝ) c j ^ 2 := by
    simp only [starW, Finset.sum_mul]
  have s1 : ∑ i, ∑ j, ∑ c, a i j * (a c i * (η : Matrix ι ι ℝ) c j ^ 2)
      = ∑ c, ∑ j, ∑ i, a c i * a i j * (η : Matrix ι ι ℝ) c j ^ 2 := by
    rw [Finset.sum_comm, Finset.sum_congr rfl fun j _ => Finset.sum_comm, Finset.sum_comm]
    exact Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun i _ => by ring
  have s2 : ∑ i, ∑ j, ∑ c, a i j * (a c j * (η : Matrix ι ι ℝ) c i ^ 2)
      = ∑ c, ∑ j, ∑ i, a c i * a i j * (η : Matrix ι ι ℝ) c j ^ 2 := by
    rw [Finset.sum_congr rfl fun i _ => Finset.sum_comm, Finset.sum_comm]
    refine Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
    have hs : a i j = a j i := by rw [← Matrix.transpose_apply a j i, ha]
    rw [hs]; ring
  have hsum : ∑ i, ∑ j, a i j * ((1 / 2) * ∑ x, ∑ y, a x y * br (η : Matrix ι ι ℝ) (phi i j) x y ^ 2)
      = 2 * ∑ x, ∑ y, starW a x y * (η : Matrix ι ι ℝ) x y ^ 2 := by
    simp only [e, Finset.sum_add_distrib]
    rw [s1, s2, hS]; ring
  have hneg : ∑ i, ∑ j, -(a i j * ((1 / 2) * ∑ x, ∑ y, a x y * br (η : Matrix ι ι ℝ) (phi i j) x y ^ 2))
      = -∑ i, ∑ j, a i j * ((1 / 2) * ∑ x, ∑ y, a x y * br (η : Matrix ι ι ℝ) (phi i j) x y ^ 2) := by
    simp only [Finset.sum_neg_distrib]
  rw [hneg, hsum]; ring

theorem sharpBil2_coordOp (a : Matrix ι ι ℝ) (ha : aᵀ = a) (ha0 : ∀ x, a x x = 0) (X Y : skewSub ι) :
    sharpBil2 (coordOp a) X Y = inner2 (starW a ⊙ (X : Matrix ι ι ℝ)) Y := by
  unfold sharpBil2
  rw [sharpQF2_coordOp a ha ha0, sharpQF2_coordOp a ha ha0, sharpQF2_coordOp a ha ha0, inner2_eq_sum]
  simp only [Submodule.coe_add, Matrix.add_apply, Matrix.hadamard_apply, Finset.mul_sum, ← Finset.sum_sub_distrib]
  refine Finset.sum_congr rfl fun x _ => Finset.sum_congr rfl fun y _ => ?_
  ring

/-- **`(a ⊙ ·) # (a ⊙ ·) = (a ⋆ a) ⊙ ·`** as operators on bivectors, for symmetric weights with zero diagonal. -/
theorem sharpMapCL_coordOp (a : Matrix ι ι ℝ) (ha : aᵀ = a) (ha0 : ∀ x, a x x = 0) :
    sharpMapCL (coordOp a) = coordOp (starW a) := by
  refine ContinuousLinearMap.ext fun X => ?_
  rw [sharpMapCL_apply]
  unfold sharpMap
  simp_rw [sharpBil2_coordOp a ha ha0]
  set Z : skewSub ι := ⟨starW a ⊙ (X : Matrix ι ι ℝ), hadamard_skew _ _ (starW_symm a ha) X.2⟩ with hZ
  have hZe := skew_expand_sub Z
  have e : ∀ i j : ι, inner2 (starW a ⊙ (X : Matrix ι ι ℝ)) (phi i j) = inner2 (Z : Matrix ι ι ℝ) (phi i j) :=
    fun i j => rfl
  simp_rw [e]
  rw [hZe]
  apply Subtype.ext
  rw [coordOp_coe (starW a) (starW_symm a ha)]

/-- Weights off the diagonal only: the diagonal of a coordinate operator is invisible on bivectors. -/
noncomputable def offDiag (a : Matrix ι ι ℝ) : Matrix ι ι ℝ := fun i j => if i = j then 0 else a i j

theorem coordOp_offDiag (a : Matrix ι ι ℝ) : coordOp (offDiag a) = coordOp a := by
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  have hX : (X : Matrix ι ι ℝ)ᵀ = -X := X.2
  have h0 : ∀ x, (X : Matrix ι ι ℝ) x x = 0 := fun x => by
    have := congrFun (congrFun hX x) x
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this; linarith
  show skewPartM (offDiag a ⊙ (X : Matrix ι ι ℝ)) = skewPartM (a ⊙ (X : Matrix ι ι ℝ))
  congr 1
  ext x y
  simp only [Matrix.hadamard_apply, offDiag]
  split_ifs with h
  · subst h; rw [h0]; ring
  · rfl

/-- A sum over `ι` vanishing at `i ≠ j` and constant `c` elsewhere is `(|ι| - 2) c`. -/
theorem sum_off_two_gen {i j : ι} (hij : i ≠ j) (c : ℝ) (f : ι → ℝ) (hf : ∀ l, l ≠ i → l ≠ j → f l = c)
    (hi : f i = 0) (hj : f j = 0) : ∑ l, f l = ((Fintype.card ι : ℝ) - 2) * c := by
  have hjm : j ∈ Finset.univ.erase i := Finset.mem_erase.mpr ⟨hij.symm, Finset.mem_univ j⟩
  rw [← Finset.add_sum_erase _ _ (Finset.mem_univ i), hi, zero_add, ← Finset.add_sum_erase _ _ hjm, hj, zero_add,
    Finset.sum_congr rfl (fun l hl => hf l (Finset.ne_of_mem_erase (Finset.mem_of_mem_erase hl))
      (Finset.ne_of_mem_erase hl)), Finset.sum_const, Finset.card_erase_of_mem hjm,
    Finset.card_erase_of_mem (Finset.mem_univ i), Finset.card_univ, nsmul_eq_mul]
  have h2 : 2 ≤ Fintype.card ι := Fintype.one_lt_card_iff_nontrivial.mpr ⟨i, j, hij⟩
  rw [Nat.cast_sub (by omega), Nat.cast_sub (by omega)]; push_cast; ring

/-- **L261.** A coordinate-diagonal `#`-idempotent with every weight positive is `I/(n - 2)`. -/
theorem L261_coord_diag (hn : 3 ≤ Fintype.card ι) (a : Matrix ι ι ℝ) (ha : aᵀ = a)
    (hpos : ∀ i j, i ≠ j → 0 < a i j) (hidem : IsIdem (coordOp a)) :
    coordOp a = (1 / ((Fintype.card ι : ℝ) - 2)) • idOp := by
  set W := offDiag a with hWdef
  have hsa : ∀ i j, a i j = a j i := fun i j => by rw [← Matrix.transpose_apply a j i, ha]
  have hWt : Wᵀ = W := by
    ext i j; simp only [Matrix.transpose_apply, hWdef, offDiag]
    split_ifs with h1 h2 h2 <;> first | rfl | (exact absurd h1.symm h2) | (exact absurd h2.symm h1) | exact hsa j i
  have hW0 : ∀ x, W x x = 0 := fun x => by simp [hWdef, offDiag]
  have hWoff : ∀ i j, i ≠ j → W i j = a i j := fun i j h => by simp [hWdef, offDiag, h]
  have hWpos : ∀ i j, i ≠ j → 0 < W i j := fun i j h => by rw [hWoff i j h]; exact hpos i j h
  -- idempotency: `W ⋆ W = W` off the diagonal
  have hidemW : sharpMapCL (coordOp W) = coordOp W := by rw [hWdef, coordOp_offDiag]; exact hidem
  rw [sharpMapCL_coordOp W hWt hW0] at hidemW
  have hstar : ∀ i j, i ≠ j → starW W i j = W i j := by
    intro i j hij
    have h := congrArg (fun R : CurvOp2 ι => ((R ⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι) : Matrix ι ι ℝ) i j) hidemW
    simp only [coordOp_coe _ (starW_symm W hWt), coordOp_coe _ hWt, hadamard_phi _ (starW_symm W hWt),
      hadamard_phi _ hWt, Matrix.smul_apply, smul_eq_mul, phi, Matrix.sub_apply, Matrix.single_apply] at h
    simpa [hij, Ne.symm hij] using h
  -- `W² = W + diag d`, and `d` is constant through the Perron vector
  set d : ι → ℝ := fun i => ∑ k, W i k ^ 2 with hd
  have hsq : W * W = W + Matrix.diagonal d := by
    ext i j
    rw [Matrix.mul_apply, Matrix.add_apply]
    by_cases h : i = j
    · subst h; simp only [Matrix.diagonal_apply_eq, hW0, zero_add, hd]
      exact Finset.sum_congr rfl fun k _ => by rw [← Matrix.transpose_apply W k i, hWt]; ring
    · rw [Matrix.diagonal_apply_ne _ h, add_zero, ← hstar i j h]; rfl
  obtain ⟨k0, k1, hk01⟩ := Fintype.exists_pair_of_one_lt_card (by omega : 1 < Fintype.card ι)
  have : Nonempty ι := ⟨k0⟩
  obtain ⟨ρ, w, hw, hWw⟩ := perron_positive_eigvec W hWt hWpos
  have hdρ : ∀ i, d i = ρ ^ 2 - ρ := by
    intro i
    have h1 : (W * W).mulVec w = (ρ ^ 2) • w := by
      rw [← Matrix.mulVec_mulVec, hWw, Matrix.mulVec_smul, hWw, smul_smul, sq]
    rw [hsq, Matrix.add_mulVec, hWw] at h1
    have := congrFun h1 i
    simp only [Pi.add_apply, Pi.smul_apply, smul_eq_mul, Matrix.mulVec_diagonal] at this
    have hwi := hw i
    have : (d i - (ρ ^ 2 - ρ)) * w i = 0 := by linarith
    have := (mul_eq_zero.mp this).resolve_right hwi.ne'
    linarith
  set δ := ρ ^ 2 - ρ with hδ
  have hδpos : 0 < δ := by
    rw [← hdρ k0]
    have := Finset.single_le_sum (f := fun k => W k0 k ^ 2) (fun k _ => sq_nonneg _) (Finset.mem_univ k1)
    have := hWpos k0 k1 hk01
    simp only [hd]; nlinarith
  have hρpos : 0 < ρ := by
    have h := congrFun hWw k0
    simp only [Matrix.mulVec, dotProduct, Pi.smul_apply, smul_eq_mul] at h
    have hsum : 0 < ∑ j, W k0 j * w j := by
      have hnn : ∀ j ∈ Finset.univ, 0 ≤ W k0 j * w j := fun j _ => by
        by_cases h : k0 = j
        · subst h; rw [hW0]; simp
        · exact mul_nonneg (hWpos k0 j h).le (hw j).le
      have := Finset.single_le_sum hnn (Finset.mem_univ k1)
      have := mul_pos (hWpos k0 k1 hk01) (hw k1)
      linarith
    rw [h] at hsum
    exact (pos_iff_pos_of_mul_pos hsum).mpr (hw k0)
  set μ := ρ - 1 with hμ
  have hμpos : 0 < μ := by
    have : δ = ρ * μ := by rw [hδ, hμ]; ring
    rw [this] at hδpos
    exact (mul_pos_iff_of_pos_left hρpos).mp hδpos
  -- the columns of `N = W + μ I` are eigenvectors of `W` for `ρ`
  set N : ι → ι → ℝ := fun i k => W i k + if i = k then μ else 0 with hNdef
  have hWN : ∀ k, W.mulVec (fun i => N i k) = ρ • (fun i => N i k) := fun k => by
    funext i
    simp only [Matrix.mulVec, dotProduct, Pi.smul_apply, smul_eq_mul, hNdef, mul_add, Finset.sum_add_distrib,
      mul_ite, mul_zero, Finset.sum_ite_eq', Finset.mem_univ, if_true]
    rw [← Matrix.mul_apply, hsq, Matrix.add_apply]
    by_cases hik : i = k
    · subst hik; rw [Matrix.diagonal_apply_eq, hdρ, hW0, if_pos rfl]; rw [hμ]; ring
    · rw [Matrix.diagonal_apply_ne _ hik, if_neg hik]; rw [hμ]; ring
  have hNpos : ∀ i, 0 < N i k0 := fun i => by
    by_cases h : i = k0
    · subst h; simp [hNdef, hW0, hμpos]
    · simp only [hNdef, if_neg h, add_zero]; exact hWpos i k0 h
  have hrel : ∀ k i j, N i k * N j k0 = N j k * N i k0 := fun k =>
    perron_unique W hWt hWpos (fun i => N i k0) (fun i => N i k) ρ hNpos (hWN k0) (hWN k)
  have hNd : ∀ i, N i i = μ := fun i => by simp [hNdef, hW0]
  have hNo : ∀ i j, i ≠ j → N i j = W i j := fun i j h => by simp [hNdef, h]
  have hcol : ∀ j, N j k0 = μ := fun j => by
    by_cases h : j = k0
    · subst h; exact hNd _
    · have e := hrel j j k0
      rw [hNd, hNd, hNo k0 j (Ne.symm h)] at e
      rw [← Matrix.transpose_apply W j k0, hWt] at e
      rw [hNo j k0 h] at e ⊢
      have := hWpos j k0 h
      nlinarith [sq_nonneg (W j k0 - μ), sq_nonneg (W j k0 + μ)]
  have hconst : ∀ i j, i ≠ j → W i j = μ := fun i j hij => by
    have e := hrel j i j
    rw [hcol, hcol, hNd, hNo i j hij] at e
    have := mul_right_cancel₀ hμpos.ne' e
    linarith
  -- `(n - 2) μ² = μ`
  have hn' : (3 : ℝ) ≤ Fintype.card ι := by exact_mod_cast hn
  have hs : starW W k0 k1 = ((Fintype.card ι : ℝ) - 2) * μ ^ 2 := by
    unfold starW
    exact sum_off_two_gen hk01 _ _ (fun l hl0 hl1 => by rw [hconst k0 l (Ne.symm hl0), hconst l k1 hl1]; ring)
      (by rw [hW0]; ring) (by rw [hW0]; ring)
  have hval : ((Fintype.card ι : ℝ) - 2) * μ ^ 2 = μ := by
    rw [← hs, hstar k0 k1 hk01, hconst k0 k1 hk01]
  have hμval : μ = 1 / ((Fintype.card ι : ℝ) - 2) := by
    have hc : (0 : ℝ) < (Fintype.card ι : ℝ) - 2 := by linarith
    field_simp
    nlinarith [hval, hμpos]
  -- the operator
  rw [← coordOp_offDiag a, ← hWdef]
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  have hX : (X : Matrix ι ι ℝ)ᵀ = -X := X.2
  have h0 : ∀ x, (X : Matrix ι ι ℝ) x x = 0 := fun x => by
    have := congrFun (congrFun hX x) x
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this; linarith
  rw [coordOp_coe W hWt]
  ext x y
  simp only [Matrix.hadamard_apply, ContinuousLinearMap.smul_apply, Submodule.coe_smul, Matrix.smul_apply,
    smul_eq_mul]
  show W x y * (X : Matrix ι ι ℝ) x y = 1 / ((Fintype.card ι : ℝ) - 2) * (X : Matrix ι ι ℝ) x y
  by_cases h : x = y
  · subst h; rw [h0]; ring
  · rw [hconst x y h, hμval]

/-! ## L264 (1): the maximiser's first and second variation -/

theorem Ftri_add_left (A A' B C : CurvOp2 ι) : Ftri (A + A') B C = Ftri A B C + Ftri A' B C := by
  unfold Ftri; rw [phiTri_add_left]; ring

theorem Ftri_smul_left (c : ℝ) (A B C : CurvOp2 ι) : Ftri (c • A) B C = c * Ftri A B C := by
  unfold Ftri; rw [phiTri_smul_left]; ring

theorem Ftri_cube_smul (c : ℝ) (A : CurvOp2 ι) : Ftri (c • A) (c • A) (c • A) = c ^ 3 * Ftri A A A := by
  rw [Ftri_smul_left, Ftri_smul_mid, Ftri_smul_right]; ring

theorem normSq2_smul' (c : ℝ) (A : CurvOp2 ι) : normSq2 (c • A) = c ^ 2 * normSq2 A := by
  unfold normSq2; rw [innerOp2_smul_left, innerOp2_smul_right]; ring

theorem isSelfAdjoint2_add {A B : CurvOp2 ι} (hA : IsSelfAdjoint2 A) (hB : IsSelfAdjoint2 B) :
    IsSelfAdjoint2 (A + B) := fun X Y => by
  have h1 := hA X Y
  have h2 := hB X Y
  simp only [ContinuousLinearMap.add_apply, Submodule.coe_add]
  unfold inner2 at *
  simp only [Matrix.transpose_add, Matrix.add_mul, Matrix.mul_add, Matrix.trace_add] at *
  linarith

theorem isSelfAdjoint2_smul {A : CurvOp2 ι} (hA : IsSelfAdjoint2 A) (c : ℝ) : IsSelfAdjoint2 (c • A) :=
  fun X Y => by
  have h1 := hA X Y
  simp only [ContinuousLinearMap.smul_apply, Submodule.coe_smul]
  unfold inner2 at *
  simp only [Matrix.transpose_smul, Matrix.smul_mul, Matrix.mul_smul, Matrix.trace_smul, smul_eq_mul] at *
  linear_combination c * h1

/-- `R # R` is self-adjoint for every `R`, its bilinear form being a polarisation. -/
theorem isSelfAdjoint2_sharp (R : CurvOp2 ι) : IsSelfAdjoint2 (sharpMapCL R) := fun X Y => by
  rw [sharpMapCL_apply, sharpMapCL_apply, inner2_sharpMap, inner2_comm, inner2_sharpMap, sharpBil2_comm]

/-- Two operators pairing equally against every operator are equal. -/
theorem eq_of_innerOp2_eq {A B : CurvOp2 ι} (h : ∀ S : CurvOp2 ι, innerOp2 S A = innerOp2 S B) : A = B := by
  have h0 : normSq2 (A - B) = 0 := by
    show innerOp2 (A - B) (A - B) = 0
    rw [innerOp2_comm, innerOp2_sub_left, innerOp2_comm A, innerOp2_comm B, h]; ring
  exact sub_eq_zero.mp (normSq2_eq_zero h0)

/-- `(c R) # (c R) = c² R # R`. -/
theorem sharpMapCL_smul (c : ℝ) (R : CurvOp2 ι) : sharpMapCL (c • R) = c ^ 2 • sharpMapCL R :=
  eq_of_innerOp2_eq fun S => by
    rw [innerOp2_smul_right, innerOp2_sharpMap_eq_phiTri, innerOp2_sharpMap_eq_phiTri, phiTri_smul_mid,
      phiTri_smul_right]
    ring

/-- The cubic along a line through self-adjoint operators. -/
theorem Ftri_line {X H : CurvOp2 ι} (hX : IsSelfAdjoint2 X) (hH : IsSelfAdjoint2 H) (t : ℝ) :
    Ftri (X + t • H) (X + t • H) (X + t • H)
      = Ftri X X X + 3 * t * Ftri X X H + 3 * t ^ 2 * Ftri X H H + t ^ 3 * Ftri H H H := by
  simp only [Ftri_add_left, Ftri_add_mid, Ftri_add_right, Ftri_smul_left, Ftri_smul_mid, Ftri_smul_right]
  have e1 : Ftri X H X = Ftri X X H := Ftri_symm23 hX H X
  have e2 : Ftri H X X = Ftri X X H := by rw [Ftri_symm12 hX, e1]
  have e3 : Ftri H X H = Ftri X H H := Ftri_symm12 hH
  have e4 : Ftri H H X = Ftri X H H := by rw [Ftri_symm23 hH H X, e3]
  rw [e1, e2, e3, e4]
  ring

/-- A quartic with no constant term that is non-negative everywhere has zero linear coefficient and
non-negative quadratic coefficient. -/
theorem quartic_coeffs (α β γ δ : ℝ) (h : ∀ t : ℝ, 0 ≤ α * t + β * t ^ 2 + γ * t ^ 3 + δ * t ^ 4) :
    α = 0 ∧ 0 ≤ β := by
  have hg : Continuous (fun t : ℝ => α + β * t + γ * t ^ 2 + δ * t ^ 3) := by fun_prop
  have hlim := hg.tendsto 0
  simp only [ne_eq, OfNat.ofNat_ne_zero, not_false_eq_true, zero_pow, mul_zero, add_zero] at hlim
  have hpos : 0 ≤ α := by
    refine ge_of_tendsto (hlim.mono_left (nhdsWithin_le_nhds (s := Set.Ioi 0))) ?_
    filter_upwards [self_mem_nhdsWithin] with t ht
    have ht' : (0 : ℝ) < t := ht
    have e : α * t + β * t ^ 2 + γ * t ^ 3 + δ * t ^ 4 = t * (α + β * t + γ * t ^ 2 + δ * t ^ 3) := by ring
    have := h t
    rw [e] at this
    exact (mul_nonneg_iff_of_pos_left ht').mp this
  have hneg : α ≤ 0 := by
    refine le_of_tendsto (hlim.mono_left (nhdsWithin_le_nhds (s := Set.Iio 0))) ?_
    filter_upwards [self_mem_nhdsWithin] with t ht
    have ht' : t < (0 : ℝ) := ht
    have e : α * t + β * t ^ 2 + γ * t ^ 3 + δ * t ^ 4 = t * (α + β * t + γ * t ^ 2 + δ * t ^ 3) := by ring
    have := h t
    rw [e] at this
    nlinarith
  have hα : α = 0 := le_antisymm hneg hpos
  refine ⟨hα, ?_⟩
  have hg2 : Continuous (fun t : ℝ => β + γ * t + δ * t ^ 2) := by fun_prop
  have hlim2 := hg2.tendsto 0
  simp only [ne_eq, OfNat.ofNat_ne_zero, not_false_eq_true, zero_pow, mul_zero, add_zero] at hlim2
  refine ge_of_tendsto (hlim2.mono_left (nhdsWithin_le_nhds (s := Set.Ioi 0))) ?_
  filter_upwards [self_mem_nhdsWithin] with t ht
  have ht' : (0 : ℝ) < t := ht
  have e : α * t + β * t ^ 2 + γ * t ^ 3 + δ * t ^ 4 = t ^ 2 * (β + γ * t + δ * t ^ 2) := by rw [hα]; ring
  have := h t
  rw [e] at this
  exact (mul_nonneg_iff_of_pos_left (by positivity)).mp this

/-- **The first and second variation at a maximiser** of `F` on the unit sphere of self-adjoint operators: along
every self-adjoint `H ⊥ X`, `F(X, X, H) = 0` and `F(X, H, H) ≤ ½ F(X) ‖H‖²`. -/
theorem maximiser_variation (X : CurvOp2 ι) (hX : IsSelfAdjoint2 X) (hunit : normSq2 X = 1)
    (hmax : ∀ Y : CurvOp2 ι, IsSelfAdjoint2 Y → normSq2 Y = 1 → Ftri Y Y Y ≤ Ftri X X X)
    (hpos : 0 < Ftri X X X) (H : CurvOp2 ι) (hH : IsSelfAdjoint2 H) (hHX : innerOp2 H X = 0) :
    Ftri X X H = 0 ∧ Ftri X H H ≤ (1 / 2) * Ftri X X X * normSq2 H := by
  set f := Ftri X X X with hf
  set h := normSq2 H with hhdef
  have hh : 0 ≤ h := normSq2_nonneg H
  have key : ∀ t : ℝ, 0 ≤ (-3 * Ftri X X H) * t + ((3 / 2) * f * h - 3 * Ftri X H H) * t ^ 2
      + (-(Ftri H H H)) * t ^ 3 + ((1 / 2) * f * h ^ 2) * t ^ 4 := by
    intro t
    have hY : IsSelfAdjoint2 (X + t • H) := isSelfAdjoint2_add hX (isSelfAdjoint2_smul hH t)
    have hnY : normSq2 (X + t • H) = 1 + t ^ 2 * h := by
      show innerOp2 (X + t • H) (X + t • H) = _
      rw [innerOp2_add_left, innerOp2_add_right, innerOp2_add_right, innerOp2_smul_left, innerOp2_smul_left,
        innerOp2_smul_right, innerOp2_smul_right, innerOp2_comm X H, hHX]
      have : innerOp2 X X = 1 := hunit
      rw [this]; simp only [hhdef, normSq2]; ring
    have hu : 0 ≤ t ^ 2 * h := by positivity
    set s := Real.sqrt (1 + t ^ 2 * h) with hsdef
    have hs0 : 0 < s := Real.sqrt_pos.mpr (by linarith)
    have hs2 : s ^ 2 = 1 + t ^ 2 * h := Real.sq_sqrt (by linarith)
    have hsle : s ≤ 1 + t ^ 2 * h / 2 := by nlinarith [sq_nonneg (s - 1 - t ^ 2 * h / 2)]
    have hZ : normSq2 (s⁻¹ • (X + t • H)) = 1 := by
      rw [normSq2_smul', hnY, inv_pow, hs2, inv_mul_cancel₀ (by linarith)]
    have hle := hmax _ (isSelfAdjoint2_smul hY s⁻¹) hZ
    rw [Ftri_cube_smul, Ftri_line hX hH] at hle
    have hs3 : 0 < s ^ 3 := by positivity
    have hFY : Ftri X X X + 3 * t * Ftri X X H + 3 * t ^ 2 * Ftri X H H + t ^ 3 * Ftri H H H ≤ f * s ^ 3 := by
      have e : Ftri X X X + 3 * t * Ftri X X H + 3 * t ^ 2 * Ftri X H H + t ^ 3 * Ftri H H H
          = s ^ 3 * (s⁻¹ ^ 3 * (Ftri X X X + 3 * t * Ftri X X H + 3 * t ^ 2 * Ftri X H H
            + t ^ 3 * Ftri H H H)) := by
        field_simp
      rw [e]; nlinarith [mul_le_mul_of_nonneg_left hle hs3.le]
    have hs3le : s ^ 3 ≤ (1 + t ^ 2 * h) * (1 + t ^ 2 * h / 2) := by
      have e : s ^ 3 = s ^ 2 * s := by ring
      rw [e, hs2]; exact mul_le_mul_of_nonneg_left hsle (by linarith)
    have h1 : f * s ^ 3 ≤ f * ((1 + t ^ 2 * h) * (1 + t ^ 2 * h / 2)) := mul_le_mul_of_nonneg_left hs3le hpos.le
    have h2 := hFY.trans h1
    rw [← hf] at h2
    nlinarith [h2]
  obtain ⟨h1, h2⟩ := quartic_coeffs _ _ _ _ key
  exact ⟨by linarith, by linarith⟩

/-- **L264 (1).** A maximiser `X` of `F` on the unit sphere of self-adjoint operators, with `F(X) > 0`, gives the
idempotent `C = X / F(X)`, and `C` is stable. -/
theorem L264_maximiser_stable (X : CurvOp2 ι) (hX : IsSelfAdjoint2 X) (hunit : normSq2 X = 1)
    (hmax : ∀ Y : CurvOp2 ι, IsSelfAdjoint2 Y → normSq2 Y = 1 → Ftri Y Y Y ≤ Ftri X X X)
    (hpos : 0 < Ftri X X X) :
    IsIdem ((1 / Ftri X X X) • X) ∧ IsStable ((1 / Ftri X X X) • X) := by
  set f := Ftri X X X with hf
  have hf0 : f ≠ 0 := hpos.ne'
  have hsharp : sharpMapCL X = f • X := by
    set D := sharpMapCL X - f • X with hD
    have hDsa : IsSelfAdjoint2 D := by
      have e : D = sharpMapCL X + (-f) • X := by rw [hD]; module
      rw [e]
      exact isSelfAdjoint2_add (isSelfAdjoint2_sharp X) (isSelfAdjoint2_smul hX (-f))
    have hXX : innerOp2 X X = 1 := hunit
    have hDX : innerOp2 D X = 0 := by
      rw [hD, innerOp2_sub_left, innerOp2_smul_left, innerOp2_comm, ← Ftri_sharp, hXX, ← hf]; ring
    have hvar := (maximiser_variation X hX hunit hmax hpos D hDsa hDX).1
    rw [Ftri_sharp] at hvar
    have h0 : normSq2 D = 0 := by
      show innerOp2 D D = 0
      conv_lhs => rw [hD]
      rw [innerOp2_comm, innerOp2_sub_left, innerOp2_smul_left, innerOp2_comm (sharpMapCL X) D, hvar,
        innerOp2_comm X D, hDX]
      ring
    exact sub_eq_zero.mp (normSq2_eq_zero h0)
  refine ⟨?_, ?_⟩
  · show sharpMapCL ((1 / f) • X) = (1 / f) • X
    rw [sharpMapCL_smul, hsharp, smul_smul]
    congr 1
    field_simp
  · intro H hH hHC
    have hHX : innerOp2 H X = 0 := by
      rw [innerOp2_smul_right] at hHC
      rcases mul_eq_zero.mp hHC with h | h
      · exact absurd h (by positivity)
      · exact h
    have hv := (maximiser_variation X hX hunit hmax hpos H hH hHX).2
    rw [Ftri_smul_left]
    rw [← hf] at hv
    calc 1 / f * Ftri X H H ≤ 1 / f * ((1 / 2) * f * normSq2 H) :=
          mul_le_mul_of_nonneg_left hv (by positivity)
      _ = (1 / 2) * normSq2 H := by field_simp

/-- `Φ(A; B, C) = 0` when the ranges of `A` and `C` commute, every bracket in its sum being zero. -/
theorem phiTri_comm_zero {A C : CurvOp2 ι} (B : CurvOp2 ι) (h : ∀ X Y : skewSub ι, brS (A X) (C Y) = 0) :
    phiTri A B C = 0 := by
  unfold phiTri
  simp [h, inner2]

/-- **L264 (2), at a split with no cross block.** A positive semidefinite idempotent `C = D₁ + D₂` with `D₁, D₂`
self-adjoint and nonzero, `D₁ D₂ = D₂ D₁ = 0` and `[range D₁, range D₂] = 0` (so the two ranges are commuting ideals
of `range C`) is not stable. The record's (2) also covers a cross block `E` between the ideals. -/
theorem L264_not_simple_unstable (C D₁ D₂ : CurvOp2 ι) (hC : IsSelfAdjoint2 C) (hpsd : IsPSD2 C)
    (hidem : IsIdem C) (hsplit : C = D₁ + D₂) (hD₁ : IsSelfAdjoint2 D₁) (hD₂ : IsSelfAdjoint2 D₂)
    (h1 : D₁ ≠ 0) (h2 : D₂ ≠ 0)
    (hcomm : ∀ X Y : skewSub ι, brS (D₁ X) (D₂ Y) = 0) (hrange : ∀ X : skewSub ι, D₁ (D₂ X) = 0 ∧ D₂ (D₁ X) = 0) :
    ¬ IsStable C := by
  intro hst
  -- every mixed term vanishes: `F(D₁, S, D₂) = 0`
  have z : ∀ S, Ftri D₁ S D₂ = 0 := fun S => by
    unfold Ftri; rw [phiTri_comm_zero S hcomm]; ring
  have z121 : Ftri D₁ D₂ D₁ = 0 := by rw [Ftri_symm23 hD₁, z]
  have z211 : Ftri D₂ D₁ D₁ = 0 := by rw [Ftri_symm12 hD₁, z121]
  have z212 : Ftri D₂ D₁ D₂ = 0 := by rw [Ftri_symm12 hD₂, z]
  have z221 : Ftri D₂ D₂ D₁ = 0 := by rw [Ftri_symm23 hD₂, z212]
  have z112 : Ftri D₁ D₁ D₂ = 0 := z D₁
  have z122 : Ftri D₁ D₂ D₂ = 0 := z D₂
  -- `D₁ ⊥ D₂`
  have hperp : innerOp2 D₁ D₂ = 0 := by
    unfold innerOp2
    have : ∀ i j : ι, inner2 (applyPhi D₁ i j) (applyPhi D₂ i j) = 0 := fun i j => by
      show inner2 ((D₁ ⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι) : Matrix ι ι ℝ)
        ((D₂ ⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι) : Matrix ι ι ℝ) = 0
      rw [hD₁, (hrange _).1]
      simp [inner2]
    simp [this]
  have hperp' : innerOp2 D₂ D₁ = 0 := by rw [innerOp2_comm]; exact hperp
  -- `F(D_i) = ‖D_i‖²` from `C # C = C`
  have hF1 : Ftri D₁ D₁ D₁ = normSq2 D₁ := by
    have e := Ftri_idem hidem D₁
    rw [hsplit, Ftri_add_left, Ftri_add_mid, Ftri_add_mid, innerOp2_add_right, hperp, z121, z211, z221] at e
    simp only [normSq2]; linarith
  have hF2 : Ftri D₂ D₂ D₂ = normSq2 D₂ := by
    have e := Ftri_idem hidem D₂
    rw [hsplit, Ftri_add_left, Ftri_add_mid, Ftri_add_mid, innerOp2_add_right, hperp', z112, z122, z212] at e
    simp only [normSq2]; linarith
  -- the destabilising direction
  set a := normSq2 D₂ with ha
  set b := normSq2 D₁ with hb
  have ha0 : 0 < a := lt_of_le_of_ne (normSq2_nonneg D₂) (fun h => h2 (normSq2_eq_zero h.symm))
  have hb0 : 0 < b := lt_of_le_of_ne (normSq2_nonneg D₁) (fun h => h1 (normSq2_eq_zero h.symm))
  set H := a • D₁ + (-b) • D₂ with hH
  have hHsa : IsSelfAdjoint2 H := isSelfAdjoint2_add (isSelfAdjoint2_smul hD₁ a) (isSelfAdjoint2_smul hD₂ (-b))
  have hHC : innerOp2 H C = 0 := by
    rw [hH, hsplit, innerOp2_add_left, innerOp2_smul_left, innerOp2_smul_left, innerOp2_add_right,
      innerOp2_add_right, hperp, hperp']
    simp only [ha, hb, normSq2]; ring
  have hnH : normSq2 H = a ^ 2 * b + b ^ 2 * a := by
    show innerOp2 (a • D₁ + (-b) • D₂) (a • D₁ + (-b) • D₂) = _
    rw [innerOp2_add_left, innerOp2_add_right, innerOp2_add_right, innerOp2_smul_left, innerOp2_smul_left,
      innerOp2_smul_left, innerOp2_smul_left, innerOp2_smul_right, innerOp2_smul_right, innerOp2_smul_right,
      innerOp2_smul_right, hperp, hperp']
    simp only [ha, hb, normSq2]; ring
  have hFH : Ftri C H H = a ^ 2 * b + b ^ 2 * a := by
    rw [hH, hsplit]
    simp only [Ftri_add_left, Ftri_add_mid, Ftri_add_right, Ftri_smul_mid, Ftri_smul_right]
    rw [hF1, hF2, z112, z121, z122, z211, z212, z221]
    simp only [ha, hb]; ring
  have hle := hst H hHsa hHC
  rw [hFH, hnH] at hle
  nlinarith [mul_pos (mul_pos ha0 ha0) hb0, mul_pos (mul_pos hb0 hb0) ha0]

/-- The orbit tangent `u_X = [ad_X, C]`. -/
noncomputable def orbitTangent (C : CurvOp2 ι) (X : skewSub ι) : CurvOp2 ι := (adS X).comp C - C.comp (adS X)

end SoN

/-- **L254.** Conjecture A at `n = 12`: `P(W) ≤ Θ₁₂ = √55/6` on the unit Weyl sphere of `𝔰𝔬(12)`. *Its proof is
an outside sum-of-squares certificate (unpublished, held in the private record),
which is not a Lean proof; the layer types its arithmetic in [L254.lean](L254.lean).* -/
theorem L254_conjA_12 : ∀ R ∈ weylSphereSet (Fin 12), Pcubic2 R ≤ HamiltonsCubic.L254.Theta12 := by
  sorry

/-! ## The remaining parts -/

section Remaining

/-! ## The eigenframe of a self-adjoint operator, and L260 (1) at self-adjoint `X`

*`skewSub` carries the Pi topology, so the inner product lives on the synonym `FrameExtension.SkewSp`; `toSk` and
`ofSk` move between them, and a self-adjoint `CurvOp2` becomes a symmetric endomorphism there, where Mathlib's
spectral theorem supplies an orthonormal eigenbasis.* -/

/-- `skewSub` to its inner-product synonym. -/
def toSk (X : skewSub ι) : FrameExtension.SkewSp ι := FrameExtension.ofM (X : Matrix ι ι ℝ) X.2

/-- The synonym back to `skewSub`. -/
def ofSk (x : FrameExtension.SkewSp ι) : skewSub ι := ⟨FrameExtension.toM x, FrameExtension.toM_skew x⟩

theorem ofSk_coe (x : FrameExtension.SkewSp ι) : ((ofSk x : skewSub ι) : Matrix ι ι ℝ) = FrameExtension.toM x := rfl

theorem toM_toSk (X : skewSub ι) : FrameExtension.toM (toSk X) = (X : Matrix ι ι ℝ) := rfl

theorem ofSk_toSk (X : skewSub ι) : ofSk (toSk X) = X := rfl

theorem ofSk_add (x y : FrameExtension.SkewSp ι) : ofSk (x + y) = ofSk x + ofSk y := rfl

theorem ofSk_smul (c : ℝ) (x : FrameExtension.SkewSp ι) : ofSk (c • x) = c • ofSk x := rfl

theorem ofSk_sum {κ : Type*} (s : Finset κ) (f : κ → FrameExtension.SkewSp ι) :
    ofSk (∑ k ∈ s, f k) = ∑ k ∈ s, ofSk (f k) := by
  apply Subtype.ext
  rw [ofSk_coe, FrameExtension.toM_sum]
  simp [AddSubmonoidClass.coe_finsetSum, ofSk_coe]

theorem inner_toSk (X Y : skewSub ι) :
    inner ℝ (toSk X) (toSk Y) = inner2 (X : Matrix ι ι ℝ) (Y : Matrix ι ι ℝ) := rfl

/-- A `CurvOp2`, read on the synonym. -/
noncomputable def opSk (C : CurvOp2 ι) : FrameExtension.SkewSp ι →ₗ[ℝ] FrameExtension.SkewSp ι where
  toFun x := toSk (C (ofSk x))
  map_add' x y := by
    apply FrameExtension.toM_injective
    rw [ofSk_add, map_add, FrameExtension.toM_add]; rfl
  map_smul' c x := by
    apply FrameExtension.toM_injective
    rw [ofSk_smul, map_smul, FrameExtension.toM_smul]; rfl

theorem opSk_symm {C : CurvOp2 ι} (hC : IsSelfAdjoint2 C) : (opSk C).IsSymmetric := fun x y => by
  show inner2 ((C (ofSk x) : skewSub ι) : Matrix ι ι ℝ) (FrameExtension.toM y)
    = inner2 (FrameExtension.toM x) ((C (ofSk y) : skewSub ι) : Matrix ι ι ℝ)
  exact hC (ofSk x) (ofSk y)

/-- **The `φ`-family sums of a bilinear form are twice its sum over any orthonormal basis.** -/
theorem phi_sum_change {N : ℕ} (b : OrthonormalBasis (Fin N) ℝ (FrameExtension.SkewSp ι))
    (f : skewSub ι →ₗ[ℝ] skewSub ι →ₗ[ℝ] ℝ) :
    ∑ i, ∑ j, f ⟨phi i j, phi_mem_skewSub i j⟩ ⟨phi i j, phi_mem_skewSub i j⟩
      = 2 * ∑ β, f (ofSk (b β)) (ofSk (b β)) := by
  have hexp : ∀ X : skewSub ι, X = ∑ β, inner ℝ (b β) (toSk X) • ofSk (b β) := fun X => by
    conv_lhs => rw [← ofSk_toSk X, ← b.sum_repr' (toSk X)]
    rw [ofSk_sum]; rfl
  have hpair : ∀ β γ, ∑ i, ∑ j, inner ℝ (b β) (toSk ⟨phi i j, phi_mem_skewSub i j⟩)
      * inner ℝ (b γ) (toSk ⟨phi i j, phi_mem_skewSub i j⟩) = 2 * (if β = γ then 1 else 0) := by
    intro β γ
    have h := sum_phi_inner_sub (ofSk (b β)) (innerRight (FrameExtension.toM (b γ)))
    simp only [innerRight, LinearMap.coe_mk, AddHom.coe_mk] at h
    have horth : inner2 (FrameExtension.toM (b β)) (FrameExtension.toM (b γ)) = if β = γ then 1 else 0 := by
      rw [← FrameExtension.inner_def]; exact orthonormal_iff_ite.mp b.orthonormal β γ
    rw [ofSk_coe, horth] at h
    have key : ∑ i, ∑ j, inner ℝ (b β) (toSk ⟨phi i j, phi_mem_skewSub i j⟩)
        * inner ℝ (b γ) (toSk ⟨phi i j, phi_mem_skewSub i j⟩)
        = ∑ i, ∑ j, inner2 (FrameExtension.toM (b β)) (phi i j) * inner2 (phi i j) (FrameExtension.toM (b γ)) := by
      refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
      rw [FrameExtension.inner_def, FrameExtension.inner_def, inner2_comm (FrameExtension.toM (b γ))]
      rfl
    rw [key]
    linarith [h]
  have hf : ∀ X : skewSub ι, f X X = ∑ β, ∑ γ, inner ℝ (b β) (toSk X) * inner ℝ (b γ) (toSk X)
      * f (ofSk (b β)) (ofSk (b γ)) := fun X => by
    conv_lhs => rw [hexp X]
    simp only [map_sum, map_smul, LinearMap.sum_apply, LinearMap.smul_apply, smul_eq_mul, Finset.mul_sum]
    rw [Finset.sum_comm]
    exact Finset.sum_congr rfl fun β _ => Finset.sum_congr rfl fun γ _ => by ring
  rw [Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => hf _]
  rw [sum_pq_swap, Finset.sum_congr rfl fun β _ => by rw [sum_pq_swap]]
  simp only [← Finset.sum_mul, hpair]
  rw [Finset.mul_sum]
  refine Finset.sum_congr rfl fun β _ => ?_
  simp [mul_ite, ite_mul, Finset.sum_ite_eq]

theorem i2_add_l (A B Y : Matrix ι ι ℝ) : inner2 (A + B) Y = inner2 A Y + inner2 B Y := by
  unfold inner2; rw [Matrix.transpose_add, Matrix.add_mul, Matrix.trace_add]; ring

theorem i2_add_r (X A B : Matrix ι ι ℝ) : inner2 X (A + B) = inner2 X A + inner2 X B := by
  unfold inner2; rw [Matrix.mul_add, Matrix.trace_add]; ring

theorem i2_smul_l (c : ℝ) (X Y : Matrix ι ι ℝ) : inner2 (c • X) Y = c * inner2 X Y := by
  unfold inner2; rw [Matrix.transpose_smul, Matrix.smul_mul, Matrix.trace_smul, smul_eq_mul]; ring

theorem i2_smul_r (c : ℝ) (X Y : Matrix ι ι ℝ) : inner2 X (c • Y) = c * inner2 X Y := by
  unfold inner2; rw [Matrix.mul_smul, Matrix.trace_smul, smul_eq_mul]; ring

/-- An operator acting diagonally on an orthonormal basis. -/
theorem inner2_diag_self {N : ℕ} (b : OrthonormalBasis (Fin N) ℝ (FrameExtension.SkewSp ι)) (R : CurvOp2 ι)
    (lam : Fin N → ℝ) (hR : ∀ β, R (ofSk (b β)) = lam β • ofSk (b β)) (Z : skewSub ι) :
    inner2 ((R Z : skewSub ι) : Matrix ι ι ℝ) (Z : Matrix ι ι ℝ) = ∑ δ, lam δ * inner ℝ (b δ) (toSk Z) ^ 2 := by
  have hexp : Z = ∑ δ, inner ℝ (b δ) (toSk Z) • ofSk (b δ) := by
    conv_lhs => rw [← ofSk_toSk Z, ← b.sum_repr' (toSk Z)]
    rw [ofSk_sum]; rfl
  have hRZ : R Z = ∑ δ, (lam δ * inner ℝ (b δ) (toSk Z)) • ofSk (b δ) := by
    conv_lhs => rw [hexp]
    simp only [map_sum, map_smul, hR, smul_smul]
    exact Finset.sum_congr rfl fun δ _ => by ring_nf
  have : toSk (∑ δ, (lam δ * inner ℝ (b δ) (toSk Z)) • ofSk (b δ)) = ∑ δ, (lam δ * inner ℝ (b δ) (toSk Z)) • b δ := by
    apply FrameExtension.toM_injective
    rw [FrameExtension.toM_sum, toM_toSk]
    simp only [AddSubmonoidClass.coe_finsetSum, Submodule.coe_smul, ofSk_coe, FrameExtension.toM_smul]
  rw [← inner_toSk, hRZ, this, sum_inner]
  refine Finset.sum_congr rfl fun δ _ => ?_
  rw [real_inner_smul_left]; ring

/-- **`F` in an eigenframe**: `F(R) = ½ ∑_{β,γ,δ} λ_β λ_γ λ_δ ⟨[b_β, b_γ], b_δ⟩²`. -/
theorem Ftri_eigen {N : ℕ} (b : OrthonormalBasis (Fin N) ℝ (FrameExtension.SkewSp ι)) (R : CurvOp2 ι)
    (hRsa : IsSelfAdjoint2 R) (lam : Fin N → ℝ) (hR : ∀ β, R (ofSk (b β)) = lam β • ofSk (b β)) :
    Ftri R R R = (1 / 2) * ∑ β, ∑ γ, ∑ δ, lam β * lam γ * lam δ
      * inner ℝ (b δ) (toSk (brS (ofSk (b β)) (ofSk (b γ)))) ^ 2 := by
  -- the inner sum, bilinear in its two slots
  let H : skewSub ι → skewSub ι →ₗ[ℝ] skewSub ι →ₗ[ℝ] ℝ := fun X => LinearMap.mk₂ ℝ
    (fun Y Y' => inner2 ((R (brS (R X) (R Y)) : skewSub ι) : Matrix ι ι ℝ) ((brS X Y' : skewSub ι) : Matrix ι ι ℝ))
    (fun Y₁ Y₂ Y' => by simp only [map_add, brS_add_right, Submodule.coe_add, i2_add_l])
    (fun c Y Y' => by simp only [map_smul, brS_smul_right, Submodule.coe_smul, i2_smul_l, smul_eq_mul])
    (fun Y Y₁' Y₂' => by simp only [brS_add_right, Submodule.coe_add, i2_add_r])
    (fun c Y Y' => by simp only [brS_smul_right, Submodule.coe_smul, i2_smul_r, smul_eq_mul])
  let G : skewSub ι →ₗ[ℝ] skewSub ι →ₗ[ℝ] ℝ := LinearMap.mk₂ ℝ
    (fun X X' => ∑ k, ∑ l, inner2 ((R (brS (R X) (R ⟨phi k l, phi_mem_skewSub k l⟩)) : skewSub ι) : Matrix ι ι ℝ)
      ((brS X' ⟨phi k l, phi_mem_skewSub k l⟩ : skewSub ι) : Matrix ι ι ℝ))
    (fun X₁ X₂ X' => by
      simp only [map_add, brS_add_left, Submodule.coe_add, i2_add_l, Finset.sum_add_distrib])
    (fun c X X' => by
      simp only [map_smul, brS_smul_left, Submodule.coe_smul, i2_smul_l, smul_eq_mul, Finset.mul_sum])
    (fun X X₁' X₂' => by simp only [brS_add_left, Submodule.coe_add, i2_add_r, Finset.sum_add_distrib])
    (fun c X X' => by simp only [brS_smul_left, Submodule.coe_smul, i2_smul_r, smul_eq_mul, Finset.mul_sum])
  have hphi : phiTri R R R = -(1 / 4) * ∑ i, ∑ j, G ⟨phi i j, phi_mem_skewSub i j⟩ ⟨phi i j, phi_mem_skewSub i j⟩ := by
    unfold phiTri
    rfl
  have hG : ∀ β, G (ofSk (b β)) (ofSk (b β)) = 2 * ∑ γ, H (ofSk (b β)) (ofSk (b γ)) (ofSk (b γ)) := fun β => by
    rw [← phi_sum_change b (H (ofSk (b β)))]
    rfl
  have hH : ∀ β γ, H (ofSk (b β)) (ofSk (b γ)) (ofSk (b γ))
      = lam β * lam γ * ∑ δ, lam δ * inner ℝ (b δ) (toSk (brS (ofSk (b β)) (ofSk (b γ)))) ^ 2 := by
    intro β γ
    show inner2 ((R (brS (R (ofSk (b β))) (R (ofSk (b γ)))) : skewSub ι) : Matrix ι ι ℝ)
      ((brS (ofSk (b β)) (ofSk (b γ)) : skewSub ι) : Matrix ι ι ℝ) = _
    rw [hR, hR, brS_smul_left, brS_smul_right, map_smul, map_smul, Submodule.coe_smul, Submodule.coe_smul,
      i2_smul_l, i2_smul_l, inner2_diag_self b R lam hR]
    ring
  unfold Ftri
  rw [hphi, phi_sum_change b G]
  simp only [hG, hH]
  simp only [Finset.mul_sum]
  refine Finset.sum_congr rfl fun β _ => Finset.sum_congr rfl fun γ _ => Finset.sum_congr rfl fun δ _ => ?_
  ring

/-- The operator with eigenbasis `b` and eigenvalues `μ`. -/
noncomputable def diagOp {N : ℕ} (b : OrthonormalBasis (Fin N) ℝ (FrameExtension.SkewSp ι)) (μ : Fin N → ℝ) :
    CurvOp2 ι :=
  LinearMap.toContinuousLinearMap
    { toFun := fun Y => ∑ β, (μ β * inner ℝ (b β) (toSk Y)) • ofSk (b β)
      map_add' := fun Y Z => by
        have : toSk (Y + Z) = toSk Y + toSk Z := FrameExtension.toM_injective rfl
        simp only [this, inner_add_right, mul_add, add_smul, Finset.sum_add_distrib]
      map_smul' := fun c Y => by
        have : toSk (c • Y) = c • toSk Y := FrameExtension.toM_injective rfl
        simp only [this, real_inner_smul_right, RingHom.id_apply, Finset.smul_sum, smul_smul]
        exact Finset.sum_congr rfl fun β _ => by ring_nf }

theorem diagOp_apply {N : ℕ} (b : OrthonormalBasis (Fin N) ℝ (FrameExtension.SkewSp ι)) (μ : Fin N → ℝ)
    (Y : skewSub ι) : diagOp b μ Y = ∑ β, (μ β * inner ℝ (b β) (toSk Y)) • ofSk (b β) := rfl

theorem diagOp_basis {N : ℕ} (b : OrthonormalBasis (Fin N) ℝ (FrameExtension.SkewSp ι)) (μ : Fin N → ℝ)
    (γ : Fin N) : diagOp b μ (ofSk (b γ)) = μ γ • ofSk (b γ) := by
  rw [diagOp_apply]
  have : toSk (ofSk (b γ)) = b γ := rfl
  simp only [this, orthonormal_iff_ite.mp b.orthonormal, mul_ite, mul_one, mul_zero, ite_smul, zero_smul,
    Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.mem_univ, if_true]

theorem inner2_diagOp {N : ℕ} (b : OrthonormalBasis (Fin N) ℝ (FrameExtension.SkewSp ι)) (μ : Fin N → ℝ)
    (Y Z : skewSub ι) : inner2 ((diagOp b μ Y : skewSub ι) : Matrix ι ι ℝ) (Z : Matrix ι ι ℝ)
      = ∑ β, μ β * inner ℝ (b β) (toSk Y) * inner ℝ (b β) (toSk Z) := by
  rw [← inner_toSk, diagOp_apply]
  have : toSk (∑ β, (μ β * inner ℝ (b β) (toSk Y)) • ofSk (b β)) = ∑ β, (μ β * inner ℝ (b β) (toSk Y)) • b β := by
    apply FrameExtension.toM_injective
    rw [FrameExtension.toM_sum, toM_toSk]
    simp only [AddSubmonoidClass.coe_finsetSum, Submodule.coe_smul, ofSk_coe, FrameExtension.toM_smul]
  rw [this, sum_inner]
  exact Finset.sum_congr rfl fun β _ => by rw [real_inner_smul_left]

theorem diagOp_sa {N : ℕ} (b : OrthonormalBasis (Fin N) ℝ (FrameExtension.SkewSp ι)) (μ : Fin N → ℝ) :
    IsSelfAdjoint2 (diagOp b μ) := fun Y Z => by
  rw [inner2_diagOp, inner2_comm, inner2_diagOp]
  exact Finset.sum_congr rfl fun β _ => by ring

theorem diagOp_psd {N : ℕ} (b : OrthonormalBasis (Fin N) ℝ (FrameExtension.SkewSp ι)) (μ : Fin N → ℝ)
    (hμ : ∀ β, 0 ≤ μ β) : IsPSD2 (diagOp b μ) := fun Y => by
  rw [inner2_diagOp]
  exact Finset.sum_nonneg fun β _ => by nlinarith [hμ β, sq_nonneg (inner ℝ (b β) (toSk Y))]

/-- `‖R‖² = ∑ λ²` in an eigenframe. -/
theorem normSq2_eigen {N : ℕ} (b : OrthonormalBasis (Fin N) ℝ (FrameExtension.SkewSp ι)) (R : CurvOp2 ι)
    (lam : Fin N → ℝ) (hR : ∀ β, R (ofSk (b β)) = lam β • ofSk (b β)) : normSq2 R = ∑ β, lam β ^ 2 := by
  let f : skewSub ι →ₗ[ℝ] skewSub ι →ₗ[ℝ] ℝ := LinearMap.mk₂ ℝ
    (fun X X' => inner2 ((R X : skewSub ι) : Matrix ι ι ℝ) ((R X' : skewSub ι) : Matrix ι ι ℝ))
    (fun X₁ X₂ X' => by simp only [map_add, Submodule.coe_add, i2_add_l])
    (fun c X X' => by simp only [map_smul, Submodule.coe_smul, i2_smul_l, smul_eq_mul])
    (fun X X₁' X₂' => by simp only [map_add, Submodule.coe_add, i2_add_r])
    (fun c X X' => by simp only [map_smul, Submodule.coe_smul, i2_smul_r, smul_eq_mul])
  have h := phi_sum_change b f
  show (1 / 2) * ∑ i, ∑ j, inner2 (applyPhi R i j) (applyPhi R i j) = _
  have e : ∑ i, ∑ j, inner2 (applyPhi R i j) (applyPhi R i j)
      = ∑ i, ∑ j, f ⟨phi i j, phi_mem_skewSub i j⟩ ⟨phi i j, phi_mem_skewSub i j⟩ := rfl
  rw [e, h]
  have hb : ∀ β, f (ofSk (b β)) (ofSk (b β)) = lam β ^ 2 := fun β => by
    show inner2 ((R (ofSk (b β)) : skewSub ι) : Matrix ι ι ℝ) ((R (ofSk (b β)) : skewSub ι) : Matrix ι ι ℝ) = _
    rw [hR, Submodule.coe_smul, i2_smul_l, i2_smul_r, ofSk_coe, ← FrameExtension.inner_def,
      real_inner_self_eq_norm_sq, b.orthonormal.1 β]
    ring
  simp only [hb]; ring

/-- **L260 (1), in the form it is used**: `κ_n` is attained on the positive semidefinite cone, every self-adjoint `X`
being matched by a positive semidefinite self-adjoint `Y` of the same norm with `F(X) ≤ F(Y)`. *Proved in `X`'s
eigenframe with `Y = |X|`; the record's mechanism at non-self-adjoint `X`, `F(X) ≤ ½(F(|Xᵀ|) + F(|X|))` in the
rows-together extension of `F`, is `L260_one` in [L260One.lean](L260One.lean).* -/
theorem L260_psd_cone (X : CurvOp2 ι) (hX : IsSelfAdjoint2 X) :
    ∃ Y : CurvOp2 ι, IsSelfAdjoint2 Y ∧ IsPSD2 Y ∧ normSq2 Y = normSq2 X ∧ Ftri X X X ≤ Ftri Y Y Y := by
  have hs := opSk_symm hX
  let b := hs.eigenvectorBasis (n := Module.finrank ℝ (FrameExtension.SkewSp ι)) rfl
  let σ := hs.eigenvalues (n := Module.finrank ℝ (FrameExtension.SkewSp ι)) rfl
  have hXb : ∀ β, X (ofSk (b β)) = σ β • ofSk (b β) := fun β => by
    have h := hs.apply_eigenvectorBasis (n := Module.finrank ℝ (FrameExtension.SkewSp ι)) rfl β
    have h2 : X (ofSk (b β)) = ofSk (opSk X (b β)) := rfl
    rw [h2, h, ofSk_smul]
    rfl
  refine ⟨diagOp b (fun β => |σ β|), diagOp_sa b _, diagOp_psd b _ (fun β => abs_nonneg _), ?_, ?_⟩
  · rw [normSq2_eigen b _ _ (diagOp_basis b _), normSq2_eigen b X σ hXb]
    simp only [sq_abs]
  · rw [Ftri_eigen b X hX σ hXb, Ftri_eigen b _ (diagOp_sa b _) _ (diagOp_basis b _)]
    apply mul_le_mul_of_nonneg_left _ (by norm_num)
    refine Finset.sum_le_sum fun β _ => Finset.sum_le_sum fun γ _ => Finset.sum_le_sum fun δ _ => ?_
    apply mul_le_mul_of_nonneg_right _ (sq_nonneg _)
    rw [← abs_mul, ← abs_mul]
    exact le_abs_self _

/-- A sum vanishing at `i`, `j`, equal to `e` at `L` and `c` elsewhere (`i, j, L` distinct) is `(|ι| - 3) c + e`. -/
theorem sum_off_three_gen {i j L : ι} (hij : i ≠ j) (hiL : i ≠ L) (hjL : j ≠ L) (c e : ℝ) (f : ι → ℝ)
    (hf : ∀ l, l ≠ i → l ≠ j → l ≠ L → f l = c) (hi : f i = 0) (hj : f j = 0) (hL : f L = e) :
    ∑ l, f l = ((Fintype.card ι : ℝ) - 3) * c + e := by
  have hjm : j ∈ Finset.univ.erase i := Finset.mem_erase.mpr ⟨hij.symm, Finset.mem_univ j⟩
  have hLm : L ∈ (Finset.univ.erase i).erase j :=
    Finset.mem_erase.mpr ⟨hjL.symm, Finset.mem_erase.mpr ⟨hiL.symm, Finset.mem_univ L⟩⟩
  rw [← Finset.add_sum_erase _ _ (Finset.mem_univ i), hi, zero_add, ← Finset.add_sum_erase _ _ hjm, hj, zero_add,
    ← Finset.add_sum_erase _ _ hLm, hL,
    Finset.sum_congr rfl (fun l hl => hf l
      (Finset.ne_of_mem_erase (Finset.mem_of_mem_erase (Finset.mem_of_mem_erase hl)))
      (Finset.ne_of_mem_erase (Finset.mem_of_mem_erase hl)) (Finset.ne_of_mem_erase hl)),
    Finset.sum_const, Finset.card_erase_of_mem hLm, Finset.card_erase_of_mem hjm,
    Finset.card_erase_of_mem (Finset.mem_univ i), Finset.card_univ, nsmul_eq_mul]
  have h3 : 3 ≤ Fintype.card ι := by
    have : ({i, j, L} : Finset ι).card = 3 := by
      rw [Finset.card_insert_of_notMem (by simp [hij, hiL]), Finset.card_pair hjL]
    rw [← this]; exact Finset.card_le_univ _
  rw [Nat.cast_sub (by omega), Nat.cast_sub (by omega), Nat.cast_sub (by omega)]; push_cast; ring

/-- The weights of `a P_𝔨 + b P_𝔭` at `𝔰𝔬(n - 1) ⊂ 𝔰𝔬(n)`, off the diagonal. -/
noncomputable def pairW (n : ℕ) (a b : ℝ) : Matrix (Fin n) (Fin n) ℝ :=
  fun i j => if i = j then 0 else if (i : ℕ) < n - 1 ∧ (j : ℕ) < n - 1 then a else b

theorem pairW_symm (n : ℕ) (a b : ℝ) : (pairW n a b)ᵀ = pairW n a b := by
  ext i j
  simp only [Matrix.transpose_apply, pairW]
  by_cases h : i = j
  · subst h; rfl
  · rw [if_neg h, if_neg (Ne.symm h)]
    by_cases h2 : (i : ℕ) < n - 1 ∧ (j : ℕ) < n - 1
    · rw [if_pos h2, if_pos ⟨h2.2, h2.1⟩]
    · rw [if_neg h2, if_neg (fun h3 => h2 ⟨h3.2, h3.1⟩)]

theorem pairW_diag (n : ℕ) (a b : ℝ) (x : Fin n) : pairW n a b x x = 0 := by simp [pairW]

theorem pairW_ss {n : ℕ} (a b : ℝ) {i j : Fin n} (hij : i ≠ j) (hi : (i : ℕ) < n - 1) (hj : (j : ℕ) < n - 1) :
    pairW n a b i j = a := by simp [pairW, hij, hi, hj]

theorem pairW_sL {n : ℕ} (a b : ℝ) {i j : Fin n} (hij : i ≠ j) (hj : ¬ (j : ℕ) < n - 1) :
    pairW n a b i j = b := by simp [pairW, hij, hj]

theorem pairW_Ls {n : ℕ} (a b : ℝ) {i j : Fin n} (hij : i ≠ j) (hi : ¬ (i : ℕ) < n - 1) :
    pairW n a b i j = b := by simp [pairW, hij, hi]

/-- `IsIdem (coordOp w) ↔ w ⋆ w = w` off the diagonal. -/
theorem isIdem_coordOp_iff (w : Matrix ι ι ℝ) (hw : wᵀ = w) (hw0 : ∀ x, w x x = 0) :
    IsIdem (coordOp w) ↔ ∀ i j, i ≠ j → starW w i j = w i j := by
  unfold IsIdem
  rw [sharpMapCL_coordOp w hw hw0]
  constructor
  · intro h i j hij
    have h1 := congrArg (fun R : CurvOp2 ι => ((R ⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι) : Matrix ι ι ℝ) i j) h
    simp only [coordOp_coe _ (starW_symm w hw), coordOp_coe _ hw, hadamard_phi _ (starW_symm w hw),
      hadamard_phi _ hw, Matrix.smul_apply, smul_eq_mul, phi, Matrix.sub_apply, Matrix.single_apply] at h1
    simpa [hij, Ne.symm hij] using h1
  · intro h
    refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
    have hX : (X : Matrix ι ι ℝ)ᵀ = -X := X.2
    have h0 : ∀ x, (X : Matrix ι ι ℝ) x x = 0 := fun x => by
      have := congrFun (congrFun hX x) x
      simp only [Matrix.transpose_apply, Matrix.neg_apply] at this; linarith
    rw [coordOp_coe _ (starW_symm w hw), coordOp_coe _ hw]
    ext x y
    simp only [Matrix.hadamard_apply]
    by_cases hxy : x = y
    · subst hxy; rw [h0]; ring
    · rw [h x y hxy]

/-- **L262 at the symmetric pair `𝔰𝔬(n - 1) ⊂ 𝔰𝔬(n)`** (`𝔨` of one induced Casimir value, `c_𝔨 = n - 3`): the
idempotents among `a P_𝔨 + b P_𝔭` are exactly `0`, `P_𝔨/(n - 3)`, `I/(n - 2)` and `σ/(n - 2)`, `σ = P_𝔨 - P_𝔭`.
*Screened at `n = 5, 6, 7` against the repository's Hamilton product.* -/
theorem L262_son (n : ℕ) (hn : 5 ≤ n) (a b : ℝ) :
    let Pk : CurvOp2 (Fin n) := coordOp (fun i j => if (i : ℕ) < n - 1 ∧ (j : ℕ) < n - 1 then 1 else 0)
    let Pp : CurvOp2 (Fin n) := idOp - Pk
    IsIdem (a • Pk + b • Pp) ↔
      ((a = 0 ∧ b = 0) ∨ (a = 1 / ((n : ℝ) - 3) ∧ b = 0) ∨ (a = 1 / ((n : ℝ) - 2) ∧ b = 1 / ((n : ℝ) - 2)) ∨
        (a = 1 / ((n : ℝ) - 2) ∧ b = -(1 / ((n : ℝ) - 2)))) := by
  intro Pk Pp
  have hn' : (5 : ℝ) ≤ n := by exact_mod_cast hn
  set χ : Matrix (Fin n) (Fin n) ℝ := Matrix.of fun i j => if (i : ℕ) < n - 1 ∧ (j : ℕ) < n - 1 then (1 : ℝ) else 0
    with hχdef
  have hχs : χᵀ = χ := by
    ext i j; simp only [hχdef, Matrix.transpose_apply, Matrix.of_apply, and_comm]
  have hχ : ∀ X : skewSub (Fin n), ((Pk X : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ) = χ ⊙ (X : Matrix _ _ ℝ) :=
    fun X => coordOp_coe χ hχs X
  have hcomb : a • Pk + b • Pp = coordOp (pairW n a b) := by
    refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
    have hX : (X : Matrix (Fin n) (Fin n) ℝ)ᵀ = -X := X.2
    have h0 : ∀ x, (X : Matrix (Fin n) (Fin n) ℝ) x x = 0 := fun x => by
      have := congrFun (congrFun hX x) x
      simp only [Matrix.transpose_apply, Matrix.neg_apply] at this; linarith
    rw [coordOp_coe _ (pairW_symm n a b)]
    show a • ((Pk X : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ)
      + b • ((X : Matrix (Fin n) (Fin n) ℝ) - ((Pk X : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ)) = _
    rw [hχ]
    ext x y
    simp only [Matrix.add_apply, Matrix.smul_apply, Matrix.sub_apply, Matrix.hadamard_apply, smul_eq_mul, pairW,
      hχdef, Matrix.of_apply]
    by_cases hxy : x = y
    · subst hxy; rw [h0]; ring
    · rw [if_neg hxy]; split_ifs <;> ring
  rw [hcomb, isIdem_coordOp_iff _ (pairW_symm n a b) (pairW_diag n a b)]
  have hL : (n : ℕ) - 1 < n := by omega
  set L : Fin n := ⟨n - 1, hL⟩ with hLdef
  have small : ∀ i : Fin n, i ≠ L → (i : ℕ) < n - 1 := fun i hi => by
    have := i.2; have : (i : ℕ) ≠ n - 1 := fun h => hi (Fin.ext h); omega
  have hLnot : ¬ ((L : ℕ) < n - 1) := by simp [hLdef]
  have vss : ∀ i j : Fin n, i ≠ j → i ≠ L → j ≠ L →
      starW (pairW n a b) i j = ((n : ℝ) - 3) * a ^ 2 + b ^ 2 := by
    intro i j hij hiL hjL
    unfold starW
    rw [sum_off_three_gen hij hiL hjL (a ^ 2) (b ^ 2) _ ?_ (by rw [pairW_diag]; ring) (by rw [pairW_diag]; ring) ?_]
    · simp
    · intro l hli hlj hlL
      rw [pairW_ss a b (Ne.symm hli) (small i hiL) (small l hlL), pairW_ss a b hlj (small l hlL) (small j hjL)]; ring
    · rw [pairW_sL a b hiL hLnot, pairW_Ls a b (Ne.symm hjL) hLnot]; ring
  have vsL : ∀ i : Fin n, i ≠ L → starW (pairW n a b) i L = ((n : ℝ) - 2) * (a * b) := by
    intro i hiL
    unfold starW
    rw [show (n : ℝ) = (Fintype.card (Fin n) : ℝ) by rw [Fintype.card_fin]]
    refine sum_off_two_gen hiL (a * b) (fun l => pairW n a b i l * pairW n a b l L) (fun l hli hlL => ?_) ?_ ?_
    · show pairW n a b i l * pairW n a b l L = a * b
      rw [pairW_ss a b (Ne.symm hli) (small i hiL) (small l hlL), pairW_sL a b hlL hLnot]
    · show pairW n a b i i * pairW n a b i L = 0
      rw [pairW_diag]; ring
    · show pairW n a b i L * pairW n a b L L = 0
      rw [pairW_diag]; ring
  have i0 : (⟨0, by omega⟩ : Fin n) ≠ L := by simp [hLdef, Fin.ext_iff]; omega
  have i1 : (⟨1, by omega⟩ : Fin n) ≠ L := by simp [hLdef, Fin.ext_iff]; omega
  have i01 : (⟨0, by omega⟩ : Fin n) ≠ ⟨1, by omega⟩ := by simp [Fin.ext_iff]
  have hsys : (∀ i j : Fin n, i ≠ j → starW (pairW n a b) i j = pairW n a b i j) ↔
      (a = ((n : ℝ) - 3) * a ^ 2 + b ^ 2 ∧ b = ((n : ℝ) - 2) * (a * b)) := by
    constructor
    · intro h
      refine ⟨?_, ?_⟩
      · have := h _ _ i01
        rw [vss _ _ i01 i0 i1, pairW_ss a b i01 (small _ i0) (small _ i1)] at this
        linarith
      · have := h _ _ i0
        rw [vsL _ i0, pairW_sL a b i0 hLnot] at this
        linarith
    · rintro ⟨h1, h2⟩ i j hij
      by_cases hiL : i = L
      · subst hiL
        have hjL : j ≠ L := Ne.symm hij
        rw [← Matrix.transpose_apply (starW (pairW n a b)), starW_symm _ (pairW_symm n a b), vsL j hjL,
          pairW_Ls a b hij hLnot]; linarith
      · by_cases hjL : j = L
        · subst hjL; rw [vsL i hiL, pairW_sL a b hij hLnot]; linarith
        · rw [vss i j hij hiL hjL, pairW_ss a b hij (small i hiL) (small j hjL)]; linarith
  rw [hsys]
  have hc3 : (0 : ℝ) < (n : ℝ) - 3 := by linarith
  have hc2 : (0 : ℝ) < (n : ℝ) - 2 := by linarith
  constructor
  · rintro ⟨h1, h2⟩
    have hb : b * (1 - ((n : ℝ) - 2) * a) = 0 := by linarith
    rcases mul_eq_zero.mp hb with hb0 | ha1
    · subst hb0
      have : a * (((n : ℝ) - 3) * a - 1) = 0 := by linarith
      rcases mul_eq_zero.mp this with ha0 | ha1
      · left; exact ⟨ha0, rfl⟩
      · right; left; refine ⟨?_, rfl⟩; field_simp; linarith
    · have ha : a = 1 / ((n : ℝ) - 2) := by field_simp; linarith
      have hb2 : b ^ 2 = (1 / ((n : ℝ) - 2)) ^ 2 := by
        rw [ha] at h1; field_simp at h1 ⊢; nlinarith
      rcases sq_eq_sq_iff_eq_or_eq_neg.mp hb2 with hbp | hbn
      · right; right; left; exact ⟨ha, hbp⟩
      · right; right; right; exact ⟨ha, hbn⟩
  · rintro (⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩)
    · constructor <;> ring
    · constructor <;> field_simp <;> ring
    · constructor <;> field_simp <;> ring
    · constructor <;> field_simp <;> ring

/-- **L270 (4) on the torus family.** A positive torus-invariant idempotent lighter than `I/(2m - 2)` has
`∑_{i<j} (U_ij² + V_ij²) < m/(4(m - 1))`. *The proof uses neither `hidem` nor `hpos`: the bound holds on the whole
slice `A = A_μ`, and an arbitrary torus idempotent reaches that slice through `L268_torus_idem`.* -/
theorem L270_torus_light {m : ℕ} (hm : 3 ≤ m) (U V : Matrix (Fin m) (Fin m) ℝ) (hU : IsPairWeights U)
    (hV : IsPairWeights V) (hpos : ∀ i j, i ≠ j → 0 < U i j ∧ 0 < V i j)
    (hidem : IsIdem (torusOp (Amu U V) U V))
    (hlight : normSq2 (torusOp (Amu U V) U V) < normSq2 (idOp : CurvOp2 (Fin m × Fin 2)) / (2 * ((m : ℝ) - 1)) ^ 2) :
    (1 / 2 : ℝ) * ∑ i, ∑ j, (U i j ^ 2 + V i j ^ 2) < (m : ℝ) / (4 * ((m : ℝ) - 1)) := by
  obtain ⟨hUt, hU0⟩ := hU
  obtain ⟨hVt, hV0⟩ := hV
  set y := (1 / 2 : ℝ) * ∑ i, ∑ j, (U i j ^ 2 + V i j ^ 2) with hy
  have hm' : (3 : ℝ) ≤ m := by exact_mod_cast hm
  have hm1 : (0 : ℝ) < (m : ℝ) - 1 := by linarith
  have hy0 : 0 ≤ y := by rw [hy]; positivity
  -- the norm, from the torus inner product
  have hq := normSq2_torusOp (Amu U V) U V hUt hVt
  have hoff : ∑ k, ∑ l, (if k = l then (0 : ℝ) else U k l ^ 2 + V k l ^ 2) = 2 * y := by
    rw [hy, ← mul_assoc, show (2 : ℝ) * (1 / 2) = 1 by norm_num, one_mul]
    refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => ?_
    split_ifs with h
    · subst h; rw [hU0, hV0]; ring
    · rfl
  -- the Cartan block's squared norm is at least that of its diagonal, at least (tr A_μ)²/m
  have hdiag : ∑ k, Amu U V k k ^ 2 ≤ ∑ k, ∑ t, Amu U V k t ^ 2 :=
    Finset.sum_le_sum fun k _ => Finset.single_le_sum (f := fun t => Amu U V k t ^ 2)
      (fun t _ => sq_nonneg _) (Finset.mem_univ k)
  have htr : ∑ k, Amu U V k k = 2 * y := by
    rw [hy]; simp only [Amu, if_true]; ring
  have hcs : (∑ k, Amu U V k k) ^ 2 ≤ (m : ℝ) * ∑ k, Amu U V k k ^ 2 := by
    have := sq_sum_le_card_mul_sum_sq (s := (Finset.univ : Finset (Fin m))) (f := fun k => Amu U V k k)
    simpa [Finset.card_univ, Fintype.card_fin] using this
  have hlow : 4 * y ^ 2 / m + 2 * y ≤ normSq2 (torusOp (Amu U V) U V) := by
    rw [hq, hoff]
    have hm0 : (0 : ℝ) < m := by linarith
    rw [htr] at hcs
    have : 4 * y ^ 2 / m ≤ ∑ k, Amu U V k k ^ 2 := by
      rw [div_le_iff₀ hm0]; nlinarith
    linarith
  rw [normSq2_idOp_torus] at hlight
  by_contra hge
  push_neg at hge
  have hm0 : (0 : ℝ) < m := by linarith
  -- `4y²/m + 2y` increases on `y ≥ 0`, and equals `‖I‖²/(2m - 2)²` at `y = m/(4(m - 1))`
  have hmono : 4 * ((m : ℝ) / (4 * ((m : ℝ) - 1))) ^ 2 / m + 2 * ((m : ℝ) / (4 * ((m : ℝ) - 1))) ≤ 4 * y ^ 2 / m + 2 * y := by
    have h0 : 0 ≤ (m : ℝ) / (4 * ((m : ℝ) - 1)) := by positivity
    have hsq : ((m : ℝ) / (4 * ((m : ℝ) - 1))) ^ 2 ≤ y ^ 2 := pow_le_pow_left₀ h0 hge 2
    have : 4 * ((m : ℝ) / (4 * ((m : ℝ) - 1))) ^ 2 / m ≤ 4 * y ^ 2 / m := by
      apply div_le_div_of_nonneg_right _ hm0.le; linarith
    linarith
  have hval : 4 * ((m : ℝ) / (4 * ((m : ℝ) - 1))) ^ 2 / m + 2 * ((m : ℝ) / (4 * ((m : ℝ) - 1)))
      = (m : ℝ) * (2 * (m : ℝ) - 1) / (2 * ((m : ℝ) - 1)) ^ 2 := by
    field_simp; ring
  linarith

/-- **L272 (4).** `(X - ρ)(X + ρ - 1)` vanishes outside `S × S`, `S` the rows where `Q ≠ 0`. -/
theorem L272_support {m : ℕ} (hm : 3 ≤ m) (U V : Matrix (Fin m) (Fin m) ℝ) (hU : IsPairWeights U)
    (hV : IsPairWeights V) (hpos : ∀ i j, i ≠ j → 0 < U i j ∧ 0 < V i j) (hsys : TorusSystem U V) (ρ : ℝ)
    (hρ : ∃ w : Fin m → ℝ, (∀ i, 0 < w i) ∧ ((U + V) + Matrix.diagonal (dvec U V)).mulVec w = ρ • w) :
    let X := (U + V) + Matrix.diagonal (dvec U V)
    ∀ i j : Fin m, ((∀ l, U i l = V i l) ∨ (∀ l, U j l = V j l)) →
      ((X - ρ • (1 : Matrix (Fin m) (Fin m) ℝ)) * (X + (ρ - 1) • (1 : Matrix (Fin m) (Fin m) ℝ))) i j = 0 := by
  intro X i j hrow
  have hL := L272_perron hm U V hU hV hpos hsys ρ hρ
  obtain ⟨hUt, hU0⟩ := hU
  obtain ⟨hVt, hV0⟩ := hV
  have hsU : ∀ i j, U i j = U j i := fun i j => by rw [← Matrix.transpose_apply U j i, hUt]
  have hsV : ∀ i j, V i j = V j i := fun i j => by rw [← Matrix.transpose_apply V j i, hVt]
  have hP0 : ∀ i, (U + V) i i = 0 := fun i => by simp [hU0, hV0]
  have e : (X - ρ • (1 : Matrix (Fin m) (Fin m) ℝ)) * (X + (ρ - 1) • (1 : Matrix (Fin m) (Fin m) ℝ))
      = X * X - X - (ρ * (ρ - 1)) • (1 : Matrix (Fin m) (Fin m) ℝ) := by
    simp only [sub_mul, mul_add, Matrix.smul_mul, Matrix.mul_smul, Matrix.mul_one, Matrix.one_mul, smul_smul]
    module
  rw [e, Matrix.sub_apply, Matrix.sub_apply, Matrix.smul_apply, sq_add_diag _ _ hP0, smul_eq_mul]
  by_cases hij : i = j
  · subst hij
    have hr : ∀ l, U i l = V i l := by simpa using hrow
    have hdi := hL.2.1 i hr
    have hPP : ((U + V) * (U + V)) i i = 2 * dvec U V i := by
      rw [Matrix.mul_apply]; unfold dvec; rw [Finset.mul_sum]
      exact Finset.sum_congr rfl fun l _ => by
        simp only [Matrix.add_apply]; rw [hsU l i, hsV l i, hr l]; ring
    simp only [X, Matrix.add_apply, Matrix.diagonal_apply_eq, hP0, Matrix.one_apply_eq, hPP, hdi, if_true]
    ring
  · have hq : U i j = V i j := by
      rcases hrow with h | h
      · exact h j
      · rw [hsU, hsV]; exact h i
    have hpq := ((L271_pq_system U V).mp hsys i j hij).1
    simp only [Matrix.sub_apply, hq, sub_self] at hpq
    simp only [X, Matrix.add_apply, Matrix.diagonal_apply_ne _ hij, Matrix.one_apply_ne hij, if_neg hij]
    simp only [Matrix.add_apply] at hpq
    linarith

/-! ## A maximiser of `F` on the unit sphere of self-adjoint operators, and L260 (3), L270 (3) -/

theorem zero_smul_op (X : CurvOp2 ι) : (0 : ℝ) • X = 0 := ContinuousLinearMap.ext fun Y => by simp

theorem Ftri_zero_left (B C : CurvOp2 ι) : Ftri 0 B C = 0 := by
  have h := Ftri_smul_left 0 (0 : CurvOp2 ι) B C
  rw [zero_smul_op, zero_mul] at h
  exact h

theorem Ftri_zero_mid (A C : CurvOp2 ι) : Ftri A 0 C = 0 := by
  have h := Ftri_smul_mid 0 A (0 : CurvOp2 ι) C
  rw [zero_smul_op, zero_mul] at h
  exact h

theorem Ftri_zero_right (A B : CurvOp2 ι) : Ftri A B 0 = 0 := by
  have h := Ftri_smul_right 0 A B (0 : CurvOp2 ι)
  rw [zero_smul_op, zero_mul] at h
  exact h

theorem Ftri_sum_left {κ : Type*} (s : Finset κ) (A : κ → CurvOp2 ι) (B C : CurvOp2 ι) :
    Ftri (∑ k ∈ s, A k) B C = ∑ k ∈ s, Ftri (A k) B C := by
  classical
  refine Finset.induction_on s ?_ ?_
  · simp [Ftri_zero_left]
  · intro a s ha ih
    rw [Finset.sum_insert ha, Finset.sum_insert ha, Ftri_add_left, ih]

theorem Ftri_sum_mid {κ : Type*} (s : Finset κ) (A : CurvOp2 ι) (B : κ → CurvOp2 ι) (C : CurvOp2 ι) :
    Ftri A (∑ k ∈ s, B k) C = ∑ k ∈ s, Ftri A (B k) C := by
  classical
  refine Finset.induction_on s ?_ ?_
  · simp [Ftri_zero_mid]
  · intro a s ha ih
    rw [Finset.sum_insert ha, Finset.sum_insert ha, Ftri_add_mid, ih]

theorem Ftri_sum_right {κ : Type*} (s : Finset κ) (A B : CurvOp2 ι) (C : κ → CurvOp2 ι) :
    Ftri A B (∑ k ∈ s, C k) = ∑ k ∈ s, Ftri A B (C k) := by
  classical
  refine Finset.induction_on s ?_ ?_
  · simp [Ftri_zero_right]
  · intro a s ha ih
    rw [Finset.sum_insert ha, Finset.sum_insert ha, Ftri_add_right, ih]

theorem isPSD2_smul {Y : CurvOp2 ι} (hY : IsPSD2 Y) {c : ℝ} (hc : 0 ≤ c) : IsPSD2 (c • Y) := fun X => by
  have h := hY X
  simp only [_root_.smul_apply, Submodule.coe_smul]
  unfold inner2 at *
  simp only [Matrix.transpose_smul, Matrix.smul_mul, Matrix.trace_smul, smul_eq_mul] at *
  nlinarith [mul_nonneg hc h]

/-- The self-adjoint operators, under the record's norm. -/
def saR (ι : Type*) [Fintype ι] [DecidableEq ι] : Submodule ℝ (RecCurv ι) where
  carrier := {v | IsSelfAdjoint2 (show CurvOp2 ι from v)}
  add_mem' := fun hv hw => isSelfAdjoint2_add hv hw
  zero_mem' := by
    show IsSelfAdjoint2 (0 : CurvOp2 ι)
    intro X Y
    simp [inner2]
  smul_mem' := fun c _ hv => isSelfAdjoint2_smul hv c

/-- The underlying operator. -/
def sv (x : saR ι) : CurvOp2 ι := show CurvOp2 ι from (x : RecCurv ι)

theorem sv_sa (x : saR ι) : IsSelfAdjoint2 (sv x) := x.2

theorem sv_norm_sq (x : saR ι) : ‖x‖ ^ 2 = normSq2 (sv x) := by
  have h : ‖x‖ = ‖(x : RecCurv ι)‖ := (Submodule.coe_norm x).symm
  rw [h]
  exact RecCurv.norm_sq_eq (x : RecCurv ι)

theorem continuous_Ftri_sv : Continuous (fun x : saR ι => Ftri (sv x) (sv x) (sv x)) := by
  let b := Module.finBasis ℝ (saR ι)
  have hc : Continuous (fun x : saR ι => b.equivFun x) :=
    LinearMap.continuous_of_finiteDimensional b.equivFun.toLinearMap
  have hci : ∀ i, Continuous (fun x : saR ι => b.equivFun x i) := fun i => (continuous_apply i).comp hc
  have hx : ∀ x : saR ι, sv x = ∑ i, b.equivFun x i • sv (b i) := fun x => by
    conv_lhs => rw [← b.sum_equivFun x]
    simp only [sv, Submodule.coe_sum, Submodule.coe_smul]
    rfl
  have e : (fun x : saR ι => Ftri (sv x) (sv x) (sv x)) = fun x =>
      ∑ i, ∑ j, ∑ k, b.equivFun x i * (b.equivFun x j * (b.equivFun x k * Ftri (sv (b k)) (sv (b j)) (sv (b i)))) := by
    funext x
    rw [hx x]
    simp only [Ftri_sum_left, Ftri_sum_mid, Ftri_sum_right, Ftri_smul_left, Ftri_smul_mid, Ftri_smul_right,
      Finset.mul_sum]
  rw [e]
  fun_prop

/-- **A maximiser of `F` on the unit sphere of self-adjoint operators exists**, the sphere being compact. -/
theorem exists_sa_maximiser (hn : 2 ≤ Fintype.card ι) :
    ∃ X : CurvOp2 ι, IsSelfAdjoint2 X ∧ normSq2 X = 1 ∧
      ∀ Y : CurvOp2 ι, IsSelfAdjoint2 Y → normSq2 Y = 1 → Ftri Y Y Y ≤ Ftri X X X := by
  have : ProperSpace (saR ι) := FiniteDimensional.proper_real _
  have hK : IsCompact (Metric.sphere (0 : saR ι) 1) := isCompact_sphere 0 1
  -- a nonzero self-adjoint operator: the identity
  obtain ⟨i, j, hij⟩ := Fintype.exists_pair_of_one_lt_card (by omega : 1 < Fintype.card ι)
  have hid0 : normSq2 (idOp : CurvOp2 ι) ≠ 0 := by
    intro h
    have h0 := normSq2_eq_zero h
    have := congrArg (fun R : CurvOp2 ι => ((R ⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι) : Matrix ι ι ℝ) j i) h0
    simp [phi, Matrix.single_apply, hij, Ne.symm hij] at this
  have hidpos : 0 < normSq2 (idOp : CurvOp2 ι) := lt_of_le_of_ne (normSq2_nonneg _) (Ne.symm hid0)
  set r := Real.sqrt (normSq2 (idOp : CurvOp2 ι)) with hr
  have hr0 : 0 < r := Real.sqrt_pos.mpr hidpos
  have hr2 : r ^ 2 = normSq2 (idOp : CurvOp2 ι) := Real.sq_sqrt hidpos.le
  obtain ⟨x0, hx0d⟩ : ∃ x0 : saR ι, sv x0 = r⁻¹ • (idOp : CurvOp2 ι) :=
    ⟨⟨show RecCurv ι from r⁻¹ • (idOp : CurvOp2 ι), isSelfAdjoint2_smul idOp_isSelfAdjoint2 r⁻¹⟩, rfl⟩
  have hx0 : x0 ∈ Metric.sphere (0 : saR ι) 1 := by
    rw [mem_sphere_zero_iff_norm]
    have h2 : ‖x0‖ ^ 2 = 1 := by
      rw [sv_norm_sq, hx0d, normSq2_smul', inv_pow, hr2, inv_mul_cancel₀ hid0]
    exact (pow_eq_one_iff_of_nonneg (norm_nonneg x0) two_ne_zero).mp h2
  obtain ⟨x, hx, hxmax⟩ := hK.exists_isMaxOn ⟨x0, hx0⟩ continuous_Ftri_sv.continuousOn
  have hxn : normSq2 (sv x) = 1 := by
    rw [← sv_norm_sq, mem_sphere_zero_iff_norm.mp hx]; norm_num
  refine ⟨sv x, sv_sa x, hxn, fun Y hY hY1 => ?_⟩
  obtain ⟨y, hyd⟩ : ∃ y : saR ι, sv y = Y := ⟨⟨show RecCurv ι from Y, hY⟩, rfl⟩
  have hy : y ∈ Metric.sphere (0 : saR ι) 1 := by
    rw [mem_sphere_zero_iff_norm]
    have h2 : ‖y‖ ^ 2 = 1 := by rw [sv_norm_sq, hyd]; exact hY1
    exact (pow_eq_one_iff_of_nonneg (norm_nonneg y) two_ne_zero).mp h2
  have := isMaxOn_iff.mp hxmax y hy
  rw [hyd] at this
  exact this

/-- The homogeneous form of the bound: a bound `F ≤ κ` on the unit sphere of self-adjoint operators is statement
H at every norm. -/
theorem statementH_of_unit {κ : ℝ} (hκ : 0 ≤ κ)
    (h : ∀ X : CurvOp2 ι, IsSelfAdjoint2 X → normSq2 X = 1 → Ftri X X X ≤ κ) :
    ∀ X : CurvOp2 ι, IsSelfAdjoint2 X → Ftri X X X ≤ κ * normSq2 X ^ ((3 : ℝ) / 2) := by
  intro X hX
  have hn0 := normSq2_nonneg X
  rcases hn0.lt_or_eq with hpos | hzero
  · set r := Real.sqrt (normSq2 X) with hr
    have hr0 : 0 < r := Real.sqrt_pos.mpr hpos
    have hr2 : r ^ 2 = normSq2 X := Real.sq_sqrt hn0
    have hU := h (r⁻¹ • X) (isSelfAdjoint2_smul hX r⁻¹) (by rw [normSq2_smul', inv_pow, hr2, inv_mul_cancel₀ hpos.ne'])
    rw [Ftri_cube_smul] at hU
    have hpow : normSq2 X ^ ((3 : ℝ) / 2) = r ^ 3 := by
      rw [← hr2, ← Real.rpow_natCast r 2, ← Real.rpow_mul hr0.le]
      norm_num
    rw [hpow]
    have hr3 : 0 < r ^ 3 := by positivity
    have e : Ftri X X X = r ^ 3 * (r⁻¹ ^ 3 * Ftri X X X) := by field_simp
    rw [e]
    nlinarith [mul_le_mul_of_nonneg_left hU hr3.le]
  · have hX0 : X = 0 := normSq2_eq_zero hzero.symm
    subst hX0
    rw [Ftri_zero_left, ← hzero, Real.zero_rpow (by norm_num), mul_zero]

/-- The maximiser's value against a norm bound on its idempotent: `F(X) ≤ κ_n` once `‖C‖² ≥ N/(n - 2)²` at
`C = X/F(X)`. -/
theorem maximiser_le_kappa (hn : 3 ≤ Fintype.card ι) {f q : ℝ} (hf : 0 < f) (hq : q = (1 / f) ^ 2)
    (hb : (Fintype.card ι : ℝ) * ((Fintype.card ι : ℝ) - 1) / 2 / ((Fintype.card ι : ℝ) - 2) ^ 2 ≤ q) :
    f ≤ kappaN ι := by
  have hn' : (3 : ℝ) ≤ Fintype.card ι := by exact_mod_cast hn
  set c := (Fintype.card ι : ℝ) - 2 with hc
  set N := (Fintype.card ι : ℝ) * ((Fintype.card ι : ℝ) - 1) / 2 with hN
  have hc0 : 0 < c := by linarith
  have hN0 : 0 < N := by rw [hN]; nlinarith
  have hsN : 0 < Real.sqrt N := Real.sqrt_pos.mpr hN0
  have hsN2 : Real.sqrt N ^ 2 = N := Real.sq_sqrt hN0.le
  show f ≤ c / Real.sqrt N
  rw [le_div_iff₀ hsN]
  have key : N * f ^ 2 ≤ c ^ 2 := by
    rw [hq, div_le_iff₀ (by positivity)] at hb
    have : (1 / f) ^ 2 * c ^ 2 * f ^ 2 = c ^ 2 := by field_simp
    nlinarith [mul_le_mul_of_nonneg_right hb (sq_nonneg f)]
  nlinarith [sq_nonneg (f * Real.sqrt N - c), mul_pos hf hsN]

/-- **L260 (3), the direction H needs.** If every positive semidefinite `#`-idempotent `C ≠ 0` has
`‖C‖² ≥ N/(n - 2)²`, statement H holds on `𝔰𝔬(n)`. *Proved from `L260_psd_cone` (L260 (1)), `L264_maximiser_stable`
and a maximiser on the compact unit sphere of self-adjoint operators.* -/
theorem L260_H_of_norm_bound (hn : 3 ≤ Fintype.card ι)
    (hbound : ∀ C : CurvOp2 ι, IsSelfAdjoint2 C → IsPSD2 C → IsIdem C → C ≠ 0 →
      (Fintype.card ι : ℝ) * ((Fintype.card ι : ℝ) - 1) / 2 / ((Fintype.card ι : ℝ) - 2) ^ 2 ≤ normSq2 C) :
    StatementH ι := by
  have hκ : 0 ≤ kappaN ι := by
    have : (3 : ℝ) ≤ Fintype.card ι := by exact_mod_cast hn
    unfold kappaN; exact div_nonneg (by linarith) (Real.sqrt_nonneg _)
  refine statementH_of_unit hκ ?_
  obtain ⟨X, hX, hX1, hmax⟩ := exists_sa_maximiser (ι := ι) (by omega)
  intro Z hZ hZ1
  refine (hmax Z hZ hZ1).trans ?_
  rcases le_or_gt (Ftri X X X) 0 with hle | hpos
  · exact hle.trans hκ
  obtain ⟨Y, hY, hYp, hYn, hXY⟩ := L260_psd_cone X hX
  rw [hX1] at hYn
  have hYmax : ∀ W : CurvOp2 ι, IsSelfAdjoint2 W → normSq2 W = 1 → Ftri W W W ≤ Ftri Y Y Y :=
    fun W hW hW1 => (hmax W hW hW1).trans hXY
  have hYX : Ftri Y Y Y = Ftri X X X := le_antisymm (hmax Y hY hYn) hXY
  have hYpos : 0 < Ftri Y Y Y := by rw [hYX]; exact hpos
  obtain ⟨hidem, -⟩ := L264_maximiser_stable Y hY hYn hYmax hYpos
  have hCn : normSq2 ((1 / Ftri Y Y Y) • Y) = (1 / Ftri Y Y Y) ^ 2 := by rw [normSq2_smul', hYn, mul_one]
  have hC0 : (1 / Ftri Y Y Y) • Y ≠ 0 := by
    intro h0
    have hpos2 : 0 < normSq2 ((1 / Ftri Y Y Y) • Y) := by rw [hCn]; exact pow_pos (one_div_pos.mpr hYpos) 2
    have h00 : normSq2 (0 : CurvOp2 ι) = 0 := by
      have h := innerOp2_smul_left 0 (0 : CurvOp2 ι) 0
      rw [zero_smul_op, zero_mul] at h
      exact h
    rw [h0, h00] at hpos2
    exact lt_irrefl _ hpos2
  have hb := hbound ((1 / Ftri Y Y Y) • Y) (isSelfAdjoint2_smul hY _) (isPSD2_smul hYp (le_of_lt (one_div_pos.mpr hYpos))) hidem hC0
  rw [← hYX]
  exact maximiser_le_kappa hn hYpos hCn hb

/-- **L264 (3) with L270 (3).** If every stable positive semidefinite idempotent `C ≠ 0` on `𝔰𝔬(n)` has
`‖C‖² ≥ N/(n - 2)²` (U$_{\mathrm s}'$ read at `𝔰𝔬(n)`, with L256 supplying the subalgebra comparison),
statement H holds. *Proved from `L260_psd_cone`, `L264_maximiser_stable` and the compact unit sphere.* -/
theorem L270_H_of_Us' (hn : 9 ≤ Fintype.card ι)
    (hUs : ∀ C : CurvOp2 ι, IsSelfAdjoint2 C → IsPSD2 C → IsIdem C → C ≠ 0 → IsStable C →
      (Fintype.card ι : ℝ) * ((Fintype.card ι : ℝ) - 1) / 2 / ((Fintype.card ι : ℝ) - 2) ^ 2 ≤ normSq2 C) :
    StatementH ι := by
  have hn3 : 3 ≤ Fintype.card ι := by omega
  have hκ : 0 ≤ kappaN ι := by
    have : (3 : ℝ) ≤ Fintype.card ι := by exact_mod_cast hn3
    unfold kappaN; exact div_nonneg (by linarith) (Real.sqrt_nonneg _)
  refine statementH_of_unit hκ ?_
  obtain ⟨X, hX, hX1, hmax⟩ := exists_sa_maximiser (ι := ι) (by omega)
  intro Z hZ hZ1
  refine (hmax Z hZ hZ1).trans ?_
  rcases le_or_gt (Ftri X X X) 0 with hle | hpos
  · exact hle.trans hκ
  obtain ⟨Y, hY, hYp, hYn, hXY⟩ := L260_psd_cone X hX
  rw [hX1] at hYn
  have hYmax : ∀ W : CurvOp2 ι, IsSelfAdjoint2 W → normSq2 W = 1 → Ftri W W W ≤ Ftri Y Y Y :=
    fun W hW hW1 => (hmax W hW hW1).trans hXY
  have hYX : Ftri Y Y Y = Ftri X X X := le_antisymm (hmax Y hY hYn) hXY
  have hYpos : 0 < Ftri Y Y Y := by rw [hYX]; exact hpos
  obtain ⟨hidem, hstab⟩ := L264_maximiser_stable Y hY hYn hYmax hYpos
  have hCn : normSq2 ((1 / Ftri Y Y Y) • Y) = (1 / Ftri Y Y Y) ^ 2 := by rw [normSq2_smul', hYn, mul_one]
  have hC0 : (1 / Ftri Y Y Y) • Y ≠ 0 := by
    intro h0
    have hpos2 : 0 < normSq2 ((1 / Ftri Y Y Y) • Y) := by rw [hCn]; exact pow_pos (one_div_pos.mpr hYpos) 2
    have h00 : normSq2 (0 : CurvOp2 ι) = 0 := by
      have h := innerOp2_smul_left 0 (0 : CurvOp2 ι) 0
      rw [zero_smul_op, zero_mul] at h
      exact h
    rw [h0, h00] at hpos2
    exact lt_irrefl _ hpos2
  have hb := hUs ((1 / Ftri Y Y Y) • Y) (isSelfAdjoint2_smul hY _) (isPSD2_smul hYp (le_of_lt (one_div_pos.mpr hYpos))) hidem hC0 hstab
  rw [← hYX]
  exact maximiser_le_kappa hn3 hYpos hCn hb

theorem toSk_finsum {κ : Type*} (s : Finset κ) (g : κ → skewSub ι) : toSk (∑ k ∈ s, g k) = ∑ k ∈ s, toSk (g k) :=
  FrameExtension.toM_injective (by rw [FrameExtension.toM_sum]; simp [AddSubmonoidClass.coe_finsetSum, toM_toSk])

theorem toSk_smul' (r : ℝ) (g : skewSub ι) : toSk (r • g) = r • toSk g := FrameExtension.toM_injective rfl

theorem brS_sum_left {κ : Type*} (s : Finset κ) (f : κ → skewSub ι) (Y : skewSub ι) :
    brS (∑ k ∈ s, f k) Y = ∑ k ∈ s, brS (f k) Y := by
  have := map_sum ((LinearMap.mk₂ ℝ brS brS_add_left brS_smul_left brS_add_right brS_smul_right).flip Y) f s
  exact this

theorem brS_sum_right {κ : Type*} (s : Finset κ) (X : skewSub ι) (f : κ → skewSub ι) :
    brS X (∑ k ∈ s, f k) = ∑ k ∈ s, brS X (f k) := by
  have := map_sum (LinearMap.mk₂ ℝ brS brS_add_left brS_smul_left brS_add_right brS_smul_right X) f s
  exact this

/-- A bivector in an orthonormal basis. -/
theorem sk_expand {N : ℕ} (b : OrthonormalBasis (Fin N) ℝ (FrameExtension.SkewSp ι)) (Z : skewSub ι) :
    Z = ∑ δ, inner ℝ (b δ) (toSk Z) • ofSk (b δ) := by
  conv_lhs => rw [← ofSk_toSk Z, ← b.sum_repr' (toSk Z)]
  rw [ofSk_sum]; rfl

theorem toSk_sum_smul {N : ℕ} (b : OrthonormalBasis (Fin N) ℝ (FrameExtension.SkewSp ι)) (c : Fin N → ℝ) :
    toSk (∑ δ, c δ • ofSk (b δ)) = ∑ δ, c δ • b δ := by
  apply FrameExtension.toM_injective
  rw [FrameExtension.toM_sum, toM_toSk]
  simp only [AddSubmonoidClass.coe_finsetSum, Submodule.coe_smul, ofSk_coe, FrameExtension.toM_smul]

theorem inner_basis_sum {N : ℕ} (b : OrthonormalBasis (Fin N) ℝ (FrameExtension.SkewSp ι)) (c : Fin N → ℝ)
    (ε : Fin N) : inner ℝ (b ε) (∑ δ, c δ • b δ) = c ε := by
  rw [inner_sum]
  simp only [real_inner_smul_right, orthonormal_iff_ite.mp b.orthonormal, mul_ite, mul_one, mul_zero,
    Finset.sum_ite_eq, Finset.mem_univ, if_true]

/-- `⟨R Y, Z⟩ = ∑ λ_δ ⟨b_δ, Y⟩⟨b_δ, Z⟩` for `R` diagonal in `b`. -/
theorem inner2_diag_two {N : ℕ} (b : OrthonormalBasis (Fin N) ℝ (FrameExtension.SkewSp ι)) (R : CurvOp2 ι)
    (lam : Fin N → ℝ) (hR : ∀ β, R (ofSk (b β)) = lam β • ofSk (b β)) (Y Z : skewSub ι) :
    inner2 ((R Y : skewSub ι) : Matrix ι ι ℝ) (Z : Matrix ι ι ℝ)
      = ∑ δ, lam δ * inner ℝ (b δ) (toSk Y) * inner ℝ (b δ) (toSk Z) := by
  have hRY : R Y = ∑ δ, (lam δ * inner ℝ (b δ) (toSk Y)) • ofSk (b δ) := by
    conv_lhs => rw [sk_expand b Y]
    simp only [map_sum, map_smul, hR, smul_smul]
    exact Finset.sum_congr rfl fun δ _ => by ring_nf
  rw [← inner_toSk, hRY, toSk_sum_smul, sum_inner]
  exact Finset.sum_congr rfl fun δ _ => by rw [real_inner_smul_left]

/-- **`⟨(C#C)X, Y⟩` in an eigenframe of `C`.** -/
theorem sharpBil2_eigen {N : ℕ} (b : OrthonormalBasis (Fin N) ℝ (FrameExtension.SkewSp ι)) (C : CurvOp2 ι)
    (lam : Fin N → ℝ) (hC : ∀ β, C (ofSk (b β)) = lam β • ofSk (b β)) (X Y : skewSub ι) :
    sharpBil2 C X Y = (1 / 2) * ∑ β, ∑ γ, lam β * lam γ * inner ℝ (b β) (toSk (brS X (ofSk (b γ))))
      * inner ℝ (b β) (toSk (brS Y (ofSk (b γ)))) := by
  rw [sharpBil2_eq_crossPair2]
  let K : skewSub ι →ₗ[ℝ] skewSub ι →ₗ[ℝ] ℝ := LinearMap.mk₂ ℝ
    (fun W W' => inner2 ((brS X (C (brS Y (C W))) : skewSub ι) : Matrix ι ι ℝ) (W' : Matrix ι ι ℝ))
    (fun W₁ W₂ W' => by simp only [map_add, brS_add_right, Submodule.coe_add, i2_add_l])
    (fun c W W' => by simp only [map_smul, brS_smul_right, Submodule.coe_smul, i2_smul_l, smul_eq_mul])
    (fun W W₁' W₂' => by simp only [Submodule.coe_add, i2_add_r])
    (fun c W W' => by simp only [Submodule.coe_smul, i2_smul_r, smul_eq_mul])
  have hcp : crossPair2 C X Y = -(1 / 4) * ∑ i, ∑ j, K ⟨phi i j, phi_mem_skewSub i j⟩ ⟨phi i j, phi_mem_skewSub i j⟩ :=
    rfl
  have hK : ∀ γ, K (ofSk (b γ)) (ofSk (b γ))
      = -(lam γ * ∑ β, lam β * inner ℝ (b β) (toSk (brS Y (ofSk (b γ)))) * inner ℝ (b β) (toSk (brS X (ofSk (b γ))))) := by
    intro γ
    show inner2 ((brS X (C (brS Y (C (ofSk (b γ))))) : skewSub ι) : Matrix ι ι ℝ) (FrameExtension.toM (b γ)) = _
    rw [hC, brS_smul_right, map_smul, brS_smul_right, Submodule.coe_smul, i2_smul_l]
    have adj := HamiltonsCubic.L33Statement.ad_skewAdjoint (C (brS Y (ofSk (b γ)))).2 X.2 (ofSk (b γ)).2
    have e1 : ((brS X (C (brS Y (ofSk (b γ)))) : skewSub ι) : Matrix ι ι ℝ)
        = br (X : Matrix ι ι ℝ) ((C (brS Y (ofSk (b γ))) : skewSub ι) : Matrix ι ι ℝ) := rfl
    rw [e1, ← ofSk_coe, adj]
    have e2 : br (X : Matrix ι ι ℝ) ((ofSk (b γ) : skewSub ι) : Matrix ι ι ℝ)
        = ((brS X (ofSk (b γ)) : skewSub ι) : Matrix ι ι ℝ) := rfl
    rw [e2, inner2_diag_two b C lam hC]
    ring
  rw [hcp, phi_sum_change b K]
  simp only [hK, Finset.sum_neg_distrib]
  rw [show ∀ S : ℝ, -(1 / 4) * (2 * -S) = (1 / 2) * S from fun S => by ring]
  congr 1
  conv_rhs => rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun γ _ => ?_
  rw [Finset.mul_sum]
  refine Finset.sum_congr rfl fun β _ => ?_
  ring

/-- **L260 (2).** The range of a positive semidefinite `#`-idempotent is a subalgebra, perfect
(`[𝔥, 𝔥] = 𝔥`, hence semisimple for compact `𝔰𝔬(n)`), and the idempotent is positive definite on it. -/
theorem L260_range_subalgebra (C : CurvOp2 ι) (hC : IsSelfAdjoint2 C) (hpsd : IsPSD2 C) (hidem : IsIdem C) :
    (∀ X Y : skewSub ι, X ∈ LinearMap.range (C : skewSub ι →ₗ[ℝ] skewSub ι) →
        Y ∈ LinearMap.range (C : skewSub ι →ₗ[ℝ] skewSub ι) →
        brS X Y ∈ LinearMap.range (C : skewSub ι →ₗ[ℝ] skewSub ι)) ∧
    LinearMap.range (C : skewSub ι →ₗ[ℝ] skewSub ι)
      = Submodule.span ℝ {Z | ∃ X Y, X ∈ LinearMap.range (C : skewSub ι →ₗ[ℝ] skewSub ι) ∧
          Y ∈ LinearMap.range (C : skewSub ι →ₗ[ℝ] skewSub ι) ∧ Z = brS X Y} ∧
    (∀ X : skewSub ι, X ∈ LinearMap.range (C : skewSub ι →ₗ[ℝ] skewSub ι) → X ≠ 0 →
        0 < inner2 ((C X : skewSub ι) : Matrix ι ι ℝ) ((X : skewSub ι) : Matrix ι ι ℝ)) := by
  have hs := opSk_symm hC
  let b := hs.eigenvectorBasis (n := Module.finrank ℝ (FrameExtension.SkewSp ι)) rfl
  let lam := hs.eigenvalues (n := Module.finrank ℝ (FrameExtension.SkewSp ι)) rfl
  have hCb : ∀ β, C (ofSk (b β)) = lam β • ofSk (b β) := fun β => by
    have h := hs.apply_eigenvectorBasis (n := Module.finrank ℝ (FrameExtension.SkewSp ι)) rfl β
    have h2 : C (ofSk (b β)) = ofSk (opSk C (b β)) := rfl
    rw [h2, h, ofSk_smul]; rfl
  have hunit : ∀ β, inner2 (FrameExtension.toM (b β)) (FrameExtension.toM (b β)) = 1 := fun β => by
    rw [← FrameExtension.inner_def, real_inner_self_eq_norm_sq, b.orthonormal.1 β]; norm_num
  have hlam0 : ∀ β, 0 ≤ lam β := fun β => by
    have := hpsd (ofSk (b β))
    rw [hCb, Submodule.coe_smul, i2_smul_l, ofSk_coe, hunit, mul_one] at this; exact this
  -- idempotency, read as a bilinear identity
  have hid : ∀ X Y : skewSub ι, inner2 ((C X : skewSub ι) : Matrix ι ι ℝ) (Y : Matrix ι ι ℝ) = sharpBil2 C X Y := by
    intro X Y
    have : C X = sharpMapCL C X := by rw [hidem]
    rw [this, sharpMapCL_apply, inner2_sharpMap]
  set c : Fin _ → Fin _ → Fin _ → ℝ := fun β δ γ => inner ℝ (b β) (toSk (brS (ofSk (b δ)) (ofSk (b γ)))) with hcdef
  -- the bracket coefficients are cyclic
  have hcyc : ∀ β δ γ, inner ℝ (b δ) (toSk (brS (ofSk (b β)) (ofSk (b γ)))) = c γ δ β := by
    intro β δ γ
    show inner2 (FrameExtension.toM (b δ)) (br (FrameExtension.toM (b β)) (FrameExtension.toM (b γ)))
      = inner2 (FrameExtension.toM (b γ)) (br (FrameExtension.toM (b δ)) (FrameExtension.toM (b β)))
    have adj := HamiltonsCubic.L33Statement.ad_skewAdjoint (FrameExtension.toM_skew (b γ))
      (FrameExtension.toM_skew (b β)) (FrameExtension.toM_skew (b δ))
    rw [inner2_comm, adj]
    have e : br (FrameExtension.toM (b β)) (FrameExtension.toM (b δ))
        = -br (FrameExtension.toM (b δ)) (FrameExtension.toM (b β)) := by simp [br]
    rw [e]; unfold inner2; rw [Matrix.mul_neg, Matrix.trace_neg]; ring
  -- the diagonal of `C # C = C`
  have hdiag : ∀ δ, lam δ = (1 / 2) * ∑ β, ∑ γ, lam β * lam γ * c β δ γ ^ 2 := by
    intro δ
    have h := hid (ofSk (b δ)) (ofSk (b δ))
    rw [hCb, Submodule.coe_smul, i2_smul_l, ofSk_coe, hunit, mul_one, sharpBil2_eigen b C lam hCb] at h
    rw [h]; congr 1
    exact Finset.sum_congr rfl fun β _ => Finset.sum_congr rfl fun γ _ => by rw [hcdef]; ring
  have key0 : ∀ δ, lam δ = 0 → ∀ β γ, lam β ≠ 0 → lam γ ≠ 0 → c β δ γ = 0 := by
    intro δ hδ β γ hβ hγ
    have hnn : ∀ β γ, 0 ≤ lam β * lam γ * c β δ γ ^ 2 := fun β γ =>
      mul_nonneg (mul_nonneg (hlam0 β) (hlam0 γ)) (sq_nonneg _)
    have hz : ∑ β, ∑ γ, lam β * lam γ * c β δ γ ^ 2 = 0 := by rw [hdiag δ] at hδ; linarith
    have h1 := (Finset.sum_eq_zero_iff_of_nonneg (fun β _ => Finset.sum_nonneg fun γ _ => hnn β γ)).mp hz β
      (Finset.mem_univ β)
    have h2 := (Finset.sum_eq_zero_iff_of_nonneg (fun γ _ => hnn β γ)).mp h1 γ (Finset.mem_univ γ)
    have hp : 0 < lam β * lam γ := mul_pos (lt_of_le_of_ne (hlam0 β) (Ne.symm hβ)) (lt_of_le_of_ne (hlam0 γ) (Ne.symm hγ))
    exact pow_eq_zero_iff (n := 2) (by norm_num) |>.mp ((mul_eq_zero.mp h2).resolve_left hp.ne')
  -- membership in the range, coordinatewise
  have memR : ∀ Z : skewSub ι, Z ∈ LinearMap.range (C : skewSub ι →ₗ[ℝ] skewSub ι) ↔
      ∀ δ, lam δ = 0 → inner ℝ (b δ) (toSk Z) = 0 := by
    intro Z
    constructor
    · rintro ⟨W, rfl⟩ δ hδ
      show inner ℝ (b δ) (toSk (C W)) = 0
      rw [FrameExtension.inner_def, toM_toSk, ← ofSk_coe, inner2_comm, hC, hCb, Submodule.coe_smul, i2_smul_r,
        hδ, zero_mul]
    · intro h
      refine ⟨∑ δ, (if lam δ = 0 then 0 else inner ℝ (b δ) (toSk Z) / lam δ) • ofSk (b δ), ?_⟩
      show C (∑ δ, (if lam δ = 0 then 0 else inner ℝ (b δ) (toSk Z) / lam δ) • ofSk (b δ)) = Z
      simp only [map_sum, map_smul, hCb, smul_smul]
      conv_rhs => rw [sk_expand b Z]
      refine Finset.sum_congr rfl fun δ _ => ?_
      congr 1
      by_cases hδ : lam δ = 0
      · rw [if_pos hδ, h δ hδ]; ring
      · rw [if_neg hδ]; field_simp
  have memB : ∀ β, lam β ≠ 0 → ofSk (b β) ∈ LinearMap.range (C : skewSub ι →ₗ[ℝ] skewSub ι) := by
    intro β hβ
    rw [memR]
    intro δ hδ
    show inner ℝ (b δ) (b β) = 0
    rw [orthonormal_iff_ite.mp b.orthonormal, if_neg]
    rintro rfl; exact hβ hδ
  -- the bracket of two range elements
  have hbr : ∀ X Y : skewSub ι, X ∈ LinearMap.range (C : skewSub ι →ₗ[ℝ] skewSub ι) →
      Y ∈ LinearMap.range (C : skewSub ι →ₗ[ℝ] skewSub ι) → brS X Y ∈ LinearMap.range (C : skewSub ι →ₗ[ℝ] skewSub ι) := by
    intro X Y hX hY
    rw [memR] at hX hY ⊢
    intro δ hδ
    rw [sk_expand b X, sk_expand b Y]
    simp only [brS_sum_left, brS_sum_right, brS_smul_left, brS_smul_right]
    simp only [toSk_finsum, toSk_smul', inner_sum, real_inner_smul_right]
    refine Finset.sum_eq_zero fun β _ => ?_
    by_cases hβ : lam β = 0
    · rw [hY β hβ, zero_mul]
    · refine mul_eq_zero_of_right _ (Finset.sum_eq_zero fun γ _ => ?_)
      by_cases hγ : lam γ = 0
      · rw [hX γ hγ, zero_mul]
      · rw [hcyc, key0 δ hδ β γ hβ hγ, mul_zero]
  refine ⟨hbr, ?_, ?_⟩
  · apply le_antisymm
    · -- every eigenvector of a nonzero eigenvalue is a combination of brackets
      intro Z hZ
      have hZe := sk_expand b Z
      rw [hZe]
      refine Submodule.sum_mem _ fun δ _ => ?_
      by_cases hδ : lam δ = 0
      · rw [(memR Z).mp hZ δ hδ, zero_smul]; exact Submodule.zero_mem _
      · refine Submodule.smul_mem _ _ ?_
        set W : skewSub ι := ∑ β, ∑ γ, (lam β * lam γ * c β δ γ) • brS (ofSk (b γ)) (ofSk (b β)) with hW
        have hWmem : W ∈ Submodule.span ℝ {Z | ∃ X Y, X ∈ LinearMap.range (C : skewSub ι →ₗ[ℝ] skewSub ι) ∧
            Y ∈ LinearMap.range (C : skewSub ι →ₗ[ℝ] skewSub ι) ∧ Z = brS X Y} := by
          refine Submodule.sum_mem _ fun β _ => Submodule.sum_mem _ fun γ _ => ?_
          by_cases hβ : lam β = 0
          · rw [hβ, zero_mul, zero_mul, zero_smul]; exact Submodule.zero_mem _
          · by_cases hγ : lam γ = 0
            · rw [hγ, mul_zero, zero_mul, zero_smul]; exact Submodule.zero_mem _
            · exact Submodule.smul_mem _ _ (Submodule.subset_span ⟨_, _, memB γ hγ, memB β hβ, rfl⟩)
        have hWcoord : ∀ ε, inner ℝ (b ε) (toSk W) = 2 * lam δ * (if ε = δ then 1 else 0) := by
          intro ε
          have hoff := hid (ofSk (b ε)) (ofSk (b δ))
          rw [hCb, Submodule.coe_smul, i2_smul_l, ofSk_coe, ofSk_coe, ← FrameExtension.inner_def,
            orthonormal_iff_ite.mp b.orthonormal, sharpBil2_eigen b C lam hCb] at hoff
          rw [hW]
          simp only [toSk_finsum, toSk_smul', inner_sum, real_inner_smul_right, hcyc]
          have : lam ε * (if ε = δ then (1 : ℝ) else 0) = lam δ * (if ε = δ then 1 else 0) := by
            split_ifs with h
            · rw [h]
            · ring
          rw [this] at hoff
          have e : ∑ β, ∑ γ, lam β * lam γ * c β δ γ * c β ε γ
              = ∑ β, ∑ γ, lam β * lam γ * c β ε γ * c β δ γ :=
            Finset.sum_congr rfl fun β _ => Finset.sum_congr rfl fun γ _ => by ring
          simp only [hcdef] at hoff e ⊢
          linarith [hoff, e]
        have hWe : W = (2 * lam δ) • ofSk (b δ) := by
          rw [sk_expand b W]
          simp only [hWcoord, mul_ite, mul_one, mul_zero, ite_smul, zero_smul, Finset.sum_ite_eq', Finset.mem_univ,
            if_true]
        have : ofSk (b δ) = (2 * lam δ)⁻¹ • W := by
          rw [hWe, smul_smul, inv_mul_cancel₀ (by simpa using hδ), one_smul]
        rw [this]; exact Submodule.smul_mem _ _ hWmem
    · rw [Submodule.span_le]
      rintro Z ⟨X, Y, hX, hY, rfl⟩
      exact hbr X Y hX hY
  · intro X hX hX0
    rw [inner2_diag_two b C lam hCb]
    have hnn : ∀ δ, 0 ≤ lam δ * inner ℝ (b δ) (toSk X) * inner ℝ (b δ) (toSk X) := fun δ => by
      nlinarith [hlam0 δ, sq_nonneg (inner ℝ (b δ) (toSk X))]
    by_contra hle
    push_neg at hle
    have hz : ∑ δ, lam δ * inner ℝ (b δ) (toSk X) * inner ℝ (b δ) (toSk X) = 0 :=
      le_antisymm hle (Finset.sum_nonneg fun δ _ => hnn δ)
    apply hX0
    rw [sk_expand b X]
    refine Finset.sum_eq_zero fun δ _ => ?_
    by_cases hδ : lam δ = 0
    · rw [(memR X).mp hX δ hδ, zero_smul]
    · have h1 := (Finset.sum_eq_zero_iff_of_nonneg (fun δ _ => hnn δ)).mp hz δ (Finset.mem_univ δ)
      have h2 : inner ℝ (b δ) (toSk X) * inner ℝ (b δ) (toSk X) = 0 := by
        rw [mul_assoc] at h1; exact (mul_eq_zero.mp h1).resolve_left hδ
      rw [mul_self_eq_zero.mp h2, zero_smul]

/-- Equality in `x + y + z ≤ xy/z + yz/x + zx/y` forces `x = y = z`. -/
theorem three_ratio_eq {x y z : ℝ} (hx : 0 < x) (hy : 0 < y) (hz : 0 < z)
    (h : x * y / z + y * z / x + z * x / y = x + y + z) : x = y ∧ y = z := by
  have hxyz : 0 < x * y * z := by positivity
  have key : (x * y - y * z) ^ 2 + (y * z - z * x) ^ 2 + (z * x - x * y) ^ 2 = 0 := by
    field_simp at h
    nlinarith [h]
  have h1 : x * y - y * z = 0 := by nlinarith [sq_nonneg (x * y - y * z), sq_nonneg (y * z - z * x), sq_nonneg (z * x - x * y)]
  have h2 : y * z - z * x = 0 := by nlinarith [sq_nonneg (x * y - y * z), sq_nonneg (y * z - z * x), sq_nonneg (z * x - x * y)]
  have e1 : y * (x - z) = 0 := by linarith
  have e2 : z * (y - x) = 0 := by linarith
  have hxz := (mul_eq_zero.mp e1).resolve_left hy.ne'
  have hyx := (mul_eq_zero.mp e2).resolve_left hz.ne'
  constructor <;> linarith

/-- The equality case of `trace_le_of_pairing`: every triple carrying weight has equal `λ`. -/
theorem trace_eq_of_pairing {d : ℕ} (c : Fin d → Fin d → Fin d → ℝ) (lam : Fin d → ℝ) (γ D : ℝ)
    (hc : ∀ i j k, 0 ≤ c i j k) (hcyc : ∀ i j k, c i j k = c j k i)
    (hrow : ∀ k, ∑ i, ∑ j, c i j k = 2 * γ) (hlam : ∀ k, 0 < lam k)
    (hpair : D = (1 / 2) * ∑ i, ∑ j, ∑ k, c i j k * (lam i * lam j / lam k)) (heq : γ * ∑ k, lam k = D) :
    ∀ i j k, c i j k ≠ 0 → lam i = lam j ∧ lam j = lam k := by
  set g : Fin d → Fin d → Fin d → ℝ := fun i j k => c i j k * (lam i * lam j / lam k) with hg
  have e2 : ∑ i, ∑ j, ∑ k, c i j k * (lam j * lam k / lam i) = ∑ i, ∑ j, ∑ k, g i j k := by
    rw [← HamiltonsCubic.I117PsdReduction.cyc_sum g]
    refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun k _ => ?_
    simp only [hg]; rw [hcyc i j k]
  have e3 : ∑ i, ∑ j, ∑ k, c i j k * (lam k * lam i / lam j) = ∑ i, ∑ j, ∑ k, g i j k := by
    rw [← e2, ← HamiltonsCubic.I117PsdReduction.cyc_sum (fun i j k => c i j k * (lam j * lam k / lam i))]
    refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun k _ => ?_
    rw [hcyc i j k]
  have m1 : ∑ i, ∑ j, ∑ k, c i j k * lam i = 2 * γ * ∑ k, lam k := by
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun i _ => ?_
    have : ∑ j, ∑ k, c i j k = 2 * γ := by
      rw [← hrow i]
      exact Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun k _ => by rw [hcyc i j k]
    rw [← this, Finset.sum_mul]
    exact Finset.sum_congr rfl fun j _ => by rw [Finset.sum_mul]
  have m2 : ∑ i, ∑ j, ∑ k, c i j k * lam j = 2 * γ * ∑ k, lam k := by
    rw [← m1, ← HamiltonsCubic.I117PsdReduction.cyc_sum (fun i j k => c i j k * lam i)]
    exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun k _ => by
      rw [hcyc i j k]
  have m3 : ∑ i, ∑ j, ∑ k, c i j k * lam k = 2 * γ * ∑ k, lam k := by
    rw [← m2, ← HamiltonsCubic.I117PsdReduction.cyc_sum (fun i j k => c i j k * lam j)]
    exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun k _ => by
      rw [hcyc i j k]
  set t : Fin d → Fin d → Fin d → ℝ := fun i j k =>
    c i j k * ((lam i * lam j / lam k + lam j * lam k / lam i + lam k * lam i / lam j) - (lam i + lam j + lam k))
    with ht
  have htnn : ∀ i j k, 0 ≤ t i j k := fun i j k => by
    have h := HamiltonsCubic.I117PsdReduction.three_ratio (lam k) (lam i) (lam j) (hlam k) (hlam i) (hlam j)
    simp only [ht]
    apply mul_nonneg (hc i j k)
    have : lam k * lam i / lam j + lam i * lam j / lam k + lam j * lam k / lam i
        = lam i * lam j / lam k + lam j * lam k / lam i + lam k * lam i / lam j := by ring
    linarith
  have hsum : ∑ i, ∑ j, ∑ k, t i j k = 0 := by
    have e : ∑ i, ∑ j, ∑ k, t i j k
        = (∑ i, ∑ j, ∑ k, g i j k + ∑ i, ∑ j, ∑ k, c i j k * (lam j * lam k / lam i)
          + ∑ i, ∑ j, ∑ k, c i j k * (lam k * lam i / lam j))
          - (∑ i, ∑ j, ∑ k, c i j k * lam i + ∑ i, ∑ j, ∑ k, c i j k * lam j + ∑ i, ∑ j, ∑ k, c i j k * lam k) := by
      simp only [← Finset.sum_add_distrib, ← Finset.sum_sub_distrib]
      exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun k _ => by
        simp only [ht, hg]; ring
    rw [e, e2, e3, m1, m2, m3]
    have hD : ∑ i, ∑ j, ∑ k, g i j k = 2 * D := by rw [hpair]; simp only [hg]; ring
    rw [hD, ← heq]; ring
  intro i j k hck
  have h1 := (Finset.sum_eq_zero_iff_of_nonneg (fun i _ => Finset.sum_nonneg fun j _ => Finset.sum_nonneg
    fun k _ => htnn i j k)).mp hsum i (Finset.mem_univ i)
  have h2 := (Finset.sum_eq_zero_iff_of_nonneg (fun j _ => Finset.sum_nonneg fun k _ => htnn i j k)).mp h1 j
    (Finset.mem_univ j)
  have h3 := (Finset.sum_eq_zero_iff_of_nonneg (fun k _ => htnn i j k)).mp h2 k (Finset.mem_univ k)
  simp only [ht] at h3
  have h4 := (mul_eq_zero.mp h3).resolve_left hck
  have h5 : lam k * lam i / lam j + lam i * lam j / lam k + lam j * lam k / lam i = lam k + lam i + lam j := by
    have : lam k * lam i / lam j + lam i * lam j / lam k + lam j * lam k / lam i
        = lam i * lam j / lam k + lam j * lam k / lam i + lam k * lam i / lam j := by ring
    linarith
  obtain ⟨hki, hij⟩ := three_ratio_eq (hlam k) (hlam i) (hlam j) h5
  exact ⟨hij, by linarith⟩

/-- **The Casimir row sum**: `∑_{β,γ} ⟨b_β, [b_δ, b_γ]⟩² = 2(n - 2)` over an orthonormal basis of `𝔰𝔬(n)`. -/
theorem casimir_row {N : ℕ} (b : OrthonormalBasis (Fin N) ℝ (FrameExtension.SkewSp ι)) (δ : Fin N) :
    ∑ β, ∑ γ, inner ℝ (b β) (toSk (brS (ofSk (b δ)) (ofSk (b γ)))) ^ 2 = 2 * ((Fintype.card ι : ℝ) - 2) := by
  rw [Finset.sum_comm]
  have hpar : ∀ γ, ∑ β, inner ℝ (b β) (toSk (brS (ofSk (b δ)) (ofSk (b γ)))) ^ 2
      = inner2 ((brS (ofSk (b δ)) (ofSk (b γ)) : skewSub ι) : Matrix ι ι ℝ)
          ((brS (ofSk (b δ)) (ofSk (b γ)) : skewSub ι) : Matrix ι ι ℝ) := fun γ => by
    rw [← inner_toSk, ← b.sum_inner_mul_inner]
    exact Finset.sum_congr rfl fun β _ => by rw [real_inner_comm (toSk _) (b β)]; ring
  simp only [hpar]
  let f : skewSub ι →ₗ[ℝ] skewSub ι →ₗ[ℝ] ℝ := LinearMap.mk₂ ℝ
    (fun W W' => inner2 ((brS (ofSk (b δ)) (brS (ofSk (b δ)) W) : skewSub ι) : Matrix ι ι ℝ) (W' : Matrix ι ι ℝ))
    (fun W₁ W₂ W' => by simp only [brS_add_right, Submodule.coe_add, i2_add_l])
    (fun c W W' => by simp only [brS_smul_right, Submodule.coe_smul, i2_smul_l, smul_eq_mul])
    (fun W W₁' W₂' => by simp only [Submodule.coe_add, i2_add_r])
    (fun c W W' => by simp only [Submodule.coe_smul, i2_smul_r, smul_eq_mul])
  have hch := phi_sum_change b f
  have hkill : ∑ i, ∑ j, f ⟨phi i j, phi_mem_skewSub i j⟩ ⟨phi i j, phi_mem_skewSub i j⟩
      = 2 * ((Fintype.card ι : ℝ) - 2) * (FrameExtension.toM (b δ) * FrameExtension.toM (b δ)).trace :=
    sum_inner2_ad2 _ _ (FrameExtension.toM_skew (b δ)) (FrameExtension.toM_skew (b δ))
  have hsk : ∀ γ, f (ofSk (b γ)) (ofSk (b γ))
      = -inner2 ((brS (ofSk (b δ)) (ofSk (b γ)) : skewSub ι) : Matrix ι ι ℝ)
          ((brS (ofSk (b δ)) (ofSk (b γ)) : skewSub ι) : Matrix ι ι ℝ) := fun γ => by
    show inner2 (br (FrameExtension.toM (b δ)) ((brS (ofSk (b δ)) (ofSk (b γ)) : skewSub ι) : Matrix ι ι ℝ))
      (FrameExtension.toM (b γ)) = _
    rw [HamiltonsCubic.L33Statement.ad_skewAdjoint (brS (ofSk (b δ)) (ofSk (b γ))).2 (FrameExtension.toM_skew (b δ))
      (FrameExtension.toM_skew (b γ))]
    rfl
  have htr : (FrameExtension.toM (b δ) * FrameExtension.toM (b δ)).trace = -2 := by
    have hs : (FrameExtension.toM (b δ))ᵀ = -FrameExtension.toM (b δ) := FrameExtension.toM_skew (b δ)
    have hn : inner2 (FrameExtension.toM (b δ)) (FrameExtension.toM (b δ)) = 1 := by
      rw [← FrameExtension.inner_def, real_inner_self_eq_norm_sq, b.orthonormal.1 δ]; norm_num
    unfold inner2 at hn
    rw [hs, Matrix.neg_mul, Matrix.trace_neg] at hn
    linarith
  rw [hkill, htr] at hch
  simp only [hsk, Finset.sum_neg_distrib] at hch
  linarith

/-- **L260 (4) at a positive definite idempotent of `𝔰𝔬(n)` itself**: `(n - 2) tr C ≤ N`, with equality exactly at
`I/(n - 2)`. -/
theorem L260_trace_bound (hn : 3 ≤ Fintype.card ι) (C : CurvOp2 ι) (hC : IsSelfAdjoint2 C) (hpd : IsPD2 C)
    (hidem : IsIdem C) :
    ((Fintype.card ι : ℝ) - 2) * innerOp2 C idOp ≤ normSq2 (idOp : CurvOp2 ι) ∧
      (((Fintype.card ι : ℝ) - 2) * innerOp2 C idOp = normSq2 (idOp : CurvOp2 ι) →
        C = (1 / ((Fintype.card ι : ℝ) - 2)) • idOp) := by
  have hs := opSk_symm hC
  let b := hs.eigenvectorBasis (n := Module.finrank ℝ (FrameExtension.SkewSp ι)) rfl
  let lam := hs.eigenvalues (n := Module.finrank ℝ (FrameExtension.SkewSp ι)) rfl
  have hCb : ∀ β, C (ofSk (b β)) = lam β • ofSk (b β) := fun β => by
    have h := hs.apply_eigenvectorBasis (n := Module.finrank ℝ (FrameExtension.SkewSp ι)) rfl β
    have h2 : C (ofSk (b β)) = ofSk (opSk C (b β)) := rfl
    rw [h2, h, ofSk_smul]; rfl
  have hunit : ∀ β, inner2 (FrameExtension.toM (b β)) (FrameExtension.toM (b β)) = 1 := fun β => by
    rw [← FrameExtension.inner_def, real_inner_self_eq_norm_sq, b.orthonormal.1 β]; norm_num
  have hlam : ∀ β, 0 < lam β := fun β => by
    have hne : ofSk (b β) ≠ 0 := fun h => by
      have := congrArg (fun Z : skewSub ι => inner2 (Z : Matrix ι ι ℝ) (Z : Matrix ι ι ℝ)) h
      simp only [ofSk_coe, hunit] at this
      simp [inner2] at this
    have := hpd _ hne
    rw [hCb, Submodule.coe_smul, i2_smul_l, ofSk_coe, hunit, mul_one] at this; exact this
  have hid : ∀ X Y : skewSub ι, inner2 ((C X : skewSub ι) : Matrix ι ι ℝ) (Y : Matrix ι ι ℝ) = sharpBil2 C X Y := by
    intro X Y
    have : C X = sharpMapCL C X := by rw [hidem]
    rw [this, sharpMapCL_apply, inner2_sharpMap]
  set w : Fin _ → Fin _ → Fin _ → ℝ := fun i j k => inner ℝ (b i) (toSk (brS (ofSk (b k)) (ofSk (b j)))) ^ 2
    with hw
  -- the cyclic symmetry of the bracket coefficients
  have hcyc0 : ∀ β δ γ, inner ℝ (b δ) (toSk (brS (ofSk (b β)) (ofSk (b γ))))
      = inner ℝ (b γ) (toSk (brS (ofSk (b δ)) (ofSk (b β)))) := by
    intro β δ γ
    show inner2 (FrameExtension.toM (b δ)) (br (FrameExtension.toM (b β)) (FrameExtension.toM (b γ)))
      = inner2 (FrameExtension.toM (b γ)) (br (FrameExtension.toM (b δ)) (FrameExtension.toM (b β)))
    have adj := HamiltonsCubic.L33Statement.ad_skewAdjoint (FrameExtension.toM_skew (b γ))
      (FrameExtension.toM_skew (b β)) (FrameExtension.toM_skew (b δ))
    rw [inner2_comm, adj]
    have e : br (FrameExtension.toM (b β)) (FrameExtension.toM (b δ))
        = -br (FrameExtension.toM (b δ)) (FrameExtension.toM (b β)) := by simp [br]
    rw [e]; unfold inner2; rw [Matrix.mul_neg, Matrix.trace_neg]; ring
  have hwcyc : ∀ i j k, w i j k = w j k i := fun i j k => by simp only [hw]; rw [hcyc0 k i j]
  have hrow : ∀ k, ∑ i, ∑ j, w i j k = 2 * ((Fintype.card ι : ℝ) - 2) := fun k => casimir_row b k
  -- the diagonal of `C # C = C`, divided by `λ`
  have hdiag : ∀ k, lam k = (1 / 2) * ∑ i, ∑ j, w i j k * (lam i * lam j) := by
    intro k
    have h := hid (ofSk (b k)) (ofSk (b k))
    rw [hCb, Submodule.coe_smul, i2_smul_l, ofSk_coe, hunit, mul_one, sharpBil2_eigen b C lam hCb] at h
    rw [h]; congr 1
    exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by simp only [hw]; ring
  have htrC : innerOp2 C idOp = ∑ k, lam k := by
    let f : skewSub ι →ₗ[ℝ] skewSub ι →ₗ[ℝ] ℝ := LinearMap.mk₂ ℝ
      (fun X X' => inner2 ((C X : skewSub ι) : Matrix ι ι ℝ) (X' : Matrix ι ι ℝ))
      (fun X₁ X₂ X' => by simp only [map_add, Submodule.coe_add, i2_add_l])
      (fun c X X' => by simp only [map_smul, Submodule.coe_smul, i2_smul_l, smul_eq_mul])
      (fun X X₁' X₂' => by simp only [Submodule.coe_add, i2_add_r])
      (fun c X X' => by simp only [Submodule.coe_smul, i2_smul_r, smul_eq_mul])
    have h := phi_sum_change b f
    show (1 / 2) * ∑ i, ∑ j, inner2 (applyPhi C i j) (applyPhi idOp i j) = _
    have e : ∑ i, ∑ j, inner2 (applyPhi C i j) (applyPhi idOp i j)
        = ∑ i, ∑ j, f ⟨phi i j, phi_mem_skewSub i j⟩ ⟨phi i j, phi_mem_skewSub i j⟩ := rfl
    rw [e, h]
    have hb : ∀ β, f (ofSk (b β)) (ofSk (b β)) = lam β := fun β => by
      show inner2 ((C (ofSk (b β)) : skewSub ι) : Matrix ι ι ℝ) (FrameExtension.toM (b β)) = _
      rw [hCb, Submodule.coe_smul, i2_smul_l, ofSk_coe, hunit, mul_one]
    simp only [hb]; ring
  have hN : normSq2 (idOp : CurvOp2 ι) = (Module.finrank ℝ (FrameExtension.SkewSp ι) : ℝ) := by
    rw [normSq2_eigen b idOp (fun _ => 1) (fun β => by simp)]
    simp
  set D := (Module.finrank ℝ (FrameExtension.SkewSp ι) : ℝ) with hD
  have hpair : D = (1 / 2) * ∑ i, ∑ j, ∑ k, w i j k * (lam i * lam j / lam k) := by
    have h1 : D = ∑ _k : Fin (Module.finrank ℝ (FrameExtension.SkewSp ι)), (1 : ℝ) := by simp [hD]
    have h2 : ∀ k, (1 : ℝ) = (1 / 2) * ∑ i, ∑ j, w i j k * (lam i * lam j / lam k) := fun k => by
      have := hdiag k
      have hk := (hlam k).ne'
      have e : ∑ i, ∑ j, w i j k * (lam i * lam j / lam k) = (∑ i, ∑ j, w i j k * (lam i * lam j)) / lam k := by
        rw [Finset.sum_div]
        exact Finset.sum_congr rfl fun i _ => by rw [Finset.sum_div]; exact Finset.sum_congr rfl fun j _ => by ring
      have hS : ∑ i, ∑ j, w i j k * (lam i * lam j) = 2 * lam k := by linarith [this]
      rw [e, hS, mul_div_assoc, div_self hk]; norm_num
    rw [h1, Finset.sum_congr rfl fun k _ => h2 k, ← Finset.mul_sum]
    congr 1
    rw [Finset.sum_comm, Finset.sum_congr rfl fun i _ => Finset.sum_comm]
  have hle := HamiltonsCubic.I117PsdReduction.trace_le_of_pairing w lam ((Fintype.card ι : ℝ) - 2) D
    (fun i j k => sq_nonneg _) hwcyc hrow hlam hpair
  rw [htrC, hN]
  refine ⟨hle, fun heq => ?_⟩
  have hn' : (3 : ℝ) ≤ Fintype.card ι := by exact_mod_cast hn
  have hc2 : (0 : ℝ) < (Fintype.card ι : ℝ) - 2 := by linarith
  have hall := trace_eq_of_pairing w lam ((Fintype.card ι : ℝ) - 2) D (fun i j k => sq_nonneg _) hwcyc hrow hlam
    hpair heq
  -- every eigenvalue is `1/(n - 2)`
  have hval : ∀ k, lam k = 1 / ((Fintype.card ι : ℝ) - 2) := by
    intro k
    have hd := hdiag k
    have e : ∑ i, ∑ j, w i j k * (lam i * lam j) = lam k ^ 2 * ∑ i, ∑ j, w i j k := by
      rw [Finset.mul_sum]
      refine Finset.sum_congr rfl fun i _ => ?_
      rw [Finset.mul_sum]
      refine Finset.sum_congr rfl fun j _ => ?_
      by_cases hz : w i j k = 0
      · rw [hz]; ring
      · obtain ⟨h1, h2⟩ := hall i j k hz
        rw [h1, h2]; ring
    rw [e, hrow k] at hd
    have hk := (hlam k).ne'
    field_simp
    have : lam k * (1 - lam k * ((Fintype.card ι : ℝ) - 2)) = 0 := by nlinarith [hd]
    rcases mul_eq_zero.mp this with h | h
    · exact absurd h hk
    · linarith
  refine ContinuousLinearMap.ext fun X => ?_
  conv_lhs => rw [sk_expand b X]
  rw [map_sum]
  simp only [map_smul, hCb, hval, smul_smul]
  conv_rhs => rw [sk_expand b X]
  rw [ContinuousLinearMap.smul_apply, ContinuousLinearMap.id_apply, Finset.smul_sum]
  exact Finset.sum_congr rfl fun δ _ => by rw [smul_smul, mul_comm]

/-- **L265, positivity**: for positive semidefinite `C`, `C # ·` maps positive semidefinite operators to positive
semidefinite operators. *Proved: each crossed term of `C # X` is `-μ⟨A[Y, e], [Y, e]⟩` in the eigenframe of the other
operator.* The record's complete positivity is the stronger statement and is not typed here. -/
theorem L265_cp (C X : CurvOp2 ι) (hC : IsSelfAdjoint2 C) (hCp : IsPSD2 C) (hX : IsSelfAdjoint2 X)
    (hXp : IsPSD2 X) : IsPSD2 (sharpB C X) := by
  intro Y
  -- the two crossed terms, as bilinear forms in the `φ` slots
  let K : CurvOp2 ι → CurvOp2 ι → skewSub ι →ₗ[ℝ] skewSub ι →ₗ[ℝ] ℝ := fun A B => LinearMap.mk₂ ℝ
    (fun W W' => inner2 ((brS Y (A (brS Y (B W))) : skewSub ι) : Matrix ι ι ℝ) (W' : Matrix ι ι ℝ))
    (fun W₁ W₂ W' => by simp only [map_add, brS_add_right, Submodule.coe_add, i2_add_l])
    (fun c W W' => by simp only [map_smul, brS_smul_right, Submodule.coe_smul, i2_smul_l, smul_eq_mul])
    (fun W W₁' W₂' => by simp only [Submodule.coe_add, i2_add_r])
    (fun c W W' => by simp only [Submodule.coe_smul, i2_smul_r, smul_eq_mul])
  have hsh : ∀ R : CurvOp2 ι, inner2 ((sharpMapCL R Y : skewSub ι) : Matrix ι ι ℝ) (Y : Matrix ι ι ℝ)
      = -(1 / 4) * ∑ i, ∑ j, K R R ⟨phi i j, phi_mem_skewSub i j⟩ ⟨phi i j, phi_mem_skewSub i j⟩ := fun R => by
    rw [sharpMapCL_apply, inner2_sharpMap, sharpBil2_eq_crossPair2]; rfl
  have hsplit : ∀ W W', K (C + X) (C + X) W W' = K C C W W' + K C X W W' + K X C W W' + K X X W W' := by
    intro W W'
    show inner2 ((brS Y ((C + X) (brS Y ((C + X) W))) : skewSub ι) : Matrix ι ι ℝ) (W' : Matrix ι ι ℝ) = _
    simp only [ContinuousLinearMap.add_apply, brS_add_right, map_add, Submodule.coe_add, i2_add_l]
    show _ = inner2 ((brS Y (C (brS Y (C W))) : skewSub ι) : Matrix ι ι ℝ) (W' : Matrix ι ι ℝ)
      + inner2 ((brS Y (C (brS Y (X W))) : skewSub ι) : Matrix ι ι ℝ) (W' : Matrix ι ι ℝ)
      + inner2 ((brS Y (X (brS Y (C W))) : skewSub ι) : Matrix ι ι ℝ) (W' : Matrix ι ι ℝ)
      + inner2 ((brS Y (X (brS Y (X W))) : skewSub ι) : Matrix ι ι ℝ) (W' : Matrix ι ι ℝ)
    ring
  have hval : inner2 ((sharpB C X Y : skewSub ι) : Matrix ι ι ℝ) (Y : Matrix ι ι ℝ)
      = -(1 / 8) * (∑ i, ∑ j, K C X ⟨phi i j, phi_mem_skewSub i j⟩ ⟨phi i j, phi_mem_skewSub i j⟩
        + ∑ i, ∑ j, K X C ⟨phi i j, phi_mem_skewSub i j⟩ ⟨phi i j, phi_mem_skewSub i j⟩) := by
    have e : ((sharpB C X Y : skewSub ι) : Matrix ι ι ℝ) = (1 / 2 : ℝ) • (((sharpMapCL (C + X) Y : skewSub ι) : Matrix ι ι ℝ)
        - ((sharpMapCL C Y : skewSub ι) : Matrix ι ι ℝ) - ((sharpMapCL X Y : skewSub ι) : Matrix ι ι ℝ)) := rfl
    rw [e, i2_smul_l]
    have hsub : ∀ A B Z : Matrix ι ι ℝ, inner2 (A - B) Z = inner2 A Z - inner2 B Z := fun A B Z => by
      unfold inner2; rw [Matrix.transpose_sub, Matrix.sub_mul, Matrix.trace_sub]; ring
    rw [hsub, hsub, hsh, hsh, hsh]
    simp only [hsplit, Finset.sum_add_distrib]
    ring
  -- each crossed sum is non-positive, read in the eigenframe of its inner operator
  have hneg : ∀ A B : CurvOp2 ι, IsPSD2 A → IsSelfAdjoint2 B → IsPSD2 B →
      ∑ i, ∑ j, K A B ⟨phi i j, phi_mem_skewSub i j⟩ ⟨phi i j, phi_mem_skewSub i j⟩ ≤ 0 := by
    intro A B hAp hB hBp
    have hs := opSk_symm hB
    let e := hs.eigenvectorBasis (n := Module.finrank ℝ (FrameExtension.SkewSp ι)) rfl
    let mu := hs.eigenvalues (n := Module.finrank ℝ (FrameExtension.SkewSp ι)) rfl
    have hBe : ∀ β, B (ofSk (e β)) = mu β • ofSk (e β) := fun β => by
      have h := hs.apply_eigenvectorBasis (n := Module.finrank ℝ (FrameExtension.SkewSp ι)) rfl β
      have h2 : B (ofSk (e β)) = ofSk (opSk B (e β)) := rfl
      rw [h2, h, ofSk_smul]; rfl
    have hunit : ∀ β, inner2 (FrameExtension.toM (e β)) (FrameExtension.toM (e β)) = 1 := fun β => by
      rw [← FrameExtension.inner_def, real_inner_self_eq_norm_sq, e.orthonormal.1 β]; norm_num
    have hmu : ∀ β, 0 ≤ mu β := fun β => by
      have := hBp (ofSk (e β))
      rw [hBe, Submodule.coe_smul, i2_smul_l, ofSk_coe, hunit, mul_one] at this; exact this
    rw [phi_sum_change e (K A B)]
    have hterm : ∀ β, K A B (ofSk (e β)) (ofSk (e β))
        = -(mu β * inner2 ((A (brS Y (ofSk (e β))) : skewSub ι) : Matrix ι ι ℝ)
            ((brS Y (ofSk (e β)) : skewSub ι) : Matrix ι ι ℝ)) := fun β => by
      show inner2 ((brS Y (A (brS Y (B (ofSk (e β))))) : skewSub ι) : Matrix ι ι ℝ) (FrameExtension.toM (e β)) = _
      rw [hBe, brS_smul_right, map_smul, brS_smul_right, Submodule.coe_smul, i2_smul_l]
      have adj := HamiltonsCubic.L33Statement.ad_skewAdjoint (A (brS Y (ofSk (e β)))).2 Y.2 (ofSk (e β)).2
      have e1 : ((brS Y (A (brS Y (ofSk (e β)))) : skewSub ι) : Matrix ι ι ℝ)
          = br (Y : Matrix ι ι ℝ) ((A (brS Y (ofSk (e β))) : skewSub ι) : Matrix ι ι ℝ) := rfl
      rw [e1, ← ofSk_coe, adj]
      have e2 : br (Y : Matrix ι ι ℝ) ((ofSk (e β) : skewSub ι) : Matrix ι ι ℝ)
          = ((brS Y (ofSk (e β)) : skewSub ι) : Matrix ι ι ℝ) := rfl
      rw [e2]; ring
    simp only [hterm]
    have : ∑ β, -(mu β * inner2 ((A (brS Y (ofSk (e β))) : skewSub ι) : Matrix ι ι ℝ)
        ((brS Y (ofSk (e β)) : skewSub ι) : Matrix ι ι ℝ)) ≤ 0 := by
      rw [Finset.sum_neg_distrib, neg_nonpos]
      exact Finset.sum_nonneg fun β _ => mul_nonneg (hmu β) (hAp _)
    linarith
  rw [hval]
  have h1 := hneg C X hCp hX hXp
  have h2 := hneg X C hXp hC hCp
  nlinarith

/-! ## The adjoint action: Jacobi, invariance of basis sums, and infinitesimal invariance of `Φ` -/

theorem brS_jacobi (X Y Z : skewSub ι) : brS X (brS Y Z) = brS (brS X Y) Z + brS Y (brS X Z) := by
  apply Subtype.ext
  rw [Submodule.coe_add]
  show br (X : Matrix ι ι ℝ) (br (Y : Matrix ι ι ℝ) (Z : Matrix ι ι ℝ))
    = br (br (X : Matrix ι ι ℝ) (Y : Matrix ι ι ℝ)) (Z : Matrix ι ι ℝ)
      + br (Y : Matrix ι ι ℝ) (br (X : Matrix ι ι ℝ) (Z : Matrix ι ι ℝ))
  unfold br; noncomm_ring

theorem inner2_brS_skew (X Y Z : skewSub ι) :
    inner2 ((brS X Y : skewSub ι) : Matrix ι ι ℝ) (Z : Matrix ι ι ℝ)
      = -inner2 (Y : Matrix ι ι ℝ) ((brS X Z : skewSub ι) : Matrix ι ι ℝ) :=
  HamiltonsCubic.L33Statement.ad_skewAdjoint Y.2 X.2 Z.2

/-- The derivation `R ↦ [ad_X, R]`. -/
noncomputable def derOp (X : skewSub ι) (R : CurvOp2 ι) : CurvOp2 ι := (adS X).comp R - R.comp (adS X)

theorem derOp_apply (X : skewSub ι) (R : CurvOp2 ι) (Y : skewSub ι) :
    derOp X R Y = brS X (R Y) - R (brS X Y) := rfl

/-- **`ad_X` is skew over an orthonormal basis**: `∑ f(ad_X b, b) = -∑ f(b, ad_X b)` for every bilinear `f`. -/
theorem onb_ad_skew {N : ℕ} (b : OrthonormalBasis (Fin N) ℝ (FrameExtension.SkewSp ι)) (X : skewSub ι)
    (f : skewSub ι →ₗ[ℝ] skewSub ι →ₗ[ℝ] ℝ) :
    ∑ β, f (brS X (ofSk (b β))) (ofSk (b β)) = -∑ β, f (ofSk (b β)) (brS X (ofSk (b β))) := by
  set a : Fin N → Fin N → ℝ := fun γ β => inner ℝ (b γ) (toSk (brS X (ofSk (b β)))) with ha
  have hanti : ∀ γ β, a γ β = -a β γ := fun γ β => by
    simp only [ha, FrameExtension.inner_def, toM_toSk]
    rw [inner2_comm, ← ofSk_coe, inner2_brS_skew, ofSk_coe]
  have hL : ∀ β, f (brS X (ofSk (b β))) (ofSk (b β)) = ∑ γ, a γ β * f (ofSk (b γ)) (ofSk (b β)) := fun β => by
    conv_lhs => rw [sk_expand b (brS X (ofSk (b β)))]
    simp only [map_sum, map_smul, LinearMap.sum_apply, LinearMap.smul_apply, smul_eq_mul, ha]
  have hR : ∀ β, f (ofSk (b β)) (brS X (ofSk (b β))) = ∑ γ, a γ β * f (ofSk (b β)) (ofSk (b γ)) := fun β => by
    conv_lhs => rw [sk_expand b (brS X (ofSk (b β)))]
    simp only [map_sum, map_smul, smul_eq_mul, ha]
  simp only [hL, hR]
  rw [Finset.sum_comm, ← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun γ _ => ?_
  rw [← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun β _ => ?_
  rw [hanti]; ring

/-- `Φ` over an orthonormal basis: `Φ(A; B, C) = -∑_{β,γ} ⟨B[A b_β, C b_γ], [b_β, b_γ]⟩`. -/
theorem phiTri_onb {N : ℕ} (b : OrthonormalBasis (Fin N) ℝ (FrameExtension.SkewSp ι)) (A B C : CurvOp2 ι) :
    phiTri A B C = -∑ β, ∑ γ, inner2 ((B (brS (A (ofSk (b β))) (C (ofSk (b γ)))) : skewSub ι) : Matrix ι ι ℝ)
      ((brS (ofSk (b β)) (ofSk (b γ)) : skewSub ι) : Matrix ι ι ℝ) := by
  let H : skewSub ι → skewSub ι →ₗ[ℝ] skewSub ι →ₗ[ℝ] ℝ := fun W => LinearMap.mk₂ ℝ
    (fun Y Y' => inner2 ((B (brS (A W) (C Y)) : skewSub ι) : Matrix ι ι ℝ) ((brS W Y' : skewSub ι) : Matrix ι ι ℝ))
    (fun Y₁ Y₂ Y' => by simp only [map_add, brS_add_right, Submodule.coe_add, i2_add_l])
    (fun c Y Y' => by simp only [map_smul, brS_smul_right, Submodule.coe_smul, i2_smul_l, smul_eq_mul])
    (fun Y Y₁' Y₂' => by simp only [brS_add_right, Submodule.coe_add, i2_add_r])
    (fun c Y Y' => by simp only [brS_smul_right, Submodule.coe_smul, i2_smul_r, smul_eq_mul])
  let G : skewSub ι →ₗ[ℝ] skewSub ι →ₗ[ℝ] ℝ := LinearMap.mk₂ ℝ
    (fun W W' => ∑ k, ∑ l, inner2 ((B (brS (A W) (C ⟨phi k l, phi_mem_skewSub k l⟩)) : skewSub ι) : Matrix ι ι ℝ)
      ((brS W' ⟨phi k l, phi_mem_skewSub k l⟩ : skewSub ι) : Matrix ι ι ℝ))
    (fun W₁ W₂ W' => by simp only [map_add, brS_add_left, Submodule.coe_add, i2_add_l, Finset.sum_add_distrib])
    (fun c W W' => by simp only [map_smul, brS_smul_left, Submodule.coe_smul, i2_smul_l, smul_eq_mul, Finset.mul_sum])
    (fun W W₁' W₂' => by simp only [brS_add_left, Submodule.coe_add, i2_add_r, Finset.sum_add_distrib])
    (fun c W W' => by simp only [brS_smul_left, Submodule.coe_smul, i2_smul_r, smul_eq_mul, Finset.mul_sum])
  have hphi : phiTri A B C = -(1 / 4) * ∑ i, ∑ j, G ⟨phi i j, phi_mem_skewSub i j⟩ ⟨phi i j, phi_mem_skewSub i j⟩ := rfl
  have hG : ∀ β, G (ofSk (b β)) (ofSk (b β)) = 2 * ∑ γ, H (ofSk (b β)) (ofSk (b γ)) (ofSk (b γ)) := fun β => by
    rw [← phi_sum_change b (H (ofSk (b β)))]; rfl
  rw [hphi, phi_sum_change b G]
  simp only [hG, Finset.mul_sum]
  rw [← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun β _ => ?_
  rw [← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun γ _ => ?_
  show -(1 / 4) * (2 * (2 * inner2 _ _)) = _
  ring

theorem brS_sub_left (P Q R : skewSub ι) : brS (P - Q) R = brS P R - brS Q R := by
  apply Subtype.ext; rw [Submodule.coe_sub]
  show br ((P : Matrix ι ι ℝ) - (Q : Matrix ι ι ℝ)) (R : Matrix ι ι ℝ) = br (P : Matrix ι ι ℝ) R - br (Q : Matrix ι ι ℝ) R
  unfold br; noncomm_ring

theorem brS_sub_right (P Q R : skewSub ι) : brS P (Q - R) = brS P Q - brS P R := by
  apply Subtype.ext; rw [Submodule.coe_sub]
  show br (P : Matrix ι ι ℝ) ((Q : Matrix ι ι ℝ) - (R : Matrix ι ι ℝ)) = br (P : Matrix ι ι ℝ) Q - br (P : Matrix ι ι ℝ) R
  unfold br; noncomm_ring

theorem i2_sub_l (A B Y : Matrix ι ι ℝ) : inner2 (A - B) Y = inner2 A Y - inner2 B Y := by
  unfold inner2; rw [Matrix.transpose_sub, Matrix.sub_mul, Matrix.trace_sub]; ring

theorem i2_sub_r' (X A B : Matrix ι ι ℝ) : inner2 X (A - B) = inner2 X A - inner2 X B := by
  unfold inner2; rw [Matrix.mul_sub, Matrix.trace_sub]; ring

/-- **Infinitesimal invariance of `Φ` under the adjoint action.** -/
theorem phiTri_der (X : skewSub ι) (A B C : CurvOp2 ι) :
    phiTri (derOp X A) B C + phiTri A (derOp X B) C + phiTri A B (derOp X C) = 0 := by
  let b := stdOrthonormalBasis ℝ (FrameExtension.SkewSp ι)
  simp only [phiTri_onb b]
  set e : Fin _ → skewSub ι := fun β => ofSk (b β) with he
  have hpt : ∀ β γ,
      inner2 ((B (brS (derOp X A (e β)) (C (e γ))) : skewSub ι) : Matrix ι ι ℝ) ((brS (e β) (e γ) : skewSub ι) : Matrix ι ι ℝ)
      + inner2 ((derOp X B (brS (A (e β)) (C (e γ))) : skewSub ι) : Matrix ι ι ℝ) ((brS (e β) (e γ) : skewSub ι) : Matrix ι ι ℝ)
      + inner2 ((B (brS (A (e β)) (derOp X C (e γ))) : skewSub ι) : Matrix ι ι ℝ) ((brS (e β) (e γ) : skewSub ι) : Matrix ι ι ℝ)
      = -(inner2 ((B (brS (A (brS X (e β))) (C (e γ)))) : Matrix ι ι ℝ) ((brS (e β) (e γ) : skewSub ι) : Matrix ι ι ℝ)
          + inner2 ((B (brS (A (e β)) (C (e γ))) : skewSub ι) : Matrix ι ι ℝ) ((brS (brS X (e β)) (e γ) : skewSub ι) : Matrix ι ι ℝ))
        - (inner2 ((B (brS (A (e β)) (C (brS X (e γ))))) : Matrix ι ι ℝ) ((brS (e β) (e γ) : skewSub ι) : Matrix ι ι ℝ)
          + inner2 ((B (brS (A (e β)) (C (e γ))) : skewSub ι) : Matrix ι ι ℝ) ((brS (e β) (brS X (e γ)) : skewSub ι) : Matrix ι ι ℝ)) := by
    intro β γ
    simp only [derOp_apply, brS_sub_left, brS_sub_right, map_sub, Submodule.coe_sub, i2_sub_l]
    rw [brS_jacobi X (A (e β)) (C (e γ)), map_add, Submodule.coe_add, i2_add_l,
      inner2_brS_skew X (B (brS (A (e β)) (C (e γ)))) (brS (e β) (e γ)), brS_jacobi X (e β) (e γ), Submodule.coe_add,
      i2_add_r]
    ring
  have hP : ∀ γ, ∑ β, (inner2 ((B (brS (A (brS X (e β))) (C (e γ)))) : Matrix ι ι ℝ) ((brS (e β) (e γ) : skewSub ι) : Matrix ι ι ℝ)
      + inner2 ((B (brS (A (e β)) (C (e γ))) : skewSub ι) : Matrix ι ι ℝ) ((brS (brS X (e β)) (e γ) : skewSub ι) : Matrix ι ι ℝ)) = 0 := by
    intro γ
    let f : skewSub ι →ₗ[ℝ] skewSub ι →ₗ[ℝ] ℝ := LinearMap.mk₂ ℝ
      (fun W W' => inner2 ((B (brS (A W) (C (e γ))) : skewSub ι) : Matrix ι ι ℝ) ((brS W' (e γ) : skewSub ι) : Matrix ι ι ℝ))
      (fun W₁ W₂ W' => by simp only [map_add, brS_add_left, Submodule.coe_add, i2_add_l])
      (fun c W W' => by simp only [map_smul, brS_smul_left, Submodule.coe_smul, i2_smul_l, smul_eq_mul])
      (fun W W₁' W₂' => by simp only [brS_add_left, Submodule.coe_add, i2_add_r])
      (fun c W W' => by simp only [brS_smul_left, Submodule.coe_smul, i2_smul_r, smul_eq_mul])
    have h := onb_ad_skew b X f
    rw [Finset.sum_add_distrib]
    change ∑ β, f (brS X (e β)) (e β) + ∑ β, f (e β) (brS X (e β)) = 0
    linarith
  have hQ : ∀ β, ∑ γ, (inner2 ((B (brS (A (e β)) (C (brS X (e γ))))) : Matrix ι ι ℝ) ((brS (e β) (e γ) : skewSub ι) : Matrix ι ι ℝ)
      + inner2 ((B (brS (A (e β)) (C (e γ))) : skewSub ι) : Matrix ι ι ℝ) ((brS (e β) (brS X (e γ)) : skewSub ι) : Matrix ι ι ℝ)) = 0 := by
    intro β
    let g : skewSub ι →ₗ[ℝ] skewSub ι →ₗ[ℝ] ℝ := LinearMap.mk₂ ℝ
      (fun W W' => inner2 ((B (brS (A (e β)) (C W)) : skewSub ι) : Matrix ι ι ℝ) ((brS (e β) W' : skewSub ι) : Matrix ι ι ℝ))
      (fun W₁ W₂ W' => by simp only [map_add, brS_add_right, Submodule.coe_add, i2_add_l])
      (fun c W W' => by simp only [map_smul, brS_smul_right, Submodule.coe_smul, i2_smul_l, smul_eq_mul])
      (fun W W₁' W₂' => by simp only [brS_add_right, Submodule.coe_add, i2_add_r])
      (fun c W W' => by simp only [brS_smul_right, Submodule.coe_smul, i2_smul_r, smul_eq_mul])
    have h := onb_ad_skew b X g
    rw [Finset.sum_add_distrib]
    change ∑ γ, g (brS X (e γ)) (e γ) + ∑ γ, g (e γ) (brS X (e γ)) = 0
    linarith
  have htot : ∑ β, ∑ γ, (inner2 ((B (brS (derOp X A (e β)) (C (e γ))) : skewSub ι) : Matrix ι ι ℝ) ((brS (e β) (e γ) : skewSub ι) : Matrix ι ι ℝ)
      + inner2 ((derOp X B (brS (A (e β)) (C (e γ))) : skewSub ι) : Matrix ι ι ℝ) ((brS (e β) (e γ) : skewSub ι) : Matrix ι ι ℝ)
      + inner2 ((B (brS (A (e β)) (derOp X C (e γ))) : skewSub ι) : Matrix ι ι ℝ) ((brS (e β) (e γ) : skewSub ι) : Matrix ι ι ℝ)) = 0 := by
    simp only [hpt, Finset.sum_sub_distrib, Finset.sum_neg_distrib]
    rw [Finset.sum_comm (f := fun β γ => inner2 ((B (brS (A (brS X (e β))) (C (e γ)))) : Matrix ι ι ℝ) ((brS (e β) (e γ) : skewSub ι) : Matrix ι ι ℝ)
          + inner2 ((B (brS (A (e β)) (C (e γ))) : skewSub ι) : Matrix ι ι ℝ) ((brS (brS X (e β)) (e γ) : skewSub ι) : Matrix ι ι ℝ))]
    simp only [hP, hQ, Finset.sum_const_zero]
    ring
  simp only [Finset.sum_add_distrib] at htot
  linarith

theorem Ftri_der (X : skewSub ι) (A B C : CurvOp2 ι) :
    Ftri (derOp X A) B C + Ftri A (derOp X B) C + Ftri A B (derOp X C) = 0 := by
  unfold Ftri; have := phiTri_der X A B C; linarith

/-- The derivation is skew for the operator pairing. -/
theorem innerOp2_derOp (X : skewSub ι) (R S : CurvOp2 ι) :
    innerOp2 (derOp X R) S = -innerOp2 R (derOp X S) := by
  let b := stdOrthonormalBasis ℝ (FrameExtension.SkewSp ι)
  let f : skewSub ι →ₗ[ℝ] skewSub ι →ₗ[ℝ] ℝ := LinearMap.mk₂ ℝ
    (fun W W' => inner2 ((R W : skewSub ι) : Matrix ι ι ℝ) ((S W' : skewSub ι) : Matrix ι ι ℝ))
    (fun W₁ W₂ W' => by simp only [map_add, Submodule.coe_add, i2_add_l])
    (fun c W W' => by simp only [map_smul, Submodule.coe_smul, i2_smul_l, smul_eq_mul])
    (fun W W₁' W₂' => by simp only [map_add, Submodule.coe_add, i2_add_r])
    (fun c W W' => by simp only [map_smul, Submodule.coe_smul, i2_smul_r, smul_eq_mul])
  have hsum : ∀ P Q : CurvOp2 ι, innerOp2 P Q = ∑ β, inner2 ((P (ofSk (b β)) : skewSub ι) : Matrix ι ι ℝ)
      ((Q (ofSk (b β)) : skewSub ι) : Matrix ι ι ℝ) := fun P Q => by
    let g : skewSub ι →ₗ[ℝ] skewSub ι →ₗ[ℝ] ℝ := LinearMap.mk₂ ℝ
      (fun W W' => inner2 ((P W : skewSub ι) : Matrix ι ι ℝ) ((Q W' : skewSub ι) : Matrix ι ι ℝ))
      (fun W₁ W₂ W' => by simp only [map_add, Submodule.coe_add, i2_add_l])
      (fun c W W' => by simp only [map_smul, Submodule.coe_smul, i2_smul_l, smul_eq_mul])
      (fun W W₁' W₂' => by simp only [map_add, Submodule.coe_add, i2_add_r])
      (fun c W W' => by simp only [map_smul, Submodule.coe_smul, i2_smul_r, smul_eq_mul])
    have h := phi_sum_change b g
    show (1 / 2) * ∑ i, ∑ j, inner2 (applyPhi P i j) (applyPhi Q i j) = _
    have e : ∑ i, ∑ j, inner2 (applyPhi P i j) (applyPhi Q i j)
        = ∑ i, ∑ j, g ⟨phi i j, phi_mem_skewSub i j⟩ ⟨phi i j, phi_mem_skewSub i j⟩ := rfl
    rw [e, h]; simp only [g, LinearMap.mk₂_apply]; ring
  have h1 : ∀ β, inner2 ((brS X (R (ofSk (b β))) : skewSub ι) : Matrix ι ι ℝ) ((S (ofSk (b β)) : skewSub ι) : Matrix ι ι ℝ)
      = -inner2 ((R (ofSk (b β)) : skewSub ι) : Matrix ι ι ℝ) ((brS X (S (ofSk (b β))) : skewSub ι) : Matrix ι ι ℝ) :=
    fun β => inner2_brS_skew _ _ _
  have hsk := onb_ad_skew b X f
  simp only [f, LinearMap.mk₂_apply] at hsk
  rw [hsum, hsum]
  simp only [derOp_apply, map_sub, Submodule.coe_sub, i2_sub_l, i2_sub_r', Finset.sum_sub_distrib, h1,
    Finset.sum_neg_distrib]
  linarith

theorem derOp_sa (X : skewSub ι) {C : CurvOp2 ι} (hC : IsSelfAdjoint2 C) : IsSelfAdjoint2 (derOp X C) := fun Y Z => by
  rw [derOp_apply, derOp_apply, Submodule.coe_sub, Submodule.coe_sub, i2_sub_l, i2_sub_r']
  have a1 := inner2_brS_skew X (C Y) Z
  have a2 := hC (brS X Y) Z
  have a3 := inner2_brS_skew X Y (C Z)
  have a4 := hC Y (brS X Z)
  linarith

/-- **L266 (1) on `𝔰𝔬(n)`.** At every self-adjoint `#`-idempotent the cubic vanishes on orbit tangents. *Proved: an orbit tangent is
a `½`-eigenvector of `C # ·` by the infinitesimal invariance of `F`, and a second application of the invariance leaves
two terms that cancel by the skewness of the derivation.* -/
theorem L266_orbit_tangent (C : CurvOp2 ι) (hC : IsSelfAdjoint2 C) (hidem : IsIdem C) (X Y Z : skewSub ι) :
    Ftri (orbitTangent C X) (orbitTangent C Y) (orbitTangent C Z) = 0 := by
  have hu : ∀ W, orbitTangent C W = derOp W C := fun W => rfl
  simp only [hu]
  -- an orbit tangent is a `½`-eigenvector: `2 F(u_W, C, S) = ⟨S, u_W⟩` for self-adjoint `S`
  have half : ∀ W S, IsSelfAdjoint2 S → 2 * Ftri (derOp W C) C S = innerOp2 S (derOp W C) := by
    intro W S hS
    have h := Ftri_der W C C S
    rw [Ftri_symm12 hS (A := C) (B := derOp W C)] at h
    rw [Ftri_idem hidem, innerOp2_derOp] at h
    linarith
  have hsaX := derOp_sa X hC
  have hsaY := derOp_sa Y hC
  have hsaZ := derOp_sa Z hC
  have h := Ftri_der Y (derOp X C) C (derOp Z C)
  -- the outer terms, through the eigen-relation
  have t1 : Ftri (derOp Y (derOp X C)) C (derOp Z C) = (1 / 2) * innerOp2 (derOp Y (derOp X C)) (derOp Z C) := by
    have hs := derOp_sa Y hsaX
    have e : Ftri (derOp Y (derOp X C)) C (derOp Z C) = Ftri (derOp Z C) C (derOp Y (derOp X C)) := by
      rw [Ftri_symm12 hsaZ, Ftri_symm23 hC, Ftri_symm12 hs]
    rw [e]; have := half Z _ hs; linarith
  have t3 : Ftri (derOp X C) C (derOp Y (derOp Z C)) = (1 / 2) * innerOp2 (derOp Y (derOp Z C)) (derOp X C) := by
    have hs := derOp_sa Y hsaZ
    have := half X _ hs; linarith
  rw [t1, t3] at h
  have skew := innerOp2_derOp Y (derOp X C) (derOp Z C)
  rw [innerOp2_comm (derOp Y (derOp Z C))] at h
  linarith

end Remaining


/-! ## The torus build: the adapted basis of `𝔰𝔬(2m)`, its bracket table, and `C # C` on the torus family

`J_k = φ_{(k,0)(k,1)}` spans the Cartan and `r_ijt` (`t = 0, 1` on `ε_i - ε_j`, `t = 2, 3` on `ε_i + ε_j`) the root
planes. Every `φ`-family sum is rewritten in this basis (`torus_sum_change`), the torus operator is diagonal on the
root vectors (`torusOp_rootS`) and acts by `A` on the Cartan (`torusOp_cartS`), and every bracket of two basis
vectors is a single basis vector up to `±1/√2` or a Cartan pair (`brS_cartS_rootS`, `brS_rootS_ac`, `brS_rootS_bc`,
`brS_rootS_ab`, `brS_rootS_disj`). *Screened before typing* by a numeric bracket table at `m = 3`, which fixed the
signs; the signs drop out of every squared term used below.
-/

section TorusBuild

variable {m : ℕ}

/-- `φ_pq` as an element of `𝔰𝔬`. -/
def phiS {κ : Type*} [Fintype κ] [DecidableEq κ] (p q : κ) : skewSub κ := ⟨phi p q, phi_mem_skewSub p q⟩

/-- The Cartan vector of the `k`-th plane, `J_k = φ_{(k,0)(k,1)}`. -/
def cartS (k : Fin m) : skewSub (Fin m × Fin 2) := phiS (k, 0) (k, 1)

/-- The four unit root vectors of the pair `(i, j)`: `t = 0, 1` span the root plane of `ε_i - ε_j`, `t = 2, 3` that
of `ε_i + ε_j`. -/
noncomputable def rootS (i j : Fin m) (t : Fin 4) : skewSub (Fin m × Fin 2) :=
  (1 / Real.sqrt 2) • match t with
    | 0 => phiS (i, 0) (j, 0) + phiS (i, 1) (j, 1)
    | 1 => phiS (i, 0) (j, 1) - phiS (i, 1) (j, 0)
    | 2 => phiS (i, 0) (j, 0) - phiS (i, 1) (j, 1)
    | 3 => phiS (i, 0) (j, 1) + phiS (i, 1) (j, 0)

theorem inv_sqrt2_sq : (1 / Real.sqrt 2) * (1 / Real.sqrt 2) = 1 / 2 := by
  rw [div_mul_div_comm, one_mul, Real.mul_self_sqrt (by norm_num : (0 : ℝ) ≤ 2)]

theorem inv_sqrt2_mul : (Real.sqrt 2)⁻¹ * (Real.sqrt 2)⁻¹ = 1 / 2 := by
  rw [← mul_inv, Real.mul_self_sqrt (by norm_num : (0 : ℝ) ≤ 2)]; norm_num

theorem phiS_self {κ : Type*} [Fintype κ] [DecidableEq κ] (p : κ) : phiS p p = 0 :=
  Subtype.ext (phi_self p)

theorem phiS_swap {κ : Type*} [Fintype κ] [DecidableEq κ] (p q : κ) : phiS q p = -phiS p q :=
  Subtype.ext (phi_swap p q)

/-- **A `φ`-family sum in the torus-adapted basis**: `∑_{p,q} f(φ_pq, φ_pq) = 2 ∑_k f(J_k, J_k) + ∑_{i ≠ j} ∑_t
f(r_ijt, r_ijt)`, for every bilinear `f`. -/
theorem torus_sum_change (f : skewSub (Fin m × Fin 2) →ₗ[ℝ] skewSub (Fin m × Fin 2) →ₗ[ℝ] ℝ) :
    ∑ p, ∑ q, f (phiS p q) (phiS p q)
      = 2 * ∑ k, f (cartS k) (cartS k) + ∑ i, ∑ j, (if i = j then 0 else ∑ t, f (rootS i j t) (rootS i j t)) := by
  have hsplit : ∑ p, ∑ q, f (phiS p q) (phiS p q)
      = ∑ i, ∑ j, ∑ a, ∑ b, f (phiS (i, a) (j, b)) (phiS (i, a) (j, b)) := by
    rw [Fintype.sum_prod_type]
    refine Finset.sum_congr rfl fun i _ => ?_
    simp only [Fintype.sum_prod_type]
    exact Finset.sum_comm
  have hs := inv_sqrt2_sq
  have hblk : ∀ i j, ∑ a, ∑ b, f (phiS (i, a) (j, b)) (phiS (i, a) (j, b))
      = if i = j then 2 * f (cartS i) (cartS i) else ∑ t, f (rootS i j t) (rootS i j t) := by
    intro i j
    simp only [Fin.sum_univ_two]
    split_ifs with h
    · subst h
      rw [phiS_self, phiS_self, phiS_swap (i, 0) (i, 1)]
      simp only [map_zero, map_neg, LinearMap.neg_apply, neg_neg, cartS]
      ring
    · simp only [Fin.sum_univ_four, rootS, map_add, map_sub, map_smul, LinearMap.add_apply, LinearMap.sub_apply,
        LinearMap.smul_apply, smul_eq_mul]
      linear_combination (-(f (phiS (i, 0) (j, 0)) (phiS (i, 0) (j, 0))) - f (phiS (i, 1) (j, 1)) (phiS (i, 1) (j, 1))
        - f (phiS (i, 0) (j, 1)) (phiS (i, 0) (j, 1)) - f (phiS (i, 1) (j, 0)) (phiS (i, 1) (j, 0))) * 2 * hs
  rw [hsplit, Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => hblk i j, Finset.mul_sum,
    ← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Finset.sum_congr rfl fun j _ => (show (if i = j then 2 * f (cartS i) (cartS i)
      else ∑ t, f (rootS i j t) (rootS i j t)) = (if i = j then 2 * f (cartS i) (cartS i) else 0)
        + (if i = j then 0 else ∑ t, f (rootS i j t) (rootS i j t)) by split_ifs <;> simp),
    Finset.sum_add_distrib, Finset.sum_ite_eq]
  simp

theorem phi_entry {κ : Type*} [DecidableEq κ] (a b x y : κ) :
    (phi a b : Matrix κ κ ℝ) x y = (if b = x ∧ a = y then 1 else 0) - (if a = x ∧ b = y then 1 else 0) := by
  simp only [phi, Matrix.sub_apply, Matrix.single_apply]

theorem cartS_coe (k : Fin m) (p q : Fin m) (c d : Fin 2) :
    ((cartS k : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) (p, c) (q, d)
      = if p = k ∧ q = k then J2 c d else 0 := by
  show (phi (k, 0) (k, 1) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) (p, c) (q, d) = _
  rw [phi_entry]
  by_cases hp : p = k <;> by_cases hq : q = k
  · subst hp; subst hq; fin_cases c <;> fin_cases d <;> simp [J2]
  · simp [hp, hq, Ne.symm hq]
  · simp [hp, Ne.symm hp, hq]
  · simp [hp, hq, Ne.symm hp, Ne.symm hq]

/-- **The torus operator on the Cartan**: `C J_k = ∑_l A_lk J_l`. -/
theorem torusOp_cartS (A U V : Matrix (Fin m) (Fin m) ℝ) (k : Fin m) :
    torusOp A U V (cartS k) = ∑ l, A l k • cartS l := by
  apply Subtype.ext
  have hM : torusMat A U V ((cartS k : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ)
      = Matrix.of fun x y => if x.1 = y.1 then A x.1 k * J2 x.2 y.2 else 0 := by
    ext ⟨p, c⟩ ⟨q, d⟩
    simp only [torusMat, Matrix.of_apply]
    split_ifs with h
    · congr 1
      simp only [cartS_coe]
      simp [Finset.sum_ite_eq', J2]
    · have hb : blk ((cartS k : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) p q = 0 := by
        ext a b; simp only [blk, cartS_coe, Matrix.zero_apply]
        split_ifs with h2
        · exact absurd (h2.1.trans h2.2.symm) h
        · rfl
      rw [hb]; simp [cPart, aPart]
  show skewPartM (torusMat A U V _) = _
  rw [hM, skewPartM_of_skew]
  · ext ⟨p, c⟩ ⟨q, d⟩
    rw [Submodule.coe_sum, Matrix.sum_apply]
    simp only [Submodule.coe_smul, Matrix.smul_apply, cartS_coe, smul_eq_mul, Matrix.of_apply]
    by_cases h : p = q
    · subst h; simp
    · simp only [if_neg h]
      refine (Finset.sum_eq_zero fun l _ => ?_).symm
      rw [if_neg (fun hl => h (hl.1.trans hl.2.symm)), mul_zero]
  · ext ⟨p, c⟩ ⟨q, d⟩
    simp only [Matrix.transpose_apply, Matrix.neg_apply, Matrix.of_apply]
    split_ifs with h1 h2 h2
    · subst h1; fin_cases c <;> fin_cases d <;> simp [J2]
    · exact absurd h1.symm h2
    · exact absurd h2.symm h1
    · simp

/-- The `2 × 2` pattern of each root vector: its block at `(j, i)` is `N_t / √2` and at `(i, j)` is `-N_tᵀ / √2`. -/
def rootPat (t : Fin 4) (c d : Fin 2) : ℝ :=
  match t with
    | 0 => if c = d then 1 else 0
    | 1 => J2 d c
    | 2 => if c = d then (if c = 0 then 1 else -1) else 0
    | 3 => if c = d then 0 else 1

theorem rootS_coe (i j : Fin m) (hij : i ≠ j) (t : Fin 4) (p q : Fin m) (c d : Fin 2) :
    ((rootS i j t : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) (p, c) (q, d)
      = (1 / Real.sqrt 2) * ((if p = j ∧ q = i then rootPat t d c else 0)
          - (if p = i ∧ q = j then rootPat t c d else 0)) := by
  have hji : j ≠ i := Ne.symm hij
  fin_cases t <;>
  · simp only [rootS, Submodule.coe_smul, Submodule.coe_add, Submodule.coe_sub, Matrix.smul_apply,
      Matrix.add_apply, Matrix.sub_apply, smul_eq_mul, phiS]
    congr 1
    simp only [phi_entry, Prod.mk.injEq, rootPat]
    by_cases h1 : p = j <;> by_cases h2 : q = i <;> by_cases h3 : p = i <;> by_cases h4 : q = j <;>
      fin_cases c <;> fin_cases d <;> simp_all [J2] <;> first | (intro h; subst h; simp_all) | simp_all [eq_comm]

/-- The weight of a root vector: `U_ij` on the `ε_i - ε_j` plane (`t = 0, 1`), `V_ij` on `ε_i + ε_j` (`t = 2, 3`). -/
def rootW (U V : Matrix (Fin m) (Fin m) ℝ) (i j : Fin m) (t : Fin 4) : ℝ := if t.val < 2 then U i j else V i j

/-- **The torus operator on a root vector**: `C r_ijt = μ r_ijt`. -/
theorem torusOp_rootS (A U V : Matrix (Fin m) (Fin m) ℝ) (hU : Uᵀ = U) (hV : Vᵀ = V) (i j : Fin m) (hij : i ≠ j)
    (t : Fin 4) : torusOp A U V (rootS i j t) = rootW U V i j t • rootS i j t := by
  apply Subtype.ext
  have hUs : U j i = U i j := by rw [← Matrix.transpose_apply U i j, hU]
  have hVs : V j i = V i j := by rw [← Matrix.transpose_apply V i j, hV]
  set X := ((rootS i j t : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) with hX
  have hM : torusMat A U V X = rootW U V i j t • X := by
    ext ⟨p, c⟩ ⟨q, d⟩
    simp only [torusMat, Matrix.smul_apply, smul_eq_mul]
    split_ifs with hpq
    · obtain rfl : p = q := hpq
      have hz : ∀ k, X (k, 1) (k, 0) = 0 := fun k => by
        rw [hX, rootS_coe i j hij]
        have : ¬(k = j ∧ k = i) := fun h => hij (h.2.symm.trans h.1)
        have : ¬(k = i ∧ k = j) := fun h => hij (h.1.symm.trans h.2)
        simp [*]
      have hz2 : X (p, c) (p, d) = 0 := by
        rw [hX, rootS_coe i j hij]
        have : ¬(p = j ∧ p = i) := fun h => hij (h.2.symm.trans h.1)
        have : ¬(p = i ∧ p = j) := fun h => hij (h.1.symm.trans h.2)
        simp [*]
      simp [hz, hz2]
    · by_cases h1 : p = i ∧ q = j
      · obtain ⟨rfl, rfl⟩ := h1
        have hb : ∀ a b, blk X p q a b = -(1 / Real.sqrt 2) * rootPat t a b := fun a b => by
          simp [blk, hX, rootS_coe p q hij, Ne.symm hij]
        fin_cases c <;> fin_cases d <;>
          simp only [Fin.zero_eta, Fin.mk_one, Fin.isValue, cPart_00, cPart_01, cPart_10, cPart_11, aPart_00, aPart_01, aPart_10, aPart_11, hb] <;>
          rw [hX, rootS_coe p q hij] <;> fin_cases t <;> simp [rootPat, rootW, J2, Ne.symm hij] <;> ring
      by_cases h2 : p = j ∧ q = i
      · obtain ⟨rfl, rfl⟩ := h2
        have hb : ∀ a b, blk X p q a b = (1 / Real.sqrt 2) * rootPat t b a := fun a b => by
          simp [blk, hX, rootS_coe q p hij, Ne.symm hij]
        fin_cases c <;> fin_cases d <;>
          simp only [Fin.zero_eta, Fin.mk_one, Fin.isValue, cPart_00, cPart_01, cPart_10, cPart_11, aPart_00, aPart_01, aPart_10, aPart_11, hb] <;>
          rw [hX, rootS_coe q p hij] <;> fin_cases t <;> simp [rootPat, rootW, J2, Ne.symm hij, hUs, hVs] <;> ring
      · have hb : blk X p q = 0 := by
          ext a b
          simp only [blk, hX, rootS_coe i j hij, Matrix.zero_apply]
          rw [if_neg (fun h => h2 h), if_neg (fun h => h1 h)]; ring
        have hx : X (p, c) (q, d) = 0 := by
          rw [hX, rootS_coe i j hij, if_neg (fun h => h2 h), if_neg (fun h => h1 h)]; ring
        rw [hb, hx]; simp [cPart, aPart]
  show skewPartM (torusMat A U V X) = _
  rw [hM, skewPartM_of_skew _ (by rw [Matrix.transpose_smul, (rootS i j t).2, smul_neg]), Submodule.coe_smul]

/-- **The crossed pairing of the sharp, in the torus-adapted basis**: with `C = torusOp A U V`,
`⟨X, C[Y, C·]⟩`-sum `= ¼(2 ∑_{k,l} A_lk ⟨C[Y, J_l], [X, J_k]⟩ + ∑_{i ≠ j} ∑_t μ_ijt ⟨C[Y, r_ijt], [X, r_ijt]⟩)`. -/
theorem crossPair2_torus (A U V : Matrix (Fin m) (Fin m) ℝ) (hU : Uᵀ = U) (hV : Vᵀ = V)
    (X Y : skewSub (Fin m × Fin 2)) :
    crossPair2 (torusOp A U V) X Y = (1 / 4) * (2 * ∑ k, ∑ l, A l k *
        inner2 ((torusOp A U V (brS Y (cartS l)) : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ)
          ((brS X (cartS k) : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ)
      + ∑ i, ∑ j, (if i = j then 0 else ∑ t, rootW U V i j t *
        inner2 ((torusOp A U V (brS Y (rootS i j t)) : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ)
          ((brS X (rootS i j t) : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ))) := by
  set C := torusOp A U V with hC
  let f : skewSub (Fin m × Fin 2) →ₗ[ℝ] skewSub (Fin m × Fin 2) →ₗ[ℝ] ℝ := LinearMap.mk₂ ℝ
    (fun W W' => inner2 ((brS X (C (brS Y (C W))) : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ)
      (W' : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ))
    (fun W₁ W₂ W' => by simp only [map_add, brS_add_right, Submodule.coe_add, i2_add_l])
    (fun c W W' => by simp only [map_smul, brS_smul_right, Submodule.coe_smul, i2_smul_l, smul_eq_mul])
    (fun W W₁' W₂' => by simp only [Submodule.coe_add, i2_add_r])
    (fun c W W' => by simp only [Submodule.coe_smul, i2_smul_r, smul_eq_mul])
  have hcp : crossPair2 C X Y = -(1 / 4) * ∑ p, ∑ q, f (phiS p q) (phiS p q) := rfl
  have hskew : ∀ W, f W W = -inner2 ((C (brS Y (C W)) : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ)
      ((brS X W : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) := fun W =>
    HamiltonsCubic.L33Statement.ad_skewAdjoint (C (brS Y (C W))).2 X.2 W.2
  have hJ : ∀ k, f (cartS k) (cartS k) = -∑ l, A l k *
      inner2 ((C (brS Y (cartS l)) : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ)
        ((brS X (cartS k) : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) := fun k => by
    rw [hskew, hC, torusOp_cartS, brS_sum_right, map_sum, Submodule.coe_sum, ← hC]
    rw [show ∀ M : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ, ∀ g : Fin m → Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ,
        inner2 (∑ l, g l) M = ∑ l, inner2 (g l) M from fun M g => by
      unfold inner2; rw [Matrix.transpose_sum, Finset.sum_mul, Matrix.trace_sum, Finset.mul_sum]]
    congr 1
    refine Finset.sum_congr rfl fun l _ => ?_
    rw [brS_smul_right, map_smul, Submodule.coe_smul, i2_smul_l]
  have hR : ∀ i j t, i ≠ j → f (rootS i j t) (rootS i j t) = -(rootW U V i j t *
      inner2 ((C (brS Y (rootS i j t)) : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ)
        ((brS X (rootS i j t) : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ)) := fun i j t hij => by
    rw [hskew, hC, torusOp_rootS A U V hU hV i j hij, brS_smul_right, map_smul, Submodule.coe_smul, i2_smul_l, ← hC]
  rw [hcp, torus_sum_change f]
  simp only [hJ, Finset.sum_neg_distrib]
  rw [Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => (show (if i = j then (0 : ℝ) else
      ∑ t, f (rootS i j t) (rootS i j t)) = -(if i = j then 0 else ∑ t, rootW U V i j t *
        inner2 ((C (brS Y (rootS i j t)) : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ)
          ((brS X (rootS i j t) : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ)) by
      split_ifs with h
      · simp
      · rw [← Finset.sum_neg_distrib]; exact Finset.sum_congr rfl fun t _ => hR i j t h)]
  simp only [Finset.sum_neg_distrib]
  ring

theorem cartS_mul (l : Fin m) (Y : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) (p q : Fin m) (c d : Fin 2) :
    (((cartS l : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) * Y) (p, c) (q, d)
      = if p = l then ∑ e, J2 c e * Y (l, e) (q, d) else 0 := by
  rw [Matrix.mul_apply, Fintype.sum_prod_type]
  simp only [cartS_coe]
  by_cases h : p = l
  · subst h; simp [ite_and, Finset.sum_ite_eq']
  · simp [h]

theorem mul_cartS (l : Fin m) (Y : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) (p q : Fin m) (c d : Fin 2) :
    (Y * ((cartS l : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ)) (p, c) (q, d)
      = if q = l then ∑ e, Y (p, c) (l, e) * J2 e d else 0 := by
  rw [Matrix.mul_apply, Fintype.sum_prod_type]
  simp only [cartS_coe]
  by_cases h : q = l
  · subst h; simp [ite_and, Finset.sum_ite_eq']
  · simp [h]

/-- The Cartan is abelian: `[J_k, J_l] = 0`. -/
theorem brS_cartS_cartS (k l : Fin m) : brS (cartS k) (cartS l) = 0 := by
  apply Subtype.ext
  show br _ _ = (0 : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ)
  ext ⟨p, c⟩ ⟨q, d⟩
  simp only [br, Matrix.sub_apply, cartS_mul, cartS_coe, Matrix.zero_apply]
  by_cases hp : p = k <;> by_cases hq : q = l <;> by_cases hpl : p = l <;> by_cases hqk : q = k <;>
    simp [hp, hq, hpl, hqk, Fin.sum_univ_two] <;> (try subst_vars) <;> fin_cases c <;> fin_cases d <;>
    simp_all [J2, eq_comm]

/-- The partner index of a root vector in its plane. -/
def flipT : Fin 4 → Fin 4
  | 0 => 1
  | 1 => 0
  | 2 => 3
  | 3 => 2

/-- The weight of `J_l` on the pair `(i, j)`: `[J_l, r_ijt] = σ r_ij(flip t)`. -/
def sigT (l i j : Fin m) (t : Fin 4) : ℝ :=
  match t with
    | 0 => (if l = j then 1 else 0) - (if l = i then 1 else 0)
    | 1 => (if l = i then 1 else 0) - (if l = j then 1 else 0)
    | 2 => (if l = i then 1 else 0) + (if l = j then 1 else 0)
    | 3 => -((if l = i then 1 else 0) + (if l = j then 1 else 0))

/-- **The torus acts on each root plane by rotation**: `[J_l, r_ijt] = σ_l r_ij(flip t)`. -/
theorem brS_cartS_rootS (l i j : Fin m) (hij : i ≠ j) (t : Fin 4) :
    brS (cartS l) (rootS i j t) = sigT l i j t • rootS i j (flipT t) := by
  apply Subtype.ext
  show br _ _ = _
  rw [Submodule.coe_smul]
  ext ⟨p, c⟩ ⟨q, d⟩
  simp only [br, Matrix.sub_apply, cartS_mul, mul_cartS, Matrix.smul_apply, smul_eq_mul, rootS_coe i j hij,
    Fin.sum_univ_two]
  by_cases h1 : p = i ∧ q = j
  · obtain ⟨rfl, rfl⟩ := h1
    rcases eq_or_ne l p with rfl | hli
    · have hlj : q ≠ l := Ne.symm hij
      fin_cases t <;> fin_cases c <;> fin_cases d <;> simp [sigT, flipT, rootPat, J2, hij, hlj] <;> ring
    rcases eq_or_ne l q with rfl | hlj
    · have hli' : p ≠ l := Ne.symm hli
      fin_cases t <;> fin_cases c <;> fin_cases d <;> simp [sigT, flipT, rootPat, J2, hij, hli, hli'] <;> ring
    have hli' : p ≠ l := Ne.symm hli
    have hlj' : q ≠ l := Ne.symm hlj
    fin_cases t <;> fin_cases c <;> fin_cases d <;> simp [sigT, flipT, rootPat, J2, hli, hlj, hli', hlj']
  by_cases h2 : p = j ∧ q = i
  · obtain ⟨rfl, rfl⟩ := h2
    rcases eq_or_ne l q with rfl | hli
    · have hlj : p ≠ l := Ne.symm hij
      fin_cases t <;> fin_cases c <;> fin_cases d <;> simp [sigT, flipT, rootPat, J2, hij, hlj] <;> ring
    rcases eq_or_ne l p with rfl | hlj
    · have hli' : q ≠ l := Ne.symm hli
      fin_cases t <;> fin_cases c <;> fin_cases d <;> simp [sigT, flipT, rootPat, J2, hij, hli, hli'] <;> ring
    have hli' : q ≠ l := Ne.symm hli
    have hlj' : p ≠ l := Ne.symm hlj
    fin_cases t <;> fin_cases c <;> fin_cases d <;> simp [sigT, flipT, rootPat, J2, hli, hlj, hli', hlj']
  · rw [if_neg h2, if_neg h1]
    have z1 : p = l → ∀ e : Fin 2, (1 / Real.sqrt 2) * ((if l = j ∧ q = i then rootPat t d e else 0)
        - (if l = i ∧ q = j then rootPat t e d else 0)) = 0 := fun hp e => by
      rw [if_neg (fun h => h2 ⟨hp.trans h.1, h.2⟩), if_neg (fun h => h1 ⟨hp.trans h.1, h.2⟩)]; ring
    have z2 : q = l → ∀ e : Fin 2, (1 / Real.sqrt 2) * ((if p = j ∧ l = i then rootPat t e c else 0)
        - (if p = i ∧ l = j then rootPat t c e else 0)) = 0 := fun hq e => by
      rw [if_neg (fun h => h2 ⟨h.1, hq.trans h.2⟩), if_neg (fun h => h1 ⟨h.1, hq.trans h.2⟩)]; ring
    by_cases hp : p = l <;> by_cases hq : q = l
    · rw [if_pos hp, if_pos hq, z1 hp 0, z1 hp 1, z2 hq 0, z2 hq 1]; ring
    · rw [if_pos hp, if_neg hq, z1 hp 0, z1 hp 1]; ring
    · rw [if_neg hp, if_pos hq, z2 hq 0, z2 hq 1]; ring
    · rw [if_neg hp, if_neg hq]; ring

theorem rootS_norm (i j : Fin m) (hij : i ≠ j) (t : Fin 4) :
    inner2 ((rootS i j t : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ)
      ((rootS i j t : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) = 1 := by
  have hs := inv_sqrt2_sq
  fin_cases t <;>
  · simp only [rootS, Submodule.coe_smul, Submodule.coe_add, Submodule.coe_sub, i2_smul_l, i2_smul_r, i2_add_l,
      i2_add_r, i2_sub_l, i2_sub_r', phiS, HamiltonsCubic.FamilyLayer.inner2_phi_phi, Prod.mk.injEq]
    simp [hij, Ne.symm hij]
    linear_combination 2 * hs

/-- The weights of a plane agree on its two root vectors. -/
theorem rootW_flip (U V : Matrix (Fin m) (Fin m) ℝ) (i j : Fin m) (t : Fin 4) :
    rootW U V i j (flipT t) = rootW U V i j t := by
  fin_cases t <;> rfl

/-- Kronecker delta. -/
def dlt {κ : Type*} [DecidableEq κ] (a b : κ) : ℝ := if a = b then 1 else 0

theorem dd_ij (f : Fin m → Fin m → ℝ) (a b : Fin m) : ∑ i, ∑ j, f i j * (dlt a i * dlt b j) = f a b := by
  simp [dlt, ite_mul, mul_ite, Finset.sum_ite_eq]

theorem dd_ji (f : Fin m → Fin m → ℝ) (a b : Fin m) : ∑ i, ∑ j, f i j * (dlt a j * dlt b i) = f b a := by
  simp [dlt, ite_mul, mul_ite, Finset.sum_ite_eq]

theorem dd_ii (f : Fin m → Fin m → ℝ) (a b : Fin m) :
    ∑ i, ∑ j, f i j * (dlt a i * dlt b i) = if a = b then ∑ j, f a j else 0 := by
  simp only [dlt, ite_mul, mul_ite, one_mul, mul_one, zero_mul, mul_zero]
  by_cases h : a = b
  · subst h; simp [Finset.sum_ite_eq]
  · simp [h]

theorem dd_jj (f : Fin m → Fin m → ℝ) (a b : Fin m) :
    ∑ i, ∑ j, f i j * (dlt a j * dlt b j) = if a = b then ∑ i, f i a else 0 := by
  simp only [dlt, ite_mul, mul_ite, one_mul, mul_one, zero_mul, mul_zero]
  by_cases h : a = b
  · subst h; simp [Finset.sum_ite_eq]
  · simp [h]

/-- **`⟨(C # C) J_k, J_l⟩ = (A_μ)_kl`** on the torus family: the Cartan block of the sharp does not see `A`. -/
theorem sharpBil2_torus_cart (A U V : Matrix (Fin m) (Fin m) ℝ) (hU : IsPairWeights U) (hV : IsPairWeights V)
    (k l : Fin m) : sharpBil2 (torusOp A U V) (cartS k) (cartS l) = Amu U V k l := by
  obtain ⟨hUt, hU0⟩ := hU
  obtain ⟨hVt, hV0⟩ := hV
  have hUs : ∀ a b, U b a = U a b := fun a b => by rw [← Matrix.transpose_apply U a b, hUt]
  have hVs : ∀ a b, V b a = V a b := fun a b => by rw [← Matrix.transpose_apply V a b, hVt]
  rw [sharpBil2_eq_crossPair2, crossPair2_torus A U V hUt hVt]
  simp only [brS_cartS_cartS, map_zero, ZeroMemClass.coe_zero]
  have hz : ∀ M : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ, inner2 0 M = 0 := fun M => by simp [inner2]
  simp only [hz, mul_zero, Finset.sum_const_zero, add_zero, zero_add]
  have hterm : ∀ i j, i ≠ j → ∑ t, rootW U V i j t *
      inner2 ((torusOp A U V (brS (cartS l) (rootS i j t)) : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ)
        ((brS (cartS k) (rootS i j t) : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ)
      = ∑ t, rootW U V i j t ^ 2 * sigT l i j t * sigT k i j t := fun i j hij => by
    refine Finset.sum_congr rfl fun t _ => ?_
    rw [brS_cartS_rootS l i j hij, brS_cartS_rootS k i j hij, map_smul, torusOp_rootS A U V hUt hVt i j hij,
      Submodule.coe_smul, Submodule.coe_smul, Submodule.coe_smul, i2_smul_l, i2_smul_l, i2_smul_r, rootS_norm i j hij,
      rootW_flip]
    ring
  rw [Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => (show (if i = j then (0 : ℝ) else _)
      = ∑ t, rootW U V i j t ^ 2 * sigT l i j t * sigT k i j t by
    split_ifs with h
    · subst h; simp [rootW, sigT, Fin.sum_univ_four, hU0, hV0]
    · exact hterm i j h)]
  have hG : ∀ i j, ∑ t, rootW U V i j t ^ 2 * sigT l i j t * sigT k i j t
      = 2 * (U i j ^ 2 * (dlt l j * dlt k j) - U i j ^ 2 * (dlt l j * dlt k i) - U i j ^ 2 * (dlt l i * dlt k j)
          + U i j ^ 2 * (dlt l i * dlt k i) + V i j ^ 2 * (dlt l i * dlt k i) + V i j ^ 2 * (dlt l i * dlt k j)
          + V i j ^ 2 * (dlt l j * dlt k i) + V i j ^ 2 * (dlt l j * dlt k j)) := fun i j => by
    have e : ∀ a b : Fin m, (if a = b then (1 : ℝ) else 0) = dlt a b := fun _ _ => rfl
    simp only [Fin.sum_univ_four, rootW, sigT, e]; norm_num; ring
  simp only [hG, ← Finset.mul_sum, Finset.sum_add_distrib, Finset.sum_sub_distrib]
  rw [dd_ij, dd_ji, dd_ii, dd_jj, dd_ii, dd_ij, dd_ji, dd_jj]
  unfold Amu
  by_cases h : k = l
  · subst h; simp [hUs, hVs, hU0, hV0]; ring_nf; rw [← Finset.sum_add_distrib]
  · simp [h, Ne.symm h, hUs, hVs]; ring

theorem brS_phiS {κ : Type*} [Fintype κ] [DecidableEq κ] (a b c d : κ) :
    brS (phiS a b) (phiS c d) = (if a = c then (1 : ℝ) else 0) • phiS b d + (if b = d then (1 : ℝ) else 0) • phiS a c
      - (if a = d then (1 : ℝ) else 0) • phiS b c - (if b = c then (1 : ℝ) else 0) • phiS a d :=
  Subtype.ext (br_phi_phi a b c d)

/-- The index `s ⊕ t` of the Klein group on the four root vectors of a plane. -/
def xorT (s t : Fin 4) : Fin 4 :=
  match s, t with
    | 0, 0 => 0
    | 0, 1 => 1
    | 0, 2 => 2
    | 0, 3 => 3
    | 1, 0 => 1
    | 1, 1 => 0
    | 1, 2 => 3
    | 1, 3 => 2
    | 2, 0 => 2
    | 2, 1 => 3
    | 2, 2 => 0
    | 2, 3 => 1
    | 3, 0 => 3
    | 3, 1 => 2
    | 3, 2 => 1
    | 3, 3 => 0

/-- The sign of `[r_ab s, r_ac t] = ± r_bc (s ⊕ t) / √2`. -/
def sgnA (s t : Fin 4) : ℝ :=
  match s, t with
    | 1, 0 => -1 | 1, 3 => -1 | 3, 1 => -1 | 3, 2 => -1
    | _, _ => 1

/-- **Brackets of root vectors sharing their first index**: `[r_ab s, r_ac t] = ± r_bc (s ⊕ t) / √2`. -/
theorem brS_rootS_ac (a b c : Fin m) (hab : a ≠ b) (hac : a ≠ c) (hbc : b ≠ c) (s t : Fin 4) :
    brS (rootS a b s) (rootS a c t) = (sgnA s t / Real.sqrt 2) • rootS b c (xorT s t) := by
  have hs := inv_sqrt2_sq
  have hba := Ne.symm hab
  have hca := Ne.symm hac
  have hcb := Ne.symm hbc
  fin_cases s <;> fin_cases t <;>
  · simp only [rootS, brS_smul_left, brS_smul_right, brS_add_left, brS_add_right, brS_sub_left, brS_sub_right,
      brS_phiS, Prod.mk.injEq, hab, hac, hbc, hba, hca, hcb, false_and, and_false, if_false, zero_smul, add_zero,
      sub_zero, zero_add, zero_sub]
    simp only [sgnA, xorT, Fin.isValue, Fin.reduceFinMk]
    norm_num
    try module

/-- The sign of `[r_ab s, r_bc t] = ± r_ac (s ⊕ t) / √2`. -/
def sgnB (s t : Fin 4) : ℝ :=
  match s, t with
    | 1, 1 => 1 | 1, 2 => 1 | 3, 1 => 1 | 3, 2 => 1
    | _, _ => -1

/-- **Brackets of root vectors chained through an index**: `[r_ab s, r_bc t] = ± r_ac (s ⊕ t) / √2`. -/
theorem brS_rootS_bc (a b c : Fin m) (hab : a ≠ b) (hac : a ≠ c) (hbc : b ≠ c) (s t : Fin 4) :
    brS (rootS a b s) (rootS b c t) = (sgnB s t / Real.sqrt 2) • rootS a c (xorT s t) := by
  have hba := Ne.symm hab
  have hca := Ne.symm hac
  have hcb := Ne.symm hbc
  fin_cases s <;> fin_cases t <;>
  · simp only [rootS, brS_smul_left, brS_smul_right, brS_add_left, brS_add_right, brS_sub_left, brS_sub_right,
      brS_phiS, Prod.mk.injEq, hab, hac, hbc, hba, hca, hcb, false_and, and_false, if_false, zero_smul, add_zero,
      sub_zero, zero_add, zero_sub]
    simp only [sgnB, xorT, Fin.isValue, Fin.reduceFinMk]
    norm_num
    try module

/-- The Cartan coefficients of `[r_ab s, r_ab t] = α J_a + β J_b`. -/
def cartA (s t : Fin 4) : ℝ :=
  match s, t with
    | 0, 1 => -1 | 1, 0 => 1 | 2, 3 => 1 | 3, 2 => -1
    | _, _ => 0

def cartB (s t : Fin 4) : ℝ :=
  match s, t with
    | 0, 1 => 1 | 1, 0 => -1 | 2, 3 => 1 | 3, 2 => -1
    | _, _ => 0

theorem phiS_10 (k : Fin m) : phiS ((k, 1) : Fin m × Fin 2) (k, 0) = -cartS k := phiS_swap _ _

/-- **Brackets within one plane land in the Cartan**: `[r_ab s, r_ab t] = α J_a + β J_b`. -/
theorem brS_rootS_ab (a b : Fin m) (hab : a ≠ b) (s t : Fin 4) :
    brS (rootS a b s) (rootS a b t) = cartA s t • cartS a + cartB s t • cartS b := by
  have hba := Ne.symm hab
  fin_cases s <;> fin_cases t <;>
  · simp only [rootS, brS_smul_left, brS_smul_right, brS_add_left, brS_add_right, brS_sub_left, brS_sub_right,
      brS_phiS, Prod.mk.injEq, hab, hba, false_and, and_false, if_false, zero_smul, add_zero,
      sub_zero, zero_add, zero_sub, true_and, and_true]
    simp only [cartA, cartB, Fin.isValue, Fin.reduceFinMk, phiS_self, phiS_10]
    norm_num
    try (simp only [cartS, smul_add, smul_sub, smul_neg, smul_smul, inv_sqrt2_mul]; module)

/-- **Brackets of root vectors on disjoint pairs vanish.** -/
theorem brS_rootS_disj (a b i j : Fin m) (hai : a ≠ i) (haj : a ≠ j) (hbi : b ≠ i) (hbj : b ≠ j) (s t : Fin 4) :
    brS (rootS a b s) (rootS i j t) = 0 := by
  fin_cases s <;> fin_cases t <;>
  · simp only [rootS, brS_smul_left, brS_smul_right, brS_add_left, brS_add_right, brS_sub_left, brS_sub_right,
      brS_phiS, Prod.mk.injEq, hai, haj, hbi, hbj, false_and, and_false, if_false, zero_smul, add_zero,
      sub_zero, zero_add, zero_sub, smul_zero, sub_self, neg_zero]

/-- The orientation of a root vector: `r_ji t = ε_t r_ij t`. -/
def epsT (t : Fin 4) : ℝ :=
  match t with
    | 1 => 1
    | _ => -1

theorem rootS_swap (i j : Fin m) (t : Fin 4) : rootS j i t = epsT t • rootS i j t := by
  fin_cases t <;>
  · simp only [rootS, epsT, Fin.isValue, Fin.reduceFinMk, phiS_swap ((i, 0) : Fin m × Fin 2) (j, 0),
      phiS_swap ((i, 1) : Fin m × Fin 2) (j, 1), phiS_swap ((i, 0) : Fin m × Fin 2) (j, 1),
      phiS_swap ((i, 1) : Fin m × Fin 2) (j, 0)]
    module

/-- The quadratic form `Z ↦ ⟨C Z, Z⟩` of the torus operator. -/
noncomputable def QF (A U V : Matrix (Fin m) (Fin m) ℝ) (Z : skewSub (Fin m × Fin 2)) : ℝ :=
  inner2 ((torusOp A U V Z : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ)
    (Z : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ)

theorem QF_smul (A U V : Matrix (Fin m) (Fin m) ℝ) (c : ℝ) (Z : skewSub (Fin m × Fin 2)) :
    QF A U V (c • Z) = c ^ 2 * QF A U V Z := by
  unfold QF; rw [map_smul, Submodule.coe_smul, Submodule.coe_smul, i2_smul_l, i2_smul_r]; ring

theorem QF_zero (A U V : Matrix (Fin m) (Fin m) ℝ) : QF A U V 0 = 0 := by
  unfold QF; simp [inner2]

theorem QF_root (A U V : Matrix (Fin m) (Fin m) ℝ) (hU : Uᵀ = U) (hV : Vᵀ = V) (p q : Fin m) (hpq : p ≠ q)
    (u : Fin 4) : QF A U V (rootS p q u) = rootW U V p q u := by
  unfold QF; rw [torusOp_rootS A U V hU hV p q hpq, Submodule.coe_smul, i2_smul_l, rootS_norm p q hpq, mul_one]

theorem cartS_inner (k l : Fin m) :
    inner2 ((cartS k : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ)
      ((cartS l : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) = dlt k l := by
  show inner2 (phi (k, 0) (k, 1)) (phi (l, 0) (l, 1)) = _
  rw [HamiltonsCubic.FamilyLayer.inner2_phi_phi]
  by_cases h : k = l
  · subst h; simp [dlt]
  · simp [dlt, h]

theorem inner2_torus_cart (A U V : Matrix (Fin m) (Fin m) ℝ) (k l : Fin m) :
    inner2 ((torusOp A U V (cartS k) : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ)
      ((cartS l : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) = A l k := by
  rw [torusOp_cartS, Submodule.coe_sum]
  rw [show ∀ M : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ, ∀ g : Fin m → Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ,
      inner2 (∑ l, g l) M = ∑ l, inner2 (g l) M from fun M g => by
    unfold inner2; rw [Matrix.transpose_sum, Finset.sum_mul, Matrix.trace_sum, Finset.mul_sum]]
  simp only [Submodule.coe_smul, i2_smul_l, cartS_inner, dlt, mul_ite, mul_one, mul_zero, Finset.sum_ite_eq',
    Finset.mem_univ, if_true]

theorem QF_cart2 (A U V : Matrix (Fin m) (Fin m) ℝ) (a b : Fin m) (α β : ℝ) :
    QF A U V (α • cartS a + β • cartS b) = α ^ 2 * A a a + α * β * (A a b + A b a) + β ^ 2 * A b b := by
  unfold QF
  rw [map_add, map_smul, map_smul]
  simp only [Submodule.coe_add, Submodule.coe_smul, i2_add_l, i2_add_r, i2_smul_l, i2_smul_r, inner2_torus_cart]
  ring

theorem pm_sq {c : ℝ} (h : c = 1 ∨ c = -1) : c ^ 2 = 1 := by rcases h with h | h <;> rw [h] <;> norm_num
theorem sgnA_sq (s t : Fin 4) : sgnA s t ^ 2 = 1 :=
  pm_sq (by fin_cases s <;> fin_cases t <;> first | exact Or.inl rfl | exact Or.inr rfl)
theorem sgnB_sq (s t : Fin 4) : sgnB s t ^ 2 = 1 :=
  pm_sq (by fin_cases s <;> fin_cases t <;> first | exact Or.inl rfl | exact Or.inr rfl)
theorem epsT_sq (t : Fin 4) : epsT t ^ 2 = 1 :=
  pm_sq (by fin_cases t <;> first | exact Or.inl rfl | exact Or.inr rfl)

theorem rootW_symm (U V : Matrix (Fin m) (Fin m) ℝ) (hU : Uᵀ = U) (hV : Vᵀ = V) (i j : Fin m) (t : Fin 4) :
    rootW U V j i t = rootW U V i j t := by
  unfold rootW
  rw [← Matrix.transpose_apply U i j, hU, ← Matrix.transpose_apply V i j, hV]

theorem rootW_diag (U V : Matrix (Fin m) (Fin m) ℝ) (hU : ∀ i, U i i = 0) (hV : ∀ i, V i i = 0) (i : Fin m)
    (t : Fin 4) : rootW U V i i t = 0 := by
  unfold rootW; split_ifs <;> simp [hU, hV]

theorem sq_div_sqrt2 (c : ℝ) (hc : c ^ 2 = 1) : (c / Real.sqrt 2) ^ 2 = 1 / 2 := by
  rw [div_pow, hc, Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 2)]

/-- `½ ∑_t μ_{ac,t} μ_{bc,s⊕t}`, the contribution of the plane `(a, c)` to `⟨(C # C) r_abs, r_abs⟩`. -/
noncomputable def Yf (U V : Matrix (Fin m) (Fin m) ℝ) (a b c : Fin m) (s : Fin 4) : ℝ :=
  (1 / 2) * ∑ t, rootW U V a c t * rootW U V b c (xorT s t)

/-- The Cartan contribution to `⟨(C # C) r_abs, r_abs⟩`. -/
noncomputable def Xf (A U V : Matrix (Fin m) (Fin m) ℝ) (a b : Fin m) (s : Fin 4) : ℝ :=
  ∑ t, rootW U V a b t * (cartA s t ^ 2 * A a a + cartA s t * cartB s t * (A a b + A b a) + cartB s t ^ 2 * A b b)

theorem Yf_diag_l (U V : Matrix (Fin m) (Fin m) ℝ) (hU : ∀ i, U i i = 0) (hV : ∀ i, V i i = 0) (a b : Fin m)
    (s : Fin 4) : Yf U V a b a s = 0 := by
  simp [Yf, rootW_diag U V hU hV]

theorem Yf_diag_r (U V : Matrix (Fin m) (Fin m) ℝ) (hU : ∀ i, U i i = 0) (hV : ∀ i, V i i = 0) (a b : Fin m)
    (s : Fin 4) : Yf U V a b b s = 0 := by
  simp [Yf, rootW_diag U V hU hV]

/-- **The root-plane terms of `⟨(C # C) r_abs, r_abs⟩`, pair by pair**: only the planes meeting `{a, b}`
contribute, the plane `(a, b)` through the Cartan and each plane `(a, c)`, `(b, c)` through the third side. -/
theorem root_term (A U V : Matrix (Fin m) (Fin m) ℝ) (hU : IsPairWeights U) (hV : IsPairWeights V) (a b : Fin m)
    (hab : a ≠ b) (s : Fin 4) (i j : Fin m) :
    (if i = j then 0 else ∑ t, rootW U V i j t * QF A U V (brS (rootS a b s) (rootS i j t)))
      = dlt a i * dlt b j * Xf A U V a b s + dlt b i * dlt a j * Xf A U V a b s + dlt a i * Yf U V a b j s
        + dlt a j * Yf U V a b i s + dlt b i * Yf U V b a j s + dlt b j * Yf U V b a i s := by
  obtain ⟨hUt, hU0⟩ := hU
  obtain ⟨hVt, hV0⟩ := hV
  have hba := Ne.symm hab
  have hYl := Yf_diag_l U V hU0 hV0
  have hYr := Yf_diag_r U V hU0 hV0
  have hswap : ∀ p q t, QF A U V (brS (rootS a b s) (rootS q p t)) = QF A U V (brS (rootS a b s) (rootS p q t)) :=
    fun p q t => by rw [rootS_swap p q t, brS_smul_right, QF_smul, epsT_sq, one_mul]
  by_cases hij : i = j
  · subst hij
    rw [if_pos rfl]
    by_cases hia : i = a
    · subst hia; simp [dlt, hab, hba, hYl, hYr]
    by_cases hib : i = b
    · subst hib; simp [dlt, hab, hba, hYl, hYr]
    · simp [dlt, Ne.symm hia, Ne.symm hib]
  rw [if_neg hij]
  have hji : j ≠ i := Ne.symm hij
  by_cases hia : i = a
  · subst hia
    by_cases hjb : j = b
    · subst hjb
      have hR : dlt i i * dlt j j * Xf A U V i j s + dlt j i * dlt i j * Xf A U V i j s + dlt i i * Yf U V i j j s
          + dlt i j * Yf U V i j i s + dlt j i * Yf U V j i j s + dlt j j * Yf U V j i i s = Xf A U V i j s := by
        simp [dlt, hij, hji, hYl, hYr]
      rw [hR, Xf]
      refine Finset.sum_congr rfl fun t _ => ?_
      rw [brS_rootS_ab i j hab, QF_cart2]
    · have hR : dlt i i * dlt b j * Xf A U V i b s + dlt b i * dlt i j * Xf A U V i b s + dlt i i * Yf U V i b j s
          + dlt i j * Yf U V i b i s + dlt b i * Yf U V b i j s + dlt b j * Yf U V b i i s = Yf U V i b j s := by
        simp [dlt, hij, hba, Ne.symm hjb]
      rw [hR, Yf, Finset.mul_sum]
      refine Finset.sum_congr rfl fun t _ => ?_
      rw [brS_rootS_ac i b j hab hij (fun h => hjb h.symm), QF_smul, sq_div_sqrt2 _ (sgnA_sq s t),
        QF_root A U V hUt hVt b j (fun h => hjb h.symm)]
      ring
  by_cases hib : i = b
  · subst hib
    by_cases hja : j = a
    · subst hja
      have hR : dlt j i * dlt i j * Xf A U V j i s + dlt i i * dlt j j * Xf A U V j i s + dlt j i * Yf U V j i j s
          + dlt j j * Yf U V j i i s + dlt i i * Yf U V i j j s + dlt i j * Yf U V i j i s = Xf A U V j i s := by
        simp [dlt, hij, hji, hYl, hYr]
      rw [hR, Xf]
      refine Finset.sum_congr rfl fun t _ => ?_
      rw [hswap, brS_rootS_ab j i hab, QF_cart2, rootW_symm U V hUt hVt]
    · have hR : dlt a i * dlt i j * Xf A U V a i s + dlt i i * dlt a j * Xf A U V a i s + dlt a i * Yf U V a i j s
          + dlt a j * Yf U V a i i s + dlt i i * Yf U V i a j s + dlt i j * Yf U V i a i s = Yf U V i a j s := by
        simp [dlt, hij, hab, Ne.symm hja]
      rw [hR, Yf, Finset.mul_sum]
      refine Finset.sum_congr rfl fun t _ => ?_
      rw [brS_rootS_bc a i j hab (fun h => hja h.symm) hij, QF_smul, sq_div_sqrt2 _ (sgnB_sq s t),
        QF_root A U V hUt hVt a j (fun h => hja h.symm)]
      ring
  by_cases hja : j = a
  · subst hja
    have hR : dlt j i * dlt b j * Xf A U V j b s + dlt b i * dlt j j * Xf A U V j b s + dlt j i * Yf U V j b j s
        + dlt j j * Yf U V j b i s + dlt b i * Yf U V b j j s + dlt b j * Yf U V b j i s = Yf U V j b i s := by
      simp [dlt, hji, hba, Ne.symm hib]
    rw [hR, Yf, Finset.mul_sum]
    refine Finset.sum_congr rfl fun t _ => ?_
    rw [hswap, brS_rootS_ac j b i hab hji (fun h => hib h.symm), QF_smul, sq_div_sqrt2 _ (sgnA_sq s t),
      QF_root A U V hUt hVt b i (fun h => hib h.symm), rootW_symm U V hUt hVt]
    ring
  by_cases hjb : j = b
  · subst hjb
    have hR : dlt a i * dlt j j * Xf A U V a j s + dlt j i * dlt a j * Xf A U V a j s + dlt a i * Yf U V a j j s
        + dlt a j * Yf U V a j i s + dlt j i * Yf U V j a j s + dlt j j * Yf U V j a i s = Yf U V j a i s := by
      simp [dlt, hji, hab, Ne.symm hia]
    rw [hR, Yf, Finset.mul_sum]
    refine Finset.sum_congr rfl fun t _ => ?_
    rw [hswap, brS_rootS_bc a j i hab (fun h => hia h.symm) hji, QF_smul, sq_div_sqrt2 _ (sgnB_sq s t),
      QF_root A U V hUt hVt a i (fun h => hia h.symm), rootW_symm U V hUt hVt]
    ring
  · have hR : dlt a i * dlt b j * Xf A U V a b s + dlt b i * dlt a j * Xf A U V a b s + dlt a i * Yf U V a b j s
        + dlt a j * Yf U V a b i s + dlt b i * Yf U V b a j s + dlt b j * Yf U V b a i s = 0 := by
      simp [dlt, Ne.symm hia, Ne.symm hib, Ne.symm hja, Ne.symm hjb]
    rw [hR]
    refine Finset.sum_eq_zero fun t _ => ?_
    rw [brS_rootS_disj a b i j (Ne.symm hia) (Ne.symm hja) (Ne.symm hib) (Ne.symm hjb), QF_zero, mul_zero]

theorem brS_rootS_cartS (l a b : Fin m) (hab : a ≠ b) (s : Fin 4) :
    brS (rootS a b s) (cartS l) = (-sigT l a b s) • rootS a b (flipT s) := by
  rw [brS_neg, brS_cartS_rootS l a b hab]; exact (neg_smul _ _).symm

theorem sum_dlt_l (f : Fin m → ℝ) (a : Fin m) : ∑ i, dlt a i * f i = f a := by
  simp [dlt, Finset.sum_ite_eq]

theorem sum_dlt_r (f : Fin m → ℝ) (a : Fin m) : ∑ i, f i * dlt a i = f a := by
  simp [dlt, Finset.sum_ite_eq]

/-- The sign of the Cartan pairing on a root plane: `-1` on `ε_a - ε_b`, `+1` on `ε_a + ε_b`. -/
def rsgn (s : Fin 4) : ℝ := if s.val < 2 then -1 else 1

/-- The cross term of the two root planes through `(a, b)`: `(UU + VV)_ab` on `ε_a - ε_b`, `(UV + VU)_ab` on
`ε_a + ε_b`. -/
noncomputable def rootPair (U V : Matrix (Fin m) (Fin m) ℝ) (a b : Fin m) (s : Fin 4) : ℝ :=
  if s.val < 2 then (U * U + V * V) a b else (U * V + V * U) a b

theorem Xf_closed (A U V : Matrix (Fin m) (Fin m) ℝ) (hA : Aᵀ = A) (a b : Fin m) (s : Fin 4) :
    Xf A U V a b s = rootW U V a b s * (A a a + A b b + 2 * rsgn s * A a b) := by
  have hAs : A b a = A a b := by rw [← Matrix.transpose_apply A a b, hA]
  fin_cases s <;> simp only [Xf, rootW, cartA, cartB, rsgn, Fin.sum_univ_four, Fin.isValue, Fin.reduceFinMk] <;>
    norm_num <;> (try rw [hAs]) <;> (try ring_nf) <;> (try simp)

theorem sumY (U V : Matrix (Fin m) (Fin m) ℝ) (hU : Uᵀ = U) (hV : Vᵀ = V) (a b : Fin m) (s : Fin 4) :
    ∑ c, Yf U V a b c s = rootPair U V a b s := by
  have hUs : ∀ x y, U y x = U x y := fun x y => by rw [← Matrix.transpose_apply U x y, hU]
  have hVs : ∀ x y, V y x = V x y := fun x y => by rw [← Matrix.transpose_apply V x y, hV]
  fin_cases s <;>
  · simp only [Yf, rootPair, rootW, xorT, Fin.sum_univ_four, Fin.isValue, Matrix.add_apply, Matrix.mul_apply]
    norm_num
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun c _ => ?_
    rw [hUs c b, hVs c b]
    ring

theorem rootPair_symm (U V : Matrix (Fin m) (Fin m) ℝ) (hU : Uᵀ = U) (hV : Vᵀ = V) (a b : Fin m) (s : Fin 4) :
    rootPair U V b a s = rootPair U V a b s := by
  have hUs : ∀ x y, U y x = U x y := fun x y => by rw [← Matrix.transpose_apply U x y, hU]
  have hVs : ∀ x y, V y x = V x y := fun x y => by rw [← Matrix.transpose_apply V x y, hV]
  unfold rootPair
  split_ifs
  · simp only [Matrix.add_apply, Matrix.mul_apply]
    rw [← Finset.sum_add_distrib, ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun c _ => ?_
    rw [hUs b c, hVs b c, hUs c a, hVs c a]; ring
  · simp only [Matrix.add_apply, Matrix.mul_apply]
    rw [← Finset.sum_add_distrib, ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun c _ => ?_
    rw [hUs b c, hVs b c, hUs c a, hVs c a]; ring

def sigA (s : Fin 4) : ℝ := match s with | 0 => -1 | 1 => 1 | 2 => 1 | 3 => -1
def sigB (s : Fin 4) : ℝ := match s with | 0 => 1 | 1 => -1 | 2 => 1 | 3 => -1

theorem sigT_eq (l a b : Fin m) (s : Fin 4) :
    sigT l a b s = sigA s * (if l = a then 1 else 0) + sigB s * (if l = b then 1 else 0) := by
  fin_cases s <;> simp only [sigT, sigA, sigB, Fin.isValue] <;> ring

theorem sum_dl2 (g : Fin m → ℝ) (a b : Fin m) (α β : ℝ) :
    ∑ l, g l * (α * (if l = a then 1 else 0) + β * (if l = b then 1 else 0)) = α * g a + β * g b := by
  simp only [mul_add, Finset.sum_add_distrib, mul_ite, mul_one, mul_zero, Finset.sum_ite_eq', Finset.mem_univ,
    if_true]
  ring

theorem quad_dl (A : Matrix (Fin m) (Fin m) ℝ) (a b : Fin m) (α β w : ℝ) :
    ∑ k, ∑ l, A l k * ((α * (if l = a then 1 else 0) + β * (if l = b then 1 else 0))
      * (α * (if k = a then 1 else 0) + β * (if k = b then 1 else 0)) * w)
      = w * (α ^ 2 * A a a + α * β * (A a b + A b a) + β ^ 2 * A b b) := by
  have h1 : ∀ k, ∑ l, A l k * ((α * (if l = a then 1 else 0) + β * (if l = b then 1 else 0))
      * (α * (if k = a then 1 else 0) + β * (if k = b then 1 else 0)) * w)
      = (α * A a k + β * A b k) * w * (α * (if k = a then 1 else 0) + β * (if k = b then 1 else 0)) := fun k => by
    rw [← sum_dl2 (fun l => A l k) a b α β, Finset.sum_mul, Finset.sum_mul]
    exact Finset.sum_congr rfl fun l _ => by ring
  rw [Finset.sum_congr rfl fun k _ => h1 k, sum_dl2 (fun k => (α * A a k + β * A b k) * w) a b α β]
  ring

/-- **`⟨(C # C) r_abs, r_abs⟩ = μ_abs (A_aa + A_bb ∓ 2A_ab) + (UU + VV)_ab` or `(UV + VU)_ab`.** -/
theorem sharpBil2_torus_root (A U V : Matrix (Fin m) (Fin m) ℝ) (hA : Aᵀ = A) (hU : IsPairWeights U)
    (hV : IsPairWeights V) (a b : Fin m) (hab : a ≠ b) (s : Fin 4) :
    sharpBil2 (torusOp A U V) (rootS a b s) (rootS a b s)
      = rootW U V a b s * (A a a + A b b + 2 * rsgn s * A a b) + rootPair U V a b s := by
  have hU' := hU
  have hV' := hV
  obtain ⟨hUt, hU0⟩ := hU
  obtain ⟨hVt, hV0⟩ := hV
  have hAs : ∀ x y, A y x = A x y := fun x y => by rw [← Matrix.transpose_apply A x y, hA]
  have hUs : ∀ x y, U y x = U x y := fun x y => by rw [← Matrix.transpose_apply U x y, hUt]
  have hVs : ∀ x y, V y x = V x y := fun x y => by rw [← Matrix.transpose_apply V x y, hVt]
  rw [sharpBil2_eq_crossPair2, crossPair2_torus A U V hUt hVt]
  have h1 : ∀ k l, inner2 ((torusOp A U V (brS (rootS a b s) (cartS l)) : skewSub (Fin m × Fin 2)) :
      Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) ((brS (rootS a b s) (cartS k) : skewSub (Fin m × Fin 2)) :
        Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) = sigT l a b s * sigT k a b s * rootW U V a b s := fun k l => by
    rw [brS_rootS_cartS l a b hab, brS_rootS_cartS k a b hab, map_smul, torusOp_rootS A U V hUt hVt a b hab,
      Submodule.coe_smul, Submodule.coe_smul, Submodule.coe_smul, i2_smul_l, i2_smul_l, i2_smul_r,
      rootS_norm a b hab, rootW_flip]
    ring
  have h2 : ∀ i j, (if i = j then (0 : ℝ) else ∑ t, rootW U V i j t *
      inner2 ((torusOp A U V (brS (rootS a b s) (rootS i j t)) : skewSub (Fin m × Fin 2)) :
        Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) ((brS (rootS a b s) (rootS i j t) : skewSub (Fin m × Fin 2)) :
          Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ))
      = dlt a i * dlt b j * Xf A U V a b s + dlt b i * dlt a j * Xf A U V a b s + dlt a i * Yf U V a b j s
        + dlt a j * Yf U V a b i s + dlt b i * Yf U V b a j s + dlt b j * Yf U V b a i s :=
    root_term A U V hU' hV' a b hab s
  simp only [h1, h2]
  -- the double sums of Kronecker terms
  have e2 : ∑ i, ∑ j, (dlt a i * dlt b j * Xf A U V a b s + dlt b i * dlt a j * Xf A U V a b s
      + dlt a i * Yf U V a b j s + dlt a j * Yf U V a b i s + dlt b i * Yf U V b a j s + dlt b j * Yf U V b a i s)
      = 2 * Xf A U V a b s + 2 * ∑ c, Yf U V a b c s + 2 * ∑ c, Yf U V b a c s := by
    simp only [Finset.sum_add_distrib]
    simp only [mul_assoc, ← Finset.mul_sum, sum_dlt_l, sum_dlt_r, Finset.sum_mul, ← Finset.sum_mul]
    simp [dlt, Finset.sum_ite_eq, mul_comm]
    ring
  rw [e2]
  have e1 : ∑ k, ∑ l, A l k * (sigT l a b s * sigT k a b s * rootW U V a b s)
      = rootW U V a b s * (A a a + A b b + 2 * rsgn s * A a b) := by
    simp only [sigT_eq, quad_dl]
    fin_cases s <;> simp only [sigA, sigB, rsgn, Fin.isValue] <;> rw [hAs b a] <;> norm_num <;> (try ring_nf) <;> (try simp)
  rw [e1]
  rw [Xf_closed A U V hA a b s, sumY U V hUt hVt a b s, sumY U V hUt hVt b a s, rootPair_symm U V hUt hVt]
  ring

/-- **The operator pairing in the torus-adapted basis.** -/
theorem innerOp2_torus (R S : CurvOp2 (Fin m × Fin 2)) :
    innerOp2 R S = ∑ k, inner2 ((R (cartS k) : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ)
        ((S (cartS k) : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ)
      + (1 / 2) * ∑ i, ∑ j, (if i = j then 0 else ∑ t,
        inner2 ((R (rootS i j t) : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ)
          ((S (rootS i j t) : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ)) := by
  let f : skewSub (Fin m × Fin 2) →ₗ[ℝ] skewSub (Fin m × Fin 2) →ₗ[ℝ] ℝ := LinearMap.mk₂ ℝ
    (fun W W' => inner2 ((R W : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ)
      ((S W' : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ))
    (fun W₁ W₂ W' => by simp only [map_add, Submodule.coe_add, i2_add_l])
    (fun c W W' => by simp only [map_smul, Submodule.coe_smul, i2_smul_l, smul_eq_mul])
    (fun W W₁' W₂' => by simp only [map_add, Submodule.coe_add, i2_add_r])
    (fun c W W' => by simp only [map_smul, Submodule.coe_smul, i2_smul_r, smul_eq_mul])
  have h : innerOp2 R S = (1 / 2) * ∑ p, ∑ q, f (phiS p q) (phiS p q) := rfl
  rw [h, torus_sum_change f]
  simp only [f, LinearMap.mk₂_apply]
  ring

theorem inner2_sum_l {κ : Type*} (s : Finset κ) (g : κ → Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ)
    (M : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) : inner2 (∑ l ∈ s, g l) M = ∑ l ∈ s, inner2 (g l) M := by
  unfold inner2; rw [Matrix.transpose_sum, Finset.sum_mul, Matrix.trace_sum, Finset.mul_sum]

/-- **`F(C, C, C)` on the torus family, before the index algebra**: the Cartan block pairs `A` with `A_μ`, and each
root vector contributes its weight times `⟨(C # C) r, r⟩`. -/
theorem Ftri_torus_raw (A U V : Matrix (Fin m) (Fin m) ℝ) (hA : Aᵀ = A) (hU : IsPairWeights U)
    (hV : IsPairWeights V) :
    Ftri (torusOp A U V) (torusOp A U V) (torusOp A U V)
      = ∑ k, ∑ l, A l k * Amu U V k l + (1 / 2) * ∑ i, ∑ j, (if i = j then 0 else ∑ t, rootW U V i j t *
          (rootW U V i j t * (A i i + A j j + 2 * rsgn t * A i j) + rootPair U V i j t)) := by
  have hU' := hU
  have hV' := hV
  obtain ⟨hUt, hU0⟩ := hU
  obtain ⟨hVt, hV0⟩ := hV
  rw [Ftri_sharp, innerOp2_torus]
  congr 1
  · refine Finset.sum_congr rfl fun k _ => ?_
    rw [torusOp_cartS, Submodule.coe_sum, inner2_sum_l]
    refine Finset.sum_congr rfl fun l _ => ?_
    rw [Submodule.coe_smul, i2_smul_l, inner2_comm, sharpMapCL_apply, inner2_sharpMap,
      sharpBil2_torus_cart A U V hU' hV' k l]
  · congr 1
    refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
    split_ifs with hij
    · rfl
    refine Finset.sum_congr rfl fun t _ => ?_
    rw [torusOp_rootS A U V hUt hVt i j hij, Submodule.coe_smul, i2_smul_l, inner2_comm, sharpMapCL_apply,
      inner2_sharpMap, sharpBil2_torus_root A U V hA hU' hV' i j hij]

theorem trace_mul_symm (X M : Matrix (Fin m) (Fin m) ℝ) (hM : Mᵀ = M) :
    Matrix.trace (X * M) = ∑ i, ∑ j, X i j * M i j := by
  simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply]
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  rw [← Matrix.transpose_apply M i j, hM]

/-- **L271 (1), the cubic**: `F(C, C, C) = 3 ∑ A_ii d_i - 3 ∑_{i ≠ j} A_ij P_ij Q_ij + ½ tr P³ + ½ tr Q³`. -/
theorem Ftri_torus (A U V : Matrix (Fin m) (Fin m) ℝ) (hA : Aᵀ = A) (hU : IsPairWeights U) (hV : IsPairWeights V) :
    Ftri (torusOp A U V) (torusOp A U V) (torusOp A U V)
      = 3 * ∑ i, A i i * dvec U V i - 3 * (∑ i, ∑ j, if i = j then 0 else A i j * (U + V) i j * (U - V) i j)
        + (1 / 2) * Matrix.trace ((U + V) * (U + V) * (U + V))
        + (1 / 2) * Matrix.trace ((U - V) * (U - V) * (U - V)) := by
  have hU' := hU
  have hV' := hV
  obtain ⟨hUt, hU0⟩ := hU
  obtain ⟨hVt, hV0⟩ := hV
  have hAs : ∀ x y, A y x = A x y := fun x y => by rw [← Matrix.transpose_apply A x y, hA]
  have hUs : ∀ x y, U y x = U x y := fun x y => by rw [← Matrix.transpose_apply U x y, hUt]
  have hVs : ∀ x y, V y x = V x y := fun x y => by rw [← Matrix.transpose_apply V x y, hVt]
  rw [Ftri_torus_raw A U V hA hU' hV']
  set M1 := U * U + V * V with hM1
  set M2 := U * V + V * U with hM2
  -- the four root terms of each pair
  have hG : ∀ i j, (if i = j then (0 : ℝ) else ∑ t, rootW U V i j t *
      (rootW U V i j t * (A i i + A j j + 2 * rsgn t * A i j) + rootPair U V i j t))
      = 2 * (U i j ^ 2 + V i j ^ 2) * A i i + 2 * (U i j ^ 2 + V i j ^ 2) * A j j
        + 4 * A i j * (V i j ^ 2 - U i j ^ 2) + 2 * (U i j * M1 i j + V i j * M2 i j) := fun i j => by
    split_ifs with h
    · subst h; simp [hU0, hV0]
    · simp only [Fin.sum_univ_four, rootW, rsgn, rootPair, Fin.isValue, hM1, hM2]
      norm_num
      ring
  simp only [hG]
  -- the Cartan pairing
  have hC : ∑ k, ∑ l, A l k * Amu U V k l = ∑ k, A k k * dvec U V k + ∑ k, ∑ l, A k l * (V k l ^ 2 - U k l ^ 2) := by
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [← Finset.add_sum_erase _ _ (Finset.mem_univ k), ← Finset.add_sum_erase _ _ (Finset.mem_univ k)]
    simp only [Amu, if_true, hU0, hV0, dvec]
    have : ∑ l ∈ Finset.univ.erase k, A l k * (if k = l then ∑ l, (U k l ^ 2 + V k l ^ 2) else V k l ^ 2 - U k l ^ 2)
        = ∑ l ∈ Finset.univ.erase k, A k l * (V k l ^ 2 - U k l ^ 2) :=
      Finset.sum_congr rfl fun l hl => by rw [if_neg (Ne.symm (Finset.ne_of_mem_erase hl)), hAs]
    rw [this]; ring
  have hd : ∀ i, ∑ j, (U i j ^ 2 + V i j ^ 2) * A i i = A i i * dvec U V i := fun i => by
    rw [← Finset.sum_mul, dvec]; ring
  have hd' : ∑ i, ∑ j, (U i j ^ 2 + V i j ^ 2) * A j j = ∑ i, A i i * dvec U V i := by
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [← Finset.sum_mul, dvec, mul_comm]
    congr 1
    exact Finset.sum_congr rfl fun i _ => by rw [hUs, hVs]
  have hPQ : ∑ i, ∑ j, (if i = j then 0 else A i j * (U + V) i j * (U - V) i j)
      = -∑ i, ∑ j, A i j * (V i j ^ 2 - U i j ^ 2) := by
    rw [← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun j _ => ?_
    split_ifs with h
    · subst h; simp [hU0, hV0]
    · simp only [Matrix.add_apply, Matrix.sub_apply]; ring
  have hM1s : M1ᵀ = M1 := by
    rw [hM1, Matrix.transpose_add, Matrix.transpose_mul, Matrix.transpose_mul, hUt, hVt]
  have hM2s : M2ᵀ = M2 := by
    rw [hM2, Matrix.transpose_add, Matrix.transpose_mul, Matrix.transpose_mul, hUt, hVt, add_comm]
  have hT : (1 / 2) * Matrix.trace ((U + V) * (U + V) * (U + V)) + (1 / 2) * Matrix.trace ((U - V) * (U - V) * (U - V))
      = ∑ i, ∑ j, (U i j * M1 i j + V i j * M2 i j) := by
    have key : (U + V) * (U + V) * (U + V) + (U - V) * (U - V) * (U - V)
        = (U * M1 + V * M2) + (U * M1 + V * M2) := by
      rw [hM1, hM2]; noncomm_ring
    rw [← mul_add, ← Matrix.trace_add, key, Matrix.trace_add, Matrix.trace_add, trace_mul_symm U M1 hM1s,
      trace_mul_symm V M2 hM2s]
    simp only [mul_add, Finset.mul_sum, ← Finset.sum_add_distrib]
    exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by ring
  simp only [Finset.sum_add_distrib, ← Finset.mul_sum] at *
  rw [hC, hPQ, add_assoc (3 * _ - _), hT]
  simp only [mul_assoc, ← Finset.mul_sum, Finset.sum_add_distrib, hd, hd']
  ring

/-- **L271 (1).** On the torus slice, `‖C‖² = ‖A‖² + ½‖P‖² + ½‖Q‖²` and
`F(C, C, C) = 3 ∑_i A_ii d_i - 3 ∑_{i ≠ j} A_ij P_ij Q_ij + ½ tr P³ + ½ tr Q³`, `P = U + V`, `Q = U - V`,
for every symmetric `A` and pair weights `U, V`. -/
theorem L271_F_slice (A U V : Matrix (Fin m) (Fin m) ℝ) (hA : Aᵀ = A) (hU : IsPairWeights U) (hV : IsPairWeights V) :
    let C := torusOp A U V
    let P := U + V
    let Q := U - V
    normSq2 C = (∑ i, ∑ j, A i j ^ 2) + (1 / 2) * (∑ i, ∑ j, P i j ^ 2) + (1 / 2) * (∑ i, ∑ j, Q i j ^ 2) ∧
    Ftri C C C = 3 * ∑ i, A i i * dvec U V i - 3 * (∑ i, ∑ j, if i = j then 0 else A i j * P i j * Q i j)
      + (1 / 2) * Matrix.trace (P * P * P) + (1 / 2) * Matrix.trace (Q * Q * Q) :=
  ⟨L271_norm A U V hU hV, Ftri_torus A U V hA hU hV⟩

local notation "SK" => skewSub (Fin m × Fin 2)
local notation "MM" => Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ

theorem skew_zero_of_inner (Z : SK) (h : inner2 (Z : MM) (Z : MM) = 0) : Z = 0 := by
  have h1 : toSk Z = 0 := inner_self_eq_zero.mp (by rw [inner_toSk]; exact h)
  exact Subtype.ext (show FrameExtension.toM (toSk Z) = 0 by rw [h1]; rfl)

/-- **A linear functional in the torus-adapted basis.** -/
theorem torus_expand (g : SK →ₗ[ℝ] ℝ) (Y : SK) :
    g Y = ∑ k, inner2 (Y : MM) ((cartS k : SK) : MM) * g (cartS k)
      + (1 / 2) * ∑ i, ∑ j, (if i = j then 0 else ∑ t, inner2 (Y : MM) ((rootS i j t : SK) : MM) * g (rootS i j t)) := by
  have h := sum_phi_inner_sub Y g
  let f : SK →ₗ[ℝ] SK →ₗ[ℝ] ℝ := LinearMap.mk₂ ℝ (fun W W' => inner2 (Y : MM) (W : MM) * g W')
    (fun W₁ W₂ W' => by simp only [Submodule.coe_add, i2_add_r, add_mul])
    (fun c W W' => by simp only [Submodule.coe_smul, i2_smul_r, smul_eq_mul, mul_assoc])
    (fun W W₁' W₂' => by simp only [map_add, mul_add])
    (fun c W W' => by simp only [map_smul, smul_eq_mul]; ring)
  have e : ∑ p, ∑ q, inner2 (Y : MM) (phi p q) * g ⟨phi p q, phi_mem_skewSub p q⟩
      = ∑ p, ∑ q, f (phiS p q) (phiS p q) := rfl
  rw [e, torus_sum_change f] at h
  simp only [f, LinearMap.mk₂_apply] at h
  linarith

/-- An operator vanishing on the adapted basis vanishes. -/
theorem op_zero_of_basis (T : CurvOp2 (Fin m × Fin 2)) (hJ : ∀ l, T (cartS l) = 0)
    (hr : ∀ i j t, i ≠ j → T (rootS i j t) = 0) : T = 0 := by
  refine ContinuousLinearMap.ext fun X => ?_
  let g : SK →ₗ[ℝ] ℝ :=
    { toFun := fun W => inner2 ((T W : SK) : MM) ((T X : SK) : MM)
      map_add' := fun W W' => by simp only [map_add, Submodule.coe_add, i2_add_l]
      map_smul' := fun c W => by simp only [map_smul, Submodule.coe_smul, i2_smul_l, smul_eq_mul, RingHom.id_apply] }
  have h := torus_expand g X
  have hz : ∀ W : SK, T W = 0 → g W = 0 := fun W hW => by
    show inner2 ((T W : SK) : MM) _ = 0
    rw [hW]; simp [inner2]
  have hg : g X = 0 := by
    rw [h]
    simp only [hz _ (hJ _), mul_zero, Finset.sum_const_zero, zero_add]
    rw [Finset.sum_eq_zero fun i _ => Finset.sum_eq_zero fun j _ => ?_]
    · ring
    split_ifs with hij
    · rfl
    · exact Finset.sum_eq_zero fun t _ => by rw [hz _ (hr i j t hij), mul_zero]
  exact skew_zero_of_inner _ hg

theorem Amu_symm (U V : Matrix (Fin m) (Fin m) ℝ) (hU : Uᵀ = U) (hV : Vᵀ = V) (k l : Fin m) :
    Amu U V l k = Amu U V k l := by
  unfold Amu
  by_cases h : k = l
  · subst h; rfl
  · rw [if_neg (Ne.symm h), if_neg h, ← Matrix.transpose_apply U k l, hU, ← Matrix.transpose_apply V k l, hV]

/-- **L268, forward**: a `#`-idempotent of the torus family has `A = A_μ` and solves the system. -/
theorem L268_forward (A U V : Matrix (Fin m) (Fin m) ℝ) (hA : Aᵀ = A) (hU : IsPairWeights U)
    (hV : IsPairWeights V) (hidem : IsIdem (torusOp A U V)) : A = Amu U V ∧ TorusSystem U V := by
  have key : ∀ X Y : SK, sharpBil2 (torusOp A U V) X Y = inner2 ((torusOp A U V X : SK) : MM) (Y : MM) :=
    fun X Y => by rw [← inner2_sharpMap, ← sharpMapCL_apply, hidem]
  have hAeq : A = Amu U V := by
    ext k l
    have h := key (cartS k) (cartS l)
    rw [sharpBil2_torus_cart A U V hU hV, inner2_torus_cart, ← Matrix.transpose_apply A k l, hA] at h
    exact h.symm
  refine ⟨hAeq, fun i j hij => ⟨?_, ?_⟩⟩
  · have h := key (rootS i j 0) (rootS i j 0)
    rw [sharpBil2_torus_root A U V hA hU hV i j hij] at h
    have h2 : inner2 ((torusOp A U V (rootS i j 0) : SK) : MM) ((rootS i j 0 : SK) : MM) = rootW U V i j 0 :=
      QF_root A U V hU.1 hV.1 i j hij 0
    rw [h2, hAeq] at h
    simp only [rootW, rsgn, rootPair, Fin.isValue] at h
    norm_num at h
    simp only [Amu, if_pos rfl, if_true, if_neg hij, dvec, Matrix.add_apply] at h ⊢
    linear_combination (-1 : ℝ) * h
  · have h := key (rootS i j 2) (rootS i j 2)
    rw [sharpBil2_torus_root A U V hA hU hV i j hij] at h
    have h2 : inner2 ((torusOp A U V (rootS i j 2) : SK) : MM) ((rootS i j 2 : SK) : MM) = rootW U V i j 2 :=
      QF_root A U V hU.1 hV.1 i j hij 2
    rw [h2, hAeq] at h
    simp only [rootW, rsgn, rootPair, Fin.isValue] at h
    norm_num at h
    simp only [Amu, if_pos rfl, if_true, if_neg hij, dvec, Matrix.add_apply] at h ⊢
    linear_combination (-1 : ℝ) * h

/-- A vector orthogonal to the adapted basis vanishes. -/
theorem vec_zero_of_basis (Z : SK) (hJ : ∀ k, inner2 (Z : MM) ((cartS k : SK) : MM) = 0)
    (hr : ∀ i j t, i ≠ j → inner2 (Z : MM) ((rootS i j t : SK) : MM) = 0) : Z = 0 := by
  let g : SK →ₗ[ℝ] ℝ :=
    { toFun := fun W => inner2 (Z : MM) (W : MM)
      map_add' := fun W W' => by simp only [Submodule.coe_add, i2_add_r]
      map_smul' := fun c W => by simp only [Submodule.coe_smul, i2_smul_r, smul_eq_mul, RingHom.id_apply] }
  have h := torus_expand g Z
  have hg : g Z = 0 := by
    rw [h]
    simp only [g, LinearMap.coe_mk, AddHom.coe_mk, hJ, mul_zero, Finset.sum_const_zero, zero_add]
    rw [Finset.sum_eq_zero fun i _ => Finset.sum_eq_zero fun j _ => ?_]
    · ring
    split_ifs with hij
    · rfl
    · exact Finset.sum_eq_zero fun t _ => by rw [hr i j t hij, mul_zero]
  exact skew_zero_of_inner _ hg

/-- **The torus operator is torus-invariant**: `[ad_{J_k}, C] = 0`. -/
theorem derOp_torusOp (A U V : Matrix (Fin m) (Fin m) ℝ) (hU : Uᵀ = U) (hV : Vᵀ = V) (k : Fin m) :
    derOp (cartS k) (torusOp A U V) = 0 := by
  refine op_zero_of_basis _ (fun l => ?_) (fun i j t hij => ?_)
  · rw [derOp_apply, torusOp_cartS, brS_sum_right, brS_cartS_cartS, map_zero, sub_zero]
    exact Finset.sum_eq_zero fun l' _ => by rw [brS_smul_right, brS_cartS_cartS, smul_zero]
  · rw [derOp_apply, torusOp_rootS A U V hU hV i j hij, brS_smul_right, brS_cartS_rootS k i j hij, map_smul,
      torusOp_rootS A U V hU hV i j hij, rootW_flip, smul_smul, smul_smul, mul_comm, sub_self]

/-- **The sharp of a torus-invariant operator is torus-invariant**, through the infinitesimal invariance of `F`. -/
theorem derOp_sharp (X : SK) (C : CurvOp2 (Fin m × Fin 2)) (hC : derOp X C = 0) :
    derOp X (sharpMapCL C) = 0 := by
  have h := Ftri_der X C C (derOp X (sharpMapCL C))
  rw [hC, Ftri_zero_left, Ftri_zero_mid, zero_add, zero_add, Ftri_sharp, innerOp2_derOp] at h
  exact normSq2_eq_zero (by unfold normSq2; linarith)

/-- The derivation of a torus-invariant operator commutes with `ad²`. -/
theorem inner2_ad2 (W : SK) (D : CurvOp2 (Fin m × Fin 2)) (hD : derOp W D = 0) (X Y : SK) :
    inner2 ((D (brS W (brS W X)) : SK) : MM) (Y : MM) = inner2 ((D X : SK) : MM) ((brS W (brS W Y) : SK) : MM) := by
  have hc : ∀ Z, D (brS W Z) = brS W (D Z) := fun Z => by
    have := congrArg (fun T : CurvOp2 (Fin m × Fin 2) => T Z) hD
    simp only [derOp_apply, ContinuousLinearMap.zero_apply] at this
    exact (sub_eq_zero.mp this).symm
  rw [hc, hc, inner2_brS_skew, inner2_brS_skew]
  ring

theorem sigT_flip (l i j : Fin m) (t : Fin 4) : sigT l i j (flipT t) = -sigT l i j t := by
  fin_cases t <;> simp only [sigT, flipT, Fin.isValue] <;> ring

theorem flipT_flipT (t : Fin 4) : flipT (flipT t) = t := by fin_cases t <;> rfl

/-- `ad_{J_x}²` on a root vector is `-σ²`. -/
theorem ad2_rootS (x i j : Fin m) (hij : i ≠ j) (t : Fin 4) :
    brS (cartS x) (brS (cartS x) (rootS i j t)) = (-(sigT x i j t ^ 2)) • rootS i j t := by
  rw [brS_cartS_rootS x i j hij, brS_smul_right, brS_cartS_rootS x i j hij, flipT_flipT, sigT_flip, smul_smul]
  congr 1; ring

theorem brS_zero_r (X : SK) : brS X 0 = 0 := by
  simpa using brS_smul_right (0 : ℝ) X 0

theorem ad2_cartS (x k : Fin m) : brS (cartS x) (brS (cartS x) (cartS k)) = 0 := by
  rw [brS_cartS_cartS, brS_zero_r]

/-- `ad_{J_x + J_y}²` on a root vector is `-(σ_x + σ_y)²`. -/
theorem ad2_pair_rootS (x y i j : Fin m) (hij : i ≠ j) (t : Fin 4) :
    brS (cartS x + cartS y) (brS (cartS x + cartS y) (rootS i j t))
      = (-((sigT x i j t + sigT y i j t) ^ 2)) • rootS i j t := by
  simp only [brS_add_left, brS_add_right, brS_cartS_rootS _ i j hij, brS_smul_right, flipT_flipT, sigT_flip,
    smul_smul, ← add_smul]
  congr 1; ring

theorem ad2_pair_cartS (x y k : Fin m) : brS (cartS x + cartS y) (brS (cartS x + cartS y) (cartS k)) = 0 := by
  simp only [brS_add_left, brS_cartS_cartS, add_zero, brS_zero_r]

theorem sep_of_ad2 (W : SK) (D : CurvOp2 (Fin m × Fin 2)) (hW : derOp W D = 0) (a b : ℝ) (e e' : SK)
    (he : brS W (brS W e) = a • e) (he' : brS W (brS W e') = b • e') (hab : a ≠ b) :
    inner2 ((D e : SK) : MM) (e' : MM) = 0 := by
  have h := inner2_ad2 W D hW e e'
  rw [he, he', map_smul, Submodule.coe_smul, Submodule.coe_smul, i2_smul_l, i2_smul_r] at h
  have : (a - b) * inner2 ((D e : SK) : MM) (e' : MM) = 0 := by linarith
  exact (mul_eq_zero.mp this).resolve_left (sub_ne_zero.mpr hab)

theorem sigT_self_sq (i j : Fin m) (hij : i ≠ j) (t : Fin 4) : sigT i i j t ^ 2 = 1 := by
  fin_cases t <;> simp [sigT, hij]

theorem sigT_self_sq' (i j : Fin m) (hij : i ≠ j) (t : Fin 4) : sigT j i j t ^ 2 = 1 := by
  fin_cases t <;> simp [sigT, hij, Ne.symm hij]

theorem sigT_out (x i j : Fin m) (hxi : x ≠ i) (hxj : x ≠ j) (t : Fin 4) : sigT x i j t = 0 := by
  fin_cases t <;> simp [sigT, hxi, hxj]

theorem derOp_add_left (X Y : SK) (R : CurvOp2 (Fin m × Fin 2)) :
    derOp (X + Y) R = derOp X R + derOp Y R := by
  refine ContinuousLinearMap.ext fun Z => ?_
  simp only [derOp_apply, ContinuousLinearMap.add_apply, brS_add_left, map_add]
  abel

theorem derOp_sub_right (X : SK) (R R' : CurvOp2 (Fin m × Fin 2)) :
    derOp X (R - R') = derOp X R - derOp X R' := by
  refine ContinuousLinearMap.ext fun Z => ?_
  simp only [derOp_apply, ContinuousLinearMap.sub_apply, brS_sub_right]
  abel

/-- **A self-adjoint torus-invariant operator is determined by its values on the adapted basis**: zero on the
Cartan block and on every root vector's own diagonal forces zero. -/
theorem torus_op_zero (D : CurvOp2 (Fin m × Fin 2)) (hD : ∀ x, derOp (cartS x) D = 0)
    (hsa : ∀ X Y : SK, inner2 ((D X : SK) : MM) (Y : MM) = inner2 (X : MM) ((D Y : SK) : MM))
    (hJJ : ∀ k l, inner2 ((D (cartS k) : SK) : MM) ((cartS l : SK) : MM) = 0)
    (hrr : ∀ i j t, i ≠ j → inner2 ((D (rootS i j t) : SK) : MM) ((rootS i j t : SK) : MM) = 0) : D = 0 := by
  have hD2 : ∀ x y, derOp (cartS x + cartS y) D = 0 := fun x y => by rw [derOp_add_left, hD, hD]; exact ContinuousLinearMap.ext fun _ => by simp
  -- Cartan against a root vector
  have hJr : ∀ k i j t, i ≠ j → inner2 ((D (cartS k) : SK) : MM) ((rootS i j t : SK) : MM) = 0 :=
    fun k i j t hij => sep_of_ad2 (cartS i) D (hD i) 0 (-(sigT i i j t ^ 2)) _ _
      (by rw [ad2_cartS, zero_smul]) (ad2_rootS i i j hij t) (by rw [sigT_self_sq i j hij]; norm_num)
  -- the rotation within a plane
  have hrot : ∀ i j t, i ≠ j → inner2 ((D (rootS i j t) : SK) : MM) ((rootS i j (flipT t) : SK) : MM) = 0 := by
    intro i j t hij
    have hc : ∀ Z, D (brS (cartS i) Z) = brS (cartS i) (D Z) := fun Z => by
      have := congrArg (fun T : CurvOp2 (Fin m × Fin 2) => T Z) (hD i)
      simp only [derOp_apply, ContinuousLinearMap.zero_apply] at this
      exact (sub_eq_zero.mp this).symm
    have h := inner2_brS_skew (cartS i) (D (rootS i j t)) (rootS i j t)
    rw [← hc, brS_cartS_rootS i i j hij, map_smul, Submodule.coe_smul, Submodule.coe_smul, i2_smul_l, i2_smul_r,
      hsa, inner2_comm] at h
    have hs : sigT i i j t ≠ 0 := fun h0 => by have := sigT_self_sq i j hij t; rw [h0] at this; norm_num at this
    have : 2 * sigT i i j t * inner2 ((D (rootS i j t) : SK) : MM) ((rootS i j (flipT t) : SK) : MM) = 0 := by
      linarith
    rcases mul_eq_zero.mp this with h1 | h1
    · exact absurd (by linarith : sigT i i j t = 0) hs
    · exact h1
  -- two root vectors of one plane
  have hsame : ∀ i j t u, i ≠ j → inner2 ((D (rootS i j t) : SK) : MM) ((rootS i j u : SK) : MM) = 0 := by
    intro i j t u hij
    have hpl : ∀ t : Fin 4, t.val < 2 → sigT i i j t + sigT j i j t = 0 := fun t ht => by
      fin_cases t <;> simp_all [sigT, Ne.symm hij]
    have hph : ∀ t : Fin 4, 2 ≤ t.val → (sigT i i j t + sigT j i j t) ^ 2 = 4 := fun t ht => by
      fin_cases t <;> simp_all [sigT, Ne.symm hij] <;> norm_num
    have hgrp : ∀ t u : Fin 4, t.val < 2 → 2 ≤ u.val →
        inner2 ((D (rootS i j t) : SK) : MM) ((rootS i j u : SK) : MM) = 0 := fun t u ht hu =>
      sep_of_ad2 _ D (hD2 i j) _ _ _ _ (ad2_pair_rootS i j i j hij t) (ad2_pair_rootS i j i j hij u) (by
        rw [hpl t ht, hph u hu]; norm_num)
    have hgrp' : ∀ t u : Fin 4, 2 ≤ t.val → u.val < 2 →
        inner2 ((D (rootS i j t) : SK) : MM) ((rootS i j u : SK) : MM) = 0 := fun t u ht hu => by
      rw [hsa, inner2_comm]; exact hgrp u t hu ht
    fin_cases t <;> fin_cases u
    · exact hrr i j 0 hij
    · exact hrot i j 0 hij
    · exact hgrp 0 2 (by decide) (by decide)
    · exact hgrp 0 3 (by decide) (by decide)
    · exact hrot i j 1 hij
    · exact hrr i j 1 hij
    · exact hgrp 1 2 (by decide) (by decide)
    · exact hgrp 1 3 (by decide) (by decide)
    · exact hgrp' 2 0 (by decide) (by decide)
    · exact hgrp' 2 1 (by decide) (by decide)
    · exact hrr i j 2 hij
    · exact hrot i j 2 hij
    · exact hgrp' 3 0 (by decide) (by decide)
    · exact hgrp' 3 1 (by decide) (by decide)
    · exact hrot i j 3 hij
    · exact hrr i j 3 hij
  refine op_zero_of_basis D (fun k => vec_zero_of_basis _ (hJJ k) (fun i j t hij => hJr k i j t hij))
    (fun i j t hij => vec_zero_of_basis _ (fun k => by rw [hsa, inner2_comm]; exact hJr k i j t hij) ?_)
  intro k l u hkl
  by_cases hki : k = i
  · subst hki
    by_cases hlj : l = j
    · subst hlj; exact hsame k l t u hij
    · exact sep_of_ad2 (cartS l) D (hD l) _ _ _ _ (ad2_rootS l k j hij t) (ad2_rootS l k l hkl u) (by
        rw [sigT_out l k j (Ne.symm hkl) hlj, sigT_self_sq' k l hkl]; norm_num)
  by_cases hkj : k = j
  · subst hkj
    by_cases hli : l = i
    · subst hli
      rw [rootS_swap l k u, Submodule.coe_smul, i2_smul_r, hsame l k t u hij, mul_zero]
    · exact sep_of_ad2 (cartS l) D (hD l) _ _ _ _ (ad2_rootS l i k hij t) (ad2_rootS l k l hkl u) (by
        rw [sigT_out l i k hli (Ne.symm hkl), sigT_self_sq' k l hkl]; norm_num)
  · exact sep_of_ad2 (cartS k) D (hD k) _ _ _ _ (ad2_rootS k i j hij t) (ad2_rootS k k l hkl u) (by
      rw [sigT_out k i j hki hkj, sigT_self_sq k l hkl]; norm_num)

/-- **L268, converse**: `A = A_μ` and a solution of the system give a `#`-idempotent. -/
theorem L268_converse (A U V : Matrix (Fin m) (Fin m) ℝ) (hA : Aᵀ = A) (hU : IsPairWeights U)
    (hV : IsPairWeights V) (hAeq : A = Amu U V) (hsys : TorusSystem U V) : IsIdem (torusOp A U V) := by
  set C := torusOp A U V with hC
  have hS : ∀ X Y : SK, inner2 ((sharpMapCL C X : SK) : MM) (Y : MM) = sharpBil2 C X Y := fun X Y => by
    rw [sharpMapCL_apply, inner2_sharpMap]
  have hsymm : ∀ X Y : SK, sharpBil2 C X Y = sharpBil2 C Y X := fun X Y => by
    rw [sharpBil2_eq_crossPair2, sharpBil2_eq_crossPair2, crossPair2_comm]
  have hCsa := torusOp_isSelfAdjoint2 A U V hA
  have hAs : ∀ x y, A y x = A x y := fun x y => by rw [← Matrix.transpose_apply A x y, hA]
  have hz := torus_op_zero (sharpMapCL C - C)
    (fun x => by rw [derOp_sub_right, derOp_sharp _ C (derOp_torusOp A U V hU.1 hV.1 x),
      derOp_torusOp A U V hU.1 hV.1 x]; exact ContinuousLinearMap.ext fun _ => by simp)
    (fun X Y => by
      simp only [ContinuousLinearMap.sub_apply, Submodule.coe_sub, i2_sub_l, i2_sub_r', hS]
      rw [hsymm, ← hS, inner2_comm, hCsa X Y])
    (fun k l => by
      simp only [ContinuousLinearMap.sub_apply, Submodule.coe_sub, i2_sub_l, hS]
      rw [sharpBil2_torus_cart A U V hU hV, inner2_torus_cart, hAeq, Amu_symm U V hU.1 hV.1]; ring)
    (fun i j t hij => by
      simp only [ContinuousLinearMap.sub_apply, Submodule.coe_sub, i2_sub_l, hS]
      rw [sharpBil2_torus_root A U V hA hU hV i j hij,
        show inner2 ((C (rootS i j t) : SK) : MM) ((rootS i j t : SK) : MM) = rootW U V i j t from
          QF_root A U V hU.1 hV.1 i j hij t]
      obtain ⟨h1, h2⟩ := hsys i j hij
      rw [hAeq]
      simp only [dvec, Matrix.add_apply] at h1 h2
      fin_cases t <;> simp only [rootW, rsgn, rootPair, Fin.isValue, Amu, if_pos rfl, if_neg hij, Matrix.add_apply] <;> norm_num
      · linear_combination (-1 : ℝ) * h1
      · linear_combination (-1 : ℝ) * h1
      · linear_combination (-1 : ℝ) * h2
      · linear_combination (-1 : ℝ) * h2)
  exact sub_eq_zero.mp hz

theorem L268_torus_idem_core (A U V : Matrix (Fin m) (Fin m) ℝ) (hA : Aᵀ = A) (hU : IsPairWeights U)
    (hV : IsPairWeights V) : IsIdem (torusOp A U V) ↔ (A = Amu U V ∧ TorusSystem U V) :=
  ⟨L268_forward A U V hA hU hV, fun h => L268_converse A U V hA hU hV h.1 h.2⟩

/-- **L268.** For `m ≥ 3`, symmetric `A` and pair weights `U, V`, the torus-invariant operator is a `#`-idempotent
exactly when `A = A_μ` and `(U, V)` solves the system. Positive definiteness is `L268_torus_pd` (⇐) and
`L268_pd_pos` (⇒). -/
theorem L268_torus_idem (hm : 3 ≤ m) (A U V : Matrix (Fin m) (Fin m) ℝ) (hA : Aᵀ = A) (hU : IsPairWeights U)
    (hV : IsPairWeights V) :
    IsIdem (torusOp A U V) ↔ (A = Amu U V ∧ TorusSystem U V) :=
  L268_torus_idem_core A U V hA hU hV

/-- Cauchy–Schwarz for double sums over `Fin m`. -/
theorem cs_double (f g : Fin m → Fin m → ℝ) :
    ∑ i, ∑ j, f i j * g i j ≤ Real.sqrt (∑ i, ∑ j, f i j ^ 2) * Real.sqrt (∑ i, ∑ j, g i j ^ 2) := by
  have e : ∀ h : Fin m → Fin m → ℝ, ∑ i, ∑ j, h i j = ∑ x : Fin m × Fin m, h x.1 x.2 := fun h =>
    (Fintype.sum_prod_type' h).symm
  rw [e (fun i j => f i j * g i j), e (fun i j => f i j ^ 2), e (fun i j => g i j ^ 2),
    ← Real.sqrt_mul (Finset.sum_nonneg fun x _ => sq_nonneg _)]
  have hcs := Finset.sum_mul_sq_le_sq_mul_sq Finset.univ (fun x : Fin m × Fin m => f x.1 x.2)
    (fun x => g x.1 x.2)
  exact le_trans (le_abs_self _) (Real.abs_le_sqrt hcs)

/-- **L273 (1).** `F(C) ≤ 3 ‖A‖ ‖A_μ‖ + ½(tr P³ + tr Q³)` on the torus slice. -/
theorem L273_F_bound_core (A U V : Matrix (Fin m) (Fin m) ℝ) (hA : Aᵀ = A) (hU : IsPairWeights U)
    (hV : IsPairWeights V) :
    Ftri (torusOp A U V) (torusOp A U V) (torusOp A U V)
      ≤ 3 * Real.sqrt (∑ i, ∑ j, A i j ^ 2) * Real.sqrt (∑ i, ∑ j, Amu U V i j ^ 2)
        + (1 / 2) * (Matrix.trace ((U + V) * (U + V) * (U + V)) + Matrix.trace ((U - V) * (U - V) * (U - V))) := by
  rw [Ftri_torus A U V hA hU hV]
  have hpair : 3 * ∑ i, A i i * dvec U V i - 3 * (∑ i, ∑ j, if i = j then 0 else A i j * (U + V) i j * (U - V) i j)
      = 3 * ∑ i, ∑ j, A i j * Amu U V i j := by
    have hpt : ∀ i j, A i j * Amu U V i j = (if i = j then A i i * dvec U V i else 0)
        - (if i = j then 0 else A i j * (U + V) i j * (U - V) i j) := fun i j => by
      by_cases h : i = j
      · subst h; simp [Amu, dvec]
      · simp only [Amu, if_neg h, Matrix.add_apply, Matrix.sub_apply, sub_zero, zero_sub]; ring
    simp only [hpt, Finset.sum_sub_distrib, Finset.sum_ite_eq, Finset.mem_univ, if_true]
    ring
  have hcs := cs_double A (Amu U V)
  linarith [hpair]
/-- The tangent line of `a ↦ (1 + a²)^{3/2}`: `s³ ≥ t³ + 3bt(a - b)` with `s = √(1+a²)`, `t = √(1+b²)`. -/
theorem cube_tangent (a b : ℝ) (hb : 0 ≤ b) :
    Real.sqrt (1 + b ^ 2) ^ 3 + 3 * b * Real.sqrt (1 + b ^ 2) * (a - b) ≤ Real.sqrt (1 + a ^ 2) ^ 3 := by
  set s := Real.sqrt (1 + a ^ 2) with hs
  set t := Real.sqrt (1 + b ^ 2) with ht
  have hs0 : 0 ≤ s := Real.sqrt_nonneg _
  have ht0 : 0 ≤ t := Real.sqrt_nonneg _
  have hs2 : s ^ 2 = 1 + a ^ 2 := Real.sq_sqrt (by positivity)
  have ht2 : t ^ 2 = 1 + b ^ 2 := Real.sq_sqrt (by positivity)
  have hst : 1 + a * b ≤ s * t := by
    have h1 : (1 + a * b) ^ 2 ≤ (s * t) ^ 2 := by rw [mul_pow, hs2, ht2]; nlinarith [sq_nonneg (a - b)]
    have h2 : 0 ≤ s * t := by positivity
    nlinarith [sq_nonneg (1 + a * b - s * t), sq_nonneg (1 + a * b + s * t)]
  have hamgm : 3 * s * t ^ 2 - 2 * t ^ 3 ≤ s ^ 3 := by
    nlinarith [mul_nonneg (sq_nonneg (s - t)) (by positivity : 0 ≤ s + 2 * t)]
  nlinarith [mul_le_mul_of_nonneg_left hst (by positivity : 0 ≤ 3 * t)]

set_option maxHeartbeats 1000000 in
/-- L273 (2) over abstract constants: `κ² t₀²(t₀² - 1) = 1/m` and `h ≥ 0` from `t₀` on give
`3ag + λ(1 - g²) ≤ κ (1 + a²)^{3/2}` for `g² ≥ 1/m`. -/
theorem psi_core (κ l t0 m a g : ℝ) (hκ0 : 0 < κ) (ht0 : 0 ≤ t0) (c1 : κ ^ 2 * t0 ^ 2 * (t0 ^ 2 - 1) = 1 / m)
    (hjh : ∀ t, t0 ≤ t → 0 ≤ HamiltonsCubic.I117.jh κ l t) (ha : 0 ≤ a) (hg0 : 0 < g) (hg2 : 1 / m ≤ g ^ 2) :
    3 * a * g + l * (1 - g ^ 2) ≤ κ * Real.sqrt (1 + a ^ 2) ^ 3 := by
  obtain ⟨r, hrdef⟩ : ∃ r, r = Real.sqrt (1 + 4 * g ^ 2 / κ ^ 2) := ⟨_, rfl⟩
  have hq : 0 ≤ 4 * g ^ 2 / κ ^ 2 := by positivity
  have hr : r ^ 2 = 1 + 4 * g ^ 2 / κ ^ 2 := by rw [hrdef]; exact Real.sq_sqrt (by linarith)
  have hr0 : 0 ≤ r := by rw [hrdef]; exact Real.sqrt_nonneg _
  have hr1 : 1 ≤ r := by nlinarith
  obtain ⟨u, hudef⟩ : ∃ u, u = (1 + r) / 2 := ⟨_, rfl⟩
  have hu1 : 1 ≤ u := by rw [hudef]; linarith
  have huu : κ ^ 2 * (u * (u - 1)) = g ^ 2 := by
    have e : u * (u - 1) = (r ^ 2 - 1) / 4 := by rw [hudef]; ring
    rw [e, hr]; field_simp; ring
  obtain ⟨t, htdef⟩ : ∃ t, t = Real.sqrt u := ⟨_, rfl⟩
  have ht2 : t ^ 2 = u := by rw [htdef]; exact Real.sq_sqrt (by linarith)
  have ht0' : 0 ≤ t := by rw [htdef]; exact Real.sqrt_nonneg _
  have ht1 : 1 ≤ t := by nlinarith
  obtain ⟨b, hbdef⟩ : ∃ b, b = Real.sqrt (u - 1) := ⟨_, rfl⟩
  have hb0 : 0 ≤ b := by rw [hbdef]; exact Real.sqrt_nonneg _
  have hb2 : b ^ 2 = u - 1 := by rw [hbdef]; exact Real.sq_sqrt (by linarith)
  have htb : Real.sqrt (1 + b ^ 2) = t := by rw [hb2, htdef]; congr 1; ring
  have hkbt : κ * b * t = g := by
    have h1 : (κ * b * t) ^ 2 = g ^ 2 := by rw [mul_pow, mul_pow, hb2, ht2]; nlinarith [huu]
    have h2 : 0 ≤ κ * b * t := by positivity
    nlinarith [sq_nonneg (κ * b * t - g), sq_nonneg (κ * b * t + g)]
  have htan := cube_tangent a b hb0
  rw [htb] at htan
  have ht0t : t0 ≤ t := by
    have hmono : t0 ^ 2 * (t0 ^ 2 - 1) ≤ t ^ 2 * (t ^ 2 - 1) := by
      have e2 : κ ^ 2 * (t ^ 2 * (t ^ 2 - 1)) = g ^ 2 := by rw [ht2]; exact huu
      have hk2 : 0 < κ ^ 2 := by positivity
      by_contra hcon
      push_neg at hcon
      have := mul_lt_mul_of_pos_left hcon hk2
      nlinarith
    have hsq : t0 ^ 2 ≤ t ^ 2 := by nlinarith [sq_nonneg (t0 ^ 2 - t ^ 2), ht1]
    exact (sq_le_sq₀ ht0 ht0').mp hsq
  have hj := hjh t ht0t
  simp only [HamiltonsCubic.I117.jh] at hj
  have hg2' : g ^ 2 = κ ^ 2 * t ^ 2 * (t ^ 2 - 1) := by rw [ht2]; linarith [huu]
  have hs := mul_le_mul_of_nonneg_left htan hκ0.le
  have hgb : κ * (3 * b * t * (a - b)) = 3 * a * g - 3 * κ * t * (t ^ 2 - 1) := by
    have : κ * b * t * b = κ * t * (t ^ 2 - 1) := by rw [show t ^ 2 - 1 = b ^ 2 by rw [hb2, ht2]]; ring
    linear_combination (3 * a - 3 * b) * hkbt + 0 * this - 3 * this + 3 * b * hkbt
  have hstep : 3 * a * g + κ * t * (3 - 2 * t ^ 2) ≤ κ * Real.sqrt (1 + a ^ 2) ^ 3 := by
    have e : κ * (t ^ 3 + 3 * b * t * (a - b)) = 3 * a * g + κ * t * (3 - 2 * t ^ 2) := by
      rw [mul_add, hgb]; ring
    linarith
  have hl : l * (1 - g ^ 2) ≤ κ * t * (3 - 2 * t ^ 2) := by rw [hg2']; nlinarith [hj]
  linarith

/-- **L273 (2), in closed form**: for `m ≥ 5`, `a ≥ 0` and `g ≥ 1/√m`, `3ag + λ_m(1 - g²) ≤ κ (1 + a²)^{3/2}`. -/
theorem psi_bound (m : ℝ) (hm : 5 ≤ m) (a g : ℝ) (ha : 0 ≤ a) (hg : 1 / Real.sqrt m ≤ g) :
    3 * a * g + Real.sqrt (2 * m) * (m - 2) / ((m - 1) * Real.sqrt (m - 1)) * (1 - g ^ 2)
      ≤ 2 * (m - 1) / Real.sqrt (m * (2 * m - 1)) * Real.sqrt (1 + a ^ 2) ^ 3 := by
  obtain ⟨c1, -, -, -⟩ := HamiltonsCubic.I117.jh_constants m (by linarith)
  have hsm : 0 < Real.sqrt m := Real.sqrt_pos.mpr (by linarith)
  have hg0 : 0 < g := lt_of_lt_of_le (by positivity) hg
  have hg2 : 1 / m ≤ g ^ 2 := by
    have : (1 / Real.sqrt m) ^ 2 = 1 / m := by rw [div_pow, Real.sq_sqrt (by linarith)]; ring
    rw [← this]; exact pow_le_pow_left₀ (by positivity) hg 2
  exact psi_core _ _ _ m a g (div_pos (by linarith) (Real.sqrt_pos.mpr (by nlinarith))) (Real.sqrt_nonneg _) c1
    (fun t ht => HamiltonsCubic.I117.jh_nonneg m t hm ht) ha hg0 hg2


theorem Amu_sq (U V : Matrix (Fin m) (Fin m) ℝ) :
    ∑ i, ∑ j, Amu U V i j ^ 2 = (∑ i, dvec U V i ^ 2)
      + ∑ i, ∑ j, (if i = j then 0 else ((U + V) i j * (U - V) i j) ^ 2) := by
  have hpt : ∀ i j, Amu U V i j ^ 2 = (if i = j then dvec U V i ^ 2 else 0)
      + (if i = j then 0 else ((U + V) i j * (U - V) i j) ^ 2) := fun i j => by
    by_cases h : i = j
    · subst h; simp [Amu, dvec]
    · simp only [Amu, if_neg h, Matrix.add_apply, Matrix.sub_apply, zero_add]; ring
  simp only [hpt, Finset.sum_add_distrib, Finset.sum_ite_eq, Finset.mem_univ, if_true]

theorem sum_dvec (U V : Matrix (Fin m) (Fin m) ℝ) :
    ∑ i, dvec U V i = (1 / 2 : ℝ) * ((∑ i, ∑ j, (U + V) i j ^ 2) + (∑ i, ∑ j, (U - V) i j ^ 2)) := by
  simp only [dvec, ← Finset.sum_add_distrib, Finset.mul_sum, Matrix.add_apply, Matrix.sub_apply]
  exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by ring

theorem trace_cube_smul (c : ℝ) (P : Matrix (Fin m) (Fin m) ℝ) :
    Matrix.trace ((c • P) * (c • P) * (c • P)) = c ^ 3 * Matrix.trace (P * P * P) := by
  simp only [Matrix.smul_mul, Matrix.mul_smul, smul_smul, Matrix.trace_smul, smul_eq_mul]; ring

/-- **L273 (3).** For `m ≥ 5`, J1 on the unit root sphere implies H on the torus slice. -/
theorem L273_J1_core (hm : 5 ≤ m)
    (J1 : ∀ U V : Matrix (Fin m) (Fin m) ℝ, IsPairWeights U → IsPairWeights V →
      (1 / 2 : ℝ) * ((∑ i, ∑ j, (U + V) i j ^ 2) + (∑ i, ∑ j, (U - V) i j ^ 2)) = 1 →
      (1 / 2 : ℝ) * (Matrix.trace ((U + V) * (U + V) * (U + V)) + Matrix.trace ((U - V) * (U - V) * (U - V)))
        + Real.sqrt (2 * m) * ((m : ℝ) - 2) / (((m : ℝ) - 1) * Real.sqrt ((m : ℝ) - 1))
          * ((∑ i, dvec U V i ^ 2) + ∑ i, ∑ j, if i = j then 0 else ((U + V) i j * (U - V) i j) ^ 2)
        ≤ Real.sqrt (2 * m) * ((m : ℝ) - 2) / (((m : ℝ) - 1) * Real.sqrt ((m : ℝ) - 1)))
    (A U V : Matrix (Fin m) (Fin m) ℝ) (hA : Aᵀ = A) (hU : IsPairWeights U) (hV : IsPairWeights V) :
    Ftri (torusOp A U V) (torusOp A U V) (torusOp A U V)
      ≤ 2 * ((m : ℝ) - 1) / Real.sqrt (m * (2 * m - 1)) * (normSq2 (torusOp A U V)) ^ ((3 : ℝ) / 2) := by
  have hmR : (5 : ℝ) ≤ m := by exact_mod_cast hm
  set l := Real.sqrt (2 * m) * ((m : ℝ) - 2) / (((m : ℝ) - 1) * Real.sqrt ((m : ℝ) - 1)) with hl
  set κ := 2 * ((m : ℝ) - 1) / Real.sqrt (m * (2 * m - 1)) with hκ
  have hκ0 : 0 < κ := div_pos (by linarith) (Real.sqrt_pos.mpr (by nlinarith))
  have hl0 : 0 < l := div_pos (mul_pos (Real.sqrt_pos.mpr (by linarith)) (by linarith))
    (mul_pos (by linarith) (Real.sqrt_pos.mpr (by linarith)))
  obtain ⟨SA, hSA⟩ : ∃ x, x = ∑ i, ∑ j, A i j ^ 2 := ⟨_, rfl⟩
  obtain ⟨b2, hb2⟩ : ∃ x, x = (1 / 2 : ℝ) * ((∑ i, ∑ j, (U + V) i j ^ 2) + (∑ i, ∑ j, (U - V) i j ^ 2)) := ⟨_, rfl⟩
  obtain ⟨G2, hG2⟩ : ∃ x, x = ∑ i, ∑ j, Amu U V i j ^ 2 := ⟨_, rfl⟩
  obtain ⟨T, hT⟩ : ∃ x, x = (1 / 2 : ℝ) * (Matrix.trace ((U + V) * (U + V) * (U + V))
      + Matrix.trace ((U - V) * (U - V) * (U - V))) := ⟨_, rfl⟩
  have hSA0 : 0 ≤ SA := by rw [hSA]; positivity
  have hb20 : 0 ≤ b2 := by rw [hb2]; positivity
  have hG20 : 0 ≤ G2 := by rw [hG2]; positivity
  have hN : normSq2 (torusOp A U V) = SA + b2 := by
    rw [L271_norm A U V hU hV, hSA, hb2]; ring
  have hFb := L273_F_bound_core A U V hA hU hV
  rw [← hSA, ← hG2] at hFb
  have hFb' : Ftri (torusOp A U V) (torusOp A U V) (torusOp A U V) ≤ 3 * Real.sqrt SA * Real.sqrt G2 + T := by
    rw [hT]; linarith
  have hpow : (SA + b2) ^ ((3 : ℝ) / 2) = Real.sqrt (SA + b2) ^ 3 := by
    rw [Real.sqrt_eq_rpow, ← Real.rpow_natCast, ← Real.rpow_mul (by linarith)]; norm_num
  rw [hN, hpow]
  rcases eq_or_lt_of_le hb20 with hb0 | hbpos
  · -- no root part: `U = V = 0`
    have hP : ∀ i j, (U + V) i j = 0 ∧ (U - V) i j = 0 := by
      have hs : (∑ i, ∑ j, (U + V) i j ^ 2) + (∑ i, ∑ j, (U - V) i j ^ 2) = 0 := by linarith
      have h1 := Finset.sum_nonneg (fun i (_ : i ∈ Finset.univ) =>
        Finset.sum_nonneg (fun j (_ : j ∈ Finset.univ) => sq_nonneg ((U + V) i j)))
      have h2 := Finset.sum_nonneg (fun i (_ : i ∈ Finset.univ) =>
        Finset.sum_nonneg (fun j (_ : j ∈ Finset.univ) => sq_nonneg ((U - V) i j)))
      have z1 : ∑ i, ∑ j, (U + V) i j ^ 2 = 0 := by linarith
      have z2 : ∑ i, ∑ j, (U - V) i j ^ 2 = 0 := by linarith
      intro i j
      have e1 := (Finset.sum_eq_zero_iff_of_nonneg (fun i _ => Finset.sum_nonneg fun j _ => sq_nonneg _)).mp z1 i
        (Finset.mem_univ i)
      have e2 := (Finset.sum_eq_zero_iff_of_nonneg (fun i _ => Finset.sum_nonneg fun j _ => sq_nonneg _)).mp z2 i
        (Finset.mem_univ i)
      have f1 := (Finset.sum_eq_zero_iff_of_nonneg (fun j _ => sq_nonneg _)).mp e1 j (Finset.mem_univ j)
      have f2 := (Finset.sum_eq_zero_iff_of_nonneg (fun j _ => sq_nonneg _)).mp e2 j (Finset.mem_univ j)
      exact ⟨pow_eq_zero_iff (n := 2) (by norm_num) |>.mp f1, pow_eq_zero_iff (n := 2) (by norm_num) |>.mp f2⟩
    have hU0 : U = 0 := by
      ext i j; have := hP i j; simp only [Matrix.add_apply, Matrix.sub_apply] at this
      simp only [Matrix.zero_apply]; linarith [this.1, this.2]
    have hV0 : V = 0 := by
      ext i j; have := hP i j; simp only [Matrix.add_apply, Matrix.sub_apply] at this
      simp only [Matrix.zero_apply]; linarith [this.1, this.2]
    have hF0 : Ftri (torusOp A U V) (torusOp A U V) (torusOp A U V) = 0 := by
      rw [Ftri_torus A U V hA hU hV, hU0, hV0]; simp [dvec]
    rw [hF0]; positivity
  · -- rescale the root weights to the unit sphere
    obtain ⟨b, hbdef⟩ : ∃ x, x = Real.sqrt b2 := ⟨_, rfl⟩
    have hb : 0 < b := by rw [hbdef]; exact Real.sqrt_pos.mpr hbpos
    have hbb : b ^ 2 = b2 := by rw [hbdef]; exact Real.sq_sqrt hb20
    set c := 1 / b with hc
    have hcb : c * b = 1 := by rw [hc]; field_simp
    have hU' : IsPairWeights (c • U) := ⟨by rw [Matrix.transpose_smul, hU.1], fun i => by simp [hU.2 i]⟩
    have hV' : IsPairWeights (c • V) := ⟨by rw [Matrix.transpose_smul, hV.1], fun i => by simp [hV.2 i]⟩
    have hsP : c • U + c • V = c • (U + V) := (smul_add c U V).symm
    have hsQ : c • U - c • V = c • (U - V) := (smul_sub c U V).symm
    have hunit : (1 / 2 : ℝ) * ((∑ i, ∑ j, (c • U + c • V) i j ^ 2) + (∑ i, ∑ j, (c • U - c • V) i j ^ 2)) = 1 := by
      rw [hsP, hsQ]
      simp only [Matrix.smul_apply, smul_eq_mul, mul_pow, ← Finset.mul_sum]
      rw [← mul_add, show (1 / 2 : ℝ) * (c ^ 2 * _) = c ^ 2 * b2 by rw [hb2]; ring, ← hbb]
      rw [← mul_pow, hcb, one_pow]
    have hJ := J1 (c • U) (c • V) hU' hV' hunit
    rw [hsP, hsQ, trace_cube_smul, trace_cube_smul] at hJ
    have hd : ∀ i, dvec (c • U) (c • V) i = c ^ 2 * dvec U V i := fun i => by
      simp only [dvec, Matrix.smul_apply, smul_eq_mul, Finset.mul_sum]
      exact Finset.sum_congr rfl fun l _ => by ring
    simp only [hd, Matrix.smul_apply, smul_eq_mul] at hJ
    have hG : (∑ i, (c ^ 2 * dvec U V i) ^ 2) + ∑ i, ∑ j, (if i = j then (0 : ℝ) else (c * (U + V) i j * (c * (U - V) i j)) ^ 2)
        = c ^ 4 * G2 := by
      rw [hG2, Amu_sq, mul_add, Finset.mul_sum, Finset.mul_sum]
      congr 1
      · exact Finset.sum_congr rfl fun i _ => by ring
      · refine Finset.sum_congr rfl fun i _ => ?_
        rw [Finset.mul_sum]
        refine Finset.sum_congr rfl fun j _ => ?_
        split_ifs <;> ring
    rw [hG] at hJ
    have hTJ : c ^ 3 * T + l * (c ^ 4 * G2) ≤ l := by rw [hT]; linarith
    -- so `T ≤ λ b³ - λ G/b`
    have hTb : T ≤ l * b ^ 3 - l * G2 / b := by
      have hb3 : 0 < b ^ 3 := by positivity
      have e : T = b ^ 3 * (c ^ 3 * T) := by rw [← mul_assoc, ← mul_pow, mul_comm b c, hcb, one_pow, one_mul]
      have e2 : l * G2 / b = b ^ 3 * (l * (c ^ 4 * G2)) := by
        rw [hc]; field_simp
      rw [e, e2]
      nlinarith [mul_le_mul_of_nonneg_left hTJ hb3.le]
    -- `g ≥ b² / √m`
    have hsumd : ∑ i, dvec U V i = b2 := by rw [sum_dvec, hb2]
    have hgm : b2 / Real.sqrt m ≤ Real.sqrt G2 := by
      have hcs : (∑ i, dvec U V i) ^ 2 ≤ m * ∑ i, dvec U V i ^ 2 := by
        have h := Finset.sum_mul_sq_le_sq_mul_sq Finset.univ (fun _ : Fin m => (1 : ℝ)) (fun i => dvec U V i)
        simpa using h
      have hdG : ∑ i, dvec U V i ^ 2 ≤ G2 := by
        rw [hG2, Amu_sq]; have : 0 ≤ ∑ i, ∑ j, (if i = j then (0 : ℝ) else ((U + V) i j * (U - V) i j) ^ 2) :=
          Finset.sum_nonneg fun i _ => Finset.sum_nonneg fun j _ => by split_ifs <;> positivity
        linarith
      rw [hsumd] at hcs
      have hsm : 0 < Real.sqrt m := Real.sqrt_pos.mpr (by linarith)
      rw [div_le_iff₀ hsm]
      have h1 : b2 ^ 2 ≤ (Real.sqrt G2 * Real.sqrt m) ^ 2 := by
        rw [mul_pow, Real.sq_sqrt hG20, Real.sq_sqrt (by linarith)]; nlinarith
      exact (sq_le_sq₀ hb20 (by positivity)).mp h1
    -- apply the closed form of (2) at `a = √SA / b`, `g' = √G2 / b²`
    have hpsi := psi_bound m hmR (Real.sqrt SA / b) (Real.sqrt G2 / b ^ 2) (by positivity) (by
      rw [le_div_iff₀ (by positivity), hbb]; rw [div_mul_eq_mul_div, one_mul] at *; linarith [hgm])
    have hs : Real.sqrt (1 + (Real.sqrt SA / b) ^ 2) * b = Real.sqrt (SA + b2) := by
      rw [div_pow, Real.sq_sqrt hSA0, ← hbb]
      have e : Real.sqrt (1 + SA / b ^ 2) * b = Real.sqrt ((1 + SA / b ^ 2) * b ^ 2) := by
        rw [Real.sqrt_mul (by positivity), Real.sqrt_sq hb.le]
      rw [e]; congr 1; field_simp; ring
    have hb3 : 0 < b ^ 3 := by positivity
    have hmain := mul_le_mul_of_nonneg_left hpsi hb3.le
    have lhs_eq : b ^ 3 * (3 * (Real.sqrt SA / b) * (Real.sqrt G2 / b ^ 2) + l * (1 - (Real.sqrt G2 / b ^ 2) ^ 2))
        = 3 * Real.sqrt SA * Real.sqrt G2 + l * b ^ 3 - l * G2 / b := by
      rw [div_pow, Real.sq_sqrt hG20]; field_simp; ring
    have rhs_eq : b ^ 3 * (κ * Real.sqrt (1 + (Real.sqrt SA / b) ^ 2) ^ 3) = κ * Real.sqrt (SA + b2) ^ 3 := by
      rw [← hs]; ring
    rw [lhs_eq, rhs_eq] at hmain
    linarith

/-- **L273 (1).** On the torus slice `F(C) ≤ 3 ‖A‖ ‖A_μ‖ + ½(tr P³ + tr Q³)`. The record's equality case (`A` a
non-negative multiple of `A_μ`) is `L273_F_eq` in [L273Owed.lean](L273Owed.lean). -/
theorem L273_F_bound {m : ℕ} (A U V : Matrix (Fin m) (Fin m) ℝ) (hA : Aᵀ = A) (hU : IsPairWeights U)
    (hV : IsPairWeights V) :
    Ftri (torusOp A U V) (torusOp A U V) (torusOp A U V)
      ≤ 3 * Real.sqrt (∑ i, ∑ j, A i j ^ 2) * Real.sqrt (∑ i, ∑ j, Amu U V i j ^ 2)
        + (1 / 2) * (Matrix.trace ((U + V) * (U + V) * (U + V)) + Matrix.trace ((U - V) * (U - V) * (U - V))) :=
  L273_F_bound_core A U V hA hU hV

/-- **L273 (3).** For `m ≥ 5`, J1 on the unit root sphere implies H on the torus slice:
`F(C, C, C) ≤ κ ‖C‖³` for every torus-invariant `C`, `κ = 2(m - 1)/√(m(2m - 1))`. -/
theorem L273_J1_implies_H (hm : 5 ≤ m)
    (J1 : ∀ U V : Matrix (Fin m) (Fin m) ℝ, IsPairWeights U → IsPairWeights V →
      (1 / 2 : ℝ) * ((∑ i, ∑ j, (U + V) i j ^ 2) + (∑ i, ∑ j, (U - V) i j ^ 2)) = 1 →
      (1 / 2 : ℝ) * (Matrix.trace ((U + V) * (U + V) * (U + V)) + Matrix.trace ((U - V) * (U - V) * (U - V)))
        + Real.sqrt (2 * m) * ((m : ℝ) - 2) / (((m : ℝ) - 1) * Real.sqrt ((m : ℝ) - 1))
          * ((∑ i, dvec U V i ^ 2) + ∑ i, ∑ j, if i = j then 0 else ((U + V) i j * (U - V) i j) ^ 2)
        ≤ Real.sqrt (2 * m) * ((m : ℝ) - 2) / (((m : ℝ) - 1) * Real.sqrt ((m : ℝ) - 1)))
    (A U V : Matrix (Fin m) (Fin m) ℝ) (hA : Aᵀ = A) (hU : IsPairWeights U) (hV : IsPairWeights V) :
    Ftri (torusOp A U V) (torusOp A U V) (torusOp A U V)
      ≤ 2 * ((m : ℝ) - 1) / Real.sqrt (m * (2 * m - 1)) * (normSq2 (torusOp A U V)) ^ ((3 : ℝ) / 2) :=
  L273_J1_core hm J1 A U V hA hU hV

/-- **L268's positivity clause, forward**: a positive-definite torus operator has every root weight positive, the
weight being `⟨C r, r⟩` on a unit root vector. -/
theorem L268_pd_pos (A U V : Matrix (Fin m) (Fin m) ℝ) (hU : IsPairWeights U) (hV : IsPairWeights V)
    (hpd : IsPD2 (torusOp A U V)) : ∀ i j, i ≠ j → 0 < U i j ∧ 0 < V i j := by
  intro i j hij
  have hne : ∀ t, rootS i j t ≠ 0 := fun t h => by
    have := rootS_norm i j hij t; rw [h] at this; simp [inner2] at this
  have h0 := hpd (rootS i j 0) (hne 0)
  have h2 := hpd (rootS i j 2) (hne 2)
  rw [show inner2 ((torusOp A U V (rootS i j 0) : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ)
      ((rootS i j 0 : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) = rootW U V i j 0 from
      QF_root A U V hU.1 hV.1 i j hij 0] at h0
  rw [show inner2 ((torusOp A U V (rootS i j 2) : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ)
      ((rootS i j 2 : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) = rootW U V i j 2 from
      QF_root A U V hU.1 hV.1 i j hij 2] at h2
  exact ⟨by simpa [rootW] using h0, by simpa [rootW] using h2⟩

theorem rootW_add (U V U' V' : Matrix (Fin m) (Fin m) ℝ) (i j : Fin m) (t : Fin 4) :
    rootW (U + U') (V + V') i j t = rootW U V i j t + rootW U' V' i j t := by
  unfold rootW; split_ifs <;> simp

/-- **The torus operator is additive in its data.** -/
theorem torusOp_add (A U V A' U' V' : Matrix (Fin m) (Fin m) ℝ) (hU : Uᵀ = U) (hV : Vᵀ = V) (hU' : U'ᵀ = U')
    (hV' : V'ᵀ = V') : torusOp A U V + torusOp A' U' V' = torusOp (A + A') (U + U') (V + V') := by
  have hUU : (U + U')ᵀ = U + U' := by rw [Matrix.transpose_add, hU, hU']
  have hVV : (V + V')ᵀ = V + V' := by rw [Matrix.transpose_add, hV, hV']
  have h := op_zero_of_basis (torusOp (A + A') (U + U') (V + V') - (torusOp A U V + torusOp A' U' V'))
    (fun l => by
      simp only [ContinuousLinearMap.sub_apply, ContinuousLinearMap.add_apply, torusOp_cartS, Matrix.add_apply,
        add_smul, Finset.sum_add_distrib, sub_self])
    (fun i j t hij => by
      simp only [ContinuousLinearMap.sub_apply, ContinuousLinearMap.add_apply, torusOp_rootS _ _ _ hUU hVV i j hij,
        torusOp_rootS _ _ _ hU hV i j hij, torusOp_rootS _ _ _ hU' hV' i j hij, rootW_add, add_smul, sub_self])
  exact (sub_eq_zero.mp h).symm

theorem sum_ite_diag (X : Fin m → Fin m → ℝ) (h : ∀ i, X i i = 0) :
    ∑ i, ∑ j, (if i = j then 0 else X i j) = ∑ i, ∑ j, X i j :=
  Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by
    by_cases hij : i = j
    · subst hij; simp [h]
    · simp [hij]

/-- **The identity inside L271 (4)'s proof.** -/
theorem L271_split_core (U V : Matrix (Fin m) (Fin m) ℝ) (hU : IsPairWeights U) (hV : IsPairWeights V)
    (hsys : TorusSystem U V) :
    torusOp (Amu U V) U V = torusOp (Matrix.diagonal (dvec U V)) ((1 / 2 : ℝ) • (U + V)) ((1 / 2 : ℝ) • (U + V))
        + torusOp (Amu U V - Matrix.diagonal (dvec U V)) ((1 / 2 : ℝ) • (U - V)) (-((1 / 2 : ℝ) • (U - V))) ∧
    innerOp2 (torusOp (Matrix.diagonal (dvec U V)) ((1 / 2 : ℝ) • (U + V)) ((1 / 2 : ℝ) • (U + V)))
        (torusOp (Amu U V - Matrix.diagonal (dvec U V)) ((1 / 2 : ℝ) • (U - V)) (-((1 / 2 : ℝ) • (U - V)))) = 0 ∧
    Ftri (torusOp (Amu U V) U V) (torusOp (Matrix.diagonal (dvec U V)) ((1 / 2 : ℝ) • (U + V)) ((1 / 2 : ℝ) • (U + V)))
        (torusOp (Amu U V - Matrix.diagonal (dvec U V)) ((1 / 2 : ℝ) • (U - V)) (-((1 / 2 : ℝ) • (U - V))))
      = (1 / 2) * normSq2 (torusOp (Amu U V - Matrix.diagonal (dvec U V)) ((1 / 2 : ℝ) • (U - V)) (-((1 / 2 : ℝ) • (U - V))))
        - (1 / 4) * Matrix.trace ((U - V) * (U - V) * (U - V)) := by
  obtain ⟨hUt, hU0⟩ := hU
  obtain ⟨hVt, hV0⟩ := hV
  set P := U + V with hP
  set Q := U - V with hQ
  set d := dvec U V with hd
  have hPt : Pᵀ = P := by rw [hP, Matrix.transpose_add, hUt, hVt]
  have hQt : Qᵀ = Q := by rw [hQ, Matrix.transpose_sub, hUt, hVt]
  have hP0 : ∀ i, P i i = 0 := fun i => by simp [hP, hU0, hV0]
  have hQ0 : ∀ i, Q i i = 0 := fun i => by simp [hQ, hU0, hV0]
  have hPs : ((1 / 2 : ℝ) • P)ᵀ = (1 / 2 : ℝ) • P := by rw [Matrix.transpose_smul, hPt]
  have hQs : ((1 / 2 : ℝ) • Q)ᵀ = (1 / 2 : ℝ) • Q := by rw [Matrix.transpose_smul, hQt]
  have hQn : (-((1 / 2 : ℝ) • Q))ᵀ = -((1 / 2 : ℝ) • Q) := by rw [Matrix.transpose_neg, hQs]
  have hDt : (Matrix.diagonal d)ᵀ = Matrix.diagonal d := Matrix.diagonal_transpose d
  have hAmt : (Amu U V)ᵀ = Amu U V := by ext k l; rw [Matrix.transpose_apply, Amu_symm U V hUt hVt]
  have hAdt : (Amu U V - Matrix.diagonal d)ᵀ = Amu U V - Matrix.diagonal d := by rw [Matrix.transpose_sub, hAmt, hDt]
  have hsum : torusOp (Amu U V) U V = torusOp (Matrix.diagonal d) ((1 / 2 : ℝ) • P) ((1 / 2 : ℝ) • P)
      + torusOp (Amu U V - Matrix.diagonal d) ((1 / 2 : ℝ) • Q) (-((1 / 2 : ℝ) • Q)) := by
    rw [torusOp_add _ _ _ _ _ _ hPs hPs hQs hQn]
    congr 1
    · abel
    · ext i j; simp [hP, hQ]; ring
    · ext i j; simp [hP, hQ]; ring
  refine ⟨hsum, ?_, ?_⟩
  · rw [innerOp2_torusOp _ _ _ _ _ _ hPs hPs hQs hQn]
    have h1 : ∑ k, ∑ t, Matrix.diagonal d k t * (Amu U V - Matrix.diagonal d) k t = 0 :=
      Finset.sum_eq_zero fun k _ => Finset.sum_eq_zero fun t _ => by
        by_cases h : k = t
        · subst h; simp [Amu, hd, dvec]
        · simp [Matrix.diagonal_apply_ne _ h]
    have h2 : ∑ k, ∑ l, (if k = l then (0 : ℝ) else ((1 / 2 : ℝ) • P) k l * ((1 / 2 : ℝ) • Q) k l
        + ((1 / 2 : ℝ) • P) k l * (-((1 / 2 : ℝ) • Q)) k l) = 0 :=
      Finset.sum_eq_zero fun k _ => Finset.sum_eq_zero fun l _ => by split_ifs <;> simp <;> ring
    rw [h1, h2, add_zero]
  · -- polarise the cubic
    set CP := torusOp (Matrix.diagonal d) ((1 / 2 : ℝ) • P) ((1 / 2 : ℝ) • P) with hCP
    set CQ := torusOp (Amu U V - Matrix.diagonal d) ((1 / 2 : ℝ) • Q) (-((1 / 2 : ℝ) • Q)) with hCQ
    have saP : IsSelfAdjoint2 CP := torusOp_isSelfAdjoint2 _ _ _ hDt
    have saQ : IsSelfAdjoint2 CQ := torusOp_isSelfAdjoint2 _ _ _ hAdt
    have hline := Ftri_line saP saQ 1
    rw [one_smul, ← hsum] at hline
    have hpol : Ftri (torusOp (Amu U V) U V) CP CQ
        = (1 / 3) * (Ftri (torusOp (Amu U V) U V) (torusOp (Amu U V) U V) (torusOp (Amu U V) U V)
          - Ftri CP CP CP - Ftri CQ CQ CQ) := by
      rw [hsum, Ftri_add_left, Ftri_symm12 saQ (A := CQ) (B := CP)]
      rw [← hsum]; linarith
    have hPP : (1 / 2 : ℝ) • P + (1 / 2 : ℝ) • P = P := by rw [← add_smul]; norm_num
    have hPm : (1 / 2 : ℝ) • P - (1 / 2 : ℝ) • P = 0 := sub_self _
    have hQp : (1 / 2 : ℝ) • Q + -((1 / 2 : ℝ) • Q) = 0 := add_neg_cancel _
    have hQm : (1 / 2 : ℝ) • Q - -((1 / 2 : ℝ) • Q) = Q := by rw [sub_neg_eq_add, ← add_smul]; norm_num
    have fC := Ftri_torus (Amu U V) U V hAmt ⟨hUt, hU0⟩ ⟨hVt, hV0⟩
    have fP := Ftri_torus (Matrix.diagonal d) ((1 / 2 : ℝ) • P) ((1 / 2 : ℝ) • P) hDt
      ⟨hPs, fun i => by simp [hP0]⟩ ⟨hPs, fun i => by simp [hP0]⟩
    have fQ := Ftri_torus (Amu U V - Matrix.diagonal d) ((1 / 2 : ℝ) • Q) (-((1 / 2 : ℝ) • Q)) hAdt
      ⟨hQs, fun i => by simp [hQ0]⟩ ⟨hQn, fun i => by simp [hQ0]⟩
    rw [hPP, hPm] at fP
    rw [hQp, hQm] at fQ
    have nQ := L271_norm (Amu U V - Matrix.diagonal d) ((1 / 2 : ℝ) • Q) (-((1 / 2 : ℝ) • Q))
      ⟨hQs, fun i => by simp [hQ0]⟩ ⟨hQn, fun i => by simp [hQ0]⟩
    rw [hQp, hQm] at nQ
    rw [← hP, ← hQ, ← hd] at fC
    rw [hpol, fC, fP, fQ, nQ]
    -- the index algebra
    have dP : ∀ i, dvec ((1 / 2 : ℝ) • P) ((1 / 2 : ℝ) • P) i = (1 / 2) * ∑ l, P i l ^ 2 := fun i => by
      simp only [dvec, Matrix.smul_apply, smul_eq_mul, Finset.mul_sum]
      exact Finset.sum_congr rfl fun l _ => by ring
    have dd : ∀ i, d i = (1 / 2) * (∑ l, P i l ^ 2 + ∑ l, Q i l ^ 2) := fun i => by
      simp only [hd, dvec, hP, hQ, Matrix.add_apply, Matrix.sub_apply, ← Finset.sum_add_distrib, Finset.mul_sum]
      exact Finset.sum_congr rfl fun l _ => by ring
    have hAmuoff : ∀ i j, i ≠ j → Amu U V i j = -(P i j * Q i j) := fun i j h => by
      simp only [Amu, if_neg h, hP, hQ, Matrix.add_apply, Matrix.sub_apply]; ring
    have hAd : ∀ i, (Amu U V - Matrix.diagonal d) i i = 0 := fun i => by simp [Amu, hd, dvec]
    -- the Q equation contracted with Q
    have hQeq : ∀ i j, i ≠ j → Q i j * (1 - d i - d j - 2 * P i j ^ 2) = (Q * Q) i j := fun i j h =>
      ((L271_pq_system U V).mp hsys i j h).2
    have hcon : ∑ i, ∑ j, Q i j ^ 2 * (1 - d i - d j - 2 * P i j ^ 2) = Matrix.trace (Q * Q * Q) := by
      rw [Matrix.mul_assoc, trace_mul_symm Q (Q * Q) (by rw [Matrix.transpose_mul, hQt])]
      refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
      by_cases h : i = j
      · subst h; rw [hQ0]; simp
      · rw [← hQeq i j h]; ring
    have hsym2 : ∑ i, ∑ j, Q i j ^ 2 * d j = ∑ i, d i * ∑ j, Q i j ^ 2 := by
      rw [Finset.sum_comm]
      refine Finset.sum_congr rfl fun j _ => ?_
      rw [Finset.mul_sum]
      exact Finset.sum_congr rfl fun i _ => by rw [← Matrix.transpose_apply Q j i, hQt]; ring
    -- rewrite every `ite` sum and every diagonal sum
    have e1 : ∑ i, Amu U V i i * d i = ∑ i, d i * d i := Finset.sum_congr rfl fun i _ => by simp [Amu, hd, dvec]
    have e2 : ∑ i, ∑ j, (if i = j then 0 else Amu U V i j * P i j * Q i j) = -∑ i, ∑ j, (P i j * Q i j) ^ 2 := by
      rw [← Finset.sum_neg_distrib]
      refine Finset.sum_congr rfl fun i _ => ?_
      rw [← Finset.sum_neg_distrib]
      refine Finset.sum_congr rfl fun j _ => ?_
      by_cases h : i = j
      · subst h; simp [hP0]
      · rw [if_neg h, hAmuoff i j h]; ring
    have e3 : ∑ i, Matrix.diagonal d i i * dvec ((1 / 2 : ℝ) • P) ((1 / 2 : ℝ) • P) i
        = ∑ i, d i * ((1 / 2) * ∑ l, P i l ^ 2) := Finset.sum_congr rfl fun i _ => by rw [dP]; simp
    have e4 : ∑ i, ∑ j, (if i = j then (0 : ℝ) else Matrix.diagonal d i j * P i j * (0 : Matrix (Fin m) (Fin m) ℝ) i j) = 0 :=
      Finset.sum_eq_zero fun i _ => Finset.sum_eq_zero fun j _ => by simp
    have e5 : ∑ i, (Amu U V - Matrix.diagonal d) i i * dvec ((1 / 2 : ℝ) • Q) (-((1 / 2 : ℝ) • Q)) i = 0 :=
      Finset.sum_eq_zero fun i _ => by rw [hAd, zero_mul]
    have e6 : ∑ i, ∑ j, (if i = j then (0 : ℝ) else (Amu U V - Matrix.diagonal d) i j
        * (0 : Matrix (Fin m) (Fin m) ℝ) i j * Q i j) = 0 :=
      Finset.sum_eq_zero fun i _ => Finset.sum_eq_zero fun j _ => by simp
    have e7 : ∑ i, ∑ j, (Amu U V - Matrix.diagonal d) i j ^ 2 = ∑ i, ∑ j, (P i j * Q i j) ^ 2 :=
      Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by
        by_cases h : i = j
        · subst h; rw [hAd, hP0]; ring
        · rw [Matrix.sub_apply, Matrix.diagonal_apply_ne _ h, sub_zero, hAmuoff i j h]; ring
    have e8 : Matrix.trace ((0 : Matrix (Fin m) (Fin m) ℝ) * 0 * 0) = 0 := by simp
    have e9 : ∑ i, ∑ j, (0 : Matrix (Fin m) (Fin m) ℝ) i j ^ 2 = 0 := by simp
    rw [e1, e2, e3, e4, e5, e6, e7, e8, e9]
    have hexp : ∑ i, ∑ j, Q i j ^ 2 * (1 - d i - d j - 2 * P i j ^ 2)
        = ∑ i, ∑ j, Q i j ^ 2 - ∑ i, d i * ∑ j, Q i j ^ 2 - ∑ i, ∑ j, Q i j ^ 2 * d j
          - 2 * ∑ i, ∑ j, (P i j * Q i j) ^ 2 := by
      simp only [Finset.mul_sum, ← Finset.sum_sub_distrib]
      exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by ring
    rw [hsym2] at hexp
    have hdd : ∑ i, d i * d i - ∑ i, d i * ((1 / 2) * ∑ l, P i l ^ 2) = ∑ i, d i * ((1 / 2) * ∑ l, Q i l ^ 2) := by
      rw [← Finset.sum_sub_distrib]
      exact Finset.sum_congr rfl fun i _ => by rw [dd i]; ring
    rw [← hcon, hexp]
    have : ∑ i, d i * ((1 / 2) * ∑ l, Q i l ^ 2) = (1 / 2) * ∑ i, d i * ∑ j, Q i j ^ 2 := by
      rw [Finset.mul_sum]; exact Finset.sum_congr rfl fun i _ => by ring
    linarith [hdd, this]


theorem torusOp_smul (c : ℝ) (A U V : Matrix (Fin m) (Fin m) ℝ) (hU : Uᵀ = U) (hV : Vᵀ = V) :
    c • torusOp A U V = torusOp (c • A) (c • U) (c • V) := by
  have hcU : (c • U)ᵀ = c • U := by rw [Matrix.transpose_smul, hU]
  have hcV : (c • V)ᵀ = c • V := by rw [Matrix.transpose_smul, hV]
  have h := op_zero_of_basis (torusOp (c • A) (c • U) (c • V) - c • torusOp A U V)
    (fun l => by
      simp only [ContinuousLinearMap.sub_apply, ContinuousLinearMap.smul_apply, torusOp_cartS, Matrix.smul_apply,
        smul_eq_mul, Finset.smul_sum, smul_smul, sub_self])
    (fun i j t hij => by
      simp only [ContinuousLinearMap.sub_apply, ContinuousLinearMap.smul_apply, torusOp_rootS _ _ _ hcU hcV i j hij,
        torusOp_rootS _ _ _ hU hV i j hij, smul_smul]
      rw [show rootW (c • U) (c • V) i j t = c * rootW U V i j t by unfold rootW; split_ifs <;> simp, sub_self])
  exact (sub_eq_zero.mp h).symm

/-- **`F(C, X, X)` by polarisation of the cubic.** -/
theorem Ftri_pol {C X : CurvOp2 (Fin m × Fin 2)} (hC : IsSelfAdjoint2 C) (hX : IsSelfAdjoint2 X) :
    Ftri C X X = (Ftri (C + X) (C + X) (C + X) + Ftri (C + (-1 : ℝ) • X) (C + (-1 : ℝ) • X) (C + (-1 : ℝ) • X)
      - 2 * Ftri C C C) / 6 := by
  have h1 := Ftri_line hC hX 1
  have h2 := Ftri_line hC hX (-1)
  rw [one_smul] at h1
  rw [h1, h2]; ring

theorem zero_pw : IsPairWeights (0 : Matrix (Fin m) (Fin m) ℝ) := ⟨by simp, fun i => by simp⟩

theorem onesOff_pw : IsPairWeights (onesOff m) := ⟨onesOff_symm, fun i => by simp [onesOff]⟩

/-- `F(C, I_t, I_t) = 0` on the torus family, `I_t = torusOp 1 0 0` the Cartan identity. -/
theorem Ftri_It (A U V : Matrix (Fin m) (Fin m) ℝ) (hA : Aᵀ = A) (hU : IsPairWeights U) (hV : IsPairWeights V) :
    Ftri (torusOp A U V) (torusOp 1 0 0) (torusOp 1 0 0) = 0 := by
  have h0 : (0 : Matrix (Fin m) (Fin m) ℝ)ᵀ = 0 := by simp
  rw [Ftri_pol (torusOp_isSelfAdjoint2 A U V hA) (torusOp_isSelfAdjoint2 1 0 0 (by simp)),
    torusOp_smul _ _ _ _ h0 h0]
  simp only [smul_zero]
  rw [torusOp_add _ _ _ _ _ _ hU.1 hV.1 h0 h0, torusOp_add _ _ _ _ _ _ hU.1 hV.1 h0 h0]
  simp only [add_zero]
  have hA1 : (A + 1)ᵀ = A + 1 := by rw [Matrix.transpose_add, hA, Matrix.transpose_one]
  have hA2 : (A + (-1 : ℝ) • 1)ᵀ = A + (-1 : ℝ) • 1 := by
    rw [Matrix.transpose_add, hA, Matrix.transpose_smul, Matrix.transpose_one]
  rw [Ftri_torus _ U V hA1 hU hV, Ftri_torus _ U V hA2 hU hV, Ftri_torus A U V hA hU hV]
  have s1 : ∑ i, (A + 1) i i * dvec U V i + ∑ i, (A + (-1 : ℝ) • 1) i i * dvec U V i = 2 * ∑ i, A i i * dvec U V i := by
    rw [← Finset.sum_add_distrib, Finset.mul_sum]
    exact Finset.sum_congr rfl fun i _ => by simp; ring
  have s2 : ∑ i, ∑ j, (if i = j then (0 : ℝ) else (A + 1) i j * (U + V) i j * (U - V) i j)
      + ∑ i, ∑ j, (if i = j then (0 : ℝ) else (A + (-1 : ℝ) • 1) i j * (U + V) i j * (U - V) i j)
      = 2 * ∑ i, ∑ j, (if i = j then (0 : ℝ) else A i j * (U + V) i j * (U - V) i j) := by
    simp only [← Finset.sum_add_distrib, Finset.mul_sum]
    exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by
      split_ifs with h
      · simp
      · simp [Matrix.one_apply_ne h]; ring
  linarith

/-- `F(C, I_R, I_R)` on the torus family, `I_R = torusOp 0 J J` the root identity. -/
theorem Ftri_IR (A U V : Matrix (Fin m) (Fin m) ℝ) (hA : Aᵀ = A) (hU : IsPairWeights U) (hV : IsPairWeights V) :
    Ftri (torusOp A U V) (torusOp 0 (onesOff m) (onesOff m)) (torusOp 0 (onesOff m) (onesOff m))
      = 2 * ((m : ℝ) - 1) * ∑ i, A i i + 2 * ((m : ℝ) - 2) * ∑ i, ∑ j, (U + V) i j := by
  have hJ := onesOff_symm (m := m)
  have hJn : (-onesOff m)ᵀ = -onesOff m := by rw [Matrix.transpose_neg, hJ]
  rw [Ftri_pol (torusOp_isSelfAdjoint2 A U V hA) (torusOp_isSelfAdjoint2 0 _ _ (by simp)),
    torusOp_smul _ _ _ _ hJ hJ, torusOp_add _ _ _ _ _ _ hU.1 hV.1 hJ hJ,
    torusOp_add _ _ _ _ _ _ hU.1 hV.1 (by rw [Matrix.transpose_smul, hJ]) (by rw [Matrix.transpose_smul, hJ])]
  simp only [smul_zero, add_zero]
  have pw1 : IsPairWeights (U + onesOff m) := ⟨by rw [Matrix.transpose_add, hU.1, hJ], fun i => by simp [hU.2, onesOff]⟩
  have pw2 : IsPairWeights (V + onesOff m) := ⟨by rw [Matrix.transpose_add, hV.1, hJ], fun i => by simp [hV.2, onesOff]⟩
  have pw3 : IsPairWeights (U + (-1 : ℝ) • onesOff m) :=
    ⟨by rw [Matrix.transpose_add, hU.1, Matrix.transpose_smul, hJ], fun i => by simp [hU.2, onesOff]⟩
  have pw4 : IsPairWeights (V + (-1 : ℝ) • onesOff m) :=
    ⟨by rw [Matrix.transpose_add, hV.1, Matrix.transpose_smul, hJ], fun i => by simp [hV.2, onesOff]⟩
  rw [Ftri_torus A _ _ hA pw1 pw2, Ftri_torus A _ _ hA pw3 pw4, Ftri_torus A U V hA hU hV]
  set J := onesOff m with hJdef
  set P := U + V with hP
  set Q := U - V with hQ
  have eP1 : U + J + (V + J) = P + (2 : ℝ) • J := by rw [hP, two_smul]; abel
  have eP2 : U + (-1 : ℝ) • J + (V + (-1 : ℝ) • J) = P + (-2 : ℝ) • J := by
    rw [hP, show (-2 : ℝ) = -1 + -1 by norm_num, add_smul]; abel
  have eQ1 : U + J - (V + J) = Q := by rw [hQ]; abel
  have eQ2 : U + (-1 : ℝ) • J - (V + (-1 : ℝ) • J) = Q := by rw [hQ]; abel
  rw [eP1, eP2, eQ1, eQ2]
  have hJ0 : ∀ i, J i i = 0 := fun i => by simp [hJdef, onesOff]
  have hJ1 : ∀ i j, i ≠ j → J i j = 1 := fun i j h => by simp [hJdef, onesOff, h]
  have hP0 : ∀ i, P i i = 0 := fun i => by simp [hP, hU.2, hV.2]
  -- the Cartan terms
  have hd : ∀ (s : ℝ) i, dvec (U + s • J) (V + s • J) i = dvec U V i + 2 * s * ∑ l, P i l * J i l + 2 * s ^ 2 * ∑ l, J i l ^ 2 := by
    intro s i
    simp only [dvec, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul, hP, Finset.mul_sum, ← Finset.sum_add_distrib]
    exact Finset.sum_congr rfl fun l _ => by ring
  have hdd : ∀ i, dvec (U + J) (V + J) i + dvec (U + (-1 : ℝ) • J) (V + (-1 : ℝ) • J) i - 2 * dvec U V i
      = 4 * ((m : ℝ) - 1) := fun i => by
    have h1 := hd 1 i
    rw [one_smul] at h1
    rw [h1, hd (-1) i]
    have : ∑ l, J i l ^ 2 = ((m : ℝ) - 1) * 1 :=
      sum_off_one i 1 _ (fun l hl => by rw [hJ1 i l (Ne.symm hl)]; norm_num) (by rw [hJ0]; norm_num)
    rw [this]; ring
  have sA : ∑ i, A i i * dvec (U + J) (V + J) i + ∑ i, A i i * dvec (U + (-1 : ℝ) • J) (V + (-1 : ℝ) • J) i
      - 2 * ∑ i, A i i * dvec U V i = 4 * ((m : ℝ) - 1) * ∑ i, A i i := by
    rw [Finset.mul_sum, Finset.mul_sum, ← Finset.sum_add_distrib, ← Finset.sum_sub_distrib]
    exact Finset.sum_congr rfl fun i _ => by rw [← mul_assoc, mul_comm _ (A i i), ← hdd i]; ring
  -- the mixed terms are linear in `P`
  have sM : ∑ i, ∑ j, (if i = j then (0 : ℝ) else A i j * (P + (2 : ℝ) • J) i j * Q i j)
      + ∑ i, ∑ j, (if i = j then (0 : ℝ) else A i j * (P + (-2 : ℝ) • J) i j * Q i j)
      = 2 * ∑ i, ∑ j, (if i = j then (0 : ℝ) else A i j * P i j * Q i j) := by
    simp only [← Finset.sum_add_distrib, Finset.mul_sum]
    exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by
      split_ifs <;> simp [Matrix.add_apply, Matrix.smul_apply] <;> ring
  -- the traces
  have hJJ : (J * J)ᵀ = J * J := by rw [Matrix.transpose_mul, hJ]
  have sT : Matrix.trace ((P + (2 : ℝ) • J) * (P + (2 : ℝ) • J) * (P + (2 : ℝ) • J))
      + Matrix.trace ((P + (-2 : ℝ) • J) * (P + (-2 : ℝ) • J) * (P + (-2 : ℝ) • J))
      - 2 * Matrix.trace (P * P * P) = 8 * (Matrix.trace (J * J * P) + Matrix.trace (J * P * J) + Matrix.trace (P * J * J)) := by
    have key : (P + (2 : ℝ) • J) * (P + (2 : ℝ) • J) * (P + (2 : ℝ) • J) + (P + (-2 : ℝ) • J) * (P + (-2 : ℝ) • J) * (P + (-2 : ℝ) • J)
        - (2 : ℝ) • (P * P * P) = (8 : ℝ) • (J * J * P + J * P * J + P * J * J) := by
      simp only [add_mul, mul_add, smul_mul_assoc, mul_smul_comm, smul_add, smul_smul]
      module
    have := congrArg Matrix.trace key
    simp only [Matrix.trace_add, Matrix.trace_sub, Matrix.trace_smul, smul_eq_mul] at this
    linarith
  have tr3 : Matrix.trace (J * J * P) = Matrix.trace (P * J * J) ∧ Matrix.trace (J * P * J) = Matrix.trace (P * J * J) := by
    constructor
    · rw [Matrix.trace_mul_comm, Matrix.mul_assoc]
    · rw [Matrix.mul_assoc, Matrix.trace_mul_comm, Matrix.mul_assoc]
  have hPJJ : Matrix.trace (P * J * J) = ((m : ℝ) - 2) * ∑ i, ∑ j, P i j := by
    rw [Matrix.mul_assoc, trace_mul_symm P (J * J) hJJ, Finset.mul_sum]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun j _ => ?_
    by_cases h : i = j
    · subst h; rw [hP0]; ring
    · have : (J * J) i j = (m : ℝ) - 2 := by
        rw [Matrix.mul_apply, ← Finset.add_sum_erase _ _ (Finset.mem_univ i), hJ0, zero_mul, zero_add,
          ← Finset.add_sum_erase _ _ (Finset.mem_erase.mpr ⟨Ne.symm h, Finset.mem_univ j⟩), hJ0, mul_zero, zero_add]
        rw [Finset.sum_congr rfl fun k hk => (show J i k * J k j = 1 by
          rw [hJ1 i k (Ne.symm (Finset.ne_of_mem_erase (Finset.mem_of_mem_erase hk))),
            hJ1 k j (Finset.ne_of_mem_erase hk)]; norm_num)]
        rw [Finset.sum_const, Finset.card_erase_of_mem, Finset.card_erase_of_mem (Finset.mem_univ i), Finset.card_univ,
          Fintype.card_fin, nsmul_eq_mul, mul_one]
        · have : 2 ≤ m := by
            by_contra hm; push_neg at hm; interval_cases m <;> exact absurd (Subsingleton.elim i j) h
          push_cast [Nat.sub_sub, Nat.cast_sub (by omega : 2 ≤ m)]; ring
        · exact Finset.mem_erase.mpr ⟨Ne.symm h, Finset.mem_univ j⟩
      rw [this]; ring
  obtain ⟨t1, t2⟩ := tr3
  linarith [sA, sM, sT, hPJJ]


theorem innerOp2_sub_right'' (A B B' : CurvOp2 (Fin m × Fin 2)) :
    innerOp2 A (B - B') = innerOp2 A B - innerOp2 A B' := by
  rw [innerOp2_comm, innerOp2_sub_left, innerOp2_comm B, innerOp2_comm B']

theorem normSq2_nonneg' (R : CurvOp2 (Fin m × Fin 2)) : 0 ≤ normSq2 R := by
  unfold normSq2 innerOp2
  exact mul_nonneg (by norm_num) (Finset.sum_nonneg fun i _ => Finset.sum_nonneg fun j _ =>
    HamiltonsCubic.FrameExtension.inner2_self_nonneg _)

theorem sum_offdiag_one : ∑ i : Fin m, ∑ j : Fin m, (if i = j then (0 : ℝ) else 1) = (m : ℝ) * ((m : ℝ) - 1) := by
  rw [Finset.sum_congr rfl fun i _ => sum_off_one i 1 (fun j => if i = j then (0 : ℝ) else 1)
    (fun l hl => by simp [Ne.symm hl]) (by simp)]
  simp; ring

/-- **L269.** At a positive solution, `Φ > 0` puts an eigenvalue of `C # ·` above `½` on `C^⊥`. -/
theorem L269_core (hm : 3 ≤ m) (U V : Matrix (Fin m) (Fin m) ℝ) (hU : IsPairWeights U) (hV : IsPairWeights V)
    (hpos : ∀ i j, i ≠ j → 0 < U i j ∧ 0 < V i j) (hsys : TorusSystem U V)
    (hΦ : (4 * ((m : ℝ) - 1) * ((1 / 2 : ℝ) * ∑ i, ∑ j, (U i j ^ 2 + V i j ^ 2))
        + 4 * ((m : ℝ) - 2) * ((1 / 2 : ℝ) * ∑ i, ∑ j, (U i j + V i j)) - (m : ℝ) * ((m : ℝ) - 1))
        * (normSq2 (torusOp (Amu U V) U V) * m / 2 + 2 * ((1 / 2 : ℝ) * ∑ i, ∑ j, (U i j ^ 2 + V i j ^ 2)) ^ 2)
        + ((1 / 2 : ℝ) * ∑ i, ∑ j, (U i j + V i j)) ^ 2
          * (4 * normSq2 (torusOp (Amu U V) U V) - 8 * ((1 / 2 : ℝ) * ∑ i, ∑ j, (U i j ^ 2 + V i j ^ 2)) - m) > 0) :
    ∃ H : CurvOp2 (Fin m × Fin 2), IsSelfAdjoint2 H ∧ innerOp2 H (torusOp (Amu U V) U V) = 0 ∧
      2 * Ftri (torusOp (Amu U V) U V) H H > normSq2 H := by
  obtain ⟨hUt, hU0⟩ := hU
  obtain ⟨hVt, hV0⟩ := hV
  have hAmt : (Amu U V)ᵀ = Amu U V := by ext k l; rw [Matrix.transpose_apply, Amu_symm U V hUt hVt]
  set C := torusOp (Amu U V) U V with hC
  set It : CurvOp2 (Fin m × Fin 2) := torusOp 1 0 0 with hIt
  set IR : CurvOp2 (Fin m × Fin 2) := torusOp 0 (onesOff m) (onesOff m) with hIR
  set x := (1 / 2 : ℝ) * ∑ i, ∑ j, (U i j + V i j) with hx
  set y := (1 / 2 : ℝ) * ∑ i, ∑ j, (U i j ^ 2 + V i j ^ 2) with hy
  set q := normSq2 C with hq
  set W := 4 * ((m : ℝ) - 1) * y + 4 * ((m : ℝ) - 2) * x with hW
  set R := (m : ℝ) * ((m : ℝ) - 1) with hR
  have hidem : IsIdem C := (L268_torus_idem_core (Amu U V) U V hAmt ⟨hUt, hU0⟩ ⟨hVt, hV0⟩).mpr ⟨rfl, hsys⟩
  have saC : IsSelfAdjoint2 C := torusOp_isSelfAdjoint2 _ _ _ hAmt
  have saT : IsSelfAdjoint2 It := torusOp_isSelfAdjoint2 _ _ _ (by simp)
  have saR : IsSelfAdjoint2 IR := torusOp_isSelfAdjoint2 _ _ _ (by simp)
  have h0 : (0 : Matrix (Fin m) (Fin m) ℝ)ᵀ = 0 := by simp
  have hJ := onesOff_symm (m := m)
  -- the Gram entries
  have sd : ∑ i, Amu U V i i = 2 * y := by
    rw [hy]; simp only [Amu, if_pos rfl, if_true]; ring
  have gTT : innerOp2 It It = m := by
    rw [innerOp2_torusOp _ _ _ _ _ _ h0 h0 h0 h0]; simp [Matrix.one_apply]
  have gRR : innerOp2 IR IR = 2 * R := by
    rw [innerOp2_torusOp _ _ _ _ _ _ hJ hJ hJ hJ, hR, ← sum_offdiag_one]
    simp only [Matrix.zero_apply, mul_zero, Finset.sum_const_zero, zero_add, Finset.mul_sum]
    exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by
      by_cases h : i = j
      · simp [h]
      · simp [onesOff, h]; norm_num
  have gTR : innerOp2 It IR = 0 := by
    rw [innerOp2_torusOp _ _ _ _ _ _ h0 h0 hJ hJ]; simp
  have gCT : innerOp2 It C = 2 * y := by
    rw [innerOp2_torusOp _ _ _ _ _ _ h0 h0 hUt hVt, ← sd]; simp [Matrix.one_apply]
  have gCR : innerOp2 IR C = 2 * x := by
    rw [innerOp2_torusOp _ _ _ _ _ _ hJ hJ hUt hVt, hx, show (2 : ℝ) * ((1 / 2 : ℝ) * ∑ i, ∑ j, (U i j + V i j))
      = ∑ i, ∑ j, (U i j + V i j) by ring]
    simp only [Matrix.zero_apply, zero_mul, Finset.sum_const_zero, zero_add]
    refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
    by_cases h : i = j
    · subst h; simp [hU0, hV0]
    · simp [onesOff, h]
  -- the values of `F(C, ·, ·)`
  have fTT : Ftri C It It = 0 := Ftri_It _ U V hAmt ⟨hUt, hU0⟩ ⟨hVt, hV0⟩
  have fRR : Ftri C IR IR = W := by
    rw [Ftri_IR _ U V hAmt ⟨hUt, hU0⟩ ⟨hVt, hV0⟩, sd, hW, hx]
    simp only [Matrix.add_apply, Finset.mul_sum]; ring_nf
  have hI : (idOp : CurvOp2 (Fin m × Fin 2)) = It + IR := by
    rw [idOp_eq_torusOp, hIt, hIR, torusOp_add _ _ _ _ _ _ h0 h0 hJ hJ]; simp
  have fII : Ftri C (It + IR) (It + IR) = 4 * ((m : ℝ) - 1) * (x + y) := by
    rw [← hI, Ftri_id, hI, innerOp2_comm, innerOp2_add_left, gCT, gCR]
    simp [Fintype.card_prod]; ring
  have fTR : Ftri C It IR = 2 * x := by
    have e := fII
    rw [Ftri_add_mid, Ftri_add_right, Ftri_add_right, Ftri_symm23 saC IR It, fTT, fRR, hW] at e
    linarith
  have fCX : ∀ X, Ftri C C X = innerOp2 X C := Ftri_idem hidem
  have fXC : ∀ X, Ftri C X C = innerOp2 X C := fun X => by rw [Ftri_symm23 saC, fCX]
  have hq0 : 0 < q := by
    obtain ⟨i0, j0, hij⟩ : ∃ i j : Fin m, i ≠ j := ⟨⟨0, by omega⟩, ⟨1, by omega⟩, by simp [Fin.ext_iff]⟩
    have hpij := hpos i0 j0 hij
    rw [hq, hC, L271_norm _ U V ⟨hUt, hU0⟩ ⟨hVt, hV0⟩]
    have h1 : 0 < (U + V) i0 j0 ^ 2 := by simp only [Matrix.add_apply]; nlinarith [hpij.1, hpij.2]
    have h2 : (U + V) i0 j0 ^ 2 ≤ ∑ i, ∑ j, (U + V) i j ^ 2 :=
      le_trans (Finset.single_le_sum (f := fun j => (U + V) i0 j ^ 2) (fun j _ => sq_nonneg _) (Finset.mem_univ j0))
        (Finset.single_le_sum (f := fun i => ∑ j, (U + V) i j ^ 2)
          (fun i _ => Finset.sum_nonneg fun j _ => sq_nonneg _) (Finset.mem_univ i0))
    have h3 : 0 ≤ ∑ i, ∑ j, Amu U V i j ^ 2 := Finset.sum_nonneg fun i _ => Finset.sum_nonneg fun j _ => sq_nonneg _
    have h4 : 0 ≤ ∑ i, ∑ j, (U - V) i j ^ 2 := Finset.sum_nonneg fun i _ => Finset.sum_nonneg fun j _ => sq_nonneg _
    linarith
  -- the direction
  set den := (m : ℝ) * q + 4 * y ^ 2 with hden
  have hden0 : 0 < den := by
    rw [hden]; have : (0 : ℝ) < m := by exact_mod_cast (by omega : 0 < m)
    nlinarith [mul_pos this hq0, sq_nonneg y]
  set a := 4 * x * (q - y) / den with ha
  set g := 2 * y * a + 2 * x with hg
  set lam := g / q with hlam
  refine ⟨a • It + IR - lam • C, ?_, ?_, ?_⟩
  · intro X Y
    simp only [ContinuousLinearMap.sub_apply, ContinuousLinearMap.add_apply, ContinuousLinearMap.smul_apply,
      Submodule.coe_sub, Submodule.coe_add, Submodule.coe_smul, i2_sub_l, i2_sub_r', i2_add_l, i2_add_r, i2_smul_l,
      i2_smul_r, saT X Y, saR X Y, saC X Y]
  · rw [innerOp2_sub_left, innerOp2_add_left, innerOp2_smul_left, innerOp2_smul_left, gCT, gCR, hlam]
    rw [show innerOp2 C C = q from rfl]; field_simp; rw [hg]; ring
  · -- expand both sides in the basis `C, I_t, I_R`
    have eF : Ftri C (a • It + IR - lam • C) (a • It + IR - lam • C)
        = a ^ 2 * Ftri C It It + 2 * a * Ftri C It IR + Ftri C IR IR - 2 * lam * (a * innerOp2 It C + innerOp2 IR C)
          + lam ^ 2 * q := by
      have eH : a • It + IR - lam • C = a • It + IR + (-lam) • C :=
        ContinuousLinearMap.ext fun X => Subtype.ext (by
          simp only [ContinuousLinearMap.sub_apply, ContinuousLinearMap.add_apply, ContinuousLinearMap.smul_apply,
            Submodule.coe_sub, Submodule.coe_add, Submodule.coe_smul]
          module)
      rw [eH]
      simp only [Ftri_add_mid, Ftri_add_right, Ftri_smul_mid, Ftri_smul_right]
      simp only [fXC, fCX]
      rw [Ftri_symm23 saC IR It]
      try rw [show innerOp2 C C = q from rfl]
      ring
    have eN : normSq2 (a • It + IR - lam • C)
        = a ^ 2 * m + 2 * R - 2 * lam * (a * innerOp2 It C + innerOp2 IR C) + lam ^ 2 * q := by
      unfold normSq2
      simp only [innerOp2_sub_left, innerOp2_add_left, innerOp2_smul_left, innerOp2_sub_right'', innerOp2_add_right,
        innerOp2_smul_right, gTT, gRR, gTR]
      rw [innerOp2_comm IR It, gTR, innerOp2_comm C It, innerOp2_comm C IR]
      try rw [show innerOp2 C C = q from rfl]
      ring
    rw [eF, eN, fTT, fTR, fRR, gCT, gCR]
    have key : 2 * (a ^ 2 * 0 + 2 * a * (2 * x) + W - 2 * lam * (a * (2 * y) + 2 * x) + lam ^ 2 * q)
        - (a ^ 2 * m + 2 * R - 2 * lam * (a * (2 * y) + 2 * x) + lam ^ 2 * q)
        = 4 * ((W - R) * (q * m / 2 + 2 * y ^ 2) + x ^ 2 * (4 * q - 8 * y - m)) / den := by
      rw [hlam, hg, ha]; field_simp; ring
    have hpos' : 0 < 4 * ((W - R) * (q * m / 2 + 2 * y ^ 2) + x ^ 2 * (4 * q - 8 * y - m)) / den :=
      div_pos (by linarith) hden0
    linarith

/-- **The identity in L271 (4)'s proof.** With `C_P = torusOp (diag d) (P/2) (P/2)` and
`C_Q = torusOp (A_μ - diag d) (Q/2) (-Q/2)`, `C = C_P + C_Q` at an idempotent, the two are orthogonal and
`F(C, C_P, C_Q) = ½‖C_Q‖² - ¼ tr Q³`. (4)'s eigenvalue formula and its threshold are not typed. -/
theorem L271_split {m : ℕ} (hm : 3 ≤ m) (U V : Matrix (Fin m) (Fin m) ℝ) (hU : IsPairWeights U)
    (hV : IsPairWeights V) (hsys : TorusSystem U V) :
    let P := U + V
    let Q := U - V
    let CP := torusOp (Matrix.diagonal (dvec U V)) ((1 / 2 : ℝ) • P) ((1 / 2 : ℝ) • P)
    let CQ := torusOp (Amu U V - Matrix.diagonal (dvec U V)) ((1 / 2 : ℝ) • Q) (-((1 / 2 : ℝ) • Q))
    torusOp (Amu U V) U V = CP + CQ ∧ innerOp2 CP CQ = 0 ∧
      Ftri (torusOp (Amu U V) U V) CP CQ = (1 / 2) * normSq2 CQ - (1 / 4) * Matrix.trace (Q * Q * Q) := by
  intro P Q CP CQ
  exact L271_split_core U V hU hV hsys

/-- **L269.** At a positive solution, with `x = ∑_{i<j} (U_ij + V_ij)`, `y = ∑_{i<j} (U_ij² + V_ij²)`,
`q = ‖C‖²`, `R = m(m - 1)` and `W = 4(m - 1) y + 4(m - 2) x`, `Φ > 0` puts an eigenvalue of `C # ·` above `½` on
`C^⊥`: some self-adjoint `H ⊥ C` has `2 F(C, H, H) > ‖H‖²`. -/
theorem L269_phi_test (hm : 3 ≤ m) (U V : Matrix (Fin m) (Fin m) ℝ) (hU : IsPairWeights U) (hV : IsPairWeights V)
    (hpos : ∀ i j, i ≠ j → 0 < U i j ∧ 0 < V i j) (hsys : TorusSystem U V) :
    let C := torusOp (Amu U V) U V
    let x := (1 / 2 : ℝ) * ∑ i, ∑ j, (U i j + V i j)
    let y := (1 / 2 : ℝ) * ∑ i, ∑ j, (U i j ^ 2 + V i j ^ 2)
    let q := normSq2 C
    let R := (m : ℝ) * ((m : ℝ) - 1)
    let W := 4 * ((m : ℝ) - 1) * y + 4 * ((m : ℝ) - 2) * x
    (W - R) * (q * m / 2 + 2 * y ^ 2) + x ^ 2 * (4 * q - 8 * y - m) > 0 →
      ∃ H : CurvOp2 (Fin m × Fin 2), IsSelfAdjoint2 H ∧ innerOp2 H C = 0 ∧ 2 * Ftri C H H > normSq2 H := by
  intro C x y q R W hΦ
  exact L269_core hm U V hU hV hpos hsys hΦ

end TorusBuild

end HamiltonsCubic.I117S
