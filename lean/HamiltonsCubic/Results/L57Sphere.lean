import HamiltonsCubic.Results.L57Attain
import HamiltonsCubic.Results.L57Equality

set_option linter.style.longLine false

/-!
# L57's extremal matrix is the sphere product

At a two-valued `v` with `∑ v = 0`, `∑ v² = 1`, taking `x` on `p ≥ 2` indices and `y` on `q ≥ 2`,
L57's projection `Z(v)` is a positive multiple of `sphereWeight` of the split (`Zp_sphereWeight`).
So the equality cases `L57_unit_eq` and `L57_unit_eq_odd` land on positive multiples of the balanced and
the `(m, m+1)` sphere products (`L57_unit_sphere`, `L57_unit_sphere_odd`). `unit_join` puts `θ(diag w)` and
`diagP w` on one footing at unit norm, so **`L57_equality_even` and `L57_equality_odd` state L57's equality
clause in both directions on `θ`**: a unit diagonal `W` attains the bound iff its weight is a positive
multiple of the sphere product's weight at the extremal split.
-/

namespace HamiltonsCubic.L57Critical

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The scale is positive: times `pqn(n−1)(n−2)` it is `(n−1)[p²(q−1) + q²(p−1) − 2pq] + npq`. -/
theorem c_pos (p q : ℝ) (hp : 2 ≤ p) (hq : 2 ≤ q) :
    0 < -(-1 / (p + q) + (q / (p * (p + q)) + p / (q * (p + q))) / (p + q - 2)
      - 1 / ((p + q - 1) * (p + q - 2))) := by
  have h0 : 0 ≤ p * q - p - q := by nlinarith [mul_nonneg (sub_nonneg.2 hp) (sub_nonneg.2 hq)]
  have h1 : 0 ≤ p ^ 2 * (q - 1) - p * q := by nlinarith [mul_nonneg (by linarith : (0:ℝ) ≤ p) h0]
  have h2 : 0 ≤ q ^ 2 * (p - 1) - p * q := by nlinarith [mul_nonneg (by linarith : (0:ℝ) ≤ q) h0]
  have hn1 : 0 < p + q - 1 := by linarith
  have hn2 : 0 < p + q - 2 := by linarith
  have hp0 : 0 < p := by linarith
  have hq0 : 0 < q := by linarith
  have hD : 0 < p * q * (p + q) * (p + q - 1) * (p + q - 2) := by positivity
  have e : -(-1 / (p + q) + (q / (p * (p + q)) + p / (q * (p + q))) / (p + q - 2)
      - 1 / ((p + q - 1) * (p + q - 2)))
      = ((p + q - 1) * ((p ^ 2 * (q - 1) - p * q) + (q ^ 2 * (p - 1) - p * q)) + (p + q) * p * q)
        / (p * q * (p + q) * (p + q - 1) * (p + q - 2)) := by
    field_simp; ring
  rw [e]
  exact div_pos (add_pos_of_nonneg_of_pos (mul_nonneg hn1.le (add_nonneg h1 h2)) (by positivity)) hD

