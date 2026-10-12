import HamiltonsCubic.Results.L162Value

set_option linter.style.longLine false

/-!
# L162's limit, as a theorem

[second-order.md](../../../findings/second-order.md), Lemma L162: *"with `F(12) = 0.38673` and limit `0.90304`"*. The
limit is a closed form: as `n → ∞`, `θ₀ → √2`, `(n+16)/(2(n-2)) → ½`, `w₀ = (n-4)/n → 1`, `c_p → 0` and `C → 4`, so

* **`Finf`**: `F∞ = 4s∞/(√(4β∞s∞ + 1) + 1)²` with `s∞ = √(√6 - √2/2)`, `β∞ = λ∞/8`, `λ∞ = 2/√(9(√2 - √(3/2)))`;
* **`F_tendsto`**: `F(n) → F∞` as `n → ∞`;
* **`Finf_bounds`**: `0.903035 < F∞ < 0.903036`, so the printed `0.90304` is the limit to five places.
-/

namespace HamiltonsCubic.L162

open Filter Topology

/-- `F(n)` as the record composes it. -/
noncomputable def Fn (n : ℝ) : ℝ :=
  4 * Real.sqrt (Sfun n) / (Real.sqrt (4 * (lam n / (2 * (2 * (2 * n - 3) / (n - 1)))) * Real.sqrt (Sfun n) + 1) + 1) ^ 2

/-- The limit's closed form. -/
noncomputable def Finf : ℝ :=
  4 * Real.sqrt (Real.sqrt 6 - Real.sqrt 2 / 2) /
    (Real.sqrt (4 * (2 / Real.sqrt (9 * (Real.sqrt 2 - Real.sqrt (3 / 2))) / 8) *
      Real.sqrt (Real.sqrt 6 - Real.sqrt 2 / 2) + 1) + 1) ^ 2

theorem inv_tendsto : Tendsto (fun x : ℝ => x⁻¹) atTop (𝓝 0) := tendsto_inv_atTop_zero

/-- `a + b/x → a`. -/
theorem lin_tendsto (a b : ℝ) : Tendsto (fun x : ℝ => a + b * x⁻¹) atTop (𝓝 a) := by
  simpa using (tendsto_const_nhds (x := a)).add (inv_tendsto.const_mul b)

