import HamiltonsCubic.Results.L68
import Mathlib.Tactic.FieldSimp

/-!
# L130, the four-set ratio, and the entry cap that closes the spread conversion

[diagonal-half.md](../../../findings/diagonal-half.md)'s Lemma L130. Part (ii) is built on
[L68](L68.lean), whose `g_eq` is the identity it reduces to; part (i) and the
`m₄`-impossibility are arithmetic.

**The residual identity pins a sign convention the block leaves open.** L130 writes
`2θM_ab - (s_a + s_b) = 2ρ_ab - ½g_ab` with `ρ` *"the per-entry criticality residual"*, and
does not say which way round the residual is taken. Only one choice makes the identity true:
`ρ_ab = θM_ab - M_ab² - (M²)_ab`. With the opposite sign the right-hand side comes out as
`-(2θM_ab - (s_a+s_b)) - g_ab`, so the stated equality fails. That is fixed in the definition
below and proved.
-/

namespace HamiltonsCubic.Diagonal

open Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι] {M : ι → ι → ℝ}

/-! ## (ii) The entry cap and the criticality residual -/

/-- The per-entry criticality residual, in the sign the identity forces. It vanishes exactly
at a critical point. -/
def resid (M : ι → ι → ℝ) (θ : ℝ) (a b : ι) : ℝ := θ * M a b - M a b ^ 2 - sq M a b

/-- **The residual identity.** `2θM_ab - (s_a + s_b) = 2ρ_ab - ½g_ab`, with no hypothesis
beyond the two `g_eq` needs. -/
theorem cap_residual (hh : ∀ a, M a a = 0) (hs : ∀ a b, M a b = M b a) {a b : ι}
    (hab : a ≠ b) (θ : ℝ) :
    2 * θ * M a b - (rowSq M a + rowSq M b)
      = 2 * resid M θ a b - (1 / 2) * g M a b := by
  rw [g_eq hh hs hab]; unfold resid; ring

/-- **The cap fails exactly when `ρ_ab > ¼g_ab`**, an identity rather than a sweep, which is
what makes criticality load-bearing for the cap. -/
theorem cap_iff (hh : ∀ a, M a a = 0) (hs : ∀ a b, M a b = M b a) {a b : ι} (hab : a ≠ b)
    (θ : ℝ) :
    2 * θ * M a b ≤ rowSq M a + rowSq M b ↔ resid M θ a b ≤ (1 / 4) * g M a b := by
  have h := cap_residual hh hs hab θ
  constructor <;> intro hx <;> linarith [h, hx]

/-- **The two-entry cap.** `p_a = M_aj + M_ak ≤ (2s_a + s_j + s_k)/(2θ)`, from the one-entry
cap applied twice. -/
theorem two_entry_cap (hh : ∀ a, M a a = 0) (hs : ∀ a b, M a b = M b a) {a j k : ι}
    (haj : a ≠ j) (hak : a ≠ k) {θ : ℝ} (hθ : 0 < θ)
    (hcj : M a j ^ 2 + sq M a j = θ * M a j) (hck : M a k ^ 2 + sq M a k = θ * M a k) :
    M a j + M a k ≤ (2 * rowSq M a + rowSq M j + rowSq M k) / (2 * θ) := by
  have h1 := entry_cap hh hs haj hcj
  have h2 := entry_cap hh hs hak hck
  rw [le_div_iff₀ (by linarith)]
  linarith [h1, h2]

/-- **`3/(2θ) ≤ θ` is exactly `θ² ≥ 3/2`**, the block's last step, both directions. -/
theorem three_over_two_theta (θ : ℝ) (hθ : 0 < θ) : 3 / (2 * θ) ≤ θ ↔ 3 / 2 ≤ θ ^ 2 := by
  rw [div_le_iff₀ (by linarith)]
  constructor <;> intro h <;> nlinarith [h]

