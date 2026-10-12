import HamiltonsCubic.Results.L167Mixed
import HamiltonsCubic.Results.L178Asd

set_option linter.style.longLine false

/-!
# L167's second display on `𝔰𝔬(4)`: the stabiliser of `W_{ℂP²}` is the span of `J₀` and `Λ⁻`

[findings/route-a.md](../../../findings/route-a.md), Lemma L167: `𝔰𝔱𝔞𝔟(u) = 𝔲(2) ⊕ 𝔰𝔬(m)`, the `𝔰𝔬(4)` part being
*"`Λ^∓ ⊕ ℝJ ≅ 𝔰𝔲(2) ⊕ 𝔲(1)`, with `J` the eigenvalue-`2` eigenvector, which is the Kähler form"*. **This file proves the
`𝔰𝔬(4)` part** at `n = 4`, with `ρ(A) = [A, ·]` and [CP2Real.lean](CP2Real.lean)'s `Wc 4`:

* **`Wc_four`**, **`Wc4_J`**: `Wc 4 X = Σ_a ½ μ_a ⟨X, J_a⟩ J_a`, so `Wc 4 J_b = μ_b J_b`;
* **`br_J01`**, **`br_J02`**, **`br_J12`**, **`JK_comm`**, **`inner2_JJ`**, **`inner2_KJ`**, **`skew_JK`**: the `J`–`K` basis
  of `𝔰𝔬(4)` and its brackets;
* **`stab_forward`**: the commuting condition at `X = J₁, J₂` forces `⟨A, J₁⟩ = ⟨A, J₂⟩ = 0`, since `μ₁ = μ₂ ≠ μ₀`;
* **`stab_so4`**: a skew `A` has `[A, Wc X] = Wc [A, X]` for every skew `X` exactly when `A = p J₀ + Σ_a q_a K_a`.

The assembly at every `n`, with the `𝔰𝔬(m)` summand and the mixed block, is [L167Full.lean](L167Full.lean)'s
`stab_full`.
-/

namespace HamiltonsCubic.CP2Real

open Finset Matrix HamiltonsCubic.RealLayer

theorem Emb_four : Emb 4 = 1 := by
  ext p x; fin_cases p <;> fin_cases x <;> simp [Emb, Matrix.one_apply]

theorem om_four (a : Fin 3) : om (n := 4) a = sq2⁻¹ • J a := by
  simp [om, Emb_four]

theorem Wc_four (X : Matrix (Fin 4) (Fin 4) ℝ) :
    Wc 4 X = ∑ a, (mu a * (1 / 2) * inner2 X (J a)) • J a := by
  unfold Wc
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [om_four, HamiltonsCubic.L41Statement.Frame.inner2_smul_r, smul_smul]
  congr 1
  have : sq2⁻¹ * sq2⁻¹ = 1 / 2 := by rw [← mul_inv, ← sq, sq2_sq]; norm_num
  linear_combination (mu a * inner2 X (J a)) * this

theorem br_J01 : J 0 * J 1 - J 1 * J 0 = (2 : ℝ) • J 2 := by
  ext i j; fin_cases i <;> fin_cases j <;> simp [J, Matrix.mul_apply, Fin.sum_univ_four] <;> norm_num
theorem br_J02 : J 0 * J 2 - J 2 * J 0 = (-2 : ℝ) • J 1 := by
  ext i j; fin_cases i <;> fin_cases j <;> simp [J, Matrix.mul_apply, Fin.sum_univ_four] <;> norm_num
theorem br_J12 : J 1 * J 2 - J 2 * J 1 = (2 : ℝ) • J 0 := by
  ext i j; fin_cases i <;> fin_cases j <;> simp [J, Matrix.mul_apply, Fin.sum_univ_four] <;> norm_num

theorem JK_comm (a b : Fin 3) : J a * K b = K b * J a := by
  fin_cases a <;> fin_cases b <;>
    (ext i j; fin_cases i <;> fin_cases j <;> simp [J, K, Kz, Matrix.mul_apply, Fin.sum_univ_four])

