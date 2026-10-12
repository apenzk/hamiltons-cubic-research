import Mathlib

set_option linter.style.longLine false
set_option maxHeartbeats 1000000

/-!
# L242, the capped three-value class system reaches above `√(3/2)` under every valid seven-frame cap

## The record's statement, quoted from [bounds-relaxations.md](../../../findings/bounds-relaxations.md)

> **Statement.** At $n=12$, the three-value spectrum $e=(-\tfrac3{20},0,\tfrac3{20})$ with multiplicities
> $(12,42,12)$, so $\theta^2=\tfrac{50}{27}$ and $\theta\approx1.361>\sqrt{3/2}$, carries the class values
> $\tau_{002}=104$, $\tau_{011}=8$, $\tau_{022}=24$, $\tau_{111}=808$, $\tau_{112}=8$, $\tau_{222}=80$ (the other
> four zero) and $G_{12}=120$, which satisfy, in exact rational arithmetic, every class-level constraint L241
> lists, with every seven-frame class total at most $\tfrac{1172}{33}\approx35.5<42$.

## What is typed here

The same checks as [L241OffRayWitness.lean](L241OffRayWitness.lean), on this point, generated from
[verify_I73c_offray_witness.py](../../../scripts/misc/verify_I73c_offray_witness.py)'s output: the rows,
`tau_nonneg`, `pair_caps`, `kyfan_caps`, `seven_frame_caps` with `seven_frame_below_42`, `G_values`,
`gram_rows`, `gram_constraints`, `section5` at `μ̊ = 99/100` with `mu_cap_ge` and `section5_at_cap`, and
`theta_sq`, `theta_above`.

## What is NOT typed here

**L235's window**, whose `I₁` needs the corrections the layer does not define (the script gives
`I₁ = −5901/250` inside its window in exact arithmetic); **and that the class-level system is the correct
relaxation of criticality**, L104's and L235's derivation on `Λ²ℝⁿ`.
-/

namespace HamiltonsCubic.L242OffRayWitness

/-- Multiplicities `(12, 42, 12)`. -/
def m : Fin 3 → ℚ := ![12, 42, 12]
/-- The `e`-values `(-3/20, 0, 3/20)`. -/
def e : Fin 3 → ℚ := ![-3/20, 0, 3/20]
/-- `n = 12`. -/
def n : ℚ := 12

/-- The class values `τ_{abc}`, totally symmetric. -/
def tau : Fin 3 → Fin 3 → Fin 3 → ℚ :=
  ![ ![ ![0, 0, 104],  ![0, 8, 0],   ![104, 0, 24] ],
     ![ ![0, 8, 0],     ![8, 808, 8], ![0, 8, 0] ],
     ![ ![104, 0, 24],  ![0, 8, 0],   ![24, 0, 80] ] ]

theorem tau_symm (i j k : Fin 3) : tau i j k = tau j i k ∧ tau i j k = tau i k j := by
  fin_cases i <;> fin_cases j <;> fin_cases k <;> exact ⟨rfl, rfl⟩

theorem tau_nonneg (i j k : Fin 3) : 0 ≤ tau i j k := by
  fin_cases i <;> fin_cases j <;> fin_cases k <;> norm_num [tau]

@[simp] theorem m0 : m 0 = 12 := rfl
@[simp] theorem m1 : m 1 = 42 := rfl
@[simp] theorem m2 : m 2 = 12 := rfl
@[simp] theorem e0 : e 0 = -3/20 := rfl
@[simp] theorem e1 : e 1 = 0 := rfl
@[simp] theorem e2 : e 2 = 3/20 := rfl

theorem mult_sum : m 0 + m 1 + m 2 = n * (n - 1) / 2 := by norm_num [n]
theorem traceless : m 0 * e 0 + m 1 * e 1 + m 2 * e 2 = 0 := by norm_num

/-- `∑ m e² = 27/50 = 1/θ²`. -/
theorem theta_sq : m 0 * e 0 ^ 2 + m 1 * e 1 ^ 2 + m 2 * e 2 ^ 2 = 1 / (50 / 27) := by
  norm_num
theorem theta_above : (3 : ℚ) / 2 < 50 / 27 := by norm_num

/-! ## The per-index rows, as the builder writes them -/

theorem rowA (a : Fin 3) : ∑ b, ∑ c, tau a b c = 2 * (n - 2) * m a := by
  fin_cases a <;> norm_num [Fin.sum_univ_three, tau, m, n, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two, Matrix.head_cons, Matrix.tail_cons]
