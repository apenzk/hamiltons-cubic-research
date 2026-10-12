import HamiltonsCubic.Results.L17WeylUpper

set_option linter.style.longLine false

/-!
# L178, step 1: rank at most three forces (anti-)self-duality

[diagonal-half.md](../../../findings/diagonal-half.md), Lemma L178, step 1: *"On `Λ²V` the operator splits as `W⁺ ⊕ W⁻`
with each summand self-adjoint and trace-free on a three-dimensional space, so each has rank `0`, `2` or `3`, never `1`.
A total rank of at most three therefore forces one summand to vanish."* Here `V = ℝ⁴`, in the bivector model of
[L17WeylDim.lean](L17WeylDim.lean): a Weyl operator is a symmetric `W` on `Λ²ℝ⁴` with `Alt(W) = 0` and `Ric(W) = 0`.

- `P01`, …, `P23`, `cphi`, `cphi_swap`, `cphi_self` and the table `c01`, …, `c33`: `coords (φ_ij)` in the basis `e_p`;
- `om4p`, `om4m`: the self-dual bivectors `e₀₁ + e₂₃`, `e₀₂ − e₁₃`, `e₀₃ + e₁₂` and the anti-self-dual
  `e₀₁ − e₂₃`, `e₀₂ + e₁₃`, `e₀₃ − e₁₂`, the `±1` eigenvectors of the Hodge star (`⋆e₀₁ = e₂₃`, `⋆e₀₂ = −e₁₃`,
  `⋆e₀₃ = e₁₂`);
- **`mixed_zero`**: Ricci-flatness kills the mixed block `⟨ω⁺_i, W ω⁻_j⟩`, so `W = W⁺ ⊕ W⁻`;
- **`trace_blocks`**: each block is trace-free, Ricci-flatness giving the sum and first Bianchi the difference;
- `eq_zero_of_minors`, `exists_minor`, `two_by_two`: a nonzero symmetric trace-free `3 × 3` block has a nonzero
  `2 × 2` minor, so rank at least two;
- **`L178_split`**: if `rank W ≤ 3` then `W⁺ = 0` or `W⁻ = 0`.
-/

namespace HamiltonsCubic.L17Deriv

open Module HamiltonsCubic.RealLayer HamiltonsCubic.AltLayer HamiltonsCubic.BivModel

/-! ## Coordinates on `Λ²ℝ⁴` -/

/-- The six coordinate bivectors `e_{ij}`, `i < j`. -/
def P01 : Pairs 4 := ⟨(0, 1), by decide⟩
def P02 : Pairs 4 := ⟨(0, 2), by decide⟩
def P03 : Pairs 4 := ⟨(0, 3), by decide⟩
def P12 : Pairs 4 := ⟨(1, 2), by decide⟩
def P13 : Pairs 4 := ⟨(1, 3), by decide⟩
def P23 : Pairs 4 := ⟨(2, 3), by decide⟩

theorem cphi (i j : Fin 4) (h : i < j) : coords (phi i j) = ep ⟨(i, j), h⟩ := by
  rw [show phi i j = phi (⟨(i, j), h⟩ : Pairs 4).1.1 (⟨(i, j), h⟩ : Pairs 4).1.2 from rfl, coords_phi_eq_basis, EuclideanSpace.basisFun_apply]; rfl

theorem cphi_swap (i j : Fin 4) (h : i < j) : coords (phi j i) = -ep ⟨(i, j), h⟩ := by
  rw [phi_swap, coords_neg, cphi i j h]

theorem cphi_self (i : Fin 4) : coords (phi i i) = 0 := by
  have h := phi_swap i i
  have : phi i i = 0 := by
    have h2 : (2 : ℝ) • phi i i = 0 := by rw [two_smul]; nth_rewrite 1 [h]; exact neg_add_cancel _
    exact (smul_eq_zero.mp h2).resolve_left (by norm_num)
  rw [this]; ext p; simp [coords_apply, inner2]

