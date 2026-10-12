import HamiltonsCubic.Results.L127Within

set_option linter.style.longLine false

/-!
# L127's cross-factor multiplicities: the kernel and the `θ/2`-eigenspace, characterised

[findings/second-order.md](../../../findings/second-order.md), Lemma L127's table, cross-factor row, *"spectrum is exactly
`{½ simple, 0^{n−4}}`"*. [L127Spec.lean](L127Spec.lean) gives the inclusion and the occurrence, and this file characterises
the two eigenspaces on the Ricci cut of the pair span at a sphere product, `j ∈ T`, `k ∉ T`, `t > 0`:

* **`cross_kernel_iff`**: `M ∘ ∑ c_i f_i = 0` exactly when the coefficients sum to zero on the first factor (and so on
  the second): the zero-sum-per-factor vectors, of dimension `(p − 2) + (q − 2) = n − 4`;
* **`cross_top_iff`**: `M ∘ ∑ c_i f_i = (t(n − 1)/2) ∑ c_i f_i` exactly when `c` is constant on each factor, which on
  the Ricci cut is one line, the orbit. The dimension count itself is prose, as is the division by `θ`.
-/

namespace HamiltonsCubic.L121Block

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **The cross-factor kernel**: on the Ricci cut, `M ∘ ∑ c_i f_i = 0` on every bivector exactly when the coefficients
sum to zero on the first factor (and so on the second), a space of dimension `(p − 2) + (q − 2) = n − 4`. -/
theorem cross_kernel_iff (T : Finset ι) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t) {j k : ι}
    (hj : j ∈ T) (hk : k ∉ T) (c : ι → ℝ) (hsum : ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i = 0) :
    (∀ X : Matrix ι ι ℝ, IsSkew X →
      foxProd (diagOp (t • sphereWeight T)) (fun Y => ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i),
        c i • rk2 (phi j i) (phi k i) Y) X = 0)
      ↔ ∑ i ∈ (univ.filter (fun i => j ≠ i ∧ k ≠ i)).filter (· ∈ T), c i = 0 := by
  set s := univ.filter (fun i => j ≠ i ∧ k ≠ i) with hsdef
  have hs : ∀ i ∈ s, j ≠ i ∧ k ≠ i := fun i hi => (Finset.mem_filter.mp hi).2
  have hjk : j ≠ k := fun h => hk (h ▸ hj)
  have hpR : (2 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  have hp1 : 0 < (T.card : ℝ) - 1 := by linarith
  have hAT : 0 < t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1)) + t := by
    have : 0 < t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1)) := mul_pos ht (div_pos (by exact_mod_cast (by omega : 0 < Tᶜ.card)) hp1)
    linarith
  constructor
  · intro h
    -- a second index of `T`
    obtain ⟨q, hqT, hqj⟩ : ∃ q ∈ T, q ≠ j := by
      by_contra hc; push Not at hc
      have : T ⊆ {j} := fun x hx => Finset.mem_singleton.mpr (hc x hx)
      have := Finset.card_le_card this; simp at this; omega
    have hkq : k ≠ q := fun e => hk (e ▸ hqT)
    have hq_s : q ∈ s := Finset.mem_filter.mpr ⟨Finset.mem_univ _, Ne.symm hqj, hkq⟩
    have e := h (phi j q) (phi_isSkew j q)
    rw [crossPair T t hj hk c hsum (phi_isSkew j q), pair_eval hjk s hs _ hq_s, if_pos hqT] at e
    have e2 := congrArg (fun A : Matrix ι ι ℝ => A q k) e
    change (_ • phi k q) q k = (0 : Matrix ι ι ℝ) q k at e2
    rw [phi_entry' hkq, Matrix.zero_apply] at e2
    have : (1 / 2 : ℝ) * (t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1)) + t) ≠ 0 := by positivity
    exact (mul_eq_zero.mp e2).resolve_left this
  · intro hCT X hX
    have hCO : ∑ i ∈ s.filter (· ∉ T), c i = 0 := by
      have := sum_split_T T s c; rw [hsum, hCT] at this; linarith
    rw [crossPair T t hj hk c hsum hX]
    refine Finset.sum_eq_zero fun q _ => ?_
    split_ifs
    · rw [hCT, mul_zero, zero_smul]
    · rw [hCO, mul_zero, zero_smul]

