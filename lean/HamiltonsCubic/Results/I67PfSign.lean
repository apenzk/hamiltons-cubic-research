import HamiltonsCubic.Base.Pfaffian6Conj
import HamiltonsCubic.Results.L193Statement
import HamiltonsCubic.Results.L184Statement

set_option linter.style.longLine false

/-!
# `StarWedgeIdentity` holds: the Pfaffian of a complex structure on `ℝ⁶` is `±1`

**Every complex structure on `ℝ⁶` is orthogonally conjugate to `stdJ6`**, and
[Pfaffian6Conj.lean](../Base/Pfaffian6Conj.lean)'s `pf6_conj` then gives
`pf6 J = det Q · pf6 stdJ6 = ±1`, since `pf6 stdJ6 = -1` and an orthogonal `Q` has `det Q = ±1`.
[L193Statement.lean](L193Statement.lean)'s `starWedge_of_pf` turns that into `StarWedgeIdentity`.

*The normal form is built one `J`-invariant plane at a time*: `q₀` is any unit vector, `q₂` a unit
vector orthogonal to `q₀` and `J q₀`, and `q₄` one orthogonal to all four of `q₀, J q₀, q₂, J q₂`,
each found as a kernel vector of a `6 × 6` matrix with zero rows, so `Matrix.exists_mulVec_eq_zero_iff`
supplies it. **The columns `q₀, J q₀, q₂, J q₂, q₄, J q₄` are orthonormal** because `J` is skew and
orthogonal, which is all `cs_dot_left`, `cs_dot_JJ` and `cs_dot_self` use.
-/

namespace HamiltonsCubic.SelfDualLayer

open Matrix HamiltonsCubic.RealLayer

/-- `triple6` on three single-entry matrices is one `levi6` value. -/
theorem triple6_single (a b c d e f : Fin 6) :
    triple6 (single a b (1 : ℝ)) (single c d 1) (single e f 1) = (1 / 48 : ℝ) * levi6 a b c d e f := by
  unfold triple6
  congr 1
  rw [Fintype.sum_eq_single a (fun x hx => by simp [Matrix.single_apply, Ne.symm hx])]
  rw [Fintype.sum_eq_single b (fun x hx => by simp [Matrix.single_apply, Ne.symm hx])]
  rw [Fintype.sum_eq_single c (fun x hx => by simp [Matrix.single_apply, Ne.symm hx])]
  rw [Fintype.sum_eq_single d (fun x hx => by simp [Matrix.single_apply, Ne.symm hx])]
  rw [Fintype.sum_eq_single e (fun x hx => by simp [Matrix.single_apply, Ne.symm hx])]
  rw [Fintype.sum_eq_single f (fun x hx => by simp [Matrix.single_apply, Ne.symm hx])]
  simp [Matrix.single_apply]

/-- `phi` as a sum of scaled single-entry matrices, the form trilinearity expands. -/
theorem phi_eq_sub (i j : Fin 6) : phi i j = single j i (1 : ℝ) + (-1 : ℝ) • single i j 1 := by
  simp [phi, sub_eq_add_neg]

/-- **`Pf(stdJ6) = -1`**: `X₀₁ X₂₃ X₄₅` with each `X_{2k,2k+1} = -1`. -/
theorem pf6_stdJ6 : pf6 stdJ6 = -1 := by
  unfold pf6 stdJ6
  simp only [phi_eq_sub, triple6_add_left, triple6_add_mid, triple6_add_right,
    triple6_smul_left, triple6_smul_mid, triple6_smul_right, triple6_single]
  simp (config := {decide := true}) only [levi6, sgnR]
  norm_num


