import HamiltonsCubic.Results.L127Spec

set_option linter.style.longLine false

/-!
# L127's within-factor row: every eigenvalue is `0`, the record's top, or a negative value

[findings/second-order.md](../../../findings/second-order.md), Lemma L127's table: *"pair, within-factor, `C(p,2)` and
`C(q,2)`, top `L_e`-eigenvalue `(p−2)/(2(p−1))` and `(q−2)/(2(q−1))` respectively, both `< ½`, at `p, q ≥ 3`"*. At a
sphere product `M = diagOp(t · sphereWeight T)`, `j, k ∈ T`, on the Ricci cut of the pair span:

* **`within_coeff_in`**, **`within_coeff_out`**: the coefficient of `M ∘ ∑ c_i f_i` is `½(α + t) C_T` at `q ∈ T` and
  `½((−2t − α − β) c_q + (t + β) C_{Tᶜ})` at `q ∉ T`;
* **`pair_coeff`**: that coefficient, read off at `φ_jq`, for any symmetric hollow weight;
* **`within_spectrum`**: so every eigenvalue is `0`, `½(α + t)(p − 2)` or `−½(2t + α + β)`. With
  `α + t = t(n − 1)/(p − 1)` ([L127Cross.lean](L127Cross.lean)'s `cross_kappa`) the middle value is
  `t(n − 1)(p − 2)/(2(p − 1))`, the record's top in `L_e` units at `θ = t(n − 1)`, and it is `0` at `p = 2`, the defect
  [L127.lean](L127.lean) records. The third is `−μ_{p,q} θ`;
* **`sphereWeight_compl`**, **`within_spectrum_out`**: the second family, `j, k ∉ T`, by exchanging the factors;
* **`within_bounds`**: at `t > 0` the top is below `t(n − 1)/2` (below `½` in `L_e` units) and the third value is
  negative;
* **`withinPair`**, **`within_top_exists`**, **`within_top_ne_zero`**: the block as coefficients, and at `p ≥ 3` an
  explicit nonzero Ricci-cut vector carrying the top;
* **`within_bounds_out`**, **`within_top_exists_out`**, **`within_top_ne_zero_out`**: the second family's top is below
  `½` too, and occurs at `q ≥ 3` on a nonzero vector. The multiplicities and the division by `θ` are prose.
-/

namespace HamiltonsCubic.L121Block

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **Within-factor coefficient, first factor**: `j, k, q ∈ T`, on the Ricci cut, the `q` coefficient is
`½(α + t) C_T`. -/
theorem within_coeff_in (T : Finset ι) (t : ℝ) {j k : ι} (hj : j ∈ T) (hk : k ∈ T) (hjk : j ≠ k) (s : Finset ι)
    (hs : ∀ i ∈ s, j ≠ i ∧ k ≠ i) (c : ι → ℝ) (hsum : ∑ i ∈ s, c i = 0) {q : ι} (hq : q ∈ s) (hqT : q ∈ T) :
    let w := t • sphereWeight T
    (1 / 2 : ℝ) * ((w j q + w k q - w j k) * c q) + ∑ i ∈ s, c i * ((1 / 2 : ℝ) * w i q)
      = (1 / 2 : ℝ) * (t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1)) + t) * ∑ i ∈ s.filter (· ∈ T), c i := by
  intro w
  obtain ⟨hjq, hkq⟩ := hs q hq
  set α := t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1))
  have ewjq : w j q = α := by simp only [w, Matrix.smul_apply, smul_eq_mul, sphereWeight_in T hj hqT hjq, α]
  have ewkq : w k q = α := by simp only [w, Matrix.smul_apply, smul_eq_mul, sphereWeight_in T hk hqT hkq, α]
  have ewjk : w j k = α := by simp only [w, Matrix.smul_apply, smul_eq_mul, sphereWeight_in T hj hk hjk, α]
  have hin : ∀ i ∈ s.filter (· ∈ T), c i * ((1 / 2 : ℝ) * w i q) = (1 / 2 : ℝ) * α * c i - (if i = q then (1 / 2 : ℝ) * α * c q else 0) := by
    intro i hi
    have hiT := (Finset.mem_filter.mp hi).2
    by_cases hiq : i = q
    · subst hiq; simp [w, sphereWeight]
    · simp only [if_neg hiq, w, Matrix.smul_apply, smul_eq_mul, sphereWeight_in T hiT hqT hiq, α]; ring
  have hout : ∀ i ∈ s.filter (· ∉ T), c i * ((1 / 2 : ℝ) * w i q) = -((1 / 2 : ℝ) * t * c i) := by
    intro i hi
    have hiT := (Finset.mem_filter.mp hi).2
    simp only [w, Matrix.smul_apply, smul_eq_mul]
    rw [sphereWeight_symm, sphereWeight_cross T hqT hiT]; ring
  have hqs : q ∈ s.filter (· ∈ T) := Finset.mem_filter.mpr ⟨hq, hqT⟩
  rw [sum_split_T T s, Finset.sum_congr rfl hin, Finset.sum_congr rfl hout, Finset.sum_sub_distrib,
    Finset.sum_ite_eq' _ q, if_pos hqs, Finset.sum_neg_distrib, ← Finset.mul_sum, ← Finset.mul_sum]
  have hB : ∑ i ∈ s.filter (· ∉ T), c i = -∑ i ∈ s.filter (· ∈ T), c i := by
    have := sum_split_T T s c; rw [hsum] at this; linarith
  rw [hB, ewjq, ewkq, ewjk]
  ring

/-- **Within-factor coefficient, second factor**: at `q ∉ T` the coefficient is
`½((−2t − α − β) c_q + (t + β) C_{Tᶜ})`. -/
theorem within_coeff_out (T : Finset ι) (t : ℝ) {j k : ι} (hj : j ∈ T) (hk : k ∈ T) (hjk : j ≠ k) (s : Finset ι)
    (_hs : ∀ i ∈ s, j ≠ i ∧ k ≠ i) (c : ι → ℝ) (hsum : ∑ i ∈ s, c i = 0) {q : ι} (hq : q ∈ s) (hqT : q ∉ T) :
    let w := t • sphereWeight T
    (1 / 2 : ℝ) * ((w j q + w k q - w j k) * c q) + ∑ i ∈ s, c i * ((1 / 2 : ℝ) * w i q)
      = (1 / 2 : ℝ) * ((-2 * t - t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1)) - t * ((T.card : ℝ) / ((Tᶜ.card : ℝ) - 1))) * c q
          + (t + t * ((T.card : ℝ) / ((Tᶜ.card : ℝ) - 1))) * ∑ i ∈ s.filter (· ∉ T), c i) := by
  intro w
  set α := t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1))
  set β := t * ((T.card : ℝ) / ((Tᶜ.card : ℝ) - 1))
  have ewjq : w j q = -t := by simp only [w, Matrix.smul_apply, smul_eq_mul, sphereWeight_cross T hj hqT]; ring
  have ewkq : w k q = -t := by simp only [w, Matrix.smul_apply, smul_eq_mul, sphereWeight_cross T hk hqT]; ring
  have ewjk : w j k = α := by simp only [w, Matrix.smul_apply, smul_eq_mul, sphereWeight_in T hj hk hjk, α]
  have hout : ∀ i ∈ s.filter (· ∉ T), c i * ((1 / 2 : ℝ) * w i q) = (1 / 2 : ℝ) * β * c i - (if i = q then (1 / 2 : ℝ) * β * c q else 0) := by
    intro i hi
    have hiT := (Finset.mem_filter.mp hi).2
    by_cases hiq : i = q
    · subst hiq; simp [w, sphereWeight]
    · simp only [if_neg hiq, w, Matrix.smul_apply, smul_eq_mul, sphereWeight_out T hiT hqT hiq, β]; ring
  have hin : ∀ i ∈ s.filter (· ∈ T), c i * ((1 / 2 : ℝ) * w i q) = -((1 / 2 : ℝ) * t * c i) := by
    intro i hi
    have hiT := (Finset.mem_filter.mp hi).2
    simp only [w, Matrix.smul_apply, smul_eq_mul, sphereWeight_cross T hiT hqT]; ring
  have hqs : q ∈ s.filter (· ∉ T) := Finset.mem_filter.mpr ⟨hq, hqT⟩
  rw [sum_split_T T s, Finset.sum_congr rfl hin, Finset.sum_congr rfl hout, Finset.sum_sub_distrib,
    Finset.sum_ite_eq' _ q, if_pos hqs, Finset.sum_neg_distrib, ← Finset.mul_sum, ← Finset.mul_sum]
  have hA : ∑ i ∈ s.filter (· ∈ T), c i = -∑ i ∈ s.filter (· ∉ T), c i := by
    have := sum_split_T T s c; rw [hsum] at this; linarith
  rw [hA, ewjq, ewkq, ewjk]
  ring

/-- **The coefficient of `M ∘ ∑ c_i f_i` at `q`, read off at `φ_jq`.** -/
theorem pair_coeff (w : Matrix ι ι ℝ) (hw : ∀ p q, w p q = w q p) (hh : ∀ a, w a a = 0) {j k : ι} (hjk : j ≠ k)
    (c : ι → ℝ) {q : ι} (hq : q ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i)) :
    foxProd (diagOp w) (fun Y => ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i • rk2 (phi j i) (phi k i) Y)
        (phi j q)
      = ((1 / 2 : ℝ) * ((w j q + w k q - w j k) * c q)
          + ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i * ((1 / 2 : ℝ) * w i q)) • phi k q := by
  set s := univ.filter (fun i => j ≠ i ∧ k ≠ i)
  have hs : ∀ i ∈ s, j ≠ i ∧ k ≠ i := fun i hi => (Finset.mem_filter.mp hi).2
  rw [pair_invariant w hw hh hjk s hs c (phi_isSkew j q)]
  have inner : ∀ i, ∑ q', w i q' • rk2 (phi j q') (phi k q') (phi j q) = w i q • phi k q := fun i => by
    rw [pairSum_restrict hjk (w i), pair_eval hjk s hs (w i) hq]
  have single : ∀ i ∈ s, rk2 (phi j i) (phi k i) (phi j q) = if i = q then phi k q else 0 := fun i hi => by
    have := pair_eval hjk s hs (fun i' => if i' = i then 1 else 0) hq
    simp only [ite_smul, one_smul, zero_smul, Finset.sum_ite_eq', if_pos hi] at this
    rw [this]; by_cases h : i = q
    · subst h; simp
    · simp [Ne.symm h, h]
  simp only [inner, smul_add]
  rw [Finset.sum_add_distrib]
  rw [Finset.sum_congr rfl fun i hi => by rw [single i hi]]
  simp only [smul_ite, smul_zero, Finset.sum_ite_eq', if_pos hq, smul_smul, ← Finset.sum_smul, ← add_smul]
  congr 1
  ring

theorem within_filter_in (T : Finset ι) {j k : ι} :
    (univ.filter (fun i => j ≠ i ∧ k ≠ i)).filter (· ∈ T) = (T.erase j).erase k := by
  ext i
  simp only [Finset.mem_filter, Finset.mem_univ, true_and, Finset.mem_erase]
  constructor
  · rintro ⟨⟨h1, h2⟩, h3⟩; exact ⟨Ne.symm h2, Ne.symm h1, h3⟩
  · rintro ⟨h2, h1, h3⟩; exact ⟨⟨Ne.symm h1, Ne.symm h2⟩, h3⟩

/-- **THE WITHIN-FACTOR SPECTRUM**: at a sphere product, `j, k ∈ T`, every eigenvalue of `M ∘` on a nonzero Ricci-cut
vector of the pair span is `0`, `½(α + t)(p − 2)` or `−½(2t + α + β)`. The first nonzero value is
`t(n − 1)(p − 2)/(2(p − 1))`, the record's top `(p − 2)/(2(p − 1))` in `L_e` units, and the other is negative at
`t > 0` (`within_bounds`). -/
theorem within_spectrum (T : Finset ι) (hp : 2 ≤ T.card) (t : ℝ) {j k : ι} (hj : j ∈ T) (hk : k ∈ T) (hjk : j ≠ k)
    (c : ι → ℝ) (hsum : ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i = 0)
    (hne : ∃ q ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c q ≠ 0) (lam : ℝ)
    (heig : ∀ X : Matrix ι ι ℝ, IsSkew X →
      foxProd (diagOp (t • sphereWeight T)) (fun Y => ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i),
          c i • rk2 (phi j i) (phi k i) Y) X
        = lam • ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i • rk2 (phi j i) (phi k i) X) :
    lam = 0 ∨ lam = (1 / 2 : ℝ) * (t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1)) + t) * ((T.card : ℝ) - 2)
      ∨ lam = (1 / 2 : ℝ) * (-2 * t - t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1)) - t * ((T.card : ℝ) / ((Tᶜ.card : ℝ) - 1))) := by
  set s := univ.filter (fun i => j ≠ i ∧ k ≠ i) with hsdef
  have hs : ∀ i ∈ s, j ≠ i ∧ k ≠ i := fun i hi => (Finset.mem_filter.mp hi).2
  set w := t • sphereWeight T
  have hw : ∀ p q, w p q = w q p := fun p q => by simp only [w, Matrix.smul_apply, sphereWeight_symm]
  have hh : ∀ a, w a a = 0 := fun a => by simp [w, sphereWeight]
  -- the eigen-equation, coefficient by coefficient
  have key : ∀ q ∈ s, lam * c q
      = (1 / 2 : ℝ) * ((w j q + w k q - w j k) * c q) + ∑ i ∈ s, c i * ((1 / 2 : ℝ) * w i q) := by
    intro q hq
    have e := heig (phi j q) (phi_isSkew j q)
    rw [pair_coeff w hw hh hjk c hq, pair_eval hjk s hs c hq, smul_smul] at e
    have e2 := congrArg (fun A : Matrix ι ι ℝ => A q k) e
    change (_ • phi k q) q k = (_ • phi k q) q k at e2
    rw [phi_entry' (hs q hq).2, phi_entry' (hs q hq).2] at e2
    linarith
  set CA := ∑ i ∈ s.filter (· ∈ T), c i
  set CB := ∑ i ∈ s.filter (· ∉ T), c i
  set top := (1 / 2 : ℝ) * (t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1)) + t)
  have kA : ∀ q ∈ s.filter (· ∈ T), lam * c q = top * CA := fun q hq => by
    rw [key q (Finset.mem_filter.mp hq).1]
    exact within_coeff_in T t hj hk hjk s hs c hsum (Finset.mem_filter.mp hq).1 (Finset.mem_filter.mp hq).2
  have cardA : ((s.filter (· ∈ T)).card : ℝ) = (T.card : ℝ) - 2 := by
    rw [hsdef, within_filter_in T, Finset.card_erase_of_mem (Finset.mem_erase.mpr ⟨Ne.symm hjk, hk⟩),
      Finset.card_erase_of_mem hj]
    rw [Nat.cast_sub (by have := Finset.card_erase_of_mem hj (s := T); omega), Nat.cast_sub (by omega)]
    push_cast; ring
  have sA : lam * CA = top * CA * ((T.card : ℝ) - 2) := by
    have : ∑ q ∈ s.filter (· ∈ T), lam * c q = ∑ q ∈ s.filter (· ∈ T), top * CA := Finset.sum_congr rfl kA
    rw [Finset.sum_const, nsmul_eq_mul, cardA, ← Finset.mul_sum] at this; linarith
  by_cases hl : lam = top * ((T.card : ℝ) - 2)
  · exact Or.inr (Or.inl hl)
  · have hCA : CA = 0 := by
      have : (lam - top * ((T.card : ℝ) - 2)) * CA = 0 := by linarith
      exact (mul_eq_zero.mp this).resolve_left (sub_ne_zero.mpr hl)
    have hCB : CB = 0 := by
      have h := sum_split_T T s c; rw [hsum] at h; change 0 = CA + CB at h; linarith
    obtain ⟨q, hq, hcq⟩ := hne
    by_cases hqT : q ∈ T
    · left
      have h := kA q (Finset.mem_filter.mpr ⟨hq, hqT⟩)
      rw [hCA, mul_zero] at h
      exact (mul_eq_zero.mp h).resolve_right hcq
    · right; right
      have h := key q hq
      rw [within_coeff_out T t hj hk hjk s hs c hsum hq hqT] at h
      change lam * c q = _ at h
      rw [show ∑ i ∈ s.filter (· ∉ T), c i = CB from rfl, hCB, mul_zero, add_zero] at h
      have : (lam - (1 / 2 : ℝ) * (-2 * t - t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1))
          - t * ((T.card : ℝ) / ((Tᶜ.card : ℝ) - 1)))) * c q = 0 := by linarith
      exact sub_eq_zero.mp ((mul_eq_zero.mp this).resolve_right hcq)

