import HamiltonsCubic.Results.L178Asd

set_option linter.style.longLine false

/-!
# Quaternion rotations of `Λ⁺ℝ⁴`

Milestone 1 of [the L178 rigidity plan](../../../reviews/2026-09-26-lean-L178-rigidity-plan.md). Reading `ℝ⁴` as the
quaternions with basis `1, i, j, k`, the layer's self-dual structures `J 0, J 1, J 2` are left multiplication by
`i, j, k` and the anti-self-dual `K 0, K 1, K 2` are right multiplication. So left multiplication `L_p` by a
quaternion `p` rotates `Λ⁺` by `u ↦ p u p̄` and commutes with `Λ⁻`:

* **`Lq_mul_transpose`**: `L_p L_pᵀ = |p|² · 1`;
* **`Lq_comm_K`**: `L_p K_a = K_a L_p`;
* **`Lq_conj_J`**: `L_p J_b L_pᵀ` is the combination of `J 0, J 1, J 2` given by `p e_b p̄`, the rotation matrix of `p`;
* **`Lq_to_J0`**: for `u = Σ v_b J_b` and `p = (1 + v₀, 0, v₂, -v₁)`, `L_p u L_pᵀ = (1 - s) u + 2s(1 + v₀) J 0` with
  `s = |v|²`, so at `|v| = 1` the rotation carries `u` to `2(1 + v₀) J 0`;
* **`rot_to_J0`**: for every unit `v` an orthogonal `U` with `U (Σ v_b J_b) Uᵀ = J 0`, `U J_b Uᵀ ∈ span J` and
  `U K_a = K_a U`.
-/

namespace HamiltonsCubic.CP2Real

open Matrix

/-- **Left multiplication by the quaternion `p`** on `ℝ⁴ = ℍ`, in the basis `1, i, j, k`. -/
def Lq (p : Fin 4 → ℝ) : Matrix (Fin 4) (Fin 4) ℝ :=
  !![p 0, -p 1, -p 2, -p 3; p 1, p 0, -p 3, p 2; p 2, p 3, p 0, -p 1; p 3, -p 2, p 1, p 0]

theorem Lq_mul_transpose (p : Fin 4 → ℝ) :
    Lq p * (Lq p)ᵀ = (p 0 ^ 2 + p 1 ^ 2 + p 2 ^ 2 + p 3 ^ 2) • (1 : Matrix (Fin 4) (Fin 4) ℝ) := by
  ext i j; fin_cases i <;> fin_cases j <;> simp [Lq, Matrix.mul_apply, Fin.sum_univ_four] <;> ring

theorem Lq_transpose_mul (p : Fin 4 → ℝ) :
    (Lq p)ᵀ * Lq p = (p 0 ^ 2 + p 1 ^ 2 + p 2 ^ 2 + p 3 ^ 2) • (1 : Matrix (Fin 4) (Fin 4) ℝ) := by
  ext i j; fin_cases i <;> fin_cases j <;> simp [Lq, Matrix.mul_apply, Fin.sum_univ_four] <;> ring

theorem Lq_comm_K (p : Fin 4 → ℝ) (a : Fin 3) : Lq p * K a = K a * Lq p := by
  fin_cases a <;> (ext i j; fin_cases i <;> fin_cases j <;> simp [Lq, K, Kz, Matrix.mul_apply, Fin.sum_univ_four])

/-- The rotation `p e_b p̄` of the pure quaternion `e_b`, as coefficients on `i, j, k`. -/
def rotq (p : Fin 4 → ℝ) : Fin 3 → Fin 3 → ℝ :=
  ![![p 0 ^ 2 + p 1 ^ 2 - p 2 ^ 2 - p 3 ^ 2, 2 * (p 1 * p 2 + p 0 * p 3), 2 * (p 1 * p 3 - p 0 * p 2)],
    ![2 * (p 1 * p 2 - p 0 * p 3), p 0 ^ 2 - p 1 ^ 2 + p 2 ^ 2 - p 3 ^ 2, 2 * (p 2 * p 3 + p 0 * p 1)],
    ![2 * (p 1 * p 3 + p 0 * p 2), 2 * (p 2 * p 3 - p 0 * p 1), p 0 ^ 2 - p 1 ^ 2 - p 2 ^ 2 + p 3 ^ 2]]

set_option maxHeartbeats 4000000 in
-- The entrywise expansion of three `4 × 4` products over `p` exceeds the default budget.
/-- **`L_p J_b L_pᵀ = Σ_c R(p)_{bc} J_c`**: conjugation by `L_p` keeps `Λ⁺` and rotates it. -/
theorem Lq_conj_J (p : Fin 4 → ℝ) (b : Fin 3) :
    Lq p * J b * (Lq p)ᵀ = ∑ c, rotq p b c • J c := by
  fin_cases b <;> (ext i j; fin_cases i <;> fin_cases j <;>
    simp [Lq, J, rotq, Matrix.mul_apply, Fin.sum_univ_four, Fin.sum_univ_three] <;> ring)

set_option maxHeartbeats 4000000 in
-- As above, for the product with `Σ v_b J_b`.
/-- **The rotation carrying `u = Σ v_b J_b` towards `J 0`**, exactly, before normalising `|v|`. -/
theorem Lq_to_J0 (v : Fin 3 → ℝ) :
    Lq ![1 + v 0, 0, v 2, -v 1] * (∑ b, v b • J b) * (Lq ![1 + v 0, 0, v 2, -v 1])ᵀ
      = (1 - (v 0 ^ 2 + v 1 ^ 2 + v 2 ^ 2)) • (∑ b, v b • J b)
        + (2 * (v 0 ^ 2 + v 1 ^ 2 + v 2 ^ 2) * (1 + v 0)) • J 0 := by
  ext i j; fin_cases i <;> fin_cases j <;>
    simp [Lq, J, Matrix.mul_apply, Fin.sum_univ_four, Fin.sum_univ_three] <;> ring

