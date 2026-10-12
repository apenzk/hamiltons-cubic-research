import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity

/-!
# L51, the guard that names the empty set, and the witness made exact

[LEDGER.md](../../../findings/LEDGER.md)'s Lemma L51. Four of its findings are arithmetic
and are carried here.

**The guard is unsatisfiable as written.** `B = (θ/2)Id - L_W` and `L_W W = θW` give
`BW = -(θ/2)W`, so `⟨BW,W⟩ = -(θ/2)‖W‖² < 0` whenever `θ > 0` and `W ≠ 0`. It must read
`B|_{W⊥} ⪰ 0`, which is what [r287](../../../reviews/REVIEW_r287.md) wrote and the write-up
dropped into four copies.

**The two quartics differ by exactly `2⟨Bz,z⟩` and agree on the null cone.** The great-circle
coefficient `(7/8)θ - (5/2)⟨L_W z,z⟩` and the chordal one differ by `θ‖z‖² - 2⟨L_W z,z⟩`,
which is `2⟨Bz,z⟩`; on the null cone `⟨L_W z,z⟩ = (θ/2)‖z‖²` and **both equal `-(3/8)θ`**.
So the block's four constants are one identity, and no number moves.

**The hand witness, made exact.** `P(x,y) = x³ + (3/2)xy² + αy³` at `(1,0)` has
`B|_{W⊥} = 0` and is no local maximum for `α ≠ 0`. On the unit circle
`P = (3/2)c - (1/2)c³ + αs³`, so `P - 1 = -(1/2)(c-1)²(c+2) + αs³` **identically**; through
the Pythagorean parametrisation `c = (1-u²)/(1+u²)`, `s = 2u/(1+u²)` this is
`2u³(4 - 3u - u³)/(1+u²)³` at `α = 1`, whose **sign is the sign of `u`** for `|u| < 1`. The
points reach `(1,0)` as `u → 0`, so no neighbourhood is a maximum, and nothing analytic is
used.
-/

namespace HamiltonsCubic.OrbitJet

/-! ## The guard names the empty set -/

/-- `BW = -(θ/2)W`, from `B = (θ/2)Id - L_W` and `L_W W = θW`. -/
theorem B_on_W (θ lw : ℝ) (hlw : lw = θ) : θ / 2 - lw = -(θ / 2) := by rw [hlw]; ring

/-- **So `B ⪰ 0` is unsatisfiable at `θ > 0`**: the quadratic form at `W` is strictly
negative, and `W` is in the domain the unrestricted guard quantifies over. -/
theorem guard_empty {θ nrmSq : ℝ} (hθ : 0 < θ) (hn : 0 < nrmSq) :
    -(θ / 2) * nrmSq < 0 := by nlinarith [hθ, hn]

/-! ## The two quartics -/

/-- The great-circle (geodesic) quartic coefficient. -/
noncomputable def geodesic (θ L : ℝ) : ℝ := (7 / 8) * θ - (5 / 2) * L

/-- The chordal quartic coefficient. -/
noncomputable def chordal (θ L : ℝ) : ℝ := -(1 / 8) * θ - (1 / 2) * L

/-- **They differ by `2⟨Bz,z⟩ = θ - 2L`** at `‖z‖ = 1`. -/
theorem quartics_differ (θ L : ℝ) : geodesic θ L - chordal θ L = θ - 2 * L := by
  unfold geodesic chordal; ring

/-- **And they agree on the null cone**, where `⟨Bz,z⟩ = 0`, i.e. `L = θ/2`. -/
theorem quartics_agree_on_null_cone (θ : ℝ) : geodesic θ (θ / 2) = chordal θ (θ / 2) := by
  unfold geodesic chordal; ring

/-- **Both equal `-(3/8)θ` there**, the block's own number, reached from either curve. -/
theorem null_cone_value (θ : ℝ) : chordal θ (θ / 2) = -(3 / 8) * θ := by
  unfold chordal; ring

/-- **Hence `θ ≥ 0` at every local maximum.** A local maximum needs the quartic coefficient
`≤ 0` against a nonvanishing orbit tangent, and `-(3/8)θ‖z‖⁴ ≤ 0` with `‖z‖ > 0` gives it.
So [L24](../../../findings/second-order.md)'s *"local maximiser with `θ < 0`"* branch is
empty. -/
theorem theta_nonneg_at_max {θ z4 : ℝ} (hz : 0 < z4) (hmax : -(3 / 8) * θ * z4 ≤ 0) :
    0 ≤ θ := by nlinarith [hz, hmax]

