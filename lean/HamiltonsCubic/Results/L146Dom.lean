import Mathlib

set_option linter.style.longLine false

/-!
# L146: the in-block branch dominates, by tracelessness

[findings/second-order.md](../../../findings/second-order.md), Lemma L146: *the Weyl image of `h ∈ S²₀(ℝ^m)` carries
`α h_a` on the cross planes and `−β(h_a + h_{a'})` on the in-block planes, `α = (m−2)/(2(m−1))`, `β = m/(2(m−1))`.
Tracelessness forces `max_{a≠a'} |h_a + h_{a'}| ≥ ((m−2)/(m−1)) max_a |h_a|`, sharp at the spike, while `β/α = m/(m−2)`
covers that ratio with room. The cross branch caps at `√(m−2)/m < 1/√(m−1)`, since `(m−1)(m−2) < m²`.*

- `pair_ge`: **at every `a`, some `b ≠ a` has `|h_a + h_b| ≥ ((m−2)/(m−1))|h_a|`**, from `∑_{b≠a}(h_a + h_b) = (m−2)h_a`
  at `∑ h = 0`, by averaging;
- `spike_sharp`: the spike's two pair sums, `m−2` and `−2`, against its top entry `m−1`, as scalars: the constant is
  attained there for `m ≥ 4`;
- `inblock_wins`: **the dominance statement itself**, `pair_ge` at an entry of largest modulus with `inblock_dominates`;
- `inblock_dominates`: **`β · ((m−2)/(m−1)) ≥ α`, with ratio `m/(m−1)`**, so the in-block branch dominates;
- `cross_cap`: **`√(m−2)/m < 1/√(m−1)`** at `m ≥ 3`;
- `cross5`, `inblock5`, `cross6`, `inblock6`, `cross_exceeds`: **on the joint two-copy eigenspace the cross branch exceeds
  the in-block formula**, `3/4 > 5/8` at `m = 5` and `4/5 > 12/25` at `m = 6`, which falsifies the equality clause there.
-/

namespace HamiltonsCubic.L146Dom

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **The pair bound**: at `∑ h = 0` and `m = |ι| ≥ 2`, every `a` has a partner `b ≠ a` with
`|h_a + h_b| ≥ ((m−2)/(m−1))|h_a|`. -/
theorem pair_ge (hm : 2 ≤ Fintype.card ι) (h : ι → ℝ) (h0 : ∑ c, h c = 0) (a : ι) :
    ∃ b, b ≠ a ∧ ((Fintype.card ι : ℝ) - 2) / ((Fintype.card ι : ℝ) - 1) * |h a| ≤ |h a + h b| := by
  set m : ℝ := (Fintype.card ι : ℝ) with hmdef
  have hm2 : (2 : ℝ) ≤ m := by rw [hmdef]; exact_mod_cast hm
  have hm1 : 0 < m - 1 := by linarith
  set s := Finset.univ.erase a with hs
  have hcard : (s.card : ℝ) = m - 1 := by
    rw [hs, Finset.card_erase_of_mem (Finset.mem_univ a), Finset.card_univ, hmdef]
    rw [Nat.cast_sub (by omega)]; simp
  have hsne : s.Nonempty := by
    rw [← Finset.card_pos]; have : (0 : ℝ) < s.card := by rw [hcard]; exact hm1
    exact_mod_cast this
  have hsum : ∑ b ∈ s, (h a + h b) = (m - 2) * h a := by
    rw [Finset.sum_add_distrib, Finset.sum_const, nsmul_eq_mul, hcard]
    have : ∑ b ∈ s, h b = -h a := by
      have := Finset.add_sum_erase Finset.univ h (Finset.mem_univ a)
      rw [h0] at this; linarith
    rw [this]; ring
  -- pick the partner maximising `sign(h_a)·(h_a + h_b)`
  by_cases hs0 : 0 ≤ h a
  · obtain ⟨b, hb, hmax⟩ := Finset.exists_max_image s (fun b => h a + h b) hsne
    refine ⟨b, Finset.ne_of_mem_erase hb, ?_⟩
    have hle : (m - 2) * h a ≤ (m - 1) * (h a + h b) := by
      rw [← hsum, ← hcard, ← nsmul_eq_mul, ← Finset.sum_const]
      exact Finset.sum_le_sum fun c hc => hmax c hc
    rw [abs_of_nonneg hs0]
    have hpos : 0 ≤ h a + h b := by
      have : 0 ≤ (m - 2) * h a := mul_nonneg (by linarith) hs0
      nlinarith
    rw [abs_of_nonneg hpos, div_mul_eq_mul_div, div_le_iff₀ hm1]; linarith
  · push Not at hs0
    obtain ⟨b, hb, hmin⟩ := Finset.exists_min_image s (fun b => h a + h b) hsne
    refine ⟨b, Finset.ne_of_mem_erase hb, ?_⟩
    have hle : (m - 1) * (h a + h b) ≤ (m - 2) * h a := by
      rw [← hsum, ← hcard, ← nsmul_eq_mul, ← Finset.sum_const]
      exact Finset.sum_le_sum fun c hc => hmin c hc
    rw [abs_of_neg hs0]
    have hneg : h a + h b ≤ 0 := by
      have : (m - 2) * h a ≤ 0 := mul_nonpos_of_nonneg_of_nonpos (by linarith) hs0.le
      nlinarith
    rw [abs_of_nonpos hneg, div_mul_eq_mul_div, div_le_iff₀ hm1]; linarith