/-- **`Z(v)` at a two-valued `v` is a positive multiple of the sphere-product weight.** -/
theorem Zp_sphereWeight (v : ι → ℝ) (x y : ℝ) (hvals : ∀ a, v a = x ∨ v a = y)
    (h1 : ∑ a, v a = 0) (h2 : ∑ a, v a ^ 2 = 1)
    (hp : 2 ≤ (univ.filter fun a => v a = x).card) (hq : 2 ≤ (univ.filter fun a => v a = x)ᶜ.card) :
    ∃ c : ℝ, 0 < c ∧ ∀ a b, Zp v (Fintype.card ι : ℝ) a b
      = c * sphereWeight (univ.filter fun a => v a = x) a b := by
  set T := univ.filter fun a => v a = x with hT
  set p : ℝ := (T.card : ℝ) with hpdef
  set q : ℝ := (Tᶜ.card : ℝ) with hqdef
  set n : ℝ := (Fintype.card ι : ℝ) with hndef
  have hpR : (2 : ℝ) ≤ p := by rw [hpdef]; exact_mod_cast hp
  have hqR : (2 : ℝ) ≤ q := by rw [hqdef]; exact_mod_cast hq
  have hpq : p + q = n := by
    rw [hpdef, hqdef, hndef]; exact_mod_cast (Finset.card_add_card_compl T).trans (Finset.card_univ)
  have hmemT : ∀ a, a ∈ T ↔ v a = x := fun a => by simp [hT]
  have hnotT : ∀ a, a ∉ T → v a = y := fun a ha => (hvals a).resolve_left (fun h => ha ((hmemT a).mpr h))
  -- the two moment equations
  have hsplit : ∀ f : ℝ → ℝ, ∑ a, f (v a) = p * f x + q * f y := by
    intro f
    rw [← Finset.sum_add_sum_compl T]
    have e1 : ∑ a ∈ T, f (v a) = p * f x := by
      rw [Finset.sum_congr rfl fun a ha => by rw [(hmemT a).mp ha], Finset.sum_const, nsmul_eq_mul]
    have e2 : ∑ a ∈ Tᶜ, f (v a) = q * f y := by
      rw [Finset.sum_congr rfl fun a ha => by rw [hnotT a (Finset.mem_compl.mp ha)], Finset.sum_const,
        nsmul_eq_mul]
    rw [e1, e2]
  have hs1 : p * x + q * y = 0 := by rw [← h1, hsplit (fun t => t)]
  have hs2 : p * x ^ 2 + q * y ^ 2 = 1 := by rw [← h2, hsplit (fun t => t ^ 2)]
  have hxy1 : n * (x * y) = -1 := by
    have e1 : p * x ^ 2 = -(q * (x * y)) := by linear_combination x * hs1
    have e2 : q * y ^ 2 = -(p * (x * y)) := by linear_combination y * hs1
    rw [← hpq]; linear_combination -hs2 + e1 + e2
  have hx2 : p * n * x ^ 2 = q := by
    have e1 : p * x ^ 2 = -(q * (x * y)) := by linear_combination x * hs1
    linear_combination n * e1 - q * hxy1
  have hy2 : q * n * y ^ 2 = p := by
    have e2 : q * y ^ 2 = -(p * (x * y)) := by linear_combination y * hs1
    linear_combination n * e2 - p * hxy1
  have hn4 : (4 : ℝ) ≤ n := by linarith
  have hn2 : n - 2 ≠ 0 := by linarith
  have hn1 : n - 1 ≠ 0 := by linarith
  have hp0 : p ≠ 0 := by linarith
  have hq0 : q ≠ 0 := by linarith
  have hp1 : p - 1 ≠ 0 := by linarith
  have hq1 : q - 1 ≠ 0 := by linarith
  have hnz : n ≠ 0 := by linarith
  have hxsq : x ^ 2 = q / (p * n) := by field_simp; linarith
  have hysq : y ^ 2 = p / (q * n) := by field_simp; linarith
  have hxyv : x * y = -1 / n := by field_simp; linarith
  set c := -(x * y + (x ^ 2 + y ^ 2) / (n - 2) - 1 / ((n - 1) * (n - 2))) with hc
  have hcpos : 0 < c := by
    rw [hc, hxyv, hxsq, hysq, ← hpq]; exact c_pos p q hpR hqR
  refine ⟨c, hcpos, fun a b => ?_⟩
  by_cases hab : a = b
  · subst hab; simp [Zp, sphereWeight]
  unfold Zp
  rw [if_neg hab]
  by_cases ha : a ∈ T <;> by_cases hb : b ∈ T
  · rw [sphereWeight_in T ha hb hab, (hmemT a).mp ha, (hmemT b).mp hb, ← hpdef, ← hqdef, hc]
    have : x * x = x ^ 2 := by ring
    rw [this, hxsq, hxyv, hysq]
    rw [← hpq] at hn1 hn2 hnz ⊢; field_simp; ring
  · rw [sphereWeight_cross T ha hb, (hmemT a).mp ha, hnotT b hb, hc]; ring
  · rw [sphereWeight_symm, sphereWeight_cross T hb ha, hnotT a ha, (hmemT b).mp hb, hc]; ring
  · rw [sphereWeight_out T ha hb hab, hnotT a ha, hnotT b hb, ← hpdef, ← hqdef, hc]
    have : y * y = y ^ 2 := by ring
    rw [this, hxsq, hxyv, hysq]
    rw [← hpq] at hn1 hn2 hnz ⊢; field_simp; ring

