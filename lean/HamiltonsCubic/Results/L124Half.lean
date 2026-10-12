import HamiltonsCubic.Results.L178Rigid
import HamiltonsCubic.Results.L124Det

set_option linter.style.longLine false

/-!
# L124 on the half-flat family: `θ = 9 det V₊` and the equality point

[second-order.md](../../../findings/second-order.md), Lemma L124 (iii): *"On the half-flat family supported at one
four-set, `θ = 9 det V₊`; the sharp bound … then gives `θ² ≤ (3/2)ρ²`, with equality exactly at `± W_{ℂP²}`."* The
half-flat family at the coordinate four-set is [L178Rot.lean](L178Rot.lean)'s `WMat n V`, `V` symmetric and
trace-free, the operator `Σ_{b,c} V_{bc} ⟨·, ω_b⟩ ω_c` over the self-dual forms. This file proves:

* **`half_flat_values`**: `‖W‖² = tr V²`, which is `ρ² = tr V₊²`, and `P(W) = 9 det V`, so `θ = 9 det V₊` at
  unit norm;
* **`half_flat_is_WMat`**: a Weyl `W_C` on the coordinate `Λ²ℝ⁴` annihilating `Λ²₋` is `W_V` with `V` symmetric
  and trace-free, so the family is exactly `WMat`;
* **`WMat_neg`**, **`theta_WMat_neg`**: `W_{-V} = -W_V` and `θ(W_{-V}) = -θ(W_V)`;
* **`theta_sq_le_WMat`**, **`pair_sum_zero`**, **`sigma_le_rho_WMat`**: (iii)'s `θ² ≤ 3/2`, (i)'s `A + B + C = 0` and
  (ii)'s `Σ ≤ (3/2)ρ²`, each on the operator;
* **`half_flat_eq_pos`**, **`half_flat_eq_neg`**: `θ = √(3/2)` exactly when `W` is a positive multiple of `W_c`
  after an orthogonal frame change, and `θ = -√(3/2)` exactly when it is a negative one, the equality point
  `± W_{ℂP²}`.
-/

namespace HamiltonsCubic.CP2Real

open Matrix HamiltonsCubic.RealLayer HamiltonsCubic.FrameLayer

variable {n : ℕ}