/-- **`sphereWeight` is symmetric in the two factors**: `sphereWeight Tᶜ = sphereWeight T`. -/
theorem sphereWeight_compl (T : Finset ι) : sphereWeight Tᶜ = sphereWeight T := by
  ext a b
  unfold sphereWeight
  simp only [Matrix.of_apply, Finset.mem_compl, compl_compl]
  by_cases hab : a = b
  · simp [hab]
  · by_cases ha : a ∈ T <;> by_cases hb : b ∈ T <;> simp [hab, ha, hb]

/-- **The second within-factor family**: at `j, k ∉ T` the same spectrum holds with the factors exchanged, every
eigenvalue on a nonzero Ricci-cut vector being `0`, `½(β + t)(q − 2)` or `−½(2t + α + β)`. -/
theorem within_spectrum_out (T : Finset ι) (hq : 2 ≤ Tᶜ.card) (t : ℝ) {j k : ι} (hj : j ∉ T) (hk : k ∉ T)
    (hjk : j ≠ k) (c : ι → ℝ) (hsum : ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i = 0)
    (hne : ∃ q ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c q ≠ 0) (lam : ℝ)
    (heig : ∀ X : Matrix ι ι ℝ, IsSkew X →
      foxProd (diagOp (t • sphereWeight T)) (fun Y => ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i),
          c i • rk2 (phi j i) (phi k i) Y) X
        = lam • ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i • rk2 (phi j i) (phi k i) X) :
    lam = 0 ∨ lam = (1 / 2 : ℝ) * (t * ((T.card : ℝ) / ((Tᶜ.card : ℝ) - 1)) + t) * ((Tᶜ.card : ℝ) - 2)
      ∨ lam = (1 / 2 : ℝ) * (-2 * t - t * ((T.card : ℝ) / ((Tᶜ.card : ℝ) - 1)) - t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1))) := by
  have h := within_spectrum Tᶜ hq t (Finset.mem_compl.mpr hj) (Finset.mem_compl.mpr hk) hjk c hsum hne lam
    (by rw [sphereWeight_compl]; exact heig)
  simpa only [compl_compl] using h

