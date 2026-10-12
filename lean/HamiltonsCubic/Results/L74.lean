import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.FieldSimp

/-!
# L74, `θ` in closed form for every strongly regular graph

[diagonal-half.md](../../../findings/diagonal-half.md)'s Lemma L74 turns a strongly regular
graph `(v, k, λ, μ)` into a diagonal critical point and gives

`θ/‖W‖ = F/w² · √(2w / (v k (v-1)))`, `F = (v-1)²λ + 2k(v-1) - k²v + w²`, `w = v-1-k`.

Everything below is the arithmetic of that formula and of the block's four uses of it.

**The finding is on the conference-graph paragraph.** The block writes that every conference
graph has `θ = 0`, then adds *"The Petersen graph is another."* Petersen is `SRG(10,3,0,1)`
and a conference graph needs `k = (v-1)/2`, which at `v = 10` is `4.5`. **Petersen is not a
conference graph.** Its `θ` does vanish, and by the same closed form, so the conclusion
survives and the reason given for it does not. Both are proved below.
-/

namespace HamiltonsCubic.SRG

/-- The numerator of the closed form. **It takes no `μ`**, which is the hazard the block
names: `μ` cancels out of the edge face, so an inadmissible parameter set validates against
that face alone and only the graph identity sees the error. -/
def F (v k lam : ℤ) : ℤ := (v - 1) ^ 2 * lam + 2 * k * (v - 1) - k ^ 2 * v + (v - 1 - k) ^ 2

/-- `w = v - 1 - k`, the complementary degree. -/
def w (v k : ℤ) : ℤ := v - 1 - k

/-! ## The admissibility condition is the graph identity itself -/

/-- **The reduction of `F_edge = F_non-edge` is exactly the strongly-regular identity.**
`k(λ-μ) + (v-1)μ - k² + k = 0` and `k(k-λ-1) = (v-k-1)μ` are the same equation, so every
strongly regular graph is a diagonal critical point with no further constraint. -/
theorem admissible_iff (v k lam mu : ℤ) :
    k * (lam - mu) + (v - 1) * mu - k ^ 2 + k = 0 ↔ k * (k - lam - 1) = (v - k - 1) * mu := by
  constructor <;> intro h <;> linarith [h, sq_nonneg k]

/-! ## Gate 1(a), the octahedron, and the `μ` that was wrong -/

/-- `K_{2,2,2} = SRG(6,4,2,4)`: `w = 1` and `F = 50 + 40 - 96 + 1 = -5`. -/
theorem octahedron_F : F 6 4 2 = -5 := by norm_num [F]

theorem octahedron_w : w 6 4 = 1 := by norm_num [w]

/-- The octahedron's value is `θ²/‖W‖² = 25/60 = 5/12`, the record's catalogued `n = 6`
maximal torus. Written division-free: `(F/w²)² · 2w/(vk(v-1)) = 25 · 2 / 120`. -/
theorem octahedron_theta_sq : (25 : ℚ) * 2 / (6 * 4 * 5) = 5 / 12 := by norm_num

/-- **`μ = 4` is the admissible value and `μ = 3` is not**, the octahedron's non-adjacent
vertices are antipodal and share all four others. -/
theorem octahedron_mu_four : (4 : ℤ) * (4 - 2 - 1) = (6 - 4 - 1) * 4 := by norm_num

theorem octahedron_mu_three : (4 : ℤ) * (4 - 2 - 1) ≠ (6 - 4 - 1) * 3 := by norm_num

/-! ## The conference subfamily, and Petersen -/

/-- A conference graph is `SRG(4s+1, 2s, s-1, s)`. It satisfies the graph identity. -/
theorem conference_admissible (s : ℤ) :
    (2 * s) * (2 * s - (s - 1) - 1) = (4 * s + 1 - 2 * s - 1) * s := by ring

/-- **Every conference graph has `θ = 0`**: the numerator vanishes identically in `s`, so the
whole infinite subfamily degenerates. -/
theorem conference_F_zero (s : ℤ) : F (4 * s + 1) (2 * s) (s - 1) = 0 := by
  unfold F; ring

