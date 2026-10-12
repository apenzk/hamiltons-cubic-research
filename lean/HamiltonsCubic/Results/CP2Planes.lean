import HamiltonsCubic.Results.CP2Real

/-!
# The three self-dual forms on any 4-plane, and weighted sums of them

[CP2Real.lean](CP2Real.lean)'s construction with the first four coordinates replaced by any
isometric `E : ℝ⁴ → ℝⁿ` (`EᵀE = 1`) and the weights `(2,-1,-1)/√6` by any `μ` with `Σ μ = 0`.
`WE E μ = Σ_a μ_a ⟨·, ω_a⟩ ω_a` is then a Weyl operator (`WE_weyl`), by the same argument: the three
forms share one cyclic sum, and `ω_aᵀω_a` is one matrix. *This is the building block of
[L34](L34Statement.lean)'s witnesses, two such operators on overlapping 4-planes.*
-/

set_option linter.style.longLine false
set_option linter.unusedSectionVars false
set_option linter.unusedVariables false

namespace HamiltonsCubic.CP2Planes

open Matrix HamiltonsCubic.RealLayer HamiltonsCubic.CP2Real

variable {n : ℕ} {E : Matrix (Fin n) (Fin 4) ℝ} {μ : Fin 3 → ℝ}

noncomputable def omE (E : Matrix (Fin n) (Fin 4) ℝ) (a : Fin 3) : Matrix (Fin n) (Fin n) ℝ := sq2⁻¹ • (E * J a * Eᵀ)


theorem omE_skew (a : Fin 3) : IsSkew (omE E a) := by
  unfold IsSkew omE
  rw [Matrix.transpose_smul, Matrix.transpose_mul, Matrix.transpose_mul, Matrix.transpose_transpose,
    J_skew]
  simp [Matrix.mul_assoc, Matrix.neg_mul, Matrix.mul_neg]

theorem omE_entry (a : Fin 3) (p q : Fin n) :
    omE E a q p = sq2⁻¹ * dotProduct (fun x => E q x) (J a *ᵥ fun x => E p x) := by
  simp only [omE, Matrix.smul_apply, smul_eq_mul, Matrix.mul_apply, Matrix.transpose_apply, dotProduct,
    Matrix.mulVec, Finset.sum_mul, Finset.mul_sum]
  rw [Finset.sum_comm]
  exact Finset.sum_congr rfl fun x _ => Finset.sum_congr rfl fun y _ => by ring

theorem conjT (A : Matrix (Fin 4) (Fin 4) ℝ) : (E * A * (E)ᵀ)ᵀ = E * Aᵀ * (E)ᵀ := by
  rw [Matrix.transpose_mul, Matrix.transpose_mul, Matrix.transpose_transpose, Matrix.mul_assoc]

theorem sandwich (hE : Eᵀ * E = 1) (A B : Matrix (Fin 4) (Fin 4) ℝ) :
    E * A * (E)ᵀ * (E * B * (E)ᵀ) = E * (A * B) * (E)ᵀ := by
  rw [show E * A * (E)ᵀ * (E * B * (E)ᵀ)
      = E * A * ((E)ᵀ * E) * B * (E)ᵀ by simp only [Matrix.mul_assoc],
    hE, Matrix.mul_one]
  simp only [Matrix.mul_assoc]

theorem omE_inner (hE : Eᵀ * E = 1) (a b : Fin 3) : inner2 (omE E a) (omE E b) = if a = b then 1 else 0 := by
  have h : (omE E a)ᵀ * omE E b = (sq2⁻¹ * sq2⁻¹) • (E * ((J a)ᵀ * J b) * (E)ᵀ) := by
    unfold omE
    rw [Matrix.transpose_smul, conjT, Matrix.smul_mul, Matrix.mul_smul, smul_smul, sandwich hE]
  unfold inner2
  rw [h, Matrix.trace_smul, Matrix.trace_mul_comm, ← Matrix.mul_assoc, hE, Matrix.one_mul, J_inner,
    smul_eq_mul]
  have := sq2_sq
  have := sq2_pos
  split_ifs
  · field_simp; linarith
  · simp