theorem c01 : coords (phi (0 : Fin 4) 1) = ep P01 := cphi 0 1 (by decide)
theorem c10 : coords (phi (1 : Fin 4) 0) = -ep P01 := cphi_swap 0 1 (by decide)
theorem c02 : coords (phi (0 : Fin 4) 2) = ep P02 := cphi 0 2 (by decide)
theorem c20 : coords (phi (2 : Fin 4) 0) = -ep P02 := cphi_swap 0 2 (by decide)
theorem c03 : coords (phi (0 : Fin 4) 3) = ep P03 := cphi 0 3 (by decide)
theorem c30 : coords (phi (3 : Fin 4) 0) = -ep P03 := cphi_swap 0 3 (by decide)
theorem c12 : coords (phi (1 : Fin 4) 2) = ep P12 := cphi 1 2 (by decide)
theorem c21 : coords (phi (2 : Fin 4) 1) = -ep P12 := cphi_swap 1 2 (by decide)
theorem c13 : coords (phi (1 : Fin 4) 3) = ep P13 := cphi 1 3 (by decide)
theorem c31 : coords (phi (3 : Fin 4) 1) = -ep P13 := cphi_swap 1 3 (by decide)
theorem c23 : coords (phi (2 : Fin 4) 3) = ep P23 := cphi 2 3 (by decide)
theorem c32 : coords (phi (3 : Fin 4) 2) = -ep P23 := cphi_swap 2 3 (by decide)
theorem c00 : coords (phi (0 : Fin 4) 0) = 0 := cphi_self 0
theorem c11 : coords (phi (1 : Fin 4) 1) = 0 := cphi_self 1
theorem c22 : coords (phi (2 : Fin 4) 2) = 0 := cphi_self 2
theorem c33 : coords (phi (3 : Fin 4) 3) = 0 := cphi_self 3

/-- The self-dual bivectors `e₀₁ + e₂₃`, `e₀₂ − e₁₃`, `e₀₃ + e₁₂`. -/
noncomputable def om4p : Fin 3 → Biv 4 := ![ep P01 + ep P23, ep P02 - ep P13, ep P03 + ep P12]
/-- The anti-self-dual bivectors `e₀₁ − e₂₃`, `e₀₂ + e₁₃`, `e₀₃ − e₁₂`. -/
noncomputable def om4m : Fin 3 → Biv 4 := ![ep P01 - ep P23, ep P02 + ep P13, ep P03 - ep P12]

variable {W : Biv 4 →ₗ[ℝ] Biv 4}

theorem symm_ep (hS : W.IsSymmetric) (p q : Pairs 4) : inner ℝ (ep p) (W (ep q)) = inner ℝ (ep q) (W (ep p)) := by
  rw [← hS, real_inner_comm]

/-- **Ricci-flatness kills the mixed block** `⟨ω⁺_i, W ω⁻_j⟩`. -/
theorem mixed_zero (hS : W.IsSymmetric) (hR : ric W = 0) (i j : Fin 3) : inner ℝ (om4p i) (W (om4m j)) = 0 := by
  have r : ∀ a b : Fin 4, ric W a b = 0 := fun a b => congrFun (congrFun hR a) b
  have r00 := r 0 0; have r01 := r 0 1; have r02 := r 0 2; have r03 := r 0 3; have r11 := r 1 1
  have r12 := r 1 2; have r13 := r 1 3; have r22 := r 2 2; have r23 := r 2 3; have r33 := r 3 3
  simp only [ric, compOf, Fin.sum_univ_four, c00, c01, c02, c03, c10, c11, c12, c13, c20, c21, c22, c23, c30, c31, c32, c33, map_neg, map_zero, inner_neg_left, inner_neg_right,
    inner_zero_left, inner_zero_right, neg_neg, add_zero, zero_add] at r00 r01 r02 r03 r11 r12 r13 r22 r23 r33
  have s := symm_ep hS
  fin_cases i <;> fin_cases j <;>
    simp only [om4p, om4m, Fin.zero_eta, Fin.mk_one, Fin.reduceFinMk, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two, Matrix.vecHead, Matrix.vecTail, Function.comp_apply, Fin.succ_zero_eq_one, Fin.isValue,
      map_add, map_sub, inner_add_left, inner_add_right, inner_sub_left, inner_sub_right] <;>
    linarith [s P01 P02, s P01 P03, s P01 P12, s P01 P13, s P01 P23, s P02 P03, s P02 P12, s P02 P13, s P02 P23,
      s P03 P12, s P03 P13, s P03 P23, s P12 P13, s P12 P23, s P13 P23]

