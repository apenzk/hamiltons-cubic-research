import HamiltonsCubic.Results.L57Diagonal

set_option linter.style.longLine false

/-!
# L57's equality case at a critical point

At a unit weight `S` satisfying the criticality equation with multiplier `λ` equal to the bound
`√(2(n−1)(n−2))/n`, every inequality in L57's chain is tight ([L57Critical.lean](L57Critical.lean)):

- `step23_parts`: `⟨S, Z⟩ = μ` and `‖Z‖²` in closed form, with `Zp` the projection
  `Z_ab = v_a v_b + (v_a² + v_b²)/(n−2) − 1/((n−1)(n−2))` off the diagonal;
- `cs_eq`: Cauchy–Schwarz is an equality only at proportional vectors;
- `L57_critical_eq`: **equality forces `v_a² = 1/n` for every `a` and `S = t Z`**, so `S` is constant
  on the two classes of pairs of the sign partition of `v`, `s_ab = t(σ_aσ_b/n + 2/(n(n−2)) −
  1/((n−1)(n−2)))` with `σ_a = ±1` and `∑ σ = 0`, the balanced sphere product;
- `even_card_of_balanced` and `L57_critical_strict_odd`: such a `v` forces `n` even, so **at odd `n`
  the bound is strict** at every critical point;