theorem conj_smul (c : ℝ) (U X : Matrix (Fin 4) (Fin 4) ℝ) : (c • U) * X * (c • U)ᵀ = c ^ 2 • (U * X * Uᵀ) := by
  rw [transpose_smul]; simp only [Matrix.smul_mul, Matrix.mul_smul, smul_smul, sq]

/-- A scaled left multiplication `c L_p` with `c²|p|² = 1` is orthogonal, keeps `span J` and commutes with `K`. -/
theorem scaled_Lq (p : Fin 4 → ℝ) (c : ℝ) (hc : c ^ 2 * (p 0 ^ 2 + p 1 ^ 2 + p 2 ^ 2 + p 3 ^ 2) = 1) :
    (c • Lq p)ᵀ * (c • Lq p) = 1 ∧
    (∀ b, ∃ w : Fin 3 → ℝ, (c • Lq p) * J b * (c • Lq p)ᵀ = ∑ d, w d • J d) ∧
    ∀ a, (c • Lq p) * K a = K a * (c • Lq p) := by
  refine ⟨?_, fun b => ⟨fun d => c ^ 2 * rotq p b d, ?_⟩, fun a => ?_⟩
  · rw [transpose_smul, smul_mul_smul_comm, Lq_transpose_mul, smul_smul, ← sq, hc, one_smul]
  · rw [conj_smul, Lq_conj_J, Finset.smul_sum]
    exact Finset.sum_congr rfl fun d _ => by rw [smul_smul]
  · rw [smul_mul_assoc, Lq_comm_K, mul_smul_comm]

/-- **Every unit self-dual form is carried to `J 0`** by an orthogonal `U` that keeps `span J` and commutes
with the anti-self-dual `K`. -/
theorem rot_to_J0 (v : Fin 3 → ℝ) (hv : v 0 ^ 2 + v 1 ^ 2 + v 2 ^ 2 = 1) :
    ∃ U : Matrix (Fin 4) (Fin 4) ℝ, Uᵀ * U = 1 ∧ U * (∑ b, v b • J b) * Uᵀ = J 0 ∧
      (∀ b, ∃ w : Fin 3 → ℝ, U * J b * Uᵀ = ∑ d, w d • J d) ∧ ∀ a, U * K a = K a * U := by
  have hv0 : -1 ≤ v 0 := by nlinarith [sq_nonneg (v 1), sq_nonneg (v 2), sq_nonneg (v 0 + 1)]
  rcases eq_or_lt_of_le hv0 with h | h
  · -- `v = (-1, 0, 0)`: `U = L_j`
    have h0 : v 0 = -1 := h.symm
    have h12 : v 1 = 0 ∧ v 2 = 0 := by
      constructor <;> nlinarith [sq_nonneg (v 1), sq_nonneg (v 2)]
    obtain ⟨o, sp, cm⟩ := scaled_Lq ![0, 0, 1, 0] 1 (by simp)
    refine ⟨(1 : ℝ) • Lq ![0, 0, 1, 0], o, ?_, sp, cm⟩
    rw [one_smul, Fin.sum_univ_three, h0, h12.1, h12.2, zero_smul, zero_smul, add_zero, add_zero, neg_one_smul,
      mul_neg, neg_mul, Lq_conj_J, Fin.sum_univ_three]
    simp [rotq]
  · -- `U = L_p / √(2(1 + v₀))` with `p = (1 + v₀, 0, v₂, -v₁)`
    set p : Fin 4 → ℝ := ![1 + v 0, 0, v 2, -v 1] with hp
    have hpos : 0 < 2 * (1 + v 0) := by linarith
    have hnorm : p 0 ^ 2 + p 1 ^ 2 + p 2 ^ 2 + p 3 ^ 2 = 2 * (1 + v 0) := by
      have e0 : p 0 = 1 + v 0 := rfl
      have e1 : p 1 = 0 := rfl
      have e2 : p 2 = v 2 := rfl
      have e3 : p 3 = -v 1 := rfl
      rw [e0, e1, e2, e3]; nlinarith
    set c : ℝ := 1 / Real.sqrt (2 * (1 + v 0)) with hcdef
    have hc2 : c ^ 2 = 1 / (2 * (1 + v 0)) := by
      rw [hcdef, div_pow, one_pow, Real.sq_sqrt hpos.le]
    have hne : 1 + v 0 ≠ 0 := by linarith
    have hc : c ^ 2 * (p 0 ^ 2 + p 1 ^ 2 + p 2 ^ 2 + p 3 ^ 2) = 1 := by
      rw [hc2, hnorm]; field_simp
    obtain ⟨o, sp, cm⟩ := scaled_Lq p c hc
    refine ⟨c • Lq p, o, ?_, sp, cm⟩
    rw [conj_smul, hp, Lq_to_J0, hv, hc2]
    rw [sub_self, zero_smul, zero_add, smul_smul]
    have : 1 / (2 * (1 + v 0)) * (2 * 1 * (1 + v 0)) = 1 := by field_simp
    rw [this, one_smul]

end HamiltonsCubic.CP2Real