/-- **The constant is sharp at the spike** `h = (m−1, −1, …, −1)`: pair sums are `m−2` or `−2`, so at `m ≥ 4` the
largest is `m−2 = ((m−2)/(m−1))·(m−1)`. -/
theorem spike_sharp (m : ℝ) (hm : 4 ≤ m) :
    max |(m - 1) + (-1)| |(-1) + (-1 : ℝ)| = (m - 2) / (m - 1) * |m - 1| := by
  have h1 : 0 < m - 1 := by linarith
  rw [abs_of_pos h1, show (m - 1) + (-1) = m - 2 by ring, abs_of_nonneg (by linarith : (0:ℝ) ≤ m - 2),
    show (-1) + (-1 : ℝ) = -2 by ring, abs_neg, abs_two, max_eq_left (by linarith)]
  field_simp

/-- **The in-block branch dominates**: `β · ((m−2)/(m−1)) = (m/(m−1)) · α ≥ α`. -/
theorem inblock_dominates (m : ℝ) (hm : 3 ≤ m) :
    m / (2 * (m - 1)) * ((m - 2) / (m - 1)) = m / (m - 1) * ((m - 2) / (2 * (m - 1))) ∧
      (m - 2) / (2 * (m - 1)) ≤ m / (2 * (m - 1)) * ((m - 2) / (m - 1)) := by
  have h1 : 0 < m - 1 := by linarith
  refine ⟨by field_simp, ?_⟩
  rw [div_mul_div_comm, div_le_div_iff₀ (by positivity) (by positivity)]
  nlinarith

