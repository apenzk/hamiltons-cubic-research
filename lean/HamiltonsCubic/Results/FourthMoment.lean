import HamiltonsCubic.Results.L57Diagonal

set_option linter.style.longLine false

/-!
# L57's fourth-moment lemma at both parities

[findings/problem.md](../../../findings/problem.md), *Step 3, closed at both parities*: for `v ∈ ℝⁿ`,
`n ≥ 4`, with `∑ v = 0` and `∑ v² = 1`, `∑ v⁴ ≥ min_{p+q=n} (n/(pq) − 3/n)`, which is `1/n` at even `n`
and `(n²+3)/(n(n²−1))` at odd `n`. **This file proves the odd bound** (the even one being
`fourth_moment_defect`), by the record's route:

- `exists_min_moment`: a minimiser of `∑ v⁴` on `{∑ v = 0, ∑ v² = 1}` exists (compactness);
- `min_cubic`: at it `v_i³ = a + b v_i` for every `i`, with `b = ∑ v⁴`, from a line argument and the
  vanishing of `v³ − a − bv` against itself;
- `pair_root`, `triple_sum`: two distinct values satisfy `x² + xy + y² = b`, three sum to zero, so
  at most three values occur;
- `two_value_bound`: with two values at multiplicities `p + q = n`, `b = n/(pq) − 3/n`, and
  `pq ≤ (n²−1)/4` at odd `n`;
- `three_value_bound`: with three, `b ≥ 1/(n−1)`, through `core3`, the sign lemma
  `k₁r₂r₃ + k₂r₁r₃ + k₃r₁r₂ ≤ 0` under `∑ kᵢrᵢ = 0 = ∑ rᵢ`, `k ≥ 0`;
- `fourth_moment_odd`: **`∑ v⁴ ≥ (n²+3)/(n(n²−1))` at odd `n ≥ 5`**.
-/

namespace HamiltonsCubic.FourthMoment

open Finset

/-- **The sign lemma** in the case `r₁r₂ ≥ 0`. -/
theorem core3 (k1 k2 k3 r1 r2 r3 : ℝ) (h1 : 0 ≤ k1) (h2 : 0 ≤ k2)
    (hs : r1 + r2 + r3 = 0) (hc : k1 * r1 + k2 * r2 + k3 * r3 = 0) (h12 : 0 ≤ r1 * r2) :
    k1 * r2 * r3 + k2 * r1 * r3 + k3 * r1 * r2 ≤ 0 := by
  have hr3 : r3 = -(r1 + r2) := by linarith
  subst hr3
  have hk3 : k3 * (r1 + r2) = k1 * r1 + k2 * r2 := by linarith
  have key : (k1 * r2 * -(r1 + r2) + k2 * r1 * -(r1 + r2) + k3 * r1 * r2) * (r1 + r2)
      = -(k1 * r2 ^ 2 * (2 * r1 + r2)) - k2 * r1 ^ 2 * (r1 + 2 * r2) := by
    have : k3 * r1 * r2 * (r1 + r2) = r1 * r2 * (k1 * r1 + k2 * r2) := by rw [← hk3]; ring
    linear_combination this
  rcases lt_trichotomy (r1 + r2) 0 with hneg | hz | hpos
  · have ha : r1 ≤ 0 := by nlinarith
    have hb : r2 ≤ 0 := by nlinarith
    have : 0 ≤ -(k1 * r2 ^ 2 * (2 * r1 + r2)) - k2 * r1 ^ 2 * (r1 + 2 * r2) := by
      have t1 : k1 * r2 ^ 2 * (2 * r1 + r2) ≤ 0 :=
        mul_nonpos_of_nonneg_of_nonpos (by positivity) (by linarith)
      have t2 : k2 * r1 ^ 2 * (r1 + 2 * r2) ≤ 0 :=
        mul_nonpos_of_nonneg_of_nonpos (by positivity) (by linarith)
      linarith
    rw [← key] at this
    exact nonpos_of_mul_nonneg_left this hneg |> fun h => by linarith [h]
  · have ha : r1 = 0 := by nlinarith
    have hb : r2 = 0 := by linarith
    subst ha; subst hb; simp
  · have ha : 0 ≤ r1 := by nlinarith
    have hb : 0 ≤ r2 := by nlinarith
    have : -(k1 * r2 ^ 2 * (2 * r1 + r2)) - k2 * r1 ^ 2 * (r1 + 2 * r2) ≤ 0 := by
      have t1 : 0 ≤ k1 * r2 ^ 2 * (2 * r1 + r2) := by positivity
      have t2 : 0 ≤ k2 * r1 ^ 2 * (r1 + 2 * r2) := by positivity
      linarith
    rw [← key] at this
    exact nonpos_of_mul_nonpos_left this hpos |> fun h => by linarith [h]

