import HamiltonsCubic.Results.L178Quat
import HamiltonsCubic.Results.FrameTransfer

set_option linter.style.longLine false

/-!
# L178's equality case

Milestones 2 and 3 of [the L178 rigidity plan](../../../reviews/2026-09-26-lean-L178-rigidity-plan.md). An operator
`Σ_a μ_a ⟨·, ω_a⟩ ω_a` over an orthonormal triple is `Wtrip ω μ`, and every `WF` and `W_c` is one:

* **`conjOp_Wtrip`**: a frame change conjugates the triple, `U·Wtrip ω μ = Wtrip (UωUᵀ) μ`;
* **`proj_inv`**: two orthonormal triples spanning the same space give the same projection `Σ_a ⟨·, ω_a⟩ ω_a`;
* **`Wtrip_top`**: at the equality spectrum `s(2, -1, -1)`, `Wtrip ω μ = 3s⟨·, ω_{a₀}⟩ω_{a₀} - s·Σ_a ⟨·, ω_a⟩ω_a`;
* **`Upad`**, **`Upad_orth`**, **`Upad_conj`**: a `4 × 4` orthogonal `U` padded by the identity is orthogonal on `ℝⁿ`
  and conjugates `Emb F Embᵀ` to `Emb (UFUᵀ) Embᵀ`.

Milestone 4, the assembly:

* **`rigid_sd`**: an orthonormal triple in the span of the standard self-dual forms, at the equality spectrum, is
  `s√6 · W_c` after the padded quaternion rotation of [L178Quat.lean](L178Quat.lean)'s `rot_to_J0`;
* **`top_of_eq`**, **`WF_eq_top`**: `θ = √(3/2)` at a frame operator forces the spectrum `s(2, -1, -1)` with
  `s > 0`, the sign coming from `θ > 0`;
* **`D4_K`**, **`rigid_rot_asd`**: the reflection `diag(1, 1, 1, -1)` carries the anti-self-dual frame to
  `(J 0, J 1, -J 2)`, which reduces the mirror to the self-dual case;
* **`theta_smul_Wc`**: `θ(t W_c) = √(3/2)` for `t > 0`, the converse;
* **`L178_padded_eq_iff`**, **`L178_supported_eq_iff`**, **`L178_frame_eq_iff`**: **L178's equality clause**, for
  `W_C`, for the operator supported on the coordinate `Λ²ℝ⁴`, and for every four-dimensional `V`: `θ = √(3/2)`
  exactly when the operator is a positive multiple of `W_c` after an orthogonal frame change, on bivectors.
-/

namespace HamiltonsCubic.CP2Real

open Matrix HamiltonsCubic.RealLayer HamiltonsCubic.FrameLayer

variable {n : ℕ}

/-- `Σ_a μ_a ⟨·, ω_a⟩ ω_a`. -/
noncomputable def Wtrip (ω : Fin 3 → Matrix (Fin n) (Fin n) ℝ) (μ : Fin 3 → ℝ) (X : Matrix (Fin n) (Fin n) ℝ) :
    Matrix (Fin n) (Fin n) ℝ :=
  ∑ a, (μ a * inner2 X (ω a)) • ω a

theorem WF_eq_Wtrip (Φ : SUFrame) (μ : Fin 3 → ℝ) : WF Φ n μ = Wtrip (omF Φ) μ := rfl

theorem Wc_eq_Wtrip : Wc n = Wtrip om mu := rfl

/-- **A frame change conjugates the triple.** -/
theorem conjOp_Wtrip {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U) (ω : Fin 3 → Matrix (Fin n) (Fin n) ℝ)
    (μ : Fin 3 → ℝ) : conjOp U (Wtrip ω μ) = Wtrip (fun a => U * ω a * Uᵀ) μ := by
  funext X
  unfold conjOp Wtrip
  rw [Matrix.mul_sum, Matrix.sum_mul]
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [Matrix.mul_smul, Matrix.smul_mul]
  congr 2
  rw [inner2_comm X, inner2_move hU, inner2_comm]

