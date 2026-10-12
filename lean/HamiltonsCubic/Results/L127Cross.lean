import HamiltonsCubic.Results.L122Orbit
import HamiltonsCubic.Results.L126DF

set_option linter.style.longLine false

/-!
# L127's cross-factor row: the cross pair block is `(θ/2)` times a projection

[findings/second-order.md](../../../findings/second-order.md), Lemma L127's table: *"pair, cross-factor, `pq`, spectrum is
exactly `{½ simple, 0^{n−4}}`, yes, along the orbit"*, in `L_e` units. At a sphere product `M = diagOp(t · sphereWeight T)`,
`j ∈ T`, `k ∉ T`, on the Ricci cut `∑ c_i = 0` of the pair span ([L122Pair.lean](L122Pair.lean)):

* **`cross_coeff_in`**, **`cross_coeff_out`**: the coefficient of `M ∘ ∑ c_i f_i` at `q` is `½(α − γ) C_T` in the first
  factor and `½(β − γ) C_{Tᶜ}` in the second, `C_T`, `C_{Tᶜ}` the in-factor coefficient sums and `γ = −t`;
* **`crossPair`**: so `M ∘ ∑ c_i f_i = ∑_q κ_q f_q` with `κ_q` constant on each factor. Since `α + t = t(n−1)/(p−1)` and
  `β + t = t(n−1)/(q−1)` and `θ = t(n−1)` at unit norm, this is `(θ/2)` times the projection onto the vectors constant
  on each factor, which on the Ricci cut is the orbit line: the block has `θ/2` once, on the orbit, and `0` on the
  `n − 4` zero-sum-per-factor vectors, the record's row in `L_e` units. That spectral reading, the eigenvector and
  kernel as declarations, and the division by `θ` into `L_e` units are prose here;
* **`cross_kappa`**: the two coefficient identities, in terms of the criticality multiplier `t(n − 1)`.
-/

namespace HamiltonsCubic.L121Block

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

omit [Fintype ι] in
/-- Split a sum over `s` by membership in `T`. -/
theorem sum_split_T (T s : Finset ι) (g : ι → ℝ) :
    ∑ i ∈ s, g i = ∑ i ∈ s.filter (· ∈ T), g i + ∑ i ∈ s.filter (· ∉ T), g i :=
  (Finset.sum_filter_add_sum_filter_not s (· ∈ T) g).symm

/-- **The cross-factor coefficient identity**: at a sphere product, `j ∈ T`, `k ∉ T`, `q ∈ T` off `{j, k}` and
`∑_{i∈s} c_i = 0`, the `q` coefficient of `M ∘ ∑ c_i f_i` is `½(α − γ) C_T`, `C_T` the in-factor sum. -/
theorem cross_coeff_in (T : Finset ι) (t : ℝ) {j k : ι} (hj : j ∈ T) (hk : k ∉ T) (s : Finset ι)
    (hs : ∀ i ∈ s, j ≠ i ∧ k ≠ i) (c : ι → ℝ) (hsum : ∑ i ∈ s, c i = 0) {q : ι} (hq : q ∈ s) (hqT : q ∈ T) :
    let w := t • sphereWeight T
    (1 / 2 : ℝ) * ((w j q + w k q - w j k) * c q) + ∑ i ∈ s, c i * ((1 / 2 : ℝ) * w i q)
      = (1 / 2 : ℝ) * (t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1)) + t) * ∑ i ∈ s.filter (· ∈ T), c i := by
  intro w
  obtain ⟨hjq, hkq⟩ := hs q hq
  have ewjq : w j q = t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1)) := by
    simp only [w, Matrix.smul_apply, smul_eq_mul, sphereWeight_in T hj hqT hjq]
  have ewkq : w k q = -t := by
    simp only [w, Matrix.smul_apply, smul_eq_mul]; rw [sphereWeight_symm, sphereWeight_cross T hqT hk]; ring
  have ewjk : w j k = -t := by
    simp only [w, Matrix.smul_apply, smul_eq_mul, sphereWeight_cross T hj hk]; ring
  set α := t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1))
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

