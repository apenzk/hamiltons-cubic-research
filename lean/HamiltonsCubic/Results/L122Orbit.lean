import HamiltonsCubic.Results.L122Pair
import HamiltonsCubic.Results.FoxBridge

set_option linter.style.longLine false

/-!
# L122's orbit direction: the orbit tangent is a `θ/2`-eigenvector of the pair block

[findings/second-order.md](../../../findings/second-order.md), after Lemma L121: *"The orbit direction
`x_i = M_ki − M_ji` is an eigenvector with eigenvalue `θ/2`, all `M`-dependence cancelling against criticality"*. The
file's `T_jk` has coefficients `w_ji − w_ki`, the record's vector negated, which leaves an eigenvector one. At a
diagonally critical weight (`w_ab² + (w²)_ab = θ w_ab` off the diagonal):

* **`pairSum_restrict`**, **`sum_off_pair`**: the pair-basis sum over all indices is the sum off `{j, k}`, `f_j` and `f_k`
  being zero;
* **`pair_perp`**: the pair span is orthogonal to `M`;
* **`orbit_eigen`**: the orbit tangent `T_jk = ∑ (w_ji − w_ki) f_i` ([L126Orbit.lean](L126Orbit.lean)'s
  `orbit_in_pairBlock`) has `M ∘ T_jk = (θ/2) T_jk` on every bivector, through `pair_invariant` and the criticality
  identity at `(j, q)` and `(k, q)`.
-/

namespace HamiltonsCubic.L121Block

open Matrix Finset HamiltonsCubic.RealLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

theorem rk2_zero_left (V X : Matrix ι ι ℝ) : rk2 0 V X = 0 := by
  unfold rk2; simp [inner2]

/-- The pair-basis sum over all indices is the sum over the indices off `{j, k}`, `f_j` and `f_k` being zero. -/
theorem pairSum_restrict {j k : ι} (_hjk : j ≠ k) (c : ι → ℝ) (X : Matrix ι ι ℝ) :
    ∑ i, c i • rk2 (phi j i) (phi k i) X
      = ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i • rk2 (phi j i) (phi k i) X := by
  rw [Finset.sum_filter]
  refine Finset.sum_congr rfl fun i _ => ?_
  split_ifs with h
  · rfl
  · rcases not_and_or.mp h with h1 | h1
    · have := not_not.mp h1; subst this; simp [phi_self, rk2_zero_left]
    · have := not_not.mp h1; subst this
      rw [rk2_comm, phi_self, rk2_zero_left, smul_zero]

/-- A sum over the indices off `{j, k}` is the full sum less the two terms. -/
theorem sum_off_pair {j k : ι} (hjk : j ≠ k) (g : ι → ℝ) :
    ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), g i = (∑ i, g i) - g j - g k := by
  rw [Finset.sum_filter]
  have e : ∀ i, (if j ≠ i ∧ k ≠ i then g i else 0) = g i - (if j = i then g i else 0) - (if k = i then g i else 0) := by
    intro i
    by_cases h1 : j = i
    · subst h1; simp [Ne.symm hjk]
    · by_cases h2 : k = i
      · subst h2; simp [h1]
      · simp [h1, h2]
  rw [Finset.sum_congr rfl fun i _ => e i, Finset.sum_sub_distrib, Finset.sum_sub_distrib, Finset.sum_ite_eq,
    Finset.sum_ite_eq, if_pos (Finset.mem_univ _), if_pos (Finset.mem_univ _)]

