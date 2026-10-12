import HamiltonsCubic.Results.L74
import Mathlib.Tactic.LinearCombination

/-!
# L96, the two printed closed forms are one, and the refutations check

[diagonal-half.md](../../../findings/diagonal-half.md)'s Lemma L96 is **REFUTED as stated**,
and the block records five separate counts. This file checks the arithmetic of each, and
supplies the step the record asserts without proving.

**The reconciliation the record never states.** L96's refutation says *"the closed form is
already on the record, 130 lines below"* and prints
`θ = |1+λ-μ| √(2(n-1)/(n k (n-1-k)))`, while [L74](L74.lean) prints
`θ = F/w² · √(2w/(vk(v-1)))` with a different radicand. **The record treats these as the same
formula and nowhere shows they are.** They are: given the strongly-regular identity,

`F = w (v-1) (1 + λ - μ)`,

which converts one into the other exactly. That is `forms_agree` below, and every other
statement in this file goes through it.
-/

namespace HamiltonsCubic.SRG

/-! ## The two closed forms are one -/

/-- **The reconciliation.** Under the strongly-regular identity the two printed numerators
agree, so `F/w² · √(2w/(vk(v-1)))` and `|1+λ-μ| √(2(v-1)/(vkw))` are the same function. -/
theorem forms_agree (v k lam mu : ℤ) (hid : k * (k - lam - 1) = (v - k - 1) * mu) :
    F v k lam = w v k * (v - 1) * (1 + lam - mu) := by
  unfold F w
  linear_combination -(v - 1) * hid

/-- `F` factors without `μ` at all: `F = (v-1)((v-1)(1+λ) - k²)`. -/
theorem F_factored (v k lam : ℤ) :
    F v k lam = (v - 1) * ((v - 1) * (1 + lam) - k ^ 2) := by
  unfold F; ring

/-! ## `K_{m,m}` and `2K_m`, one point up to sign -/

/-- `K_{m,m} = SRG(2m, m, 0, m)` has **negative** `F`, so the positive root returns `-θ₀`:
the block's named maximiser is, as written, the minimiser. -/
theorem kmm_F (m : ℤ) : F (2 * m) m 0 = -((2 * m - 1) * (m - 1) ^ 2) := by
  unfold F; ring

/-- Its `1 + λ - μ` is `1 - m`, negative for `m ≥ 2`, the same sign, seen in the other
form. -/
theorem kmm_sign (m : ℤ) (hm : 2 ≤ m) : 1 + (0 : ℤ) - m < 0 := by omega

/-- `θ² = (2m-1)(m-1)/m²` at `K_{m,m}`, which is `θ₀(2m)²`. -/
theorem kmm_theta_sq (m : ℚ) (hm : m ≠ 0) (h1 : m - 1 ≠ 0) (h2 : 2 * m - 1 ≠ 0) :
    ((2 * m - 1) * (m - 1) ^ 2 / (m - 1) ^ 2) ^ 2 * (2 * (m - 1) / (2 * m * m * (2 * m - 1)))
      = (2 * m - 1) * (m - 1) / m ^ 2 := by
  field_simp

/-- **`2K_m = SRG(2m, m-1, m-2, 0)` has positive `F`** and reaches the same `θ²`, so it
attains `θ₀` at every even `n`, the witness refuting *"only at `K_{m,m}`"*. -/
theorem twokm_F (m : ℤ) : F (2 * m) (m - 1) (m - 2) = (2 * m - 1) * (m - 1) * m := by
  unfold F; ring

theorem twokm_positive (m : ℤ) (hm : 2 ≤ m) : 0 < F (2 * m) (m - 1) (m - 2) := by
  rw [twokm_F]
  have h1 : 0 < 2 * m - 1 := by omega
  have h2 : 0 < m - 1 := by omega
  have h3 : 0 < m := by omega
  exact mul_pos (mul_pos h1 h2) h3

theorem twokm_theta_sq (m : ℚ) (hm : m ≠ 0) (h1 : m - 1 ≠ 0) (h2 : 2 * m - 1 ≠ 0) :
    ((2 * m - 1) * (m - 1) * m / m ^ 2) ^ 2 * (2 * m / (2 * m * (m - 1) * (2 * m - 1)))
      = (2 * m - 1) * (m - 1) / m ^ 2 := by
  field_simp

/-- `SRG(6,2,1,0) = 2K₃` and `SRG(12,5,4,0) = 2K₆`, the two witnesses the block names. -/
theorem twokm_at_three : (6 : ℤ) = 2 * 3 ∧ (2 : ℤ) = 3 - 1 ∧ (1 : ℤ) = 3 - 2 := by norm_num