/-- **Each summand is trace-free**: Ricci-flatness gives the total trace, first Bianchi the difference. -/
theorem trace_blocks (hS : W.IsSymmetric) (hA : alt4 (compOf W) = 0) (hR : ric W = 0) :
    ∑ i, inner ℝ (om4p i) (W (om4p i)) = 0 ∧ ∑ i, inner ℝ (om4m i) (W (om4m i)) = 0 := by
  have r : ∀ a b : Fin 4, ric W a b = 0 := fun a b => congrFun (congrFun hR a) b
  have r00 := r 0 0; have r11 := r 1 1; have r22 := r 2 2; have r33 := r 3 3
  have hb := congrFun (congrFun (congrFun (congrFun hA 0) 1) 2) 3
  simp only [ric, alt4, compOf, Fin.sum_univ_four, c00, c01, c02, c03, c10, c11, c12, c13, c20, c21, c22, c23, c30, c31, c32, c33, map_neg, map_zero, inner_neg_left, inner_neg_right,
    inner_zero_right, neg_neg, add_zero, zero_add, Pi.zero_apply] at r00 r11 r22 r33 hb
  have s := symm_ep hS
  simp only [Fin.sum_univ_three, om4p, om4m, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two, Matrix.vecHead, Matrix.vecTail, Function.comp_apply, Fin.succ_zero_eq_one, Fin.isValue, map_add, map_sub, inner_add_left, inner_add_right, inner_sub_left,
    inner_sub_right]
  constructor <;> linarith [s P01 P02, s P01 P03, s P01 P12, s P01 P13, s P01 P23, s P02 P03, s P02 P12, s P02 P13, s P02 P23, s P03 P12, s P03 P13, s P03 P23, s P12 P13, s P12 P23, s P13 P23]

/-- **A symmetric trace-free `3 × 3` array with every `2 × 2` minor zero vanishes.** -/
theorem eq_zero_of_minors {B : Fin 3 → Fin 3 → ℝ} (hB : ∀ i j, B i j = B j i) (htr : B 0 0 + B 1 1 + B 2 2 = 0)
    (hm : ∀ i₁ i₂ j₁ j₂, B i₁ j₁ * B i₂ j₂ - B i₁ j₂ * B i₂ j₁ = 0) : ∀ i j, B i j = 0 := by
  have m01 := hm 0 1 0 1; have m02 := hm 0 2 0 2; have m12 := hm 1 2 1 2
  rw [hB 1 0] at m01; rw [hB 2 0] at m02; rw [hB 2 1] at m12
  have h2 : B 2 2 = -B 0 0 - B 1 1 := by linarith
  rw [h2] at m02 m12
  have key : B 0 0 ^ 2 + B 0 0 * B 1 1 + B 1 1 ^ 2 + B 0 1 ^ 2 + B 0 2 ^ 2 + B 1 2 ^ 2 = 0 := by nlinarith
  have ha : B 0 0 = 0 := by
    nlinarith [sq_nonneg (B 0 0 + B 1 1), sq_nonneg (B 0 0), sq_nonneg (B 1 1), sq_nonneg (B 0 1), sq_nonneg (B 0 2), sq_nonneg (B 1 2)]
  have hd : B 1 1 = 0 := by
    nlinarith [sq_nonneg (B 0 0 + B 1 1), sq_nonneg (B 0 0), sq_nonneg (B 1 1), sq_nonneg (B 0 1), sq_nonneg (B 0 2), sq_nonneg (B 1 2)]
  have hb : B 0 1 = 0 := by nlinarith [sq_nonneg (B 0 1)]
  have hc : B 0 2 = 0 := by nlinarith [sq_nonneg (B 0 2)]
  have he : B 1 2 = 0 := by nlinarith [sq_nonneg (B 1 2)]
  intro i j
  fin_cases i <;> fin_cases j <;> simp only [Fin.zero_eta, Fin.mk_one, Fin.reduceFinMk, Fin.isValue] <;>
    first | assumption | (rw [hB]; assumption) | linarith

theorem mixed_zero' (hS : W.IsSymmetric) (hR : ric W = 0) (i j : Fin 3) : inner ℝ (om4m i) (W (om4p j)) = 0 := by
  rw [← hS, real_inner_comm]; exact mixed_zero hS hR j i