/-- **`‖W_V‖² = tr V²` and `P(W_V) = 9 det V`** on the half-flat family. -/
theorem half_flat_values (hn : 4 ≤ n) {V : Matrix (Fin 3) (Fin 3) ℝ} (hV : Vᵀ = V) (htr : V.trace = 0) :
    normSq (WMat n V) = (V ^ 2).trace ∧ Pcubic (WMat n V) = 9 * V.det := by
  obtain ⟨O, hO, μ, hμ, hVe, hW⟩ := WMatF_spectral (n := n) stdFrame hV htr
  have hO' : O * Oᵀ = 1 := mul_eq_one_comm.mp hO
  rw [show WMat n V = WMatF stdFrame n V from rfl, hW]
  obtain ⟨hN, -, -⟩ := WF_values (rotFrame stdFrame hO) hn hμ
  refine ⟨?_, ?_⟩
  · rw [hN, hVe, sq, show Oᵀ * diagonal μ * O * (Oᵀ * diagonal μ * O) = Oᵀ * (diagonal μ * diagonal μ) * O by
      simp only [Matrix.mul_assoc]; rw [← Matrix.mul_assoc O Oᵀ, hO', Matrix.one_mul]]
    rw [Matrix.trace_mul_cycle, ← Matrix.mul_assoc, hO', Matrix.one_mul, diagonal_mul_diagonal, trace_diagonal]
    exact Finset.sum_congr rfl fun a _ => by ring
  · rw [WF_P _ hn hμ, hVe, Matrix.det_mul, Matrix.det_mul, Matrix.det_transpose, Matrix.det_diagonal,
      Fin.prod_univ_three]
    have hd : O.det * O.det = 1 := by
      have := congrArg Matrix.det hO
      rwa [Matrix.det_mul, Matrix.det_transpose, Matrix.det_one] at this
    linear_combination (9 * (μ 0 * μ 1 * μ 2)) * (-hd)

/-- **The family is closed under the sign**: `W_{-V} = -W_V`. -/
theorem WMat_neg (V : Matrix (Fin 3) (Fin 3) ℝ) : WMat n (-V) = fun X => -WMat n V X := by
  funext X
  simp only [WMatF, Matrix.neg_apply, neg_mul, neg_smul, Finset.sum_neg_distrib]

/-- **`θ = √(3/2)` on the half-flat family exactly at a positive multiple of `W_c` after a frame change.** -/
theorem half_flat_eq_pos (hn : 4 ≤ n) {V : Matrix (Fin 3) (Fin 3) ℝ} (hV : Vᵀ = V) (htr : V.trace = 0) :
    theta (WMat n V) = Real.sqrt (3 / 2) ↔
      ∃ U : Matrix (Fin n) (Fin n) ℝ, IsOrth U ∧ ∃ t : ℝ, 0 < t ∧ conjOp U (WMat n V) = t • Wc n := by
  have hW := WMatF_weyl stdFrame (n := n) hn hV htr
  constructor
  · intro heq
    obtain ⟨O, hO, μ, hμ, -, hWF⟩ := WMatF_spectral (n := n) stdFrame hV htr
    rw [show WMat n V = WMatF stdFrame n V from rfl, hWF] at heq ⊢
    exact rigid_rot_sd hn hO hμ heq
  · rintro ⟨U, hU, t, ht, h⟩
    rw [← (invariants_conj hU hW).2, h, theta_smul_Wc hn ht]

/-- **`θ = -√(3/2)` on the half-flat family exactly at a negative multiple of `W_c` after a frame change.** -/
theorem half_flat_eq_neg (hn : 4 ≤ n) {V : Matrix (Fin 3) (Fin 3) ℝ} (hV : Vᵀ = V) (htr : V.trace = 0) :
    theta (WMat n V) = -Real.sqrt (3 / 2) ↔
      ∃ U : Matrix (Fin n) (Fin n) ℝ, IsOrth U ∧ ∃ t : ℝ, t < 0 ∧ conjOp U (WMat n V) = t • Wc n := by
  have hV' : (-V)ᵀ = -V := by rw [Matrix.transpose_neg, hV]
  have htr' : (-V).trace = 0 := by rw [Matrix.trace_neg, htr, neg_zero]
  -- `θ(W_{-V}) = -θ(W_V)`
  have hθ : theta (WMat n (-V)) = -theta (WMat n V) := by
    obtain ⟨hN, hP⟩ := half_flat_values hn hV htr
    obtain ⟨hN', hP'⟩ := half_flat_values hn hV' htr'
    unfold theta HamiltonsCubic.RealLayer.norm
    rw [hN, hP, hN', hP', neg_sq, Matrix.det_neg]
    simp [Fintype.card_fin]; ring
  have hconj : ∀ U : Matrix (Fin n) (Fin n) ℝ, conjOp U (WMat n (-V)) = fun X => -conjOp U (WMat n V) X := by
    intro U; funext X; unfold conjOp; rw [WMat_neg]; simp
  rw [show theta (WMat n V) = -Real.sqrt (3 / 2) ↔ theta (WMat n (-V)) = Real.sqrt (3 / 2) by
    rw [hθ]; constructor <;> intro h <;> linarith, half_flat_eq_pos hn hV' htr']
  constructor
  · rintro ⟨U, hU, t, ht, h⟩
    refine ⟨U, hU, -t, by linarith, funext fun X => ?_⟩
    have := congrFun h X
    rw [hconj] at this
    simp only [Pi.smul_apply, neg_smul] at this ⊢
    rw [← this, neg_neg]
  · rintro ⟨U, hU, t, ht, h⟩
    refine ⟨U, hU, -t, by linarith, funext fun X => ?_⟩
    rw [hconj]
    simp only [Pi.smul_apply, neg_smul]
    rw [h]; rfl

/-! ## (ii): the opposite-pair sums are the diagonal of `V₊` -/

/-- The entries of `ω_a` on the coordinate four-set are `J_a / √2`. -/
theorem om_small (hn : 4 ≤ n) (a : Fin 3) (p q : Fin 4) :
    om (n := n) a (Fin.castLE hn q) (Fin.castLE hn p) = sq2⁻¹ * J a q p := by
  rw [om_entry]
  congr 1
  have hE : ∀ r : Fin 4, (fun x => Emb n (Fin.castLE hn r) x) = Pi.single r 1 := fun r => by
    funext x; simp only [Emb, Fin.val_castLE, Pi.single_apply]
    by_cases h : x = r
    · subst h; simp
    · rw [if_neg (fun h' => h (Fin.ext h'.symm)), if_neg h]
  rw [hE, hE, Matrix.mulVec_single_one, single_dotProduct, one_mul]
  rfl

/-- The sectional value `M_{ij} = ⟨W φ_{ij}, φ_{ij}⟩`. -/
noncomputable def Msec (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (i j : Fin n) : ℝ :=
  inner2 (W (phi i j)) (phi i j)

theorem Msec_WMat (V : Matrix (Fin 3) (Fin 3) ℝ) (i j : Fin n) :
    Msec (WMat n V) i j = ∑ b, ∑ c, V b c * om (n := n) b j i * om c j i := by
  have hphi : ∀ a, inner2 (phi i j) (om (n := n) a) = om a j i := fun a => by
    rw [inner2_comm, inner2_phi _ (om_skew a), HamiltonsCubic.L30Statement.skew_entry (om_skew a)]
    ring
  unfold Msec
  rw [show WMat n V = WMatF stdFrame n V from rfl]
  unfold WMatF
  rw [HamiltonsCubic.L41Statement.Frame.inner2_sum_l]
  refine Finset.sum_congr rfl fun b _ => ?_
  rw [HamiltonsCubic.L41Statement.Frame.inner2_sum_l]
  refine Finset.sum_congr rfl fun c _ => ?_
  rw [HamiltonsCubic.L41Statement.Frame.inner2_smul_l, omF_std, omF_std, hphi b, inner2_comm, hphi c]

/-- **(ii)**: on the half-flat family the opposite-pair sums `A = M₀₁ + M₂₃`, `B = M₀₂ + M₁₃`, `C = M₀₃ + M₁₂` are the
diagonal entries of `V₊`. -/
theorem pair_sums_diag (hn : 4 ≤ n) (V : Matrix (Fin 3) (Fin 3) ℝ) :
    let e : Fin 4 → Fin n := Fin.castLE hn
    Msec (WMat n V) (e 0) (e 1) + Msec (WMat n V) (e 2) (e 3) = V 0 0 ∧
    Msec (WMat n V) (e 0) (e 2) + Msec (WMat n V) (e 1) (e 3) = V 1 1 ∧
    Msec (WMat n V) (e 0) (e 3) + Msec (WMat n V) (e 1) (e 2) = V 2 2 := by
  intro e
  have h2 : sq2⁻¹ * sq2⁻¹ = 1 / 2 := by
    rw [← mul_inv, ← sq, sq2_sq]; norm_num
  simp only [Msec_WMat, e, om_small hn, Fin.sum_univ_three]
  refine ⟨?_, ?_, ?_⟩ <;> simp [J] <;> linear_combination (V _ _) * h2 + (V _ _) * h2

/-- **(ii)'s bound**: with `A, B, C` the diagonal of a trace-free symmetric `V₊`,
`Σ = (3/2)(A² + B² + C²) ≤ (3/2) tr V₊² = (3/2) ρ²`, with equality exactly when `V₊` is diagonal, the three
opposite-pair planes being `W`-invariant. -/
theorem sigma_le_rho (V : Matrix (Fin 3) (Fin 3) ℝ) (hV : Vᵀ = V) (htr : V.trace = 0) :
    V 0 0 ^ 2 + V 1 1 ^ 2 + V 2 2 ^ 2 - V 0 0 * V 1 1 - V 1 1 * V 2 2 - V 2 2 * V 0 0 ≤ 3 / 2 * (V ^ 2).trace ∧
      (V 0 0 ^ 2 + V 1 1 ^ 2 + V 2 2 ^ 2 - V 0 0 * V 1 1 - V 1 1 * V 2 2 - V 2 2 * V 0 0 = 3 / 2 * (V ^ 2).trace ↔
        V 0 1 = 0 ∧ V 0 2 = 0 ∧ V 1 2 = 0) := by
  have hs : ∀ i j, V j i = V i j := fun i j => by
    have := congrFun (congrFun hV i) j; simpa [Matrix.transpose_apply] using this
  have hsum : V 0 0 + V 1 1 + V 2 2 = 0 := by
    have := htr; simp only [Matrix.trace, Matrix.diag, Fin.sum_univ_three] at this; exact this
  have hsig := HamiltonsCubic.L124Det.sigma_of_sum_zero (V 0 0) (V 1 1) (V 2 2) hsum
  have htr2 : (V ^ 2).trace = V 0 0 ^ 2 + V 1 1 ^ 2 + V 2 2 ^ 2 + 2 * (V 0 1 ^ 2 + V 0 2 ^ 2 + V 1 2 ^ 2) := by
    simp only [sq, Matrix.trace, Matrix.diag, Matrix.mul_apply, Fin.sum_univ_three]
    rw [hs 1 0, hs 2 0, hs 2 1]; ring
  rw [hsig, htr2]
  refine ⟨by nlinarith [sq_nonneg (V 0 1), sq_nonneg (V 0 2), sq_nonneg (V 1 2)], ?_⟩
  constructor
  · intro h
    have h0 : V 0 1 ^ 2 + V 0 2 ^ 2 + V 1 2 ^ 2 = 0 := by linarith
    refine ⟨?_, ?_, ?_⟩ <;> nlinarith [sq_nonneg (V 0 1), sq_nonneg (V 0 2), sq_nonneg (V 1 2)]
  · rintro ⟨h1, h2, h3⟩; rw [h1, h2, h3]; ring

/-! ## The family identification and the compositions -/

/-- **The half-flat family is `WMat`**: a Weyl `W_C` on the coordinate `Λ²ℝ⁴` that annihilates `Λ²₋` (its
anti-self-dual block `D` zero) is `W_V` with `V = C₊₊` symmetric and trace-free. -/
theorem half_flat_is_WMat (hn : 4 ≤ n) (C : Matrix (Fin 3 ⊕ Fin 3) (Fin 3 ⊕ Fin 3) ℝ) (hs : ∀ i j, C i j = C j i)
    (hW : IsWeyl (WC n C)) (hD : ∀ a b, C (Sum.inr a) (Sum.inr b) = 0) :
    let V : Matrix (Fin 3) (Fin 3) ℝ := fun a b => C (Sum.inl a) (Sum.inl b)
    Vᵀ = V ∧ V.trace = 0 ∧ WC n C = WMat n V := by
  intro V
  obtain ⟨hB, hA, -⟩ := weyl_blocks hn C hs hW
  refine ⟨by ext a b; exact hs _ _, by change ∑ i, V i i = 0; rw [Fin.sum_univ_three]; exact hA, ?_⟩
  funext X
  rw [WC_split C hs hB X]
  have hz : WMatA n (fun a b => C (Sum.inr a) (Sum.inr b)) X = 0 := by
    change WMatF asdFrame n _ X = 0; simp [WMatF, hD]
  rw [hz, add_zero]

/-- **`θ(W_{-V}) = -θ(W_V)`** on the half-flat family. -/
theorem theta_WMat_neg (hn : 4 ≤ n) {V : Matrix (Fin 3) (Fin 3) ℝ} (hV : Vᵀ = V) (htr : V.trace = 0) :
    theta (WMat n (-V)) = -theta (WMat n V) := by
  have hV' : (-V)ᵀ = -V := by rw [Matrix.transpose_neg, hV]
  have htr' : (-V).trace = 0 := by rw [Matrix.trace_neg, htr, neg_zero]
  obtain ⟨hN, hP⟩ := half_flat_values hn hV htr
  obtain ⟨hN', hP'⟩ := half_flat_values hn hV' htr'
  unfold theta HamiltonsCubic.RealLayer.norm
  rw [hN, hP, hN', hP', neg_sq, Matrix.det_neg]
  simp [Fintype.card_fin]; ring

/-- **(iii)'s bound on the operator**: `θ(W_V)² ≤ 3/2` for every nonzero `V`. -/
theorem theta_sq_le_WMat (hn : 4 ≤ n) {V : Matrix (Fin 3) (Fin 3) ℝ} (hV : Vᵀ = V) (htr : V.trace = 0)
    (h0 : V ≠ 0) : theta (WMat n V) ^ 2 ≤ 3 / 2 := by
  have hV' : (-V)ᵀ = -V := by rw [Matrix.transpose_neg, hV]
  have htr' : (-V).trace = 0 := by rw [Matrix.trace_neg, htr, neg_zero]
  have h1 := WMat_theta_le hn hV htr h0
  have h2 := WMat_theta_le hn hV' htr' (neg_ne_zero.mpr h0)
  rw [theta_WMat_neg hn hV htr] at h2
  have hs : Real.sqrt (3 / 2) ^ 2 = 3 / 2 := Real.sq_sqrt (by norm_num)
  nlinarith [Real.sqrt_nonneg (3 / 2)]

/-- **(i) at the half-flat four-set**: the opposite-pair sums add to `0`. -/
theorem pair_sum_zero (hn : 4 ≤ n) (V : Matrix (Fin 3) (Fin 3) ℝ) (htr : V.trace = 0) :
    let e : Fin 4 → Fin n := Fin.castLE hn
    (Msec (WMat n V) (e 0) (e 1) + Msec (WMat n V) (e 2) (e 3)) + (Msec (WMat n V) (e 0) (e 2) + Msec (WMat n V) (e 1) (e 3))
      + (Msec (WMat n V) (e 0) (e 3) + Msec (WMat n V) (e 1) (e 2)) = 0 := by
  intro e
  obtain ⟨hA, hB, hC⟩ := pair_sums_diag hn V
  rw [hA, hB, hC]
  simpa [Matrix.trace_fin_three] using htr

/-- **(ii)'s bound on the operator**: with `A, B, C` the opposite-pair sums of `W_V`, `Σ ≤ (3/2) ρ²`. Its equality
case, `V₊` diagonal, is `sigma_le_rho` on the matrix. -/
theorem sigma_le_rho_WMat (hn : 4 ≤ n) {V : Matrix (Fin 3) (Fin 3) ℝ} (hV : Vᵀ = V) (htr : V.trace = 0) :
    let e : Fin 4 → Fin n := Fin.castLE hn
    let A := Msec (WMat n V) (e 0) (e 1) + Msec (WMat n V) (e 2) (e 3)
    let B := Msec (WMat n V) (e 0) (e 2) + Msec (WMat n V) (e 1) (e 3)
    let C := Msec (WMat n V) (e 0) (e 3) + Msec (WMat n V) (e 1) (e 2)
    A ^ 2 + B ^ 2 + C ^ 2 - A * B - B * C - C * A ≤ 3 / 2 * normSq (WMat n V) := by
  intro e A B C
  obtain ⟨hA, hB, hC⟩ := pair_sums_diag hn V
  rw [show A = V 0 0 from hA, show B = V 1 1 from hB, show C = V 2 2 from hC, (half_flat_values hn hV htr).1]
  exact (sigma_le_rho V hV htr).1

end HamiltonsCubic.CP2Real
