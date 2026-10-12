import HamiltonsCubic.Results.L127Mult

set_option linter.style.longLine false

/-!
# L127's within-factor eigenspaces: the kernel and the negative eigenspace, characterised

[findings/second-order.md](../../../findings/second-order.md), Lemma L127, within-factor row, and the record's full
within-factor spectrum `{λ_p, (−μ)^{q−1}, 0^{p−3}}`. At a sphere product, `j, k ∈ T`, `t > 0`, on the Ricci cut:

* **`pairSpan_eq_iff`**: an eigen-equation on the pair span is its coefficient equations, for any coefficients;
* **`within_kernel_iff`**: `M ∘ ∑ c_i f_i = 0` exactly when the first-factor coefficients sum to zero and the
  second-factor coefficients vanish, dimension `p − 3` at `p ≥ 3` and `{0}` at `p = 2`;
* **`within_neg_iff`**: `M ∘ ∑ c_i f_i = −½(2t + α + β) ∑ c_i f_i` exactly when the vector is supported on the second
  factor with zero sum there, dimension `q − 1`, the record's `(−μ)^{q−1}`. With `within_top_exists` the three
  eigenspaces exhaust the Ricci cut at `p ≥ 3`, `(p − 3) + (q − 1) + 1 = n − 3`, and at `p = 2` the cut is the
  negative eigenspace alone. The dimension counts are prose, and the
  division by `θ` is [L127Le.lean](L127Le.lean)'s `within_LeLin_spectrum`.
-/

namespace HamiltonsCubic.L121Block

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **An eigen-equation on the pair span is its coefficient equations**: at `j ≠ k` and any coefficients `κ`, `c`,
`∑ κ_q f_q = λ ∑ c_q f_q` on every bivector exactly when `κ_q = λ c_q` at every `q` off `{j, k}`. -/
theorem pairSpan_eq_iff {j k : ι} (hjk : j ≠ k) (κ c : ι → ℝ) (lam : ℝ) :
    (∀ X : Matrix ι ι ℝ, IsSkew X →
      ∑ q ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), κ q • rk2 (phi j q) (phi k q) X
        = lam • ∑ q ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c q • rk2 (phi j q) (phi k q) X)
      ↔ ∀ q ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), κ q = lam * c q := by
  set s := univ.filter (fun i => j ≠ i ∧ k ≠ i)
  have hs : ∀ i ∈ s, j ≠ i ∧ k ≠ i := fun i hi => (Finset.mem_filter.mp hi).2
  constructor
  · intro h q hq
    have e := h (phi j q) (phi_isSkew j q)
    rw [pair_eval hjk s hs κ hq, pair_eval hjk s hs c hq, smul_smul] at e
    have e2 := congrArg (fun A : Matrix ι ι ℝ => A q k) e
    change (_ • phi k q) q k = (_ • phi k q) q k at e2
    rw [phi_entry' (hs q hq).2, phi_entry' (hs q hq).2] at e2
    exact e2
  · intro h X _
    rw [Finset.smul_sum]
    exact Finset.sum_congr rfl fun q hq => by rw [smul_smul, h q hq]