theorem inner2_JJ (a b : Fin 3) : inner2 (J a) (J b) = if a = b then 2 else 0 := by
  fin_cases a <;> fin_cases b <;> simp [inner2_eq_sum, J, Fin.sum_univ_four] <;> norm_num

theorem inner2_KJ (a b : Fin 3) : inner2 (K a) (J b) = 0 := by
  fin_cases a <;> fin_cases b <;> simp [inner2_eq_sum, J, K, Kz, Fin.sum_univ_four]

/-- A skew `4 × 4` matrix from its six upper entries. -/
theorem skew_eq (A : Matrix (Fin 4) (Fin 4) ℝ) (hA : IsSkew A) :
    A = !![0, A 0 1, A 0 2, A 0 3; -A 0 1, 0, A 1 2, A 1 3; -A 0 2, -A 1 2, 0, A 2 3;
      -A 0 3, -A 1 3, -A 2 3, 0] := by
  have h : ∀ i j, A j i = -A i j := fun i j => by
    have := congrFun (congrFun hA i) j; simpa [Matrix.transpose_apply] using this
  have hd : ∀ i, A i i = 0 := fun i => by have := h i i; linarith
  ext i j; fin_cases i <;> fin_cases j <;> simp [hd] <;>
    linarith [h 0 1, h 0 2, h 0 3, h 1 2, h 1 3, h 2 3]

theorem Wc4_J (b : Fin 3) : Wc 4 (J b) = mu b • J b := by
  rw [Wc_four, Finset.sum_eq_single b]
  · rw [inner2_JJ, if_pos rfl]; congr 1; ring
  · intro a _ hab; rw [inner2_JJ, if_neg (Ne.symm hab)]; simp
  · simp

theorem Wc4_inner_J (Y : Matrix (Fin 4) (Fin 4) ℝ) (b : Fin 3) : inner2 (Wc 4 Y) (J b) = mu b * inner2 Y (J b) := by
  rw [Wc_four, HamiltonsCubic.L41Statement.Frame.inner2_sum_l, Finset.sum_eq_single b]
  · rw [HamiltonsCubic.L41Statement.Frame.inner2_smul_l, inner2_JJ, if_pos rfl]; ring
  · intro a _ hab; rw [HamiltonsCubic.L41Statement.Frame.inner2_smul_l, inner2_JJ, if_neg hab, mul_zero]
  · simp

theorem pair_J1 (A : Matrix (Fin 4) (Fin 4) ℝ) (hA : IsSkew A) :
    inner2 (A * J 1 - J 1 * A) (J 0) = -2 * inner2 A (J 2) := by
  rw [skew_eq A hA]
  simp [inner2_eq_sum, J, Fin.sum_univ_four]; ring

theorem pair_J2 (A : Matrix (Fin 4) (Fin 4) ℝ) (hA : IsSkew A) :
    inner2 (A * J 2 - J 2 * A) (J 0) = 2 * inner2 A (J 1) := by
  rw [skew_eq A hA]
  simp [inner2_eq_sum, J, Fin.sum_univ_four]; ring

theorem K_lit : K = ![!![0, -1, 0, 0; 1, 0, 0, 0; 0, 0, 0, 1; 0, 0, -1, 0],
    !![0, 0, -1, 0; 0, 0, 0, -1; 1, 0, 0, 0; 0, 1, 0, 0],
    !![0, 0, 0, -1; 0, 0, 1, 0; 0, -1, 0, 0; 1, 0, 0, 0]] := by
  funext a; fin_cases a <;> (ext i j; fin_cases i <;> fin_cases j <;> simp [K, Kz])

