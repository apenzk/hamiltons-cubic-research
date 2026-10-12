import HamiltonsCubic.Results.L31Statement

/-!
# The real normal form of a skew matrix

**`skew_normal_form`**: every skew `x` is `Σ_j a_j (w_j u_jᵀ - u_j w_jᵀ)` with `{u_j, w_j}` orthonormal,
every `a_j > 0`, and every `u_j, w_j` in the image of `x`. The `a_j` are the singular values of `x`,
and the planes `⟨u_j, w_j⟩` its invariant 2-planes.

**The proof peels one plane at a time.** A unit `u` maximising `‖xu‖` is a top eigenvector of
`xᵀx` ([L31Statement.lean](L31Statement.lean)'s `exists_max` and `max_eigen`), with eigenvalue
`c = ‖xu‖² > 0` when `x ≠ 0`. With `a = √c` and `w = xu/a`, the pair `u, w` is orthonormal, `xu = aw`
and `xw = -au`, and `x' = x - a(wuᵀ - uwᵀ)` is skew, kills `u` and `w`, and has image inside that of
`x` and orthogonal to `u`. So its image is strictly smaller, and strong induction on its dimension
finishes, the new planes lying in `im x'`, which is orthogonal to `u` and `w`.

*This is the base of the centraliser computations [L81](L81Statement.lean) and
[L33](L33Statement.lean) need: `x` is conjugate to a sum of rotations in coordinate planes.*
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.SkewNormalForm

open Matrix HamiltonsCubic.L31Statement.Proof

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The rank-2 skew matrix `w uᵀ - u wᵀ`, which sends `u ↦ w` and `w ↦ -u` on an orthonormal pair. -/
def rot (u w : ι → ℝ) : Matrix ι ι ℝ := vecMulVec w u - vecMulVec u w

theorem rot_mulVec (u w v : ι → ℝ) : rot u w *ᵥ v = (u ⬝ᵥ v) • w - (w ⬝ᵥ v) • u := by
  unfold rot
  rw [Matrix.sub_mulVec, Matrix.vecMulVec_mulVec, Matrix.vecMulVec_mulVec, op_smul_eq_smul, op_smul_eq_smul]

theorem rot_skew (u w : ι → ℝ) : (rot u w)ᵀ = -rot u w := by
  unfold rot; rw [Matrix.transpose_sub, Matrix.transpose_vecMulVec, Matrix.transpose_vecMulVec]; abel

theorem dot_skew' {x : Matrix ι ι ℝ} (hx : xᵀ = -x) (u v : ι → ℝ) : u ⬝ᵥ (x *ᵥ v) = -((x *ᵥ u) ⬝ᵥ v) := by
  rw [Matrix.dotProduct_mulVec, ← Matrix.mulVec_transpose, hx, Matrix.neg_mulVec, neg_dotProduct,
    dotProduct_comm]

theorem self_dot_skew {x : Matrix ι ι ℝ} (hx : xᵀ = -x) (u : ι → ℝ) : u ⬝ᵥ (x *ᵥ u) = 0 := by
  have := dot_skew' hx u u
  rw [dotProduct_comm (x *ᵥ u) u] at this
  linarith

/-- **The real normal form of a skew matrix.** Every skew `x` is `Σ_j a_j (w_j u_jᵀ - u_j w_jᵀ)` with
`{u_j, w_j}` orthonormal, every `a_j > 0`, and every `u_j, w_j` in the image of `x`. -/
theorem skew_normal_form : ∀ (n : ℕ) (x : Matrix ι ι ℝ), xᵀ = -x →
    Module.finrank ℝ (LinearMap.range (Matrix.mulVecLin x)) = n →
    ∃ (k : ℕ) (u w : Fin k → ι → ℝ) (a : Fin k → ℝ),
      (∀ j, 0 < a j) ∧
      (∀ i j, u i ⬝ᵥ u j = if i = j then 1 else 0) ∧
      (∀ i j, w i ⬝ᵥ w j = if i = j then 1 else 0) ∧
      (∀ i j, u i ⬝ᵥ w j = 0) ∧
      (∀ j, u j ∈ LinearMap.range (Matrix.mulVecLin x) ∧ w j ∈ LinearMap.range (Matrix.mulVecLin x)) ∧
      x = ∑ j, a j • rot (u j) (w j) := by
  intro n
  induction n using Nat.strong_induction_on with
  | _ n ih =>
  intro x hx hn
  by_cases h0 : x = 0
  · exact ⟨0, Fin.elim0, Fin.elim0, Fin.elim0, fun j => j.elim0, fun i => i.elim0, fun i => i.elim0,
      fun i => i.elim0, fun j => j.elim0, by simp [h0]⟩
  -- a top eigenvector of `xᵀx`
  have hne : Nonempty ι := by
    by_contra hc
    rw [not_nonempty_iff] at hc
    exact h0 (Subsingleton.elim _ _)
  obtain ⟨u, hu1, hmax⟩ := exists_max x
  have hev := max_eigen x hu1 hmax
  set c := nsq (x *ᵥ u) with hc
  have hcpos : 0 < c := by
    rcases (nsq_nonneg (x *ᵥ u)).lt_or_eq with h | h
    · exact h
    · exfalso; apply h0
      ext i j
      have hj := hmax (Pi.single j 1)
      rw [show c = 0 from by rw [hc]; exact h.symm, zero_mul] at hj
      have hz : nsq (x *ᵥ Pi.single j 1) = 0 := le_antisymm hj (nsq_nonneg _)
      have := nsq_eq_zero hz
      have := congrFun this i
      simpa [Matrix.mulVec_single] using this
  set a := Real.sqrt c with ha_def
  have ha : 0 < a := Real.sqrt_pos.mpr hcpos
  have ha2 : a * a = c := Real.mul_self_sqrt hcpos.le
  set w := a⁻¹ • (x *ᵥ u) with hw_def
  have huu : u ⬝ᵥ u = 1 := by rw [← nsq_eq_dot]; exact hu1
  have hxuxu : (x *ᵥ u) ⬝ᵥ (x *ᵥ u) = c := by rw [← nsq_eq_dot]
  have hww : w ⬝ᵥ w = 1 := by
    simp only [w, smul_dotProduct, dotProduct_smul, smul_eq_mul, hxuxu]
    rw [← ha2]; field_simp
  have huw : u ⬝ᵥ w = 0 := by simp [w, dotProduct_smul, self_dot_skew hx]
  have hwu : w ⬝ᵥ u = 0 := by rw [dotProduct_comm]; exact huw
  have hxx : x *ᵥ (x *ᵥ u) = -(c • u) := by
    have h := hev
    rw [hx, Matrix.neg_mulVec] at h
    rw [← h, neg_neg]
  have hxu : x *ᵥ u = a • w := by
    simp only [w, smul_smul, mul_inv_cancel₀ ha.ne', one_smul]
  have hxw : x *ᵥ w = -(a • u) := by
    simp only [w, Matrix.mulVec_smul, hxx, smul_neg, smul_smul]
    rw [← ha2, show a⁻¹ * (a * a) = a by field_simp]
  have humem : u ∈ LinearMap.range (Matrix.mulVecLin x) :=
    ⟨(-c⁻¹) • (x *ᵥ u), by
      simp only [Matrix.mulVecLin_apply, neg_smul, Matrix.mulVec_neg, Matrix.mulVec_smul, hxx, smul_neg, neg_neg, smul_smul,
        inv_mul_cancel₀ hcpos.ne', one_smul]⟩
  have hwmem : w ∈ LinearMap.range (Matrix.mulVecLin x) :=
    ⟨a⁻¹ • u, by simp only [Matrix.mulVecLin_apply, Matrix.mulVec_smul, w]⟩
  set x' := x - a • rot u w with hx'_def
  have hx' : x'ᵀ = -x' := by
    simp only [x', Matrix.transpose_sub, Matrix.transpose_smul, rot_skew, hx, smul_neg]; abel
  have hx'u : x' *ᵥ u = 0 := by
    simp only [x', Matrix.sub_mulVec, Matrix.smul_mulVec, rot_mulVec, huu, hwu, hxu, one_smul, zero_smul,
      sub_zero, sub_self]
  have hx'w : x' *ᵥ w = 0 := by
    simp only [x', Matrix.sub_mulVec, Matrix.smul_mulVec, rot_mulVec, huw, hww, hxw, one_smul, zero_smul,
      zero_sub, smul_neg, sub_neg_eq_add, neg_add_cancel]
  have hsub : LinearMap.range (Matrix.mulVecLin x') ≤ LinearMap.range (Matrix.mulVecLin x) := by
    rintro _ ⟨v, rfl⟩
    simp only [Matrix.mulVecLin_apply, x', Matrix.sub_mulVec, Matrix.smul_mulVec, rot_mulVec]
    refine Submodule.sub_mem _ ⟨v, rfl⟩ (Submodule.smul_mem _ _ (Submodule.sub_mem _
      (Submodule.smul_mem _ _ hwmem) (Submodule.smul_mem _ _ humem)))
  have hperp : ∀ y ∈ LinearMap.range (Matrix.mulVecLin x'), u ⬝ᵥ y = 0 ∧ w ⬝ᵥ y = 0 := by
    rintro _ ⟨v, rfl⟩
    simp only [Matrix.mulVecLin_apply]
    rw [dot_skew' hx', dot_skew' hx', hx'u, hx'w, zero_dotProduct, neg_zero]
    exact ⟨rfl, rfl⟩
  have hlt : LinearMap.range (Matrix.mulVecLin x') < LinearMap.range (Matrix.mulVecLin x) := by
    refine lt_of_le_of_ne hsub fun h => ?_
    have := (hperp u (h ▸ humem)).1
    rw [huu] at this
    exact one_ne_zero this
  have hfin := Submodule.finrank_lt_finrank_of_lt hlt
  obtain ⟨k, u', w', a', hapos, huu', hww', huw', hmem', hsum⟩ := ih _ (hn ▸ hfin) x' hx' rfl
  have hu'perp : ∀ j, u ⬝ᵥ u' j = 0 ∧ w ⬝ᵥ u' j = 0 := fun j => hperp _ (hmem' j).1
  have hw'perp : ∀ j, u ⬝ᵥ w' j = 0 ∧ w ⬝ᵥ w' j = 0 := fun j => hperp _ (hmem' j).2
  refine ⟨k + 1, Fin.cons u u', Fin.cons w w', Fin.cons a a', ?_, ?_, ?_, ?_, ?_, ?_⟩
  · intro j; exact Fin.cases ha (fun j => hapos j) j
  · intro i j
    refine Fin.cases ?_ (fun i => ?_) i <;> refine Fin.cases ?_ (fun j => ?_) j
    · simp [huu]
    · simp [(hu'perp j).1, (Fin.succ_ne_zero j).symm]
    · simp [dotProduct_comm (u' i) u, (hu'perp i).1, Fin.succ_ne_zero i]
    · simp [huu' i j, Fin.succ_inj]
  · intro i j
    refine Fin.cases ?_ (fun i => ?_) i <;> refine Fin.cases ?_ (fun j => ?_) j
    · simp [hww]
    · simp [(hw'perp j).2, (Fin.succ_ne_zero j).symm]
    · simp [dotProduct_comm (w' i) w, (hw'perp i).2, Fin.succ_ne_zero i]
    · simp [hww' i j, Fin.succ_inj]
  · intro i j
    refine Fin.cases ?_ (fun i => ?_) i <;> refine Fin.cases ?_ (fun j => ?_) j
    · simp [huw]
    · simp [(hw'perp j).1]
    · simp [dotProduct_comm (u' i) w, (hu'perp i).2]
    · simp [huw' i j]
  · intro j
    refine Fin.cases ⟨humem, hwmem⟩ (fun j => ⟨hsub (hmem' j).1, hsub (hmem' j).2⟩) j
  · rw [Fin.sum_univ_succ]
    simp only [Fin.cons_zero, Fin.cons_succ]
    rw [← hsum, hx'_def]
    abel

end HamiltonsCubic.SkewNormalForm