theorem twokm_at_six : (12 : ℤ) = 2 * 6 ∧ (5 : ℤ) = 6 - 1 ∧ (4 : ℤ) = 6 - 2 := by norm_num

/-- `θ₀(12)² = 55/36`, so `θ = √55/6 = 1.236033…`, the screened value the block reports at
`(12,5,4,0)`. -/
theorem theta0_twelve : (2 * 6 - 1 : ℚ) * (6 - 1) / 6 ^ 2 = 55 / 36 := by norm_num

theorem theta0_twelve_decimal :
    ((1236032 : ℚ) / 1000000) ^ 2 < 55 / 36
      ∧ (55 : ℚ) / 36 < ((1236034 : ℚ) / 1000000) ^ 2 := by
  constructor <;> norm_num

/-! ## The "superset, so a fortiori" step is false, in general rather than at two witnesses -/

/-- `(v, v-2, v-3, 0)` satisfies the strongly-regular identity for **every** `v`. -/
theorem superset_admissible (v : ℤ) :
    (v - 2) * ((v - 2) - (v - 3) - 1) = (v - (v - 2) - 1) * 0 := by ring

/-- Its `F` is `(v-1)(v-2)` and `w = 1`, so `F/w² = (v-1)(v-2)`. -/
theorem superset_F (v : ℤ) : F v (v - 2) (v - 3) = (v - 1) * (v - 2) := by unfold F; ring

theorem superset_w (v : ℤ) : w v (v - 2) = 1 := by unfold w; ring

/-- **`θ² = v · θ₀(v)²` on the whole family**, so `θ = √v θ₀(v)`, the block's two witnesses
are instances of a general identity, and the superset step fails at every `v`. -/
theorem superset_theta_sq (v : ℚ) (hv : v ≠ 0) (hv1 : v ≠ 1) (hv2 : v ≠ 2) :
    ((v - 1) * (v - 2)) ^ 2 * (2 * 1 / (v * (v - 2) * (v - 1)))
      = v * (2 * (v - 1) * (v - 2) / v ^ 2) := by
  have h1 : v - 1 ≠ 0 := sub_ne_zero.2 hv1
  have h2 : v - 2 ≠ 0 := sub_ne_zero.2 hv2
  field_simp

/-- At `v = 6`: `θ² = 2·5·4/6 = 20/3`, and `√(20/3) = 2.581988…`. -/
theorem superset_six : 2 * (6 - 1 : ℚ) * (6 - 2) / 6 = 20 / 3 := by norm_num

/-- At `v = 24`: `θ² = 2·23·22/24 = 253/6`, and `√(253/6) = 6.493587…`, the block's second
witness. -/
theorem superset_twentyfour : 2 * (24 - 1 : ℚ) * (24 - 2) / 24 = 253 / 6 := by norm_num

/-- **And `(6,4,3,0)` is not a graph.** With `μ = 0` the graph is a disjoint union of cliques
of size `k+1 = 5`, which needs `5 ∣ 6`. So the parameter set satisfies the identity and
carries no graph, which is why multiplicity integrality, not the identity, is the hypothesis
that works. -/
theorem six_four_not_graph : ¬ ((5 : ℤ) ∣ 6) := by decide

/-- The other witness `(6,3,2,0)` gives `θ² = 10/4`, against `θ₀(6)² = 10/9`. -/
theorem six_three_theta_sq :
    ((1 + 2 - 0 : ℚ)) ^ 2 * (2 * (6 - 1) / (6 * 3 * (6 - 1 - 3))) = 10 / 4 := by norm_num

theorem theta0_six : (2 * (6 - 1 : ℚ) * (6 - 2)) / 6 ^ 2 = 10 / 9 := by norm_num

/-! ## The parity qualifier the numbering commit dropped -/

/-- `θ₀(9)² = 112/81`, so `θ₀(9) = 1.175877…`, above the family maximum `0.7698` at `n = 9`,
which is the block's own witness that the heading asserts a maximum the locus does not
attain. -/
theorem theta0_nine : (2 * (9 - 1 : ℚ) * (9 - 2)) / 9 ^ 2 = 112 / 81 := by norm_num

theorem theta0_nine_above_family : ((7698 : ℚ) / 10000) ^ 2 < 112 / 81 := by norm_num

/-- `K_{n/2,n/2}` needs `n` even: at `n` odd there is no such graph, which is the restriction
the heading lost. -/
theorem no_balanced_odd (n : ℤ) (hodd : ¬ (2 ∣ n)) (m : ℤ) : 2 * m ≠ n := by
  rintro rfl; exact hodd ⟨m, rfl⟩

end HamiltonsCubic.SRG
