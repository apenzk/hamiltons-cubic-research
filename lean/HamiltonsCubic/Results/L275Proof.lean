import HamiltonsCubic.Results.J1

set_option linter.style.longLine false

/-!
# L275, proved: J1 on the face `P = Q`, for `m ≥ 4`

The record's proof ([second-order.md](../../../findings/second-order.md), L275), step by step:
- (1) and (2): `HamiltonsCubic.J1.cocktail_rows` and `HamiltonsCubic.J1.pairing` at `V = 0`, where the pair weight is
  `R_ij = D_i D_j − x_ij²`;
- (3): `HamiltonsCubic.J1.pair_bound` at `γ = 0`, which is the harmonic-mean bound;
- (4): `vb`, the column Cauchy–Schwarz with weights `1/π_i − κ`;
- (5): `H_pi`, the chord of `1/(1 − κt)`, Titu's form, `Σπ³ ≥ s²`, `Σπ⁴ ≥ s³` and `L275_close`;
- the range `m ≥ 4` through `kapm_facts`: `κ < 2` and `κ² − 8κ + 8 < 0`.
-/

namespace HamiltonsCubic.L275

open Matrix Finset

/-- `κ = λ_m² = 2m(m − 2)²/(m − 1)³`. -/
noncomputable def kapm (m : ℝ) : ℝ := 2 * m * (m - 2) ^ 2 / (m - 1) ^ 3

