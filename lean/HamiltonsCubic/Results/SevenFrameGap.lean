import Mathlib

/-!
# The triangle gap of the seven-frame stability reduction

[I73](../../../plan.md)'s seven-frame lemma asks that every orthonormal seven-frame in `𝔰𝔬(n)` have
ordered bracket total at most `54.06`. [The stability note](../../../reviews/2026-09-24-I73-seven-frame-stability.md)
takes the element of smallest row deficit `x`, with angles `a₁, a₂, a₃` on its top triangle of
planes and a further angle `b`, and charges the partners' leak `η` against row `0`:
`g η ≤ x - y`, `g` the spectral gap and `y` the angle deficit. **This file proves the gap is large
enough**: `½ g + y ≥ 0.277` against every competing slot, so `η ≤ ½` whenever `x < 0.277`.

`yT` is `y = 8(1 - Σaₖ²) + 2Σ(aₖ - aₗ)²`. The three competing slots are a slot joining the third
plane (`triangle_gap_other`), a slot joining a plane of the pair (`triangle_gap_same`, which with
`b = 0` also covers the kernel slot `aₖ²` and every difference slot `(aₚ - a_q)² ≤ max(aₚ, a_q)²`),
and a slot of the leftover mass (`triangle_gap_small`, `(b_m ± b_m')² ≤ 2B`). Relabelling covers
every pair of the triangle. **The proof** is the variance fact `(aᵢ - σ/3)² ≤ ⅔(Σaₖ² - σ²/3)`, which
turns the deficit into `y ≥ 8B + 9u²`, and then a concave quadratic in `(b, u)` for each slot
(`gap_core_other`, `gap_core_same`, `gap_core_small`), whose worst value is about `0.38`.

The neighbourhood section bounds the fifty-two other three-slot configurations by `3733/1000` for
nonnegative angles, so near-extremal elements are triangles or stars; the later sections carry
the partner-deficit route and the star side.

**What this file does NOT state**: the slot spectrum of `-ad_X²`, the reduction (R1)-(R3) and the
assembly into `T ≤ 54.06` on the triangle side, which are prose in the note.
-/

namespace HamiltonsCubic.SevenFrameGap

/-- **The gap core when the competing slot joins the third plane**: `σ` the angle sum,
`u ≥ |aᵢ - σ/3|`, `b` a further angle, `B ≥ b²` the mass off the triangle, `y = 8B + 6w`. -/
theorem gap_core_other (σ u b B y : ℝ) (_hσ0 : 0 ≤ σ) (hσ : σ ≤ 17321/10000) (hu : 0 ≤ u)
    (hb : 0 ≤ b) (hbB : b^2 ≤ B) (hy : 8 * B + 9 * u^2 ≤ y)
    (hsig : σ^2 = 3 * (1 - B) - (y - 8 * B) / 2) :
    1/2 * ((σ / 3 - 2 * u - b) * (σ + b)) + y ≥ 277/1000 := by
  nlinarith [mul_nonneg _hσ0 hb, mul_nonneg hu hb, mul_nonneg _hσ0 hu,
    mul_nonneg (sub_nonneg.2 hσ) hb, mul_nonneg (sub_nonneg.2 hσ) hu,
    sq_nonneg (b - 1/20), sq_nonneg (u - 11/100), sq_nonneg (b - u)]

/-- **The gap core when the competing slot joins a plane of the pair.** -/
theorem gap_core_same (σ u b B y : ℝ) (_hσ0 : 0 ≤ σ) (hσ : σ ≤ 17321/10000) (hu : 0 ≤ u)
    (hb : 0 ≤ b) (hbB : b^2 ≤ B) (hy : 8 * B + 9 * u^2 ≤ y)
    (hsig : σ^2 = 3 * (1 - B) - (y - 8 * B) / 2) :
    1/2 * ((σ / 3 - u - b) * (σ + b)) - u + y ≥ 277/1000 := by
  nlinarith [mul_nonneg _hσ0 hb, mul_nonneg hu hb, mul_nonneg _hσ0 hu,
    mul_nonneg (sub_nonneg.2 hσ) hb, mul_nonneg (sub_nonneg.2 hσ) hu,
    sq_nonneg (b - 1/20), sq_nonneg (u - 11/100), sq_nonneg (b - u)]

/-- **The gap core against a slot of the leftover mass**, `(b + b')² ≤ 2B`. -/
theorem gap_core_small (σ u p B y : ℝ) (hσ0 : 0 ≤ σ) (hu : 0 ≤ u) (hp0 : 0 ≤ p)
    (hp : 2 * σ / 3 - u ≤ p) (hB : 0 ≤ B) (hy : 8 * B + 9 * u^2 ≤ y)
    (hsig : σ^2 = 3 * (1 - B) - (y - 8 * B) / 2) :
    1/2 * (p^2 - 2 * B) + y ≥ 277/1000 := by
  rcases le_total 0 (2 * σ / 3 - u) with h | h
  · have hp2 : (2 * σ / 3 - u)^2 ≤ p^2 := by nlinarith
    nlinarith [mul_nonneg hσ0 hu, sq_nonneg (u - 1/5)]
  · nlinarith [mul_nonneg hσ0 hu]

/-- The variance fact: each of three numbers lies within `√(2w/3)` of their mean. -/
theorem dev_sq_le (a1 a2 a3 : ℝ) :
    (a3 - (a1 + a2 + a3) / 3)^2 ≤ 2/3 * ((a1^2 + a2^2 + a3^2) - (a1 + a2 + a3)^2 / 3) := by
  nlinarith [sq_nonneg (a1 - a2)]

theorem diff_sq_le (a1 a2 a3 : ℝ) :
    ((a1 - a3) / 2)^2 ≤ 2/3 * ((a1^2 + a2^2 + a3^2) - (a1 + a2 + a3)^2 / 3) := by
  nlinarith [sq_nonneg (a1 + a3 - 2 * a2)]

/-- The angle deficit of the triangle `(a1, a2, a3)`. -/
def yT (a1 a2 a3 : ℝ) : ℝ :=
  8 * (1 - (a1^2 + a2^2 + a3^2)) + 2 * ((a1 - a2)^2 + (a1 - a3)^2 + (a2 - a3)^2)

section Link
variable (a1 a2 a3 b : ℝ) (h1 : 0 ≤ a1) (h2 : 0 ≤ a2) (h3 : 0 ≤ a3) (hb : 0 ≤ b)
  (hs : a1^2 + a2^2 + a3^2 + b^2 ≤ 1)
include h1 h2 h3 hb hs

omit h1 h2 h3 hb in
private theorem sig_le : a1 + a2 + a3 ≤ 17321/10000 := by
  nlinarith [sq_nonneg (a1 - a2), sq_nonneg (a1 - a3), sq_nonneg (a2 - a3),
    sq_nonneg (a1 + a2 + a3 - 17321/10000)]

omit h1 h2 h3 hb hs in
private theorem sig_eq :
    (a1 + a2 + a3)^2 = 3 * (1 - (1 - (a1^2 + a2^2 + a3^2)))
      - (yT a1 a2 a3 - 8 * (1 - (a1^2 + a2^2 + a3^2))) / 2 := by
  unfold yT; ring

/-- **The triangle gap, against a slot joining the third plane.** -/
theorem triangle_gap_other :
    1/2 * ((a1 + a2)^2 - (a3 + b)^2) + yT a1 a2 a3 ≥ 277/1000 := by
  set σ := a1 + a2 + a3
  set u := |a3 - σ / 3|
  have hu : 0 ≤ u := abs_nonneg _
  have hu2 : u^2 = (a3 - σ / 3)^2 := sq_abs _
  have ha3 : a3 ≤ σ / 3 + u := by have := le_abs_self (a3 - σ / 3); linarith
  have hy : 8 * (1 - (a1^2 + a2^2 + a3^2)) + 9 * u^2 ≤ yT a1 a2 a3 := by
    have := dev_sq_le a1 a2 a3; unfold yT; nlinarith
  have core := gap_core_other σ u b (1 - (a1^2 + a2^2 + a3^2)) (yT a1 a2 a3) (by positivity)
    (sig_le a1 a2 a3 b hs) hu hb (by linarith) hy (sig_eq a1 a2 a3)
  have hfac : (a1 + a2)^2 - (a3 + b)^2 = (σ - 2 * a3 - b) * (σ + b) := by ring
  have hmono : (σ / 3 - 2 * u - b) * (σ + b) ≤ (σ - 2 * a3 - b) * (σ + b) :=
    mul_le_mul_of_nonneg_right (by linarith) (by positivity)
  rw [hfac]; linarith

