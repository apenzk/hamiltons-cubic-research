import Mathlib

/-!
# P does not extend to the Ricci-free or the scalar-flat operators at `n = 12`

[The I123 working note](../../../reviews/2026-09-28o-I123-coupling.md). On the `SO(4) × O(8)`-invariant
operators `α P₊ + β P₋ + b P_{𝔰𝔬(8)} + c P_mix` of `ℝ⁴ ⊕ ℝ⁸`, the note derives from the record's
`#` products the cubic `G` and the norm below. On the Ricci-free plane (the `S⁴ × S⁸` Weyl line
plus `t` times the `ℝ⁴` volume form) `G/‖X‖³` reaches `8√15015/715` against `θ₀(12) = √55/6`, and on
the `O(6) × O(6)` traceless plane the maximum `2√2310/77` also exceeds `θ₀(12)`.

**Typed**: the restriction of `G` and the norm to the Ricci-free plane (`G_plane`, `N_plane`), and
both comparisons as rational inequalities between squares (`ricci_free_beats`,
`scalar_flat_beats`). **Not typed**: the cubic itself from the `#` table, and the maximisations.
-/

namespace HamiltonsCubic.I123Lifts

/-- The cubic on the `SO(4) × O(8)`-invariant operators. -/
def G (α β b c : ℝ) : ℝ :=
  9 * α ^ 3 + 9 * β ^ 3 + 196 * b ^ 3 + 32 * c ^ 3 + 72 * (α + β) * c ^ 2 + 336 * b * c ^ 2

/-- The squared norm there. -/
def N (α β b c : ℝ) : ℝ := 3 * α ^ 2 + 3 * β ^ 2 + 28 * b ^ 2 + 32 * c ^ 2

/-- On the Ricci-free plane `α = -8/3 c + t`, `β = -8/3 c - t`, `b = -4/7 c`. -/
theorem G_plane (c t : ℝ) :
    G (-8 / 3 * c + t) (-8 / 3 * c - t) (-4 / 7 * c) c = -19360 / 21 * c ^ 3 - 144 * c * t ^ 2 := by
  unfold G; ring

theorem N_plane (c t : ℝ) :
    N (-8 / 3 * c + t) (-8 / 3 * c - t) (-4 / 7 * c) c = 1760 / 21 * c ^ 2 + 6 * t ^ 2 := by
  unfold N; ring

/-- **The Ricci-free witness beats `θ₀(12)`**: at `c = -1`, `t² = 3850/441`, `G² > (55/36) N³`, that
is `G / N^{3/2} > √55/6`, with `G > 0`. -/
theorem ricci_free_beats (t : ℝ) (ht : t ^ 2 = 3850 / 441) :
    0 < G (8 / 3 + t) (8 / 3 - t) (4 / 7) (-1) ∧
      55 / 36 * N (8 / 3 + t) (8 / 3 - t) (4 / 7) (-1) ^ 3
        < G (8 / 3 + t) (8 / 3 - t) (4 / 7) (-1) ^ 2 := by
  have hG := G_plane (-1) t
  have hN := N_plane (-1) t
  norm_num at hG hN
  rw [hG, hN, ht]
  norm_num

/-- **The scalar-flat witness beats `θ₀(12)`**: `(2√2310/77)² = 120/77 > 55/36`. -/
theorem scalar_flat_beats : (55 / 36 : ℝ) < 120 / 77 := by norm_num


/-- **At every even `n = 2m ≥ 8` the chirality tilt of `S⁴ × S^{2m-4}` beats `θ₀(2m)`.** The note
derives, from the `#` table on `ℝ⁴ ⊕ ℝ^q`, the tilted maximum `ρ² = 6q²(q-1)/((q+2)(q+3)(2q-3))` and
`θ₀(2m)² = (2m-1)(m-1)/m²`; with `q = 2m - 4` the comparison is this rational inequality, whose
cleared difference is `8k⁵ + 96k⁴ + 408k³ + 727k² + 498k + 99` at `m = k + 4`. -/
theorem tilt_beats_theta0 (m : ℝ) (hm : 4 ≤ m) :
    (2 * m - 1) * (m - 1) / m ^ 2
      < 12 * (m - 2) ^ 2 * (2 * m - 5) / ((m - 1) * (2 * m - 1) * (4 * m - 11)) := by
  have h1 : 0 < m ^ 2 := by positivity
  have h2 : 0 < (m - 1) * (2 * m - 1) * (4 * m - 11) := by
    have : 0 < m - 1 := by linarith
    have : 0 < 2 * m - 1 := by linarith
    have : 0 < 4 * m - 11 := by linarith
    positivity
  rw [div_lt_div_iff₀ h1 h2]
  obtain ⟨k, hk, rfl⟩ : ∃ k, 0 ≤ k ∧ m = k + 4 := ⟨m - 4, by linarith, by ring⟩
  nlinarith [pow_nonneg hk 2, pow_nonneg hk 3, pow_nonneg hk 4, pow_nonneg hk 5]

end HamiltonsCubic.I123Lifts