set_option maxHeartbeats 4000000 in
-- Sixteen entries, each an expansion of six `inner2` pairings.
/-- **The `J`–`K` basis of `𝔰𝔬(4)`**, coefficients read by `inner2`. -/
theorem skew_JK (A : Matrix (Fin 4) (Fin 4) ℝ) (hA : IsSkew A) :
    A = ∑ b, (inner2 A (J b) / 2) • J b + ∑ a, (inner2 A (K a) / 2) • K a := by
  conv_lhs => rw [skew_eq A hA]
  conv_rhs => rw [skew_eq A hA]
  ext i j; fin_cases i <;> fin_cases j <;>
    simp [inner2_eq_sum, J, K, Kz, Fin.sum_univ_four, Fin.sum_univ_three] <;> ring

theorem J_isSkew (b : Fin 3) : IsSkew (J b) := J_skew b

theorem mu_ne : mu 1 ≠ mu 0 := by
  simp only [mu, Matrix.cons_val_one, Matrix.cons_val_zero]
  have : 0 < Real.sqrt 6 := by positivity
  intro h
  field_simp at h
  linarith

/-- **The commuting condition kills the `J₁`, `J₂` components.** -/
theorem stab_forward (A : Matrix (Fin 4) (Fin 4) ℝ) (hA : IsSkew A)
    (hstab : ∀ X, IsSkew X → A * Wc 4 X - Wc 4 X * A = Wc 4 (A * X - X * A)) :
    inner2 A (J 1) = 0 ∧ inner2 A (J 2) = 0 := by
  have key : ∀ b : Fin 3, b ≠ 0 → (mu b - mu 0) * inner2 (A * J b - J b * A) (J 0) = 0 := by
    intro b hb
    have h := congrArg (fun M => inner2 M (J 0)) (hstab (J b) (J_isSkew b))
    rw [Wc4_inner_J, Wc4_J, Matrix.mul_smul, Matrix.smul_mul, ← smul_sub,
      HamiltonsCubic.L41Statement.Frame.inner2_smul_l] at h
    linarith
  have hmu2 : mu 2 - mu 0 ≠ 0 := by
    have : mu 2 = mu 1 := by simp [mu]
    rw [this]; exact sub_ne_zero.mpr mu_ne
  have k1 := key 1 (by decide)
  have k2 := key 2 (by decide)
  rw [pair_J1 A hA] at k1
  rw [pair_J2 A hA] at k2
  constructor
  · rcases mul_eq_zero.mp k2 with h | h
    · exact absurd h hmu2
    · linarith
  · rcases mul_eq_zero.mp k1 with h | h
    · exact absurd h (sub_ne_zero.mpr mu_ne)
    · linarith

set_option maxHeartbeats 8000000 in
-- The converse expands both sides entrywise over six free entries of `X`.
/-- **L167's second display on `𝔰𝔬(4)`**: `ad A` commutes with `W_{ℂP²}` on bivectors exactly when
`A = p J₀ + Σ q_a K_a`, so the stabiliser is the span of `J₀` and `Λ⁻`, which the record reads as `𝔲(1) ⊕ 𝔰𝔲(2) = 𝔲(2)`. -/
theorem stab_so4 (A : Matrix (Fin 4) (Fin 4) ℝ) (hA : IsSkew A) :
    (∀ X, IsSkew X → A * Wc 4 X - Wc 4 X * A = Wc 4 (A * X - X * A)) ↔
      ∃ (p : ℝ) (q : Fin 3 → ℝ), A = p • J 0 + ∑ a, q a • K a := by
  constructor
  · intro hstab
    obtain ⟨h1, h2⟩ := stab_forward A hA hstab
    refine ⟨inner2 A (J 0) / 2, fun a => inner2 A (K a) / 2, ?_⟩
    conv_lhs => rw [skew_JK A hA]
    rw [Fin.sum_univ_three (fun b => (inner2 A (J b) / 2) • J b), h1, h2]
    simp
  · rintro ⟨p, q, rfl⟩ X hX
    rw [skew_eq X hX, K_lit]
    simp only [Wc_four, Fin.sum_univ_three]
    ext i j; fin_cases i <;> fin_cases j <;>
      simp [inner2_eq_sum, J, mu, Fin.sum_univ_four, Matrix.mul_apply, Matrix.vecMul, dotProduct] <;> ring

end HamiltonsCubic.CP2Real