/-- **The triangle gap, against a slot joining a plane of the pair.** -/
theorem triangle_gap_same :
    1/2 * ((a1 + a2)^2 - (a1 + b)^2) + yT a1 a2 a3 ≥ 277/1000 := by
  set σ := a1 + a2 + a3
  set u := max |a2 - σ / 3| (|a1 - a3| / 2)
  have hu : 0 ≤ u := le_trans (abs_nonneg _) (le_max_left _ _)
  have hdev : (a2 - σ / 3)^2 ≤ 2/3 * ((a1^2 + a2^2 + a3^2) - σ^2 / 3) := by
    have := dev_sq_le a1 a3 a2; ring_nf at this ⊢; linarith
  have hdif := diff_sq_le a1 a2 a3
  have hu2 : 3/2 * u^2 ≤ (a1^2 + a2^2 + a3^2) - σ^2 / 3 := by
    rcases le_total |a2 - σ / 3| (|a1 - a3| / 2) with h | h
    · have hue : u = |a1 - a3| / 2 := max_eq_right h
      rw [hue]
      have : (|a1 - a3| / 2)^2 = ((a1 - a3) / 2)^2 := by rw [div_pow, sq_abs, div_pow]
      nlinarith
    · have hue : u = |a2 - σ / 3| := max_eq_left h
      rw [hue, sq_abs]; nlinarith
  have ha2 : σ / 3 - u ≤ a2 := by
    have := neg_abs_le (a2 - σ / 3); have := le_max_left |a2 - σ / 3| (|a1 - a3| / 2); linarith
  have hd : |a1 - a3| ≤ 2 * u := by have := le_max_right |a2 - σ / 3| (|a1 - a3| / 2); linarith
  have hy : 8 * (1 - (a1^2 + a2^2 + a3^2)) + 9 * u^2 ≤ yT a1 a2 a3 := by unfold yT; nlinarith
  have core := gap_core_same σ u b (1 - (a1^2 + a2^2 + a3^2)) (yT a1 a2 a3) (by positivity)
    (sig_le a1 a2 a3 b hs) hu hb (by linarith) hy (sig_eq a1 a2 a3)
  have hfac : (a1 + a2)^2 - (a1 + b)^2 = (a2 - b) * (σ + b) + (a2 - b) * (a1 - a3) := by ring
  have hmono : (σ / 3 - u - b) * (σ + b) ≤ (a2 - b) * (σ + b) :=
    mul_le_mul_of_nonneg_right (by linarith) (by positivity)
  have ha2b : |a2 - b| ≤ 1 := by
    rw [abs_le]; constructor <;> nlinarith
  have hcross : -(2 * u) ≤ (a2 - b) * (a1 - a3) := by
    have := abs_mul (a2 - b) (a1 - a3)
    have h' : |(a2 - b) * (a1 - a3)| ≤ 2 * u := by
      rw [this]; calc |a2 - b| * |a1 - a3| ≤ 1 * (2 * u) :=
            mul_le_mul ha2b hd (abs_nonneg _) zero_le_one
        _ = 2 * u := one_mul _
    linarith [neg_abs_le ((a2 - b) * (a1 - a3))]
  rw [hfac]; linarith

/-- **The triangle gap, against a slot of the leftover mass**, `(b_m ± b_m')² ≤ 2B`. -/
theorem triangle_gap_small :
    1/2 * ((a1 + a2)^2 - 2 * (1 - (a1^2 + a2^2 + a3^2))) + yT a1 a2 a3 ≥ 277/1000 := by
  set σ := a1 + a2 + a3
  set u := |a3 - σ / 3|
  have hu : 0 ≤ u := abs_nonneg _
  have hu2 : u^2 = (a3 - σ / 3)^2 := sq_abs _
  have ha3 : a3 ≤ σ / 3 + u := by have := le_abs_self (a3 - σ / 3); linarith
  have hy : 8 * (1 - (a1^2 + a2^2 + a3^2)) + 9 * u^2 ≤ yT a1 a2 a3 := by
    have := dev_sq_le a1 a2 a3; unfold yT; nlinarith
  exact gap_core_small σ u (a1 + a2) (1 - (a1^2 + a2^2 + a3^2)) (yT a1 a2 a3) (by positivity) hu
    (by positivity) (by linarith) (by nlinarith) hy (sig_eq a1 a2 a3)

end Link


/-! ## The neighbourhood of `κ₆`: near-extremal elements are triangles or stars

**Every three-slot configuration other than the all-plus triangle and star has slot sum at most
`3733/1000` times the angles' squared norm, for nonnegative angles.** There are fifty-four
configurations up to relabelling, counting plus slots, minus slots and kernel loops on up to six
planes; the two extremal ones reach `4`, two more reach exactly `2 + √3 ≈ 3.7321` (the path with a
kernel slot, and the star with one minus slot), and the rest are at most `2 + √2`. So an element
whose row exceeds `8 - 2(3.733) = 7.466` has a triangle or a star on top, and any element's deficit
is at least `0.534` when its top configuration is neither. *Nonnegativity is needed: a minus slot
turns into a plus slot under a sign change.* -/