/-- **The quantitative gap.** With `2s_a + s_j + s_k ≤ s_a + 2` and `θ² ≥ 3/2`,
`θ - p_a ≥ (1 - s_a)/(2θ)`, so the spread conversion's denominator is bounded away from
zero, and the count of indices with `p_a = θ` is zero rather than *"at most two"*. -/
theorem gap_lower_bound {θ p sa : ℝ} (hθ : 0 < θ) (hsq : 3 / 2 ≤ θ ^ 2)
    (hp : p ≤ (sa + 2) / (2 * θ)) : (1 - sa) / (2 * θ) ≤ θ - p := by
  rw [div_le_iff₀ (by linarith)]
  have h2 : p * (2 * θ) ≤ sa + 2 := by
    rw [← le_div_iff₀ (by linarith)]; exact hp
  nlinarith [h2, hsq, hθ]

end HamiltonsCubic.Diagonal

/-! ## (i) The four-set ratio, and what an `m₄`-only criterion cannot be -/

namespace HamiltonsCubic.FourSetRatio

/-- **The closed form.** At every `(3,1)` four-subset of `Sᵖ × S^q` the ratio is
`9 / (2(p-1)²)`, independent of `q`, which is what makes [r400](../../../reviews/REVIEW_r400.md)'s
`q ≤ 200` cutoff irrelevant. -/
def ratio (p : ℚ) : ℚ := 9 / (2 * (p - 1) ^ 2)

/-- The band forces `p ≥ 5`, and the ratio is strictly decreasing there, so the supremum over
the two-factor family is attained at `p = 5`. -/
theorem ratio_antitone {p p' : ℚ} (hp : 5 ≤ p) (hlt : p < p') : ratio p' < ratio p := by
  unfold ratio
  have h1 : (0:ℚ) < (p - 1) ^ 2 := by nlinarith [hp]
  have h2 : (0:ℚ) < (p' - 1) ^ 2 := by nlinarith [hp, hlt]
  rw [div_lt_div_iff₀ (by linarith) (by linarith)]
  nlinarith [hp, hlt]

/-- **The supremum is exactly `9/32`**, the closed form of the screened `0.28125`. -/
theorem ratio_at_five : ratio 5 = 9 / 32 := by unfold ratio; norm_num

theorem ratio_decimal : (9 : ℚ) / 32 = 28125 / 100000 := by norm_num

/-- **No reduction of the four-set clause to `m₄` alone can work.** An `m₄`-only sufficient
condition must imply `m₄ < θ²/3`, because in-band `σ = 0` four-sets exist; and `S⁵ × S⁶⁶`
reaches `sup m₄/θ² = 3/8`. The two are incompatible because `3/8 > 1/3`, a theorem, as the
block says, not a caution. -/
theorem m4_only_impossible : (1 : ℚ) / 3 < 3 / 8 := by norm_num

/-- The margin is `1/24`, so the obstruction is not a boundary case. -/
theorem m4_margin : (3 : ℚ) / 8 - 1 / 3 = 1 / 24 := by norm_num

/-- The `(2,2)` family carrying `σ = 0` is cut out by `q(q-1) + p(p-1) = 4(p-1)(q-1)`. At
`p = q` this is `2p(p-1) = 4(p-1)²`, i.e. `p = 2(p-1)`, so `p = 2`, outside the band, which
is why the family's in-band members are unbalanced. -/
theorem sigma_zero_balanced (p : ℚ) (hp : p ≠ 1) :
    2 * p * (p - 1) = 4 * (p - 1) ^ 2 ↔ p = 2 := by
  constructor
  · intro h
    have hne : p - 1 ≠ 0 := fun hz => hp (by linarith [sub_eq_zero.1 hz])
    have : (p - 1) * (2 * p - 4 * (p - 1)) = 0 := by ring_nf; ring_nf at h; linarith
    rcases mul_eq_zero.1 this with h' | h'
    · exact absurd h' hne
    · linarith
  · intro h; subst h; ring

end HamiltonsCubic.FourSetRatio