/-- The `y`-level set of a two-valued `v` is the complement of its `x`-level set. -/
theorem filter_y_eq_compl (v : ι → ℝ) (x y : ℝ) (hxy : x ≠ y) (hvals : ∀ a, v a = x ∨ v a = y) :
    (univ.filter fun a => v a = y) = (univ.filter fun a => v a = x)ᶜ := by
  ext a
  simp only [Finset.mem_filter, Finset.mem_univ, true_and, Finset.mem_compl]
  exact ⟨fun h h' => hxy (h' ▸ h), fun h => (hvals a).resolve_left h⟩

/-- **L57's even equality case is the balanced sphere product**: a unit-Frobenius weight attaining the bound
is `c · sphereWeight S'` with `c > 0` and `|S'| = n/2`. -/
theorem L57_unit_sphere {S : Matrix ι ι ℝ} (hS : IsWeight S) (hn : 4 ≤ Fintype.card ι) (hf : fro S = 2)
    (heq : diagP S = Real.sqrt (2 * ((Fintype.card ι : ℝ) - 1) * ((Fintype.card ι : ℝ) - 2))
      / (Fintype.card ι : ℝ)) :
    ∃ (T : Finset ι) (c : ℝ), 2 * T.card = Fintype.card ι ∧ 0 < c ∧ ∀ a b, S a b = c * sphereWeight T a b := by
  obtain ⟨⟨v, t, ht, hv2, h1, hprop⟩, _⟩ := L57_unit_eq hS hn hf heq
  have hne : Nonempty ι := Fintype.card_pos_iff.mp (by omega)
  obtain ⟨a₀⟩ := hne
  set x := v a₀
  have hnR : (0 : ℝ) < Fintype.card ι := by exact_mod_cast (show 0 < Fintype.card ι by omega)
  have hx0 : x ≠ 0 := fun h => by have := hv2 a₀; rw [show v a₀ = x from rfl, h] at this; norm_num at this; linarith
  have hvals : ∀ a, v a = x ∨ v a = -x := fun a => by
    have : v a ^ 2 = x ^ 2 := by rw [hv2, hv2]
    exact sq_eq_sq_iff_eq_or_eq_neg.mp this
  set T := univ.filter fun a => v a = x with hT
  have hsplit : ∑ a, v a = (T.card : ℝ) * x + (Tᶜ.card : ℝ) * (-x) := by
    rw [← Finset.sum_add_sum_compl T]
    rw [Finset.sum_congr rfl fun a ha => (Finset.mem_filter.mp ha).2, Finset.sum_const, nsmul_eq_mul,
      Finset.sum_congr rfl fun a ha => (hvals a).resolve_left (by simpa [hT] using ha), Finset.sum_const,
      nsmul_eq_mul]
  have hpq : (T.card : ℝ) = Tᶜ.card := by
    rw [h1] at hsplit
    have : ((T.card : ℝ) - Tᶜ.card) * x = 0 := by linarith
    linarith [(mul_eq_zero.mp this).resolve_right hx0]
  have hpqN : T.card = Tᶜ.card := by exact_mod_cast hpq
  have htot : T.card + Tᶜ.card = Fintype.card ι := (Finset.card_add_card_compl T).trans Finset.card_univ
  have h2 : ∑ a, v a ^ 2 = 1 := by
    simp only [hv2, Finset.sum_const, Finset.card_univ, nsmul_eq_mul]; field_simp
  have hp : 2 ≤ T.card := by omega
  have hq : 2 ≤ Tᶜ.card := by omega
  obtain ⟨c, hc, hZ⟩ := Zp_sphereWeight v x (-x) hvals h1 h2 hp hq
  refine ⟨T, t * c, by omega, mul_pos ht hc, fun a b => ?_⟩
  rw [hprop, hZ, mul_assoc]