/-- **The sign lemma**: `k₁r₂r₃ + k₂r₁r₃ + k₃r₁r₂ ≤ 0` when `∑ kᵢrᵢ = 0 = ∑ rᵢ` and `k ≥ 0`. -/
theorem sign3 (k1 k2 k3 r1 r2 r3 : ℝ) (h1 : 0 ≤ k1) (h2 : 0 ≤ k2) (h3 : 0 ≤ k3)
    (hs : r1 + r2 + r3 = 0) (hc : k1 * r1 + k2 * r2 + k3 * r3 = 0) :
    k1 * r2 * r3 + k2 * r1 * r3 + k3 * r1 * r2 ≤ 0 := by
  by_cases h12 : 0 ≤ r1 * r2
  · exact core3 k1 k2 k3 r1 r2 r3 h1 h2 hs hc h12
  by_cases h13 : 0 ≤ r1 * r3
  · have := core3 k1 k3 k2 r1 r3 r2 h1 h3 (by linarith) (by linarith) h13
    linarith
  · have h23 : 0 ≤ r2 * r3 := by
      push Not at h12 h13
      nlinarith [mul_pos_of_neg_of_neg h12 h13, sq_nonneg r1]
    have := core3 k2 k3 k1 r2 r3 r1 h2 h3 (by linarith) (by linarith) h23
    linarith

/-- **The three-value bound**: values `r₁, r₂, r₃` summing to zero at multiplicities `mᵢ ≥ 1` with
`∑ mᵢrᵢ = 0` and `∑ mᵢrᵢ² = 1` have `(r₁² + r₂² + r₃²)/2 ≥ 1/(n−1)`, `n = ∑ mᵢ`. -/
theorem three_value_bound (m1 m2 m3 r1 r2 r3 : ℝ) (h1 : 1 ≤ m1) (h2 : 1 ≤ m2) (h3 : 1 ≤ m3)
    (hs : r1 + r2 + r3 = 0) (hc : m1 * r1 + m2 * r2 + m3 * r3 = 0)
    (hq : m1 * r1 ^ 2 + m2 * r2 ^ 2 + m3 * r3 ^ 2 = 1) :
    1 / (m1 + m2 + m3 - 1) ≤ (r1 ^ 2 + r2 ^ 2 + r3 ^ 2) / 2 := by
  have hsign := sign3 (m1 - 1) (m2 - 1) (m3 - 1) r1 r2 r3 (by linarith) (by linarith) (by linarith) hs
    (by linarith)
  have hr3 : r3 = -(r1 + r2) := by linarith
  -- `∑ mᵢrᵢ² ≤ (n−1)/2 ∑ rᵢ²`
  have key : 1 ≤ (m1 + m2 + m3 - 1) * ((r1 ^ 2 + r2 ^ 2 + r3 ^ 2) / 2) := by
    rw [← hq]; subst hr3; nlinarith [hsign]
  have hpos : 0 < m1 + m2 + m3 - 1 := by linarith
  rw [div_le_iff₀ hpos]; linarith

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The feasible set. -/
def Kset (ι : Type*) [Fintype ι] : Set (ι → ℝ) := {v | ∑ i, v i = 0 ∧ ∑ i, v i ^ 2 = 1}