/-- **A unit vector orthogonal to four given vectors in `ℝ⁶`**, a kernel vector of the matrix whose
rows they are, padded with two zero rows so its determinant vanishes. -/
theorem exists_unit_orth4 (a b c d : Fin 6 → ℝ) :
    ∃ v : Fin 6 → ℝ, v ⬝ᵥ v = 1 ∧ a ⬝ᵥ v = 0 ∧ b ⬝ᵥ v = 0 ∧ c ⬝ᵥ v = 0 ∧ d ⬝ᵥ v = 0 := by
  classical
  let M : Matrix (Fin 6) (Fin 6) ℝ := Matrix.of ![a, b, c, d, 0, 0]
  have hdet : M.det = 0 := Matrix.det_eq_zero_of_row_eq_zero 4 (fun j => by simp [M])
  obtain ⟨w, hw0, hw⟩ := Matrix.exists_mulVec_eq_zero_iff.2 hdet
  have hrow : ∀ i, M i ⬝ᵥ w = 0 := fun i => by
    have := congrFun hw i
    simpa [Matrix.mulVec] using this
  have hnn : 0 ≤ w ⬝ᵥ w := Finset.sum_nonneg fun i _ => mul_self_nonneg (w i)
  have hne : w ⬝ᵥ w ≠ 0 := fun h => hw0 (dotProduct_self_eq_zero.1 h)
  have hpos : 0 < w ⬝ᵥ w := lt_of_le_of_ne hnn (Ne.symm hne)
  set s := Real.sqrt (w ⬝ᵥ w) with hs_def
  have hs : 0 < s := Real.sqrt_pos.2 hpos
  have hs2 : s * s = w ⬝ᵥ w := Real.mul_self_sqrt hnn
  have h0 := hrow 0
  have h1 := hrow 1
  have h2 := hrow 2
  have h3 := hrow 3
  change a ⬝ᵥ w = 0 at h0
  change b ⬝ᵥ w = 0 at h1
  change c ⬝ᵥ w = 0 at h2
  change d ⬝ᵥ w = 0 at h3
  refine ⟨s⁻¹ • w, ?_, ?_, ?_, ?_, ?_⟩
  · rw [smul_dotProduct, dotProduct_smul, smul_eq_mul, smul_eq_mul, ← hs2]
    field_simp
  · rw [dotProduct_smul, h0, smul_zero]
  · rw [dotProduct_smul, h1, smul_zero]
  · rw [dotProduct_smul, h2, smul_zero]
  · rw [dotProduct_smul, h3, smul_zero]

section CS

variable {J : Matrix (Fin 6) (Fin 6) ℝ} (hJ : IsComplexStructure J)
include hJ

/-- A complex structure is skew for the dot product. -/
theorem cs_dot_left (x y : Fin 6 → ℝ) : x ⬝ᵥ (J *ᵥ y) = -((J *ᵥ x) ⬝ᵥ y) := by
  have hT : Jᵀ = -J := hJ.1
  rw [dotProduct_mulVec, ← mulVec_transpose, hT, neg_mulVec, neg_dotProduct]

/-- `J (J x) = -x`. -/
theorem cs_mulVec_mulVec (x : Fin 6 → ℝ) : J *ᵥ (J *ᵥ x) = -x := by
  rw [mulVec_mulVec, hJ.2, neg_mulVec, one_mulVec]

/-- A complex structure is orthogonal for the dot product. -/
theorem cs_dot_JJ (x y : Fin 6 → ℝ) : (J *ᵥ x) ⬝ᵥ (J *ᵥ y) = x ⬝ᵥ y := by
  have h := cs_dot_left hJ x (J *ᵥ y)
  rw [cs_mulVec_mulVec hJ, dotProduct_neg] at h
  linarith

/-- `x` and `J x` are orthogonal. -/
theorem cs_dot_self (x : Fin 6 → ℝ) : x ⬝ᵥ (J *ᵥ x) = 0 := by
  have h := cs_dot_left hJ x x
  rw [dotProduct_comm (J *ᵥ x) x] at h
  linarith

