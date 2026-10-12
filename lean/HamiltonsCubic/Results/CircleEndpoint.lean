import Mathlib

/-!
# (MG) on the great circle through the diagonal part, the scalar core

[reviews/2026-09-28-LIT-step8-sweep.md](../../../reviews/2026-09-28-LIT-step8-sweep.md), route R54.

**The source's statement.** "With `Â = A/t` and `ν = B/b`, on the circle
`u(φ) = cos φ Â + sin φ ν`, `g(φ) = P(u(φ)) = p cos³φ + 3 r cos φ sin²φ + q sin³φ`, the
`cos²φ sin φ` term vanishing because `Q(Â)` is diagonal. L214's relations are `ρ = t p + (b²/t) r`
and `q = (ρ - 2 t r)/b`. At a global maximiser `g ≤ ρ = g(φ₀)` and `p = g(0) ≤ ρ`, so above
`√(3/2)`, (MG) `⟺ p = ρ`."

**What is typed.**
* `circle_cubic`: for a symmetric trilinear form `T` with `T a a b = 0`, the cubic on the circle
  through `a` and `b` has no `cos² sin` term.
* `mg_iff_value`: above `√(3/2)` and with `p ≤ ρ`, (MG) is `p = ρ`.
* `g_at_W`: L214's relations alone give `g(φ₀) = ρ`, so after them the criterion is `p = ρ`,
  (MG) restated (r1821, r1822).
* `tie_of_mg`: under (MG) with `0 < t < 1`, L214's relations force `r = p t/(1 + t)` and the
  endpoint criterion `p q² ≤ (p + r)² (p - 2 r)` to hold with equality.

**Not typed**: the endpoint criterion's equivalence with the arc peaking at `φ = 0`, which is the
outside author's, rebuilt by r1801; and `T(Â, Â, ν) = 0`, which is L120's block diagonality.
-/

namespace HamiltonsCubic.CircleEndpoint

/-- **THE CIRCLE CUBIC.** A symmetric trilinear `T` with `T a a b = 0` restricted to
`c a + s b` is `c³ T a a a + 3 c s² T a b b + s³ T b b b`. -/
theorem circle_cubic {V : Type*} [AddCommGroup V] [Module ℝ V]
    (T : V →ₗ[ℝ] V →ₗ[ℝ] V →ₗ[ℝ] ℝ)
    (h12 : ∀ x y z, T x y z = T y x z) (h23 : ∀ x y z, T x y z = T x z y)
    (a b : V) (hab : T a a b = 0) (c s : ℝ) :
    T (c • a + s • b) (c • a + s • b) (c • a + s • b)
      = c ^ 3 * T a a a + 3 * c * s ^ 2 * T a b b + s ^ 3 * T b b b := by
  have e1 : T a b a = 0 := by rw [← h23]; exact hab
  have e2 : T b a a = 0 := by rw [← h12]; exact e1
  have e3 : T b a b = T a b b := by rw [h12]
  have e4 : T b b a = T a b b := by rw [h23, h12]
  simp only [map_add, map_smul, LinearMap.add_apply, LinearMap.smul_apply, smul_eq_mul]
  rw [hab, e1, e2, e3, e4]
  ring

/-- **(MG) IS `p = ρ`** above `√(3/2)`, once `p ≤ ρ` (global maximality against `Â`). -/
theorem mg_iff_value (ρ p : ℝ) (hρ : Real.sqrt (3 / 2) < ρ) (hp : p ≤ ρ) :
    ρ ≤ max (Real.sqrt (3 / 2)) p ↔ p = ρ := by
  rw [le_max_iff]
  constructor
  · rintro (h | h)
    · exact absurd h (not_le.mpr hρ)
    · exact le_antisymm hp h
  · intro h; right; rw [h]

/-- **THE TIE.** Under (MG) (`p = ρ`) with `0 < t < 1`, `b² = 1 - t²` and L214's relations, the
coupling is `r = p t/(1 + t)` and the endpoint criterion holds with equality. -/
theorem tie_of_mg (p r q t b : ℝ) (ht : 0 < t) (ht1 : t < 1) (hb : 0 < b)
    (hunit : t ^ 2 + b ^ 2 = 1)
    (hrho : p = t * p + b ^ 2 / t * r) (hq : q = (p - 2 * t * r) / b) :
    r = p * t / (1 + t) ∧ p * q ^ 2 = (p + r) ^ 2 * (p - 2 * r) := by
  have h1 : 0 < 1 + t := by linarith
  have hb2 : b ^ 2 = (1 - t) * (1 + t) := by nlinarith
  have hr : r = p * t / (1 + t) := by
    have hk : (1 - t) * p * t = b ^ 2 * r := by
      field_simp at hrho; nlinarith
    rw [hb2] at hk
    have h1t : 0 < 1 - t := by linarith
    field_simp
    nlinarith [mul_pos h1t h1]
  refine ⟨hr, ?_⟩
  rw [hq, hr]
  field_simp
  rw [hb2]
  ring

/-- **THE CUBIC AT `W`.** L214's relations alone give `g(φ₀) = ρ`: with `cos φ₀ = t`,
`sin φ₀ = b`, `t³ p + 3 t b² r + b³ q = ρ` (r1822). -/
theorem g_at_W (p r q t b ρ : ℝ) (ht : 0 < t) (hb : 0 < b) (hunit : t ^ 2 + b ^ 2 = 1)
    (hrho : ρ = t * p + b ^ 2 / t * r) (hq : q = (ρ - 2 * t * r) / b) :
    t ^ 3 * p + 3 * t * b ^ 2 * r + b ^ 3 * q = ρ := by
  rw [hq]
  have hb0 : b ≠ 0 := hb.ne'
  have ht0 : t ≠ 0 := ht.ne'
  field_simp
  rw [hrho]
  field_simp
  have hb2 : b ^ 2 = 1 - t ^ 2 := by linarith
  rw [hb2]
  ring

end HamiltonsCubic.CircleEndpoint