theorem omE_br (hE : Eᵀ * E = 1) (a b : Fin 3) :
    br (omE E a) (omE E b) = (sq2⁻¹ * sq2⁻¹) • (E * (J a * J b - J b * J a) * (E)ᵀ) := by
  unfold br omE
  rw [Matrix.smul_mul, Matrix.mul_smul, smul_smul, sandwich hE, Matrix.smul_mul, Matrix.mul_smul, smul_smul,
    sandwich hE, ← smul_sub, Matrix.mul_sub, Matrix.sub_mul]

theorem omE_sq (hE : Eᵀ * E = 1) (a : Fin 3) :
    (omE E a)ᵀ * omE E a = (sq2⁻¹ * sq2⁻¹) • (E * (E)ᵀ) := by
  unfold omE
  rw [Matrix.transpose_smul, conjT, Matrix.smul_mul, Matrix.mul_smul, smul_smul, sandwich hE, J_orth,
    Matrix.mul_one]

theorem omE_cyc (a : Fin 3) (i j k l : Fin n) :
    omE E a j i * omE E a l k + omE E a k i * omE E a j l + omE E a l i * omE E a k j
      = sq2⁻¹ * sq2⁻¹ * ∑ x, ∑ y, ∑ z, ∑ t, E i x * E j y * E k z * E l t * cyc (J a) x y z t := by
  rw [omE_entry a i j, omE_entry a k l, omE_entry a i k, omE_entry a l j, omE_entry a i l, omE_entry a j k]
  set ri : Fin 4 → ℝ := fun x => E i x
  set rj : Fin 4 → ℝ := fun x => E j x
  set rk : Fin 4 → ℝ := fun x => E k x
  set rl : Fin 4 → ℝ := fun x => E l x
  calc _ = sq2⁻¹ * sq2⁻¹ * (dotProduct rj (J a *ᵥ ri) * dotProduct rl (J a *ᵥ rk)
        + dotProduct rk (J a *ᵥ ri) * dotProduct rj (J a *ᵥ rl)
        + dotProduct rl (J a *ᵥ ri) * dotProduct rk (J a *ᵥ rj)) := by ring
    _ = _ := by
      rw [HamiltonsCubic.L30Statement.e1, HamiltonsCubic.L30Statement.e2, HamiltonsCubic.L30Statement.e3]
      congr 1
      simp only [← Finset.sum_add_distrib]
      refine Finset.sum_congr rfl fun x _ => Finset.sum_congr rfl fun y _ =>
        Finset.sum_congr rfl fun z _ => Finset.sum_congr rfl fun t _ => ?_
      simp only [cyc, ri, rj, rk, rl]; ring

/-! ## The operator -/


/-- **`W_{ℂP²}` on `ℝⁿ`**, padded by zero off the first four coordinates. -/
noncomputable def WE (E : Matrix (Fin n) (Fin 4) ℝ) (μ : Fin 3 → ℝ) (X : Matrix (Fin n) (Fin n) ℝ) : Matrix (Fin n) (Fin n) ℝ :=
  ∑ a, (μ a * inner2 X (omE E a)) • omE E a

theorem WE_inner (X Y : Matrix (Fin n) (Fin n) ℝ) :
    inner2 (WE E μ X) Y = ∑ a, μ a * inner2 X (omE E a) * inner2 (omE E a) Y := by
  unfold WE
  rw [HamiltonsCubic.L41Statement.Frame.inner2_sum_l]
  exact Finset.sum_congr rfl fun a _ => by rw [HamiltonsCubic.L41Statement.Frame.inner2_smul_l]

