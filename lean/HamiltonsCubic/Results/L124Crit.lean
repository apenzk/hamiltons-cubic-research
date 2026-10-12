import HamiltonsCubic.Results.L124Half

set_option linter.style.longLine false

/-!
# L124 (iii): `± W_{ℂP²}` is the half-flat family's only critical point

[second-order.md](../../../findings/second-order.md), Lemma L124 (iii): *"… with equality exactly at `± W_{ℂP²}`,
which is moreover the family's ONLY critical point, since `∇det` on the sphere forces two equal eigenvalues."* On
the half-flat family `θ = 9 det V₊` at unit norm ([L124Half.lean](L124Half.lean)), so its critical points are those
of `det` on the unit sphere of trace-free symmetric `3 × 3` matrices:

* **`det_expand`**: at trace-free `V`, `X`, `det(V + tX) = det V + t·tr(V²X) + t²·tr(X²V) + t³·det X`, so the
  derivative of `det` along a tangent `X` is `tr(V²X)`;
* **`crit_iff`**: at unit norm, `V` is critical (`tr(V²X) = 0` along every trace-free symmetric `X ⊥ V`) exactly
  when `(tr V³)² = 1/6`, the equality of the sharp bound, which [L124Half.lean](L124Half.lean) reads as
  `± W_{ℂP²}`, and exactly when `V² = I/3 + (tr V³) V`, i.e. `V` has two equal eigenvalues;
* **`crit_iff_CP`**: the composition, critical exactly when `θ(W_V)² = 3/2`, and exactly when `W_V` is a nonzero
  multiple of `W_c` after an orthogonal frame change.

*Reading not typed*: that the critical points of `θ` restricted to the family are those of `det` on the sphere, `θ`
being `9 det` at unit norm and scale-invariant.
-/

namespace HamiltonsCubic.L124Crit

open Matrix

/-- **The derivative of `det` along a tangent `X` is `tr(V²X)`**, at trace-free `V`, `X`. -/
theorem det_expand (V X : Matrix (Fin 3) (Fin 3) ℝ) (hV : V.trace = 0) (hX : X.trace = 0) (t : ℝ) :
    (V + t • X).det = V.det + t * (V ^ 2 * X).trace + t ^ 2 * (X ^ 2 * V).trace + t ^ 3 * X.det := by
  have h2 : V 2 2 = -V 0 0 - V 1 1 := by simp only [Matrix.trace_fin_three] at hV; linarith
  have h2' : X 2 2 = -X 0 0 - X 1 1 := by simp only [Matrix.trace_fin_three] at hX; linarith
  simp only [Matrix.det_fin_three, Matrix.trace_fin_three, sq, Matrix.mul_apply, Fin.sum_univ_three,
    Matrix.add_apply, Matrix.smul_apply, smul_eq_mul, h2, h2']
  ring

/-- `tr(Y²) = Σ Y_ij²` for symmetric `Y`, so it vanishes only at `Y = 0`. -/
theorem eq_zero_of_trace_sq {Y : Matrix (Fin 3) (Fin 3) ℝ} (hY : Yᵀ = Y) (h : (Y * Y).trace = 0) : Y = 0 := by
  have hs : ∀ i j, Y j i = Y i j := fun i j => by
    have := congrFun (congrFun hY i) j; simpa [Matrix.transpose_apply] using this
  have e : (Y * Y).trace = ∑ i, ∑ j, Y i j ^ 2 := by
    simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply]
    exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by rw [hs j i]; ring
  rw [e] at h
  ext i j
  have hi := (Finset.sum_eq_zero_iff_of_nonneg (fun a _ => Finset.sum_nonneg fun b _ => sq_nonneg (Y a b))).mp h i
    (Finset.mem_univ i)
  have := (Finset.sum_eq_zero_iff_of_nonneg (fun b _ => sq_nonneg (Y i b))).mp hi j (Finset.mem_univ j)
  simpa using this

/-- Critical points of `det` on the unit sphere of trace-free symmetric `3 × 3` matrices: the derivative
`tr(V²X)` vanishes along every tangent direction, a trace-free symmetric `X` orthogonal to `V`. -/
def IsCritDet (V : Matrix (Fin 3) (Fin 3) ℝ) : Prop :=
  ∀ X : Matrix (Fin 3) (Fin 3) ℝ, Xᵀ = X → X.trace = 0 → (V * X).trace = 0 → (V ^ 2 * X).trace = 0