theorem rowB (a : Fin 3) : ∑ b, ∑ c, tau a b c * e b = -2 * m a * e a := by
  fin_cases a <;> norm_num [Fin.sum_univ_three, tau, m, e, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two, Matrix.head_cons, Matrix.tail_cons]
theorem rowC (a : Fin 3) : ∑ b, ∑ c, tau a b c * e b * e c = 2 * m a * e a * (1 - e a) := by
  fin_cases a <;> norm_num [Fin.sum_univ_three, tau, m, e, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two, Matrix.head_cons, Matrix.tail_cons]

/-! ## Per-pair bracket sums, pair caps and Ky Fan caps -/

/-- `δ` as a rational. -/
def d (a b : Fin 3) : ℚ := if a = b then 1 else 0
/-- The class count `N_{abc}` of ordered triples. -/
def N (a b c : Fin 3) : ℚ := m a * (m b - d a b) * (m c - d a c - d b c)
/-- `P_{ab} = ∑_c (m_c − δ_ac − δ_bc) τ_{abc} / N_{abc}`, the per-pair bracket sum. -/
def P (a b : Fin 3) : ℚ := ∑ c, (m c - d a c - d b c) * (tau a b c / N a b c)

theorem P_values :
    P 0 0 = 26/33 ∧ P 0 1 = 1/63 ∧ P 0 2 = 8/9 ∧ P 1 1 = 412/861 ∧ P 1 2 = 1/63 ∧ P 2 2 = 26/33 := by
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_⟩ <;> simp [P, N, d, Fin.sum_univ_three, tau, m] <;> norm_num

theorem P_symm (a b : Fin 3) : P a b = P b a := by
  fin_cases a <;> fin_cases b <;> simp [P, N, d, Fin.sum_univ_three, tau, m] <;> norm_num

theorem P_le (a b : Fin 3) : P a b ≤ 8/9 := by
  fin_cases a <;> fin_cases b <;> simp [P, N, d, Fin.sum_univ_three, tau, m] <;> norm_num

/-- L31's pair cap, `P ≤ 2`, at every pair. -/
theorem pair_caps (a b : Fin 3) : P a b ≤ 2 := le_trans (P_le a b) (by norm_num)

/-- L237's constants, odd `r` bounded by the next even one. -/
def kappa : ℕ → ℚ
  | 2 => 4 | 3 => 6 | 4 => 6 | 5 => 8 | 6 => 8 | _ => 0

/-- **Every Ky Fan cap**: for any partner profile `r` with `2 ≤ ∑ r ≤ 6`,
`∑_b r_b P_{ab} ≤ κ_{∑ r}`, since every `P_{ab} ≤ 8/9` and `R · 8/9 ≤ κ_R`. -/
theorem kyfan_caps (a : Fin 3) (r : Fin 3 → ℕ) (h2 : 2 ≤ ∑ b, r b) (h6 : ∑ b, r b ≤ 6) :
    ∑ b, (r b : ℚ) * P a b ≤ kappa (∑ b, r b) := by
  have hle : ∑ b, (r b : ℚ) * P a b ≤ ∑ b, (r b : ℚ) * (8/9) :=
    Finset.sum_le_sum fun b _ => mul_le_mul_of_nonneg_left (P_le a b) (by positivity)
  have hsum : ∑ b, (r b : ℚ) * (8/9) = ((∑ b, r b : ℕ) : ℚ) * (8/9) := by
    rw [← Finset.sum_mul]; push_cast; rfl
  rw [hsum] at hle
  refine le_trans hle ?_
  generalize ∑ b, r b = R at h2 h6 ⊢
  interval_cases R <;> norm_num [kappa]

/-! ## L240's seven-frame cap at every composition -/

/-- The class-averaged ordered bracket total of a seven-frame with `k_a` elements from class `a`. -/
def frame (k0 k1 k2 : ℚ) : ℚ :=
  k0 * (k0 - 1) * P 0 0 + k1 * (k1 - 1) * P 1 1 + k2 * (k2 - 1) * P 2 2
    + 2 * (k0 * k1 * P 0 1 + k0 * k2 * P 0 2 + k1 * k2 * P 1 2)

theorem seven_frame_caps (k0 k1 : ℕ) (h : k0 + k1 ≤ 7) :
    frame k0 k1 (7 - k0 - k1 : ℕ) ≤ 1172/33 := by
  obtain ⟨h00, h01, h02, h11, h12, h22⟩ := P_values
  have hk0 : k0 ≤ 7 := by omega
  have hk1 : k1 ≤ 7 := by omega
  interval_cases k0 <;> interval_cases k1 <;> (try omega) <;> norm_num [frame, h00, h01, h02, h11, h12, h22]