/-- **L57's odd equality case is the `(m, m+1)` sphere product**: a unit-Frobenius weight attaining the odd
bound is `c · sphereWeight S'` with `c > 0` and `||S'| − |S'ᶜ|| = 1`. -/
theorem L57_unit_sphere_odd {S : Matrix ι ι ℝ} (hS : IsWeight S) (hn : 5 ≤ Fintype.card ι)
    (hodd : ¬ Even (Fintype.card ι)) (hf : fro S = 2)
    (heq : diagP S = Real.sqrt (thetaOddSq (Fintype.card ι : ℝ))) :
    ∃ (T : Finset ι) (c : ℝ), ((T.card : ℤ) - Tᶜ.card) ^ 2 = 1 ∧ 0 < c ∧
      ∀ a b, S a b = c * sphereWeight T a b := by
  obtain ⟨v, t, x, y, ht, h1, h2, hxy, hvals, hcnt, hprop⟩ := L57_unit_eq_odd hS hn hodd hf heq
  rw [filter_y_eq_compl v x y hxy hvals] at hcnt
  set T := univ.filter fun a => v a = x
  have htot : T.card + Tᶜ.card = Fintype.card ι := (Finset.card_add_card_compl T).trans Finset.card_univ
  have hp : 2 ≤ T.card := by nlinarith
  have hq : 2 ≤ Tᶜ.card := by nlinarith
  obtain ⟨c, hc, hZ⟩ := Zp_sphereWeight v x y hvals h1 h2 hp hq
  refine ⟨T, t * c, hcnt, mul_pos ht hc, fun a b => ?_⟩
  rw [hprop, hZ, mul_assoc]

/-- At a unit-norm diagonal operator, `∑ w² = 2` and `θ(diag w) = diagP w`. -/
theorem unit_join (w : Matrix ι ι ℝ) (hw : IsWeight w) (hu : normSq (diagOp w) = 1) :
    fro w = 2 ∧ theta (diagOp w) = diagP w := by
  refine ⟨?_, ?_⟩
  · have := diagOp_normSq w hw.symm hw.hollow
    rw [hu] at this; unfold fro; linarith
  · rw [theta_of_unit _ hu, diagCubicFormula w hw]

theorem thetaSplitSq_comm (p q : ℝ) : thetaSplitSq p q = thetaSplitSq q p := by
  unfold thetaSplitSq; ring