theorem theta_tendsto : Tendsto (fun x : ℝ => Real.sqrt (2 * (x - 1) * (x - 2) / x ^ 2)) atTop (𝓝 (Real.sqrt 2)) := by
  have h : Tendsto (fun x : ℝ => 2 * (1 + (-1) * x⁻¹) * (1 + (-2) * x⁻¹)) atTop (𝓝 (2 * 1 * 1)) :=
    ((lin_tendsto 1 (-1)).const_mul 2).mul (lin_tendsto 1 (-2))
  have e : ∀ᶠ x : ℝ in atTop, 2 * (1 + (-1) * x⁻¹) * (1 + (-2) * x⁻¹) = 2 * (x - 1) * (x - 2) / x ^ 2 := by
    filter_upwards [eventually_gt_atTop 0] with x hx
    field_simp; ring
  simpa using (h.congr' e).sqrt

theorem q_div_tendsto : Tendsto (fun x : ℝ => q x / x) atTop (𝓝 (Real.sqrt 2)) := by
  refine theta_tendsto.congr' ?_
  filter_upwards [eventually_gt_atTop 2] with x hx
  unfold q
  rw [Real.sqrt_div' _ (by positivity : (0 : ℝ) ≤ x ^ 2), Real.sqrt_sq (by linarith : (0 : ℝ) ≤ x)]

theorem Sfun_tendsto : Tendsto Sfun atTop (𝓝 (Real.sqrt 6 - Real.sqrt 2 / 2)) := by
  have h1 : Tendsto (fun x : ℝ => 3 * (q x / x) / (x - 2)) atTop (𝓝 0) := by
    have hd : Tendsto (fun x : ℝ => 3 * (q x / x) * ((1 + (-2) * x⁻¹)⁻¹ * x⁻¹)) atTop (𝓝 (3 * Real.sqrt 2 * ((1 : ℝ)⁻¹ * 0))) := by
      refine (q_div_tendsto.const_mul 3).mul ?_
      refine ((lin_tendsto 1 (-2)).inv₀ (by norm_num)).mul ?_
      simpa using inv_tendsto
    simp at hd
    refine hd.congr' ?_
    filter_upwards [eventually_gt_atTop 2] with x hx
    have hx0 : x ≠ 0 := by linarith
    have hx2 : x - 2 ≠ 0 := by linarith
    have hx2' : x + -2 ≠ 0 := by intro h; linarith
    field_simp
    ring
  have h2 : Tendsto (fun x : ℝ => (x + 16) / (2 * (x - 2))) atTop (𝓝 (1 / 2)) := by
    have hd : Tendsto (fun x : ℝ => (1 + 16 * x⁻¹) / (2 * (1 + (-2) * x⁻¹))) atTop (𝓝 ((1 : ℝ) / (2 * 1))) :=
      (lin_tendsto 1 16).div ((lin_tendsto 1 (-2)).const_mul 2) (by norm_num)
    simp only [mul_one] at hd
    refine hd.congr' ?_
    filter_upwards [eventually_gt_atTop 2] with x hx
    have hx0 : x ≠ 0 := by linarith
    have hx2 : x - 2 ≠ 0 := by linarith
    have hx2' : x + -2 ≠ 0 := by intro h; linarith
    field_simp
    ring
  have h3 : Tendsto (fun x : ℝ => ((x - 4) / x) ^ 2) atTop (𝓝 1) := by
    have hd : Tendsto (fun x : ℝ => (1 + (-4) * x⁻¹) ^ 2) atTop (𝓝 (1 ^ 2)) := (lin_tendsto 1 (-4)).pow 2
    simp only [one_pow] at hd
    refine hd.congr' ?_
    filter_upwards [eventually_gt_atTop 0] with x hx
    field_simp
    ring
  have h := h1.add (((tendsto_const_nhds (x := Real.sqrt 6)).sub (q_div_tendsto.mul h2)).mul h3)
  have e : (0 : ℝ) + (Real.sqrt 6 - Real.sqrt 2 * (1 / 2)) * 1 = Real.sqrt 6 - Real.sqrt 2 / 2 := by ring
  rw [e] at h
  refine h.congr' (Eventually.of_forall fun x => ?_)
  unfold Sfun; ring

theorem lam_tendsto : Tendsto lam atTop (𝓝 (2 / Real.sqrt (9 * (Real.sqrt 2 - Real.sqrt (3 / 2))))) := by
  have hpos : 0 < Real.sqrt 2 - Real.sqrt (3 / 2) := by
    have := Real.sqrt_lt_sqrt (by norm_num : (0 : ℝ) ≤ 3 / 2) (by norm_num : (3 / 2 : ℝ) < 2); linarith
  have hr : Real.sqrt (9 * (Real.sqrt 2 - Real.sqrt (3 / 2))) ≠ 0 := (Real.sqrt_pos.mpr (by linarith)).ne'
  have h := ((theta_tendsto.sub_const (Real.sqrt (3 / 2))).const_mul 9).sqrt
  exact (tendsto_const_nhds.div h hr)

theorem C_tendsto : Tendsto (fun x : ℝ => 2 * (2 * x - 3) / (x - 1)) atTop (𝓝 4) := by
  have hd : Tendsto (fun x : ℝ => 2 * (2 + (-3) * x⁻¹) / (1 + (-1) * x⁻¹)) atTop (𝓝 (2 * 2 / 1)) :=
    ((lin_tendsto 2 (-3)).const_mul 2).div (lin_tendsto 1 (-1)) (by norm_num)
  norm_num at hd
  refine hd.congr' ?_
  filter_upwards [eventually_gt_atTop 1] with x hx
  have hx0 : x ≠ 0 := by linarith
  have hx1 : x - 1 ≠ 0 := by linarith
  have hx1' : x + -1 ≠ 0 := by intro h; linarith
  field_simp
  ring

/-- **`F(n) → F∞`.** -/
theorem F_tendsto : Tendsto Fn atTop (𝓝 Finf) := by
  have hs := Sfun_tendsto.sqrt
  have hβ := lam_tendsto.div (C_tendsto.const_mul 2) (by norm_num)
  have hinner := ((hβ.const_mul 4).mul hs).add_const 1
  have hden := (hinner.sqrt.add_const 1).pow 2
  have hden0 : (Real.sqrt (4 * (2 / Real.sqrt (9 * (Real.sqrt 2 - Real.sqrt (3 / 2))) / (2 * 4)) *
      Real.sqrt (Real.sqrt 6 - Real.sqrt 2 / 2) + 1) + 1) ^ 2 ≠ 0 := by positivity
  have h := (hs.const_mul 4).div hden hden0
  unfold Finf
  rw [show (2 : ℝ) * 4 = 8 by norm_num] at h
  exact h

/-- **`0.903035 < F∞ < 0.903036`.** -/
theorem Finf_bounds : 903035 / 1000000 < Finf ∧ Finf < 903036 / 1000000 := by
  have h6 : (1224744871391 / 500000000000 : ℝ) < Real.sqrt 6 ∧ Real.sqrt 6 < 489897948557 / 200000000000 :=
    ⟨(Real.lt_sqrt (by norm_num)).mpr (by norm_num), (Real.sqrt_lt' (by norm_num)).mpr (by norm_num)⟩
  have h2 : (353553390593 / 250000000000 : ℝ) < Real.sqrt 2 ∧ Real.sqrt 2 < 11313708499 / 8000000000 :=
    ⟨(Real.lt_sqrt (by norm_num)).mpr (by norm_num), (Real.sqrt_lt' (by norm_num)).mpr (by norm_num)⟩
  have h32 : (122474487139 / 100000000000 : ℝ) < Real.sqrt (3 / 2) ∧ Real.sqrt (3 / 2) < 1224744871393 / 1000000000000 :=
    ⟨(Real.lt_sqrt (by norm_num)).mpr (by norm_num), (Real.sqrt_lt' (by norm_num)).mpr (by norm_num)⟩
  set S := Real.sqrt 6 - Real.sqrt 2 / 2 with hS
  have hs : (164999193 / 125000000 : ℝ) < Real.sqrt S ∧ Real.sqrt S < 329998387 / 250000000 :=
    ⟨(Real.lt_sqrt (by norm_num)).mpr (by rw [hS]; nlinarith [h6.1, h2.2]),
      (Real.sqrt_lt' (by norm_num)).mpr (by rw [hS]; nlinarith [h6.2, h2.1])⟩
  set d := Real.sqrt 2 - Real.sqrt (3 / 2) with hd
  have hr : (13058400431 / 10000000000 : ℝ) < Real.sqrt (9 * d) ∧ Real.sqrt (9 * d) < 3264600109 / 2500000000 :=
    ⟨(Real.lt_sqrt (by norm_num)).mpr (by rw [hd]; nlinarith [h2.1, h32.2]),
      (Real.sqrt_lt' (by norm_num)).mpr (by rw [hd]; nlinarith [h2.2, h32.1])⟩
  set β := 2 / Real.sqrt (9 * d) / 8 with hβ
  have hr0 : 0 < Real.sqrt (9 * d) := by linarith [hr.1]
  have hβe : β = 1 / 4 / Real.sqrt (9 * d) := by rw [hβ]; field_simp; ring
  have hβlo : (191447643 / 1000000000 : ℝ) < β := by rw [hβe, lt_div_iff₀ hr0]; nlinarith [hr.2]
  have hβhi : β < 95723823 / 500000000 := by rw [hβe, div_lt_iff₀ hr0]; nlinarith [hr.1]
  set s := Real.sqrt S with hsdef
  have hs0 : 0 < s := by linarith [hs.1]
  have hF : Finf = 2 * s / (1 + 2 * β * s + Real.sqrt (1 + 4 * β * s)) := by
    unfold Finf; rw [← hS, ← hd, ← hβ, ← hsdef, F_form hs0.le (by linarith)]
  rw [hF]
  have hlow : 2 * (164999193 / 125000000) / (1 + 2 * (95723823 / 500000000) * (164999193 / 125000000)
        + Real.sqrt (1 + 4 * (95723823 / 500000000) * (164999193 / 125000000)))
      ≤ 2 * s / (1 + 2 * β * s + Real.sqrt (1 + 4 * β * s)) := by
    have a1 := F_strictMono_s (s := 164999193 / 125000000) (s' := s) (β := 95723823 / 500000000)
      (by norm_num) hs.1 (by norm_num)
    have a2 := F_antitone_beta (s := s) (β := β) (β' := 95723823 / 500000000) hs0 (by linarith) hβhi
    linarith
  have hhigh : 2 * s / (1 + 2 * β * s + Real.sqrt (1 + 4 * β * s))
      ≤ 2 * (329998387 / 250000000) / (1 + 2 * (191447643 / 1000000000) * (329998387 / 250000000)
        + Real.sqrt (1 + 4 * (191447643 / 1000000000) * (329998387 / 250000000))) := by
    have a1 := F_strictMono_s (s := s) (s' := 329998387 / 250000000) (β := 191447643 / 1000000000)
      hs0.le hs.2 (by norm_num)
    have a2 := F_antitone_beta (s := s) (β := 191447643 / 1000000000) (β' := β) hs0 (by norm_num) hβlo
    linarith
  have tU : Real.sqrt (1 + 4 * (95723823 / 500000000 : ℝ) * (164999193 / 125000000)) < 141804043 / 100000000 :=
    (Real.sqrt_lt' (by norm_num)).mpr (by norm_num)
  have tL : (3545101 / 2500000 : ℝ) < Real.sqrt (1 + 4 * (191447643 / 1000000000) * (329998387 / 250000000)) :=
    (Real.lt_sqrt (by norm_num)).mpr (by norm_num)
  have tU0 : 0 ≤ Real.sqrt (1 + 4 * (95723823 / 500000000 : ℝ) * (164999193 / 125000000)) := Real.sqrt_nonneg _
  constructor
  · refine lt_of_lt_of_le ?_ hlow
    rw [lt_div_iff₀ (by positivity)]
    nlinarith [tU]
  · refine lt_of_le_of_lt hhigh ?_
    rw [div_lt_iff₀ (by positivity)]
    nlinarith [tL]

end HamiltonsCubic.L162
