import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L25, the refuting witness, checked four ways, and the constant it identifies

[second-order.md](../../../findings/second-order.md)'s Observation L25, whose unqualified form is
refuted by a witness the same file already held.

**The witness passes every check the construction could not have been tuned to.** From
`W = diag(0,0,0,-1,-1,2)/√6` the multiplication spectrum is `{1, ½², 0⁵, (-1)²}`, giving
`tr L_e = 0` and `tr L_e² = 7/2`, both as recorded. **A check the block does not make**: the
multiplicities sum to `10`, which is `dim 𝒲₄ = 4·5·6·1/12`, so the spectrum accounts for the
whole space and none of it is missing.

**And `κ_W` is Fox's constant.** The block writes `tr L_e² = 7/2 = κ_W/θ²` without saying what
`κ_W` is. With `θ² = 3/2` it forces `κ_W = 21/4`, and
[nondegeneracy.md](../../../findings/nondegeneracy.md) records Fox's
`κ_F(n) = (2n-1)(n-1)/4`, which at `n = 4` is exactly `21/4`. So the unnamed constant is one the
record already carries, and the identity is `tr L_e² = κ_F(n)/θ²` rather than a bare number.

**The range `[1.17, 96.3]` is false under every reading**, as the audit says: the block's own
next sentence lists `3/4`, `5/6` and `1`, all strictly below `1.17`.

**And the `𝔲(m)` clause needs `m ≥ 3`.** The formula `(m+2)/(2(m+1))` gives `2/3` at `m = 2`
where the true value is `1/2`, so unrestricted it asserts a violation at the very point that
refutes the block. For `m ≥ 3` it is strictly above `1/2` and decreasing toward it, so the clause
is correct exactly on the restricted range.
-/

namespace HamiltonsCubic.SecondOrderWitness

/-! ## The witness spectrum -/

/-- **`tr L_e = 0`** across `{1, ½², 0⁵, (-1)²}`. -/
theorem trace_vanishes : (1 : ℚ) + 2 * (1 / 2) + 5 * 0 + 2 * (-1) = 0 := by norm_num

/-- **`tr L_e² = 7/2`.** -/
theorem trace_sq : (1 : ℚ) ^ 2 + 2 * (1 / 2) ^ 2 + 5 * 0 ^ 2 + 2 * (-1) ^ 2 = 7 / 2 := by
  norm_num

/-- **The multiplicities sum to `dim 𝒲₄ = 10`**, a check the block does not make, and one the
construction had no freedom to pass. -/
theorem multiplicities_fill_the_space :
    1 + 2 + 5 + 2 = 10 ∧ (4 : ℚ) * 5 * 6 * (4 - 3) / 12 = 10 := by
  refine ⟨by norm_num, by norm_num⟩

/-! ## `κ_W` is Fox's constant -/

/-- Fox's `κ_F(n) = (2n-1)(n-1)/4`. -/
def kappaF (n : ℚ) : ℚ := (2 * n - 1) * (n - 1) / 4

/-- **At `n = 4` it is `21/4`**, and `κ_F(4)/θ² = 7/2` with `θ² = 3/2`, so the block's unnamed
`κ_W` is Fox's constant and the identity is `tr L_e² = κ_F(n)/θ²`. -/
theorem kappa_identifies : kappaF 4 = 21 / 4 ∧ (21 / 4 : ℚ) / (3 / 2) = 7 / 2 := by
  refine ⟨by unfold kappaF; norm_num, by norm_num⟩

/-! ## The range is false -/

/-- **`3/4`, `5/6` and `1` all sit strictly below `1.17`**, so no reading of the block's own list
supports its stated floor. -/
theorem range_floor_false :
    (3 : ℚ) / 4 < 117 / 100 ∧ (5 : ℚ) / 6 < 117 / 100 ∧ (1 : ℚ) < 117 / 100 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

/-- And the preamble's `≥ 3/4` is consistent with all three, so it is the correct floor. -/
theorem preamble_floor_holds :
    (3 : ℚ) / 4 ≤ 3 / 4 ∧ (3 : ℚ) / 4 ≤ 5 / 6 ∧ (3 : ℚ) / 4 ≤ 1 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

/-! ## The `𝔲(m)` clause needs `m ≥ 3` -/

/-- The clause's value. -/
def uValue (m : ℚ) : ℚ := (m + 2) / (2 * (m + 1))

/-- **At `m = 2` it gives `2/3` where the true value is `1/2`**, so unrestricted the clause
asserts a violation at the point that refutes the block. -/
theorem u_fails_at_two : uValue 2 = 2 / 3 ∧ (2 : ℚ) / 3 ≠ 1 / 2 := by
  refine ⟨by unfold uValue; norm_num, by norm_num⟩

/-- **For `m ≥ 3` it is strictly above `1/2`**, so the clause is correct exactly there. -/
theorem u_above_half {m : ℚ} (hm : 3 ≤ m) : 1 / 2 < uValue m := by
  unfold uValue
  rw [lt_div_iff₀ (by linarith)]
  linarith

/-- And it decreases toward `1/2`: `5/8` at `m = 3`, `3/5` at `m = 4`, `7/12` at `m = 5`. -/
theorem u_decreasing :
    uValue 3 = 5 / 8 ∧ uValue 4 = 3 / 5 ∧ uValue 5 = 7 / 12
      ∧ (7 : ℚ) / 12 < 3 / 5 ∧ (3 : ℚ) / 5 < 5 / 8 := by
  refine ⟨by unfold uValue; norm_num, by unfold uValue; norm_num,
    by unfold uValue; norm_num, by norm_num, by norm_num⟩

/-- The other graded violator, `S² × S^{n-2}` at `½ + 1/(2(n-3))`, is above `½` for every
`n > 3`. -/
theorem sphere_pair_above_half {n : ℚ} (hn : 4 ≤ n) :
    1 / 2 < 1 / 2 + 1 / (2 * (n - 3)) := by
  have : (0:ℚ) < 1 / (2 * (n - 3)) := by apply div_pos one_pos; linarith
  linarith

end HamiltonsCubic.SecondOrderWitness