set_option maxHeartbeats 400000 in
theorem slot_ceiling_0 (a b c d : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) (hd : 0 ≤ d) :
    (a + b)^2 + (a + c)^2 + (b + d)^2 ≤ 3733/1000 * (a^2 + b^2 + c^2 + d^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (a - d), sq_nonneg (b - c), sq_nonneg (b - d), sq_nonneg (c - d), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg ha hd, mul_nonneg hb hc, mul_nonneg hb hd, mul_nonneg hc hd, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (d - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (d - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c), sq_nonneg (d - 1000/2733 * c), sq_nonneg (a - 1000/2733 * d), sq_nonneg (b - 1000/2733 * d), sq_nonneg (c - 1000/2733 * d)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_1 (a b c d e : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) (hd : 0 ≤ d) (he : 0 ≤ e) :
    (a + b)^2 + (a + c)^2 + (d + e)^2 ≤ 3733/1000 * (a^2 + b^2 + c^2 + d^2 + e^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (a - d), sq_nonneg (a - e), sq_nonneg (b - c), sq_nonneg (b - d), sq_nonneg (b - e), sq_nonneg (c - d), sq_nonneg (c - e), sq_nonneg (d - e), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg ha hd, mul_nonneg ha he, mul_nonneg hb hc, mul_nonneg hb hd, mul_nonneg hb he, mul_nonneg hc hd, mul_nonneg hc he, mul_nonneg hd he, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (d - 1000/2733 * a), sq_nonneg (e - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (d - 1000/2733 * b), sq_nonneg (e - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c), sq_nonneg (d - 1000/2733 * c), sq_nonneg (e - 1000/2733 * c), sq_nonneg (a - 1000/2733 * d), sq_nonneg (b - 1000/2733 * d), sq_nonneg (c - 1000/2733 * d), sq_nonneg (e - 1000/2733 * d), sq_nonneg (a - 1000/2733 * e), sq_nonneg (b - 1000/2733 * e), sq_nonneg (c - 1000/2733 * e), sq_nonneg (d - 1000/2733 * e)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_2 (a b c : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) :
    (a + b)^2 + (a + c)^2 + (a - b)^2 ≤ 3733/1000 * (a^2 + b^2 + c^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (b - c), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg hb hc, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_3 (a b c d : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) (hd : 0 ≤ d) :
    (a + b)^2 + (a + c)^2 + (a - d)^2 ≤ 3733/1000 * (a^2 + b^2 + c^2 + d^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (a - d), sq_nonneg (b - c), sq_nonneg (b - d), sq_nonneg (c - d), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg ha hd, mul_nonneg hb hc, mul_nonneg hb hd, mul_nonneg hc hd, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (d - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (d - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c), sq_nonneg (d - 1000/2733 * c), sq_nonneg (a - 1000/2733 * d), sq_nonneg (b - 1000/2733 * d), sq_nonneg (c - 1000/2733 * d)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_4 (a b c : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) :
    (a + b)^2 + (a + c)^2 + (b - c)^2 ≤ 3733/1000 * (a^2 + b^2 + c^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (b - c), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg hb hc, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_5 (a b c d : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) (hd : 0 ≤ d) :
    (a + b)^2 + (a + c)^2 + (b - d)^2 ≤ 3733/1000 * (a^2 + b^2 + c^2 + d^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (a - d), sq_nonneg (b - c), sq_nonneg (b - d), sq_nonneg (c - d), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg ha hd, mul_nonneg hb hc, mul_nonneg hb hd, mul_nonneg hc hd, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (d - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (d - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c), sq_nonneg (d - 1000/2733 * c), sq_nonneg (a - 1000/2733 * d), sq_nonneg (b - 1000/2733 * d), sq_nonneg (c - 1000/2733 * d)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_6 (a b c d e : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) (hd : 0 ≤ d) (he : 0 ≤ e) :
    (a + b)^2 + (a + c)^2 + (d - e)^2 ≤ 3733/1000 * (a^2 + b^2 + c^2 + d^2 + e^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (a - d), sq_nonneg (a - e), sq_nonneg (b - c), sq_nonneg (b - d), sq_nonneg (b - e), sq_nonneg (c - d), sq_nonneg (c - e), sq_nonneg (d - e), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg ha hd, mul_nonneg ha he, mul_nonneg hb hc, mul_nonneg hb hd, mul_nonneg hb he, mul_nonneg hc hd, mul_nonneg hc he, mul_nonneg hd he, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (d - 1000/2733 * a), sq_nonneg (e - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (d - 1000/2733 * b), sq_nonneg (e - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c), sq_nonneg (d - 1000/2733 * c), sq_nonneg (e - 1000/2733 * c), sq_nonneg (a - 1000/2733 * d), sq_nonneg (b - 1000/2733 * d), sq_nonneg (c - 1000/2733 * d), sq_nonneg (e - 1000/2733 * d), sq_nonneg (a - 1000/2733 * e), sq_nonneg (b - 1000/2733 * e), sq_nonneg (c - 1000/2733 * e), sq_nonneg (d - 1000/2733 * e)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_7 (a b c : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) :
    (a + b)^2 + (a + c)^2 + a^2 ≤ 3733/1000 * (a^2 + b^2 + c^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (b - c), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg hb hc, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_8 (a b c : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) :
    (a + b)^2 + (a + c)^2 + b^2 ≤ 3733/1000 * (a^2 + b^2 + c^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (b - c), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg hb hc, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_9 (a b c d : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) (hd : 0 ≤ d) :
    (a + b)^2 + (a + c)^2 + d^2 ≤ 3733/1000 * (a^2 + b^2 + c^2 + d^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (a - d), sq_nonneg (b - c), sq_nonneg (b - d), sq_nonneg (c - d), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg ha hd, mul_nonneg hb hc, mul_nonneg hb hd, mul_nonneg hc hd, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (d - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (d - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c), sq_nonneg (d - 1000/2733 * c), sq_nonneg (a - 1000/2733 * d), sq_nonneg (b - 1000/2733 * d), sq_nonneg (c - 1000/2733 * d)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_10 (a b c d e f : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) (hd : 0 ≤ d) (he : 0 ≤ e) (hf : 0 ≤ f) :
    (a + b)^2 + (c + d)^2 + (e + f)^2 ≤ 3733/1000 * (a^2 + b^2 + c^2 + d^2 + e^2 + f^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (a - d), sq_nonneg (a - e), sq_nonneg (a - f), sq_nonneg (b - c), sq_nonneg (b - d), sq_nonneg (b - e), sq_nonneg (b - f), sq_nonneg (c - d), sq_nonneg (c - e), sq_nonneg (c - f), sq_nonneg (d - e), sq_nonneg (d - f), sq_nonneg (e - f), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg ha hd, mul_nonneg ha he, mul_nonneg ha hf, mul_nonneg hb hc, mul_nonneg hb hd, mul_nonneg hb he, mul_nonneg hb hf, mul_nonneg hc hd, mul_nonneg hc he, mul_nonneg hc hf, mul_nonneg hd he, mul_nonneg hd hf, mul_nonneg he hf, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (d - 1000/2733 * a), sq_nonneg (e - 1000/2733 * a), sq_nonneg (f - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (d - 1000/2733 * b), sq_nonneg (e - 1000/2733 * b), sq_nonneg (f - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c), sq_nonneg (d - 1000/2733 * c), sq_nonneg (e - 1000/2733 * c), sq_nonneg (f - 1000/2733 * c), sq_nonneg (a - 1000/2733 * d), sq_nonneg (b - 1000/2733 * d), sq_nonneg (c - 1000/2733 * d), sq_nonneg (e - 1000/2733 * d), sq_nonneg (f - 1000/2733 * d), sq_nonneg (a - 1000/2733 * e), sq_nonneg (b - 1000/2733 * e), sq_nonneg (c - 1000/2733 * e), sq_nonneg (d - 1000/2733 * e), sq_nonneg (f - 1000/2733 * e), sq_nonneg (a - 1000/2733 * f), sq_nonneg (b - 1000/2733 * f), sq_nonneg (c - 1000/2733 * f), sq_nonneg (d - 1000/2733 * f), sq_nonneg (e - 1000/2733 * f)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_11 (a b c d : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) (hd : 0 ≤ d) :
    (a + b)^2 + (c + d)^2 + (a - b)^2 ≤ 3733/1000 * (a^2 + b^2 + c^2 + d^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (a - d), sq_nonneg (b - c), sq_nonneg (b - d), sq_nonneg (c - d), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg ha hd, mul_nonneg hb hc, mul_nonneg hb hd, mul_nonneg hc hd, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (d - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (d - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c), sq_nonneg (d - 1000/2733 * c), sq_nonneg (a - 1000/2733 * d), sq_nonneg (b - 1000/2733 * d), sq_nonneg (c - 1000/2733 * d)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_12 (a b c d : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) (hd : 0 ≤ d) :
    (a + b)^2 + (c + d)^2 + (a - c)^2 ≤ 3733/1000 * (a^2 + b^2 + c^2 + d^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (a - d), sq_nonneg (b - c), sq_nonneg (b - d), sq_nonneg (c - d), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg ha hd, mul_nonneg hb hc, mul_nonneg hb hd, mul_nonneg hc hd, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (d - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (d - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c), sq_nonneg (d - 1000/2733 * c), sq_nonneg (a - 1000/2733 * d), sq_nonneg (b - 1000/2733 * d), sq_nonneg (c - 1000/2733 * d)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_13 (a b c d e : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) (hd : 0 ≤ d) (he : 0 ≤ e) :
    (a + b)^2 + (c + d)^2 + (a - e)^2 ≤ 3733/1000 * (a^2 + b^2 + c^2 + d^2 + e^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (a - d), sq_nonneg (a - e), sq_nonneg (b - c), sq_nonneg (b - d), sq_nonneg (b - e), sq_nonneg (c - d), sq_nonneg (c - e), sq_nonneg (d - e), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg ha hd, mul_nonneg ha he, mul_nonneg hb hc, mul_nonneg hb hd, mul_nonneg hb he, mul_nonneg hc hd, mul_nonneg hc he, mul_nonneg hd he, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (d - 1000/2733 * a), sq_nonneg (e - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (d - 1000/2733 * b), sq_nonneg (e - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c), sq_nonneg (d - 1000/2733 * c), sq_nonneg (e - 1000/2733 * c), sq_nonneg (a - 1000/2733 * d), sq_nonneg (b - 1000/2733 * d), sq_nonneg (c - 1000/2733 * d), sq_nonneg (e - 1000/2733 * d), sq_nonneg (a - 1000/2733 * e), sq_nonneg (b - 1000/2733 * e), sq_nonneg (c - 1000/2733 * e), sq_nonneg (d - 1000/2733 * e)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_14 (a b c d e f : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) (hd : 0 ≤ d) (he : 0 ≤ e) (hf : 0 ≤ f) :
    (a + b)^2 + (c + d)^2 + (e - f)^2 ≤ 3733/1000 * (a^2 + b^2 + c^2 + d^2 + e^2 + f^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (a - d), sq_nonneg (a - e), sq_nonneg (a - f), sq_nonneg (b - c), sq_nonneg (b - d), sq_nonneg (b - e), sq_nonneg (b - f), sq_nonneg (c - d), sq_nonneg (c - e), sq_nonneg (c - f), sq_nonneg (d - e), sq_nonneg (d - f), sq_nonneg (e - f), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg ha hd, mul_nonneg ha he, mul_nonneg ha hf, mul_nonneg hb hc, mul_nonneg hb hd, mul_nonneg hb he, mul_nonneg hb hf, mul_nonneg hc hd, mul_nonneg hc he, mul_nonneg hc hf, mul_nonneg hd he, mul_nonneg hd hf, mul_nonneg he hf, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (d - 1000/2733 * a), sq_nonneg (e - 1000/2733 * a), sq_nonneg (f - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (d - 1000/2733 * b), sq_nonneg (e - 1000/2733 * b), sq_nonneg (f - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c), sq_nonneg (d - 1000/2733 * c), sq_nonneg (e - 1000/2733 * c), sq_nonneg (f - 1000/2733 * c), sq_nonneg (a - 1000/2733 * d), sq_nonneg (b - 1000/2733 * d), sq_nonneg (c - 1000/2733 * d), sq_nonneg (e - 1000/2733 * d), sq_nonneg (f - 1000/2733 * d), sq_nonneg (a - 1000/2733 * e), sq_nonneg (b - 1000/2733 * e), sq_nonneg (c - 1000/2733 * e), sq_nonneg (d - 1000/2733 * e), sq_nonneg (f - 1000/2733 * e), sq_nonneg (a - 1000/2733 * f), sq_nonneg (b - 1000/2733 * f), sq_nonneg (c - 1000/2733 * f), sq_nonneg (d - 1000/2733 * f), sq_nonneg (e - 1000/2733 * f)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_15 (a b c d : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) (hd : 0 ≤ d) :
    (a + b)^2 + (c + d)^2 + a^2 ≤ 3733/1000 * (a^2 + b^2 + c^2 + d^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (a - d), sq_nonneg (b - c), sq_nonneg (b - d), sq_nonneg (c - d), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg ha hd, mul_nonneg hb hc, mul_nonneg hb hd, mul_nonneg hc hd, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (d - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (d - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c), sq_nonneg (d - 1000/2733 * c), sq_nonneg (a - 1000/2733 * d), sq_nonneg (b - 1000/2733 * d), sq_nonneg (c - 1000/2733 * d)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_16 (a b c d e : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) (hd : 0 ≤ d) (he : 0 ≤ e) :
    (a + b)^2 + (c + d)^2 + e^2 ≤ 3733/1000 * (a^2 + b^2 + c^2 + d^2 + e^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (a - d), sq_nonneg (a - e), sq_nonneg (b - c), sq_nonneg (b - d), sq_nonneg (b - e), sq_nonneg (c - d), sq_nonneg (c - e), sq_nonneg (d - e), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg ha hd, mul_nonneg ha he, mul_nonneg hb hc, mul_nonneg hb hd, mul_nonneg hb he, mul_nonneg hc hd, mul_nonneg hc he, mul_nonneg hd he, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (d - 1000/2733 * a), sq_nonneg (e - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (d - 1000/2733 * b), sq_nonneg (e - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c), sq_nonneg (d - 1000/2733 * c), sq_nonneg (e - 1000/2733 * c), sq_nonneg (a - 1000/2733 * d), sq_nonneg (b - 1000/2733 * d), sq_nonneg (c - 1000/2733 * d), sq_nonneg (e - 1000/2733 * d), sq_nonneg (a - 1000/2733 * e), sq_nonneg (b - 1000/2733 * e), sq_nonneg (c - 1000/2733 * e), sq_nonneg (d - 1000/2733 * e)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_17 (a b c : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) :
    (a + b)^2 + (a - b)^2 + (a - c)^2 ≤ 3733/1000 * (a^2 + b^2 + c^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (b - c), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg hb hc, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_18 (a b c d : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) (hd : 0 ≤ d) :
    (a + b)^2 + (a - b)^2 + (c - d)^2 ≤ 3733/1000 * (a^2 + b^2 + c^2 + d^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (a - d), sq_nonneg (b - c), sq_nonneg (b - d), sq_nonneg (c - d), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg ha hd, mul_nonneg hb hc, mul_nonneg hb hd, mul_nonneg hc hd, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (d - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (d - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c), sq_nonneg (d - 1000/2733 * c), sq_nonneg (a - 1000/2733 * d), sq_nonneg (b - 1000/2733 * d), sq_nonneg (c - 1000/2733 * d)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_19 (a b : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) :
    (a + b)^2 + (a - b)^2 + a^2 ≤ 3733/1000 * (a^2 + b^2) := by
  nlinarith [sq_nonneg (a - b), mul_nonneg ha hb, sq_nonneg (b - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_20 (a b c : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) :
    (a + b)^2 + (a - b)^2 + c^2 ≤ 3733/1000 * (a^2 + b^2 + c^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (b - c), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg hb hc, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_21 (a b c d : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) (hd : 0 ≤ d) :
    (a + b)^2 + (a - c)^2 + (a - d)^2 ≤ 3733/1000 * (a^2 + b^2 + c^2 + d^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (a - d), sq_nonneg (b - c), sq_nonneg (b - d), sq_nonneg (c - d), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg ha hd, mul_nonneg hb hc, mul_nonneg hb hd, mul_nonneg hc hd, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (d - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (d - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c), sq_nonneg (d - 1000/2733 * c), sq_nonneg (a - 1000/2733 * d), sq_nonneg (b - 1000/2733 * d), sq_nonneg (c - 1000/2733 * d)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_22 (a b c : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) :
    (a + b)^2 + (a - c)^2 + (b - c)^2 ≤ 3733/1000 * (a^2 + b^2 + c^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (b - c), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg hb hc, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_23 (a b c d : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) (hd : 0 ≤ d) :
    (a + b)^2 + (a - c)^2 + (b - d)^2 ≤ 3733/1000 * (a^2 + b^2 + c^2 + d^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (a - d), sq_nonneg (b - c), sq_nonneg (b - d), sq_nonneg (c - d), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg ha hd, mul_nonneg hb hc, mul_nonneg hb hd, mul_nonneg hc hd, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (d - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (d - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c), sq_nonneg (d - 1000/2733 * c), sq_nonneg (a - 1000/2733 * d), sq_nonneg (b - 1000/2733 * d), sq_nonneg (c - 1000/2733 * d)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_24 (a b c d : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) (hd : 0 ≤ d) :
    (a + b)^2 + (a - c)^2 + (c - d)^2 ≤ 3733/1000 * (a^2 + b^2 + c^2 + d^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (a - d), sq_nonneg (b - c), sq_nonneg (b - d), sq_nonneg (c - d), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg ha hd, mul_nonneg hb hc, mul_nonneg hb hd, mul_nonneg hc hd, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (d - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (d - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c), sq_nonneg (d - 1000/2733 * c), sq_nonneg (a - 1000/2733 * d), sq_nonneg (b - 1000/2733 * d), sq_nonneg (c - 1000/2733 * d)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_25 (a b c d e : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) (hd : 0 ≤ d) (he : 0 ≤ e) :
    (a + b)^2 + (a - c)^2 + (d - e)^2 ≤ 3733/1000 * (a^2 + b^2 + c^2 + d^2 + e^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (a - d), sq_nonneg (a - e), sq_nonneg (b - c), sq_nonneg (b - d), sq_nonneg (b - e), sq_nonneg (c - d), sq_nonneg (c - e), sq_nonneg (d - e), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg ha hd, mul_nonneg ha he, mul_nonneg hb hc, mul_nonneg hb hd, mul_nonneg hb he, mul_nonneg hc hd, mul_nonneg hc he, mul_nonneg hd he, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (d - 1000/2733 * a), sq_nonneg (e - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (d - 1000/2733 * b), sq_nonneg (e - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c), sq_nonneg (d - 1000/2733 * c), sq_nonneg (e - 1000/2733 * c), sq_nonneg (a - 1000/2733 * d), sq_nonneg (b - 1000/2733 * d), sq_nonneg (c - 1000/2733 * d), sq_nonneg (e - 1000/2733 * d), sq_nonneg (a - 1000/2733 * e), sq_nonneg (b - 1000/2733 * e), sq_nonneg (c - 1000/2733 * e), sq_nonneg (d - 1000/2733 * e)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_26 (a b c : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) :
    (a + b)^2 + (a - c)^2 + a^2 ≤ 3733/1000 * (a^2 + b^2 + c^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (b - c), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg hb hc, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_27 (a b c : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) :
    (a + b)^2 + (a - c)^2 + b^2 ≤ 3733/1000 * (a^2 + b^2 + c^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (b - c), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg hb hc, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_28 (a b c : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) :
    (a + b)^2 + (a - c)^2 + c^2 ≤ 3733/1000 * (a^2 + b^2 + c^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (b - c), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg hb hc, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_29 (a b c d : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) (hd : 0 ≤ d) :
    (a + b)^2 + (a - c)^2 + d^2 ≤ 3733/1000 * (a^2 + b^2 + c^2 + d^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (a - d), sq_nonneg (b - c), sq_nonneg (b - d), sq_nonneg (c - d), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg ha hd, mul_nonneg hb hc, mul_nonneg hb hd, mul_nonneg hc hd, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (d - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (d - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c), sq_nonneg (d - 1000/2733 * c), sq_nonneg (a - 1000/2733 * d), sq_nonneg (b - 1000/2733 * d), sq_nonneg (c - 1000/2733 * d)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_30 (a b c d e : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) (hd : 0 ≤ d) (he : 0 ≤ e) :
    (a + b)^2 + (c - d)^2 + (c - e)^2 ≤ 3733/1000 * (a^2 + b^2 + c^2 + d^2 + e^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (a - d), sq_nonneg (a - e), sq_nonneg (b - c), sq_nonneg (b - d), sq_nonneg (b - e), sq_nonneg (c - d), sq_nonneg (c - e), sq_nonneg (d - e), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg ha hd, mul_nonneg ha he, mul_nonneg hb hc, mul_nonneg hb hd, mul_nonneg hb he, mul_nonneg hc hd, mul_nonneg hc he, mul_nonneg hd he, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (d - 1000/2733 * a), sq_nonneg (e - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (d - 1000/2733 * b), sq_nonneg (e - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c), sq_nonneg (d - 1000/2733 * c), sq_nonneg (e - 1000/2733 * c), sq_nonneg (a - 1000/2733 * d), sq_nonneg (b - 1000/2733 * d), sq_nonneg (c - 1000/2733 * d), sq_nonneg (e - 1000/2733 * d), sq_nonneg (a - 1000/2733 * e), sq_nonneg (b - 1000/2733 * e), sq_nonneg (c - 1000/2733 * e), sq_nonneg (d - 1000/2733 * e)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_31 (a b c d e f : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) (hd : 0 ≤ d) (he : 0 ≤ e) (hf : 0 ≤ f) :
    (a + b)^2 + (c - d)^2 + (e - f)^2 ≤ 3733/1000 * (a^2 + b^2 + c^2 + d^2 + e^2 + f^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (a - d), sq_nonneg (a - e), sq_nonneg (a - f), sq_nonneg (b - c), sq_nonneg (b - d), sq_nonneg (b - e), sq_nonneg (b - f), sq_nonneg (c - d), sq_nonneg (c - e), sq_nonneg (c - f), sq_nonneg (d - e), sq_nonneg (d - f), sq_nonneg (e - f), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg ha hd, mul_nonneg ha he, mul_nonneg ha hf, mul_nonneg hb hc, mul_nonneg hb hd, mul_nonneg hb he, mul_nonneg hb hf, mul_nonneg hc hd, mul_nonneg hc he, mul_nonneg hc hf, mul_nonneg hd he, mul_nonneg hd hf, mul_nonneg he hf, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (d - 1000/2733 * a), sq_nonneg (e - 1000/2733 * a), sq_nonneg (f - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (d - 1000/2733 * b), sq_nonneg (e - 1000/2733 * b), sq_nonneg (f - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c), sq_nonneg (d - 1000/2733 * c), sq_nonneg (e - 1000/2733 * c), sq_nonneg (f - 1000/2733 * c), sq_nonneg (a - 1000/2733 * d), sq_nonneg (b - 1000/2733 * d), sq_nonneg (c - 1000/2733 * d), sq_nonneg (e - 1000/2733 * d), sq_nonneg (f - 1000/2733 * d), sq_nonneg (a - 1000/2733 * e), sq_nonneg (b - 1000/2733 * e), sq_nonneg (c - 1000/2733 * e), sq_nonneg (d - 1000/2733 * e), sq_nonneg (f - 1000/2733 * e), sq_nonneg (a - 1000/2733 * f), sq_nonneg (b - 1000/2733 * f), sq_nonneg (c - 1000/2733 * f), sq_nonneg (d - 1000/2733 * f), sq_nonneg (e - 1000/2733 * f)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_32 (a b c d : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) (hd : 0 ≤ d) :
    (a + b)^2 + (c - d)^2 + a^2 ≤ 3733/1000 * (a^2 + b^2 + c^2 + d^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (a - d), sq_nonneg (b - c), sq_nonneg (b - d), sq_nonneg (c - d), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg ha hd, mul_nonneg hb hc, mul_nonneg hb hd, mul_nonneg hc hd, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (d - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (d - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c), sq_nonneg (d - 1000/2733 * c), sq_nonneg (a - 1000/2733 * d), sq_nonneg (b - 1000/2733 * d), sq_nonneg (c - 1000/2733 * d)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_33 (a b c d : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) (hd : 0 ≤ d) :
    (a + b)^2 + (c - d)^2 + c^2 ≤ 3733/1000 * (a^2 + b^2 + c^2 + d^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (a - d), sq_nonneg (b - c), sq_nonneg (b - d), sq_nonneg (c - d), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg ha hd, mul_nonneg hb hc, mul_nonneg hb hd, mul_nonneg hc hd, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (d - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (d - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c), sq_nonneg (d - 1000/2733 * c), sq_nonneg (a - 1000/2733 * d), sq_nonneg (b - 1000/2733 * d), sq_nonneg (c - 1000/2733 * d)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_34 (a b c d e : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) (hd : 0 ≤ d) (he : 0 ≤ e) :
    (a + b)^2 + (c - d)^2 + e^2 ≤ 3733/1000 * (a^2 + b^2 + c^2 + d^2 + e^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (a - d), sq_nonneg (a - e), sq_nonneg (b - c), sq_nonneg (b - d), sq_nonneg (b - e), sq_nonneg (c - d), sq_nonneg (c - e), sq_nonneg (d - e), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg ha hd, mul_nonneg ha he, mul_nonneg hb hc, mul_nonneg hb hd, mul_nonneg hb he, mul_nonneg hc hd, mul_nonneg hc he, mul_nonneg hd he, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (d - 1000/2733 * a), sq_nonneg (e - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (d - 1000/2733 * b), sq_nonneg (e - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c), sq_nonneg (d - 1000/2733 * c), sq_nonneg (e - 1000/2733 * c), sq_nonneg (a - 1000/2733 * d), sq_nonneg (b - 1000/2733 * d), sq_nonneg (c - 1000/2733 * d), sq_nonneg (e - 1000/2733 * d), sq_nonneg (a - 1000/2733 * e), sq_nonneg (b - 1000/2733 * e), sq_nonneg (c - 1000/2733 * e), sq_nonneg (d - 1000/2733 * e)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_35 (a b : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) :
    (a + b)^2 + a^2 + b^2 ≤ 3733/1000 * (a^2 + b^2) := by
  nlinarith [sq_nonneg (a - b), mul_nonneg ha hb, sq_nonneg (b - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_36 (a b c : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) :
    (a + b)^2 + a^2 + c^2 ≤ 3733/1000 * (a^2 + b^2 + c^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (b - c), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg hb hc, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_37 (a b c d : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) (hd : 0 ≤ d) :
    (a + b)^2 + c^2 + d^2 ≤ 3733/1000 * (a^2 + b^2 + c^2 + d^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (a - d), sq_nonneg (b - c), sq_nonneg (b - d), sq_nonneg (c - d), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg ha hd, mul_nonneg hb hc, mul_nonneg hb hd, mul_nonneg hc hd, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (d - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (d - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c), sq_nonneg (d - 1000/2733 * c), sq_nonneg (a - 1000/2733 * d), sq_nonneg (b - 1000/2733 * d), sq_nonneg (c - 1000/2733 * d)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_38 (a b c d : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) (hd : 0 ≤ d) :
    (a - b)^2 + (a - c)^2 + (a - d)^2 ≤ 3733/1000 * (a^2 + b^2 + c^2 + d^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (a - d), sq_nonneg (b - c), sq_nonneg (b - d), sq_nonneg (c - d), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg ha hd, mul_nonneg hb hc, mul_nonneg hb hd, mul_nonneg hc hd, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (d - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (d - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c), sq_nonneg (d - 1000/2733 * c), sq_nonneg (a - 1000/2733 * d), sq_nonneg (b - 1000/2733 * d), sq_nonneg (c - 1000/2733 * d)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_39 (a b c : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) :
    (a - b)^2 + (a - c)^2 + (b - c)^2 ≤ 3733/1000 * (a^2 + b^2 + c^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (b - c), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg hb hc, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_40 (a b c d : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) (hd : 0 ≤ d) :
    (a - b)^2 + (a - c)^2 + (b - d)^2 ≤ 3733/1000 * (a^2 + b^2 + c^2 + d^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (a - d), sq_nonneg (b - c), sq_nonneg (b - d), sq_nonneg (c - d), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg ha hd, mul_nonneg hb hc, mul_nonneg hb hd, mul_nonneg hc hd, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (d - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (d - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c), sq_nonneg (d - 1000/2733 * c), sq_nonneg (a - 1000/2733 * d), sq_nonneg (b - 1000/2733 * d), sq_nonneg (c - 1000/2733 * d)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_41 (a b c d e : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) (hd : 0 ≤ d) (he : 0 ≤ e) :
    (a - b)^2 + (a - c)^2 + (d - e)^2 ≤ 3733/1000 * (a^2 + b^2 + c^2 + d^2 + e^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (a - d), sq_nonneg (a - e), sq_nonneg (b - c), sq_nonneg (b - d), sq_nonneg (b - e), sq_nonneg (c - d), sq_nonneg (c - e), sq_nonneg (d - e), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg ha hd, mul_nonneg ha he, mul_nonneg hb hc, mul_nonneg hb hd, mul_nonneg hb he, mul_nonneg hc hd, mul_nonneg hc he, mul_nonneg hd he, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (d - 1000/2733 * a), sq_nonneg (e - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (d - 1000/2733 * b), sq_nonneg (e - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c), sq_nonneg (d - 1000/2733 * c), sq_nonneg (e - 1000/2733 * c), sq_nonneg (a - 1000/2733 * d), sq_nonneg (b - 1000/2733 * d), sq_nonneg (c - 1000/2733 * d), sq_nonneg (e - 1000/2733 * d), sq_nonneg (a - 1000/2733 * e), sq_nonneg (b - 1000/2733 * e), sq_nonneg (c - 1000/2733 * e), sq_nonneg (d - 1000/2733 * e)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_42 (a b c : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) :
    (a - b)^2 + (a - c)^2 + a^2 ≤ 3733/1000 * (a^2 + b^2 + c^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (b - c), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg hb hc, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_43 (a b c : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) :
    (a - b)^2 + (a - c)^2 + b^2 ≤ 3733/1000 * (a^2 + b^2 + c^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (b - c), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg hb hc, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_44 (a b c d : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) (hd : 0 ≤ d) :
    (a - b)^2 + (a - c)^2 + d^2 ≤ 3733/1000 * (a^2 + b^2 + c^2 + d^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (a - d), sq_nonneg (b - c), sq_nonneg (b - d), sq_nonneg (c - d), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg ha hd, mul_nonneg hb hc, mul_nonneg hb hd, mul_nonneg hc hd, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (d - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (d - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c), sq_nonneg (d - 1000/2733 * c), sq_nonneg (a - 1000/2733 * d), sq_nonneg (b - 1000/2733 * d), sq_nonneg (c - 1000/2733 * d)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_45 (a b c d e f : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) (hd : 0 ≤ d) (he : 0 ≤ e) (hf : 0 ≤ f) :
    (a - b)^2 + (c - d)^2 + (e - f)^2 ≤ 3733/1000 * (a^2 + b^2 + c^2 + d^2 + e^2 + f^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (a - d), sq_nonneg (a - e), sq_nonneg (a - f), sq_nonneg (b - c), sq_nonneg (b - d), sq_nonneg (b - e), sq_nonneg (b - f), sq_nonneg (c - d), sq_nonneg (c - e), sq_nonneg (c - f), sq_nonneg (d - e), sq_nonneg (d - f), sq_nonneg (e - f), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg ha hd, mul_nonneg ha he, mul_nonneg ha hf, mul_nonneg hb hc, mul_nonneg hb hd, mul_nonneg hb he, mul_nonneg hb hf, mul_nonneg hc hd, mul_nonneg hc he, mul_nonneg hc hf, mul_nonneg hd he, mul_nonneg hd hf, mul_nonneg he hf, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (d - 1000/2733 * a), sq_nonneg (e - 1000/2733 * a), sq_nonneg (f - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (d - 1000/2733 * b), sq_nonneg (e - 1000/2733 * b), sq_nonneg (f - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c), sq_nonneg (d - 1000/2733 * c), sq_nonneg (e - 1000/2733 * c), sq_nonneg (f - 1000/2733 * c), sq_nonneg (a - 1000/2733 * d), sq_nonneg (b - 1000/2733 * d), sq_nonneg (c - 1000/2733 * d), sq_nonneg (e - 1000/2733 * d), sq_nonneg (f - 1000/2733 * d), sq_nonneg (a - 1000/2733 * e), sq_nonneg (b - 1000/2733 * e), sq_nonneg (c - 1000/2733 * e), sq_nonneg (d - 1000/2733 * e), sq_nonneg (f - 1000/2733 * e), sq_nonneg (a - 1000/2733 * f), sq_nonneg (b - 1000/2733 * f), sq_nonneg (c - 1000/2733 * f), sq_nonneg (d - 1000/2733 * f), sq_nonneg (e - 1000/2733 * f)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_46 (a b c d : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) (hd : 0 ≤ d) :
    (a - b)^2 + (c - d)^2 + a^2 ≤ 3733/1000 * (a^2 + b^2 + c^2 + d^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (a - d), sq_nonneg (b - c), sq_nonneg (b - d), sq_nonneg (c - d), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg ha hd, mul_nonneg hb hc, mul_nonneg hb hd, mul_nonneg hc hd, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (d - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (d - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c), sq_nonneg (d - 1000/2733 * c), sq_nonneg (a - 1000/2733 * d), sq_nonneg (b - 1000/2733 * d), sq_nonneg (c - 1000/2733 * d)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_47 (a b c d e : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) (hd : 0 ≤ d) (he : 0 ≤ e) :
    (a - b)^2 + (c - d)^2 + e^2 ≤ 3733/1000 * (a^2 + b^2 + c^2 + d^2 + e^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (a - d), sq_nonneg (a - e), sq_nonneg (b - c), sq_nonneg (b - d), sq_nonneg (b - e), sq_nonneg (c - d), sq_nonneg (c - e), sq_nonneg (d - e), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg ha hd, mul_nonneg ha he, mul_nonneg hb hc, mul_nonneg hb hd, mul_nonneg hb he, mul_nonneg hc hd, mul_nonneg hc he, mul_nonneg hd he, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (d - 1000/2733 * a), sq_nonneg (e - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (d - 1000/2733 * b), sq_nonneg (e - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c), sq_nonneg (d - 1000/2733 * c), sq_nonneg (e - 1000/2733 * c), sq_nonneg (a - 1000/2733 * d), sq_nonneg (b - 1000/2733 * d), sq_nonneg (c - 1000/2733 * d), sq_nonneg (e - 1000/2733 * d), sq_nonneg (a - 1000/2733 * e), sq_nonneg (b - 1000/2733 * e), sq_nonneg (c - 1000/2733 * e), sq_nonneg (d - 1000/2733 * e)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_48 (a b : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) :
    (a - b)^2 + a^2 + b^2 ≤ 3733/1000 * (a^2 + b^2) := by
  nlinarith [sq_nonneg (a - b), mul_nonneg ha hb, sq_nonneg (b - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_49 (a b c : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) :
    (a - b)^2 + a^2 + c^2 ≤ 3733/1000 * (a^2 + b^2 + c^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (b - c), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg hb hc, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_50 (a b c d : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) (hd : 0 ≤ d) :
    (a - b)^2 + c^2 + d^2 ≤ 3733/1000 * (a^2 + b^2 + c^2 + d^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (a - d), sq_nonneg (b - c), sq_nonneg (b - d), sq_nonneg (c - d), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg ha hd, mul_nonneg hb hc, mul_nonneg hb hd, mul_nonneg hc hd, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (d - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (d - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c), sq_nonneg (d - 1000/2733 * c), sq_nonneg (a - 1000/2733 * d), sq_nonneg (b - 1000/2733 * d), sq_nonneg (c - 1000/2733 * d)]

set_option maxHeartbeats 400000 in
theorem slot_ceiling_51 (a b c : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c) :
    a^2 + b^2 + c^2 ≤ 3733/1000 * (a^2 + b^2 + c^2) := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (b - c), mul_nonneg ha hb, mul_nonneg ha hc, mul_nonneg hb hc, sq_nonneg (b - 1000/2733 * a), sq_nonneg (c - 1000/2733 * a), sq_nonneg (a - 1000/2733 * b), sq_nonneg (c - 1000/2733 * b), sq_nonneg (a - 1000/2733 * c), sq_nonneg (b - 1000/2733 * c)]

/-! The kernel slots `π_i ⊗ ker` have dimension `2 dim ker`, so a plane can carry several loop slots of
value `a_i²`. **The six configurations repeating a loop are also at most `3733/1000`** (in fact at
most `2 + √2`). A slot of value `0` leaves two slots, whose sum is at most `3` by L237's `κ₂`. -/

theorem slot_ceiling_rep0 (a b : ℝ) : 2 * a^2 + (a + b)^2 ≤ 3733/1000 * (a^2 + b^2) := by
  nlinarith [sq_nonneg (a - 12/5 * b), sq_nonneg b]
theorem slot_ceiling_rep1 (a b : ℝ) : 2 * a^2 + (a - b)^2 ≤ 3733/1000 * (a^2 + b^2) := by
  nlinarith [sq_nonneg (a + 12/5 * b), sq_nonneg b]
theorem slot_ceiling_rep2 (a : ℝ) : 3 * a^2 ≤ 3733/1000 * a^2 := by nlinarith [sq_nonneg a]
theorem slot_ceiling_rep3 (a b : ℝ) : 2 * a^2 + b^2 ≤ 3733/1000 * (a^2 + b^2) := by
  nlinarith [sq_nonneg a, sq_nonneg b]
theorem slot_ceiling_rep4 (a b c : ℝ) : 2 * a^2 + (b + c)^2 ≤ 3733/1000 * (a^2 + b^2 + c^2) := by
  nlinarith [sq_nonneg (b - c), sq_nonneg a]
theorem slot_ceiling_rep5 (a b c : ℝ) : 2 * a^2 + (b - c)^2 ≤ 3733/1000 * (a^2 + b^2 + c^2) := by
  nlinarith [sq_nonneg (b + c), sq_nonneg a]

theorem slot_threshold : 8 - 2 * (3733/1000 : ℝ) = 534/1000 := by norm_num



/-! ## The partner-deficit route: exact deficits and the distance they pay for

[The note](../../../reviews/2026-09-24-I73-seven-frame-stability.md)'s second route counts the
partners' own row deficits. **These are its algebraic inputs**: the deficit of a triangle or star
configuration is an exact sum of squares, `6(1 - p²)` plus nonnegative terms, `p` the alignment
with the extremal pattern; with `dist² ≤ 2 - 2p` that is at least `6d²(1 - d²/4)`; and an element
of the top space, whose alignment with any extremal element is at most `√(2/3)·r`, is at squared
distance at least `1/3` from them. -/

/-- **The triangle deficit identity**: `8 - 2·(slot sum) = 6(1 - p²) + 2(1 - |v|²)`, `p = σ/√3`. -/
theorem deficit_triangle (a b c : ℝ) :
    8 - 2 * ((a + b)^2 + (a + c)^2 + (b + c)^2)
      = 6 * (1 - (a + b + c)^2 / 3) + 2 * (1 - (a^2 + b^2 + c^2)) := by ring

/-- **The star deficit identity**: `8 - 2·(slot sum) = 6(1 - p²) + 2(1 - |v|²) + ½(a - L)²`,
`p = (3a + L)/√12`, `L` the leaf sum. -/
theorem deficit_star (a l1 l2 l3 : ℝ) :
    8 - 2 * ((a + l1)^2 + (a + l2)^2 + (a + l3)^2)
      = 6 * (1 - (3 * a + (l1 + l2 + l3))^2 / 12) + 2 * (1 - (a^2 + l1^2 + l2^2 + l3^2))
        + 1/2 * (a - (l1 + l2 + l3))^2 := by ring

/-- **The deficit bound from the distance**: with `p ≤ 1 - d²/2`, `0 ≤ p`, `|v| ≤ 1`, a triangle- or
star-type deficit is at least `6 d² (1 - d²/4)`. -/
theorem deficit_of_dist (p d2 : ℝ) (hp0 : 0 ≤ p) (hp : p ≤ 1 - d2 / 2) (hd : d2 ≤ 2) :
    6 * (1 - p^2) ≥ 6 * d2 * (1 - d2 / 4) := by
  have h1 : 0 ≤ 1 - d2 / 2 := by linarith
  have : p^2 ≤ (1 - d2 / 2)^2 := by nlinarith
  nlinarith

/-- **Elements of the top space are far from the extremal set**: with alignment at most
`√(2/3)·r`, `r² + 1 - 2·align ≥ 1/3` at every radius. -/
theorem far_from_ext (r s : ℝ) (hs : s^2 = 2/3) (hs0 : 0 ≤ s) :
    r^2 + 1 - 2 * s * r ≥ 1/3 := by
  nlinarith [sq_nonneg (r - s)]


/-! ## The star gap

**On the star side the leak splits by what it does to a partner's angles.** Maps from the dominant
plane to anything outside it and the three leaves (kernel slots, and both slots to further planes)
change a partner's angles only at second order, and are charged at the kernel gap `g_K`; every
other direction moves a partner at first order and is charged at `g_M`. With `y` the star deficit
`8 - 2Σ(a + lᵢ)²`, **both gaps are large enough**: `0.677 g_M + y ≥ 0.3` against every first-order
slot, and `3 g_K + y ≥ 0.3`, whenever `y ≤ 0.277`. *The minus slots, the leaf pair containing the
pair's own leaf and the leftover mass are proved directly (`sgM_*`); the other leaf slots are at most
`2(1 - a²)` (`R_*`), which `sgM_bulk` handles through an explicit sum of squares (`bulk_core`); the
kernel gap needs the constraint `y ≤ 0.277` puts on `b` (`sgK_core`, `sgK`).* -/

set_option maxHeartbeats 1000000

/-- The star angle deficit, `y = 8 - 2Σ(a + lᵢ)²`. -/
def yS (a l1 l2 l3 : ℝ) : ℝ := 8 - 2 * ((a + l1)^2 + (a + l2)^2 + (a + l3)^2)

section StarCases
variable (a l1 l2 l3 b : ℝ) (ha : 0 ≤ a) (h1 : 0 ≤ l1) (h2 : 0 ≤ l2) (h3 : 0 ≤ l3) (hb : 0 ≤ b)
  (hs : a^2 + l1^2 + l2^2 + l3^2 + b^2 ≤ 1) (hy : yS a l1 l2 l3 ≤ 277/1000)
include ha h1 h2 h3 hb hs hy

theorem sgM_minus_same : 677/1000 * ((a + l1)^2 - (a - l1)^2) + yS a l1 l2 l3 ≥ 3/10 := by
  unfold yS at *
  nlinarith [sq_nonneg (l1 - l2), sq_nonneg (l1 - l3), sq_nonneg (l2 - l3), mul_nonneg ha h1,
    sq_nonneg (a - 3 * l1), sq_nonneg (a - 3 * l2), sq_nonneg (a - 3 * l3)]

theorem sgM_minus_other : 677/1000 * ((a + l1)^2 - (a - l2)^2) + yS a l1 l2 l3 ≥ 3/10 := by
  unfold yS at *
  nlinarith [sq_nonneg (l1 - l2), sq_nonneg (l1 - l3), sq_nonneg (l2 - l3), mul_nonneg ha h1, mul_nonneg ha h2, mul_nonneg ha h3, sq_nonneg (a - 3 * l1), sq_nonneg (a - 3 * l2), sq_nonneg (a - 3 * l3), mul_nonneg ha hb, mul_nonneg h1 hb, mul_nonneg h2 hb, sq_nonneg b]

theorem sgM_leaves_in : 677/1000 * ((a + l1)^2 - (l1 + l2)^2) + yS a l1 l2 l3 ≥ 3/10 := by
  unfold yS at *
  nlinarith [sq_nonneg (l1 - l2), sq_nonneg (l1 - l3), sq_nonneg (l2 - l3), mul_nonneg ha h1, mul_nonneg ha h2, mul_nonneg ha h3, sq_nonneg (a - 3 * l1), sq_nonneg (a - 3 * l2), sq_nonneg (a - 3 * l3), mul_nonneg ha hb, mul_nonneg h1 hb, mul_nonneg h2 hb, sq_nonneg b]

theorem sgM_mass : 677/1000 * ((a + l1)^2 - 2 * (1 - (a^2 + l1^2 + l2^2 + l3^2))) + yS a l1 l2 l3 ≥ 3/10 := by
  unfold yS at *
  nlinarith [sq_nonneg (l1 - l2), sq_nonneg (l1 - l3), sq_nonneg (l2 - l3), mul_nonneg ha h1, mul_nonneg ha h2, mul_nonneg ha h3, sq_nonneg (a - 3 * l1), sq_nonneg (a - 3 * l2), sq_nonneg (a - 3 * l3), mul_nonneg ha hb, mul_nonneg h1 hb, mul_nonneg h2 hb, sq_nonneg b]

omit hy in
theorem R_leaves_out : (l2 + l3)^2 ≤ 2 * (1 - a^2) := by nlinarith [sq_nonneg (l2 - l3)]
omit hy in
theorem R_leaf_b_out : (l2 + b)^2 ≤ 2 * (1 - a^2) := by nlinarith [sq_nonneg (l2 - b)]
omit hy in
theorem R_leaf_b_in : (l1 + b)^2 ≤ 2 * (1 - a^2) := by nlinarith [sq_nonneg (l1 - b)]

end StarCases

/-- The reduced bulk quadratic, `t = l₂ + l₃`, on `2a² + 2l₁² + t² ≤ 2`. -/
theorem bulk_core (a l1 t : ℝ) (ha : 0 ≤ a) (ht : 0 ≤ t) (hc : t^2 + 2 * a^2 + 2 * l1^2 ≤ 2) :
    -1969/1000 * a^2 - 2646/1000 * a * l1 + 677/1000 * l1^2 + 4346/1000 - 4 * a * t ≥ 0 := by
  nlinarith [sq_nonneg (t - 16/17 * a), sq_nonneg (l1 - 11/41 * a), sq_nonneg a]

theorem sgM_bulk (a l1 l2 l3 b : ℝ) (ha : 0 ≤ a) (h1 : 0 ≤ l1) (h2 : 0 ≤ l2) (h3 : 0 ≤ l3)
    (hb : 0 ≤ b) (hs : a^2 + l1^2 + l2^2 + l3^2 + b^2 ≤ 1) :
    677/1000 * ((a + l1)^2 - 2 * (1 - a^2)) + yS a l1 l2 l3 ≥ 3/10 := by
  have hc : (l2 + l3)^2 + 2 * a^2 + 2 * l1^2 ≤ 2 := by nlinarith [sq_nonneg (l2 - l3), sq_nonneg b]
  have core := bulk_core a l1 (l2 + l3) ha (by positivity) hc
  unfold yS
  nlinarith [sq_nonneg b]


theorem sgK_core (a l1 b t : ℝ) (ha : 0 ≤ a) (h1 : 0 ≤ l1) (hb : 0 ≤ b) (ht : 0 ≤ t)
    (hc : t^2 + 2 * a^2 + 2 * l1^2 + 2 * b^2 ≤ 2)
    (hq : b^2 ≤ 2 * a^2 + 2 * a * (l1 + t) - 28615/10000) :
    3 * ((a + l1)^2 - (a + b)^2) + 6 - 4 * a^2 - 4 * a * l1 - 4 * a * t + 2 * b^2 - 3/10 ≥ 0 := by
  nlinarith [sq_nonneg (t - 7/10 * a), sq_nonneg (l1 - 1/6 * a), sq_nonneg (b - 1/7 * a),
    mul_nonneg ha hb, mul_nonneg h1 hb, mul_nonneg ha h1, sq_nonneg (a - 88/100)]

/-- **The kernel gap on the star side**: `3 g_K + y ≥ 0.3`. -/
theorem sgK (a l1 l2 l3 b : ℝ) (ha : 0 ≤ a) (h1 : 0 ≤ l1) (h2 : 0 ≤ l2) (h3 : 0 ≤ l3)
    (hb : 0 ≤ b) (hs : a^2 + l1^2 + l2^2 + l3^2 + b^2 ≤ 1) (hy : yS a l1 l2 l3 ≤ 277/1000) :
    3 * ((a + l1)^2 - (a + b)^2) + yS a l1 l2 l3 ≥ 3/10 := by
  have hc : (l2 + l3)^2 + 2 * a^2 + 2 * l1^2 + 2 * b^2 ≤ 2 := by nlinarith [sq_nonneg (l2 - l3)]
  have hq : b^2 ≤ 2 * a^2 + 2 * a * (l1 + (l2 + l3)) - 28615/10000 := by
    unfold yS at hy; nlinarith
  have core := sgK_core a l1 b (l2 + l3) ha h1 hb (by positivity) hc hq
  have hlow : yS a l1 l2 l3 ≥ 6 - 4 * a^2 - 4 * a * l1 - 4 * a * (l2 + l3) + 2 * b^2 := by
    unfold yS; nlinarith
  linarith


/-! ## The leak constants on the star side

A partner of a star element, split as a rank-four part `Y + K` (anti-linear plus kernel) and a
first-order remainder of norm `m`, sits at distance `e ≥ ρ(κ) - m` from the triangles and stars,
where the normalised `κ`, with `κ(1 - m²) ≤ ‖K‖²`, measures how unequal `Y + K`'s two angles are and,
on the star branch of von
Neumann's bound (`star_ge_tri`), `ρ(κ)² = 7/12 - κ/3 - c/4` with `c = √(1 - κ²)`. **Its damage, the
shortfall of its own row deficit from the plateau `0.534`, is at most `½κ(1 - m²) + 2.4m²`, hence at
most `½‖K‖² + 2.4m²`**: below the
plateau the deficit is at least `5.86 e²` (`phi_low`), and completing the square in `m` leaves a
quadratic `G ≥ 0` on the unit-circle arc (`lamG`, `lam_pos_norm`, and `lam_neg_norm` once
`m ≥ ρ`). -/

/-- **The star branch dominates the triangle branch** of a rank-four element's alignment:
`star² - tri² = 1/12 + κ/3 - c/12 ≥ 0`, `c = √(1 - κ²)`. -/
theorem star_ge_tri (κ c : ℝ) (hk : 0 ≤ κ) (hc1 : c ≤ 1) :
    5/12 + κ/3 + c/4 ≥ (1 + c) / 3 := by linarith

/-- The plateau value `4 - 2√3` is at most `0.5359`. -/
theorem plateau_le : 4 - 2 * Real.sqrt 3 ≤ 5359/10000 := by
  have h := Real.sq_sqrt (show (0:ℝ) ≤ 3 by norm_num)
  nlinarith [Real.sqrt_nonneg 3, sq_nonneg (Real.sqrt 3 - 17321/10000)]

/-- Below the plateau the deficit function is at least `5.86 e²`. -/
theorem phi_low (e2 : ℝ) (h0 : 0 ≤ e2) (h : e2 ≤ 914/10000) : 6 * e2 * (1 - e2 / 4) ≥ 586/100 * e2 := by
  nlinarith [mul_nonneg h0 (sub_nonneg.2 h)]

set_option maxHeartbeats 1000000

/-- The discriminant of the normalised damage bound, as a quadratic on the unit-circle arc. -/
theorem lamG (κ c : ℝ) (hk : 0 ≤ κ) (hc : 0 ≤ c) (hcirc : κ^2 + c^2 = 1) :
    (586/100 * (7/12 - κ/3 - c/4) + 1/2 * κ - 534/1000) * (826/100 - 1/2 * κ)
      - (586/100)^2 * (7/12 - κ/3 - c/4) ≥ 0 := by
  nlinarith [sq_nonneg (κ - 264/1000), sq_nonneg (c - 9645/10000), mul_nonneg hk hc]

/-- **The damage bound with `κ` normalised**: the budget pays `‖K‖² = κ(1 - m²)`. The certificate
is `A·F = (A m - 5.86 ρ)² + G` with `A = 8.26 - κ/2`. -/
theorem lam_pos_norm (κ c ρ m : ℝ) (hk : 0 ≤ κ) (hc : 0 ≤ c) (hcirc : κ^2 + c^2 = 1) (_hρ0 : 0 ≤ ρ)
    (hρ : ρ^2 = 7/12 - κ/3 - c/4) (_hm : 0 ≤ m) :
    534/1000 - 586/100 * (ρ - m)^2 ≤ 1/2 * (κ * (1 - m^2)) + 24/10 * m^2 := by
  have hk1 : κ ≤ 1 := by nlinarith
  have hG := lamG κ c hk hc hcirc
  have hA : 0 < 826/100 - 1/2 * κ := by linarith
  have key : (826/100 - 1/2 * κ) * (1/2 * (κ * (1 - m^2)) + 24/10 * m^2 + 586/100 * (ρ - m)^2 - 534/1000)
      = ((826/100 - 1/2 * κ) * m - 586/100 * ρ)^2
        + ((586/100 * (7/12 - κ/3 - c/4) + 1/2 * κ - 534/1000) * (826/100 - 1/2 * κ)
          - (586/100)^2 * (7/12 - κ/3 - c/4)) := by
    rw [← hρ]; ring
  have hpos : 0 ≤ (826/100 - 1/2 * κ) * (1/2 * (κ * (1 - m^2)) + 24/10 * m^2 + 586/100 * (ρ - m)^2 - 534/1000) := by
    rw [key]; nlinarith [sq_nonneg ((826/100 - 1/2 * κ) * m - 586/100 * ρ)]
  have := (mul_nonneg_iff_of_pos_left hA).mp hpos
  linarith

theorem lam_neg_norm (κ c ρ m : ℝ) (hk : 0 ≤ κ) (hc : 0 ≤ c) (hcirc : κ^2 + c^2 = 1) (hρ0 : 0 ≤ ρ)
    (hρ : ρ^2 = 7/12 - κ/3 - c/4) (hm : ρ ≤ m) (hm1 : m ≤ 1) :
    534/1000 ≤ 1/2 * (κ * (1 - m^2)) + 24/10 * m^2 := by
  have hk1 : κ ≤ 1 := by nlinarith
  have hx : 2667/10000 * κ + 575/1000 * c ≤ 806/1000 := by
    nlinarith [sq_nonneg (575/1000 * κ - 2667/10000 * c)]
  have : ρ^2 ≤ m^2 := by nlinarith
  nlinarith [mul_nonneg hk (sq_nonneg m), mul_nonneg (sub_nonneg.2 hk1) (sq_nonneg m)]


/-! ## L240, the seven-frame lemma, stated

**The lemma's own statement.** The inner product is `⟨X, Y⟩ = -½ tr(XY)` on skew matrices and
`‖[X, Y]‖² = ⟨[X, Y], [X, Y]⟩`. *The `sorry` stands for the slot spectrum of `-ad_X²`, the Ky Fan
weights, the Gram computation, von Neumann's inequality for skew matrices and the final count,
which are prose in [second-order.md](../../../findings/second-order.md); every scalar step they
use is proved above.* -/

/-- The inner product `⟨X, Y⟩ = -½ tr(XY)` on `𝔰𝔬(n)`. -/
noncomputable def ipSo {n : ℕ} (X Y : Matrix (Fin n) (Fin n) ℝ) : ℝ := -(1/2) * (X * Y).trace

/-- The ordered bracket total `T = Σ_{i≠j} ‖[X_i, X_j]‖²` of a seven-frame. -/
noncomputable def bracketTotal {n : ℕ} (X : Fin 7 → Matrix (Fin n) (Fin n) ℝ) : ℝ :=
  ∑ i, ∑ j, if i = j then 0 else
    ipSo (X i * X j - X j * X i) (X i * X j - X j * X i)

/-- **L240, the seven-frame lemma.** Every orthonormal seven-frame in `𝔰𝔬(n)` has ordered bracket
total at most `54.064`. -/
theorem seven_frame_lemma {n : ℕ} (X : Fin 7 → Matrix (Fin n) (Fin n) ℝ)
    (hskew : ∀ i, Matrix.transpose (X i) = -X i)
    (hon : ∀ i j, ipSo (X i) (X j) = if i = j then 1 else 0) :
    bracketTotal X ≤ 54064/1000 := by
  sorry

end HamiltonsCubic.SevenFrameGap
