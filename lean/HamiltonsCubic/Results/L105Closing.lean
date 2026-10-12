import Mathlib

/-!
# L105, typed: the two branches and the closing inequality `min ≤ θ₀(n)`

[findings/bounds-relaxations.md](../../../findings/bounds-relaxations.md), Lemma L105: a unit
`θ`-critical point whose spectrum takes two values, `u > 0` with multiplicity `r` and `-w < 0`
with multiplicity `N - r`, has `θ ≤ min{(n-1)w, ((n-2)u² - 2uw - w²)/w} ≤ θ₀(n)`,
`θ₀(n) = √(2(n-1)(n-2))/n`.

* `L105_pi_bound`, `L105_tangent_bound`: each branch from its row identity and `t ≥ 0`.
* `L105_closing`: the two branches give `θ ≤ θ₀(n)`. Tracelessness and unit norm give `uwN = 1`,
  and the tangent branch closes by the identity
  `(n-1)²(n-2)uw³ - nQ² = (n-1)w²·[-((n-2)u - nw)(nu + w)] + nQ((n-1)w² - Q)`,
  `Q = (n-2)u² - 2uw - w²`, both terms nonnegative when `(n-2)u < nw`.

**Not typed**: the two row identities themselves, which come from [L104](../../../findings/bounds-relaxations.md)'s
reduced system at the spectrum; they enter as hypotheses.
-/

namespace HamiltonsCubic.Results

/-- **The `Π`-bound**, from the class-1 row and `t₁₁₂ ≥ 0`. -/
theorem L105_pi_bound (n r N u w θ t112 : ℝ) (hu : 0 < u) (hr : 1 ≤ r) (hNr : r ≤ N)
    (hrow : -(r - 1) * (N - r) * (u + w) ^ 2 * t112 = 2 * u * θ - 2 * (n - 1) * u * w)
    (ht : 0 ≤ t112) : θ ≤ (n - 1) * w := by
  have h1 : 0 ≤ (r - 1) * (N - r) * (u + w) ^ 2 * t112 := by
    have : 0 ≤ (r - 1) * (N - r) := mul_nonneg (by linarith) (by linarith)
    positivity
  have : u * (θ - (n - 1) * w) ≤ 0 := by nlinarith
  by_contra hc
  push_neg at hc
  have : 0 < u * (θ - (n - 1) * w) := mul_pos hu (by linarith)
  linarith

/-- **The tangent bound**, from the class-2 row and `t₂₂₂ ≥ 0`, in the form `θ w ≤ Q`. -/
theorem L105_tangent_bound (n r N u w θ t222 : ℝ) (hcoef : 0 ≤ (N - r - 1) * (N - r - 2))
    (hrow : (N - r - 1) * (N - r - 2) * (u + w) ^ 2 * t222 =
      2 * (n - 2) * u ^ 2 - 4 * u * w - 2 * w ^ 2 - 2 * w * θ)
    (ht : 0 ≤ t222) : θ * w ≤ (n - 2) * u ^ 2 - 2 * u * w - w ^ 2 := by
  have : 0 ≤ (N - r - 1) * (N - r - 2) * (u + w) ^ 2 * t222 := by positivity
  nlinarith

/-- **The closing identity.** -/
theorem L105_identity (n u w : ℝ) :
    (n - 1) ^ 2 * (n - 2) * u * w ^ 3 - n * ((n - 2) * u ^ 2 - 2 * u * w - w ^ 2) ^ 2 =
      (n - 1) * w ^ 2 * (-(((n - 2) * u - n * w) * (n * u + w))) +
        n * ((n - 2) * u ^ 2 - 2 * u * w - w ^ 2) *
          ((n - 1) * w ^ 2 - ((n - 2) * u ^ 2 - 2 * u * w - w ^ 2)) := by
  ring

/-- **L105's conclusion**: the two branches, with `uwN = 1`, give `θ ≤ θ₀(n)`. -/
theorem L105_closing (n u w θ : ℝ) (hn : 3 ≤ n) (hu : 0 < u) (hw : 0 < w)
    (huw : u * w * (n * (n - 1) / 2) = 1) (h1 : θ ≤ (n - 1) * w)
    (h2 : θ * w ≤ (n - 2) * u ^ 2 - 2 * u * w - w ^ 2) :
    θ ≤ Real.sqrt (2 * (n - 1) * (n - 2)) / n := by
  have hnpos : 0 < n := by linarith
  rcases le_or_gt θ 0 with hθ | hθ
  · exact le_trans hθ (div_nonneg (Real.sqrt_nonneg _) hnpos.le)
  rw [le_div_iff₀ hnpos]
  apply Real.le_sqrt_of_sq_le
  -- the target in squared form: (θ n)² ≤ 2(n-1)(n-2), with uw = 2/(n(n-1))
  have huw' : u * w * (n * (n - 1)) = 2 := by linarith
  by_cases hA : n * w ≤ (n - 2) * u
  · -- the Π-branch
    have hθw : θ ^ 2 ≤ (n - 1) ^ 2 * w ^ 2 := by nlinarith
    have hww : (n - 1) ^ 2 * w ^ 2 * n ≤ (n - 1) ^ 2 * (n - 2) * (u * w) := by
      have : 0 ≤ (n - 1) ^ 2 * w := by positivity
      nlinarith
    nlinarith
  · -- the tangent branch
    push_neg at hA
    set Q := (n - 2) * u ^ 2 - 2 * u * w - w ^ 2 with hQ
    have hQpos : 0 < Q := by nlinarith
    have hQle : Q ≤ (n - 1) * w ^ 2 := by
      have : ((n - 2) * u - n * w) * (u + w) ≤ 0 :=
        mul_nonpos_of_nonpos_of_nonneg (by linarith) (by linarith)
      nlinarith
    have hid := L105_identity n u w
    rw [← hQ] at hid
    have hsq : n * Q ^ 2 ≤ (n - 1) ^ 2 * (n - 2) * u * w ^ 3 := by
      have t1 : 0 ≤ (n - 1) * w ^ 2 * (-(((n - 2) * u - n * w) * (n * u + w))) := by
        have : ((n - 2) * u - n * w) * (n * u + w) ≤ 0 :=
          mul_nonpos_of_nonpos_of_nonneg (by linarith) (by positivity)
        have hn1 : 0 ≤ n - 1 := by linarith
        have : 0 ≤ (n - 1) * w ^ 2 := by positivity
        nlinarith
      have t2 : 0 ≤ n * Q * ((n - 1) * w ^ 2 - Q) := by
        have : 0 ≤ (n - 1) * w ^ 2 - Q := by linarith
        positivity
      linarith
    have hθQ : (θ * w) ^ 2 ≤ Q ^ 2 := by
      have : 0 ≤ θ * w := by positivity
      nlinarith
    -- (θ n)² w² n ≤ n² Q² ... assemble: θ² ≤ Q²/w² ≤ (n-1)²(n-2) u w / n
    have key : θ ^ 2 * w ^ 2 * n ≤ (n - 1) ^ 2 * (n - 2) * u * w ^ 3 := by nlinarith
    have key2 : θ ^ 2 * n ≤ (n - 1) ^ 2 * (n - 2) * (u * w) := by
      have hw2 : 0 < w ^ 2 := by positivity
      nlinarith
    nlinarith

end HamiltonsCubic.Results