/-- **The within-factor values against `½`**: at `t > 0` and `p, q ≥ 2`, the top `½(α + t)(p − 2)` is below
`t(n − 1)/2`, the critical multiplier halved (so below `½` in `L_e` units at `θ = t(n − 1)`), and the third value
`−½(2t + α + β)` is negative. -/
theorem within_bounds (T : Finset ι) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t) :
    (1 / 2 : ℝ) * (t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1)) + t) * ((T.card : ℝ) - 2)
        < t * ((T.card : ℝ) + Tᶜ.card - 1) / 2
      ∧ (1 / 2 : ℝ) * (-2 * t - t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1)) - t * ((T.card : ℝ) / ((Tᶜ.card : ℝ) - 1))) < 0 := by
  have hpR : (2 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  have hqR : (2 : ℝ) ≤ (Tᶜ.card : ℝ) := by exact_mod_cast hq
  have hp1 : 0 < (T.card : ℝ) - 1 := by linarith
  have hq1 : 0 < (Tᶜ.card : ℝ) - 1 := by linarith
  have hα : 0 < t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1)) := mul_pos ht (div_pos (by linarith) hp1)
  have hβ : 0 < t * ((T.card : ℝ) / ((Tᶜ.card : ℝ) - 1)) := mul_pos ht (div_pos (by linarith) hq1)
  refine ⟨?_, by linarith⟩
  obtain ⟨kT, -⟩ := cross_kappa T hp hq t
  rw [kT]
  rw [show t * ((T.card : ℝ) + Tᶜ.card - 1) / ((T.card : ℝ) - 1) = t * ((T.card : ℝ) + Tᶜ.card - 1) * (1 / ((T.card : ℝ) - 1)) by ring]
  have hn : 0 < t * ((T.card : ℝ) + Tᶜ.card - 1) := mul_pos ht (by linarith)
  have hfrac : ((T.card : ℝ) - 2) * (1 / ((T.card : ℝ) - 1)) < 1 := by
    rw [mul_one_div, div_lt_one hp1]; linarith
  nlinarith [hfrac, hn]