/-- **Newton at trace zero**: `tr V⁴ = (tr V²)²/2` for a trace-free `3 × 3` matrix. -/
theorem trace_pow_four (V : Matrix (Fin 3) (Fin 3) ℝ) (hV : V.trace = 0) :
    (V ^ 4).trace = (V ^ 2).trace ^ 2 / 2 := by
  have h2 : V 2 2 = -V 0 0 - V 1 1 := by simp only [Matrix.trace_fin_three] at hV; linarith
  simp only [show V ^ 4 = V * V * V * V by simp [pow_succ], sq, Matrix.trace_fin_three, Matrix.mul_apply,
    Fin.sum_univ_three, h2]
  ring

/-- **L124 (iii)**: at a trace-free symmetric `V` of unit norm, `V` is a critical point of `det` on the sphere exactly
when `(tr V³)² = 1/6`, the equality case of `|det V| ≤ ‖V‖³/(3√6)`, and exactly when `V² = I/3 + (tr V³) V`. -/
theorem crit_iff (V : Matrix (Fin 3) (Fin 3) ℝ) (hV : Vᵀ = V) (htr : V.trace = 0) (hn : (V ^ 2).trace = 1) :
    (IsCritDet V ↔ (V ^ 3).trace ^ 2 = 1 / 6) ∧
      ((V ^ 3).trace ^ 2 = 1 / 6 ↔ V ^ 2 = (1 / 3 : ℝ) • (1 : Matrix (Fin 3) (Fin 3) ℝ) + (V ^ 3).trace • V) := by
  set b := (V ^ 3).trace with hb
  set Y := V ^ 2 - (1 / 3 : ℝ) • (1 : Matrix (Fin 3) (Fin 3) ℝ) - b • V with hYdef
  have htr1 : (1 : Matrix (Fin 3) (Fin 3) ℝ).trace = 3 := by simp
  have hp4 : (V ^ 4).trace = 1 / 2 := by rw [trace_pow_four V htr, hn]; norm_num
  have e21 : V * V = V ^ 2 := (sq V).symm
  have e31 : V * V ^ 2 = V ^ 3 := (pow_succ' V 2).symm
  have e32 : V ^ 2 * V = V ^ 3 := (pow_succ V 2).symm
  have e42 : V ^ 2 * V ^ 2 = V ^ 4 := (pow_add V 2 2).symm
  have e43 : V * V ^ 3 = V ^ 4 := (pow_succ' V 3).symm
  have e34 : V ^ 3 * V = V ^ 4 := (pow_succ V 3).symm
  have hYs : Yᵀ = Y := by
    rw [hYdef, Matrix.transpose_sub, Matrix.transpose_sub, Matrix.transpose_smul, Matrix.transpose_smul,
      Matrix.transpose_one, hV, sq, Matrix.transpose_mul, hV]
  have hYt : Y.trace = 0 := by
    rw [hYdef, Matrix.trace_sub, Matrix.trace_sub, Matrix.trace_smul, Matrix.trace_smul, hn, htr1, htr]; norm_num
  have hVY : (V * Y).trace = 0 := by
    rw [hYdef]
    simp only [Matrix.mul_sub, Matrix.mul_smul, Matrix.mul_one, e21, e31, Matrix.trace_sub, Matrix.trace_smul,
      smul_eq_mul, htr, hn, ← hb]
    ring
  have hV2Y : (V ^ 2 * Y).trace = 1 / 2 - 1 / 3 - b ^ 2 := by
    rw [hYdef]
    simp only [Matrix.mul_sub, Matrix.mul_smul, Matrix.mul_one, e42, e32, Matrix.trace_sub, Matrix.trace_smul,
      smul_eq_mul, hp4, hn, ← hb]
    ring
  have hYY : (Y * Y).trace = (V ^ 2 * Y).trace := by
    have e : Y * Y = V ^ 2 * Y - (1 / 3 : ℝ) • Y - b • (V * Y) := by
      calc Y * Y = (V ^ 2 - (1 / 3 : ℝ) • (1 : Matrix (Fin 3) (Fin 3) ℝ) - b • V) * Y := by rw [← hYdef]
        _ = V ^ 2 * Y - (1 / 3 : ℝ) • Y - b • (V * Y) := by
          simp only [Matrix.sub_mul, Matrix.smul_mul, Matrix.one_mul]
    rw [e, Matrix.trace_sub, Matrix.trace_sub, Matrix.trace_smul, Matrix.trace_smul, hYt, hVY]; simp
  have key : b ^ 2 = 1 / 6 ↔ Y = 0 := by
    constructor
    · intro h
      exact eq_zero_of_trace_sq hYs (by rw [hYY, hV2Y, h]; norm_num)
    · intro h
      have : (Y * Y).trace = 0 := by rw [h]; simp
      rw [hYY, hV2Y] at this; linarith
  have hY0 : Y = 0 ↔ V ^ 2 = (1 / 3 : ℝ) • (1 : Matrix (Fin 3) (Fin 3) ℝ) + b • V := by
    rw [hYdef, sub_sub, sub_eq_zero]
  refine ⟨?_, key.trans hY0⟩
  constructor
  · intro hc
    have h0 := hc Y hYs hYt hVY
    rw [hV2Y] at h0
    linarith
  · intro h X _ hX hVX
    have hY := key.mp h
    rw [hY0] at hY
    rw [hY, Matrix.add_mul, Matrix.trace_add, Matrix.smul_mul, Matrix.smul_mul, Matrix.one_mul, Matrix.trace_smul,
      Matrix.trace_smul, hX, hVX]
    simp

open HamiltonsCubic.CP2Real HamiltonsCubic.RealLayer HamiltonsCubic.FrameLayer in
/-- **The composition**: at unit norm, `V` is a critical point of `det` on the sphere exactly when `θ(W_V)² = 3/2`,
and exactly when `W_V` is a nonzero multiple of `W_c` after an orthogonal frame change, the point `± W_{ℂP²}`. -/
theorem crit_iff_CP {n : ℕ} (hn : 4 ≤ n) (V : Matrix (Fin 3) (Fin 3) ℝ) (hV : Vᵀ = V) (htr : V.trace = 0)
    (hnorm : (V ^ 2).trace = 1) :
    (IsCritDet V ↔ theta (WMat n V) ^ 2 = 3 / 2) ∧
      (IsCritDet V ↔ ∃ U : Matrix (Fin n) (Fin n) ℝ, IsOrth U ∧ ∃ t : ℝ, t ≠ 0 ∧ conjOp U (WMat n V) = t • Wc n) := by
  obtain ⟨hN, hP⟩ := half_flat_values hn hV htr
  have hθ : theta (WMat n V) = 9 * V.det := by
    unfold theta HamiltonsCubic.RealLayer.norm; rw [hN, hP, hnorm]; simp
  have h3 := HamiltonsCubic.L124Det.trace_cube_eq_three_det V htr
  have h1 : IsCritDet V ↔ theta (WMat n V) ^ 2 = 3 / 2 := by
    rw [(crit_iff V hV htr hnorm).1, hθ, h3]
    constructor <;> intro h <;> nlinarith [h]
  refine ⟨h1, ?_⟩
  rw [h1]
  have hs : Real.sqrt (3 / 2) ^ 2 = 3 / 2 := Real.sq_sqrt (by norm_num)
  have hs0 : 0 ≤ Real.sqrt (3 / 2) := Real.sqrt_nonneg _
  constructor
  · intro h
    have hpm : theta (WMat n V) = Real.sqrt (3 / 2) ∨ theta (WMat n V) = -Real.sqrt (3 / 2) := by
      have : (theta (WMat n V) - Real.sqrt (3 / 2)) * (theta (WMat n V) + Real.sqrt (3 / 2)) = 0 := by nlinarith
      rcases mul_eq_zero.mp this with h' | h'
      · left; linarith
      · right; linarith
    rcases hpm with hp | hm
    · obtain ⟨U, hU, t, ht, hc⟩ := (half_flat_eq_pos hn hV htr).mp hp
      exact ⟨U, hU, t, ht.ne', hc⟩
    · obtain ⟨U, hU, t, ht, hc⟩ := (half_flat_eq_neg hn hV htr).mp hm
      exact ⟨U, hU, t, ht.ne, hc⟩
  · rintro ⟨U, hU, t, ht, hc⟩
    rcases lt_or_gt_of_ne ht with hneg | hpos
    · rw [(half_flat_eq_neg hn hV htr).mpr ⟨U, hU, t, hneg, hc⟩]; nlinarith
    · rw [(half_flat_eq_pos hn hV htr).mpr ⟨U, hU, t, hpos, hc⟩]; exact hs

end HamiltonsCubic.L124Crit
