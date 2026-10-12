import Mathlib

set_option linter.style.longLine false

/-!
# The sharing quotient at a two-block sphere product, arithmetic half

**The projected pair direction built from two coordinate planes sharing one index inside the
`p`-block splits into a `Weyl_p` piece and an `S²₀(ℝ^p)` piece**, the two summands of Lemma L27's
multiplicity-free decomposition that it can reach. `L_e` is `0` on the first and
`λ_p = (p-2)/(2(p-1))` on the second, so the quotient is `λ_p` times the second piece's share of
the norm.

*That share is read off the Ricci contraction.* With scalar curvature zero, removing the Ricci
part in dimension `p` costs `1/(p-2)` of `c‖Ric‖²` and removing it in dimension `n` costs
`1/(n-2)`, so the `S²₀(ℝ^p)` piece carries `c‖Ric‖²·q/((p-2)(n-2))` against the projected total
`(n-3)/(2(n-2))`, with `c‖Ric‖² = 1/2` in the normalisation where `‖u⊙v‖² = 1/2`.

**This file types that arithmetic and the bound it gives.** The decomposition and the two
eigenvalues are Lemma L27's, stated in prose in `findings/nondegeneracy.md`, and are the
structural half this file assumes rather than proves.
-/

namespace HamiltonsCubic.Results

/-- **THE SHARING QUOTIENT IS `q / (2(p-1)(n-3))`.** `λ_p` times the `S²₀(ℝ^p)` share of the
projected norm, simplified. -/
theorem sharing_quotient_closed_form (p q : ℝ) (hp : 3 ≤ p) (hq : 3 ≤ q) :
    ((p - 2) / (2 * (p - 1))) * ((1 / 2) * q / ((p - 2) * (p + q - 2)))
        / ((p + q - 3) / (2 * (p + q - 2)))
      = q / (2 * (p - 1) * (p + q - 3)) := by
  have h1 : p - 2 ≠ 0 := by linarith
  have h2 : p - 1 ≠ 0 := by linarith
  have h3 : p + q - 2 ≠ 0 := by linarith
  have h4 : p + q - 3 ≠ 0 := by linarith
  field_simp

/-- **THE SHARING QUOTIENT NEVER REACHES THE SECOND-ORDER THRESHOLD `1/2`**, so no pair
direction of this family violates Lemma L24 at a sphere product with `p, q ≥ 3`. -/
theorem sharing_quotient_lt_half (p q : ℝ) (hp : 3 ≤ p) (hq : 3 ≤ q) :
    q / (2 * (p - 1) * (p + q - 3)) < 1 / 2 := by
  have hd : 0 < 2 * (p - 1) * (p + q - 3) := by
    have : 0 < p - 1 := by linarith
    have : 0 < p + q - 3 := by linarith
    positivity
  rw [div_lt_iff₀ hd]
  nlinarith

/-- Non-vacuity: the hypotheses hold at `S⁴ × S⁴`, where the quotient is `2/15`. -/
example : (4 : ℝ) / (2 * (4 - 1) * (4 + 4 - 3)) = 2 / 15 := by norm_num

end HamiltonsCubic.Results
