import HamiltonsCubic.Results.L162

set_option linter.style.longLine false

/-!
# L162's monotonicity: `F(n) > F(12)` for every real `n > 12`

[findings/second-order.md](../../../findings/second-order.md), Lemma L162: *"`F(n) > F(12)` at every even
`n ≥ 14`"*, by `F` rising in `s₀` and falling in `β`, `β` falling and `s₀` rising, the last reduced to `D(n) > 0`.
[L162.lean](L162.lean) proves the pieces, and this file supplies `s₀` and composes them.

- `q_hasDerivAt'`, `Sfun_hasDerivAt`: `S = c_p + ρw₀²` has `S'(x) = (8√6x(x−1)(x−2)²(x−4) + q P(x))/(x⁴(x−2)²(x−1))`
  with `q = √(2(x−1)(x−2))`, the record's numerator, positive on `x ≥ 12` through `D_pos`;
- `Sfun_strictMonoOn`, `Sfun_twelve_pos`: `S` strictly increases on `[12, ∞)` and `S(12) > 0`;
- **`F_gt_twelve`**: `F(n) > F(12)` for every real `n > 12`, so at every even `n ≥ 14`.
-/

namespace HamiltonsCubic.L162

/-- `q(x) = √(2(x − 1)(x − 2))`, so `θ₀ = q/x`. -/
noncomputable def q (x : ℝ) : ℝ := Real.sqrt (2 * (x - 1) * (x - 2))

/-- `S(x) = c_p + ρ w₀²` with `c_p = 3θ₀/(x − 2)`, `ρ = √6 − θ₀(x + 16)/(2(x − 2))`, `w₀ = (x − 4)/x`. -/
noncomputable def Sfun (x : ℝ) : ℝ :=
  3 * (q x / x) / (x - 2) + (Real.sqrt 6 - q x / x * (x + 16) / (2 * (x - 2))) * ((x - 4) / x) ^ 2