/-- **The cross branch caps below the supremum**: `√(m−2)/m < 1/√(m−1)` at `m ≥ 3`. -/
theorem cross_cap (m : ℝ) (hm : 3 ≤ m) : Real.sqrt (m - 2) / m < 1 / Real.sqrt (m - 1) := by
  have h1 : 0 < m - 1 := by linarith
  have hs1 : 0 < Real.sqrt (m - 1) := Real.sqrt_pos.mpr h1
  rw [div_lt_div_iff₀ (by linarith) hs1, one_mul, ← Real.sqrt_mul (by linarith)]
  rw [Real.sqrt_lt' (by linarith)]
  nlinarith

/-- **The in-block branch wins**: at `∑ h = 0` and `m ≥ 3`, some pair `a ≠ b` has `β|h_a + h_b| ≥ α|h_c|` for every `c`,
`α = (m−2)/(2(m−1))`, `β = m/(2(m−1))`: `pair_ge` at an entry of largest modulus with `inblock_dominates`. -/
theorem inblock_wins (hm : 3 ≤ Fintype.card ι) (h : ι → ℝ) (h0 : ∑ c, h c = 0) :
    ∃ a b, b ≠ a ∧ ∀ c, ((Fintype.card ι : ℝ) - 2) / (2 * ((Fintype.card ι : ℝ) - 1)) * |h c|
      ≤ (Fintype.card ι : ℝ) / (2 * ((Fintype.card ι : ℝ) - 1)) * |h a + h b| := by
  have hne : (Finset.univ : Finset ι).Nonempty := Finset.univ_nonempty_iff.mpr ⟨Classical.choice (Fintype.card_pos_iff.mp (by omega))⟩
  obtain ⟨a, -, hmax⟩ := Finset.exists_max_image Finset.univ (fun c => |h c|) hne
  obtain ⟨b, hb, hpair⟩ := pair_ge (by omega) h h0 a
  refine ⟨a, b, hb, fun c => ?_⟩
  have hm3 : (3 : ℝ) ≤ (Fintype.card ι : ℝ) := by exact_mod_cast hm
  set m : ℝ := (Fintype.card ι : ℝ)
  have hdom := (inblock_dominates m hm3).2
  have hc := hmax c (Finset.mem_univ c)
  have hα : 0 ≤ (m - 2) / (2 * (m - 1)) := div_nonneg (by linarith) (by linarith)
  have hβ : 0 ≤ m / (2 * (m - 1)) := div_nonneg (by linarith) (by linarith)
  calc (m - 2) / (2 * (m - 1)) * |h c| ≤ (m - 2) / (2 * (m - 1)) * |h a| := mul_le_mul_of_nonneg_left hc hα
    _ ≤ m / (2 * (m - 1)) * ((m - 2) / (m - 1)) * |h a| := mul_le_mul_of_nonneg_right hdom (abs_nonneg _)
    _ = m / (2 * (m - 1)) * ((m - 2) / (m - 1) * |h a|) := by ring
    _ ≤ m / (2 * (m - 1)) * |h a + h b| := mul_le_mul_of_nonneg_left hpair hβ

/-! ## The cross-plane branch exceeds the in-block formula on the joint two-copy eigenspace

At `m = 5`, `α = 3/8`, `β = 5/8` and `h = k = (1, 0, 0, 0, −1)`: the cross branch `α(h_a + k_b)` reaches `3/4` while the
in-block formula `β|h_a + h_{a'}|` gives `5/8`. At `m = 6`, `α = 2/5`, `β = 3/5` and `h = k = (1, −1/5, …, −1/5)`, written
`h = h'/5` with `h' = (5, −1, …, −1)`: `4/5` against `12/25`. Checked on the integer scalings, `8α(h_a + k_b)` and
`8β(h_a + h_{a'})` at `m = 5`, `25α(h_a + k_b)` and `25β(h_a + h_{a'})` at `m = 6`. -/

def h5 : Fin 5 → ℤ := ![1, 0, 0, 0, -1]

/-- `m = 5`: `max 8·(3/8)|h_a + k_b| = 6`, i.e. `3/4`, and `max 8·(5/8)|h_a + h_{a'}| = 5`, i.e. `5/8`. -/
theorem cross5 : (∀ a b : Fin 5, |3 * (h5 a + h5 b)| ≤ 6) ∧ |3 * (h5 0 + h5 0)| = 6 := by decide

theorem inblock5 : (∀ a b : Fin 5, a ≠ b → |5 * (h5 a + h5 b)| ≤ 5) ∧ |5 * (h5 0 + h5 1)| = 5 := by decide

def h6 : Fin 6 → ℤ := ![5, -1, -1, -1, -1, -1]

/-- `m = 6`: `max 25·(2/5)|h_a + k_b| = 20`, i.e. `4/5`, and `max 25·(3/5)|h_a + h_{a'}| = 12`, i.e. `12/25`. -/
theorem cross6 : (∀ a b : Fin 6, |2 * (h6 a + h6 b)| ≤ 20) ∧ |2 * (h6 0 + h6 0)| = 20 := by decide

theorem inblock6 : (∀ a b : Fin 6, a ≠ b → |3 * (h6 a + h6 b)| ≤ 12) ∧ |3 * (h6 0 + h6 1)| = 12 := by decide

/-- Both traceless. -/
theorem traceless : (∑ a, h5 a = 0) ∧ (∑ a, h6 a = 0) := by decide

/-- **So the cross branch exceeds the in-block formula at both**: `3/4 > 5/8` and `4/5 > 12/25`. -/
theorem cross_exceeds : (5 : ℚ) / 8 < 3 / 4 ∧ (12 : ℚ) / 25 < 4 / 5 := by norm_num

end HamiltonsCubic.L146Dom
