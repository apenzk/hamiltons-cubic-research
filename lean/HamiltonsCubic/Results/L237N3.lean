import Mathlib
import HamiltonsCubic.Results.L237Attain
import HamiltonsCubic.Base.Families

set_option linter.style.longLine false

/-!
# L237 at `n = 3`: `κ₁ = 1` and `κ₂ = 2`, from Lagrange's identity in `𝔰𝔬(3)`

The L237 row owes *"the values $\kappa_1=1$ and $\kappa_2=2$ at $n=3$"* ([r1685](../../../reviews/REVIEW_r1685.md)).
`κ_r` is the supremum of `∑ⱼ ‖[X, yⱼ]‖² / ⟨X, X⟩` over skew `X ≠ 0` and orthonormal skew `y₁, …, y_r`
([L237Attain.lean](L237Attain.lean)'s `Attains`). In `𝔰𝔬(3)` the bracket is the cross product:

* `lagrange3`: `‖[X, Y]‖² = ‖X‖² ‖Y‖² - ⟨X, Y⟩²` for skew `3 × 3` `X`, `Y`, in the layer's
  `⟨X, Y⟩ = ½ tr(XᵀY)`;
* `cap3`: so `∑ⱼ ‖[X, yⱼ]‖² = r ‖X‖² - ∑ⱼ ⟨X, yⱼ⟩² ≤ r ‖X‖²` at `n = 3`, every `r`;
* `attains3_one`, `attains3_two`: equality at `X = φ₀₁` with `y = φ₀₂` and `y = (φ₀₂, φ₁₂)`, so `κ₁ = 1`
  and `κ₂ = 2` at `n = 3`.
-/

namespace HamiltonsCubic.L237N3

open HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L237Attain Matrix

theorem skew_rel {X : Matrix (Fin 3) (Fin 3) ℝ} (hX : IsSkew X) :
    X 0 0 = 0 ∧ X 1 1 = 0 ∧ X 2 2 = 0 ∧ X 1 0 = -X 0 1 ∧ X 2 0 = -X 0 2 ∧ X 2 1 = -X 1 2 := by
  have h : ∀ i j, X j i = -X i j := fun i j => by
    have := congrFun (congrFun hX i) j
    simpa [Matrix.transpose_apply] using this
  refine ⟨?_, ?_, ?_, h 0 1, h 0 2, h 1 2⟩ <;> linarith [h 0 0, h 1 1, h 2 2]

/-- **Lagrange's identity in `𝔰𝔬(3)`**: `‖[X, Y]‖² = ‖X‖² ‖Y‖² - ⟨X, Y⟩²`. -/
theorem lagrange3 (X Y : Matrix (Fin 3) (Fin 3) ℝ) (hX : IsSkew X) (hY : IsSkew Y) :
    inner2 (br X Y) (br X Y) = inner2 X X * inner2 Y Y - inner2 X Y ^ 2 := by
  obtain ⟨x0, x1, x2, x10, x20, x21⟩ := skew_rel hX
  obtain ⟨y0, y1, y2, y10, y20, y21⟩ := skew_rel hY
  simp only [inner2_eq_sum, br, Matrix.sub_apply, Matrix.mul_apply, Fin.sum_univ_three]
  simp only [x0, x1, x2, x10, x20, x21, y0, y1, y2, y10, y20, y21]
  ring

/-- **The cap at `n = 3`**: `∑ⱼ ‖[X, yⱼ]‖² ≤ r ‖X‖²`, with the deficit `∑ⱼ ⟨X, yⱼ⟩²`. -/
theorem cap3 {r : ℕ} (X : Matrix (Fin 3) (Fin 3) ℝ) (hX : IsSkew X) (y : Fin r → Matrix (Fin 3) (Fin 3) ℝ)
    (hy : ∀ j, IsSkew (y j)) (hon : ∀ i j, inner2 (y i) (y j) = if i = j then 1 else 0) :
    ∑ j, inner2 (br X (y j)) (br X (y j)) = r * inner2 X X - ∑ j, inner2 X (y j) ^ 2 ∧
      ∑ j, inner2 (br X (y j)) (br X (y j)) ≤ r * inner2 X X := by
  have e : ∀ j, inner2 (br X (y j)) (br X (y j)) = inner2 X X - inner2 X (y j) ^ 2 := fun j => by
    rw [lagrange3 X (y j) hX (hy j), hon j j, if_pos rfl, mul_one]
  have hsum : ∑ j, inner2 (br X (y j)) (br X (y j)) = r * inner2 X X - ∑ j, inner2 X (y j) ^ 2 := by
    rw [Finset.sum_congr rfl fun j _ => e j, Finset.sum_sub_distrib, Finset.sum_const, Finset.card_univ,
      Fintype.card_fin, nsmul_eq_mul]
  refine ⟨hsum, ?_⟩
  rw [hsum]
  have : 0 ≤ ∑ j, inner2 X (y j) ^ 2 := Finset.sum_nonneg fun j _ => sq_nonneg _
  linarith

theorem phi_skew3 (i j : Fin 3) : IsSkew (phi i j : Matrix (Fin 3) (Fin 3) ℝ) := phi_isSkew i j

/-- **`κ₁ = 1` at `n = 3`**, attained at `X = φ₀₁`, `y = φ₀₂`. -/
theorem attains3_one : Attains (Fin 3) 1 1 := by
  refine ⟨phi 0 1, phi_skew3 0 1, ?_, fun _ => phi 0 2, fun _ => phi_skew3 0 2, ?_, ?_⟩
  · rw [inner2_phi_phi]; norm_num
  · intro i j; rw [inner2_phi_phi]; fin_cases i; fin_cases j; simp [Fin.ext_iff]
  · rw [Fin.sum_univ_one, lagrange3 _ _ (phi_skew3 0 1) (phi_skew3 0 2), inner2_phi_phi, inner2_phi_phi,
      inner2_phi_phi]
    simp [Fin.ext_iff]

/-- **`κ₂ = 2` at `n = 3`**, attained at `X = φ₀₁`, `y = (φ₀₂, φ₁₂)`. -/
theorem attains3_two : Attains (Fin 3) 2 2 := by
  refine ⟨phi 0 1, phi_skew3 0 1, ?_, ![phi 0 2, phi 1 2], fun j => by fin_cases j <;> exact phi_skew3 _ _,
    ?_, ?_⟩
  · rw [inner2_phi_phi]; norm_num
  · intro i j
    fin_cases i <;> fin_cases j <;> simp [inner2_phi_phi]
  · rw [Fin.sum_univ_two]
    simp only [Matrix.cons_val_zero, Matrix.cons_val_one]
    rw [lagrange3 _ _ (phi_skew3 0 1) (phi_skew3 0 2), lagrange3 _ _ (phi_skew3 0 1) (phi_skew3 1 2)]
    simp [inner2_phi_phi]
    norm_num

end HamiltonsCubic.L237N3