theorem exists_minor {B : Fin 3 → Fin 3 → ℝ} (hB : ∀ i j, B i j = B j i) (htr : B 0 0 + B 1 1 + B 2 2 = 0)
    (hne : ∃ i j, B i j ≠ 0) : ∃ i₁ i₂ j₁ j₂, B i₁ j₁ * B i₂ j₂ - B i₁ j₂ * B i₂ j₁ ≠ 0 := by
  by_contra h
  push Not at h
  obtain ⟨i, j, hij⟩ := hne
  exact hij (eq_zero_of_minors hB htr h i j)

/-- Two linear equations with nonzero determinant force both unknowns to vanish. -/
theorem two_by_two {a b c d x y : ℝ} (hdet : a * d - b * c ≠ 0) (h1 : x * a + y * b = 0) (h2 : x * c + y * d = 0) :
    x = 0 ∧ y = 0 := by
  constructor
  · have : x * (a * d - b * c) = 0 := by linear_combination d * h1 - b * h2
    exact (mul_eq_zero.mp this).resolve_right hdet
  · have : y * (a * d - b * c) = 0 := by linear_combination a * h2 - c * h1
    exact (mul_eq_zero.mp this).resolve_right hdet

/-- **L178, step 1: a Weyl operator on `Λ²ℝ⁴` of rank at most three is self-dual or anti-self-dual**: one of its
blocks `W⁺ = (⟨ω⁺_i, W ω⁺_j⟩)` and `W⁻ = (⟨ω⁻_i, W ω⁻_j⟩)` vanishes. -/
theorem L178_split (hS : W.IsSymmetric) (hA : alt4 (compOf W) = 0) (hR : ric W = 0)
    (hrank : finrank ℝ (LinearMap.range W) ≤ 3) :
    (∀ i j, inner ℝ (om4p i) (W (om4p j)) = 0) ∨ (∀ i j, inner ℝ (om4m i) (W (om4m j)) = 0) := by
  by_contra h
  push Not at h
  obtain ⟨hp, hm⟩ := h
  have symB : ∀ (v : Fin 3 → Biv 4) i j, inner ℝ (v i) (W (v j)) = inner ℝ (v j) (W (v i)) := fun v i j => by
    rw [← hS, real_inner_comm]
  obtain ⟨htp, htm⟩ := trace_blocks hS hA hR
  simp only [Fin.sum_univ_three] at htp htm
  obtain ⟨i₁, i₂, j₁, j₂, hdp⟩ := exists_minor (B := fun i j => inner ℝ (om4p i) (W (om4p j))) (symB om4p) htp hp
  obtain ⟨k₁, k₂, l₁, l₂, hdm⟩ := exists_minor (B := fun i j => inner ℝ (om4m i) (W (om4m j))) (symB om4m) htm hm
  let v : Fin 4 → LinearMap.range W := ![⟨W (om4p j₁), ⟨_, rfl⟩⟩, ⟨W (om4p j₂), ⟨_, rfl⟩⟩, ⟨W (om4m l₁), ⟨_, rfl⟩⟩,
    ⟨W (om4m l₂), ⟨_, rfl⟩⟩]
  have hli : LinearIndependent ℝ v := by
    rw [Fintype.linearIndependent_iff]
    intro c hc
    have hc' : c 0 • W (om4p j₁) + c 1 • W (om4p j₂) + c 2 • W (om4m l₁) + c 3 • W (om4m l₂) = 0 := by
      have := congrArg Subtype.val hc
      simpa [Fin.sum_univ_four, v] using this
    have e : ∀ x : Biv 4, inner ℝ x (c 0 • W (om4p j₁) + c 1 • W (om4p j₂) + c 2 • W (om4m l₁) + c 3 • W (om4m l₂)) = 0 :=
      fun x => by rw [hc', inner_zero_right]
    have ep1 := e (om4p i₁); have ep2 := e (om4p i₂); have em1 := e (om4m k₁); have em2 := e (om4m k₂)
    simp only [inner_add_right, real_inner_smul_right, mixed_zero hS hR, mixed_zero' hS hR, mul_zero, add_zero,
      zero_add] at ep1 ep2 em1 em2
    obtain ⟨h0, h1⟩ := two_by_two hdp ep1 ep2
    obtain ⟨h2, h3⟩ := two_by_two hdm em1 em2
    intro t; fin_cases t <;> assumption
  have := hli.fintype_card_le_finrank
  simp at this
  omega

end HamiltonsCubic.L17Deriv