theorem q_hasDerivAt (x : ℝ) (hx : 2 < x) : HasDerivAt q ((2 * x - 3) / q x) x := by
  have hpos : 0 < 2 * (x - 1) * (x - 2) := by nlinarith
  have hp : HasDerivAt (fun x => 2 * (x - 1) * (x - 2)) (4 * x - 6) x := by
    exact ((((hasDerivAt_id' x).sub_const 1).const_mul 2).mul ((hasDerivAt_id' x).sub_const 2)).congr_deriv
      (by ring)
  have h := hp.sqrt hpos.ne'
  have hq : q x = Real.sqrt (2 * (x - 1) * (x - 2)) := rfl
  have hq0 : 0 < Real.sqrt (2 * (x - 1) * (x - 2)) := Real.sqrt_pos.mpr hpos
  have e : (2 * x - 3) / q x = (4 * x - 6) / (2 * Real.sqrt (2 * (x - 1) * (x - 2))) := by
    rw [hq]; field_simp; ring
  rw [e]
  exact h

theorem q_sq (x : ℝ) (hx : 2 < x) : q x ^ 2 = 2 * (x - 1) * (x - 2) := Real.sq_sqrt (by nlinarith)

theorem q_pos (x : ℝ) (hx : 2 < x) : 0 < q x := Real.sqrt_pos.mpr (by nlinarith)

theorem q_hasDerivAt' (x : ℝ) (hx : 2 < x) :
    HasDerivAt q ((2 * x - 3) * q x / (2 * (x - 1) * (x - 2))) x := by
  have h := q_hasDerivAt x hx
  have e : (2 * x - 3) / q x = (2 * x - 3) * q x / (2 * (x - 1) * (x - 2)) := by
    have hq := q_sq x hx
    have hq0 := (q_pos x hx).ne'
    have h1 : (x - 1) ≠ 0 := by linarith
    have h2 : (x - 2) ≠ 0 := by linarith
    rw [← hq]; field_simp
  rw [← e]; exact h

theorem Sfun_hasDerivAt (x : ℝ) (hx : 12 ≤ x) : ∃ d, HasDerivAt Sfun d x ∧ 0 < d := by
  have hq := q_hasDerivAt' x (by linarith)
  have hx0 : x ≠ 0 := by linarith
  have hx2 : x - 2 ≠ 0 := by linarith
  have hx22 : 2 * (x - 2) ≠ 0 := by intro h; apply hx2; linarith
  have hθ := hq.div (hasDerivAt_id' x) hx0
  have h1 := (hθ.const_mul 3).div ((hasDerivAt_id' x).sub_const 2) hx2
  have h2 := (hasDerivAt_const x (Real.sqrt 6)).sub
    ((hθ.mul ((hasDerivAt_id' x).add_const 16)).div (((hasDerivAt_id' x).sub_const 2).const_mul 2) hx22)
  have h3 := (((hasDerivAt_id' x).sub_const 4).div (hasDerivAt_id' x) hx0).pow 2
  have hS := h1.add (h2.mul h3)
  have hx1 : x - 1 ≠ 0 := by linarith
  refine ⟨(8 * Real.sqrt 6 * x * (x - 1) * (x - 2) ^ 2 * (x - 4) + q x * P x) / (x ^ 4 * (x - 2) ^ 2 * (x - 1)),
    hS.congr_deriv ?_, ?_⟩
  · simp only [Pi.div_apply, Pi.mul_apply, Pi.sub_apply, Pi.add_apply, Pi.pow_apply, one_mul, mul_one,
      Nat.cast_ofNat]
    unfold P
    norm_num
    field_simp
    ring
  · have hden : 0 < x ^ 4 * (x - 2) ^ 2 * (x - 1) := by
      have : 0 < x - 1 := by linarith
      positivity
    apply div_pos _ hden
    have hq0 := q_pos x (by linarith)
    have hq2 := q_sq x (by linarith)
    have h6 : Real.sqrt 6 ^ 2 = 6 := Real.sq_sqrt (by norm_num)
    have h60 : 0 < Real.sqrt 6 := Real.sqrt_pos.mpr (by norm_num)
    have ha : 0 < 8 * Real.sqrt 6 * x * (x - 1) * (x - 2) ^ 2 * (x - 4) := by
      have : 0 < x - 4 := by linarith
      have : 0 < x - 1 := by linarith
      positivity
    by_cases hP : 0 ≤ P x
    · have := mul_nonneg hq0.le hP; linarith
    · push Not at hP
      have hD := D_pos x hx
      unfold D at hD
      have hb : 0 < -(q x * P x) := by nlinarith
      have hsq : (-(q x * P x)) ^ 2 < (8 * Real.sqrt 6 * x * (x - 1) * (x - 2) ^ 2 * (x - 4)) ^ 2 := by
        have e1 : (-(q x * P x)) ^ 2 = 2 * (x - 1) * (x - 2) * P x ^ 2 := by rw [neg_sq, mul_pow, hq2]
        have e2 : (8 * Real.sqrt 6 * x * (x - 1) * (x - 2) ^ 2 * (x - 4)) ^ 2
            = 384 * x ^ 2 * (x - 1) ^ 2 * (x - 2) ^ 4 * (x - 4) ^ 2 := by
          rw [show (8 * Real.sqrt 6 * x * (x - 1) * (x - 2) ^ 2 * (x - 4)) ^ 2
            = 64 * Real.sqrt 6 ^ 2 * x ^ 2 * (x - 1) ^ 2 * (x - 2) ^ 4 * (x - 4) ^ 2 by ring, h6]; ring
        rw [e1, e2]
        have h12 : 0 < (x - 1) * (x - 2) := by nlinarith
        nlinarith [mul_pos h12 hD]
      nlinarith [hsq, ha, hb]

/-- **`S` strictly increases on `[12, ∞)`**, so `s₀ = √S` rises. -/
theorem Sfun_strictMonoOn : StrictMonoOn Sfun (Set.Ici 12) := by
  apply strictMonoOn_of_deriv_pos (convex_Ici 12)
  · intro x hx
    obtain ⟨d, hd, -⟩ := Sfun_hasDerivAt x hx
    exact hd.continuousAt.continuousWithinAt
  · intro x hx
    rw [interior_Ici] at hx
    obtain ⟨d, hd, hpos⟩ := Sfun_hasDerivAt x (le_of_lt hx)
    rw [hd.deriv]; exact hpos

/-- `S(12) > 0`. -/
theorem Sfun_twelve_pos : 0 < Sfun 12 := by
  unfold Sfun q
  have h220 : Real.sqrt (2 * (12 - 1) * (12 - 2)) = Real.sqrt 220 := by norm_num
  rw [h220]
  have hs : 0 < Real.sqrt 220 := Real.sqrt_pos.mpr (by norm_num)
  have hs2 : Real.sqrt 220 ^ 2 = 220 := Real.sq_sqrt (by norm_num)
  have h6 : Real.sqrt 6 ^ 2 = 6 := Real.sq_sqrt (by norm_num)
  have h60 : 0 < Real.sqrt 6 := Real.sqrt_pos.mpr (by norm_num)
  have hρ : Real.sqrt 220 * 7 < Real.sqrt 6 * 60 := by nlinarith
  norm_num
  nlinarith

/-- **L162's MONOTONICITY**: for every real `n > 12`, `F(n) > F(12)`, where
`F(n) = 4s₀/(√(4βs₀ + 1) + 1)²` with `s₀ = √S(n)` and `β = λ/(2C)`. -/
theorem F_gt_twelve {n : ℝ} (hn : 12 < n) :
    let s := fun x => Real.sqrt (Sfun x)
    let β := fun x => lam x / (2 * (2 * (2 * x - 3) / (x - 1)))
    4 * s 12 / (Real.sqrt (4 * β 12 * s 12 + 1) + 1) ^ 2 < 4 * s n / (Real.sqrt (4 * β n * s n + 1) + 1) ^ 2 := by
  intro s β
  have hS := Sfun_strictMonoOn (Set.mem_Ici.mpr le_rfl) (Set.mem_Ici.mpr hn.le) hn
  have hS12 := Sfun_twelve_pos
  have hs : s 12 < s n := Real.sqrt_lt_sqrt hS12.le hS
  have hs0 : 0 < s 12 := Real.sqrt_pos.mpr hS12
  have hβ : β n < β 12 := beta_strictAnti le_rfl hn
  have hβ0 : 0 < β n := by
    show 0 < lam n / (2 * (2 * (2 * n - 3) / (n - 1)))
    have hgt := theta0Sq_gt n hn.le
    have h1 : Real.sqrt (3 / 2) < Real.sqrt (2 * (n - 1) * (n - 2) / n ^ 2) := Real.sqrt_lt_sqrt (by norm_num) hgt
    have hl : 0 < lam n := div_pos (by norm_num) (Real.sqrt_pos.mpr (by linarith))
    have hC : 0 < 2 * (2 * n - 3) / (n - 1) := div_pos (by linarith) (by linarith)
    positivity
  rw [F_form hs0.le (by linarith), F_form (hs0.trans hs).le hβ0.le]
  calc 2 * s 12 / (1 + 2 * β 12 * s 12 + Real.sqrt (1 + 4 * β 12 * s 12))
      < 2 * s 12 / (1 + 2 * β n * s 12 + Real.sqrt (1 + 4 * β n * s 12)) := F_antitone_beta hs0 hβ0.le hβ
    _ < 2 * s n / (1 + 2 * β n * s n + Real.sqrt (1 + 4 * β n * s n)) := F_strictMono_s hs0.le hs hβ0

end HamiltonsCubic.L162