/-- **The within-factor block as coefficients**: at `j, k ∈ T` and a Ricci-cut vector, `M ∘ ∑ c_i f_i` is
`∑_q κ_q f_q` with `κ_q` the coefficients of `within_coeff_in` and `within_coeff_out`. -/
theorem withinPair (T : Finset ι) (t : ℝ) {j k : ι} (hj : j ∈ T) (hk : k ∈ T) (hjk : j ≠ k) (c : ι → ℝ)
    (hsum : ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i = 0) {X : Matrix ι ι ℝ} (hX : IsSkew X) :
    let w := t • sphereWeight T
    let s := univ.filter (fun i => j ≠ i ∧ k ≠ i)
    foxProd (diagOp w) (fun Y => ∑ i ∈ s, c i • rk2 (phi j i) (phi k i) Y) X
      = ∑ q ∈ s, (if q ∈ T then (1 / 2 : ℝ) * (t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1)) + t) * ∑ i ∈ s.filter (· ∈ T), c i
          else (1 / 2 : ℝ) * ((-2 * t - t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1)) - t * ((T.card : ℝ) / ((Tᶜ.card : ℝ) - 1))) * c q
            + (t + t * ((T.card : ℝ) / ((Tᶜ.card : ℝ) - 1))) * ∑ i ∈ s.filter (· ∉ T), c i))
          • rk2 (phi j q) (phi k q) X := by
  intro w s
  have hs : ∀ i ∈ s, j ≠ i ∧ k ≠ i := fun i hi => (Finset.mem_filter.mp hi).2
  have hw : ∀ p q, w p q = w q p := fun p q => by simp only [w, Matrix.smul_apply, sphereWeight_symm]
  have hh : ∀ a, w a a = 0 := fun a => by simp [w, sphereWeight]
  rw [pair_invariant w hw hh hjk s hs c hX]
  have inner : ∀ i, ∑ q, w i q • rk2 (phi j q) (phi k q) X = ∑ q ∈ s, w i q • rk2 (phi j q) (phi k q) X :=
    fun i => pairSum_restrict hjk (w i) X
  simp only [inner, smul_add, Finset.smul_sum, smul_smul, Finset.sum_add_distrib]
  rw [Finset.sum_comm (s := s) (t := s), ← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun q hq => ?_
  rw [← Finset.sum_smul, ← add_smul]
  congr 1
  split_ifs with hqT
  · have h := within_coeff_in T t hj hk hjk s hs c hsum hq hqT
    simp only at h; rw [← h]; ring
  · have h := within_coeff_out T t hj hk hjk s hs c hsum hq hqT
    simp only at h; rw [← h]; ring

/-- **THE WITHIN-FACTOR TOP OCCURS**: at `p ≥ 3`, `j, k ∈ T`, the Ricci-cut vector with coefficient `|Tᶜ|` on
`T ∖ {j, k}` and `−(p − 2)` on `Tᶜ` has `M ∘ v = ½(α + t)(p − 2) v` on every bivector, and is nonzero
(`within_top_ne_zero`). -/
theorem within_top_exists (T : Finset ι) (hp : 3 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) {j k : ι} (hj : j ∈ T)
    (hk : k ∈ T) (hjk : j ≠ k) {X : Matrix ι ι ℝ} (hX : IsSkew X) :
    let s := univ.filter (fun i => j ≠ i ∧ k ≠ i)
    let c : ι → ℝ := fun i => if i ∈ T then (Tᶜ.card : ℝ) else -((T.card : ℝ) - 2)
    (∑ i ∈ s, c i = 0) ∧
    foxProd (diagOp (t • sphereWeight T)) (fun Y => ∑ i ∈ s, c i • rk2 (phi j i) (phi k i) Y) X
      = ((1 / 2 : ℝ) * (t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1)) + t) * ((T.card : ℝ) - 2))
          • ∑ i ∈ s, c i • rk2 (phi j i) (phi k i) X := by
  intro s c
  have hpR : (3 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  have hqR : (2 : ℝ) ≤ (Tᶜ.card : ℝ) := by exact_mod_cast hq
  have h1 : (T.card : ℝ) - 1 ≠ 0 := by linarith
  have h2 : (Tᶜ.card : ℝ) - 1 ≠ 0 := by linarith
  have cardA : ((s.filter (· ∈ T)).card : ℝ) = (T.card : ℝ) - 2 := by
    rw [within_filter_in T, Finset.card_erase_of_mem (Finset.mem_erase.mpr ⟨Ne.symm hjk, hk⟩),
      Finset.card_erase_of_mem hj]
    rw [Nat.cast_sub (by have := Finset.card_erase_of_mem hj (s := T); omega), Nat.cast_sub (by omega)]
    push_cast; ring
  have filtB : s.filter (· ∉ T) = Tᶜ := by
    ext i; simp only [Finset.mem_filter, Finset.mem_univ, true_and, Finset.mem_compl, s]
    constructor
    · rintro ⟨_, h⟩; exact h
    · intro h; exact ⟨⟨fun e => h (e ▸ hj), fun e => h (e ▸ hk)⟩, h⟩
  have CA : ∑ i ∈ s.filter (· ∈ T), c i = ((T.card : ℝ) - 2) * (Tᶜ.card : ℝ) := by
    rw [Finset.sum_congr rfl fun i hi => by rw [show c i = (Tᶜ.card : ℝ) from if_pos (Finset.mem_filter.mp hi).2],
      Finset.sum_const, nsmul_eq_mul, cardA]
  have CB : ∑ i ∈ s.filter (· ∉ T), c i = (Tᶜ.card : ℝ) * (-((T.card : ℝ) - 2)) := by
    rw [Finset.sum_congr rfl fun i hi => by rw [show c i = -((T.card : ℝ) - 2) from if_neg (Finset.mem_filter.mp hi).2],
      Finset.sum_const, nsmul_eq_mul, filtB]
  have hsum : ∑ i ∈ s, c i = 0 := by rw [sum_split_T T s, CA, CB]; ring
  refine ⟨hsum, ?_⟩
  rw [withinPair T t hj hk hjk c hsum hX, Finset.smul_sum]
  refine Finset.sum_congr rfl fun q _ => ?_
  rw [smul_smul]
  congr 1
  simp only [c]
  split_ifs with hqT
  · rw [CA]; ring
  · rw [CB]; field_simp; ring

/-- **The within-factor top's vector is nonzero**: at `φ_jq`, `q ∈ Tᶜ`, it takes the value `−(p − 2) φ_kq`. -/
theorem within_top_ne_zero (T : Finset ι) (hp : 3 ≤ T.card) (hq : 2 ≤ Tᶜ.card) {j k : ι} (hj : j ∈ T) (hk : k ∈ T)
    (hjk : j ≠ k) :
    ∃ X : Matrix ι ι ℝ, IsSkew X ∧ ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i),
      (if i ∈ T then (Tᶜ.card : ℝ) else -((T.card : ℝ) - 2)) • rk2 (phi j i) (phi k i) X ≠ 0 := by
  obtain ⟨q, hqT⟩ : ∃ q, q ∈ Tᶜ := Finset.card_pos.mp (by omega)
  have hqT' := Finset.mem_compl.mp hqT
  have hjq : j ≠ q := fun h => hqT' (h ▸ hj)
  have hkq : k ≠ q := fun h => hqT' (h ▸ hk)
  refine ⟨phi j q, phi_isSkew j q, fun h0 => ?_⟩
  rw [pair_eval hjk _ (fun i hi => (Finset.mem_filter.mp hi).2) _
    (Finset.mem_filter.mpr ⟨Finset.mem_univ _, hjq, hkq⟩), if_neg hqT'] at h0
  have e := congrArg (fun A : Matrix ι ι ℝ => A q k) h0
  change (_ • phi k q) q k = (0 : Matrix ι ι ℝ) q k at e
  rw [phi_entry' hkq, Matrix.zero_apply] at e
  have hpR : (3 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  linarith

/-- **The second family's top is below `½` too**: `within_bounds` with the factors exchanged. -/
theorem within_bounds_out (T : Finset ι) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t) :
    (1 / 2 : ℝ) * (t * ((T.card : ℝ) / ((Tᶜ.card : ℝ) - 1)) + t) * ((Tᶜ.card : ℝ) - 2)
      < t * ((T.card : ℝ) + Tᶜ.card - 1) / 2 := by
  have h := (within_bounds Tᶜ hq (by simpa only [compl_compl] using hp) t ht).1
  simp only [compl_compl] at h
  linarith

/-- **The second family's top occurs too**: `within_top_exists` and `within_top_ne_zero` at `Tᶜ`, for `j, k ∉ T` and
`q ≥ 3`. -/
theorem within_top_exists_out (T : Finset ι) (hp : 2 ≤ T.card) (hq : 3 ≤ Tᶜ.card) (t : ℝ) {j k : ι} (hj : j ∉ T)
    (hk : k ∉ T) (hjk : j ≠ k) {X : Matrix ι ι ℝ} (hX : IsSkew X) :
    let s := univ.filter (fun i => j ≠ i ∧ k ≠ i)
    let c : ι → ℝ := fun i => if i ∈ Tᶜ then (T.card : ℝ) else -((Tᶜ.card : ℝ) - 2)
    (∑ i ∈ s, c i = 0) ∧
    foxProd (diagOp (t • sphereWeight T)) (fun Y => ∑ i ∈ s, c i • rk2 (phi j i) (phi k i) Y) X
      = ((1 / 2 : ℝ) * (t * ((T.card : ℝ) / ((Tᶜ.card : ℝ) - 1)) + t) * ((Tᶜ.card : ℝ) - 2))
          • ∑ i ∈ s, c i • rk2 (phi j i) (phi k i) X := by
  intro s c
  have h := within_top_exists Tᶜ hq (by simpa only [compl_compl] using hp) t (Finset.mem_compl.mpr hj)
    (Finset.mem_compl.mpr hk) hjk hX
  simp only [compl_compl, sphereWeight_compl] at h
  exact h

theorem within_top_ne_zero_out (T : Finset ι) (hp : 2 ≤ T.card) (hq : 3 ≤ Tᶜ.card) {j k : ι} (hj : j ∉ T)
    (hk : k ∉ T) (hjk : j ≠ k) :
    ∃ X : Matrix ι ι ℝ, IsSkew X ∧ ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i),
      (if i ∈ Tᶜ then (T.card : ℝ) else -((Tᶜ.card : ℝ) - 2)) • rk2 (phi j i) (phi k i) X ≠ 0 := by
  have h := within_top_ne_zero Tᶜ hq (by simpa only [compl_compl] using hp) (Finset.mem_compl.mpr hj)
    (Finset.mem_compl.mpr hk) hjk
  simpa only [compl_compl] using h

end HamiltonsCubic.L121Block