/-- **The within-factor kernel**: at a sphere product, `j, k ∈ T`, `t > 0`, on the Ricci cut, `M ∘ ∑ c_i f_i = 0`
exactly when the first-factor coefficients sum to zero and every second-factor coefficient vanishes, a space of
dimension `p − 3` at `p ≥ 3` and `{0}` at `p = 2`. -/
theorem within_kernel_iff (T : Finset ι) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t) {j k : ι}
    (hj : j ∈ T) (hk : k ∈ T) (hjk : j ≠ k) (c : ι → ℝ)
    (hsum : ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i = 0) :
    (∀ X : Matrix ι ι ℝ, IsSkew X →
      foxProd (diagOp (t • sphereWeight T)) (fun Y => ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i),
        c i • rk2 (phi j i) (phi k i) Y) X
        = (0 : ℝ) • ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i • rk2 (phi j i) (phi k i) X)
      ↔ (∑ i ∈ (univ.filter (fun i => j ≠ i ∧ k ≠ i)).filter (· ∈ T), c i = 0
          ∧ ∀ q ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), q ∉ T → c q = 0) := by
  set s := univ.filter (fun i => j ≠ i ∧ k ≠ i) with hsdef
  have hpR : (2 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  have hqR : (2 : ℝ) ≤ (Tᶜ.card : ℝ) := by exact_mod_cast hq
  have hα : 0 < t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1)) := mul_pos ht (div_pos (by linarith) (by linarith))
  have hβ : 0 < t * ((T.card : ℝ) / ((Tᶜ.card : ℝ) - 1)) := mul_pos ht (div_pos (by linarith) (by linarith))
  have hsplit : ∑ i ∈ s.filter (· ∈ T), c i + ∑ i ∈ s.filter (· ∉ T), c i = 0 := by
    rw [← sum_split_T T s]; exact hsum
  rw [forall_congr' fun X => imp_congr_right fun hX => by rw [withinPair T t hj hk hjk c hsum hX], pairSpan_eq_iff hjk]
  constructor
  · intro h
    have hCA : ∑ i ∈ s.filter (· ∈ T), c i = 0 := by
      by_cases hA : (s.filter (· ∈ T)).Nonempty
      · obtain ⟨q, hq⟩ := hA
        have e := h q (Finset.mem_filter.mp hq).1
        rw [if_pos (Finset.mem_filter.mp hq).2, zero_mul] at e
        have : (1 / 2 : ℝ) * (t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1)) + t) ≠ 0 := by positivity
        exact (mul_eq_zero.mp e).resolve_left this
      · rw [Finset.not_nonempty_iff_eq_empty.mp hA, Finset.sum_empty]
    refine ⟨hCA, fun q hq hqT => ?_⟩
    have e := h q hq
    rw [if_neg hqT, zero_mul, show ∑ i ∈ s.filter (· ∉ T), c i = 0 by linarith, mul_zero, add_zero] at e
    have : (1 / 2 : ℝ) * (-2 * t - t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1)) - t * ((T.card : ℝ) / ((Tᶜ.card : ℝ) - 1))) ≠ 0 := by
      have : -2 * t - t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1)) - t * ((T.card : ℝ) / ((Tᶜ.card : ℝ) - 1)) < 0 := by linarith
      intro h0; linarith
    have e' : (1 / 2 : ℝ) * (-2 * t - t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1)) - t * ((T.card : ℝ) / ((Tᶜ.card : ℝ) - 1))) * c q = 0 := by
      linarith
    exact (mul_eq_zero.mp e').resolve_left this
  · rintro ⟨hCA, hB⟩ q hq
    have hCB : ∑ i ∈ s.filter (· ∉ T), c i = 0 := by linarith
    split_ifs with hqT
    · rw [hCA]; ring
    · rw [hB q hq hqT, hCB]; ring

/-- **The within-factor negative eigenspace**: on the Ricci cut, `M ∘ ∑ c_i f_i = −½(2t + α + β) ∑ c_i f_i` exactly
when the vector is supported on the second factor with zero sum there, a space of dimension `q − 1`, the record's
`(−μ)^{q−1}`. -/
theorem within_neg_iff (T : Finset ι) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t) {j k : ι}
    (hj : j ∈ T) (hk : k ∈ T) (hjk : j ≠ k) (c : ι → ℝ)
    (hsum : ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i = 0) :
    (∀ X : Matrix ι ι ℝ, IsSkew X →
      foxProd (diagOp (t • sphereWeight T)) (fun Y => ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i),
        c i • rk2 (phi j i) (phi k i) Y) X
        = ((1 / 2 : ℝ) * (-2 * t - t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1)) - t * ((T.card : ℝ) / ((Tᶜ.card : ℝ) - 1))))
          • ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i • rk2 (phi j i) (phi k i) X)
      ↔ ((∀ q ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), q ∈ T → c q = 0)
          ∧ ∑ i ∈ (univ.filter (fun i => j ≠ i ∧ k ≠ i)).filter (· ∉ T), c i = 0) := by
  set s := univ.filter (fun i => j ≠ i ∧ k ≠ i) with hsdef
  have hpR : (2 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  have hqR : (2 : ℝ) ≤ (Tᶜ.card : ℝ) := by exact_mod_cast hq
  have hα : 0 < t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1)) := mul_pos ht (div_pos (by linarith) (by linarith))
  have hβ : 0 < t * ((T.card : ℝ) / ((Tᶜ.card : ℝ) - 1)) := mul_pos ht (div_pos (by linarith) (by linarith))
  set neg := (1 / 2 : ℝ) * (-2 * t - t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1)) - t * ((T.card : ℝ) / ((Tᶜ.card : ℝ) - 1)))
  have hneg : neg < 0 := by simp only [neg]; linarith
  have hsplit : ∑ i ∈ s.filter (· ∈ T), c i + ∑ i ∈ s.filter (· ∉ T), c i = 0 := by
    rw [← sum_split_T T s]; exact hsum
  rw [forall_congr' fun X => imp_congr_right fun hX => by rw [withinPair T t hj hk hjk c hsum hX], pairSpan_eq_iff hjk]
  constructor
  · intro h
    -- a second-factor index
    obtain ⟨q, hqT⟩ : ∃ q, q ∈ Tᶜ := Finset.card_pos.mp (by omega)
    have hqT' := Finset.mem_compl.mp hqT
    have hq_s : q ∈ s := Finset.mem_filter.mpr ⟨Finset.mem_univ _,
      fun e => hqT' (e ▸ hj), fun e => hqT' (e ▸ hk)⟩
    have e := h q hq_s
    rw [if_neg hqT'] at e
    have hCB : ∑ i ∈ s.filter (· ∉ T), c i = 0 := by
      have e' : (t + t * ((T.card : ℝ) / ((Tᶜ.card : ℝ) - 1))) * ∑ i ∈ s.filter (· ∉ T), c i = 0 := by
        simp only [neg] at e; linarith
      exact (mul_eq_zero.mp e').resolve_left (by linarith)
    have hCA : ∑ i ∈ s.filter (· ∈ T), c i = 0 := by linarith
    refine ⟨fun q' hq' hq'T => ?_, hCB⟩
    have e2 := h q' hq'
    rw [if_pos hq'T, hCA, mul_zero] at e2
    exact (mul_eq_zero.mp e2.symm).resolve_left hneg.ne
  · rintro ⟨hA, hCB⟩ q hq
    have hCA : ∑ i ∈ s.filter (· ∈ T), c i = 0 := by linarith
    split_ifs with hqT
    · rw [hCA, hA q hq hqT]; ring
    · rw [hCB]; simp only [neg]; ring

end HamiltonsCubic.L121Block