/-- **The projection onto an orthonormal triple's span is basis-free.** -/
theorem proj_inv (ω ω' : Fin 3 → Matrix (Fin n) (Fin n) ℝ) (c : Fin 3 → Fin 3 → ℝ)
    (hω : ∀ a b, inner2 (ω a) (ω b) = if a = b then 1 else 0)
    (hω' : ∀ a b, inner2 (ω' a) (ω' b) = if a = b then 1 else 0)
    (hc : ∀ a, ω' a = ∑ b, c a b • ω b) (X : Matrix (Fin n) (Fin n) ℝ) :
    ∑ a, inner2 X (ω' a) • ω' a = ∑ a, inner2 X (ω a) • ω a := by
  -- the coefficient matrix has orthonormal rows, so orthonormal columns
  have hrow : ∀ a b, ∑ d, c a d * c b d = if a = b then 1 else 0 := fun a b => by
    rw [← hω' a b, hc a, hc b, HamiltonsCubic.L41Statement.Frame.inner2_sum_l]
    refine Finset.sum_congr rfl fun d _ => ?_
    rw [HamiltonsCubic.L41Statement.Frame.inner2_smul_l, HamiltonsCubic.L41Statement.Frame.inner2_sum_r]
    rw [Finset.sum_eq_single d]
    · rw [HamiltonsCubic.L41Statement.Frame.inner2_smul_r, hω, if_pos rfl]; ring
    · intro e _ he; rw [HamiltonsCubic.L41Statement.Frame.inner2_smul_r, hω, if_neg (Ne.symm he), mul_zero]
    · intro h; exact absurd (Finset.mem_univ d) h
  have hC : (Matrix.of c) * (Matrix.of c)ᵀ = 1 := by
    ext a b; simp only [Matrix.mul_apply, Matrix.transpose_apply, Matrix.of_apply, Matrix.one_apply]; exact hrow a b
  have hC' : (Matrix.of c)ᵀ * (Matrix.of c) = 1 := mul_eq_one_comm.mp hC
  have hcol : ∀ d e, ∑ a, c a d * c a e = if d = e then 1 else 0 := fun d e => by
    have := congrFun (congrFun hC' d) e
    simpa [Matrix.mul_apply, Matrix.transpose_apply, Matrix.one_apply] using this
  have hL : ∀ a, inner2 X (ω' a) • ω' a = ∑ d, ∑ e, (c a d * c a e * inner2 X (ω d)) • ω e := fun a => by
    rw [hc a, HamiltonsCubic.L41Statement.Frame.inner2_sum_r, Finset.sum_smul]
    refine Finset.sum_congr rfl fun d _ => ?_
    rw [HamiltonsCubic.L41Statement.Frame.inner2_smul_r, Finset.smul_sum]
    exact Finset.sum_congr rfl fun e _ => by rw [smul_smul]; ring_nf
  simp only [hL]
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun d _ => ?_
  rw [Finset.sum_comm]
  rw [Finset.sum_eq_single d]
  · rw [← Finset.sum_smul]
    congr 1
    rw [← Finset.sum_mul, hcol d d, if_pos rfl, one_mul]
  · intro e _ he
    rw [← Finset.sum_smul]
    rw [show (∑ a, c a d * c a e * inner2 X (ω d)) = (∑ a, c a d * c a e) * inner2 X (ω d) from
      (Finset.sum_mul _ _ _).symm, hcol d e, if_neg (Ne.symm he), zero_mul, zero_smul]
  · intro h; exact absurd (Finset.mem_univ d) h

/-- **The equality spectrum**: at `μ = s(2, -1, -1)` with the `2` at `a₀`,
`Wtrip ω μ = 3s⟨·, ω_{a₀}⟩ω_{a₀} - s·Σ_a ⟨·, ω_a⟩ω_a`. -/
theorem Wtrip_top (ω : Fin 3 → Matrix (Fin n) (Fin n) ℝ) (a₀ : Fin 3) (s : ℝ) (X : Matrix (Fin n) (Fin n) ℝ) :
    Wtrip ω (fun a => if a = a₀ then 2 * s else -s) X
      = (3 * s * inner2 X (ω a₀)) • ω a₀ - s • ∑ a, inner2 X (ω a) • ω a := by
  unfold Wtrip
  have e : ∀ a, ((if a = a₀ then 2 * s else -s) * inner2 X (ω a)) • ω a
      = (if a = a₀ then (3 * s * inner2 X (ω a)) • ω a else 0) - s • (inner2 X (ω a) • ω a) := fun a => by
    split_ifs with h
    · rw [smul_smul, ← sub_smul]; congr 1; ring
    · rw [smul_smul, zero_sub, ← neg_smul]; congr 1; ring
  simp only [e, Finset.sum_sub_distrib, Finset.sum_ite_eq', Finset.mem_univ, if_true, ← Finset.smul_sum]

/-! ## The padded frame change -/

/-- A `4 × 4` matrix on the first four coordinates, the identity elsewhere. -/
noncomputable def Upad (n : ℕ) (U : Matrix (Fin 4) (Fin 4) ℝ) : Matrix (Fin n) (Fin n) ℝ :=
  Emb n * U * (Emb n)ᵀ + (1 - Emb n * (Emb n)ᵀ)

theorem Upad_emb (hn : 4 ≤ n) (U : Matrix (Fin 4) (Fin 4) ℝ) : Upad n U * Emb n = Emb n * U := by
  unfold Upad
  rw [Matrix.add_mul, Matrix.sub_mul, Matrix.one_mul, Matrix.mul_assoc, Matrix.mul_assoc, Emb_orth hn,
    Matrix.mul_one, Matrix.mul_assoc, Emb_orth hn, Matrix.mul_one, sub_self, add_zero]

theorem Upad_transpose (U : Matrix (Fin 4) (Fin 4) ℝ) : (Upad n U)ᵀ = Upad n Uᵀ := by
  unfold Upad
  rw [Matrix.transpose_add, Matrix.transpose_sub, Matrix.transpose_one, Matrix.transpose_mul, Matrix.transpose_mul,
    Matrix.transpose_mul, Matrix.transpose_transpose, Matrix.mul_assoc]

theorem Upad_mul (hn : 4 ≤ n) (U V : Matrix (Fin 4) (Fin 4) ℝ) : Upad n U * Upad n V = Upad n (U * V) := by
  have hE := Emb_orth (n := n) hn
  unfold Upad
  set E := Emb n
  have h1 : (E * U * Eᵀ) * (E * V * Eᵀ) = E * (U * V) * Eᵀ := by
    rw [show (E * U * Eᵀ) * (E * V * Eᵀ) = E * U * (Eᵀ * E) * V * Eᵀ by simp only [Matrix.mul_assoc], hE,
      Matrix.mul_one, Matrix.mul_assoc E U V]
  have h2 : (E * U * Eᵀ) * (1 - E * Eᵀ) = 0 := by
    rw [Matrix.mul_sub, Matrix.mul_one, show E * U * Eᵀ * (E * Eᵀ) = E * U * (Eᵀ * E) * Eᵀ by
      simp only [Matrix.mul_assoc], hE, Matrix.mul_one, sub_self]
  have h3 : (1 - E * Eᵀ) * (E * V * Eᵀ) = 0 := by
    rw [Matrix.sub_mul, Matrix.one_mul, show E * Eᵀ * (E * V * Eᵀ) = E * (Eᵀ * E) * V * Eᵀ by
      simp only [Matrix.mul_assoc], hE, Matrix.mul_one, sub_self]
  have h4 : (1 - E * Eᵀ) * (1 - E * Eᵀ) = 1 - E * Eᵀ := by
    rw [Matrix.sub_mul, Matrix.one_mul, Matrix.mul_sub, Matrix.mul_one,
      show E * Eᵀ * (E * Eᵀ) = E * (Eᵀ * E) * Eᵀ by simp only [Matrix.mul_assoc], hE, Matrix.mul_one]
    abel
  rw [Matrix.add_mul, Matrix.mul_add, Matrix.mul_add, h1, h2, h3, h4, add_zero, zero_add]

theorem Upad_one : Upad n (1 : Matrix (Fin 4) (Fin 4) ℝ) = 1 := by
  unfold Upad; rw [Matrix.mul_one]; abel

/-- **A padded orthogonal matrix is orthogonal.** -/
theorem Upad_orth (hn : 4 ≤ n) {U : Matrix (Fin 4) (Fin 4) ℝ} (hU : Uᵀ * U = 1) : IsOrth (Upad n U) := by
  have hU' : U * Uᵀ = 1 := mul_eq_one_comm.mp hU
  refine ⟨?_, ?_⟩
  · rw [Upad_transpose, Upad_mul hn, hU, Upad_one]
  · rw [Upad_transpose, Upad_mul hn, hU', Upad_one]

/-- **The padded `U` conjugates blockwise**: `Upad U (E F Eᵀ) Upad Uᵀ = E (U F Uᵀ) Eᵀ`. -/
theorem Upad_conj (hn : 4 ≤ n) (U F : Matrix (Fin 4) (Fin 4) ℝ) :
    Upad n U * (Emb n * F * (Emb n)ᵀ) * (Upad n U)ᵀ = Emb n * (U * F * Uᵀ) * (Emb n)ᵀ := by
  have h1 := Upad_emb hn U
  have h2 : (Emb n)ᵀ * (Upad n U)ᵀ = Uᵀ * (Emb n)ᵀ := by
    rw [← Matrix.transpose_mul, h1, Matrix.transpose_mul]
  rw [show Upad n U * (Emb n * F * (Emb n)ᵀ) * (Upad n U)ᵀ = (Upad n U * Emb n) * F * ((Emb n)ᵀ * (Upad n U)ᵀ) by
    simp only [Matrix.mul_assoc], h1, h2]
  simp only [Matrix.mul_assoc]

/-! ## The self-dual core -/

/-- The equality spectrum `s(2, -1, -1)` with the `2` at `a₀`. -/
def top (a₀ : Fin 3) (s : ℝ) : Fin 3 → ℝ := fun a => if a = a₀ then 2 * s else -s

theorem mu_eq_top : mu = top 0 (1 / Real.sqrt 6) := by
  funext a; fin_cases a <;> simp [mu, top]; ring

theorem conjOp_mul (A B : Matrix (Fin n) (Fin n) ℝ) (R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) :
    conjOp (A * B) R = conjOp A (conjOp B R) := by
  funext X; unfold conjOp; simp only [Matrix.transpose_mul, Matrix.mul_assoc]

theorem isOrth_mul {A B : Matrix (Fin n) (Fin n) ℝ} (hA : IsOrth A) (hB : IsOrth B) : IsOrth (A * B) := by
  refine ⟨?_, ?_⟩
  · rw [Matrix.transpose_mul, Matrix.mul_assoc, ← Matrix.mul_assoc Aᵀ, hA.1, Matrix.one_mul, hB.1]
  · rw [Matrix.transpose_mul, Matrix.mul_assoc, ← Matrix.mul_assoc B, hB.2, Matrix.one_mul, hA.2]

/-- A frame change preserves `inner2` between conjugated matrices. -/
theorem inner2_conj' {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U) (X Y : Matrix (Fin n) (Fin n) ℝ) :
    inner2 (U * X * Uᵀ) (U * Y * Uᵀ) = inner2 X Y := by
  have h := inner2_conj (isOrth_transpose hU) X Y
  rwa [Matrix.transpose_transpose] at h

/-- `Σ_b x_b ω_b` for the standard forms is `sq2⁻¹ E (Σ_b x_b J_b) Eᵀ`. -/
theorem om_combo (x : Fin 3 → ℝ) : ∑ b, x b • om (n := n) b = sq2⁻¹ • (Emb n * (∑ b, x b • J b) * (Emb n)ᵀ) := by
  unfold om
  rw [Matrix.mul_sum, Matrix.sum_mul, Finset.smul_sum]
  exact Finset.sum_congr rfl fun b _ => by rw [Matrix.mul_smul, Matrix.smul_mul, smul_comm]

/-- `⟨Σ x_b ω_b, Σ y_b ω_b⟩ = Σ x_b y_b` over an orthonormal triple. -/
theorem inner2_combo (ω : Fin 3 → Matrix (Fin n) (Fin n) ℝ) (hω : ∀ a b, inner2 (ω a) (ω b) = if a = b then 1 else 0)
    (x y : Fin 3 → ℝ) : inner2 (∑ b, x b • ω b) (∑ b, y b • ω b) = ∑ b, x b * y b := by
  rw [HamiltonsCubic.L41Statement.Frame.inner2_sum_l]
  refine Finset.sum_congr rfl fun d _ => ?_
  rw [HamiltonsCubic.L41Statement.Frame.inner2_smul_l, HamiltonsCubic.L41Statement.Frame.inner2_sum_r,
    Finset.sum_eq_single d]
  · rw [HamiltonsCubic.L41Statement.Frame.inner2_smul_r, hω, if_pos rfl]; ring
  · intro e _ he; rw [HamiltonsCubic.L41Statement.Frame.inner2_smul_r, hω, if_neg (Ne.symm he), mul_zero]
  · intro h; exact absurd (Finset.mem_univ d) h

/-- **The self-dual core**: an orthonormal triple in the span of the standard forms, carrying the equality
spectrum, is `s√6 · W_c` after a frame change. -/
theorem rigid_sd (hn : 4 ≤ n) (ω : Fin 3 → Matrix (Fin n) (Fin n) ℝ) (c : Fin 3 → Fin 3 → ℝ)
    (hω : ∀ a b, inner2 (ω a) (ω b) = if a = b then 1 else 0) (hc : ∀ a, ω a = ∑ b, c a b • om b)
    (a₀ : Fin 3) (s : ℝ) :
    ∃ U : Matrix (Fin n) (Fin n) ℝ, IsOrth U ∧ conjOp U (Wtrip ω (top a₀ s)) = (s * Real.sqrt 6) • Wc n := by
  have hv : c a₀ 0 ^ 2 + c a₀ 1 ^ 2 + c a₀ 2 ^ 2 = 1 := by
    have h := hω a₀ a₀
    rw [if_pos rfl, hc a₀, inner2_combo om (om_inner hn), Fin.sum_univ_three] at h
    linarith [h, sq (c a₀ 0), sq (c a₀ 1), sq (c a₀ 2)]
  obtain ⟨U4, hU4, hJ0, hspan, -⟩ := rot_to_J0 (c a₀) hv
  choose w hw using hspan
  have hUo := Upad_orth hn hU4
  refine ⟨Upad n U4, hUo, ?_⟩
  rw [conjOp_Wtrip hUo]
  set ω'' : Fin 3 → Matrix (Fin n) (Fin n) ℝ := fun a => Upad n U4 * ω a * (Upad n U4)ᵀ with hω''
  have hlin : ∀ x : Fin 3 → ℝ, Upad n U4 * (∑ b, x b • om (n := n) b) * (Upad n U4)ᵀ
      = sq2⁻¹ • (Emb n * (U4 * (∑ b, x b • J b) * U4ᵀ) * (Emb n)ᵀ) := fun x => by
    rw [om_combo, Matrix.mul_smul, Matrix.smul_mul, Upad_conj hn]
  have h0 : ω'' a₀ = om 0 := by
    simp only [hω'', hc a₀]; rw [hlin, hJ0]; rfl
  have hom : ∀ b, Upad n U4 * om (n := n) b * (Upad n U4)ᵀ = ∑ d, w b d • om d := fun b => by
    rw [om_combo]
    conv_lhs => unfold om
    rw [Matrix.mul_smul, Matrix.smul_mul, Upad_conj hn, hw b]
  have hconjlin : ∀ x : Fin 3 → ℝ, Upad n U4 * (∑ b, x b • om (n := n) b) * (Upad n U4)ᵀ
      = ∑ b, x b • (Upad n U4 * om b * (Upad n U4)ᵀ) := fun x => by
    rw [Matrix.mul_sum, Matrix.sum_mul]
    exact Finset.sum_congr rfl fun b _ => by rw [Matrix.mul_smul, Matrix.smul_mul]
  have hcoef : ∀ a, ω'' a = ∑ d, (∑ b, c a b * w b d) • om d := fun a => by
    simp only [hω'', hc a]
    rw [hconjlin]
    simp only [hom, Finset.smul_sum, smul_smul]
    rw [Finset.sum_comm]
    exact Finset.sum_congr rfl fun d _ => by rw [Finset.sum_smul]
  have horth : ∀ a b, inner2 (ω'' a) (ω'' b) = if a = b then 1 else 0 := fun a b => by
    simp only [hω'']; rw [inner2_conj' hUo, hω]
  funext X
  rw [show top a₀ s = fun a => if a = a₀ then 2 * s else -s from rfl, Wtrip_top, h0,
    proj_inv om ω'' _ (om_inner hn) horth hcoef, Pi.smul_apply, Wc_eq_Wtrip, mu_eq_top,
    show top 0 (1 / Real.sqrt 6) = fun a => if a = 0 then 2 * (1 / Real.sqrt 6) else -(1 / Real.sqrt 6) from rfl,
    Wtrip_top, smul_sub, smul_smul, smul_smul]
  have h6 : Real.sqrt 6 ≠ 0 := by positivity
  congr 2
  · field_simp
  · field_simp

/-! ## From `θ = √(3/2)` to the equality spectrum -/

/-- **Two equal eigenvalues, trace zero and a positive product force the spectrum `s(2, -1, -1)`, `s > 0`.** -/
theorem top_of_eq {μ : Fin 3 → ℝ} (hμ : ∑ a, μ a = 0) (hP : 0 < μ 0 * μ 1 * μ 2)
    (heq : μ 0 = μ 1 ∨ μ 1 = μ 2 ∨ μ 2 = μ 0) : ∃ a₀ s, 0 < s ∧ μ = top a₀ s := by
  rw [Fin.sum_univ_three] at hμ
  rcases heq with h | h | h
  · have h2 : μ 2 = -2 * μ 0 := by linarith
    have hx : μ 0 < 0 := by
      rw [← h, h2] at hP; nlinarith [sq_nonneg (μ 0)]
    refine ⟨2, -μ 0, by linarith, funext fun a => ?_⟩
    fin_cases a <;> simp [top] <;> linarith
  · have h0 : μ 0 = -2 * μ 1 := by linarith
    have hx : μ 1 < 0 := by
      rw [h0, ← h] at hP; nlinarith [sq_nonneg (μ 1)]
    refine ⟨0, -μ 1, by linarith, funext fun a => ?_⟩
    fin_cases a <;> simp [top] <;> linarith
  · have h1 : μ 1 = -2 * μ 2 := by linarith
    have hx : μ 2 < 0 := by
      rw [h1, h] at hP
      have : μ 0 < 0 := by nlinarith [sq_nonneg (μ 0)]
      linarith
    refine ⟨1, -μ 2, by linarith, funext fun a => ?_⟩
    fin_cases a <;> simp [top] <;> linarith

/-- **At `θ = √(3/2)` a frame operator carries the equality spectrum.** -/
theorem WF_eq_top (hn : 4 ≤ n) (Φ : SUFrame) {μ : Fin 3 → ℝ} (hμ : ∑ a, μ a = 0)
    (hθ : theta (WF Φ n μ) = Real.sqrt (3 / 2)) : ∃ a₀ s, 0 < s ∧ μ = top a₀ s := by
  obtain ⟨hN, -, -⟩ := WF_values Φ hn hμ
  have hPv := WF_P Φ hn hμ
  set N := normSq (WF Φ n μ)
  set P := Pcubic (WF Φ n μ)
  have hθ' : P / Real.sqrt N ^ 3 = Real.sqrt (3 / 2) := hθ
  have hNpos : 0 < N := by
    by_contra hc
    have hN0 : Real.sqrt N = 0 := Real.sqrt_eq_zero'.mpr (not_lt.mp hc)
    rw [hN0] at hθ'; simp at hθ'
    have : (0 : ℝ) < Real.sqrt 3 / Real.sqrt 2 := by positivity
    linarith
  have hs : 0 < Real.sqrt N := Real.sqrt_pos.mpr hNpos
  have hPe : P = Real.sqrt (3 / 2) * Real.sqrt N ^ 3 := by
    field_simp at hθ'; linarith
  have hPpos : 0 < P := by rw [hPe]; positivity
  have hsq : P ^ 2 = 3 / 2 * N ^ 3 := by
    rw [hPe, mul_pow, Real.sq_sqrt (by norm_num), ← pow_mul, show 3 * 2 = 2 * 3 by rfl, pow_mul,
      Real.sq_sqrt hNpos.le]
  have heq := (WF_bound_eq_iff Φ hn hμ).mp hsq
  refine top_of_eq hμ ?_ heq
  rw [hPv] at hPpos; linarith

/-! ## The anti-self-dual reflection -/

/-- `diag(1, 1, 1, -1)`. -/
noncomputable def D4 : Matrix (Fin 4) (Fin 4) ℝ := Matrix.diagonal ![1, 1, 1, -1]

/-- The signs `D4` puts on the anti-self-dual frame. -/
def sgnK : Fin 3 → ℝ := ![1, 1, -1]

theorem D4_orth : D4ᵀ * D4 = 1 := by
  ext i j; fin_cases i <;> fin_cases j <;> simp [D4, Matrix.mul_apply, Matrix.diagonal]

theorem D4_K (b : Fin 3) : D4 * K b * D4ᵀ = sgnK b • J b := by
  fin_cases b <;> (ext i j; fin_cases i <;> fin_cases j <;>
    simp [D4, K, Kz, J, sgnK, Matrix.mul_apply, Matrix.diagonal])

/-! ## The equality case on `ℝⁿ` -/

/-- **Rigidity for a rotated self-dual frame operator.** -/
theorem rigid_rot_sd (hn : 4 ≤ n) {O : Matrix (Fin 3) (Fin 3) ℝ} (hO : Oᵀ * O = 1) {μ : Fin 3 → ℝ}
    (hμ : ∑ a, μ a = 0) (hθ : theta (WF (rotFrame stdFrame hO) n μ) = Real.sqrt (3 / 2)) :
    ∃ U : Matrix (Fin n) (Fin n) ℝ, IsOrth U ∧ ∃ t : ℝ, 0 < t ∧ conjOp U (WF (rotFrame stdFrame hO) n μ) = t • Wc n := by
  obtain ⟨a₀, s, hs, rfl⟩ := WF_eq_top hn _ hμ hθ
  obtain ⟨U, hU, hconj⟩ := rigid_sd hn (omF (rotFrame stdFrame hO)) (fun a b => O a b)
    (omF_inner _ hn) (fun a => omF_rot stdFrame hO a) a₀ s
  exact ⟨U, hU, s * Real.sqrt 6, by positivity, by rw [WF_eq_Wtrip]; exact hconj⟩

/-- **Rigidity for a rotated anti-self-dual frame operator**, through the reflection `D4`. -/
theorem rigid_rot_asd (hn : 4 ≤ n) {O : Matrix (Fin 3) (Fin 3) ℝ} (hO : Oᵀ * O = 1) {μ : Fin 3 → ℝ}
    (hμ : ∑ a, μ a = 0) (hθ : theta (WF (rotFrame asdFrame hO) n μ) = Real.sqrt (3 / 2)) :
    ∃ U : Matrix (Fin n) (Fin n) ℝ, IsOrth U ∧ ∃ t : ℝ, 0 < t ∧ conjOp U (WF (rotFrame asdFrame hO) n μ) = t • Wc n := by
  obtain ⟨a₀, s, hs, rfl⟩ := WF_eq_top hn _ hμ hθ
  have hD := Upad_orth (n := n) hn D4_orth
  set ω' : Fin 3 → Matrix (Fin n) (Fin n) ℝ := fun a => Upad n D4 * omF (rotFrame asdFrame hO) a * (Upad n D4)ᵀ
    with hω'
  have hK : ∀ b, Upad n D4 * omF (n := n) asdFrame b * (Upad n D4)ᵀ = sgnK b • om b := fun b => by
    change Upad n D4 * (sq2⁻¹ • (Emb n * K b * (Emb n)ᵀ)) * (Upad n D4)ᵀ = sgnK b • om b
    rw [Matrix.mul_smul, Matrix.smul_mul, Upad_conj hn, D4_K]
    unfold om
    rw [Matrix.mul_smul, Matrix.smul_mul, smul_comm]
  have hc : ∀ a, ω' a = ∑ b, (O a b * sgnK b) • om b := fun a => by
    simp only [hω', omF_rot asdFrame hO a, Matrix.mul_sum, Matrix.sum_mul]
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [Matrix.mul_smul, Matrix.smul_mul, hK, smul_smul]
  have horth : ∀ a b, inner2 (ω' a) (ω' b) = if a = b then 1 else 0 := fun a b => by
    simp only [hω']; rw [inner2_conj' hD, omF_inner _ hn]
  obtain ⟨U, hU, hconj⟩ := rigid_sd hn ω' (fun a b => O a b * sgnK b) horth hc a₀ s
  refine ⟨U * Upad n D4, isOrth_mul hU hD, s * Real.sqrt 6, by positivity, ?_⟩
  rw [conjOp_mul, WF_eq_Wtrip, conjOp_Wtrip hD]
  exact hconj

/-- **L178's equality case on `ℝⁿ`**: a Weyl `W_C` of rank at most three, supported on the coordinate
`Λ²ℝ⁴`, with `θ(W_C) = √(3/2)`, is a positive multiple of `W_c` after an orthogonal frame change. -/
theorem L178_padded_eq (hn : 4 ≤ n) (C : Matrix (Fin 3 ⊕ Fin 3) (Fin 3 ⊕ Fin 3) ℝ) (hs : ∀ i j, C i j = C j i)
    (hW : IsWeyl (WC n C)) (hrank : C.rank ≤ 3) (heq : theta (WC n C) = Real.sqrt (3 / 2)) :
    ∃ U : Matrix (Fin n) (Fin n) ℝ, IsOrth U ∧ ∃ t : ℝ, 0 < t ∧ conjOp U (WC n C) = t • Wc n := by
  obtain ⟨hB, hA, hD⟩ := weyl_blocks hn C hs hW
  set A : Matrix (Fin 3) (Fin 3) ℝ := fun a b => C (Sum.inl a) (Sum.inl b) with hAdef
  set D : Matrix (Fin 3) (Fin 3) ℝ := fun a b => C (Sum.inr a) (Sum.inr b) with hDdef
  have hAs : Aᵀ = A := by ext a b; exact hs _ _
  have hDs : Dᵀ = D := by ext a b; exact hs _ _
  have hAt : A.trace = 0 := by
    change ∑ i, A i i = 0
    rw [Fin.sum_univ_three]; exact hA
  have hDt : D.trace = 0 := by
    change ∑ i, D i i = 0
    rw [Fin.sum_univ_three]; exact hD
  have hsplit : WC n C = fun X => WMat n A X + WMatA n D X := funext (WC_split C hs hB)
  have hzero : ∀ {Φ : SUFrame} (X : Matrix (Fin n) (Fin n) ℝ), WMatF Φ n 0 X = 0 := fun X => by
    simp [WMatF]
  rcases one_block_zero C hs hB hA hD hrank with h | h
  · have hA0 : A = 0 := h
    have hWC : WC n C = WMatA n D := by
      rw [hsplit]; funext X; rw [hA0, show WMat n 0 X = 0 from hzero X, zero_add]
    obtain ⟨O, hO, μ, hμ, -, hWF⟩ := WMatF_spectral asdFrame (n := n) hDs hDt
    rw [hWC, show WMatA n D = WMatF asdFrame n D from rfl, hWF] at heq ⊢
    exact rigid_rot_asd hn hO hμ heq
  · have hD0 : D = 0 := h
    have hWC : WC n C = WMat n A := by
      rw [hsplit]; funext X; rw [hD0, show WMatA n 0 X = 0 from hzero X, add_zero]
    obtain ⟨O, hO, μ, hμ, -, hWF⟩ := WMatF_spectral stdFrame (n := n) hAs hAt
    rw [hWC, show WMat n A = WMatF stdFrame n A from rfl, hWF] at heq ⊢
    exact rigid_rot_sd hn hO hμ heq

/-! ## The converse, and the statement as an equivalence -/

/-- **`θ` is unchanged by a positive scale of `W_c`**: `θ(t W_c) = √(3/2)` for `t > 0`. -/
theorem theta_smul_Wc (hn : 4 ≤ n) {t : ℝ} (ht : 0 < t) : theta (t • Wc n) = Real.sqrt (3 / 2) := by
  have hmu : ∑ a, (t • mu) a = 0 := by
    simp only [Pi.smul_apply, smul_eq_mul, ← Finset.mul_sum, mu_sum, mul_zero]
  have e : t • Wc n = WF stdFrame n (t • mu) := by
    funext X
    simp only [Pi.smul_apply, Wc_eq_Wtrip, WF_eq_Wtrip, Wtrip, Finset.smul_sum, smul_smul, smul_eq_mul]
    exact Finset.sum_congr rfl fun a _ => by rw [omF_std]; ring_nf
  have e1 : Wc n = WF stdFrame n mu := by
    funext X; simp only [Wc_eq_Wtrip, WF_eq_Wtrip]; rfl
  rw [e, ← Wc_theta hn, e1]
  obtain ⟨hN, -, -⟩ := WF_values stdFrame hn hmu
  obtain ⟨hN1, -, -⟩ := WF_values stdFrame hn mu_sum
  have hP := WF_P stdFrame hn hmu
  have hP1 := WF_P stdFrame hn mu_sum
  unfold theta HamiltonsCubic.RealLayer.norm
  rw [hN, hN1, hP, hP1]
  simp only [Pi.smul_apply, smul_eq_mul, mul_pow]
  rw [← Finset.mul_sum, Real.sqrt_mul (by positivity), Real.sqrt_sq ht.le]
  have hS : 0 < Real.sqrt (∑ a, mu a ^ 2) := by
    apply Real.sqrt_pos.mpr
    have := Finset.single_le_sum (f := fun a => mu a ^ 2) (fun b _ => sq_nonneg (mu b)) (Finset.mem_univ 0)
    have h0 : 0 < mu 0 ^ 2 := by simp [mu]
    linarith
  field_simp

/-- **L178's equality case on `ℝⁿ`, as an equivalence**: a nonzero rank-`≤3` Weyl `W_C` on the coordinate
`Λ²ℝ⁴` has `θ = √(3/2)` exactly when it is a positive multiple of `W_c` after an orthogonal frame change. -/
theorem L178_padded_eq_iff (hn : 4 ≤ n) (C : Matrix (Fin 3 ⊕ Fin 3) (Fin 3 ⊕ Fin 3) ℝ) (hs : ∀ i j, C i j = C j i)
    (hW : IsWeyl (WC n C)) (hrank : C.rank ≤ 3) :
    theta (WC n C) = Real.sqrt (3 / 2) ↔
      ∃ U : Matrix (Fin n) (Fin n) ℝ, IsOrth U ∧ ∃ t : ℝ, 0 < t ∧ conjOp U (WC n C) = t • Wc n := by
  refine ⟨L178_padded_eq hn C hs hW hrank, ?_⟩
  rintro ⟨U, hU, t, ht, h⟩
  rw [← (invariants_conj hU hW).2, h, theta_smul_Wc hn ht]

/-! ## For the operator, and in every frame -/

/-- An operator supported on the coordinate `Λ²ℝ⁴` agrees with its `W_C` on bivectors, `W_C` is Weyl, and the two
have one `θ`. -/
theorem supported_facts (hn : 4 ≤ n) {R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ} (hW : IsWeyl R)
    (hker : ∀ X, IsSkew X → (∀ i, inner2 X (eF i) = 0) → R X = 0)
    (hran : ∀ X Y, IsSkew X → IsSkew Y → (∀ i, inner2 Y (eF i) = 0) → inner2 (R X) Y = 0) :
    let C : Matrix (Fin 3 ⊕ Fin 3) (Fin 3 ⊕ Fin 3) ℝ := Matrix.of fun i j => inner2 (R (eF (n := n) i)) (eF j)
    (∀ X, IsSkew X → R X = WC n C X) ∧ IsWeyl (WC n C) ∧ theta R = theta (WC n C) := by
  intro C
  have hRC : ∀ X, IsSkew X → R X = WC n C X := fun X hX => supported_eq_WC hn hW hker hran X hX
  have hR := hW.1
  have hWC : IsWeyl (WC n C) := by
    refine ⟨fun X hX => by rw [← hRC X hX]; exact hR X hX,
      fun X Y hX hY => by rw [← hRC X hX, ← hRC Y hY]; exact hW.2.1 X Y hX hY,
      fun i j k l => ?_, fun a b => ?_⟩
    · have h := hW.2.2.1 i j k l
      unfold bianchi at h ⊢
      simp only [hRC _ (HamiltonsCubic.RealLayer.phi_isSkew _ _)] at h
      exact h
    · have h := hW.2.2.2 a b
      unfold Ric at h ⊢
      simp only [hRC _ (HamiltonsCubic.RealLayer.phi_isSkew _ _)] at h
      exact h
  refine ⟨hRC, hWC, theta_congr_skew hR hRC⟩

/-- **L178's equality case for the operator**, supported on the coordinate `Λ²ℝ⁴` with rank at most three:
`θ(R) = √(3/2)` exactly when, on bivectors, `R` is a positive multiple of `W_c` after an orthogonal frame change. -/
theorem L178_supported_eq_iff (hn : 4 ≤ n) {R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ} (hW : IsWeyl R)
    (hker : ∀ X, IsSkew X → (∀ i, inner2 X (eF i) = 0) → R X = 0)
    (hran : ∀ X Y, IsSkew X → IsSkew Y → (∀ i, inner2 Y (eF i) = 0) → inner2 (R X) Y = 0)
    (hrank : (Matrix.of fun i j => inner2 (R (eF (n := n) i)) (eF j)).rank ≤ 3) :
    theta R = Real.sqrt (3 / 2) ↔
      ∃ U : Matrix (Fin n) (Fin n) ℝ, IsOrth U ∧ ∃ t : ℝ, 0 < t ∧ ∀ X, IsSkew X → conjOp U R X = t • Wc n X := by
  obtain ⟨hRC, hWC, hθ⟩ := supported_facts hn hW hker hran
  set C : Matrix (Fin 3 ⊕ Fin 3) (Fin 3 ⊕ Fin 3) ℝ := Matrix.of fun i j => inner2 (R (eF (n := n) i)) (eF j)
  constructor
  · intro heq
    rw [hθ] at heq
    obtain ⟨U, hU, t, ht, h⟩ := L178_padded_eq hn C (fun i j => coeff_symm hW i j) hWC hrank heq
    refine ⟨U, hU, t, ht, fun X hX => ?_⟩
    have : conjOp U R X = conjOp U (WC n C) X := by unfold conjOp; rw [hRC _ (isSkew_conj hX)]
    rw [this, h]; rfl
  · rintro ⟨U, hU, t, ht, h⟩
    rw [← (invariants_conj hU hW).2, theta_congr_skew (isWeyl_conj hU hW).1 h]
    exact theta_smul_Wc hn ht

/-- **L178's equality case for every four-dimensional `V`**: when the frame change `U₀` carries `V` onto the
first four coordinates and `U₀·R` meets the support and rank hypotheses, `θ(R) = √(3/2)` exactly when, on
bivectors, `R` is a positive multiple of `W_c` after an orthogonal frame change. -/
theorem L178_frame_eq_iff (hn : 4 ≤ n) {U₀ : Matrix (Fin n) (Fin n) ℝ} (hU₀ : IsOrth U₀)
    {R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ} (hW : IsWeyl R)
    (hker : ∀ X, IsSkew X → (∀ i, inner2 X (eF i) = 0) → conjOp U₀ R X = 0)
    (hran : ∀ X Y, IsSkew X → IsSkew Y → (∀ i, inner2 Y (eF i) = 0) → inner2 (conjOp U₀ R X) Y = 0)
    (hrank : (Matrix.of fun i j => inner2 (conjOp U₀ R (eF (n := n) i)) (eF j)).rank ≤ 3) :
    theta R = Real.sqrt (3 / 2) ↔
      ∃ U : Matrix (Fin n) (Fin n) ℝ, IsOrth U ∧ ∃ t : ℝ, 0 < t ∧ ∀ X, IsSkew X → conjOp U R X = t • Wc n X := by
  have hW₀ := isWeyl_conj hU₀ hW
  constructor
  · intro heq
    rw [← (invariants_conj hU₀ hW).2] at heq
    obtain ⟨U, hU, t, ht, h⟩ := (L178_supported_eq_iff hn hW₀ hker hran hrank).mp heq
    exact ⟨U * U₀, isOrth_mul hU hU₀, t, ht, fun X hX => by rw [conjOp_mul]; exact h X hX⟩
  · rintro ⟨U, hU, t, ht, h⟩
    rw [← (invariants_conj hU hW).2, theta_congr_skew (isWeyl_conj hU hW).1 h]
    exact theta_smul_Wc hn ht

end HamiltonsCubic.CP2Real