/-- **Below the octonion value `42`**, which orthonormal seven-frames attain, so no valid seven-frame cap excludes this point. -/
theorem seven_frame_below_42 : (1172 : ℚ) / 33 < 42 := by norm_num

/-! ## The isotropy Gram at `G₁₂ = 120` -/

/-- `s_a = 2(n−1) m_a`, and `p = e₁ − e₀`, `q = e₂ − e₁`. -/
def s (a : Fin 3) : ℚ := 2 * (n - 1) * m a
def p : ℚ := e 1 - e 0
def q : ℚ := e 2 - e 1
def g12 : ℚ := 120
/-- The Gram entries from the section 3 formulas of the summed-pair note. -/
def G : Fin 3 → Fin 3 → ℚ := fun a b =>
  let G01 := g12
  let G02 := (-(e 0) * s 0 - p * g12) / (p + q)
  let G12 := (-(e 1) * s 1 + p * g12) / q
  let G00 := (s 0 * e 2 - q * g12) / (p + q)
  let G11 := (s 1 * e 2 - (p + q) * g12) / q
  let G22 := s 2 - G02 - G12
  ![![G00, G01, G02], ![G01, G11, G12], ![G02, G12, G22]] a b

theorem G_values :
    G 0 0 = 72 ∧ G 0 1 = 120 ∧ G 0 2 = 72 ∧ G 1 1 = 684 ∧ G 1 2 = 120 ∧ G 2 2 = 72 := by
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_⟩ <;> simp [G, s, p, q, g12, n, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two, Matrix.head_cons, Matrix.tail_cons] <;> norm_num

/-- `∑_b G_ab = 2(n−1) m_a` and `∑_b e_b G_ab = 0`, row by row. -/
theorem gram_rows :
    (G 0 0 + G 0 1 + G 0 2 = 2 * (n - 1) * m 0 ∧ e 0 * G 0 0 + e 1 * G 0 1 + e 2 * G 0 2 = 0) ∧
    (G 0 1 + G 1 1 + G 1 2 = 2 * (n - 1) * m 1 ∧ e 0 * G 0 1 + e 1 * G 1 1 + e 2 * G 1 2 = 0) ∧
    (G 0 2 + G 1 2 + G 2 2 = 2 * (n - 1) * m 2 ∧ e 0 * G 0 2 + e 1 * G 1 2 + e 2 * G 2 2 = 0) := by
  obtain ⟨h00, h01, h02, h11, h12, h22⟩ := G_values
  rw [h00, h01, h02, h11, h12, h22]; norm_num [n]

/-- `τ_{ab} = ∑_c τ_{abc}`. -/
def tauab (a b : Fin 3) : ℚ := ∑ c, tau a b c

/-- **Every Gram constraint**: `G_ab ≥ τ_ab/2`, `0 ≤ G_ab ≤ m_a m_b`, Cauchy–Schwarz for `a < b`,
`G_aa ≥ 4 m_a²/n`, the diagonal `G_aa ≥ τ_aa/2`, and the leading minors of `G ⪰ 0`. Cauchy–Schwarz for `(0,2)` and the determinant are equalities: `Ric(e) = 0` at a symmetric spectrum forces `A₀ = A₂`, so rows `0` and `2` of `G` agree at every `G₁₂`. -/
theorem gram_constraints :
    (tauab 0 1 / 2 ≤ G 0 1 ∧ tauab 0 2 / 2 ≤ G 0 2 ∧ tauab 1 2 / 2 ≤ G 1 2) ∧
    (0 ≤ G 0 1 ∧ 0 ≤ G 0 2 ∧ 0 ≤ G 1 2) ∧
    (G 0 1 ≤ m 0 * m 1 ∧ G 0 2 < m 0 * m 2 ∧ G 1 2 ≤ m 1 * m 2) ∧
    (G 0 1 ^ 2 ≤ G 0 0 * G 1 1 ∧ G 0 2 ^ 2 = G 0 0 * G 2 2 ∧ G 1 2 ^ 2 ≤ G 1 1 * G 2 2) ∧
    (4 * m 0 ^ 2 / n ≤ G 0 0 ∧ 4 * m 1 ^ 2 / n ≤ G 1 1 ∧ 4 * m 2 ^ 2 / n ≤ G 2 2) ∧
    (tauab 0 0 / 2 ≤ G 0 0 ∧ tauab 1 1 / 2 ≤ G 1 1 ∧ tauab 2 2 / 2 ≤ G 2 2) ∧
    (0 ≤ G 0 0 ∧ G 0 1 ^ 2 ≤ G 0 0 * G 1 1 ∧
      0 ≤ Matrix.det !![G 0 0, G 0 1, G 0 2; G 0 1, G 1 1, G 1 2; G 0 2, G 1 2, G 2 2]) := by
  obtain ⟨h00, h01, h02, h11, h12, h22⟩ := G_values
  simp only [h00, h01, h02, h11, h12, h22, tauab, Fin.sum_univ_three, Matrix.det_fin_three, Matrix.of_apply, Matrix.cons_val', Matrix.empty_val', Matrix.cons_val_fin_one]
  norm_num [tau, m, n, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two, Matrix.head_cons, Matrix.tail_cons]