/-- **The out-factor twin**: at `q ∉ T` the coefficient is `½(β − γ) C_{Tᶜ}`. -/
theorem cross_coeff_out (T : Finset ι) (t : ℝ) {j k : ι} (hj : j ∈ T) (hk : k ∉ T) (s : Finset ι)
    (hs : ∀ i ∈ s, j ≠ i ∧ k ≠ i) (c : ι → ℝ) (hsum : ∑ i ∈ s, c i = 0) {q : ι} (hq : q ∈ s) (hqT : q ∉ T) :
    let w := t • sphereWeight T
    (1 / 2 : ℝ) * ((w j q + w k q - w j k) * c q) + ∑ i ∈ s, c i * ((1 / 2 : ℝ) * w i q)
      = (1 / 2 : ℝ) * (t * ((T.card : ℝ) / ((Tᶜ.card : ℝ) - 1)) + t) * ∑ i ∈ s.filter (· ∉ T), c i := by
  intro w
  obtain ⟨hjq, hkq⟩ := hs q hq
  have ewjq : w j q = -t := by
    simp only [w, Matrix.smul_apply, smul_eq_mul, sphereWeight_cross T hj hqT]; ring
  have ewkq : w k q = t * ((T.card : ℝ) / ((Tᶜ.card : ℝ) - 1)) := by
    simp only [w, Matrix.smul_apply, smul_eq_mul, sphereWeight_out T hk hqT hkq]
  have ewjk : w j k = -t := by
    simp only [w, Matrix.smul_apply, smul_eq_mul, sphereWeight_cross T hj hk]; ring
  set β := t * ((T.card : ℝ) / ((Tᶜ.card : ℝ) - 1))
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

/-- **THE CROSS-FACTOR PAIR BLOCK AT A SPHERE PRODUCT**: at `j ∈ T`, `k ∉ T` and a Ricci-cut vector `∑ c_i f_i`
(`∑ c_i = 0`), `M ∘ ∑ c_i f_i = ∑_q κ_q f_q` on every bivector, with `κ_q = ½(α + t) C_T` in the first factor and
`½(β + t) C_{Tᶜ}` in the second: `M ∘` is `(θ/2)` times the projection onto the vectors constant on each factor, which
on the Ricci cut is the orbit line. The spectral reading is [L127Spec.lean](L127Spec.lean)'s `cross_spectrum`
(eigenvalues in `{0, θ/2}`) and `cross_orbit_exists` (`θ/2` occurs). -/
theorem crossPair (T : Finset ι) (t : ℝ) {j k : ι} (hj : j ∈ T) (hk : k ∉ T) (c : ι → ℝ)
    (hsum : ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i = 0) {X : Matrix ι ι ℝ} (hX : IsSkew X) :
    let w := t • sphereWeight T
    let s := univ.filter (fun i => j ≠ i ∧ k ≠ i)
    foxProd (diagOp w) (fun Y => ∑ i ∈ s, c i • rk2 (phi j i) (phi k i) Y) X
      = ∑ q ∈ s, (if q ∈ T then (1 / 2 : ℝ) * (t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1)) + t) * ∑ i ∈ s.filter (· ∈ T), c i
          else (1 / 2 : ℝ) * (t * ((T.card : ℝ) / ((Tᶜ.card : ℝ) - 1)) + t) * ∑ i ∈ s.filter (· ∉ T), c i)
          • rk2 (phi j q) (phi k q) X := by
  intro w s
  have hs : ∀ i ∈ s, j ≠ i ∧ k ≠ i := fun i hi => (Finset.mem_filter.mp hi).2
  have hjk : j ≠ k := fun h => hk (h ▸ hj)
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
  · have h := cross_coeff_in T t hj hk s hs c hsum hq hqT
    simp only at h; rw [← h]; ring
  · have h := cross_coeff_out T t hj hk s hs c hsum hq hqT
    simp only at h; rw [← h]; ring

/-- **The cross-factor coefficients in terms of the critical value**: `α + t = t(n − 1)/(p − 1)` and
`β + t = t(n − 1)/(q − 1)`, with `n = p + q` and `t(n − 1)` the sphere product's criticality multiplier
([L126DF.lean](L126DF.lean)'s `sphere_isCritical`), which is `θ` at unit norm by
[L74Statement.lean](L74Statement.lean)'s `theta_of_critical_unit`. -/
theorem cross_kappa (T : Finset ι) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) :
    t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1)) + t = t * ((T.card : ℝ) + Tᶜ.card - 1) / ((T.card : ℝ) - 1)
      ∧ t * ((T.card : ℝ) / ((Tᶜ.card : ℝ) - 1)) + t = t * ((T.card : ℝ) + Tᶜ.card - 1) / ((Tᶜ.card : ℝ) - 1) := by
  have hpR : (2 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  have hqR : (2 : ℝ) ≤ (Tᶜ.card : ℝ) := by exact_mod_cast hq
  have h1 : (T.card : ℝ) - 1 ≠ 0 := by linarith
  have h2 : (Tᶜ.card : ℝ) - 1 ≠ 0 := by linarith
  constructor <;> field_simp <;> ring

end HamiltonsCubic.L121Block
