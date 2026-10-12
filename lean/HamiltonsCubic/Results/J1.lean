import HamiltonsCubic.Results.I117Statements
import HamiltonsCubic.Results.L275
import HamiltonsCubic.Results.MWPrime

set_option linter.style.longLine false

/-!
# J1 for `m ≥ 7`, and H on the torus slice of `so(2m)`

[L273](../../../findings/second-order.md) reduces H on the torus slice of `so(2m)` to J1, `T + λ_m g² ≤ λ_m` on the
unit root sphere, and `L273_J1_implies_H` takes J1 as a hypothesis. This file proves J1 for `m = n + 1 ≥ 7`
(`J1_holds`) and so H there (`H_torus_slice`), following the J1 working note's reduction (batches 3, 7, 9 and 11):
- `cocktail_rows`: the row Cauchy–Schwarz on the cocktail-party matrix, over the third index `k ∉ {i, j}`, `T ≤ Σ (|U_ij| + |V_ij|) √((d_i − w_ij)(d_j − w_ij))`;
- `pairing`: Cauchy–Schwarz against `R_ij = d_i d_j − (U_ij² − V_ij²)²`, which dominates `e_ij e_ji`;
- `pair_bound`: each pair's ratio bounded through `L275_interp`, with `γ_ij = 2|U_ij V_ij|/w_ij`;
- `J1b`: the symmetrised sum is MW's left side, bounded by `MWprime` ([L276](../../../findings/second-order.md)).
-/

namespace HamiltonsCubic.J1

open Matrix Finset HamiltonsCubic.I117S HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge

variable {m : ℕ}

theorem symm_of (U : Matrix (Fin m) (Fin m) ℝ) (hU : IsPairWeights U) (i j : Fin m) : U j i = U i j := by
  have := congrFun (congrFun hU.1 i) j
  rw [Matrix.transpose_apply] at this
  exact this

/-- Cauchy–Schwarz for pairs of vectors: `(Σ (a₁b₁ + a₂b₂))² ≤ Σ (a₁² + a₂²) · Σ (b₁² + b₂²)`. -/
theorem cs_pair (a1 a2 b1 b2 : Fin m → ℝ) :
    (∑ k, (a1 k * b1 k + a2 k * b2 k)) ^ 2 ≤ (∑ k, (a1 k ^ 2 + a2 k ^ 2)) * ∑ k, (b1 k ^ 2 + b2 k ^ 2) := by
  set f : Fin m × Fin 2 → ℝ := fun p => if p.2 = 0 then a1 p.1 else a2 p.1
  set g : Fin m × Fin 2 → ℝ := fun p => if p.2 = 0 then b1 p.1 else b2 p.1
  have h := Finset.sum_mul_sq_le_sq_mul_sq (Finset.univ : Finset (Fin m × Fin 2)) f g
  have e1 : ∑ p : Fin m × Fin 2, f p * g p = ∑ k, (a1 k * b1 k + a2 k * b2 k) := by
    rw [Fintype.sum_prod_type]; exact Finset.sum_congr rfl fun k _ => by simp [f, g, Fin.sum_univ_two]
  have e2 : ∑ p : Fin m × Fin 2, f p ^ 2 = ∑ k, (a1 k ^ 2 + a2 k ^ 2) := by
    rw [Fintype.sum_prod_type]; exact Finset.sum_congr rfl fun k _ => by simp [f, Fin.sum_univ_two]
  have e3 : ∑ p : Fin m × Fin 2, g p ^ 2 = ∑ k, (b1 k ^ 2 + b2 k ^ 2) := by
    rw [Fintype.sum_prod_type]; exact Finset.sum_congr rfl fun k _ => by simp [g, Fin.sum_univ_two]
  rw [e1, e2, e3] at h; exact h