/-! ## Section 5's per-pair inequalities -/

/-- The left side `¼ m_a m_b (e_a + e_b − 1) − ¼ ∑_c e_c τ_abc`. -/
def lhs5 (a b : Fin 3) : ℚ := 1/4 * m a * m b * (e a + e b - 1) - 1/4 * ∑ c, e c * tau a b c
/-- The right side at a given `μ̊`, with `3 e_max − ½ = −1/20`. -/
def rhs5 (μ : ℚ) (a b : Fin 3) : ℚ :=
  (μ - 1) / (2 * (n - 2)) * (G a b - tauab a b / 2) + (3 * (3/20) - 1/2) * (m a * m b - G a b) / 6

theorem section5 :
    lhs5 0 1 ≤ rhs5 (99/100) 0 1 ∧ lhs5 0 2 ≤ rhs5 (99/100) 0 2 ∧ lhs5 1 2 ≤ rhs5 (99/100) 1 2 := by
  obtain ⟨h00, h01, h02, h11, h12, h22⟩ := G_values
  simp only [lhs5, rhs5, h01, h02, h12, tauab, Fin.sum_univ_three]
  norm_num [tau, m, e, n, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two, Matrix.head_cons, Matrix.tail_cons]

/-- The proved cap `μ̊ ≤ n Θ_n / ((n−1) θ)`, here `√(5940/6050)`, is at least `99/100`, so the
inequalities at `μ̊ = 99/100` imply them at the cap. -/
theorem mu_cap_ge : (99/100 : ℝ) ≤ Real.sqrt (5940 / 6050) :=
  Real.le_sqrt_of_sq_le (by norm_num)

theorem rhs5_mono (μ μ' : ℚ) (hμ : μ ≤ μ') (a b : Fin 3) (hG : tauab a b / 2 ≤ G a b) :
    rhs5 μ a b ≤ rhs5 μ' a b := by
  unfold rhs5
  have h1 : 0 ≤ G a b - tauab a b / 2 := by linarith
  have h2 : (μ - 1) / (2 * (n - 2)) ≤ (μ' - 1) / (2 * (n - 2)) := by
    apply div_le_div_of_nonneg_right _ (by norm_num [n]); linarith
  nlinarith

/-- **Section 5 at the proved cap.** Over `ℝ`, with `μ̊` anywhere in `[99/100, √(5940/6050)]`, the
right side at `μ̊` is at least the right side at `99/100`, since its `μ̊` coefficient multiplies
`G_ab − τ_ab/2 ≥ 0`; so `section5` gives the inequality at the cap itself. -/
theorem section5_at_cap (μ : ℝ) (hμ : 99/100 ≤ μ) (a b : Fin 3) (hG : tauab a b / 2 ≤ G a b)
    (h : lhs5 a b ≤ rhs5 (99/100) a b) :
    (lhs5 a b : ℝ) ≤ (μ - 1) / (2 * ((n : ℝ) - 2)) * ((G a b : ℝ) - (tauab a b : ℝ) / 2)
      + (3 * (3/20) - 1/2) * ((m a : ℝ) * (m b : ℝ) - (G a b : ℝ)) / 6 := by
  have h' : (lhs5 a b : ℝ) ≤ (rhs5 (99/100) a b : ℝ) := by exact_mod_cast h
  have hG' : (0 : ℝ) ≤ (G a b : ℝ) - (tauab a b : ℝ) / 2 := by
    have : (tauab a b / 2 : ℚ) ≤ G a b := hG
    have : ((tauab a b / 2 : ℚ) : ℝ) ≤ (G a b : ℝ) := by exact_mod_cast this
    push_cast at this; linarith
  have hn : (0 : ℝ) < 2 * ((n : ℝ) - 2) := by norm_num [n]
  have hc : (99/100 - 1) / (2 * ((n : ℝ) - 2)) ≤ (μ - 1) / (2 * ((n : ℝ) - 2)) :=
    div_le_div_of_nonneg_right (by linarith) hn.le
  unfold rhs5 at h'; push_cast at h'
  nlinarith [mul_le_mul_of_nonneg_right hc hG']

end HamiltonsCubic.L242OffRayWitness