open HamiltonsCubic.FamilyLayer HamiltonsCubic.TensorBridge in
/-- **THE ORBIT DIRECTION IS A `θ/2`-EIGENVECTOR OF THE PAIR BLOCK**: at a diagonally critical weight with multiplier
`θ` (`w_ab² + (w²)_ab = θ w_ab` off the diagonal) and `j ≠ k`, the orbit tangent `T_jk = ∑ (w_ji − w_ki) f_i` has
`M ∘ T_jk = (θ/2) T_jk` on every bivector, which at `θ ≠ 0` reads `L_e T_jk = ½ T_jk` with `e = M/θ`. `T_jk = 0` on
the within-factor blocks, which carry no orbit direction. -/
theorem orbit_eigen (w : Matrix ι ι ℝ) (hw : ∀ p q, w p q = w q p) (hh : ∀ a, w a a = 0) {th : ℝ}
    (hcrit : ∀ a b, a ≠ b → w a b ^ 2 + (w * w) a b = th * w a b) {j k : ι} (hjk : j ≠ k)
    {X : Matrix ι ι ℝ} (hX : IsSkew X) :
    foxProd (diagOp w) (orbitTan (diagOp w) j k) X = (th / 2) • orbitTan (diagOp w) j k X := by
  set s := univ.filter (fun i => j ≠ i ∧ k ≠ i) with hsdef
  have hs : ∀ i ∈ s, j ≠ i ∧ k ≠ i := fun i hi => (Finset.mem_filter.mp hi).2
  set x : ι → ℝ := fun i => w j i - w k i
  have hT : ∀ Y, IsSkew Y → orbitTan (diagOp w) j k Y = ∑ i ∈ s, x i • rk2 (phi j i) (phi k i) Y := fun Y hY => by
    rw [orbit_in_pairBlock w hw hh hjk hY, pairSum_restrict hjk]
  have hTs : ∀ Y, IsSkew Y → IsSkew (orbitTan (diagOp w) j k Y) := fun Y hY => by
    unfold orbitTan
    have h1 := br_skew (phi_isSkew j k) (diagOp_skew w hw Y hY)
    have h2 := diagOp_skew w hw _ (br_skew (phi_isSkew j k) hY)
    unfold IsSkew at *; rw [Matrix.transpose_sub, h1, h2]; abel
  rw [foxProd_congr_on_skew (fun Z hZ => diagOp_skew w hw Z hZ) hTs (fun _ _ => rfl) hT X hX,
    pair_invariant w hw hh hjk s hs x hX, hT X hX]
  -- restrict the inner sums to `s`, swap, and compare coefficients
  have inner : ∀ i, ∑ q, w i q • rk2 (phi j q) (phi k q) X = ∑ q ∈ s, w i q • rk2 (phi j q) (phi k q) X :=
    fun i => pairSum_restrict hjk (w i) X
  simp only [inner, smul_add, Finset.smul_sum, smul_smul, Finset.sum_add_distrib]
  rw [Finset.sum_comm (s := s) (t := s)]
  rw [← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun q hq => ?_
  rw [← Finset.sum_smul, ← add_smul]
  congr 1
  -- the coefficient identity
  obtain ⟨hjq, hkq⟩ := hs q hq
  have hsum : ∑ i ∈ s, x i * ((1 / 2 : ℝ) * w i q) = (1 / 2 : ℝ) * ((w * w) j q - (w * w) k q
      + w j k * w j q - w j k * w k q) := by
    have := sum_off_pair hjk (fun i => x i * ((1 / 2 : ℝ) * w i q))
    rw [this]
    simp only [x, hh, Matrix.mul_apply]
    rw [show ∑ i, (w j i - w k i) * (1 / 2 * w i q) = (1 / 2 : ℝ) * (∑ i, w j i * w i q - ∑ i, w k i * w i q) by
      rw [← Finset.sum_sub_distrib, Finset.mul_sum]; exact Finset.sum_congr rfl fun i _ => by ring]
    rw [hw k j]; ring
  rw [hsum]
  have c1 := hcrit j q hjq
  have c2 := hcrit k q hkq
  simp only [x]
  linear_combination (1 / 2 : ℝ) * c1 - (1 / 2 : ℝ) * c2

open HamiltonsCubic.FamilyLayer in
/-- **The pair span is orthogonal to `M`**: `⟨diagOp w, ∑_{i∈s} c_i f_i⟩ = 0` at a symmetric weight, `s` avoiding
`j, k`, since each `f_i` pairs `φ_ji` against `φ_ki`, distinct basis bivectors. -/
theorem pair_perp (w : Matrix ι ι ℝ) (hw : ∀ p q, w p q = w q p) {j k : ι} (hjk : j ≠ k) (s : Finset ι)
    (hs : ∀ i ∈ s, j ≠ i ∧ k ≠ i) (c : ι → ℝ) :
    innerOp (diagOp w) (fun Y => ∑ i ∈ s, c i • rk2 (phi j i) (phi k i) Y) = 0 := by
  have lin : innerOp (diagOp w) (fun Y => ∑ i ∈ s, c i • rk2 (phi j i) (phi k i) Y)
      = ∑ i ∈ s, c i * innerOp (diagOp w) (rk2 (phi j i) (phi k i)) := by
    unfold innerOp
    simp only [inner2_sum_right, ip_smul_r, Finset.mul_sum]
    rw [Finset.sum_congr rfl fun a _ => Finset.sum_comm]
    rw [Finset.sum_comm]
    exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => by ring
  rw [lin]
  refine Finset.sum_eq_zero fun i hi => ?_
  obtain ⟨hji, hki⟩ := hs i hi
  rw [innerOp_rk2 _ (isLinOp_diagOp w) (phi_isSkew j i) (phi_isSkew k i), diagOp_phi w hw, diagOp_phi w hw,
    ip_smul_l, ip_smul_l, inner2_phi_phi, inner2_phi_phi]
  simp [hjk, hjk.symm, hji, hki]

end HamiltonsCubic.L121Block