/-- **The cocktail-party row bound**: `½(tr P³ + tr Q³) ≤ Σ_{i,j} (|U_ij| + |V_ij|)·√((d_i − w_ij)(d_j − w_ij))`. -/
theorem cocktail_rows (U V : Matrix (Fin m) (Fin m) ℝ) (hU : IsPairWeights U) (hV : IsPairWeights V) :
    (1 / 2 : ℝ) * (Matrix.trace ((U + V) * (U + V) * (U + V)) + Matrix.trace ((U - V) * (U - V) * (U - V)))
      ≤ ∑ i, ∑ j, (|U i j| + |V i j|) *
        Real.sqrt ((dvec U V i - (U i j ^ 2 + V i j ^ 2)) * (dvec U V j - (U i j ^ 2 + V i j ^ 2))) := by
  have sU := symm_of U hU
  have sV := symm_of V hV
  have htr : (1 / 2 : ℝ) * (Matrix.trace ((U + V) * (U + V) * (U + V)) + Matrix.trace ((U - V) * (U - V) * (U - V)))
      = ∑ i, ∑ j, (U i j * ∑ k, (U i k * U k j + V i k * V k j) + V i j * ∑ k, (U i k * V k j + V i k * U k j)) := by
    simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply, Matrix.add_apply, Matrix.sub_apply]
    rw [← Finset.sum_add_distrib, Finset.mul_sum]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [← Finset.sum_add_distrib, Finset.mul_sum]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [Finset.sum_mul, Finset.sum_mul, ← Finset.sum_add_distrib, Finset.mul_sum, Finset.mul_sum, Finset.mul_sum,
      ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [sU j i, sV j i]; ring
  rw [htr]
  refine Finset.sum_le_sum fun i _ => Finset.sum_le_sum fun j _ => ?_
  set a1 : Fin m → ℝ := fun k => if k = j then 0 else U i k
  set a2 : Fin m → ℝ := fun k => if k = j then 0 else V i k
  set b1 : Fin m → ℝ := fun k => if k = i then 0 else U k j
  set b2 : Fin m → ℝ := fun k => if k = i then 0 else V k j
  have hα : ∑ k, (U i k * U k j + V i k * V k j) = ∑ k, (a1 k * b1 k + a2 k * b2 k) := by
    refine Finset.sum_congr rfl fun k _ => ?_
    simp only [a1, a2, b1, b2]
    by_cases hkj : k = j
    · subst hkj; simp [hU.2, hV.2]
    · by_cases hki : k = i
      · subst hki; simp [hU.2, hV.2]
      · simp [hkj, hki]
  have hβ : ∑ k, (U i k * V k j + V i k * U k j) = ∑ k, (a1 k * b2 k + a2 k * b1 k) := by
    refine Finset.sum_congr rfl fun k _ => ?_
    simp only [a1, a2, b1, b2]
    by_cases hkj : k = j
    · subst hkj; simp [hU.2, hV.2]
    · by_cases hki : k = i
      · subst hki; simp [hU.2, hV.2]
      · simp [hkj, hki]
  have hsa : ∑ k, (a1 k ^ 2 + a2 k ^ 2) = dvec U V i - (U i j ^ 2 + V i j ^ 2) := by
    have e : ∀ k, a1 k ^ 2 + a2 k ^ 2 = (U i k ^ 2 + V i k ^ 2) - (if k = j then U i j ^ 2 + V i j ^ 2 else 0) :=
      fun k => by simp only [a1, a2]; split_ifs with h <;> simp [h]
    rw [Finset.sum_congr rfl fun k _ => e k, Finset.sum_sub_distrib, Finset.sum_ite_eq']
    simp [dvec]
  have hsb : ∑ k, (b1 k ^ 2 + b2 k ^ 2) = dvec U V j - (U i j ^ 2 + V i j ^ 2) := by
    have e : ∀ k, b1 k ^ 2 + b2 k ^ 2 = (U j k ^ 2 + V j k ^ 2) - (if k = i then U i j ^ 2 + V i j ^ 2 else 0) :=
      fun k => by
        simp only [b1, b2]; split_ifs with h
        · subst h; simp [sU, sV]
        · simp [sU, sV]
    rw [Finset.sum_congr rfl fun k _ => e k, Finset.sum_sub_distrib, Finset.sum_ite_eq']
    simp [dvec]
  have hsb' : ∑ k, (b2 k ^ 2 + b1 k ^ 2) = dvec U V j - (U i j ^ 2 + V i j ^ 2) := by
    rw [← hsb]; exact Finset.sum_congr rfl fun k _ => by ring
  have c1 := cs_pair a1 a2 b1 b2
  have c2 := cs_pair a1 a2 b2 b1
  rw [hsa, hsb] at c1
  rw [hsa, hsb'] at c2
  rw [hα, hβ]
  set R := (dvec U V i - (U i j ^ 2 + V i j ^ 2)) * (dvec U V j - (U i j ^ 2 + V i j ^ 2))
  have e1 : |∑ k, (a1 k * b1 k + a2 k * b2 k)| ≤ Real.sqrt R := Real.abs_le_sqrt c1
  have e2 : |∑ k, (a1 k * b2 k + a2 k * b1 k)| ≤ Real.sqrt R := Real.abs_le_sqrt c2
  calc U i j * ∑ k, (a1 k * b1 k + a2 k * b2 k) + V i j * ∑ k, (a1 k * b2 k + a2 k * b1 k)
      ≤ |U i j| * |∑ k, (a1 k * b1 k + a2 k * b2 k)| + |V i j| * |∑ k, (a1 k * b2 k + a2 k * b1 k)| := by
        rw [← abs_mul, ← abs_mul]; exact add_le_add (le_abs_self _) (le_abs_self _)
    _ ≤ |U i j| * Real.sqrt R + |V i j| * Real.sqrt R :=
        add_le_add (mul_le_mul_of_nonneg_left e1 (abs_nonneg _)) (mul_le_mul_of_nonneg_left e2 (abs_nonneg _))
    _ = (|U i j| + |V i j|) * Real.sqrt R := by ring

/-- The pair weight `R_ij = d_i d_j − (U_ij² − V_ij²)²` off the diagonal, `0` on it. -/
noncomputable def Rw (U V : Matrix (Fin m) (Fin m) ℝ) (i j : Fin m) : ℝ :=
  if i = j then 0 else dvec U V i * dvec U V j - (U i j ^ 2 - V i j ^ 2) ^ 2

theorem w_le_d (U V : Matrix (Fin m) (Fin m) ℝ) (i j : Fin m) : U i j ^ 2 + V i j ^ 2 ≤ dvec U V i :=
  Finset.single_le_sum (f := fun l => U i l ^ 2 + V i l ^ 2) (fun l _ => by positivity) (Finset.mem_univ j)

theorem d_nonneg (U V : Matrix (Fin m) (Fin m) ℝ) (i : Fin m) : 0 ≤ dvec U V i :=
  Finset.sum_nonneg fun l _ => by positivity

/-- `e e' ≤ R`: `R − e e' = w(d_i − w) + w(d_j − w) + 4U²V²`. -/
theorem ee_le_R (U V : Matrix (Fin m) (Fin m) ℝ) (hU : IsPairWeights U) (hV : IsPairWeights V) (i j : Fin m) (hij : i ≠ j) :
    (dvec U V i - (U i j ^ 2 + V i j ^ 2)) * (dvec U V j - (U i j ^ 2 + V i j ^ 2)) ≤ Rw U V i j := by
  have hwi := w_le_d U V i j
  have hwj := w_le_d U V j i
  rw [symm_of U hU i j, symm_of V hV i j] at hwj
  simp only [Rw, if_neg hij]
  nlinarith [mul_nonneg (by positivity : (0:ℝ) ≤ U i j ^ 2 + V i j ^ 2) (by linarith : (0:ℝ) ≤ dvec U V i - (U i j ^ 2 + V i j ^ 2)),
    mul_nonneg (by positivity : (0:ℝ) ≤ U i j ^ 2 + V i j ^ 2) (by linarith : (0:ℝ) ≤ dvec U V j - (U i j ^ 2 + V i j ^ 2)),
    sq_nonneg (U i j * V i j)]

theorem Rw_nonneg (U V : Matrix (Fin m) (Fin m) ℝ) (hU : IsPairWeights U) (hV : IsPairWeights V) (i j : Fin m) :
    0 ≤ Rw U V i j := by
  by_cases hij : i = j
  · simp [Rw, hij]
  · have := ee_le_R U V hU hV i j hij
    have hwi := w_le_d U V i j
    have hwj := w_le_d U V j i
    rw [symm_of U hU i j, symm_of V hV i j] at hwj
    exact le_trans (mul_nonneg (by linarith) (by linarith)) this

/-- The per-pair gap ratio `f_ij = s² e e'/R` (zero where `R = 0`). -/
noncomputable def fw (U V : Matrix (Fin m) (Fin m) ℝ) (i j : Fin m) : ℝ :=
  if Rw U V i j = 0 then 0 else
    (|U i j| + |V i j|) ^ 2 * ((dvec U V i - (U i j ^ 2 + V i j ^ 2)) * (dvec U V j - (U i j ^ 2 + V i j ^ 2))) / Rw U V i j

/-- **The pairing**: `Σ s √(e e') ≤ √(Σ f) √(Σ R)`. -/
theorem pairing (U V : Matrix (Fin m) (Fin m) ℝ) (hU : IsPairWeights U) (hV : IsPairWeights V) :
    ∑ i, ∑ j, (|U i j| + |V i j|) *
        Real.sqrt ((dvec U V i - (U i j ^ 2 + V i j ^ 2)) * (dvec U V j - (U i j ^ 2 + V i j ^ 2)))
      ≤ Real.sqrt (∑ i, ∑ j, fw U V i j) * Real.sqrt (∑ i, ∑ j, Rw U V i j) := by
  have hf0 : ∀ i j, 0 ≤ fw U V i j := fun i j => by
    unfold fw; split_ifs with h
    · exact le_refl 0
    · have hR := Rw_nonneg U V hU hV i j
      by_cases hij : i = j
      · simp [Rw, hij] at h
      · have hwi := w_le_d U V i j
        have hwj := w_le_d U V j i
        rw [symm_of U hU i j, symm_of V hV i j] at hwj
        exact div_nonneg (mul_nonneg (sq_nonneg _) (mul_nonneg (by linarith) (by linarith))) hR
  have hpt : ∀ i j, (|U i j| + |V i j|) *
      Real.sqrt ((dvec U V i - (U i j ^ 2 + V i j ^ 2)) * (dvec U V j - (U i j ^ 2 + V i j ^ 2)))
        ≤ Real.sqrt (fw U V i j) * Real.sqrt (Rw U V i j) := by
    intro i j
    have hRHS : 0 ≤ Real.sqrt (fw U V i j) * Real.sqrt (Rw U V i j) := by positivity
    by_cases hij : i = j
    · subst hij; rw [hU.2 i, hV.2 i, abs_zero, add_zero, zero_mul]; exact hRHS
    have hwi := w_le_d U V i j
    have hwj := w_le_d U V j i
    rw [symm_of U hU i j, symm_of V hV i j] at hwj
    set E := (dvec U V i - (U i j ^ 2 + V i j ^ 2)) * (dvec U V j - (U i j ^ 2 + V i j ^ 2)) with hE
    have hE0 : 0 ≤ E := mul_nonneg (by linarith) (by linarith)
    have hER := ee_le_R U V hU hV i j hij
    by_cases hR : Rw U V i j = 0
    · have : E = 0 := le_antisymm (hR ▸ hER) hE0
      rw [this, Real.sqrt_zero, mul_zero]; exact hRHS
    have hRp : 0 < Rw U V i j := lt_of_le_of_ne (Rw_nonneg U V hU hV i j) (Ne.symm hR)
    have hfe : fw U V i j * Rw U V i j = (|U i j| + |V i j|) ^ 2 * E := by
      simp only [fw, if_neg hR, hE]; exact div_mul_cancel₀ _ hR
    rw [← Real.sqrt_mul (hf0 i j), hfe, Real.sqrt_mul (sq_nonneg _), Real.sqrt_sq (by positivity)]
  have hsum : ∀ F : Fin m → Fin m → ℝ, ∑ i, ∑ j, F i j = ∑ p : Fin m × Fin m, F p.1 p.2 :=
    fun F => (Fintype.sum_prod_type' F).symm
  calc _ ≤ ∑ i, ∑ j, Real.sqrt (fw U V i j) * Real.sqrt (Rw U V i j) :=
        Finset.sum_le_sum fun i _ => Finset.sum_le_sum fun j _ => hpt i j
    _ = ∑ p : Fin m × Fin m, Real.sqrt (fw U V p.1 p.2) * Real.sqrt (Rw U V p.1 p.2) := hsum _
    _ ≤ Real.sqrt (∑ p : Fin m × Fin m, fw U V p.1 p.2) * Real.sqrt (∑ p : Fin m × Fin m, Rw U V p.1 p.2) :=
        Real.sum_sqrt_mul_sqrt_le _ (fun p => hf0 p.1 p.2) (fun p => Rw_nonneg U V hU hV p.1 p.2)
    _ = _ := by rw [← hsum (fw U V), ← hsum (Rw U V)]

/-- The pair weight `w_ij`, the angle `γ_ij = 2|U_ij V_ij|/w_ij`, and the half-summand of MW. -/
noncomputable def ww (U V : Matrix (Fin m) (Fin m) ℝ) (i j : Fin m) : ℝ := U i j ^ 2 + V i j ^ 2
noncomputable def gam (U V : Matrix (Fin m) (Fin m) ℝ) (i j : Fin m) : ℝ :=
  if ww U V i j = 0 then 0 else 2 * (|U i j| * |V i j|) / ww U V i j
noncomputable def hterm (U V : Matrix (Fin m) (Fin m) ℝ) (i j : Fin m) : ℝ :=
  ww U V i j * (gam U V i j * (1 - ww U V i j / dvec U V i) ^ 2 + (1 - gam U V i j) * (1 - ww U V i j / dvec U V i) / 2)

theorem gam_range (U V : Matrix (Fin m) (Fin m) ℝ) (i j : Fin m) : 0 ≤ gam U V i j ∧ gam U V i j ≤ 1 := by
  unfold gam ww; split_ifs with h
  · exact ⟨le_refl 0, zero_le_one⟩
  · have hw : 0 < U i j ^ 2 + V i j ^ 2 := lt_of_le_of_ne (by positivity) (Ne.symm h)
    refine ⟨by positivity, ?_⟩
    rw [div_le_one hw]
    nlinarith [sq_nonneg (|U i j| - |V i j|), sq_abs (U i j), sq_abs (V i j)]

theorem ww_symm (U V : Matrix (Fin m) (Fin m) ℝ) (hU : IsPairWeights U) (hV : IsPairWeights V) (i j : Fin m) :
    ww U V j i = ww U V i j := by
  unfold ww; rw [symm_of U hU i j, symm_of V hV i j]

theorem gam_symm (U V : Matrix (Fin m) (Fin m) ℝ) (hU : IsPairWeights U) (hV : IsPairWeights V) (i j : Fin m) :
    gam U V j i = gam U V i j := by
  unfold gam; rw [ww_symm U V hU hV i j, symm_of U hU i j, symm_of V hV i j]

/-- The per-pair inequality in real variables: `s² E/R ≤ w·Bnd` through `L275_interp`. -/
theorem pair_core (w g di dj : ℝ) (hw : 0 < w) (hwi : w ≤ di) (hwj : w ≤ dj) (hg0 : 0 ≤ g) (hg1 : g ≤ 1)
    (hR : 0 < di * dj - w ^ 2 * (1 - g ^ 2)) :
    w * (1 + g) * ((di - w) * (dj - w)) / (di * dj - w ^ 2 * (1 - g ^ 2))
      ≤ w * (g * ((1 - w / di) ^ 2 + (1 - w / dj) ^ 2) + (1 - g) * ((1 - w / di) + (1 - w / dj)) / 2) := by
  have hdi : 0 < di := lt_of_lt_of_le hw hwi
  have hdj : 0 < dj := lt_of_lt_of_le hw hwj
  set p := w / di with hp
  set q := w / dj with hq
  have hp1 : p ≤ 1 := by rw [hp, div_le_one hdi]; exact hwi
  have hq1 : q ≤ 1 := by rw [hq, div_le_one hdj]; exact hwj
  have hp0 : 0 ≤ p := div_nonneg hw.le hdi.le
  have hq0 : 0 ≤ q := div_nonneg hw.le hdj.le
  have hE : (di - w) * (dj - w) = di * dj * ((1 - p) * (1 - q)) := by rw [hp, hq]; field_simp
  have hRe : di * dj - w ^ 2 * (1 - g ^ 2) = di * dj * (1 - p * q * (1 - g ^ 2)) := by rw [hp, hq]; field_simp
  have hden : 0 < 1 - p * q * (1 - g ^ 2) := by
    have := hR; rw [hRe] at this; exact pos_of_mul_pos_right this (by positivity)
  have hi := HamiltonsCubic.L275.L275_interp (1 - p) (1 - q) g (by linarith) (by linarith) (by linarith) (by linarith) hg0 hg1
  have e3 : (1 - (1 - (1 - p)) * (1 - (1 - q)) * (1 - g ^ 2)) = 1 - p * q * (1 - g ^ 2) := by ring
  rw [e3] at hi
  rw [hE, hRe, show w * (1 + g) * (di * dj * ((1 - p) * (1 - q))) / (di * dj * (1 - p * q * (1 - g ^ 2)))
      = w * ((1 + g) * ((1 - p) * (1 - q))) / (1 - p * q * (1 - g ^ 2)) by field_simp]
  rw [div_le_iff₀ hden]
  have := mul_le_mul_of_nonneg_left hi hw.le
  nlinarith [this]

theorem hterm_nonneg (U V : Matrix (Fin m) (Fin m) ℝ) (i j : Fin m) : 0 ≤ hterm U V i j := by
  have hg := gam_range U V i j
  have hwd := w_le_d U V i j
  have hp : ww U V i j / dvec U V i ≤ 1 := by
    rcases eq_or_lt_of_le (d_nonneg U V i) with h | h
    · rw [← h, div_zero]; exact zero_le_one
    · rw [div_le_one h]; exact hwd
  unfold hterm
  exact mul_nonneg (by unfold ww; positivity)
    (add_nonneg (mul_nonneg hg.1 (sq_nonneg _)) (div_nonneg (mul_nonneg (by linarith [hg.2]) (by linarith)) (by norm_num)))

/-- **The per-pair bound**, through `L275_interp`: `f_ij ≤ hterm_ij + hterm_ji`. -/
theorem pair_bound (U V : Matrix (Fin m) (Fin m) ℝ) (hU : IsPairWeights U) (hV : IsPairWeights V) (i j : Fin m) :
    fw U V i j ≤ hterm U V i j + hterm U V j i := by
  have hRHS0 : 0 ≤ hterm U V i j + hterm U V j i := add_nonneg (hterm_nonneg U V i j) (hterm_nonneg U V j i)
  by_cases hij : i = j
  · have : Rw U V i j = 0 := by simp [Rw, hij]
    simp only [fw, this, if_true]; exact hRHS0
  by_cases hR : Rw U V i j = 0
  · simp only [fw, hR, if_true]; exact hRHS0
  have hRp : 0 < Rw U V i j := lt_of_le_of_ne (Rw_nonneg U V hU hV i j) (Ne.symm hR)
  have hwi := w_le_d U V i j
  have hwj := w_le_d U V j i
  rw [symm_of U hU i j, symm_of V hV i j] at hwj
  have hg := gam_range U V i j
  by_cases hw0 : ww U V i j = 0
  · have hU0 : U i j = 0 := by
      have : U i j ^ 2 + V i j ^ 2 = 0 := hw0
      nlinarith [sq_nonneg (U i j), sq_nonneg (V i j)]
    have hV0 : V i j = 0 := by
      have : U i j ^ 2 + V i j ^ 2 = 0 := hw0
      nlinarith [sq_nonneg (U i j), sq_nonneg (V i j)]
    have : fw U V i j = 0 := by simp [fw, hR, hU0, hV0]
    rw [this]; exact hRHS0
  have hwp : 0 < ww U V i j := lt_of_le_of_ne (by unfold ww; positivity) (Ne.symm hw0)
  have hgw : gam U V i j * ww U V i j = 2 * (|U i j| * |V i j|) := by
    unfold gam; rw [if_neg hw0]; field_simp
  have hs2 : (|U i j| + |V i j|) ^ 2 = ww U V i j * (1 + gam U V i j) := by
    have : (|U i j| + |V i j|) ^ 2 = U i j ^ 2 + V i j ^ 2 + 2 * (|U i j| * |V i j|) := by
      rw [add_sq, sq_abs, sq_abs]; ring
    rw [this, ← hgw]; unfold ww; ring
  have hUV : (U i j ^ 2 - V i j ^ 2) ^ 2 = ww U V i j ^ 2 * (1 - gam U V i j ^ 2) := by
    have e1 : (U i j ^ 2 - V i j ^ 2) ^ 2 = (U i j ^ 2 + V i j ^ 2) ^ 2 - (2 * (|U i j| * |V i j|)) ^ 2 := by
      have : (2 * (|U i j| * |V i j|)) ^ 2 = 4 * (U i j ^ 2 * V i j ^ 2) := by rw [mul_pow, mul_pow, sq_abs, sq_abs]; ring
      rw [this]; ring
    rw [e1, ← hgw]; unfold ww; ring
  have hRe : Rw U V i j = dvec U V i * dvec U V j - ww U V i j ^ 2 * (1 - gam U V i j ^ 2) := by
    simp only [Rw, if_neg hij]; rw [hUV]
  have hfw : fw U V i j = ww U V i j * (1 + gam U V i j) * ((dvec U V i - ww U V i j) * (dvec U V j - ww U V i j))
      / (dvec U V i * dvec U V j - ww U V i j ^ 2 * (1 - gam U V i j ^ 2)) := by
    simp only [fw, if_neg hR]; rw [hs2, hRe]; rfl
  have hcore := pair_core (ww U V i j) (gam U V i j) (dvec U V i) (dvec U V j) hwp hwi hwj hg.1 hg.2 (hRe ▸ hRp)
  rw [hfw]
  refine le_trans hcore (le_of_eq ?_)
  unfold hterm
  rw [ww_symm U V hU hV i j, gam_symm U V hU hV i j]
  ring

theorem ww_gam (U V : Matrix (Fin m) (Fin m) ℝ) (i j : Fin m) :
    ww U V i j ^ 2 * (1 - gam U V i j ^ 2) = (U i j ^ 2 - V i j ^ 2) ^ 2 := by
  unfold gam; split_ifs with h
  · have hU0 : U i j = 0 := by
      have : U i j ^ 2 + V i j ^ 2 = 0 := h
      nlinarith [sq_nonneg (U i j), sq_nonneg (V i j)]
    have hV0 : V i j = 0 := by
      have : U i j ^ 2 + V i j ^ 2 = 0 := h
      nlinarith [sq_nonneg (U i j), sq_nonneg (V i j)]
    simp [ww, hU0, hV0]
  · have hw : ww U V i j ≠ 0 := h
    have e : (2 * (|U i j| * |V i j|)) ^ 2 = 4 * (U i j ^ 2 * V i j ^ 2) := by
      rw [mul_pow, mul_pow, sq_abs, sq_abs]; ring
    field_simp
    simp only [sq_abs]; unfold ww; ring

/-- **J1*b through MW'**: at `Σ_i d_i = 1` and `m = n + 1 ≥ 7`, `Σ f ≤ κ Σ R`. -/
theorem J1b (n : ℕ) (hn : 6 ≤ n) (U V : Matrix (Fin (n + 1)) (Fin (n + 1)) ℝ) (hU : IsPairWeights U)
    (hV : IsPairWeights V) (hS : ∑ i, dvec U V i = 1) :
    ∑ i, ∑ j, fw U V i j ≤ HamiltonsCubic.MWPrime.kap n * ∑ i, ∑ j, Rw U V i j := by
  have h1 : ∑ i, ∑ j, fw U V i j ≤ ∑ i, ∑ j, (hterm U V i j + hterm U V j i) :=
    Finset.sum_le_sum fun i _ => Finset.sum_le_sum fun j _ => pair_bound U V hU hV i j
  have h2 : ∑ i, ∑ j, (hterm U V i j + hterm U V j i) = ∑ i, ∑ j, 2 * hterm U V i j := by
    simp only [Finset.sum_add_distrib]
    rw [Finset.sum_comm (f := fun i j => hterm U V j i)]
    simp only [← Finset.sum_add_distrib]
    exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by ring
  have hrow : ∀ i, ∑ k, ww U V i k = dvec U V i := fun i => rfl
  have hwS : ∑ i, ∑ j, ww U V i j = 1 := by simp only [hrow]; exact hS
  have hmw := HamiltonsCubic.MWPrime.MWprime n hn (ww U V) (fun i j => by unfold ww; positivity)
    (fun i j => by simp only [ww, symm_of U hU i j, symm_of V hV i j])
    (fun i => by simp only [ww, hU.2 i, hV.2 i]; ring) hwS (gam U V) (fun i j => gam_range U V i j)
  simp only [hrow] at hmw
  have e2 : ∀ i j, 2 * hterm U V i j = ww U V i j * (1 - ww U V i j / dvec U V i) *
      (1 + gam U V i j * (1 - 2 * (ww U V i j / dvec U V i))) := fun i j => by unfold hterm; ring
  have hsR : ∑ i, ∑ j, Rw U V i j = (1 - ∑ i, dvec U V i ^ 2) - ∑ i, ∑ j, ww U V i j ^ 2 * (1 - gam U V i j ^ 2) := by
    have e : ∀ i j, Rw U V i j = (if i = j then 0 else dvec U V i * dvec U V j) - ww U V i j ^ 2 * (1 - gam U V i j ^ 2) :=
      fun i j => by
        rw [ww_gam]; unfold Rw; split_ifs with h
        · subst h; simp [hU.2, hV.2]
        · ring
    simp only [e, Finset.sum_sub_distrib]
    congr 1
    have e2 : ∀ i, ∑ j, (if i = j then 0 else dvec U V i * dvec U V j) = dvec U V i * 1 - dvec U V i ^ 2 := fun i => by
      have : ∑ j, (if i = j then 0 else dvec U V i * dvec U V j)
          = ∑ j, dvec U V i * dvec U V j - ∑ j, (if i = j then dvec U V i * dvec U V j else 0) := by
        rw [← Finset.sum_sub_distrib]; exact Finset.sum_congr rfl fun j _ => by split_ifs <;> ring
      rw [this, Finset.sum_ite_eq, if_pos (Finset.mem_univ _), ← Finset.mul_sum, hS]; ring
    rw [Finset.sum_congr rfl fun i _ => e2 i, Finset.sum_sub_distrib, ← Finset.sum_mul, hS]; ring
  rw [hsR]
  have hsplit : ∑ i, ∑ j, (ww U V i j * (1 - ww U V i j / dvec U V i) * (1 + gam U V i j * (1 - 2 * (ww U V i j / dvec U V i)))
      + HamiltonsCubic.MWPrime.kap ↑n * ww U V i j ^ 2 * (1 - gam U V i j ^ 2))
      = ∑ i, ∑ j, 2 * hterm U V i j + HamiltonsCubic.MWPrime.kap ↑n * ∑ i, ∑ j, ww U V i j ^ 2 * (1 - gam U V i j ^ 2) := by
    simp only [Finset.sum_add_distrib, Finset.mul_sum]
    congr 1
    · exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => (e2 i j).symm
    · exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by ring
  rw [hsplit] at hmw
  nlinarith [h1, h2, hmw]

/-- **J1 for `m ≥ 7`**, in the form `L273_J1_implies_H` takes. -/
theorem J1_holds (n : ℕ) (hn : 6 ≤ n) :
    ∀ U V : Matrix (Fin (n + 1)) (Fin (n + 1)) ℝ, IsPairWeights U → IsPairWeights V →
      (1 / 2 : ℝ) * ((∑ i, ∑ j, (U + V) i j ^ 2) + (∑ i, ∑ j, (U - V) i j ^ 2)) = 1 →
      (1 / 2 : ℝ) * (Matrix.trace ((U + V) * (U + V) * (U + V)) + Matrix.trace ((U - V) * (U - V) * (U - V)))
        + Real.sqrt (2 * ((n + 1 : ℕ) : ℝ)) * (((n + 1 : ℕ) : ℝ) - 2) / ((((n + 1 : ℕ) : ℝ) - 1) * Real.sqrt (((n + 1 : ℕ) : ℝ) - 1))
          * ((∑ i, dvec U V i ^ 2) + ∑ i, ∑ j, if i = j then 0 else ((U + V) i j * (U - V) i j) ^ 2)
        ≤ Real.sqrt (2 * ((n + 1 : ℕ) : ℝ)) * (((n + 1 : ℕ) : ℝ) - 2) / ((((n + 1 : ℕ) : ℝ) - 1) * Real.sqrt (((n + 1 : ℕ) : ℝ) - 1)) := by
  intro U V hU hV hnorm
  have hN : (6 : ℝ) ≤ n := by exact_mod_cast hn
  have hS : ∑ i, dvec U V i = 1 := by
    rw [← hnorm]; simp only [dvec, Matrix.add_apply, Matrix.sub_apply, ← Finset.sum_add_distrib, Finset.mul_sum]
    exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by ring
  set lam := Real.sqrt (2 * ((n + 1 : ℕ) : ℝ)) * (((n + 1 : ℕ) : ℝ) - 2) / ((((n + 1 : ℕ) : ℝ) - 1) * Real.sqrt (((n + 1 : ℕ) : ℝ) - 1)) with hlam
  have hlam0 : 0 ≤ lam := by
    rw [hlam]; push_cast
    apply div_nonneg (mul_nonneg (Real.sqrt_nonneg _) (by linarith)) (mul_nonneg (by linarith) (Real.sqrt_nonneg _))
  have hlam2 : lam ^ 2 = HamiltonsCubic.MWPrime.kap n := by
    rw [hlam]; push_cast
    have h1 : (0:ℝ) ≤ 2 * ((n:ℝ) + 1) := by positivity
    have h2 : (0:ℝ) ≤ (n:ℝ) + 1 - 1 := by linarith
    rw [div_pow, mul_pow, mul_pow, Real.sq_sqrt h1, Real.sq_sqrt h2]
    simp only [HamiltonsCubic.MWPrime.kap]
    rw [show (n:ℝ) + 1 - 1 = n by ring, show (n:ℝ) + 1 - 2 = n - 1 by ring]
    have hn0 : (0:ℝ) < n := by linarith
    rw [div_eq_div_iff (by positivity) (by positivity)]; ring
  have hsk : Real.sqrt (HamiltonsCubic.MWPrime.kap n) = lam := by rw [← hlam2, Real.sqrt_sq hlam0]
  have hR0 : 0 ≤ ∑ i, ∑ j, Rw U V i j := Finset.sum_nonneg fun i _ => Finset.sum_nonneg fun j _ => Rw_nonneg U V hU hV i j
  have hT := le_trans (cocktail_rows U V hU hV) (pairing U V hU hV)
  have hb := J1b n hn U V hU hV hS
  have hkap0 : 0 ≤ HamiltonsCubic.MWPrime.kap n := by rw [← hlam2]; positivity
  have hsq : Real.sqrt (∑ i, ∑ j, fw U V i j) ≤ lam * Real.sqrt (∑ i, ∑ j, Rw U V i j) := by
    rw [← hsk, ← Real.sqrt_mul hkap0]; exact Real.sqrt_le_sqrt hb
  have hTb : (1 / 2 : ℝ) * (Matrix.trace ((U + V) * (U + V) * (U + V)) + Matrix.trace ((U - V) * (U - V) * (U - V)))
      ≤ lam * ∑ i, ∑ j, Rw U V i j := by
    calc _ ≤ Real.sqrt (∑ i, ∑ j, fw U V i j) * Real.sqrt (∑ i, ∑ j, Rw U V i j) := hT
      _ ≤ lam * Real.sqrt (∑ i, ∑ j, Rw U V i j) * Real.sqrt (∑ i, ∑ j, Rw U V i j) :=
          mul_le_mul_of_nonneg_right hsq (Real.sqrt_nonneg _)
      _ = lam * ∑ i, ∑ j, Rw U V i j := by rw [mul_assoc, Real.mul_self_sqrt hR0]
  have hRsum : ∑ i, ∑ j, Rw U V i j = 1 - ((∑ i, dvec U V i ^ 2) + ∑ i, ∑ j, if i = j then 0 else ((U + V) i j * (U - V) i j) ^ 2) := by
    have e : ∀ i j, Rw U V i j = (if i = j then 0 else dvec U V i * dvec U V j) - (if i = j then 0 else ((U + V) i j * (U - V) i j) ^ 2) :=
      fun i j => by
        unfold Rw; split_ifs with h
        · simp
        · rw [Matrix.add_apply, Matrix.sub_apply]; ring
    simp only [e, Finset.sum_sub_distrib]
    have e2 : ∀ i, ∑ j, (if i = j then 0 else dvec U V i * dvec U V j) = dvec U V i * 1 - dvec U V i ^ 2 := fun i => by
      have : ∑ j, (if i = j then 0 else dvec U V i * dvec U V j)
          = ∑ j, dvec U V i * dvec U V j - ∑ j, (if i = j then dvec U V i * dvec U V j else 0) := by
        rw [← Finset.sum_sub_distrib]; exact Finset.sum_congr rfl fun j _ => by split_ifs <;> ring
      rw [this, Finset.sum_ite_eq, if_pos (Finset.mem_univ _), ← Finset.mul_sum, hS]; ring
    rw [Finset.sum_congr rfl fun i _ => e2 i, Finset.sum_sub_distrib, ← Finset.sum_mul, hS]; ring
  rw [hRsum] at hTb
  linarith

/-- **H on the torus slice of `so(2m)` for `m ≥ 7`**: `L273_J1_implies_H` with J1 discharged. -/
theorem H_torus_slice (n : ℕ) (hn : 6 ≤ n) (A U V : Matrix (Fin (n + 1)) (Fin (n + 1)) ℝ) (hA : Aᵀ = A)
    (hU : IsPairWeights U) (hV : IsPairWeights V) :
    Ftri (torusOp A U V) (torusOp A U V) (torusOp A U V)
      ≤ 2 * (((n + 1 : ℕ) : ℝ) - 1) / Real.sqrt ((n + 1 : ℕ) * (2 * ((n + 1 : ℕ) : ℝ) - 1)) *
        (normSq2 (torusOp A U V)) ^ ((3 : ℝ) / 2) :=
  L273_J1_implies_H (by omega) (J1_holds n hn) A U V hA hU hV

end HamiltonsCubic.J1