theorem kapm_facts (t : ℕ) :
    let κ := kapm ((t : ℝ) + 4)
    0 < κ ∧ κ < 2 ∧ κ ^ 2 - 8 * κ + 8 < 0 := by
  intro κ
  set T : ℝ := (t : ℝ) with hT
  have hT0 : 0 ≤ T := by positivity
  set a : ℝ := 2 * (T + 4) * (T + 2) ^ 2 with ha
  set b : ℝ := (T + 3) ^ 3 with hb
  have hb0 : 0 < b := pow_pos (by linarith) 3
  have hk : κ = a / b := by
    show kapm ((t : ℝ) + 4) = a / b
    simp only [kapm, ha, hb, hT]; ring_nf
  have hkb : κ * b = a := by rw [hk, div_mul_cancel₀ _ hb0.ne']
  refine ⟨by rw [hk]; exact div_pos (by rw [ha]; positivity) hb0, ?_, ?_⟩
  · rw [hk, div_lt_iff₀ hb0, ha, hb]; nlinarith [sq_nonneg T, pow_nonneg hT0 3]
  · have key : (κ ^ 2 - 8 * κ + 8) * b ^ 2 = a ^ 2 - 8 * a * b + 8 * b ^ 2 := by rw [← hkb]; ring
    have hneg : a ^ 2 - 8 * a * b + 8 * b ^ 2 = -(4*T^6 + 64*T^5 + 408*T^4 + 1296*T^3 + 2056*T^2 + 1328*T + 56) := by
      rw [ha, hb]; ring
    have hlt : a ^ 2 - 8 * a * b + 8 * b ^ 2 < 0 := by
      rw [hneg]; nlinarith [pow_nonneg hT0 6, pow_nonneg hT0 5, pow_nonneg hT0 4, pow_nonneg hT0 3, pow_nonneg hT0 2]
    rw [← key] at hlt
    exact neg_of_mul_neg_left hlt (by positivity)

/-- **Step (5), the inequality on the stationary law**: for `κ ∈ (4 − 2√2, 2)` and a probability vector `π` with
`π_i ≤ ½`, with `β_i = π_i/(1 − κπ_i)` and `B = Σβ`, `Σ_j π_j²/(B − β_j) ≥ κ s + 1 − κ`. -/
theorem H_pi {m : ℕ} (κ : ℝ) (hk : κ ^ 2 - 8 * κ + 8 < 0) (hk2 : κ < 2) (p : Fin m → ℝ) (h0 : ∀ i, 0 ≤ p i)
    (h1 : ∀ i, p i ≤ 1 / 2) (hs : ∑ i, p i = 1) :
    κ * (∑ i, p i ^ 2) + 1 - κ ≤ ∑ j, p j ^ 2 / (∑ i, p i / (1 - κ * p i) - p j / (1 - κ * p j)) := by
  have hk1 : 1 < κ := by nlinarith
  set s := ∑ i, p i ^ 2 with hsdef
  set β : Fin m → ℝ := fun i => p i / (1 - κ * p i) with hβ
  set B := ∑ i, β i with hB
  change κ * s + 1 - κ ≤ ∑ j, p j ^ 2 / (B - β j)
  have hden : ∀ i, 0 < 1 - κ * p i := fun i => by nlinarith [h1 i, h0 i]
  have hβp : ∀ i, p i ≤ β i := fun i => by
    simp only [hβ]; rw [le_div_iff₀ (hden i)]; nlinarith [h0 i, mul_nonneg (by linarith : (0:ℝ) ≤ κ) (h0 i)]
  have hβ0 : ∀ i, 0 ≤ β i := fun i => le_trans (h0 i) (hβp i)
  have hBg : ∀ j, 1 / 2 ≤ B - β j := fun j => by
    have e : B - β j = ∑ i ∈ Finset.univ.erase j, β i := by
      have := Finset.add_sum_erase Finset.univ β (Finset.mem_univ j); rw [hB]; linarith
    have e2 : ∑ i ∈ Finset.univ.erase j, p i = 1 - p j := by
      have := Finset.add_sum_erase Finset.univ p (Finset.mem_univ j); linarith
    rw [e]; have := Finset.sum_le_sum (s := Finset.univ.erase j) fun i _ => hβp i
    linarith [h1 j]
  have hRHSnn : 0 ≤ ∑ j, p j ^ 2 / (B - β j) :=
    Finset.sum_nonneg fun j _ => div_nonneg (sq_nonneg _) (by linarith [hBg j])
  have hs1 : s ≤ 1 / 2 := by
    have : ∀ i, p i ^ 2 ≤ p i / 2 := fun i => by nlinarith [h0 i, h1 i]
    calc s ≤ ∑ i, p i / 2 := Finset.sum_le_sum fun i _ => this i
      _ = 1 / 2 := by rw [← Finset.sum_div, hs]
  by_cases hsm : s ≤ 1 - 1 / κ
  · have : κ * s + 1 - κ ≤ 0 := by
      have := mul_le_mul_of_nonneg_left hsm (by linarith : (0:ℝ) ≤ κ)
      rw [mul_sub, mul_one, mul_one_div_cancel (by linarith)] at this; linarith
    linarith
  push Not at hsm
  have hspos : 0 < s := by
    have : 0 < 1 - 1 / κ := by rw [sub_pos, div_lt_one (by linarith)]; exact hk1
    linarith
  -- the chord of the convex 1/(1 − κt) on [0, 1/2]
  set γ := 2 * κ / (2 - κ) with hγ
  have hγ0 : 0 ≤ γ := div_nonneg (by linarith) (by linarith)
  have hγe : γ * (2 - κ) = 2 * κ := by rw [hγ]; exact div_mul_cancel₀ _ (by linarith : (2:ℝ) - κ ≠ 0)
  have hchord : ∀ i, β i ≤ p i * (1 + γ * p i) := fun i => by
    simp only [hβ]; rw [div_le_iff₀ (hden i)]
    have e := hγe
    have hq : 0 ≤ p i * (γ - κ - γ * κ * p i) := by
      apply mul_nonneg (h0 i)
      have : γ - κ - γ * κ * (1 / 2) = 0 := by nlinarith [e]
      nlinarith [mul_nonneg (mul_nonneg hγ0 (by linarith : (0:ℝ) ≤ κ)) (by linarith [h1 i] : (0:ℝ) ≤ 1 / 2 - p i)]
    nlinarith [mul_nonneg (h0 i) hq]
  set cc : Fin m → ℝ := fun j => 1 - p j + γ * (s - p j ^ 2) with hcc
  have hBc : ∀ j, B - β j ≤ cc j := fun j => by
    have e : B - β j = ∑ i ∈ Finset.univ.erase j, β i := by
      have := Finset.add_sum_erase Finset.univ β (Finset.mem_univ j); rw [hB]; linarith
    have e2 : ∑ i ∈ Finset.univ.erase j, p i * (1 + γ * p i) = cc j := by
      have h3 := Finset.add_sum_erase Finset.univ (fun i => p i * (1 + γ * p i)) (Finset.mem_univ j)
      have h4 : ∑ i, p i * (1 + γ * p i) = 1 + γ * s := by
        rw [Finset.sum_congr rfl fun i _ => (by ring : p i * (1 + γ * p i) = p i + γ * p i ^ 2),
          Finset.sum_add_distrib, ← Finset.mul_sum, hs]
      show ∑ i ∈ Finset.univ.erase j, p i * (1 + γ * p i) = 1 - p j + γ * (s - p j ^ 2)
      linarith
    rw [e, ← e2]; exact Finset.sum_le_sum fun i _ => hchord i
  -- Titu over the support
  set T := Finset.univ.filter (fun j => 0 < p j) with hT
  have hTpos : ∀ j ∈ T, 0 < p j ^ 2 * cc j := fun j hj => by
    simp only [hT, Finset.mem_filter, Finset.mem_univ, true_and] at hj
    exact mul_pos (pow_pos hj 2) (by linarith [hBg j, hBc j])
  have htitu := sq_sum_div_le_sum_sq_div T (fun j => p j ^ 2) hTpos
  have hsT : ∑ j ∈ T, p j ^ 2 = s := by
    rw [hsdef, hT, Finset.sum_filter]
    exact Finset.sum_congr rfl fun j _ => by
      split_ifs with h
      · rfl
      · rw [le_antisymm (not_lt.1 h) (h0 j)]; ring
  have hterm : ∑ j ∈ T, (p j ^ 2) ^ 2 / (p j ^ 2 * cc j) ≤ ∑ j, p j ^ 2 / (B - β j) := by
    calc ∑ j ∈ T, (p j ^ 2) ^ 2 / (p j ^ 2 * cc j) = ∑ j ∈ T, p j ^ 2 / cc j :=
          Finset.sum_congr rfl fun j hj => by
            simp only [hT, Finset.mem_filter, Finset.mem_univ, true_and] at hj
            have : 0 < cc j := by linarith [hBg j, hBc j]
            field_simp
      _ ≤ ∑ j ∈ T, p j ^ 2 / (B - β j) := Finset.sum_le_sum fun j hj => by
            simp only [hT, Finset.mem_filter, Finset.mem_univ, true_and] at hj
            exact div_le_div_of_nonneg_left (sq_nonneg _) (by linarith [hBg j]) (hBc j)
      _ ≤ _ := Finset.sum_le_sum_of_subset_of_nonneg (Finset.subset_univ _)
            fun j _ _ => div_nonneg (sq_nonneg _) (by linarith [hBg j])
  -- the denominator: Σ π² c ≤ s(1 − s)(1 + γ s), by Σπ³ ≥ s² and Σπ⁴ ≥ s³
  have h3 : s ^ 2 ≤ ∑ i, p i ^ 3 := by
    have := Finset.sum_mul_sq_le_sq_mul_sq Finset.univ (fun i => Real.sqrt (p i)) (fun i => Real.sqrt (p i) * p i)
    have e1 : ∀ i, Real.sqrt (p i) * (Real.sqrt (p i) * p i) = p i ^ 2 := fun i => by
      rw [← mul_assoc, Real.mul_self_sqrt (h0 i)]; ring
    have e2 : ∀ i, Real.sqrt (p i) ^ 2 = p i := fun i => Real.sq_sqrt (h0 i)
    have e3 : ∀ i, (Real.sqrt (p i) * p i) ^ 2 = p i ^ 3 := fun i => by rw [mul_pow, e2]; ring
    simp only [e1, e2, e3, hs, one_mul] at this; exact this
  have h4 : s ^ 3 ≤ ∑ i, p i ^ 4 := by
    have := Finset.sum_mul_sq_le_sq_mul_sq Finset.univ (fun i => p i) (fun i => p i ^ 2)
    have e1 : ∀ i, p i * p i ^ 2 = p i ^ 3 := fun i => by ring
    have e3 : ∀ i, (p i ^ 2) ^ 2 = p i ^ 4 := fun i => by ring
    simp only [e1, e3] at this
    have h5 : s ^ 4 ≤ (∑ i, p i ^ 3) ^ 2 := by nlinarith [h3, sq_nonneg s]
    have : s ^ 4 ≤ s * ∑ i, p i ^ 4 := le_trans h5 this
    nlinarith [this, hspos]
  have hUc : ∑ j ∈ T, p j ^ 2 * cc j ≤ s * (1 - s) * (1 + γ * s) := by
    have e : ∑ j ∈ T, p j ^ 2 * cc j = ∑ j, p j ^ 2 * cc j := by
      rw [hT, Finset.sum_filter]; exact Finset.sum_congr rfl fun j _ => by
        split_ifs with h
        · rfl
        · rw [le_antisymm (not_lt.1 h) (h0 j)]; ring
    have e2 : ∑ j, p j ^ 2 * cc j = s - ∑ j, p j ^ 3 + γ * (s ^ 2 - ∑ j, p j ^ 4) := by
      simp only [hcc]
      rw [Finset.sum_congr rfl fun j _ => (by ring : p j ^ 2 * (1 - p j + γ * (s - p j ^ 2)) = p j ^ 2 - p j ^ 3 + γ * s * p j ^ 2 - γ * p j ^ 4),
        Finset.sum_sub_distrib, Finset.sum_add_distrib, Finset.sum_sub_distrib, ← Finset.mul_sum, ← Finset.mul_sum, ← hsdef]
      ring
    rw [e, e2]; nlinarith [h3, h4, hγ0, mul_le_mul_of_nonneg_left h4 hγ0]
  have hUcpos : 0 < ∑ j ∈ T, p j ^ 2 * cc j := by
    have hne : T.Nonempty := by
      by_contra hc; rw [Finset.not_nonempty_iff_eq_empty] at hc; rw [hc, Finset.sum_empty] at hsT; linarith
    exact Finset.sum_pos hTpos hne
  rw [hsT] at htitu
  have hstep : s / ((1 - s) * (1 + γ * s)) ≤ s ^ 2 / ∑ j ∈ T, p j ^ 2 * cc j := by
    rw [div_le_div_iff₀ (by nlinarith) hUcpos]; nlinarith [hUc, hspos]
  have hclose := L275_close κ s hk hk2 hsm.le hs1
  have hfin : κ * s + 1 - κ ≤ s / ((1 - s) * (1 + γ * s)) := by
    have e : (1 + γ * s) * (2 - κ) = 2 - κ + 2 * κ * s := by
      have : (1 + γ * s) * (2 - κ) = 2 - κ + s * (γ * (2 - κ)) := by ring
      rw [this, hγe]; ring
    rw [le_div_iff₀ (by nlinarith)]
    have h2k : 0 < 2 - κ := by linarith
    have h' : (κ * s + 1 - κ) * ((1 - s) * (1 + γ * s)) * (2 - κ) ≤ s * (2 - κ) := by
      rw [show (κ * s + 1 - κ) * ((1 - s) * (1 + γ * s)) * (2 - κ) = (κ * s + 1 - κ) * (1 - s) * ((1 + γ * s) * (2 - κ)) by ring, e]
      exact hclose
    exact le_of_mul_le_mul_right h' h2k
  exact le_trans hfin (le_trans hstep (le_trans htitu hterm))


/-- **(V0-b)** in weight form, for `m = t + 4 ≥ 4`: `Σ w (1 − w/π) ≤ κ(1 − Σπ² − Σw²)`. -/
theorem vb (t : ℕ) (w : Fin (t + 4) → Fin (t + 4) → ℝ) (hw0 : ∀ i j, 0 ≤ w i j) (hsym : ∀ i j, w i j = w j i)
    (hdiag : ∀ i, w i i = 0) (hS : ∑ i, ∑ j, w i j = 1) :
    ∑ i, ∑ j, w i j * (1 - w i j / ∑ k, w i k)
      ≤ kapm ((t : ℝ) + 4) * (1 - ∑ i, (∑ k, w i k) ^ 2 - ∑ i, ∑ j, w i j ^ 2) := by
  obtain ⟨hk0, hk2, hk⟩ := kapm_facts t
  set κ := kapm ((t : ℝ) + 4) with hκ
  set P : Fin (t + 4) → ℝ := fun i => ∑ k, w i k with hP
  change ∑ i, ∑ j, w i j * (1 - w i j / P i) ≤ κ * (1 - ∑ i, P i ^ 2 - ∑ i, ∑ j, w i j ^ 2)
  have hP0 : ∀ i, 0 ≤ P i := fun i => Finset.sum_nonneg fun k _ => hw0 i k
  have hPsum : ∑ i, P i = 1 := hS
  have hwP : ∀ i j, w i j ≤ P j := fun i j => by
    rw [hsym i j]; exact Finset.single_le_sum (fun k _ => hw0 j k) (Finset.mem_univ i)
  have hwPi : ∀ i j, w i j ≤ P i := fun i j => Finset.single_le_sum (fun k _ => hw0 i k) (Finset.mem_univ j)
  have hPhalf : ∀ i, P i ≤ 1 / 2 := fun i => by
    have h1 : P i ≤ ∑ j, (P j - if j = i then P j else 0) := Finset.sum_le_sum fun j _ => by
      split_ifs with h
      · rw [h, hdiag]; simp
      · simpa using hwP i j
    rw [Finset.sum_sub_distrib, Finset.sum_ite_eq', if_pos (Finset.mem_univ _), hPsum] at h1
    linarith
  have hden : ∀ i, 0 < 1 - κ * P i := fun i => by nlinarith [hPhalf i, hP0 i]
  set β : Fin (t + 4) → ℝ := fun i => P i / (1 - κ * P i) with hβ
  have hβ0 : ∀ i, 0 ≤ β i := fun i => div_nonneg (hP0 i) (hden i).le
  -- the left side is 1 − Σ w²/P
  have hL : ∑ i, ∑ j, w i j * (1 - w i j / P i) = 1 - ∑ i, ∑ j, w i j ^ 2 / P i := by
    have e : ∀ i j, w i j * (1 - w i j / P i) = w i j - w i j ^ 2 / P i := fun i j => by ring
    simp only [e, Finset.sum_sub_distrib]; rw [hS]
  -- the column Cauchy–Schwarz
  have hcol : ∀ j, P j ^ 2 / (∑ i, β i - β j) ≤ ∑ i, (w i j ^ 2 / P i - κ * w i j ^ 2) := by
    intro j
    have hR : ∀ i, 0 ≤ w i j ^ 2 / P i - κ * w i j ^ 2 := fun i => by
      by_cases h : P i = 0
      · have : w i j = 0 := le_antisymm (h ▸ hwPi i j) (hw0 i j)
        simp [this]
      · have hp : 0 < P i := lt_of_le_of_ne (hP0 i) (Ne.symm h)
        have : w i j ^ 2 / P i - κ * w i j ^ 2 = w i j ^ 2 * (1 - κ * P i) / P i := by field_simp
        rw [this]; exact div_nonneg (mul_nonneg (sq_nonneg _) (hden i).le) hp.le
    by_cases hPj : P j = 0
    · rw [hPj]; simp only [ne_eq, OfNat.ofNat_ne_zero, not_false_eq_true, zero_pow, zero_div]
      exact Finset.sum_nonneg fun i _ => hR i
    set T := Finset.univ.filter (fun i => i ≠ j ∧ 0 < P i) with hT
    have hTpos : ∀ i ∈ T, 0 < β i := fun i hi => by
      simp only [hT, Finset.mem_filter, Finset.mem_univ, true_and] at hi; exact div_pos hi.2 (hden i)
    have hTw : ∑ i ∈ T, w i j = P j := by
      have hcolsum : ∑ i, w i j = P j := by simp only [hP]; exact Finset.sum_congr rfl fun i _ => hsym i j
      rw [← hcolsum, hT, Finset.sum_filter]
      refine Finset.sum_congr rfl fun i _ => ?_
      split_ifs with h
      · rfl
      · push Not at h
        by_cases hij : i = j
        · rw [hij, hdiag]
        · have : P i = 0 := le_antisymm (h hij) (hP0 i)
          exact (le_antisymm (this ▸ hwPi i j) (hw0 i j)).symm
    have hTne : T.Nonempty := by
      by_contra hc; rw [Finset.not_nonempty_iff_eq_empty] at hc
      rw [hc, Finset.sum_empty] at hTw; exact hPj hTw.symm
    have hTg : ∑ i ∈ T, β i ≤ ∑ i, β i - β j := by
      have e : ∑ i, β i - β j = ∑ i ∈ Finset.univ.erase j, β i := by
        have := Finset.add_sum_erase Finset.univ β (Finset.mem_univ j); linarith
      rw [e]
      exact Finset.sum_le_sum_of_subset_of_nonneg (fun i hi => by
        simp only [hT, Finset.mem_filter, Finset.mem_univ, true_and] at hi
        exact Finset.mem_erase.2 ⟨hi.1, Finset.mem_univ _⟩) (fun i _ _ => hβ0 i)
    have hTg0 : 0 < ∑ i ∈ T, β i := Finset.sum_pos hTpos hTne
    have htitu := sq_sum_div_le_sum_sq_div T (fun i => w i j) hTpos
    rw [hTw] at htitu
    have hsub : ∑ i ∈ T, w i j ^ 2 / β i ≤ ∑ i, (w i j ^ 2 / P i - κ * w i j ^ 2) := by
      calc ∑ i ∈ T, w i j ^ 2 / β i = ∑ i ∈ T, (w i j ^ 2 / P i - κ * w i j ^ 2) :=
            Finset.sum_congr rfl fun i hi => by
              simp only [hT, Finset.mem_filter, Finset.mem_univ, true_and] at hi
              have := hden i
              have hP' : P i ≠ 0 := hi.2.ne'
              simp only [hβ]; field_simp
        _ ≤ _ := Finset.sum_le_sum_of_subset_of_nonneg (Finset.subset_univ _) fun i _ _ => hR i
    calc P j ^ 2 / (∑ i, β i - β j) ≤ P j ^ 2 / ∑ i ∈ T, β i := div_le_div_of_nonneg_left (sq_nonneg _) hTg0 hTg
      _ ≤ _ := le_trans htitu hsub
  have hH := H_pi κ hk hk2 P hP0 hPhalf hPsum
  have hsum : ∑ j, P j ^ 2 / (∑ i, β i - β j) ≤ ∑ i, ∑ j, w i j ^ 2 / P i - κ * ∑ i, ∑ j, w i j ^ 2 := by
    calc _ ≤ ∑ j, ∑ i, (w i j ^ 2 / P i - κ * w i j ^ 2) := Finset.sum_le_sum fun j _ => hcol j
      _ = _ := by
        rw [Finset.sum_comm]; simp only [Finset.sum_sub_distrib, Finset.mul_sum]
  rw [hL]
  change κ * (∑ i, P i ^ 2) + 1 - κ ≤ ∑ j, P j ^ 2 / (∑ i, β i - β j) at hH
  nlinarith [hH, hsum]

/-- **L275**, proved: for a real symmetric zero-diagonal `U` on `m ≥ 4` points,
`tr U³ · √S ≤ λ_m (S² − Σ_i D_i² − Σ_{i,j} U_ij⁴)`. -/
theorem L275_bound (m : ℕ) (hm : 4 ≤ m) (U : Matrix (Fin m) (Fin m) ℝ) (hU : Uᵀ = U) (hd : ∀ i, U i i = 0) :
    (U * U * U).trace * Real.sqrt (∑ i, ∑ j, U i j ^ 2)
      ≤ Real.sqrt (2 * m) * ((m : ℝ) - 2) / (((m : ℝ) - 1) * Real.sqrt ((m : ℝ) - 1)) *
        ((∑ i, ∑ j, U i j ^ 2) ^ 2 - ∑ i, (∑ j, U i j ^ 2) ^ 2 - ∑ i, ∑ j, U i j ^ 4) := by
  obtain ⟨t, rfl⟩ : ∃ t, m = t + 4 := ⟨m - 4, by omega⟩
  obtain ⟨hk0, hk2, hk⟩ := kapm_facts t
  set κ := kapm ((t : ℝ) + 4) with hκ
  have hUp : HamiltonsCubic.I117S.IsPairWeights U := ⟨hU, hd⟩
  have h0 : HamiltonsCubic.I117S.IsPairWeights (0 : Matrix (Fin (t + 4)) (Fin (t + 4)) ℝ) := ⟨by simp, fun i => by simp⟩
  set S := ∑ i, ∑ j, U i j ^ 2 with hSdef
  set D : Fin (t + 4) → ℝ := fun i => ∑ j, U i j ^ 2 with hD
  have hdv : ∀ i, HamiltonsCubic.I117S.dvec U 0 i = D i := fun i => by simp [HamiltonsCubic.I117S.dvec, hD]
  have hS0 : 0 ≤ S := Finset.sum_nonneg fun i _ => Finset.sum_nonneg fun j _ => sq_nonneg _
  -- λ_m = √κ
  set lam := Real.sqrt (2 * ((t + 4 : ℕ) : ℝ)) * (((t + 4 : ℕ) : ℝ) - 2) / ((((t + 4 : ℕ) : ℝ) - 1) * Real.sqrt (((t + 4 : ℕ) : ℝ) - 1)) with hlam
  have hT : (0 : ℝ) ≤ t := by positivity
  have hlam0 : 0 ≤ lam := by
    rw [hlam]; push_cast
    exact div_nonneg (mul_nonneg (Real.sqrt_nonneg _) (by linarith)) (mul_nonneg (by linarith) (Real.sqrt_nonneg _))
  have hlam2 : lam ^ 2 = κ := by
    rw [hlam, hκ]; push_cast
    rw [div_pow, mul_pow, mul_pow, Real.sq_sqrt (by positivity), Real.sq_sqrt (by linarith)]
    simp only [kapm]
    have h1 : ((t : ℝ) + 4 - 1) ≠ 0 := (by linarith : (0:ℝ) < (t : ℝ) + 4 - 1).ne'
    field_simp
  have hsk : Real.sqrt κ = lam := by rw [← hlam2, Real.sqrt_sq hlam0]
  -- the sum of the pair weights
  have hR : ∑ i, ∑ j, HamiltonsCubic.J1.Rw U 0 i j = S ^ 2 - ∑ i, D i ^ 2 - ∑ i, ∑ j, U i j ^ 4 := by
    have e : ∀ i j, HamiltonsCubic.J1.Rw U 0 i j = (if i = j then 0 else D i * D j) - U i j ^ 4 := fun i j => by
      unfold HamiltonsCubic.J1.Rw; split_ifs with h
      · subst h; simp [hd]
      · rw [hdv, hdv]; simp; ring
    simp only [e, Finset.sum_sub_distrib]
    congr 1
    have e2 : ∀ i, ∑ j, (if i = j then 0 else D i * D j) = D i * S - D i ^ 2 := fun i => by
      have : ∑ j, (if i = j then 0 else D i * D j)
          = ∑ j, D i * D j - ∑ j, (if i = j then D i * D j else 0) := by
        rw [← Finset.sum_sub_distrib]; exact Finset.sum_congr rfl fun j _ => by split_ifs <;> ring
      rw [this, Finset.sum_ite_eq, if_pos (Finset.mem_univ _), ← Finset.mul_sum]; ring
    rw [Finset.sum_congr rfl fun i _ => e2 i, Finset.sum_sub_distrib, ← Finset.sum_mul, sq]
  have hR0 : 0 ≤ ∑ i, ∑ j, HamiltonsCubic.J1.Rw U 0 i j :=
    Finset.sum_nonneg fun i _ => Finset.sum_nonneg fun j _ => HamiltonsCubic.J1.Rw_nonneg U 0 hUp h0 i j
  -- rows and pairing at V = 0
  have hT3 : (U * U * U).trace ≤ Real.sqrt (∑ i, ∑ j, HamiltonsCubic.J1.fw U 0 i j) * Real.sqrt (∑ i, ∑ j, HamiltonsCubic.J1.Rw U 0 i j) := by
    have h1 := HamiltonsCubic.J1.cocktail_rows U 0 hUp h0
    simp only [add_zero, sub_zero] at h1
    have e : (1 / 2 : ℝ) * ((U * U * U).trace + (U * U * U).trace) = (U * U * U).trace := by ring
    rw [e] at h1
    exact le_trans h1 (by simpa using HamiltonsCubic.J1.pairing U 0 hUp h0)
  by_cases hSz : S = 0
  · have hU0 : ∀ i j, U i j = 0 := fun i j => by
      have h2 : U i j ^ 2 ≤ D i := Finset.single_le_sum (f := fun j => U i j ^ 2) (fun j _ => sq_nonneg (U i j)) (Finset.mem_univ j)
      have h3 : D i ≤ S := Finset.single_le_sum (f := D) (fun i _ => Finset.sum_nonneg fun j _ => sq_nonneg (U i j)) (Finset.mem_univ i)
      have : U i j ^ 2 ≤ 0 := by linarith
      exact pow_eq_zero_iff (two_ne_zero) |>.mp (le_antisymm this (sq_nonneg _))
    have hUz : U = 0 := by ext i j; exact hU0 i j
    have htr : (U * U * U).trace = 0 := by rw [hUz]; simp
    have hD0 : ∀ i, D i = 0 := fun i => by simp [hD, hU0]
    have hz : S ^ 2 - ∑ i, D i ^ 2 - ∑ i, ∑ j, U i j ^ 4 = 0 := by rw [hSz]; simp [hD0, hU0]
    rw [htr, zero_mul, hz, mul_zero]
  have hSp : 0 < S := lt_of_le_of_ne hS0 (Ne.symm hSz)
  -- the per-pair bound summed: Σ f ≤ Σ U²(1 − U²/D)
  have hf : ∑ i, ∑ j, HamiltonsCubic.J1.fw U 0 i j ≤ ∑ i, ∑ j, U i j ^ 2 * (1 - U i j ^ 2 / D i) := by
    have h1 : ∑ i, ∑ j, HamiltonsCubic.J1.fw U 0 i j
        ≤ ∑ i, ∑ j, (HamiltonsCubic.J1.hterm U 0 i j + HamiltonsCubic.J1.hterm U 0 j i) :=
      Finset.sum_le_sum fun i _ => Finset.sum_le_sum fun j _ => HamiltonsCubic.J1.pair_bound U 0 hUp h0 i j
    have h2 : ∑ i, ∑ j, (HamiltonsCubic.J1.hterm U 0 i j + HamiltonsCubic.J1.hterm U 0 j i)
        = ∑ i, ∑ j, 2 * HamiltonsCubic.J1.hterm U 0 i j := by
      simp only [Finset.sum_add_distrib]
      rw [Finset.sum_comm (f := fun i j => HamiltonsCubic.J1.hterm U 0 j i)]
      simp only [← Finset.sum_add_distrib]
      exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by ring
    have hg0 : ∀ i j, HamiltonsCubic.J1.gam U 0 i j = 0 := fun i j => by
      unfold HamiltonsCubic.J1.gam; simp
    have h3 : ∀ i j, 2 * HamiltonsCubic.J1.hterm U 0 i j = U i j ^ 2 * (1 - U i j ^ 2 / D i) := fun i j => by
      unfold HamiltonsCubic.J1.hterm; rw [hg0, hdv]; unfold HamiltonsCubic.J1.ww
      simp only [Matrix.zero_apply]; ring
    rw [h2] at h1; simp only [h3] at h1; exact h1
  -- (V0-b) at w = U²/S
  have hwS : ∑ i, ∑ j, U i j ^ 2 / S = 1 := by
    have : ∑ i, ∑ j, U i j ^ 2 / S = (∑ i, ∑ j, U i j ^ 2) / S := by
      rw [Finset.sum_div]; exact Finset.sum_congr rfl fun i _ => by rw [Finset.sum_div]
    rw [this]; exact div_self hSz
  have hv := vb t (fun i j => U i j ^ 2 / S) (fun i j => div_nonneg (sq_nonneg _) hS0)
    (fun i j => by show U i j ^ 2 / S = U j i ^ 2 / S; rw [HamiltonsCubic.J1.symm_of U hUp i j]) (fun i => by simp [hd]) hwS
  have hrowS : ∀ i, ∑ k, U i k ^ 2 / S = D i / S := fun i => by rw [← Finset.sum_div]
  simp only [hrowS] at hv
  have hq : ∀ i j, U i j ^ 2 / S / (D i / S) = U i j ^ 2 / D i := fun i j => by
    by_cases hDi : D i = 0
    · have : U i j = 0 := by
        have h2 := Finset.single_le_sum (fun j _ => sq_nonneg (U i j)) (Finset.mem_univ j)
        change U i j ^ 2 ≤ D i at h2; rw [hDi] at h2; nlinarith [sq_nonneg (U i j)]
      simp [this, hDi]
    · field_simp
  simp only [hq] at hv
  have hLS : ∑ i, ∑ j, U i j ^ 2 / S * (1 - U i j ^ 2 / D i) = (∑ i, ∑ j, U i j ^ 2 * (1 - U i j ^ 2 / D i)) / S := by
    rw [Finset.sum_div]; exact Finset.sum_congr rfl fun i _ => by
      rw [Finset.sum_div]; exact Finset.sum_congr rfl fun j _ => by ring
  have hRS : 1 - ∑ i, (D i / S) ^ 2 - ∑ i, ∑ j, (U i j ^ 2 / S) ^ 2 = (S ^ 2 - ∑ i, D i ^ 2 - ∑ i, ∑ j, U i j ^ 4) / S ^ 2 := by
    have e1 : ∑ i, (D i / S) ^ 2 = (∑ i, D i ^ 2) / S ^ 2 := by
      rw [Finset.sum_div]; exact Finset.sum_congr rfl fun i _ => by ring
    have e2 : ∑ i, ∑ j, (U i j ^ 2 / S) ^ 2 = (∑ i, ∑ j, U i j ^ 4) / S ^ 2 := by
      rw [Finset.sum_div]; exact Finset.sum_congr rfl fun i _ => by
        rw [Finset.sum_div]; exact Finset.sum_congr rfl fun j _ => by ring
    rw [e1, e2]; field_simp
  rw [hLS, hRS] at hv
  have hmain : ∑ i, ∑ j, U i j ^ 2 * (1 - U i j ^ 2 / D i) ≤ κ * (S ^ 2 - ∑ i, D i ^ 2 - ∑ i, ∑ j, U i j ^ 4) / S := by
    rw [div_le_iff₀ hSp] at hv
    have : κ * ((S ^ 2 - ∑ i, D i ^ 2 - ∑ i, ∑ j, U i j ^ 4) / S ^ 2) * S = κ * (S ^ 2 - ∑ i, D i ^ 2 - ∑ i, ∑ j, U i j ^ 4) / S := by
      field_simp
    rw [this] at hv; exact hv
  rw [hR] at hT3 hR0
  have hfR : ∑ i, ∑ j, HamiltonsCubic.J1.fw U 0 i j ≤ κ * (S ^ 2 - ∑ i, D i ^ 2 - ∑ i, ∑ j, U i j ^ 4) / S := le_trans hf hmain
  set Rs := S ^ 2 - ∑ i, D i ^ 2 - ∑ i, ∑ j, U i j ^ 4 with hRs
  have hsq : Real.sqrt (∑ i, ∑ j, HamiltonsCubic.J1.fw U 0 i j) * Real.sqrt S ≤ lam * Real.sqrt Rs := by
    rw [← Real.sqrt_mul' _ hS0]
    have : Real.sqrt ((∑ i, ∑ j, HamiltonsCubic.J1.fw U 0 i j) * S) ≤ Real.sqrt (κ * Rs) := by
      apply Real.sqrt_le_sqrt
      have := mul_le_mul_of_nonneg_right hfR hS0
      rwa [div_mul_cancel₀ _ hSz] at this
    rw [Real.sqrt_mul' _ hR0, hsk] at this; exact this
  calc (U * U * U).trace * Real.sqrt S ≤ Real.sqrt (∑ i, ∑ j, HamiltonsCubic.J1.fw U 0 i j) * Real.sqrt Rs * Real.sqrt S :=
        mul_le_mul_of_nonneg_right hT3 (Real.sqrt_nonneg _)
    _ = (Real.sqrt (∑ i, ∑ j, HamiltonsCubic.J1.fw U 0 i j) * Real.sqrt S) * Real.sqrt Rs := by ring
    _ ≤ (lam * Real.sqrt Rs) * Real.sqrt Rs := mul_le_mul_of_nonneg_right hsq (Real.sqrt_nonneg _)
    _ = lam * Rs := by rw [mul_assoc, Real.mul_self_sqrt hR0]

end HamiltonsCubic.L275