/-- **A minimiser of `∑ v⁴` on `{∑ v = 0, ∑ v² = 1}` exists** once `n ≥ 2`. -/
theorem exists_min_moment (hn : 2 ≤ Fintype.card ι) :
    ∃ v ∈ Kset ι, ∀ u ∈ Kset ι, ∑ i, v i ^ 4 ≤ ∑ i, u i ^ 4 := by
  have hbox : Kset ι ⊆ Set.pi Set.univ (fun _ : ι => Set.Icc (-1 : ℝ) 1) := by
    intro u hu i _
    have h1 : u i ^ 2 ≤ 1 := by
      rw [← hu.2]
      exact Finset.single_le_sum (f := fun j => u j ^ 2) (fun j _ => sq_nonneg _) (Finset.mem_univ i)
    constructor <;> nlinarith [sq_nonneg (u i + 1), sq_nonneg (u i - 1)]
  have hcl : IsClosed (Kset ι) := by
    have e : Kset ι = {u : ι → ℝ | ∑ i, u i = 0} ∩ {u | ∑ i, u i ^ 2 = 1} := rfl
    rw [e]
    exact (isClosed_eq (continuous_finsetSum _ fun i _ => continuous_apply i) continuous_const).inter
      (isClosed_eq (continuous_finsetSum _ fun i _ => (continuous_apply i).pow 2) continuous_const)
  have hK : IsCompact (Kset ι) :=
    (isCompact_univ_pi fun _ => isCompact_Icc).of_isClosed_subset hcl hbox
  -- a point: `(e_i − e_j)/√2`
  obtain ⟨i, j, hij⟩ : ∃ i j : ι, i ≠ j := by
    have : 1 < Fintype.card ι := by omega
    exact Fintype.exists_pair_of_one_lt_card this
  set c := Real.sqrt (1 / 2) with hc
  have hc2 : c ^ 2 = 1 / 2 := Real.sq_sqrt (by norm_num)
  set w : ι → ℝ := fun k => if k = i then c else if k = j then -c else 0 with hw
  have hw1 : ∑ k, w k = 0 := by
    have : ∀ k, w k = (if k = i then c else 0) + (if k = j then -c else 0) := by
      intro k; simp only [hw]; split_ifs with h1 h2 <;> [exact absurd (h1.symm.trans h2) hij; simp; simp; simp]
    simp only [this, Finset.sum_add_distrib, Finset.sum_ite_eq', Finset.mem_univ, if_true]; ring
  have hw2 : ∑ k, w k ^ 2 = 1 := by
    have : ∀ k, w k ^ 2 = (if k = i then c ^ 2 else 0) + (if k = j then c ^ 2 else 0) := by
      intro k; simp only [hw]; split_ifs with h1 h2 <;> [exact absurd (h1.symm.trans h2) hij; simp; ring; simp]
    simp only [this, Finset.sum_add_distrib, Finset.sum_ite_eq', Finset.mem_univ, if_true, hc2]; norm_num
  have hcont : Continuous fun u : ι → ℝ => ∑ i, u i ^ 4 :=
    continuous_finsetSum _ fun i _ => (continuous_apply i).pow 4
  obtain ⟨v, hv, hmin⟩ := hK.exists_isMinOn ⟨w, hw1, hw2⟩ hcont.continuousOn
  exact ⟨v, hv, fun u hu => hmin hu⟩

/-- **At a minimiser `v³ = a + bv`**, with `b = ∑ v⁴`. -/
theorem min_cubic {v : ι → ℝ} (hv : v ∈ Kset ι) (hmin : ∀ u ∈ Kset ι, ∑ i, v i ^ 4 ≤ ∑ i, u i ^ 4) :
    ∀ i, v i ^ 3 = (∑ j, v j ^ 3) / Fintype.card ι + (∑ j, v j ^ 4) * v i := by
  obtain ⟨h1, h2⟩ := hv
  set m := ∑ j, v j ^ 4 with hm
  have hnpos : (0 : ℝ) < Fintype.card ι := by
    have : 0 < Fintype.card ι := Fintype.card_pos_iff.mpr ⟨(Classical.choice (by
      by_contra h; simp only [not_nonempty_iff] at h; simp at h2))⟩
    exact_mod_cast this
  -- homogeneity: `∑ u⁴ ≥ m (∑ u²)²` for every `u` with `∑ u = 0`
  have hhom : ∀ u : ι → ℝ, ∑ i, u i = 0 → 0 < ∑ i, u i ^ 2 → m * (∑ i, u i ^ 2) ^ 2 ≤ ∑ i, u i ^ 4 := by
    intro u hu0 hN
    set N := ∑ i, u i ^ 2
    set c := 1 / Real.sqrt N
    have hcpos : 0 < c := by positivity
    have hc2 : c ^ 2 = 1 / N := by rw [div_pow, Real.sq_sqrt hN.le]; ring
    have hmem : (fun i => c * u i) ∈ Kset ι := by
      refine ⟨by rw [← Finset.mul_sum, hu0, mul_zero], ?_⟩
      simp only [mul_pow, ← Finset.mul_sum, hc2]
      show 1 / N * N = 1
      field_simp
    have := hmin _ hmem
    simp only [mul_pow, ← Finset.mul_sum] at this
    have hc4 : c ^ 4 = 1 / N ^ 2 := by rw [show c ^ 4 = (c ^ 2) ^ 2 by ring, hc2]; ring
    rw [hc4, one_div, inv_mul_eq_div, le_div_iff₀ (by positivity)] at this
    linarith
  -- the first-order condition along `y` with `∑ y = 0 = ∑ v y`
  have hfo : ∀ y : ι → ℝ, ∑ i, y i = 0 → ∑ i, v i * y i = 0 → ∑ i, v i ^ 3 * y i = 0 := by
    intro y hy0 hyv
    set L := ∑ i, v i ^ 3 * y i
    set k := ∑ i, y i ^ 2
    have hk : 0 ≤ k := Finset.sum_nonneg fun i _ => sq_nonneg _
    set Q2 := ∑ i, v i ^ 2 * y i ^ 2
    set Q3 := ∑ i, v i * y i ^ 3
    set Q4 := ∑ i, y i ^ 4
    have hbound : ∀ t : ℝ, t ≠ 0 → |t| ≤ 1 → t * (-(4 * L)) ≤ t ^ 2 * (6 * |Q2| + 4 * |Q3| + |Q4|) := by
      intro t _ ht1
      have hN : ∑ i, (v i + t * y i) ^ 2 = 1 + t ^ 2 * k := by
        have e : ∀ i, (v i + t * y i) ^ 2 = v i ^ 2 + 2 * t * (v i * y i) + t ^ 2 * y i ^ 2 := fun i => by ring
        simp only [e, Finset.sum_add_distrib, ← Finset.mul_sum, h2, hyv]; ring
      have h0 : ∑ i, (v i + t * y i) = 0 := by
        rw [Finset.sum_add_distrib, ← Finset.mul_sum, h1, hy0]; ring
      have hF : ∑ i, (v i + t * y i) ^ 4 = m + 4 * t * L + 6 * t ^ 2 * Q2 + 4 * t ^ 3 * Q3 + t ^ 4 * Q4 := by
        have e : ∀ i, (v i + t * y i) ^ 4 = v i ^ 4 + 4 * t * (v i ^ 3 * y i) + 6 * t ^ 2 * (v i ^ 2 * y i ^ 2)
            + 4 * t ^ 3 * (v i * y i ^ 3) + t ^ 4 * y i ^ 4 := fun i => by ring
        simp only [e, Finset.sum_add_distrib, ← Finset.mul_sum]
        ring
      have hH := hhom _ h0 (by rw [hN]; positivity)
      rw [hN, hF] at hH
      have hm0 : 0 ≤ m := Finset.sum_nonneg fun i _ => by positivity
      have ht2 : t ^ 2 ≤ 1 := by nlinarith [abs_nonneg t, sq_abs t]
      have hmk : 0 ≤ m * (2 * t ^ 2 * k + t ^ 4 * k ^ 2) := by positivity
      have e2 : m * (1 + t ^ 2 * k) ^ 2 = m + m * (2 * t ^ 2 * k + t ^ 4 * k ^ 2) := by ring
      have hQ2 : 6 * t ^ 2 * Q2 ≤ t ^ 2 * (6 * |Q2|) := by nlinarith [le_abs_self Q2, sq_nonneg t]
      have hQ3 : 4 * t ^ 3 * Q3 ≤ t ^ 2 * (4 * |Q3|) := by
        have : |t ^ 3 * Q3| ≤ t ^ 2 * |Q3| := by
          rw [abs_mul, show t ^ 3 = t * t ^ 2 by ring, abs_mul, abs_of_nonneg (sq_nonneg t)]
          have := mul_le_mul_of_nonneg_right ht1 (mul_nonneg (sq_nonneg t) (abs_nonneg Q3))
          nlinarith [abs_nonneg Q3]
        nlinarith [le_abs_self (t ^ 3 * Q3)]
      have hQ4 : t ^ 4 * Q4 ≤ t ^ 2 * |Q4| := by
        have h4 : 0 ≤ t ^ 4 := by positivity
        have h44 : t ^ 4 ≤ t ^ 2 := by nlinarith [sq_nonneg t]
        have : t ^ 4 * Q4 ≤ t ^ 4 * |Q4| := mul_le_mul_of_nonneg_left (le_abs_self Q4) h4
        nlinarith [abs_nonneg Q4]
      nlinarith
    have := HamiltonsCubic.L57Critical.lin_zero (-(4 * L)) _ (by positivity) hbound
    linarith
  -- `z = v³ − a − b v` is itself admissible, so it vanishes
  set a := (∑ j, v j ^ 3) / Fintype.card ι
  set z : ι → ℝ := fun i => v i ^ 3 - a - m * v i with hz
  have hz0 : ∑ i, z i = 0 := by
    simp only [hz, Finset.sum_sub_distrib, Finset.sum_const, Finset.card_univ, nsmul_eq_mul,
      ← Finset.mul_sum, h1, mul_zero, sub_zero]
    have ha : (Fintype.card ι : ℝ) * a = ∑ j, v j ^ 3 := by
      show (Fintype.card ι : ℝ) * ((∑ j, v j ^ 3) / Fintype.card ι) = _
      field_simp
    linarith
  have hzv : ∑ i, v i * z i = 0 := by
    have e : ∀ i, v i * z i = v i ^ 4 - a * v i - m * v i ^ 2 := fun i => by simp only [hz]; ring
    simp only [e, Finset.sum_sub_distrib, ← Finset.mul_sum, h1, h2, hm]; ring
  have hzz : ∑ i, z i ^ 2 = 0 := by
    have e : ∀ i, z i ^ 2 = v i ^ 3 * z i - a * z i - m * (v i * z i) := fun i => by simp only [hz]; ring
    simp only [e, Finset.sum_sub_distrib, ← Finset.mul_sum, hfo z hz0 hzv, hz0, hzv]; ring
  intro i
  have hnn : ∀ j ∈ (Finset.univ : Finset ι), 0 ≤ z j ^ 2 := fun j _ => sq_nonneg _
  have := (Finset.sum_eq_zero_iff_of_nonneg hnn).mp hzz i (Finset.mem_univ i)
  have := pow_eq_zero_iff (n := 2) (by norm_num) |>.mp this
  simp only [hz] at this
  linarith

/-- Two distinct roots of `t³ = a + bt` satisfy `x² + xy + y² = b`. -/
theorem pair_root {a b x y : ℝ} (hx : x ^ 3 = a + b * x) (hy : y ^ 3 = a + b * y) (hxy : x ≠ y) :
    x ^ 2 + x * y + y ^ 2 = b := by
  have h : (x - y) * (x ^ 2 + x * y + y ^ 2 - b) = 0 := by linear_combination hx - hy
  rcases mul_eq_zero.mp h with h | h
  · exact absurd (sub_eq_zero.mp h) hxy
  · linarith

/-- Three distinct roots of `t³ = a + bt` sum to zero. -/
theorem triple_sum {a b x y z : ℝ} (hx : x ^ 3 = a + b * x) (hy : y ^ 3 = a + b * y)
    (hz : z ^ 3 = a + b * z) (hxy : x ≠ y) (hxz : x ≠ z) (hyz : y ≠ z) : x + y + z = 0 := by
  have h1 := pair_root hx hy hxy
  have h2 := pair_root hx hz hxz
  have h : (y - z) * (x + y + z) = 0 := by linear_combination h1 - h2
  rcases mul_eq_zero.mp h with h | h
  · exact absurd (sub_eq_zero.mp h) hyz
  · exact h

omit [DecidableEq ι] in
/-- A count of the indices at a value, as a real. -/
theorem count_eq (v : ι → ℝ) (x : ℝ) :
    ∑ i, (if v i = x then (1 : ℝ) else 0) = ((Finset.univ.filter fun i => v i = x).card : ℝ) := by
  rw [Finset.sum_boole]

omit [DecidableEq ι] in
theorem count_pos (v : ι → ℝ) (i : ι) :
    1 ≤ ∑ j, (if v j = v i then (1 : ℝ) else 0) := by
  have := Finset.single_le_sum (f := fun j => if v j = v i then (1 : ℝ) else 0)
    (fun j _ => by split_ifs <;> norm_num) (Finset.mem_univ i)
  simpa using this

/-- **The odd target** `(n²+3)/(n(n²−1))`. -/
noncomputable def gOdd (n : ℝ) : ℝ := (n ^ 2 + 3) / (n * (n ^ 2 - 1))

/-- **THE FOURTH-MOMENT LEMMA AT ODD `n`**: `∑ v⁴ ≥ (n²+3)/(n(n²−1))` on `{∑ v = 0, ∑ v² = 1}`. -/
theorem fourth_moment_odd (hn : 3 ≤ Fintype.card ι) (hodd : ¬ Even (Fintype.card ι))
    (u : ι → ℝ) (hu1 : ∑ i, u i = 0) (hu2 : ∑ i, u i ^ 2 = 1) :
    gOdd (Fintype.card ι : ℝ) ≤ ∑ i, u i ^ 4 := by
  obtain ⟨v, hv, hmin⟩ := exists_min_moment (ι := ι) (by omega)
  refine le_trans ?_ (hmin u ⟨hu1, hu2⟩)
  have hcub := min_cubic hv hmin
  obtain ⟨h1, h2⟩ := hv
  set n : ℝ := (Fintype.card ι : ℝ) with hndef
  set b := ∑ j, v j ^ 4 with hb
  set a := (∑ j, v j ^ 3) / n with ha
  have hn3 : (3 : ℝ) ≤ n := by rw [hndef]; exact_mod_cast hn
  have hne : Nonempty ι := Fintype.card_pos_iff.mp (by omega)
  obtain ⟨i0⟩ := hne
  set x := v i0 with hxdef
  -- a second value exists
  obtain ⟨j, hj⟩ : ∃ j, v j ≠ x := by
    by_contra h
    push Not at h
    have : ∑ i, v i = n * x := by
      simp only [h, Finset.sum_const, Finset.card_univ, nsmul_eq_mul]; try rfl
    have hx0 : x = 0 := by rw [h1] at this; nlinarith
    have : ∑ i, v i ^ 2 = 0 := by simp only [h, hx0]; simp
    linarith
  set y := v j with hydef
  have hxy : x ≠ y := fun e => hj e.symm
  have hbxy := pair_root (hcub i0) (hcub j) hxy
  have hnpos : 0 < n := by linarith
  have hgle : gOdd n ≤ 1 / (n - 1) := by
    unfold gOdd
    rw [div_le_div_iff₀ (by nlinarith) (by linarith)]
    nlinarith
  by_cases hthree : ∃ k, v k ≠ x ∧ v k ≠ y
  · obtain ⟨k, hkx, hky⟩ := hthree
    set z := v k with hzdef
    have hxz : x ≠ z := fun e => hkx e.symm
    have hyz : y ≠ z := fun e => hky e.symm
    have hsum0 := triple_sum (hcub i0) (hcub j) (hcub k) hxy hxz hyz
    have hvals : ∀ i, v i = x ∨ v i = y ∨ v i = z := by
      intro i
      by_contra hc
      push Not at hc
      obtain ⟨h1', h2', h3'⟩ := hc
      have := triple_sum (hcub i0) (hcub j) (hcub i) hxy (Ne.symm h1') (Ne.symm h2')
      exact h3' (by linarith)
    set c1 := ∑ i, (if v i = x then (1 : ℝ) else 0)
    set c2 := ∑ i, (if v i = y then (1 : ℝ) else 0)
    set c3 := ∑ i, (if v i = z then (1 : ℝ) else 0)
    have hsplit : ∀ f : ℝ → ℝ, ∑ i, f (v i) = c1 * f x + c2 * f y + c3 * f z := by
      intro f
      have e : ∀ i, f (v i) = (if v i = x then (1 : ℝ) else 0) * f x + (if v i = y then (1 : ℝ) else 0) * f y
          + (if v i = z then (1 : ℝ) else 0) * f z := by
        intro i
        rcases hvals i with h | h | h
        · rw [if_pos h, if_neg (h ▸ hxy), if_neg (h ▸ hxz), h]; ring
        · rw [if_neg (fun e => hxy (h ▸ e).symm), if_pos h, if_neg (h ▸ hyz), h]; ring
        · rw [if_neg (fun e => hxz (h ▸ e).symm), if_neg (fun e => hyz (h ▸ e).symm), if_pos h, h]; ring
      simp only [e, Finset.sum_add_distrib, ← Finset.sum_mul]
      try rfl
    have hc1 : 1 ≤ c1 := count_pos v i0
    have hc2 : 1 ≤ c2 := count_pos v j
    have hc3 : 1 ≤ c3 := count_pos v k
    have hn : c1 + c2 + c3 = n := by
      have := hsplit (fun _ => 1)
      simp only [Finset.sum_const, Finset.card_univ, nsmul_eq_mul, mul_one] at this
      linarith
    have hs1 : c1 * x + c2 * y + c3 * z = 0 := by rw [← h1, hsplit (fun t => t)]
    have hs2 : c1 * x ^ 2 + c2 * y ^ 2 + c3 * z ^ 2 = 1 := by rw [← h2, hsplit (fun t => t ^ 2)]
    have h3v := three_value_bound c1 c2 c3 x y z hc1 hc2 hc3 hsum0 hs1 hs2
    rw [hn] at h3v
    have hbz : b = (x ^ 2 + y ^ 2 + z ^ 2) / 2 := by
      have hz : z = -(x + y) := by linarith
      rw [← hbxy, hz]; ring
    rw [← hbz] at h3v
    linarith
  · push Not at hthree
    have hvals : ∀ i, v i = x ∨ v i = y := by
      intro i; by_cases h : v i = x
      · exact Or.inl h
      · exact Or.inr (hthree i h)
    set p := (Finset.univ.filter fun i => v i = x).card with hp
    set q := (Finset.univ.filter fun i => v i = y).card with hq
    have hsplit : ∀ f : ℝ → ℝ, ∑ i, f (v i) = (p : ℝ) * f x + (q : ℝ) * f y := by
      intro f
      have e : ∀ i, f (v i) = (if v i = x then (1 : ℝ) else 0) * f x + (if v i = y then (1 : ℝ) else 0) * f y := by
        intro i
        rcases hvals i with h | h
        · rw [if_pos h, if_neg (h ▸ hxy), h]; ring
        · rw [if_neg (fun e => hxy (h ▸ e).symm), if_pos h, h]; ring
      simp only [e, Finset.sum_add_distrib, ← Finset.sum_mul, count_eq]
      try rfl
    have hpq : (p : ℝ) + q = n := by
      have := hsplit (fun _ => 1)
      simp only [Finset.sum_const, Finset.card_univ, nsmul_eq_mul, mul_one] at this
      linarith
    have hpqN : p + q = Fintype.card ι := by
      have : ((p + q : ℕ) : ℝ) = (Fintype.card ι : ℝ) := by push_cast; rw [hpq]
      exact_mod_cast this
    have hp1 : (1 : ℝ) ≤ p := by rw [← count_eq]; exact count_pos v i0
    have hq1 : (1 : ℝ) ≤ q := by rw [← count_eq]; exact count_pos v j
    have hs1 : (p : ℝ) * x + q * y = 0 := by rw [← h1, hsplit (fun t => t)]
    have hs2 : (p : ℝ) * x ^ 2 + q * y ^ 2 = 1 := by rw [← h2, hsplit (fun t => t ^ 2)]
    -- `xy = −1/n`, `x² = q/(np)`, `y² = p/(nq)`
    have hxy1 : n * (x * y) = -1 := by
      have e1 : (p : ℝ) * x ^ 2 = -(q * (x * y)) := by linear_combination x * hs1
      have e2 : (q : ℝ) * y ^ 2 = -(p * (x * y)) := by linear_combination y * hs1
      rw [← hpq]; linear_combination -hs2 + e1 + e2
    have hx2 : (p : ℝ) * n * x ^ 2 = q := by
      have e1 : (p : ℝ) * x ^ 2 = -(q * (x * y)) := by linear_combination x * hs1
      linear_combination n * e1 - q * hxy1
    have hy2 : (q : ℝ) * n * y ^ 2 = p := by
      have e2 : (q : ℝ) * y ^ 2 = -(p * (x * y)) := by linear_combination y * hs1
      linear_combination n * e2 - p * hxy1
    -- `pq ≤ (n²−1)/4` since `p ≠ q` at odd `n`
    have hpne : p ≠ q := by
      intro e; apply hodd
      have : Fintype.card ι = q + q := by omega
      rw [this]; exact ⟨q, rfl⟩
    have hdiff : (1 : ℝ) ≤ ((p : ℝ) - q) ^ 2 := by
      rcases lt_or_gt_of_ne hpne with h | h
      · have : (p : ℝ) + 1 ≤ q := by exact_mod_cast h
        nlinarith
      · have : (q : ℝ) + 1 ≤ p := by exact_mod_cast h
        nlinarith
    -- assemble: `b n p q = q² + p² − pq`
    have hpos : 0 < (p : ℝ) * q * n := mul_pos (mul_pos (by linarith) (by linarith)) hnpos
    have hbpq : b * ((p : ℝ) * q * n) = (q : ℝ) ^ 2 + (p : ℝ) ^ 2 - p * q := by
      rw [← hbxy]
      have : (x ^ 2 + x * y + y ^ 2) * ((p : ℝ) * q * n)
          = (q : ℝ) * ((p : ℝ) * n * x ^ 2) + (p : ℝ) * ((q : ℝ) * n * y ^ 2) + (p : ℝ) * q * (n * (x * y)) := by
        ring
      rw [this, hx2, hy2, hxy1]; ring
    have hn2 : n ^ 2 = ((p : ℝ) + q) ^ 2 := by rw [hpq]
    have hsq : (q : ℝ) ^ 2 + (p : ℝ) ^ 2 - p * q = n ^ 2 - 3 * (p * q) := by rw [hn2]; ring
    have h4 : 4 * ((p : ℝ) * q) ≤ n ^ 2 - 1 := by rw [hn2]; nlinarith
    have hineq : (n ^ 2 + 3) * ((p : ℝ) * q) ≤ (n ^ 2 - 1) * (n ^ 2 - 3 * (p * q)) := by nlinarith
    have hpq0 : 0 < (p : ℝ) * q := mul_pos (by linarith) (by linarith)
    have hmain : (n ^ 2 + 3) * ((p : ℝ) * q) ≤ b * (n * (n ^ 2 - 1)) * ((p : ℝ) * q) := by
      have e : b * (n * (n ^ 2 - 1)) * ((p : ℝ) * q) = (n ^ 2 - 1) * (b * ((p : ℝ) * q * n)) := by ring
      rw [e, hbpq, hsq]; exact hineq
    have hfin : n ^ 2 + 3 ≤ b * (n * (n ^ 2 - 1)) := le_of_mul_le_mul_right hmain hpq0
    have hn21 : 1 < n ^ 2 := one_lt_pow₀ (by linarith) two_ne_zero
    have hden : 0 < n * (n ^ 2 - 1) := mul_pos hnpos (sub_pos.mpr hn21)
    unfold gOdd
    rw [div_le_iff₀ hden]
    exact hfin

end HamiltonsCubic.FourthMoment