- `L57_unit_eq`: **the same at every unit weight attaining the bound**, which is thereby a maximiser
  and critical ([L57Diagonal.lean](L57Diagonal.lean)'s `max_crit`).
-/

namespace HamiltonsCubic.L57Critical

open Finset Matrix HamiltonsCubic.FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- L57's projection off the diagonal. -/
noncomputable def Zp (v : ι → ℝ) (n : ℝ) (a b : ι) : ℝ :=
  if a = b then 0 else v a * v b + (v a ^ 2 + v b ^ 2) / (n - 2) - 1 / ((n - 1) * (n - 2))

section core

variable (S : Matrix ι ι ℝ) (hS : IsWeight S) (v : ι → ℝ) (μ : ℝ)
  (hv : S *ᵥ v = μ • v)
include hS hv

theorem step23_parts (h2 : ∑ a, v a ^ 2 = 1) (h1 : ∑ a, v a = 0) (hn : 4 ≤ Fintype.card ι) :
    ∑ a, ∑ b, S a b * Zp v (Fintype.card ι : ℝ) a b = μ ∧
      ∑ a, ∑ b, Zp v (Fintype.card ι : ℝ) a b ^ 2
        = 2 * (((Fintype.card ι : ℝ) ^ 2 - 3 * (Fintype.card ι : ℝ) + 3)
            / (2 * ((Fintype.card ι : ℝ) - 1) * ((Fintype.card ι : ℝ) - 2))
          - (Fintype.card ι : ℝ) / (2 * ((Fintype.card ι : ℝ) - 2)) * ∑ a, v a ^ 4) := by
  set n : ℝ := (Fintype.card ι : ℝ) with hndef
  have hn4 : (4 : ℝ) ≤ n := by rw [hndef]; exact_mod_cast hn
  have hn2 : n - 2 ≠ 0 := by linarith
  have hn1 : n - 1 ≠ 0 := by linarith
  have hq := quad_eq S hS v μ hv h2
  have hrow : ∀ a, ∑ b, S a b = 0 := hS.rowSum
  have hcol : ∀ b, ∑ a, S a b = 0 := fun b => by simp only [hS.symm _ b]; exact hS.rowSum b
  set c : ℝ := 1 / ((n - 1) * (n - 2)) with hc
  set Z : ι → ι → ℝ := fun a b => v a * v b + (v a ^ 2 + v b ^ 2) / (n - 2) - c with hZ
  set Z' : ι → ι → ℝ := Zp v n with hZ'
  have hZ'def : ∀ a b, Z' a b = if a = b then 0 else Z a b := fun a b => rfl
  -- `⟨S, Z'⟩ = μ`
  have hSZ : ∑ a, ∑ b, S a b * Z' a b = μ := by
    have e : ∀ a b, S a b * Z' a b = S a b * v a * v b + (S a b * v a ^ 2 + S a b * v b ^ 2) / (n - 2)
        - c * S a b := by
      intro a b
      simp only [hZ'def, hZ]
      split_ifs with h
      · subst h; rw [hS.hollow a]; ring
      · ring
    simp only [e, Finset.sum_add_distrib, Finset.sum_sub_distrib, ← Finset.sum_div, hq,
      ← Finset.mul_sum]
    have t1 : ∑ a, ∑ b, S a b * v a ^ 2 = 0 :=
      Finset.sum_eq_zero fun a _ => by rw [← Finset.sum_mul, hrow a, zero_mul]
    have t2 : ∑ a, ∑ b, S a b * v b ^ 2 = 0 := by
      rw [Finset.sum_comm]
      exact Finset.sum_eq_zero fun b _ => by rw [← Finset.sum_mul, hcol b, zero_mul]
    have t3 : ∑ a, ∑ b, S a b = 0 := Finset.sum_eq_zero fun a _ => hrow a
    rw [t1, t2, t3]; ring
  -- the rows of `Z'` sum to zero
  have hs3 : ∀ a, ∑ b, Z a b = v a * ∑ b, v b + ((n * v a ^ 2) + 1) / (n - 2) - n * c := by
    intro a
    simp only [hZ, Finset.sum_sub_distrib, Finset.sum_add_distrib, ← Finset.mul_sum, ← Finset.sum_div,
      h2, Finset.sum_const, Finset.card_univ, nsmul_eq_mul]
    rw [← hndef]
    try ring
  have hrowZ : ∀ a, ∑ b, Z' a b = 0 := by
    intro a
    have e : ∑ b, Z' a b = ∑ b, Z a b - Z a a := by
      rw [eq_sub_iff_add_eq, ← Finset.add_sum_erase _ _ (Finset.mem_univ a)]
      simp only [hZ'def, if_true, zero_add]
      rw [← Finset.add_sum_erase _ _ (Finset.mem_univ a)]
      rw [add_comm]
      congr 1
      exact Finset.sum_congr rfl fun b hb => by rw [if_neg (Ne.symm (Finset.ne_of_mem_erase hb))]
    rw [e, hs3, h1]
    simp only [hZ, hc]
    field_simp
    ring
  have hsymZ : ∀ a b, Z' a b = Z' b a := by
    intro a b; simp only [hZ'def, hZ]
    by_cases h : a = b
    · subst h; rfl
    · rw [if_neg h, if_neg (Ne.symm h)]; ring
  have hcolZ : ∀ b, ∑ a, Z' a b = 0 := fun b => by simp only [hsymZ _ b]; exact hrowZ b
  -- `‖Z'‖² = ⟨Z', v ⊗ v⟩`, then L223
  have hZZ : ∑ a, ∑ b, Z' a b ^ 2 = ∑ a, ∑ b, Z' a b * (v a * v b) := by
    have e : ∀ a b, Z' a b ^ 2 = Z' a b * (v a * v b)
        + (Z' a b * v a ^ 2 + Z' a b * v b ^ 2) / (n - 2) - c * Z' a b := by
      intro a b
      simp only [hZ'def, hZ]
      split_ifs <;> ring
    simp only [e, Finset.sum_add_distrib, Finset.sum_sub_distrib, ← Finset.sum_div, ← Finset.mul_sum]
    have t1 : ∑ a, ∑ b, Z' a b * v a ^ 2 = 0 :=
      Finset.sum_eq_zero fun a _ => by rw [← Finset.sum_mul, hrowZ a, zero_mul]
    have t2 : ∑ a, ∑ b, Z' a b * v b ^ 2 = 0 := by
      rw [Finset.sum_comm]
      exact Finset.sum_eq_zero fun b _ => by rw [← Finset.sum_mul, hcolZ b, zero_mul]
    have t3 : ∑ a, ∑ b, Z' a b = 0 := Finset.sum_eq_zero fun a _ => hrowZ a
    rw [t1, t2, t3]; ring
  have hZV : ∑ a, ∑ b, Z' a b * (v a * v b)
      = 2 * ((n ^ 2 - 3 * n + 3) / (2 * (n - 1) * (n - 2)) - n / (2 * (n - 2)) * ∑ a, v a ^ 4) := by
    rw [← HamiltonsCubic.L223Statement.Z_norm_sq v n (by linarith) h1 h2]
    have e : ∀ a, ∑ b, Z' a b * (v a * v b)
        = ∑ b, Z a b * v a * v b - Z a a * v a * v a := by
      intro a
      rw [eq_sub_iff_add_eq, ← Finset.add_sum_erase _ _ (Finset.mem_univ a)]
      simp only [hZ'def, if_true, zero_mul, zero_add]
      rw [← Finset.add_sum_erase _ _ (Finset.mem_univ a), add_comm]
      congr 1
      · exact Finset.sum_congr rfl fun b hb => by
          rw [if_neg (Ne.symm (Finset.ne_of_mem_erase hb))]; ring
    simp only [e, Finset.sum_sub_distrib]
    simp only [hZ, hc]
  exact ⟨hSZ, hZZ.trans hZV⟩

end core

omit [DecidableEq ι] in
/-- **Cauchy–Schwarz is an equality only at proportional arrays.** -/
theorem cs_eq (f g : ι → ι → ℝ) (hg : 0 < ∑ a, ∑ b, g a b ^ 2)
    (h : (∑ a, ∑ b, f a b * g a b) ^ 2 = (∑ a, ∑ b, f a b ^ 2) * (∑ a, ∑ b, g a b ^ 2)) :
    ∀ a b, f a b = ((∑ a, ∑ b, f a b * g a b) / ∑ a, ∑ b, g a b ^ 2) * g a b := by
  set F := ∑ a, ∑ b, f a b ^ 2
  set G := ∑ a, ∑ b, g a b ^ 2
  set X := ∑ a, ∑ b, f a b * g a b
  set t := X / G with ht
  have hsum : ∑ a, ∑ b, (f a b - t * g a b) ^ 2 = 0 := by
    have e : ∀ a b, (f a b - t * g a b) ^ 2 = f a b ^ 2 - 2 * t * (f a b * g a b) + t ^ 2 * g a b ^ 2 :=
      fun a b => by ring
    simp only [e, Finset.sum_add_distrib, Finset.sum_sub_distrib, ← Finset.mul_sum]
    rw [ht]
    field_simp
    nlinarith [h]
  intro a b
  have hnn : ∀ a ∈ (Finset.univ : Finset ι), 0 ≤ ∑ b, (f a b - t * g a b) ^ 2 :=
    fun a _ => Finset.sum_nonneg fun b _ => sq_nonneg _
  have h1 := (Finset.sum_eq_zero_iff_of_nonneg hnn).mp hsum a (Finset.mem_univ a)
  have h2 := (Finset.sum_eq_zero_iff_of_nonneg fun b _ => sq_nonneg (f a b - t * g a b)).mp h1 b
    (Finset.mem_univ b)
  have := pow_eq_zero_iff (n := 2) (by norm_num) |>.mp h2
  linarith

/-- **L57's EQUALITY CASE AT A CRITICAL POINT**: at `λ = √(2(n−1)(n−2))/n`, a unit eigenvector `v` of
the top eigenvalue has `v_a² = 1/n` and `∑ v = 0`, and `S` is a multiple of L57's projection `Z(v)`. -/
theorem L57_critical_eq {S : Matrix ι ι ℝ} (hS : IsWeight S) (hn : 4 ≤ Fintype.card ι)
    (hunit : ∑ a, ∑ b, S a b ^ 2 = 2) (lam : ℝ)
    (hcrit : ∀ a b, a ≠ b → S a b ^ 2 + (S * S) a b = lam * S a b)
    (heq : lam = Real.sqrt (2 * ((Fintype.card ι : ℝ) - 1) * ((Fintype.card ι : ℝ) - 2))
      / (Fintype.card ι : ℝ)) :
    ∃ (v : ι → ℝ) (t : ℝ), 0 < t ∧ (∀ a, v a ^ 2 = 1 / (Fintype.card ι : ℝ)) ∧ ∑ a, v a = 0 ∧
      ∀ a b, S a b = t * Zp v (Fintype.card ι : ℝ) a b := by
  set n : ℝ := (Fintype.card ι : ℝ) with hndef
  have hn4 : (4 : ℝ) ≤ n := by rw [hndef]; exact_mod_cast hn
  have hnpos : 0 < n := by linarith
  have hne : Nonempty ι := Fintype.card_pos_iff.mp (by omega)
  obtain ⟨μ, v, hμ, hv, h2⟩ := exists_pos_eigen hS hne hunit
  have h1 := sum_v_zero S hS v μ hv hμ.ne'
  have hp := pairing S hS v μ hv lam h2 hcrit
  have hs1 := step1 S hS v μ hv h2 h1
  obtain ⟨hSZ, hZZ⟩ := step23_parts S hS v μ hv h2 h1 hn
  rw [← hndef] at hs1 hSZ hZZ
  set T := (1 / 2) * ∑ a, ∑ b, S a b ^ 2 * (v a - v b) ^ 2
  -- `λ n ≤ (n−1) μ`
  have hlm : lam * n ≤ (n - 1) * μ := by
    have : lam * μ * n ≤ (n - 1) * μ ^ 2 := by nlinarith
    have hμ2 : lam * n * μ ≤ (n - 1) * μ * μ := by nlinarith
    exact le_of_mul_le_mul_right hμ2 hμ
  -- `λ² n² = 2(n−1)(n−2)`
  have hsq : (lam * n) ^ 2 = 2 * (n - 1) * (n - 2) := by
    rw [heq, div_mul_cancel₀ _ hnpos.ne', Real.sq_sqrt (by nlinarith)]
  have hl0 : 0 ≤ lam * n := by rw [heq, div_mul_cancel₀ _ hnpos.ne']; exact Real.sqrt_nonneg _
  -- the Cauchy–Schwarz chain
  have hcs := cs_pairs S (Zp v n)
  rw [hSZ, hunit, hZZ] at hcs
  have h4 : 1 / n ≤ ∑ a, v a ^ 4 := by
    have := HamiltonsCubic.L223Statement.fourth_moment_defect v hnpos h2
    rw [← hndef] at this
    have hnn : 0 ≤ ∑ a, (v a ^ 2 - 1 / n) ^ 2 := Finset.sum_nonneg fun a _ => sq_nonneg _
    linarith
  have hn2 : 0 < n - 2 := by linarith
  have hn1 : 0 < n - 1 := by linarith
  set A := (n ^ 2 - 3 * n + 3) / (2 * (n - 1) * (n - 2)) with hA
  set k := n / (2 * (n - 2)) with hk
  have hkpos : 0 < k := by positivity
  have hAk : A - k * (1 / n) = (n - 2) / (2 * (n - 1)) := by rw [hA, hk]; field_simp; ring
  have hμ2lo : 2 * (n - 1) * (n - 2) ≤ (n - 1) ^ 2 * μ ^ 2 := by nlinarith
  have hμ2 : 2 * (n - 2) / (n - 1) ≤ μ ^ 2 := by
    rw [div_le_iff₀ hn1]; nlinarith
  -- all inequalities are tight: `∑ v⁴ = 1/n` and the Cauchy–Schwarz equality
  have hv4 : ∑ a, v a ^ 4 = 1 / n := by
    have hup : μ ^ 2 ≤ 2 * (2 * (A - k * ∑ a, v a ^ 4)) := hcs
    have : 2 * (2 * (A - k * ∑ a, v a ^ 4)) ≤ 2 * (n - 2) / (n - 1) := by
      have := mul_le_mul_of_nonneg_left h4 hkpos.le
      have e : 2 * (n - 2) / (n - 1) = 2 * (2 * ((n - 2) / (2 * (n - 1)))) := by field_simp
      rw [e]; nlinarith
    have hmid : 2 * (2 * (A - k * ∑ a, v a ^ 4)) = 2 * (n - 2) / (n - 1) := by linarith
    have e2 : 2 * (n - 2) / (n - 1) = 4 * (A - k * (1 / n)) := by rw [hAk]; field_simp; ring
    rw [e2] at hmid
    have : k * ∑ a, v a ^ 4 = k * (1 / n) := by linarith
    exact mul_left_cancel₀ hkpos.ne' this
  have hZpos : 0 < ∑ a, ∑ b, Zp v n a b ^ 2 := by
    rw [hZZ, hv4]
    have : 2 * (A - k * (1 / n)) = (n - 2) / (n - 1) := by
      rw [hAk]; have hn1' : n - 1 ≠ 0 := by linarith
      field_simp
    rw [this]; positivity
  have hcseq : (∑ a, ∑ b, S a b * Zp v n a b) ^ 2
      = (∑ a, ∑ b, S a b ^ 2) * ∑ a, ∑ b, Zp v n a b ^ 2 := by
    rw [hSZ, hunit, hZZ, hv4]
    have : 2 * (2 * (A - k * (1 / n))) = 2 * (n - 2) / (n - 1) := by rw [hAk]; field_simp
    rw [this]
    have hup : μ ^ 2 ≤ 2 * (n - 2) / (n - 1) := by
      have := step23 S hS v μ hv h2 h1 hn hunit
      rw [← hndef] at this; exact this
    linarith
  have hprop := cs_eq S (Zp v n) hZpos hcseq
  refine ⟨v, _, ?_, fun a => ?_, h1, hprop⟩
  · rw [hSZ]; exact div_pos hμ hZpos
  -- `v_a² = 1/n` from the vanishing fourth-moment defect
  have hdef := HamiltonsCubic.L223Statement.fourth_moment_defect v hnpos h2
  rw [← hndef, hv4, sub_self] at hdef
  have hnn : ∀ a ∈ (Finset.univ : Finset ι), 0 ≤ (v a ^ 2 - 1 / n) ^ 2 := fun a _ => sq_nonneg _
  have := (Finset.sum_eq_zero_iff_of_nonneg hnn).mp hdef a (Finset.mem_univ a)
  have := pow_eq_zero_iff (n := 2) (by norm_num) |>.mp this
  linarith

omit [DecidableEq ι] in
/-- **A zero-sum vector with all squares equal has even length.** -/
theorem even_card_of_balanced (v : ι → ℝ) (c : ℝ) (hc : 0 < c) (hv2 : ∀ a, v a ^ 2 = c)
    (h1 : ∑ a, v a = 0) : Even (Fintype.card ι) := by
  classical
  set r := Real.sqrt c with hr
  have hrpos : 0 < r := Real.sqrt_pos.mpr hc
  have hval : ∀ a, v a = r ∨ v a = -r := by
    intro a
    have : (v a - r) * (v a + r) = 0 := by
      have h := hv2 a
      have hr2 : r ^ 2 = c := Real.sq_sqrt hc.le
      nlinarith
    rcases mul_eq_zero.mp this with h | h
    · left; linarith
    · right; linarith
  set P := (Finset.univ.filter fun a => v a = r).card with hP
  set N := (Finset.univ.filter fun a => ¬ v a = r).card with hN
  have hPN : P + N = Fintype.card ι := by
    rw [hP, hN, Finset.card_filter_add_card_filter_not, Finset.card_univ]
  have hsum : ∑ a, v a = r * P - r * N := by
    rw [← Finset.sum_filter_add_sum_filter_not Finset.univ (fun a => v a = r)]
    have e1 : ∑ a ∈ Finset.univ.filter (fun a => v a = r), v a = r * P := by
      rw [Finset.sum_congr rfl fun a ha => (Finset.mem_filter.mp ha).2, Finset.sum_const, nsmul_eq_mul,
        mul_comm]
    have e2 : ∑ a ∈ Finset.univ.filter (fun a => ¬ v a = r), v a = -(r * N) := by
      rw [Finset.sum_congr rfl fun a ha => ((hval a).resolve_left (Finset.mem_filter.mp ha).2),
        Finset.sum_const, nsmul_eq_mul]
      ring
    rw [e1, e2]; ring
  rw [h1] at hsum
  have hPNr : (P : ℝ) = N := by
    have : r * ((P : ℝ) - N) = 0 := by linarith
    rcases mul_eq_zero.mp this with h | h
    · linarith
    · linarith
  have hPNn : P = N := by exact_mod_cast hPNr
  exact ⟨P, by omega⟩

/-- **At odd `n` the critical bound is strict**: equality would force `n` even. -/
theorem L57_critical_strict_odd {S : Matrix ι ι ℝ} (hS : IsWeight S) (hn : 4 ≤ Fintype.card ι)
    (hodd : ¬ Even (Fintype.card ι)) (hunit : ∑ a, ∑ b, S a b ^ 2 = 2) (lam : ℝ)
    (hcrit : ∀ a b, a ≠ b → S a b ^ 2 + (S * S) a b = lam * S a b) :
    lam < Real.sqrt (2 * ((Fintype.card ι : ℝ) - 1) * ((Fintype.card ι : ℝ) - 2))
      / (Fintype.card ι : ℝ) := by
  rcases (L57_critical hS hn hunit lam hcrit).lt_or_eq with h | h
  · exact h
  · obtain ⟨v, t, -, hv2, h1, -⟩ := L57_critical_eq hS hn hunit lam hcrit h
    have hnpos : (0 : ℝ) < Fintype.card ι := by
      have : 0 < Fintype.card ι := by omega
      exact_mod_cast this
    exact absurd (even_card_of_balanced v _ (by positivity) hv2 h1) hodd

/-- **L57's EQUALITY CASE ON THE UNIT DIAGONAL SPHERE**: a unit weight attaining
`√(2(n−1)(n−2))/n` is a multiple of L57's projection `Z(v)` at a vector with `v_a² = 1/n` and
`∑ v = 0`, the balanced sphere product, and `n` is even. -/
theorem L57_unit_eq {S : Matrix ι ι ℝ} (hS : IsWeight S) (hn : 4 ≤ Fintype.card ι) (hf : fro S = 2)
    (heq : diagP S = Real.sqrt (2 * ((Fintype.card ι : ℝ) - 1) * ((Fintype.card ι : ℝ) - 2))
      / (Fintype.card ι : ℝ)) :
    (∃ (v : ι → ℝ) (t : ℝ), 0 < t ∧ (∀ a, v a ^ 2 = 1 / (Fintype.card ι : ℝ)) ∧ ∑ a, v a = 0 ∧
      ∀ a b, S a b = t * Zp v (Fintype.card ι : ℝ) a b) ∧ Even (Fintype.card ι) := by
  -- `S` is a maximiser, the global maximum being at most the bound
  obtain ⟨S₀, hS₀, hf₀, hmax₀⟩ := exists_max_weight hn
  have hb := max_le_theta hn hS₀ hf₀ hmax₀
  have hmax : ∀ T : Matrix ι ι ℝ, IsWeight T → fro T = 2 → diagP T ≤ diagP S := fun T hT hfT => by
    rw [heq]; exact le_trans (hmax₀ T hT hfT) hb
  obtain ⟨lam, hcrit⟩ := max_crit hn hS hf hmax
  have hunit : ∑ a, ∑ b, S a b ^ 2 = 2 := hf
  have hlam : lam = _ := (diagP_eq_lam hS hunit lam hcrit).symm.trans heq
  obtain ⟨v, t, ht, hv2, h1, hprop⟩ := L57_critical_eq hS hn hunit lam hcrit hlam
  have hnpos : (0 : ℝ) < Fintype.card ι := by
    have : 0 < Fintype.card ι := by omega
    exact_mod_cast this
  exact ⟨⟨v, t, ht, hv2, h1, hprop⟩, even_card_of_balanced v _ (by positivity) hv2 h1⟩

end HamiltonsCubic.L57Critical