/-- `C₅ = SRG(5,2,0,1)` is the conference graph at `s = 1`. -/
theorem c5_is_conference : (5 : ℤ) = 4 * 1 + 1 ∧ (2 : ℤ) = 2 * 1 ∧ (0 : ℤ) = 1 - 1 := by
  norm_num

/-- **Petersen's `θ` does vanish**: `SRG(10,3,0,1)` gives `F = 0 + 54 - 90 + 36 = 0`. -/
theorem petersen_F_zero : F 10 3 0 = 0 := by norm_num [F]

/-- **But Petersen is not a conference graph.** A conference graph needs `2k = v - 1`, and
`2·3 ≠ 10 - 1`. So the block's *"The Petersen graph is another"* attaches the right
conclusion to the wrong family; the vanishing is a separate solution of `F = 0`. -/
theorem petersen_not_conference : 2 * (3 : ℤ) ≠ 10 - 1 := by norm_num

/-- No integer `s` makes Petersen's parameters conference parameters, the failure is not a
matter of which of the three equations is checked. -/
theorem petersen_no_s (s : ℤ) : ¬((10 : ℤ) = 4 * s + 1) := by omega

/-! ## Saturation, the two branches, each one linear condition -/

/-- **The `a < 0` branch.** `k/w = v/(v-2)` is `k = v/2`, i.e. `2k = v`. -/
theorem branch_neg (v k : ℤ) (hw : w v k ≠ 0) (hv : v - 2 ≠ 0) :
    k * (v - 2) = v * w v k ↔ 2 * k = v ∨ v = 1 := by
  unfold w
  constructor
  · intro h
    have : (2 * k - v) * (v - 1) = 0 := by ring_nf; ring_nf at h; linarith
    rcases mul_eq_zero.1 this with h' | h'
    · exact Or.inl (by linarith)
    · exact Or.inr (by linarith)
  · rintro (h | h) <;> [skip; skip] <;> subst_vars <;> ring

/-- **The `a > 0` branch.** `w/k = v/(v-2)` is `k = (v-2)/2`, i.e. `2k = v - 2`. -/
theorem branch_pos (v k : ℤ) :
    w v k * (v - 2) - v * k = -((2 * k - (v - 2)) * (v - 1)) := by
  unfold w; ring

/-! ## The two saturating families -/

/-- `K_{m,m} = SRG(2m, m, 0, m)` satisfies the graph identity and lies on the `2k = v`
branch. -/
theorem kmm_admissible (m : ℤ) : m * (m - 0 - 1) = (2 * m - m - 1) * m := by ring

/-- `2K_m = SRG(2m, m-1, m-2, 0)` satisfies the graph identity and lies on the `2k = v - 2`
branch. They are complements, hence the two sign branches of one point. -/
theorem twokm_admissible (m : ℤ) :
    (m - 1) * ((m - 1) - (m - 2) - 1) = (2 * m - (m - 1) - 1) * 0 := by ring

/-- **The uniqueness the block claims needs more than the identity.** Under `2k = v` the
identity is one equation in two unknowns and has a whole line of solutions, `SRG(8,4,3,0)`
sits on it alongside `SRG(8,4,0,4) = K_{4,4}`, so *"exactly two parameter families"* rests
on feasibility conditions the block does not name. -/
theorem branch_not_unique :
    (4 : ℤ) * (4 - 0 - 1) = (8 - 4 - 1) * 4 ∧ (4 : ℤ) * (4 - 3 - 1) = (8 - 4 - 1) * 0 := by
  norm_num

/-! ## The saturating value is `θ₀(2m)` -/

/-- `θ₀(2m)² = (2m-1)(m-1)/m²`, so `θ₀(2m) = √((2m-1)(m-1))/m`, the record's value at the
saturating member, from the even-`n` formula `θ₀(n)² = 2(n-1)(n-2)/n²`. -/
theorem theta0_balanced (m : ℚ) (hm : m ≠ 0) :
    2 * (2 * m - 1) * (2 * m - 2) / (2 * m) ^ 2 = (2 * m - 1) * (m - 1) / m ^ 2 := by
  field_simp

end HamiltonsCubic.SRG
