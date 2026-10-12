import HamiltonsCubic.Base.Pfaffian6
import HamiltonsCubic.Base.Levi6Det

set_option linter.style.longLine false

/-!
# The Pfaffian's transformation law, `Pf(QXQᵀ) = det Q · Pf X`

**`triple6` written as a sum over index maps puts all six `Q` factors inside one sum**, and
swapping that sum past the outer one leaves, at each tuple `u`, the full `levi6` contraction
against `Qᵀ`. [Levi6Det.lean](Levi6Det.lean)'s `levi6_contract` evaluates it as `ε(u) · det Q`.

*This is the resummation [Pfaffian6.lean](Pfaffian6.lean) recorded as standing between
`levi6_contract` and the transformation law, and it is `det`-equivariance of the whole
trilinear form, of which `pf6_conj` is the diagonal.*
-/

namespace HamiltonsCubic.SelfDualLayer

open Matrix Equiv

/-- `levi6_contract` as a sum over index maps. -/
theorem levi6_contract_fun (A : Matrix (Fin 6) (Fin 6) ℝ) (w : Fin 6 → Fin 6) :
    ∑ v : Fin 6 → Fin 6, levi6 (v 0) (v 1) (v 2) (v 3) (v 4) (v 5) * ∏ k, A (w k) (v k)
      = levi6 (w 0) (w 1) (w 2) (w 3) (w 4) (w 5) * A.det := by
  rw [sum_fun_fin6, ← levi6_contract]
  simp only [Fin.prod_univ_six, Matrix.cons_val]

/-- An entry of `Q X Qᵀ` as a double sum. -/
theorem conj_apply (Q X : Matrix (Fin 6) (Fin 6) ℝ) (i j : Fin 6) :
    (Q * X * Qᵀ) i j = ∑ a, ∑ b, Q i a * Q j b * X a b := by
  simp only [Matrix.mul_apply, Matrix.transpose_apply, Finset.sum_mul]
  rw [Finset.sum_comm]
  exact Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ => by ring

/-- `triple6` as one sum over index maps. -/
theorem triple6_eq_sum_fun (X Y Z : Matrix (Fin 6) (Fin 6) ℝ) :
    triple6 X Y Z = (1 / 48 : ℝ) * ∑ v : Fin 6 → Fin 6,
      levi6 (v 0) (v 1) (v 2) (v 3) (v 4) (v 5) * (X (v 0) (v 1) * Y (v 2) (v 3) * Z (v 4) (v 5)) := by
  unfold triple6
  rw [sum_fun_fin6]
  simp only [Matrix.cons_val, mul_assoc]

/-- The inner resummation at one outer tuple. -/
theorem conj_triple_entry (Q X Y Z : Matrix (Fin 6) (Fin 6) ℝ) (v : Fin 6 → Fin 6) :
    (Q * X * Qᵀ) (v 0) (v 1) * (Q * Y * Qᵀ) (v 2) (v 3) * (Q * Z * Qᵀ) (v 4) (v 5)
      = ∑ u : Fin 6 → Fin 6, (∏ k, Q (v k) (u k)) *
          (X (u 0) (u 1) * Y (u 2) (u 3) * Z (u 4) (u 5)) := by
  rw [show (Q * X * Qᵀ) (v 0) (v 1) * (Q * Y * Qᵀ) (v 2) (v 3) * (Q * Z * Qᵀ) (v 4) (v 5)
      = (Q * Z * Qᵀ) (v 4) (v 5) * (Q * Y * Qᵀ) (v 2) (v 3) * (Q * X * Qᵀ) (v 0) (v 1) by ring]
  rw [sum_fun_fin6]
  simp only [conj_apply, Fin.prod_univ_six, Matrix.cons_val]
  simp only [Finset.sum_mul, Finset.mul_sum]
  refine Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ => ?_
  refine Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ => ?_
  refine Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ => ?_
  ring

/-- **`triple6` IS `det`-EQUIVARIANT**: `triple6 (QXQᵀ) (QYQᵀ) (QZQᵀ) = det Q · triple6 X Y Z`. -/
theorem triple6_conj (Q X Y Z : Matrix (Fin 6) (Fin 6) ℝ) :
    triple6 (Q * X * Qᵀ) (Q * Y * Qᵀ) (Q * Z * Qᵀ) = Q.det * triple6 X Y Z := by
  rw [triple6_eq_sum_fun, triple6_eq_sum_fun]
  simp only [conj_triple_entry, Finset.mul_sum]
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun u _ => ?_
  have h := levi6_contract_fun Qᵀ u
  simp only [Matrix.transpose_apply, Matrix.det_transpose] at h
  have hr : ∀ v : Fin 6 → Fin 6,
      levi6 (v 0) (v 1) (v 2) (v 3) (v 4) (v 5) *
        ((∏ k, Q (v k) (u k)) * (X (u 0) (u 1) * Y (u 2) (u 3) * Z (u 4) (u 5)))
      = (levi6 (v 0) (v 1) (v 2) (v 3) (v 4) (v 5) * ∏ k, Q (v k) (u k)) *
          (X (u 0) (u 1) * Y (u 2) (u 3) * Z (u 4) (u 5)) := fun v => by ring
  rw [← Finset.mul_sum]
  simp only [hr]
  rw [← Finset.sum_mul, h]
  ring

/-- **THE PFAFFIAN'S TRANSFORMATION LAW**: `pf6 (QXQᵀ) = det Q · pf6 X`. -/
theorem pf6_conj (Q X : Matrix (Fin 6) (Fin 6) ℝ) :
    pf6 (Q * X * Qᵀ) = Q.det * pf6 X := triple6_conj Q X X X

end HamiltonsCubic.SelfDualLayer
