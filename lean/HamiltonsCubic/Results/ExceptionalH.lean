import Mathlib

/-!
# L287: an absolute trace floor, and statement H at every embedding of index `j² ≥ ¾ h∨`

[The I117 working note](../../../reviews/2026-09-28l-I117-g2-torus.md), "An absolute trace floor".
At a nonzero positive-semidefinite `#`-idempotent `C = ∑ λ_i u_i u_iᵀ` of a compact simple `𝔥`, the
diagonal of `C # C = C` at the largest eigenvalue `λ_m` reads
`λ_m = ½ ∑_{i,j} c_{ijm} λ_i λ_j` with `c_{ijm} = ⟨[u_i,u_j],u_m⟩² ≥ 0` and
`∑_i c_{ijm} = ‖[u_j,u_m]‖² ≤ |θ|² = 2c/h∨`, so `tr C ≥ h∨/c` (`trace_floor`, `trace_ge`). With
`tr C ≤ c‖C‖²` (pairing `C # C = C` with `I`, whose scalars on `Sym² 𝔥` are at most `c`), this gives
`‖C‖² ≥ h∨/c² = j²/h∨` in an embedding of Dynkin index `j` (`norm_floor`, `index_form`), and that
exceeds H's requirement `N/(n-2)² < 3/4` at `n ≥ 9` once `j² ≥ ¾ h∨` (`requirement_lt`, `index_H`):
`𝔣₄`, `𝔢₆`, `𝔢₇`, `𝔢₈` in every embedding, `𝔤₂` from `j = 2` on (`exceptional_pass`).

**Typed**: the scalar chain from the diagonal identity to H. **Not typed**: the eigenbasis identity,
`∑_i c_{ijm} = ‖[u_j,u_m]‖²`, `max ‖ad_x‖² = |θ|² = 2c/h∨`, `tr C ≤ c‖C‖²`, the index `c = h∨/j`,
and the minimal indices; they enter as hypotheses (Gate 2 r1910, r1911).
-/

namespace HamiltonsCubic.ExceptionalH

/-- **The trace floor**, scalar core: the diagonal of `C # C = C` at the largest eigenvalue, with
every row sum at most `K`, gives `2 ≤ K tr C`. -/
theorem trace_floor {ι : Type*} [Fintype ι] (lam : ι → ℝ) (cc : ι → ι → ι → ℝ) (m : ι) (K : ℝ)
    (hc : ∀ i j k, 0 ≤ cc i j k) (hl : ∀ i, 0 ≤ lam i) (hmax : ∀ i, lam i ≤ lam m)
    (hpos : 0 < lam m) (hrow : lam m = 1 / 2 * ∑ i, ∑ j, cc i j m * lam i * lam j)
    (hB : ∀ j, ∑ i, cc i j m ≤ K) : 2 ≤ K * ∑ i, lam i := by
  have h1 : ∑ i, ∑ j, cc i j m * lam i * lam j ≤ ∑ i, ∑ j, cc i j m * lam m * lam j :=
    Finset.sum_le_sum fun i _ => Finset.sum_le_sum fun j _ =>
      mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_left (hmax i) (hc i j m)) (hl j)
  have h2 : ∑ i, ∑ j, cc i j m * lam m * lam j = lam m * ∑ j, lam j * ∑ i, cc i j m := by
    rw [Finset.sum_comm, Finset.mul_sum]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [Finset.mul_sum, Finset.mul_sum]
    exact Finset.sum_congr rfl fun i _ => by ring
  have h3 : ∑ j, lam j * ∑ i, cc i j m ≤ ∑ j, lam j * K :=
    Finset.sum_le_sum fun j _ => mul_le_mul_of_nonneg_left (hB j) (hl j)
  rw [← Finset.sum_mul] at h3
  have h4 : 2 * lam m ≤ lam m * ((∑ j, lam j) * K) := by nlinarith
  nlinarith

/-- With `K = |θ|² = 2c/h∨`, the floor reads `tr C ≥ h∨/c`. -/
theorem trace_ge (hv c K t : ℝ) (hc : 0 < c) (hhv : 0 < hv) (hK : K = 2 * c / hv)
    (h : 2 ≤ K * t) : hv / c ≤ t := by
  rw [hK, div_mul_eq_mul_div, le_div_iff₀ hhv] at h
  rw [div_le_iff₀ hc]
  linarith