/-! ## The witness, exactly -/

/-- On the unit circle the cubic collapses: `x³ + (3/2)xy² = (3/2)c - (1/2)c³`. -/
theorem cubic_on_circle (c s : ℝ) (hcs : c ^ 2 + s ^ 2 = 1) :
    c ^ 3 + (3 / 2) * c * s ^ 2 = (3 / 2) * c - (1 / 2) * c ^ 3 := by
  have hs : s ^ 2 = 1 - c ^ 2 := by linarith
  rw [hs]; ring

/-- **The exact shape near `(1,0)`**: `P - 1 = -(1/2)(c-1)²(c+2) + αs³`, an identity. The
first term is the vanishing second-order behaviour that `B|_{W⊥} = 0` encodes. -/
theorem P_minus_one (c s α : ℝ) (hcs : c ^ 2 + s ^ 2 = 1) :
    (c ^ 3 + (3 / 2) * c * s ^ 2 + α * s ^ 3) - 1
      = -(1 / 2) * (c - 1) ^ 2 * (c + 2) + α * s ^ 3 := by
  rw [cubic_on_circle c s hcs]; ring

/-- The Pythagorean parametrisation lands on the unit circle for every `u`. -/
theorem pythag_on_circle (u : ℝ) (hu : 1 + u ^ 2 ≠ 0) :
    ((1 - u ^ 2) / (1 + u ^ 2)) ^ 2 + (2 * u / (1 + u ^ 2)) ^ 2 = 1 := by
  field_simp
  ring

/-- **`P - 1 = 2u³(4 - 3u - u³)/(1+u²)³` at `α = 1`**, the witness in closed form. -/
theorem witness_closed_form (u : ℝ) :
    (-(1 / 2) * ((1 - u ^ 2) / (1 + u ^ 2) - 1) ^ 2 * ((1 - u ^ 2) / (1 + u ^ 2) + 2)
      + 1 * (2 * u / (1 + u ^ 2)) ^ 3)
      = 2 * u ^ 3 * (4 - 3 * u - u ^ 3) / (1 + u ^ 2) ^ 3 := by
  have hu : (1 : ℝ) + u ^ 2 ≠ 0 := by positivity
  field_simp
  ring

/-- The bracket is positive on `|u| < 1`, so **the sign is the sign of `u`**. -/
theorem witness_bracket_pos {u : ℝ} (hlo : -1 < u) (hhi : u < 1) : 0 < 4 - 3 * u - u ^ 3 := by
  have hfac : 4 - 3 * u - u ^ 3 = (1 - u) * (u ^ 2 + u + 4) := by ring
  have h1 : (0:ℝ) < 1 - u := by linarith
  have h2 : (0:ℝ) < u ^ 2 + u + 4 := by nlinarith [sq_nonneg (2 * u + 1)]
  rw [hfac]; exact mul_pos h1 h2

/-- **`P > 1` on one side.** -/
theorem witness_above {u : ℝ} (hpos : 0 < u) (hhi : u < 1) :
    0 < 2 * u ^ 3 * (4 - 3 * u - u ^ 3) / (1 + u ^ 2) ^ 3 := by
  have hb := witness_bracket_pos (by linarith) hhi
  have hd : (0:ℝ) < (1 + u ^ 2) ^ 3 := by positivity
  apply div_pos _ hd
  exact mul_pos (by positivity) hb

/-- **`P < 1` on the other**, so `(1,0)` is no local maximum for `α ≠ 0`, and the points
reach it as `u → 0`. -/
theorem witness_below {u : ℝ} (hneg : u < 0) (hlo : -1 < u) :
    2 * u ^ 3 * (4 - 3 * u - u ^ 3) / (1 + u ^ 2) ^ 3 < 0 := by
  have hb := witness_bracket_pos hlo (by linarith)
  have hd : (0:ℝ) < (1 + u ^ 2) ^ 3 := by positivity
  apply div_neg_of_neg_of_pos _ hd
  have hu3 : 2 * u ^ 3 < 0 := by nlinarith [hneg, sq_nonneg u, mul_pos (neg_pos.2 hneg) (neg_pos.2 hneg)]
  exact mul_neg_of_neg_of_pos hu3 hb

end HamiltonsCubic.OrbitJet