theorem WE_weyl (hE : Eᵀ * E = 1) (hμ : ∑ a, μ a = 0) : IsWeyl (WE E μ) := by
  have hphi : ∀ a i j, inner2 (phi i j) (omE E a) = omE E a j i := fun a i j => by
    rw [inner2_comm, inner2_phi _ (omE_skew a), HamiltonsCubic.L30Statement.skew_entry (omE_skew a)]
    ring
  refine ⟨fun X _ => ?_, fun X Y _ _ => ?_, fun i j k l => ?_, fun a b => ?_⟩
  · unfold WE
    exact HamiltonsCubic.L41Statement.Frame.isSkew_sum _ _ _ fun a => omE_skew a
  · rw [WE_inner, inner2_comm X, WE_inner]
    exact Finset.sum_congr rfl fun a _ => by rw [inner2_comm (omE E a) Y, inner2_comm X (omE E a)]; ring
  · unfold bianchi
    simp only [WE_inner, hphi, inner2_comm (omE E _) (phi _ _)]
    rw [← Finset.sum_add_distrib, ← Finset.sum_add_distrib]
    calc _ = ∑ a, μ a * (sq2⁻¹ * sq2⁻¹ * ∑ x, ∑ y, ∑ z, ∑ t,
          E i x * E j y * E k z * E l t * cyc (J 0) x y z t) := by
          refine Finset.sum_congr rfl fun a _ => ?_
          have h := omE_cyc (E := E) a i j k l
          simp only [cyc_eq] at h
          rw [← h]
          ring
      _ = 0 := by rw [← Finset.sum_mul, hμ, zero_mul]
  · unfold Ric
    simp only [WE_inner, hphi, inner2_comm (omE E _) (phi _ _)]
    rw [Finset.sum_comm]
    calc _ = ∑ α, μ α * (sq2⁻¹ * sq2⁻¹ * ∑ j, E a j * E b j) := by
          refine Finset.sum_congr rfl fun α _ => ?_
          have h := congrFun (congrFun (omE_sq hE α) a) b
          simp only [Matrix.mul_apply, Matrix.transpose_apply, Matrix.smul_apply, smul_eq_mul] at h
          rw [← h, Finset.mul_sum]
          exact Finset.sum_congr rfl fun c _ => by ring
      _ = 0 := by rw [← Finset.sum_mul, hμ, zero_mul]


/-! ## The brackets, in Levi-Civita form -/

theorem WE_om (hE : Eᵀ * E = 1) (b : Fin 3) : WE E μ (omE E b) = μ b • omE E b := by
  unfold WE
  simp only [omE_inner hE, mul_ite, mul_one, mul_zero, ite_smul, zero_smul, Finset.sum_ite_eq, Finset.mem_univ,
    if_true]

/-- **A sum of Weyl operators is Weyl**, every defining condition being linear. -/
theorem weyl_add {W₁ W₂ : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ} (h₁ : IsWeyl W₁)
    (h₂ : IsWeyl W₂) : IsWeyl (fun X => W₁ X + W₂ X) := by
  refine ⟨fun X hX => ?_, fun X Y hX hY => ?_, fun i j k l => ?_, fun a b => ?_⟩
  · have a1 := h₁.1 X hX; have a2 := h₂.1 X hX
    unfold IsSkew at *; rw [Matrix.transpose_add, a1, a2, neg_add]
  · simp only [HamiltonsCubic.L41Statement.Frame.inner2_add_l, inner2_comm X (W₁ Y + W₂ Y),
      HamiltonsCubic.L41Statement.Frame.inner2_add_l]
    rw [h₁.2.1 X Y hX hY, h₂.2.1 X Y hX hY, inner2_comm (W₁ Y), inner2_comm (W₂ Y)]
  · have b1 := h₁.2.2.1 i j k l; have b2 := h₂.2.2.1 i j k l
    unfold bianchi at *
    simp only [HamiltonsCubic.L41Statement.Frame.inner2_add_l]
    linarith
  · have r1 := h₁.2.2.2 a b; have r2 := h₂.2.2.2 a b
    unfold Ric at *
    simp only [HamiltonsCubic.L41Statement.Frame.inner2_add_l, Finset.sum_add_distrib]
    linarith

end HamiltonsCubic.CP2Planes