/-- **The norm floor**: `tr C ≥ h∨/c` and `tr C ≤ c‖C‖²` give `‖C‖² ≥ h∨/c²`. -/
theorem norm_floor (hv c t s : ℝ) (hc : 0 < c) (hfloor : hv / c ≤ t) (hpair : t ≤ c * s) :
    hv / c ^ 2 ≤ s := by
  have h1 : hv / c ^ 2 = (hv / c) / c := by rw [div_div, sq]
  rw [h1, div_le_iff₀ hc]
  linarith

/-- In an embedding of Dynkin index `j`, `c = h∨/j`, and the norm floor is `j²/h∨`. -/
theorem index_form (hv j : ℝ) (hj : 0 < j) (hhv : 0 < hv) : hv / (hv / j) ^ 2 = j ^ 2 / hv := by
  field_simp

/-- H's requirement `N/(n-2)²`, `N = n(n-1)/2`, is below `3/4` at every `n ≥ 9`. -/
theorem requirement_lt (n : ℝ) (hn : 9 ≤ n) : n * (n - 1) / 2 / (n - 2) ^ 2 < 3 / 4 := by
  have h2 : 0 < n - 2 := by linarith
  have hpos : 0 < (n - 2) ^ 2 := by positivity
  rw [div_lt_iff₀ hpos]
  nlinarith

/-- **Statement H at an embedding of index `j` with `j² ≥ ¾ h∨`**: every nonzero positive-semidefinite
idempotent, whose trace `t` satisfies the floor `2 ≤ (2c/h∨) t` and the pairing `t ≤ c s` with
`s = ‖C‖²` and `c = h∨/j`, has `s ≥ N/(n-2)²` at every `n ≥ 9`. -/
theorem index_H (hv j t s n : ℝ) (hj : 0 < j) (hhv : 0 < hv)
    (hfloor : 2 ≤ 2 * (hv / j) / hv * t) (hpair : t ≤ hv / j * s) (hcrit : 3 / 4 * hv ≤ j ^ 2)
    (hn : 9 ≤ n) : n * (n - 1) / 2 / (n - 2) ^ 2 ≤ s := by
  have hc : 0 < hv / j := div_pos hhv hj
  have ht := trace_ge hv (hv / j) _ t hc hhv rfl hfloor
  have hs := norm_floor hv (hv / j) t s hc ht hpair
  rw [index_form hv j hj hhv] at hs
  have h34 : 3 / 4 ≤ j ^ 2 / hv := by rw [le_div_iff₀ hhv]; linarith
  linarith [requirement_lt n hn]

/-- The criterion `¾ h∨ ≤ j²` at the minimal real embeddings of `𝔣₄` (`h∨ = 9`, `j = 3`), `𝔢₆`
(`12`, `6`), `𝔢₇` (`18`, `12`), `𝔢₈` (`30`, `30`), and at `𝔤₂`'s embeddings from `j = 2` on
(`h∨ = 4`). The criterion is monotone in `j`, so each covers every embedding of its algebra. -/
theorem exceptional_pass :
    (3 / 4 : ℝ) * 9 ≤ 3 ^ 2 ∧ (3 / 4 : ℝ) * 12 ≤ 6 ^ 2 ∧ (3 / 4 : ℝ) * 18 ≤ 12 ^ 2 ∧
      (3 / 4 : ℝ) * 30 ≤ 30 ^ 2 ∧ (3 / 4 : ℝ) * 4 ≤ 2 ^ 2 := by
  norm_num

/-- Non-vacuity: the hypotheses of `index_H` hold at `𝔣₄ ⊂ 𝔰𝔬(26)` with `C = I/c` (`c = 3`,
`t = d/c = 52/3`, `s = d/c² = 52/9`). -/
example : (2 : ℝ) ≤ 2 * (9 / 3) / 9 * (52 / 3) ∧ (52 / 3 : ℝ) ≤ 9 / 3 * (52 / 9) := by norm_num

end HamiltonsCubic.ExceptionalH