/-- **L57's equality clause at even `n`, both directions on `θ`**: a unit diagonal `W` attains
`√(2(n−1)(n−2))/n` iff its weight is a positive multiple of `sphereWeight T` with `2|T| = n`. -/
theorem L57_equality_even (hn : 4 ≤ Fintype.card ι) (S : Matrix ι ι ℝ) (hS : IsWeight S)
    (hu : normSq (diagOp S) = 1) :
    theta (diagOp S) = Real.sqrt (2 * ((Fintype.card ι : ℝ) - 1) * ((Fintype.card ι : ℝ) - 2))
        / (Fintype.card ι : ℝ) ↔
      ∃ (T : Finset ι) (c : ℝ), 2 * T.card = Fintype.card ι ∧ 0 < c ∧ S = c • sphereWeight T := by
  obtain ⟨hf, hθ⟩ := unit_join S hS hu
  constructor
  · intro h
    obtain ⟨T, c, hT, hc, hS'⟩ := L57_unit_sphere hS hn hf (hθ.symm.trans h)
    exact ⟨T, c, hT, hc, Matrix.ext fun a b => by rw [hS', Matrix.smul_apply, smul_eq_mul]⟩
  · rintro ⟨T, c, hT, hc, rfl⟩
    have htot : T.card + Tᶜ.card = Fintype.card ι := (Finset.card_add_card_compl T).trans Finset.card_univ
    have hTc : Tᶜ.card = T.card := by omega
    have hp : 2 ≤ T.card := by omega
    have hq : 2 ≤ Tᶜ.card := by omega
    rw [theta_sphereProduct_value T hp hq c hc hu, hTc, thetaSplit]
    have hnR : (Fintype.card ι : ℝ) = 2 * (T.card : ℝ) := by exact_mod_cast hT.symm
    have hmR : (2 : ℝ) ≤ T.card := by exact_mod_cast hp
    rw [hnR, thetaSplitSq_balanced (T.card : ℝ) (by positivity) (by linarith)]
    unfold theta0Sq
    have hpos : (0 : ℝ) < 2 * T.card := by positivity
    rw [Real.sqrt_div' _ (by positivity), Real.sqrt_sq hpos.le]

/-- **L57's equality clause at odd `n`, both directions on `θ`**: a unit diagonal `W` attains `Θₙ` iff
its weight is a positive multiple of `sphereWeight T` with `(|T| − |Tᶜ|)² = 1`. -/
theorem L57_equality_odd (hn : 5 ≤ Fintype.card ι) (hodd : ¬ Even (Fintype.card ι)) (S : Matrix ι ι ℝ)
    (hS : IsWeight S) (hu : normSq (diagOp S) = 1) :
    theta (diagOp S) = Real.sqrt (thetaOddSq (Fintype.card ι : ℝ)) ↔
      ∃ (T : Finset ι) (c : ℝ), ((T.card : ℤ) - Tᶜ.card) ^ 2 = 1 ∧ 0 < c ∧ S = c • sphereWeight T := by
  obtain ⟨hf, hθ⟩ := unit_join S hS hu
  constructor
  · intro h
    obtain ⟨T, c, hT, hc, hS'⟩ := L57_unit_sphere_odd hS hn hodd hf (hθ.symm.trans h)
    exact ⟨T, c, hT, hc, Matrix.ext fun a b => by rw [hS', Matrix.smul_apply, smul_eq_mul]⟩
  · rintro ⟨T, c, hT, hc, rfl⟩
    have htot : T.card + Tᶜ.card = Fintype.card ι := (Finset.card_add_card_compl T).trans Finset.card_univ
    have hfac : ((T.card : ℤ) - Tᶜ.card - 1) * ((T.card : ℤ) - Tᶜ.card + 1) = 0 := by
      linear_combination hT
    have hsplit : Tᶜ.card = T.card + 1 ∨ T.card = Tᶜ.card + 1 := by
      rcases mul_eq_zero.mp hfac with h | h
      · right; omega
      · left; omega
    have hp : 2 ≤ T.card := by omega
    have hq : 2 ≤ Tᶜ.card := by omega
    rw [theta_sphereProduct_value T hp hq c hc hu, thetaSplit, thetaOddSq_eq]
    congr 1
    rcases hsplit with h | h
    · have hnR : (Fintype.card ι : ℝ) = 2 * (T.card : ℝ) + 1 := by exact_mod_cast (by omega : Fintype.card ι = 2 * T.card + 1)
      have hmR : (2 : ℝ) ≤ T.card := by exact_mod_cast hp
      rw [h, hnR]; push_cast
      exact thetaSplitSq_odd _ (by positivity) (by positivity) (by linarith)
    · have hnR : (Fintype.card ι : ℝ) = 2 * (Tᶜ.card : ℝ) + 1 := by exact_mod_cast (by omega : Fintype.card ι = 2 * Tᶜ.card + 1)
      have hmR : (2 : ℝ) ≤ Tᶜ.card := by exact_mod_cast hq
      rw [h, hnR, thetaSplitSq_comm]; push_cast
      exact thetaSplitSq_odd _ (by positivity) (by positivity) (by linarith)

end HamiltonsCubic.L57Critical