/-- **EVERY COMPLEX STRUCTURE ON `ℝ⁶` IS ORTHOGONALLY CONJUGATE TO `stdJ6`.** -/
theorem complexStructure_normalForm :
    ∃ Q : Matrix (Fin 6) (Fin 6) ℝ, Qᵀ * Q = 1 ∧ J = Q * stdJ6 * Qᵀ := by
  obtain ⟨q0, n0, -, -, -, -⟩ := exists_unit_orth4 0 0 0 0
  obtain ⟨q2, n2, a20, b20, -, -⟩ := exists_unit_orth4 q0 (J *ᵥ q0) 0 0
  obtain ⟨q4, n4, a40, b40, a42, b42⟩ := exists_unit_orth4 q0 (J *ᵥ q0) q2 (J *ᵥ q2)
  set cols : Fin 6 → Fin 6 → ℝ := ![q0, J *ᵥ q0, q2, J *ᵥ q2, q4, J *ᵥ q4] with hcols
  set Q : Matrix (Fin 6) (Fin 6) ℝ := Matrix.of fun i k => cols k i with hQ
  have L := cs_dot_left hJ
  have JJ := cs_dot_JJ hJ
  have S := cs_dot_self hJ
  have gram : ∀ k l, cols k ⬝ᵥ cols l = if k = l then 1 else 0 := by
    intro k l
    fin_cases k <;> fin_cases l <;>
      simp [cols, JJ, S, L, n0, n2, n4, a20, b20, a40, b40, a42, b42, dotProduct_comm q2 q0,
        dotProduct_comm q4 q0, dotProduct_comm q4 q2, dotProduct_comm (J *ᵥ q0),
        dotProduct_comm (J *ᵥ q2), dotProduct_comm (J *ᵥ q4)]
  have hQtQ : Qᵀ * Q = 1 := by
    ext k l
    rw [Matrix.mul_apply, Matrix.one_apply, ← gram k l]
    simp [Q, dotProduct]
  have hQQt : Q * Qᵀ = 1 := mul_eq_one_comm.1 hQtQ
  have hJQ : J * Q = Q * stdJ6 := by
    have MM := cs_mulVec_mulVec hJ
    have hcol : ∀ i k, (J * Q) i k = (J *ᵥ cols k) i := by
      intro i k
      simp [Matrix.mul_apply, Q, Matrix.mulVec, dotProduct]
    ext i k
    rw [hcol]
    fin_cases k
    all_goals
      simp only [cols, Fin.zero_eta, Fin.mk_one, Fin.reduceFinMk, Matrix.cons_val, MM]
      simp [Q, cols, Matrix.mul_apply, Fin.sum_univ_six, stdJ6, phi, Matrix.single_apply]
  refine ⟨Q, hQtQ, ?_⟩
  calc J = J * (Q * Qᵀ) := by rw [hQQt, Matrix.mul_one]
    _ = Q * stdJ6 * Qᵀ := by rw [← Matrix.mul_assoc, hJQ]

/-- **THE PFAFFIAN OF A COMPLEX STRUCTURE ON `ℝ⁶` IS `±1`.** -/
theorem pf6_complexStructure : pf6 J = 1 ∨ pf6 J = -1 := by
  obtain ⟨Q, hQtQ, hJ'⟩ := complexStructure_normalForm hJ
  have hdet : Q.det * Q.det = 1 := by
    have := congrArg Matrix.det hQtQ
    rw [Matrix.det_mul, Matrix.det_transpose, Matrix.det_one] at this
    exact this
  have hd : Q.det = 1 ∨ Q.det = -1 := by
    have : (Q.det - 1) * (Q.det + 1) = 0 := by ring_nf; linarith
    rcases mul_eq_zero.1 this with h | h
    · left; linarith
    · right; linarith
  rw [hJ', pf6_conj, pf6_stdJ6]
  rcases hd with h | h <;> rw [h] <;> norm_num

end CS

/-- **`StarWedgeIdentity` HOLDS**, discharging the hypothesis [L184Statement.lean](L184Statement.lean)'s
case 2 carried. *Non-vacuous: `stdJ6_isComplexStructure` inhabits its binder.* -/
theorem starWedgeIdentity_holds : StarWedgeIdentity :=
  HamiltonsCubic.L193Statement.starWedge_of_pf fun _ hJ => pf6_complexStructure hJ

/-- **L184, case 2, UNCONDITIONALLY**: the scalar sub-case at `dim V = 6` is empty, with
`StarWedgeIdentity` supplied by `starWedgeIdentity_holds` rather than assumed. -/
theorem scalar_case_empty_orthonormal_uncond
    (om : Fin 3 → Matrix (Fin 6) (Fin 6) ℝ)
    (hskew : ∀ i, IsSkew (om i))
    (hon : ∀ i j, inner2 (om i) (om j) = if i = j then 1 else 0)
    (hscal : ∀ i, ∃ c : ℝ, om i * om i = c • (1 : Matrix (Fin 6) (Fin 6) ℝ))
    (hwedge : ∀ i j, wedgeSelf (om i) = wedgeSelf (om j)) :
    False :=
  HamiltonsCubic.L184Statement.scalar_case_empty_orthonormal starWedgeIdentity_holds om hskew hon
    hscal hwedge

end HamiltonsCubic.SelfDualLayer