/-- **The cross-factor `θ/2`-eigenspace**: on the Ricci cut, `M ∘ ∑ c_i f_i = (t(n − 1)/2) ∑ c_i f_i` on every bivector
exactly when `c` is constant on each factor, `c_q = C_T/(p − 1)` in the first and `C_{Tᶜ}/(q − 1)` in the second, which
on the Ricci cut is the orbit line. -/
theorem cross_top_iff (T : Finset ι) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t) {j k : ι}
    (hj : j ∈ T) (hk : k ∉ T) (c : ι → ℝ) (hsum : ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i = 0) :
    (∀ X : Matrix ι ι ℝ, IsSkew X →
      foxProd (diagOp (t • sphereWeight T)) (fun Y => ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i),
        c i • rk2 (phi j i) (phi k i) Y) X
        = (t * ((T.card : ℝ) + Tᶜ.card - 1) / 2) • ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i • rk2 (phi j i) (phi k i) X)
      ↔ ∀ q ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c q = if q ∈ T
          then (∑ i ∈ (univ.filter (fun i => j ≠ i ∧ k ≠ i)).filter (· ∈ T), c i) / ((T.card : ℝ) - 1)
          else (∑ i ∈ (univ.filter (fun i => j ≠ i ∧ k ≠ i)).filter (· ∉ T), c i) / ((Tᶜ.card : ℝ) - 1) := by
  set s := univ.filter (fun i => j ≠ i ∧ k ≠ i) with hsdef
  have hs : ∀ i ∈ s, j ≠ i ∧ k ≠ i := fun i hi => (Finset.mem_filter.mp hi).2
  have hjk : j ≠ k := fun h => hk (h ▸ hj)
  have hpR : (2 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  have hqR : (2 : ℝ) ≤ (Tᶜ.card : ℝ) := by exact_mod_cast hq
  have hp1 : (T.card : ℝ) - 1 ≠ 0 := by linarith
  have hq1 : (Tᶜ.card : ℝ) - 1 ≠ 0 := by linarith
  have hθ : t * ((T.card : ℝ) + Tᶜ.card - 1) ≠ 0 := mul_ne_zero ht.ne' (by linarith)
  obtain ⟨kT, kO⟩ := cross_kappa T hp hq t
  -- the coefficient identity at each `q`
  have coef : ∀ q ∈ s, (if q ∈ T then (1 / 2 : ℝ) * (t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1)) + t)
        * ∑ i ∈ s.filter (· ∈ T), c i
      else (1 / 2 : ℝ) * (t * ((T.card : ℝ) / ((Tᶜ.card : ℝ) - 1)) + t) * ∑ i ∈ s.filter (· ∉ T), c i)
      = (t * ((T.card : ℝ) + Tᶜ.card - 1) / 2) * (if q ∈ T then (∑ i ∈ s.filter (· ∈ T), c i) / ((T.card : ℝ) - 1)
          else (∑ i ∈ s.filter (· ∉ T), c i) / ((Tᶜ.card : ℝ) - 1)) := fun q _ => by
    split_ifs
    · rw [kT]; field_simp
    · rw [kO]; field_simp
  constructor
  · intro h q hq
    have e := h (phi j q) (phi_isSkew j q)
    rw [crossPair T t hj hk c hsum (phi_isSkew j q), pair_eval hjk s hs _ hq, Finset.smul_sum,
      Finset.sum_congr rfl (fun i _ => smul_smul _ _ _), pair_eval hjk s hs (fun i => _ * c i) hq] at e
    have e2 := congrArg (fun A : Matrix ι ι ℝ => A q k) e
    change (_ • phi k q) q k = (_ • phi k q) q k at e2
    rw [phi_entry' (hs q hq).2, phi_entry' (hs q hq).2, coef q hq] at e2
    exact (mul_left_cancel₀ (div_ne_zero hθ two_ne_zero) e2).symm
  · intro h X hX
    rw [crossPair T t hj hk c hsum hX, Finset.smul_sum]
    refine Finset.sum_congr rfl fun q hq => ?_
    rw [smul_smul, coef q hq, ← h q hq]

end HamiltonsCubic.L121Block
